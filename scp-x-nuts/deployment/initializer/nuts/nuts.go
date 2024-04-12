package nuts

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/brianvoe/gofakeit/v7"
	"io"
	"net/http"
	"net/url"
	"os"
	"regexp"
	"strconv"
	"strings"
	"time"
)

const NUTSNODE_INTERNAL_API_ENV_KEY = "NUTSNODE_INTERNAL_BASEURL"

type Organization struct {
	DID     string
	Name    string
	URACode string
	City    string
}

func Initialize() []Organization {
	baseURL, _ := url.Parse(os.Getenv(NUTSNODE_INTERNAL_API_ENV_KEY))
	if baseURL == nil || baseURL.Host == "" {
		panic(fmt.Sprintf("missing/invalid environment variable: %s", NUTSNODE_INTERNAL_API_ENV_KEY))
	}
	initialized, err := isInitialized(baseURL)
	if err != nil {
		panic(fmt.Sprintf("error checking if Nuts node is initialized: %v", err))
	}
	if initialized {
		println("Nuts node already initialized")
		//return
	}
	println("Initializing Nuts node")
	organizations := make([]Organization, 0)
	if org, err := createOrganization(baseURL); err != nil {
		panic(fmt.Sprintf("error creating organization: %v", err))
	} else {
		organizations = append(organizations, *org)
	}
	if org, err := createOrganization(baseURL); err != nil {
		panic(fmt.Sprintf("error creating organization: %v", err))
	} else {
		organizations = append(organizations, *org)
	}
	println("Nuts node initialized")
	return organizations
}

func isInitialized(baseURL *url.URL) (bool, error) {
	// See if there are any DIDs in the Nuts node. If so, the Nuts node is initialized.
	httpResponse, err := http.Get(baseURL.JoinPath("/internal/vdr/v2/did").String())
	if err != nil {
		return false, err
	}
	if !httpSuccessStatus(httpResponse.StatusCode) {
		return false, fmt.Errorf("non-OK status received for getting DIDs: %s", httpResponse.Status)
	}
	data, _ := io.ReadAll(httpResponse.Body)
	var dids []interface{}
	if err := json.Unmarshal(data, &dids); err != nil {
		return false, err
	}
	return len(dids) > 0, nil
}

func createOrganization(baseURL *url.URL) (*Organization, error) {
	// Create a new care organization in the Nuts node:
	// 1. Generate a fake name, locality and URA-code
	// 2. Create a DID
	// 3. Issue and load a NutsOrganizationCredential
	// 4. Issue and load a URACredential
	// 5. Activate the HomeMonitoring Discovery Service for the DID
	organizationName := gofakeit.FirstName() + " Care"
	organizationCity := gofakeit.City()
	organizationURACode := strconv.Itoa(gofakeit.Number(100000, 999999))
	println("Creating organization...")
	println("-----------------------------")
	println("  Name:", organizationName)
	println("  City:", organizationCity)
	println("  URA code:", organizationURACode)

	// Create DID. Use sanitized organizationName as tenant (only alphanumeric) through a regex.
	didTenant := strings.ToLower(regexp.MustCompile(`[^a-zA-Z0-9]+`).ReplaceAllString(organizationName, ""))
	organizationDID, err := createDID(baseURL, didTenant)
	if err != nil {
		return nil, fmt.Errorf("error creating DID for organization: %w", err)
	}
	println("  DID:", organizationDID)

	// Issue and load organization credential
	organizationCredential := createBaseCredential(organizationDID, organizationDID, "NutsOrganizationCredential")
	organizationCredential["credentialSubject"].(map[string]interface{})["organization"] = map[string]interface{}{
		"name": organizationName,
		"city": organizationCity,
	}
	if err := issueAndLoadCredential(baseURL, organizationDID, organizationCredential); err != nil {
		return nil, fmt.Errorf("error issuing/loading NutsOrganizationCredential: %w", err)
	}
	// Issue and load URA credential
	organizationURACredential := createBaseCredential(organizationDID, organizationDID, "URACredential")
	organizationURACredential["@context"] = "https://nuts-services.nl/jsonld/credentials/experimental"
	organizationURACredential["credentialSubject"].(map[string]interface{})["ura"] = organizationURACode
	if err := issueAndLoadCredential(baseURL, organizationDID, organizationURACredential); err != nil {
		return nil, fmt.Errorf("error issuing/loading URACredential: %w", err)
	}
	// Activate HomeMonitoring Discovery Service
	if err = activateDiscoveryService(baseURL, organizationDID, "dev:HomeMonitoringURA2024"); err != nil {
		return nil, fmt.Errorf("error activating HomeMonitoring Discovery Service: %w", err)
	}
	println("-----------------------------")
	return &Organization{
		DID:     organizationDID,
		Name:    organizationName,
		City:    organizationCity,
		URACode: organizationURACode,
	}, nil
}

