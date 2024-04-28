package main

import (
	"context"
	"errors"
	"fmt"
	"github.com/SanteonNL/shared-care-planning/epic-fhir-apigateway/smart_on_fhir"
	"github.com/lestrrat-go/jwx/v2/jwk"
	"golang.org/x/oauth2"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
)

func main() {
	var (
		clientID      string
		listenAddress string
		fhirBaseURL   string
		tokenEndpoint string
		jwkFile       string
		jwkKeyID      string
	)
	envVariables := map[string]*string{
		"EPIC_ADAPTER_OAUTH_TOKEN_ENDPOINT": &tokenEndpoint,
		"EPIC_ADAPTER_OAUTH_CLIENT_ID":      &clientID,
		"EPIC_ADAPTER_FHIR_BASEURL":         &fhirBaseURL,
		"EPIC_ADAPTER_LISTEN_ADDRESS":       &listenAddress,
		"EPIC_ADAPTER_JWK_FILE":             &jwkFile,
		"EPIC_ADAPTER_JWK_KEYID":            &jwkKeyID,
	}
	for name, ptr := range envVariables {
		value := os.Getenv(name)
		if value == "" {
			panic(fmt.Sprintf("Missing environment variable: %s", name))
		}
		*ptr = value
	}
	parsedFHIRBaseURL, err := url.Parse(fhirBaseURL)
	if err != nil {
		panic(err)
	}

	log.Println("Listening on", listenAddress)
	log.Println("Proxying to", fhirBaseURL)
	log.Println("OAuth2 client ID", clientID)
	signingKey, err := loadJWK(jwkFile, jwkKeyID)
	if err != nil {
		panic(err)
	}

	ctx := context.Background()
	fhirHTTPClient := oauth2.NewClient(ctx, oauth2.ReuseTokenSource(nil, smart_on_fhir.BackendTokenSource{
		OAuth2ASTokenEndpoint: tokenEndpoint,
		ClientID:              clientID,
		SigningKey:            signingKey,
	}))
	reverseProxy := httputil.NewSingleHostReverseProxy(parsedFHIRBaseURL)
	reverseProxy.Transport = LoggingTransportDecorator{
		RoundTripper: fhirHTTPClient.Transport,
	}

	err = http.ListenAndServe(listenAddress, reverseProxy)
	if !errors.Is(err, http.ErrServerClosed) {
		panic(err)
	}
}

func loadJWK(jwkFile string, keyID string) (jwk.Key, error) {
	data, err := os.ReadFile(jwkFile)
	if err != nil {
		return nil, fmt.Errorf("unable to read JWK file %s: %w", jwkFile, err)
	}
	jwkSet, err := jwk.Parse(data)
	if err != nil {
		return nil, fmt.Errorf("invalid JWK file %s: %w", jwkFile, err)
	}
	result, exists := jwkSet.LookupKeyID(keyID)
	if !exists {
		return nil, fmt.Errorf("key with ID %s does not exist in JWK file", keyID)
	}
	return result, nil
}

type LoggingTransportDecorator struct {
	RoundTripper http.RoundTripper
}

func (d LoggingTransportDecorator) RoundTrip(request *http.Request) (*http.Response, error) {
	response, err := d.RoundTripper.RoundTrip(request)
	// Query might contain PII (social security number) in case of FHIR Search, so do not log it.
	requestURLWithoutQuery := *request.URL
	requestURLWithoutQuery.RawQuery = ""
	if err != nil {
		log.Println("ERR", requestURLWithoutQuery.String())
	} else {
		log.Println(response.StatusCode, requestURLWithoutQuery.String())
	}
	return response, err
}
