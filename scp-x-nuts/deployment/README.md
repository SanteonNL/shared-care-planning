# Deployment

## Pre-requisites
Have Docker Compose installed. So far, it has only been tested on MacOS.

## Usage
Make sure you have the latest Docker image versions, then start the Nuts node.
It uses the "dev" image that creates a DevTunnel which requires you to log in with GitHub.
If you don't log in, the stack will not start.
```bash
docker compose pull
docker compose up nutsnode
```

After you've made sure the Nuts node started, start the rest of the stack:
```bash
docker compose up --build
```
(you could do it in one go, but you might miss the Nuts node asking you to click a link to log in with GitHub).

Then, the following services will are started:
- FHIR Store (HAPI)
- Nuts node
- the initializer, that waits until the FHIR server and Nuts node are ready. It then creates:
  - a tenant for CarePlanService in the FHIR server
  - 2 care organizations in the Nuts node (meaning a DID, and a self-issued `NutsOrganizationCredential` and `URACredential`)

## TODO
- Care Team Service:
  - [x] Fix bug where CareTeam isn't updated, but recreated every time
  - [x] Add Update() method to FHIR client that requires a resource with an ID, to avoid accidentally creating new resources.
    Use this for updating CareTeam and CarePlan resources.
  - [ ] Cleanup
  - [ ] Add authorization API
- Demo EHR:
  - [ ] Add Demo EHR deployment
  - [x] Support creating CarePlan in CarePlanService (register full resource URL in database)
  - [x] Support creating Tasks in CarePlan for other (or own) organization
  - [x] Add CarePlan view with CareTeam members
