package main

import (
	"bytes"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strconv"
	"time"
)

const FHIR_BASEURL_ENVKEY = "HAPI_FHIR_BASEURL"

func main() {
	fhirBaseURL, _ := url.Parse(os.Getenv(FHIR_BASEURL_ENVKEY))
	if fhirBaseURL == nil || fhirBaseURL.Host == "" {
		panic(fmt.Sprintf("missing/invalid environment variable: %s", FHIR_BASEURL_ENVKEY))
	}
	if err := waitForFHIRServerAvailable(fhirBaseURL, 5*time.Minute); err != nil {
		panic(fmt.Sprintf("FHIR server not available: %v", err))
	}
	if err := createTenant(fhirBaseURL, 1, "CarePlanService"); err != nil {
		panic(fmt.Sprintf("Couldn't initialize tenant: %v", err))
	} else {
		println("Tenant created successfully")
	}
}

func createTenant(fhirBaseURL *url.URL, tenantID int, tenantName string) error {
	data := bytes.NewReader([]byte(`{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "id",
      "valueInteger": ` + strconv.Itoa(tenantID) + `
    },
    {
      "name": "name",
      "valueCode": "` + tenantName + `"
    }
  ]
}
`))
	response, err := http.Post(fhirBaseURL.JoinPath("DEFAULT", "$partition-management-create-partition").String(), "application/json", data)
	if err != nil {
		return err
	}
	defer response.Body.Close()
	if response.StatusCode == http.StatusOK {
		return nil
	}
	return fmt.Errorf("Non-OK status received for creating tenant '%s': %s", tenantName, response.Status)
}

func waitForFHIRServerAvailable(baseURL *url.URL, timeout time.Duration) error {
	ticker := time.NewTicker(time.Second)
	defer ticker.Stop()
	timeoutTimer := time.NewTimer(timeout)
	defer timeoutTimer.Stop()
	println(fmt.Sprintf("Waiting for FHIR server to become available at %s (timeout: %s)", baseURL.String(), timeout))
	for {
		select {
		case <-ticker.C:
			response, err := http.Get(baseURL.JoinPath("DEFAULT", "Task").String())
			if err == nil && response.StatusCode == http.StatusOK {
				return nil
			}
			println("FHIR server not available yet")
		case <-timeoutTimer.C:
			return fmt.Errorf("timeout waiting for FHIR server")
		}
	}
}
