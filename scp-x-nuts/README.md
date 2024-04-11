# SCPxNuts HL7 NL Connectaton

## Software Design Decisions
- Care Team Service is a "view" derived from the membership of a CarePlan in the Care Plan Service
- Care Team Service and Care Plan Service are 1

## Requirements
- Care Plan Service
  - CPS authorizes Care Plan Contributor that views the CareTeam.
  - CPS authorizes Care Plan Contributor that views the CarePlan.
  - Optional: authorization of Care Plan Contributor that creates the plans.
    Contributor must be a subscriber/tenant of the Care Plan Service to create a CarePlan. 
  - Publicly available as Docker image and documented
