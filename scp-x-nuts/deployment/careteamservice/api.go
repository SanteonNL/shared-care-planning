package main

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/fhirclient"
	"github.com/google/uuid"
	"github.com/samply/golang-fhir-models/fhir-models/fhir"
	"github.com/sirupsen/logrus"
	"io"
	"net/http"
)

const uraNamingSystem = "http://fhir.nl/fhir/NamingSystem/ura"

type api struct {
	fhirClient fhirclient.Client
}

func (a api) handleSubscriptionNotify(response http.ResponseWriter, request *http.Request) {
	defer request.Body.Close()
	resourceType := request.PathValue("resourceType")
	resourceID := request.PathValue("resourceID")
	logrus.Infof("Received notification for %s/%s", resourceType, resourceID)
	if resourceType != "CarePlan" {
		// Nothing to do
		logrus.Debugf("Ignoring notification for %s/%s", resourceType, resourceID)
		response.WriteHeader(http.StatusOK)
		return
	}
	data, err := io.ReadAll(request.Body)
	if err != nil {
		logrus.Warnf("Failed to read request body: %v", err)
		response.WriteHeader(http.StatusInternalServerError)
	}
	var carePlan fhir.CarePlan
	if err := json.Unmarshal(data, &carePlan); err != nil {
		logrus.Warnf("Failed to unmarshal CarePlan: %v", err)
		response.WriteHeader(http.StatusInternalServerError)
	}
	if err := a.updateCareTeam(carePlan); err != nil {
		logrus.Warnf("Failed to update CareTeam: %v", err)
		response.WriteHeader(http.StatusInternalServerError)
	}
	logrus.Infof("Updated CareTeam for CarePlan %s", *carePlan.Id)
	response.WriteHeader(http.StatusOK)
}

// updateCareTeam updates the CareTeam based on the CarePlan.
// It looks at CarePlan.careTeam for the CareTeam to update.
// The CareTeam is derived from the CarePlan.activity entries.
// If there is no CareTeam associated with the CarePlan, it creates one.
// It writes the updated CareTeam back to the FHIR server in a Bundle transaction.
func (a api) updateCareTeam(carePlan fhir.CarePlan) error {
	logrus.Infof("Updating CareTeam for CarePlan %s", *carePlan.Id)
	var careTeam fhir.CareTeam
	// Build up intended CareTeam given CarePlan.activity(Task).owner
	careTeamOrganizationRefs := make(map[string]fhir.Reference, 0)
	for i, activity := range carePlan.Activity {
		if activity.Reference == nil {
			logrus.Warnf("CarePlan.activity[%d] has no reference", i)
			continue
		}
		if activity.Reference.Reference == nil {
			logrus.Warnf("CarePlan.activity[%d].reference has no reference", i)
			continue
		}
		// Fetch the Task
		var task fhir.Task
		taskID := *activity.Reference.Reference
		if err := a.fhirClient.ReadOne(context.Background(), taskID, &task); err != nil {
			return fmt.Errorf("failed to read Task %s: %v", taskID, err)
		}
		// Add to organizationMap. Involved organizations are Task.owner and Task.requestor
		if task.Owner != nil {
			if task.Owner == nil {
				logrus.Debugf("Task.owner is nil (id=%s)", taskID)
			} else {
				org, err := organizationIdentifier(*task.Owner)
				if err != nil {
					return err
				}
				careTeamOrganizationRefs[org] = *task.Owner
			}
			if task.Requester == nil {
				logrus.Debugf("Task.requestor is nil (id=%s)", taskID)
			} else {
				org, err := organizationIdentifier(*task.Requester)
				if err != nil {
					return err
				}
				careTeamOrganizationRefs[org] = *task.Requester
			}
		}
	}
	// Replace CareTeam.participant (onBehalfOf references organizations)
	careTeam.Participant = make([]fhir.CareTeamParticipant, 0)
	for _, reference := range careTeamOrganizationRefs {
		careTeam.Participant = append(careTeam.Participant, fhir.CareTeamParticipant{
			OnBehalfOf: &reference,
		})
	}
	// New or existing CareTeam?
	if len(carePlan.CareTeam) == 0 {
		// Create a new CareTeam
		logrus.Infof("CarePlan/%s does not have a CareTeam yet, will be created", *carePlan.Id)
		careTeam.Id = stringP(uuid.New().String())
		// TODO: Do this via a Bundle transaction with PATCH on CarePlan
		if err := a.fhirClient.Create(context.Background(), careTeam, &careTeam); err != nil {
			return fmt.Errorf("failed to create CareTeam: %w", err)
		}
		carePlan.CareTeam = []fhir.Reference{
			{
				Type:      stringP("CareTeam"),
				Reference: stringP("CareTeam/" + *careTeam.Id),
			},
		}
		if err := a.fhirClient.Update(context.Background(), carePlan); err != nil {
			return fmt.Errorf("failed to update CarePlan: %w", err)
		}
	} else if len(carePlan.CareTeam) == 1 {
		// Existing, update participants
		logrus.Infof("CarePlan/%s has a CareTeam, participants will be updated", *carePlan.Id)
		var existingCareTeam fhir.CareTeam
		careTeamID := *carePlan.CareTeam[0].Reference
		if err := a.fhirClient.ReadOne(context.Background(), careTeamID, &existingCareTeam); err != nil {
			return fmt.Errorf("failed to read CareTeam/%s: %w", careTeamID, err)
		}
		participants := careTeam.Participant
		careTeam = existingCareTeam
		careTeam.Participant = participants
		if err := a.fhirClient.Update(context.Background(), careTeam); err != nil {
			return fmt.Errorf("failed to update CareTeam/%s: %w", careTeamID, err)
		}
	} else {
		// Sanity check: can't handle multiple CareTeams (don't know which one).
		return fmt.Errorf("CarePlan/%s.careTeam contains multiple (%d) entries", *carePlan.Id, len(carePlan.CareTeam))
	}
	return nil
}

func handleNotFound(writer http.ResponseWriter, request *http.Request) {
	defer request.Body.Close()
	logrus.Warnf("not found: %s %s", request.Method, request.URL.Path)
	writer.WriteHeader(http.StatusNotFound)
	_, _ = writer.Write([]byte("not found"))
}

func organizationIdentifier(reference fhir.Reference) (string, error) {
	if reference.Identifier.System == nil || *reference.Identifier.System != uraNamingSystem {
		return "", errors.New("invalid identifier system for organization")
	}
	if reference.Identifier.Value == nil {
		return "", errors.New("missing identifier value for organization")
	}
	return fmt.Sprintf("%s|%s", *reference.Identifier.System, *reference.Identifier.Value), nil
}
