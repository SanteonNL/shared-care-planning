# SCPxNuts HL7 NL Connectaton

## Specification Design Decisions
- Does the Request/Referral Task live on the Placer's FHIR server or on the Care Team Service? Or support both?

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

## Anti-requirements
- No ActivityDefinitions (too much work (lack of knowledge), unless someone who does, makes them?)