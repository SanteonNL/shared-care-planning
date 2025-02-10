### Introduction

Shared Care Planning (SCP) provides the structures and transactions for care planning, collaboration between practitioners by cross-organizational ordering processes and localization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxiliary collaboration-systems. For practitioners and patients, Shared Care Planning provides an overview of related activities and participants in a care plan and care team. Shared Care Planning lowers the barriers that may exists between care organisations. Cross-organization referrals, communication or data access should be as simple and obvious as within a single organization or application.

### Concepts

#### CarePlan and CareTeam
SCP builds upon the IHE 'Dynamic Care Planning' profile ([IHE-DCP](https://wiki.ihe.net/index.php/Dynamic_Care_Planning_(DCP))). The FHIR CarePlan and CareTeam are used to consolidate the activities and participants for a patient. Whenever a SCP-CarePlan is created or updated, all participants are notified.

#### CarePlan Activities
Activities in the CarePlan are represented by FHIR Tasks. These Tasks are communicated between a requester and a performer using the [FHIR Workflow Mangement Communication patterns](https://hl7.org/fhir/R4/workflow-management.html). 

> The main premise of SCP is that all Tasks should refer to the same CarePlan, as long as they are related to one or more associated conditions or goals. The requesters and performers of all Tasks are consolidated as the CarePlan participants or a 'care network' of that patient. Being participant in a CarePlan may be used for localization and autorization (to read healthcare data from other care team participants or to invite new participants). A performer shall be added as a participant as soon as it accepts a Task with the intent of an order (accepting 'proposal-Tasks' does not lead to CarePlan-membership). Whenever a SCP-Task is created or updated, all Task participants *and the CarePlan-host* are notified

The Task has a state (requested, accepted, completed, etc.) and it refers to a focal resource (ServiceRequest, CommunicationRequest, MedicationRequest, Questionnaire, Consent, etc.). The focal resource contains the actual specification of what is requested, wheras the task manages metadata like requester, performer, state and if e.g. fulfilled or approval is desired by the requester.

#### Care Services
In order to address a (potential) performer, a directory of care services and technical endpoints is required. [IHE mobile Care Service Discovery](https://profiles.ihe.net/ITI/mCSD/ImplementationGuide/ihe.iti.mcsd|3.9.0) specifies such a directory: 
- FHIR Organizations specify the actual (legally registered) care providers and departments within the organization 
- FHIR HealthcareServices and/or FHIR PractitionerRole may be used to specify which services are offered by an organization.
- FHIR Locations specify the physical location where a HealthcareService, PractitionerRole or Organization offers services 
- FHIR Endpoints specify the technical location (url) for communication.

When a practitioner is creating a Task, it will query the care services directory for the service-type that is requested, possibily within some geographical boundaries (using Location). Once a HealthcareService, PractitionerRole or Organization is selected, a system should lookup the appropriate endpoint/url to send a Task or notification.

SCP does not specify the geographical area of a care service directory. It could cover a small region or multiple countries (e.g. European Union). This could improve collaboration between practitioners for patients that are temporarily living abroad, near country borders, suffer from a rare disease or require highly specialized care.

#### Notifications
The [FHIR Workflow Mangement Communication patterns](https://hl7.org/fhir/R4/workflow-management.html) specify that a Task could either 'live' at the requester, performer or a broker (pattern [F](https://hl7.org/fhir/R4/workflow-management.html#optionf), [G](https://hl7.org/fhir/R4/workflow-management.html#optiong) or [H](https://hl7.org/fhir/R4/workflow-management.html#optionh)). For some steps in these workflow patterns, a notification mechanism is needed (SCP does not use 'polling'; we'll come back to this later). SCP uses the [Topic-based, out-of-band/server managed subscription framework from the FHIR R6 specifications](https://build.fhir.org/subscriptions.html). In order to implement this in FHIR version R4, the [Subscriptions R5 Backport for R4](https://hl7.org/fhir/uv/subscriptions-backport/) is used. This subscription framework provides ways to create very reliable organization-to-organization communication using ordinary http-requests. This server-managed-subscription-framework does not require up-front registration of clients or subscriptions making it very flexible to address a HealthcareService, PractitionerRole or Organization.

#### Provenance
The final 'ingredient' of the Shared Care Planning specification involves a way lookup and verify what happened in the careplan. The FHIR Provenance resource is used whenever an organization creates or updates a Task or CarePlan to record who or what caused the change. For example, activities and participants were added to a CarePlan/Careteam caused by a specific Task instance; the Provenance resource will link the CarePlan-update to the Task. A verification signature is added to the Provenance resource to *prove* who changed the Task or CarePlan. This mitigates the security risk of malicious clients. The signature also provides a way to be flexible in where a Task or CarePlan 'lives'; it can be hosted at the requester, performer or some other broker involved in the care network of that patient. Therefore, SCP is indifferent which workflow pattern ([F](https://hl7.org/fhir/R4/workflow-management.html#optionf), [G](https://hl7.org/fhir/R4/workflow-management.html#optiong) or [H](https://hl7.org/fhir/R4/workflow-management.html#optionh)) is used; this relaxes effort to implement SCP at an EHR. It also provides a way to move Tasks or CarePlan from one organization to another e.g. if a care provider ceases to exist.
The Provenance resource is used to record why and who created or updated data. It is left up to the implementor how to properly record other events to comply to local audit requirements (e.g. ISO 27789). 


