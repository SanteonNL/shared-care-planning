# Workflow
This IG supports the following processes:
1. Shared Care Workflow: an organization requests an activity from another organization. 
2. Shared Care Data Request: an organization requests ehr data from another organization

## 1. Shared Care Workflow
### Functional description
Shared Care Workflow concerns the structures and transactions for care planning and collaboration between practitioners by cross-organizational ordering processes.

### Pattern
This IG specify a workflow pattern for the Shared Care Workflow. For general FHIR workflow concepts, see: https://hl7.org/fhir/R4/workflow.html. The base pattern that will be used is [FHIR Workflow Pattern H](https://hl7.org/fhir/R4/workflow-management.html#optionh). 

### Actors
There are a couple of actors in the Shared Care Workflow:
- Care Plan Contributor
- Care Plan Service
- Care Plan Definition Service

#### Care Plan Contributor
The first actor is the Care Plan Contributor. This actor interacts with both the Care Plan Service and the Care Plan Definition Service. This actor creates and updates the care plan and tasks/orders for other Care Plan Contributors. 

This actor aligns with actors Placer and Filler in [FHIR Workflow Pattern H](https://hl7.org/fhir/R4/workflow-management.html#optionh).

#### Care Plan Service
The second actor is the Care Plan Service. This actor manages patient specific Care Plans, Tasks and Care Teams. The Care Plan Service is also responsible for updating several elements in Care Plans and Care Teams that authorize new practitioners in the Care Teams.

This actor aligns with actor Broker in [FHIR Workflow Pattern H](https://hl7.org/fhir/R4/workflow-management.html#optionh).

#### Care Plan Definition Service
The third actor is the Care Plan Definition Service. This actor manages Plan Definitions and Activity Definitions that are used for order sets, protocols, clinical practice guidelines, etc.

## 2. Shared Care Data Request
### Functional description
Shared Care Data Requests concern the structures and transactions for data requests to and from members involved in the careteam of a patient. The artifacts created in the Shared Care Workflow are used for localization and authorization.

### Pattern
----- to do
------ unsolicited pull?

### Actors
There are a couple of actors in Shared Care Data Requests:
- Data User
- Data Holder
- Care Plan Service

#### Data User
This is an actor that has a request concerning data held by another party, the data holder.

#### Data Holder
This is an actor that hosts the data that is requested by the data user.

#### Care Plan Service
This actor hosts Care Plans and Care Teams that act
- as index in the localization process performed by the Data User;
- as parameters in the authorization process performed by the Data Holder.

#### Access Policy Service
This actor hosts generic authorization policies that can be used as paramaters in the authorization process. E.g.:
- Condition - resource matrices
- ParticipantRole - Resource matrices