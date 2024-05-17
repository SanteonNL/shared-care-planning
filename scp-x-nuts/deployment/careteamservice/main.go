package main

import (
	"context"
	"fmt"
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/fhirclient"
	fhir "github.com/samply/golang-fhir-models/fhir-models/fhir"
	"github.com/sirupsen/logrus"
	"net/url"
	"os"
)

const FHIR_BASEURL_ENVKEY = "FHIR_BASEURL"
const CARETEAMSERVICE_BASEURL_ENVKEY = "CARETEAMSERVICE_BASEURL"
const LISTEN_ADDR_ENVKEY = "LISTEN_ADDR"

func main() {
	listenAddress := os.Getenv(LISTEN_ADDR_ENVKEY)
	if listenAddress == "" {
		listenAddress = ":8080"
	}
	logrus.Infof("Listening on (override with %s): %s", LISTEN_ADDR_ENVKEY, listenAddress)

	fhirBaseURL := os.Getenv(FHIR_BASEURL_ENVKEY)
	if fhirBaseURL == "" {
		panic(fmt.Sprintf("missing environment variable: %s", FHIR_BASEURL_ENVKEY))
	}
	careTeamServiceBaseURL, _ := url.Parse(os.Getenv(CARETEAMSERVICE_BASEURL_ENVKEY))
	if careTeamServiceBaseURL == nil || careTeamServiceBaseURL.String() == "" {
		panic(fmt.Sprintf("missing/invalid environment variable: %s", CARETEAMSERVICE_BASEURL_ENVKEY))
	}

	fhirClient := fhirclient.NewClient(fhirBaseURL)
	if err := fhirSubscribe(fhirClient, careTeamServiceBaseURL); err != nil {
		panic(fmt.Sprintf("failed to initialize FHIR subscription: %v", err))
	}

	//err := http.ListenAndServe(listenAddress, http.HandlerFunc(func(writer http.ResponseWriter, request *http.Request) {
	//	switch request.Method {
	//	case http.MethodGet:
	//		writer.Header().Set("Content-Type", "application/json")
	//		lock.Lock()
	//		defer lock.Unlock()
	//		writer.WriteHeader(http.StatusOK)
	//		_ = json.NewEncoder(writer).Encode(resources)
	//	case http.MethodPost:
	//		var resourceURLs []string
	//		if err := readJSON(request.Body, &resourceURLs); err != nil {
	//			writer.WriteHeader(http.StatusBadRequest)
	//			_, _ = writer.Write([]byte(fmt.Sprintf("expected JSON []string: %w", err.Error())))
	//			return
	//		}
	//		party := strings.TrimLeft(request.URL.RawPath, "/")
	//		if party == "" {
	//			writer.WriteHeader(http.StatusBadRequest)
	//			_, _ = writer.Write([]byte("invalid party in URL"))
	//		}
	//		for _, resourceURL := range resourceURLs {
	//			resources[party] = append(resources[party], resourceURL)
	//		}
	//		log.Println(fmt.Sprintf("authorized resources for %s: %v", party, resourceURLs))
	//		writer.WriteHeader(http.StatusCreated)
	//	}
	//}))
	//if err != nil {
	//	panic(err)
	//}
}

func fhirSubscribe(fhirClient fhirclient.Client, serviceBaseURL *url.URL) error {
	return fhirClient.CreateOrUpdate(context.Background(), fhir.Subscription{
		Criteria: "CarePlan",
		Channel: fhir.SubscriptionChannel{
			Type:     fhir.SubscriptionChannelTypeRestHook,
			Endpoint: stringP(serviceBaseURL.JoinPath("notify").String()),
			Payload:  stringP("application/json"),
		},
	})
}

func stringP(value string) *string {
	return &value
}
