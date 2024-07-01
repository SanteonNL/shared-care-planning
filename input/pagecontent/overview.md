### Introduction

Shared Care Planning (SCP) provides the structures and transactions for care
planning, collaboration between practitioners by cross-organizational ordering processes and localization and authorization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxillary collaboration-systems.

SCP builds upon the IHE 'Dynamic Care Planning' profile (IHE-DCP). It is extended by generic, FHIR workflow patterns for cross-organizational requests or orders. An authorization model will also be provided so that members in a distributed careteam will, e.g., be able to read patient-data from other organizations and/or will be able to plan new activities.


### Concepts

This IG uses several concepts from the FHIR R4 specifications. 

#### FHIR Restful interactions
In the transactions sections, this IG will use the [basic concepts on RESTful interaction with a FHIR API](https://hl7.org/fhir/R4/http.html); e.g. read, search, update, create and delete interactions
> [!IMPORTANT] 
> To avoid losing data during update, actors MUST support the directives in  [transactional integrity](http://hl7.org/fhir/R4/http.html#transactional-integrity) and [concurrency](https://hl7.org/fhir/R4/http.html#concurrency)

#### FHIR Workflow
This IG will use and specify a workflow pattern. For general FHIR workflow concepts, see: https://hl7.org/fhir/R4/workflow.html The base pattern that will be used is the [https://hl7.org/fhir/R4/workflow-management.html#optionh](https://hl7.org/fhir/R4/workflow-management.html#optionh)


#### FHIR Resource types
The IG is referring to many FHIR resource types. Key resource types for SCP:

##### CarePlan
The FHIR CarePlan resource is a framework for documenting and managing healthcare interventions and goals. It ensures that all relevant information is available to all stakeholders, promoting coordinated and effective care delivery. Key elements of a CarePlan for SCP:
- **subject**: The patient to whom the care plan is intended.
- **addresses**: Conditions/problems/concerns/diagnoses that this plan is addressing.
- **activity**: Details of the planned interventions, including scheduled activities, performed activities, and their outcomes.
- **careTeam**: All the individuals and organizations who are expected to be involved in the care plan’s execution.
- **author**: The person or organization that authored the care plan.
- **supportingInfo**: Additional (relevant) information to support the care plan, such as diagnostic reports, procedures, family member history, observations, etc.
- **goal**: The intended outcomes or objectives of the care plan. 

For SCP, CarePlan will be validated using [this profile](TODO). For more information, check the [FHIR R4 CarePlan documentation](https://hl7.org/fhir/R4/careplan.html)

#### CareTeam
The CareTeam resource includes all people and organizations who are participating or have participated in the care process for a patient. Key elements of a CareTeam for SCP:
- **participant**: The members of the care team and their roles. This includes:
    - **member**: The actual person (patient, related person) or organization participating.
    - **onBehalfOf**: The organization the participant is representing.
    - **period**: The time period during which the participant is involved with the care team. This could be ongoing (active member) or ended (inactive member) 
For SCP, CareTeam will be validated using [this profile](TODO). For more information, check the [FHIR R4 CareTeam documentation](https://hl7.org/fhir/R4/careteam.html)

#### Task
The Task resource describes an activity that can be performed, is being performed, or has been performed. It is used to manage and track the status of tasks, participants and definition of the Task. A Task in SCP is always related ('basedOn') the CarePlan. When a party is request to 'do' a Task, that organizations that may not be part of the CareTeam yet. Personally Identifiable Information SHOULD be left out of the Task content until the Task is accepted by the organization responsible for the Task.
Key elements of a Task for SCP:
- **basedOn**: References to other requests that the task is based on. MUST contain one reference to a SCP-CarePlan.
- **focus**: A reference to the request-resource that the task is focused on. (e.g. a [ServiceRequest](https://hl7.org/fhir/R4/servicerequest.html), [MedicationRequest](https://hl7.org/fhir/R4/medicationrequest.html) or [DeviceRequest](https://hl7.org/fhir/R4/devicerequest.html))
- **code**: The type of task to be performed (e.g. approval, fullfilment, suspend or resume)
- **status**: The current status of the task (e.g., draft, requested, received, accepted, in-progress, on-hold, completed, cancelled, entered-in-error, rejected).
- **requester**: The individual or organization who initiated the task.
- **owner**: The individual or organization responsible for the task.
- **for**: The patient for whom the task is being performed.
- **input**: The input data required for the task.
- **output**: The output data produced by the task.
https://hl7.org/fhir/R4/task.html see the state machine: https://hl7.org/fhir/R4/workflow-communications.html#12.6.2

#### Entities: Patient, RelatedPerson, Practitioner, PractitionerRole, Organization
SCP uses some base FHIR resource types for entities. These entities are referenced in the [CarePlan](#careplan), [CareTeam](#careteam) or [Task](#task). 

For the planning or coordination of care, healthcare professionals should be able to get into contact with each other. The CareTeam-members could, for instance, plan a Multi Disciplinary Team-meeting to discuss the condition of the patient. How to organize these meetings is out of scope for SCP.
The identifiers for Patient, RelatedPerson, Practitioner and Organization are used for authentication and authorization. The key element for these entity-resources are: 
- **identifier**: e.g. Social Security Number for individuals, Care Professional number for PractitionerRoles, Chamber of Commerce number for organizations. 
- **name**: name of the Patient, RelatedPerson, Practitioner or Organization
- **telecom**: contact details of the Patient, RelatedPerson, Practitioner or Organization
For more information, check the FHIR R4 [Patient](https://hl7.org/fhir/R4/patient.html), [RelatedPerson](https://hl7.org/fhir/R4/relatedperson.html), [PractitionerRole](https://hl7.org/fhir/R4/practitionerrole.html) or [Organization](https://hl7.org/fhir/R4/organization.html) documentation

#### AuditEvent
The FHIR AuditEvent resource is used for logging of events that record activities related to the use or manipulation of data. Members of the CareTeam in a CarePlan are authorized to access and manipulate data.  Therefore the transactions that lead to adding or changing CareTeam-members is recorded in AuditEvents. For more information, check the [FHIR R4 AuditEvent documentation](https://hl7.org/fhir/R4/auditevent.html).

#### Definitional resource: PlanDefinition and ActivityDefinition
The FHIR PlanDefinition and ActivityDefinition resource provides a detailed, reusable template for defining various healthcare-related activities. It ensures that standardized actions, treatments, and procedures can be clearly described and referenced across different healthcare systems, promoting consistency and quality in care delivery.
Using the [$apply operation](https://hl7.org/fhir/R4/activitydefinition-operation-apply.html) healthcare organizations are able instantiate a [CarePlan](#careplan) or request (referred to in [Task](#task).focus) in a consistent way.
For more information, check the FHIR R4 [PlanDefinition](https://hl7.org/fhir/R4/plandefinition.html), [ActivityDefinition](https://hl7.org/fhir/R4/activitydefinition.html) documentation.



### Actors
There are three actors in this Implementation Guide: The Care Plan User, Care Plan Contributor and Care Plan Service.

#### Care Plan User
The first actor is the Care Plan User (CP-User). It is an application/client rol that is acting on behalf of a real practitioner, patient or related person. This actor interacts with both the Care Plan Contributor(s) and the Care Plan Service. This actor creates and updates the care plan and tasks/orders for other (future) Care Plan Contributors. The CP-User may also get data from the other Care Plan Contributor(s); CP-User will query the Care Plan service for the CarePlan and CareTeam-data to find at which organizations (or endpoints) other data could be reside. Every SCP-transaction is initiated or trigged by a Care Plan User, so any manipulation of data can be led back to a Care Plan User or responsible person.

TODO: FHIR capabilitystatement ([example](https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveConsumer.html)) (mode=client):
- POST/PUT CarePlan & Task
- GET various FHIR resource types

#### Care Plan Contributor
The second actor is the Care Plan Contributor (CP-Contributor). The main responsibilities of a CP-Contributor is to respond to an incoming Task-requests or Task-updates and to authorize other CP-Users to query local data.

TODO: FHIR capabilitystatement (mode=client):
- PUT Task
- GET CarePlan, CareTeam, Task, PractitionerRole, Organization to authorize CP-User to query data in the context of a CarePlan

TODO: FHIR capabilitystatement ([example](https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveSupplier.html)) (mode=server):
- POST Notification (for a new/updated Task, CarePlan or CareTeam)
- GET various FHIR resource types (including authorization of CP-User)


#### Care Plan Service
The third actor is the Care Plan Service. This actor manages (hosts) patient specific Care Plans, Tasks and Care Teams. The Care Plan Service is also responsible for **updating several elements in Care Plans and Care Teams** that authorize new persons or practitioners in the Care Team.
Optionally, this actor also manages (hosts) Plan Definitions and Activity Definitions that are used for order sets, protocols, clinical practice guidelines, etc.

TODO: FHIR capabilitystatement (mode=client):
- POST Notifications (for a new/updated Task, CarePlan or CareTeam)
- POST AuditEvent (at local endpoint)
- PUT CarePlan, CareTeam (at local endpoint)

TODO: FHIR capabilitystatement (mode=server):
- POST, PUT, GET Task, CarePlan, CareTeam and AuditEvent (including authorization of CP-User)
- Optional: POST, PUT, GET, DELETE, $apply for PlanDefinition and ActivityDefinition

TODO/Roadmap: 
- transfer CarePlan-responsibility to other Practitioner or Organization. Maybe use a Task for the current CarePlan-author to accept
- support for CarePlan-merges. Maybe use a Task for the to-be-merged-CarePlan-author to accept. Add all Tasks (all versions and provenance?) to the new CP-service.


### Security considerations

#### Identification and authentication
Data push or data pull of Personally Identifiable Information (PII) should always be initiated by a Practitioner; should be auditable who has done stuff.

Refer to Trust-over-IP or ARF or something

#### Authorization
Authorization; based on conditions, task-type, careteam-member-status (active/inactive) and/or role
Member(-status) in the CareTeam are only updated by the CPS after 'agreement' on a Task in the CarePlan. 

### Transactions

There are three transactions in SCP:
1. Creating and responding to a Task
1. Updating CarePlan and CareTeam
1. Getting data from CareTeam members


#### Creating and responding to a Task






#### Updating CarePlan and CareTeam




#### Getting data from CareTeam members





### Deployment considerations
use Orca and you'll be fine.

### Overview of the documentation structure

The image below displays the schematic overview of the topics.

Legenda
- Light green, existing standards that don't need a specific description of the usage.
- Dark green, existing standards that need a specific description of the usage.
- Blue, the topics that need description.

### Related Standards

TODO Review text:
In bovenstaande specificatie beschrijft een implementatie van het IHE DCP profiel. Deze specificatie breidt het IHE profile uit met de data die binnen werkprocessen (en tussen organisaties) ontstaat en de afgeleide, functionele autorisatie voor deze data. Uiteraard zijn er andere standaarden binnen de zorg die een overlap hebben met deze specificatie. Bij het opstellen van deze specificatie is getracht om zo veel mogelijk deze bestaande standaarden te hergebruiken.



<img src="example1-2.png" width="50%" style="float: right"/>

#### IHE: DCP
This specification has copied many of the concepts used in IHE DCP. However.... describe difference

#### US: Bi-directional ServiceRequest (BSER)

#### NL: eOverdracht
[TODO: beschrijving overeenkomsten en verschillen met eOverdracht standaard]


#### NL: Koppeltaal 2.0
[TODO: beschrijving overeenkomsten en verschillen met Koppeltaal 2.0 standaard]

#### NL: Technical Agreement Notified Pull
[TODO: beschrijving overeenkomsten en verschillen met TA NP standaard]