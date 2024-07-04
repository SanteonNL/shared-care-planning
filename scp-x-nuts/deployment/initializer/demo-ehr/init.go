package demo_ehr

import (
	"encoding/json"
	"fmt"
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/nuts"
	"os"
	"strconv"
)

const DEMOEHR_CUSTOMERS_FILE_ENV_KEY = "DEMOEHR_CUSTOMERS_FILE"

func Initialize(organizations []nuts.Organization) {
	customersFile := os.Getenv(DEMOEHR_CUSTOMERS_FILE_ENV_KEY)
	if customersFile == "" {
		panic(fmt.Sprintf("missing/invalid environment variable: %s", DEMOEHR_CUSTOMERS_FILE_ENV_KEY))
	}
	customers, err := readCustomers(customersFile)
	if err != nil {
		panic(fmt.Sprintf("error reading customers file: %v", err))
	}
	for _, organization := range organizations {
		exists := false
		for _, customer := range customers {
			if customer["did"] == organization.DID {
				exists = true
				break
			}
		}
		if !exists {
			// random number between 100 and 1000
			var customerID string
			var ok bool
			for i := 10; i < 10000; i++ {
				customerID = strconv.Itoa(i)
				if _, exists := customers[customerID]; exists {
					continue
				}
				ok = true
			}
			if !ok {
				panic("no available customer ID")
			}
			customers[customerID] = map[string]interface{}{
				"active": true,
				"city":   organization.City,
				"did":    organization.DID,
				"domain": "",
				"id":     customerID,
				"name":   organization.Name,
				"ura":    organization.URACode,
			}
		}
	}
	if err := writeCustomers(customersFile, customers); err != nil {
		panic(fmt.Sprintf("error writing customers file: %v", err))
	}
}

func readCustomers(customersFile string) (map[string]map[string]interface{}, error) {
	data, err := os.ReadFile(customersFile)
	if err != nil {

	}
	customers := make(map[string]map[string]interface{}, 0)
	if err := json.Unmarshal(data, &customers); err != nil {
		return nil, err
	}
	return customers, nil
}

func writeCustomers(customersFile string, customers map[string]map[string]interface{}) error {
	data, err := json.Marshal(customers)
	if err != nil {
		return err
	}
	return os.WriteFile(customersFile, data, 0644)
}
