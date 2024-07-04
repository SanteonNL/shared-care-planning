package main

import (
	"context"
	"fmt"
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/fhirclient"
	"github.com/samply/golang-fhir-models/fhir-models/fhir"
	"github.com/sirupsen/logrus"
	"net/http"
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

	apiHandler := api{
		fhirClient: fhirClient,
	}
	mux := http.NewServeMux()
	// FHIR Store posts to /notify/{ResourceType}/{ResourceID}
	mux.HandleFunc("POST /notify/{resourceType}/{resourceID}", apiHandler.handleSubscriptionNotify)
	mux.HandleFunc("PUT /notify/{resourceType}/{resourceID}", apiHandler.handleSubscriptionNotify)
	mux.HandleFunc("/*", handleNotFound)
	if err := http.ListenAndServe(listenAddress, mux); err != nil {
		panic(err)
	}
}

func fhirSubscribe(fhirClient fhirclient.Client, serviceBaseURL *url.URL) error {
	if isSubscribed, err := fhirIsSubscribed(fhirClient); err != nil {
		return fmt.Errorf("failed to check FHIR subscription status: %v", err)
	} else if isSubscribed {
		return nil
	}
	logrus.Info("Subscribing CarePlan changes on FHIR server")
	var createdSubscription fhir.Subscription
	return fhirClient.Create(context.Background(), fhir.Subscription{
		Criteria: "CarePlan?",
		Channel: fhir.SubscriptionChannel{
			Type:     fhir.SubscriptionChannelTypeRestHook,
			Endpoint: stringP(serviceBaseURL.JoinPath("notify").String()),
			Payload:  stringP("application/fhir+json"),
		},
	}, &createdSubscription)
}

func fhirIsSubscribed(fhirClient fhirclient.Client) (bool, error) {
	var subscriptions fhir.Bundle
	if err := fhirClient.ReadOne(context.Background(), "/Subscription", &subscriptions); err != nil {
		return false, err
	}
	return len(subscriptions.Entry) > 0, nil
}

func stringP(value string) *string {
	return &value
}