// createDID creates a new did:web DID in the Nuts node, with the given tenant. It creates the DID.
func createDID(baseURL *url.URL, tenant string) (string, error) {
	// Create a new DID in the Nuts node
	body, _ := json.Marshal(map[string]interface{}{
		"tenant": tenant,
	})
	httpResponse, err := http.Post(baseURL.JoinPath("/internal/vdr/v2/did").String(), "application/json", bytes.NewReader(body))
	if err != nil {
		return "", err
	}
	if !httpSuccessStatus(httpResponse.StatusCode) {
		return "", fmt.Errorf("non-OK status received for creating DID: %s", httpResponse.Status)
	}
	data, _ := io.ReadAll(httpResponse.Body)
	didDocument := make(map[string]interface{})
	if err := json.Unmarshal(data, &didDocument); err != nil {
		return "", err
	}
	return didDocument["id"].(string), nil
}

func issueAndLoadCredential(baseURL *url.URL, holderDID string, credential map[string]interface{}) error {
	// Issue and load a new VC in the Nuts node
	issuedCredential, err := issueCredential(baseURL, credential)
	if err != nil {
		return fmt.Errorf("error issuing VC: %w", err)
	}
	if err := loadCredential(baseURL, holderDID, issuedCredential); err != nil {
		return fmt.Errorf("error loading VC: %w", err)
	}
	return nil
}

func loadCredential(baseURL *url.URL, holderDID string, credential map[string]interface{}) error {
	// Load a new VC in the Nuts node
	body, _ := json.Marshal(credential)
	httpResponse, err := http.Post(baseURL.JoinPath("/internal/vcr/v2/holder", holderDID, "vc").String(), "application/json", bytes.NewReader(body))
	if err != nil {
		return err
	}
	if !httpSuccessStatus(httpResponse.StatusCode) {
		return fmt.Errorf("non-OK status received for loading VC: %s", httpResponse.Status)
	}
	return nil
}

func issueCredential(baseURL *url.URL, credential map[string]interface{}) (map[string]interface{}, error) {
	// Issue and load a new VC in the Nuts node
	body, _ := json.Marshal(credential)
	httpResponse, err := http.Post(baseURL.JoinPath("/internal/vcr/v2/issuer/vc").String(), "application/json", bytes.NewReader(body))
	if err != nil {
		return nil, err
	}
	if !httpSuccessStatus(httpResponse.StatusCode) {
		return nil, fmt.Errorf("non-OK status received for issuing VC: %s", httpResponse.Status)
	}
	result := make(map[string]interface{})
	data, _ := io.ReadAll(httpResponse.Body)
	if err := json.Unmarshal(data, &result); err != nil {
		return nil, fmt.Errorf("error unmarshalling VC result: %w", err)
	}
	return result, nil
}

func createBaseCredential(issuerDID string, subjectDID string, credentialType string) map[string]interface{} {
	expirationDate := time.Now().AddDate(1, 0, 0)
	return map[string]interface{}{
		"issuer":         issuerDID,
		"subject":        subjectDID,
		"type":           credentialType,
		"expirationDate": expirationDate,
		"credentialSubject": map[string]interface{}{
			"id": subjectDID,
		},
	}
}

func activateDiscoveryService(baseURL *url.URL, subjectDID string, discoveryServiceID string) error {
	// Activate a discovery service for the given DID
	body, _ := json.Marshal(map[string]interface{}{
		"subject": subjectDID,
		"service": discoveryServiceID,
	})
	httpResponse, err := http.Post(baseURL.JoinPath("/internal/discovery/v1", discoveryServiceID, subjectDID).String(), "application/json", bytes.NewReader(body))
	if err != nil {
		return err
	}
	if !httpSuccessStatus(httpResponse.StatusCode) {
		return fmt.Errorf("non-OK status received for activating discovery service: %s", httpResponse.Status)
	}
	data, _ := io.ReadAll(httpResponse.Body)
	if httpResponse.StatusCode != http.StatusOK {
		return fmt.Errorf("failed to activate discovery service: %s", string(data))
	}
	return nil
}

func httpSuccessStatus(status int) bool {
	return status >= 200 && status < 300
}
