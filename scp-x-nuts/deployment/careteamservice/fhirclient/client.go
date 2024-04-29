package fhirclient

import (
	"context"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"github.com/go-resty/resty/v2"
	"github.com/sirupsen/logrus"
	"github.com/tidwall/gjson"
	"net/url"
	"path"
)

func NewClient(baseURL string) Client {
	client := &RESTClient{
		restClient: resty.New().SetHeader("Content-Type", "application/json"),
		url:        baseURL,
		//tlsConfig:  &tls.Config{InsecureSkipVerify: true},
	}
	return client
}

type Client interface {
	Create(ctx context.Context, resource interface{}, result interface{}) error
	Update(ctx context.Context, resource interface{}) error
	ReadMultiple(ctx context.Context, path string, params map[string]string, results interface{}) error
	ReadOne(ctx context.Context, path string, result interface{}) error
	BuildRequestURI(fhirResourcePath string) *url.URL
}

type RESTClient struct {
	restClient *resty.Client
	url        string
	tlsConfig  *tls.Config
}

func (h RESTClient) Create(ctx context.Context, resource interface{}, result interface{}) error {
	resourcePath, err := resolveResourcePathWithoutID(resource)
	if err != nil {
		return fmt.Errorf("unable to determine resource path: %w", err)
	}
	requestURI := h.BuildRequestURI(resourcePath)
	resp, err := h.restClient.R().SetBody(resource).SetContext(ctx).Post(requestURI.String())
	if err != nil {
		return fmt.Errorf("unable to write FHIR resource (path=%s): %w", requestURI, err)
	}
	if !resp.IsSuccess() {
		logrus.Warnf("FHIR server replied: %s", resp.String())
		return fmt.Errorf("unable to write FHIR resource (path=%s,http-status=%d): %s", requestURI, resp.StatusCode(), string(resp.Body()))
	}
	return json.Unmarshal(resp.Body(), result)
}

func (h RESTClient) Update(ctx context.Context, resource interface{}) error {
	resourcePath, err := resolveResourcePathWithID(resource)
	if err != nil {
		return fmt.Errorf("unable to determine resource path: %w", err)
	}
	requestURI := h.BuildRequestURI(resourcePath)
	resp, err := h.restClient.R().SetBody(resource).SetContext(ctx).Put(requestURI.String())
	if err != nil {
		return fmt.Errorf("unable to write FHIR resource (path=%s): %w", requestURI, err)
	}
	if !resp.IsSuccess() {
		logrus.Warnf("FHIR server replied: %s", resp.String())
		return fmt.Errorf("unable to write FHIR resource (path=%s,http-status=%d): %s", requestURI, resp.StatusCode(), string(resp.Body()))
	}
	return nil
}

func (h RESTClient) ReadMultiple(ctx context.Context, path string, params map[string]string, results interface{}) error {
	raw, err := h.getResource(ctx, path, params)
	if err != nil {
		return err
	}
	resourcesJSON := raw.Get("entry.#.resource").String()
	if resourcesJSON == "" {
		resourcesJSON = "[]"
	}
	err = json.Unmarshal([]byte(resourcesJSON), results)
	if err != nil {
		logrus.Warnf("FHIR server replied: %s", raw.String())
		return fmt.Errorf("unable to unmarshal FHIR result (path=%s,target-type=%T): %w", path, results, err)
	}
	return nil
}

func (h RESTClient) ReadOne(ctx context.Context, path string, result interface{}) error {
	raw, err := h.getResource(ctx, path, nil)
	if err != nil {
		return err
	}
	err = json.Unmarshal([]byte(raw.String()), &result)
	if err != nil {
		logrus.Warnf("FHIR server replied: %s", raw.String())
		return fmt.Errorf("unable to unmarshal FHIR result (path=%s,target-type=%T): %w", path, result, err)
	}
	return nil
}

func (h RESTClient) getResource(ctx context.Context, path string, params map[string]string) (gjson.Result, error) {
	requestURL := h.BuildRequestURI(path)
	logrus.Debugf("Performing FHIR request with url: %s", requestURL)
	resp, err := h.restClient.R().SetQueryParams(params).SetContext(ctx).SetHeader("Cache-Control", "no-cache").Get(requestURL.String())
	if err != nil {
		return gjson.Result{}, err
	}

	if !resp.IsSuccess() {
		logrus.Warnf("FHIR server replied: %s", resp.String())
		return gjson.Result{}, fmt.Errorf("unable to read FHIR resource (path=%s,http-status=%d)", path, resp.StatusCode())
	}

	body := resp.Body()
	logrus.Debugf("FHIR response: %s", body)
	return gjson.ParseBytes(body), nil
}

func (h RESTClient) BuildRequestURI(fhirResourcePath string) *url.URL {
	return buildRequestURI(h.url, fhirResourcePath)
}

func resolveResourcePathWithoutID(resource interface{}) (string, error) {
	data, _ := json.Marshal(resource)
	js := gjson.ParseBytes(data)
	resourceType := js.Get("resourceType").String()
	if resourceType == "" {
		return "", fmt.Errorf("unable to determine resource type of %T", resource)
	}
	return path.Join(resourceType, "/"), nil
}
func resolveResourcePathWithID(resource interface{}) (string, error) {
	data, _ := json.Marshal(resource)
	js := gjson.ParseBytes(data)
	resourceType := js.Get("resourceType").String()
	if resourceType == "" {
		return "", fmt.Errorf("unable to determine resource type of %T", resource)
	}
	resourceID := js.Get("id").String()
	if resourceID == "" {
		return "", fmt.Errorf("unable to determine resource ID of %T", resource)
	}
	return resourceType + "/" + resourceID, nil
}

func buildRequestURI(baseURL string, resourcePath string) *url.URL {
	parsedBaseURL, _ := url.Parse(baseURL)
	parsedBaseURL, _ = parsedBaseURL.Parse(path.Join("/", parsedBaseURL.Path, resourcePath))
	return parsedBaseURL
}
