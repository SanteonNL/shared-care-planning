# Deployment

## Pre-requisites
Have Docker Compose installed

## Usage
1. Start the FHIR Store and its initializer that creates tenants in the FHIR server:
    ```bash
    docker compose up --build fhirstore initializer
    ```
2. Wait for the FHIR server to start completely, then start the CareTeamService:
    ```bash
    docker compose up --build careteamservice
    ```

## TODO
- Care Team Service:
  - [ ] Fix bug where CareTeam isn't updated, but recreated every time
  - [ ] Add Update() method to FHIR client that requires a resource with an ID, to avoid accidentally creating new resources.
    Use this for updating CareTeam and CarePlan resources.
  - Cleanup
- Demo EHR:
  - [ ] Add Demo EHR deployment
  - [ ] Support creating CarePlan 
  - [ ] Support creating Tasks in CarePlan for other (or own) organization
