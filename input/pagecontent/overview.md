### Introduction

Shared Care Planning (SCP) provides the structures and transactions for care planning, collaboration between practitioners by cross-organizational ordering processes and localization and authorization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxiliary collaboration-systems.

SCP builds upon the IHE 'Dynamic Care Planning' profile (IHE-DCP). It is extended by generic, FHIR workflow patterns for cross-organizational requests or orders. An authorization model will also be provided so that members in a distributed careteam will, e.g., be able to read patient-data from other organizations and/or will be able to plan new activities.

---
### Concepts

This IG uses several concepts from the FHIR R4 specifications. 

#### FHIR Restful interactions
In the transactions sections, this IG will use the [basic concepts on RESTful interaction with a FHIR API](https://hl7.org/fhir/R4/http.html); e.g. read, search, update, create and delete interactions

|------------------------------------------------|
| To avoid losing data during update, actors MUST support the directives in  [transactional integrity](http://hl7.org/fhir/R4/http.html#transactional-integrity) and [concurrency](https://hl7.org/fhir/R4/http.html#concurrency) |
{:.grid .bg-warning}


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
- **status**: The current status of the task (requested, received, accepted, in-progress, on-hold, completed, cancelled, entered-in-error, rejected).
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

#### Provenance
The Provenance resource captures details about the creation, modification, and transmission of a resource. It includes information about the entities and agents involved, as well as the time and place of the event. Provenance is essential for understanding the history and trustworthiness of data within healthcare systems. Members of the CareTeam in a CarePlan are authorized to access and manipulate data.  Therefore the transactions that lead to adding or changing CareTeam-members is recorded in Provenance instances. 
Key elements of a Provenance for SCP:
- **target**: The resources that are the subject of the provenance information (e.g., a specific Task).
- **occurredDateTime**: The time period or specific date and time when the event occurred
- **activity**: The type of activity that took place (e.g., creation, modification).
- **agent**: Details about the individual(s) or organization(s) involved in the event, including:
    - **onBehalfOf**: The organization the agent was acting on behalf of.
- **signature**: Digital signatures that authenticate the provenance event.
For more information, check the [FHIR R4 Provenance documentation](https://hl7.org/fhir/R4/provenance.html) and see [this example of a Task with an embedded Provenance instance](https://hl7.org/fhir/R4/task-example1.json.html).


---
### Actors
There are two actors in this Implementation Guide: The Care Plan Contributor and Care Plan Service. Every care-provider has to implement the Care Plan Contributor role, but in a (cross-organizational) CareTeam, just one care-provider needs to implement the Care Plan Service role.

#### Care Plan Contributor
The first actor is the Care Plan Contributor (CP-Contributor). This actor interacts with both other Care Plan Contributor(s) and a Care Plan Service. This actor creates and updates the care plan and tasks/orders for other (future) Care Plan Contributors. CP-Contributor initiates most transactions on behalf of a real practitioner, patient or related person, but Task-state-changes can be made without an active user.
The CP-Contributor may also retrieve data from the other Care Plan Contributor(s); CP-Contributor will query the Care Plan service for the CarePlan and CareTeam-data to find at which organizations (or endpoints) other data could be reside. The CP-Contributor must also respond to an incoming Task-requests or Task-updates and to authorize other CP-Users to query local data.

Expressed in a FHIR Capability Statement, there are operations that CP-Contributor will do as an client-application (initiating transactions) and as a server-application (responding to transactions):

TODO: FHIR capabilitystatement ([example](https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveConsumer.html))(mode=client):
- POST/PUT CarePlan & Task
- GET various FHIR resource types 

TODO: FHIR capabilitystatement ([example](https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveSupplier.html)) (mode=server):
- POST Notification (for a new/updated Task, CarePlan or CareTeam)
- GET various FHIR resource types (including authorization of CP-User)


#### Care Plan Service
The second actor is the Care Plan Service. This actor manages (hosts) patient specific Care Plans, Tasks and Care Teams. The Care Plan Service is also responsible for **updating several elements in Care Plans and Care Teams** that authorize new persons or practitioners in the Care Team.

TODO: FHIR capabilitystatement (mode=client):
- POST Notifications (for a new/updated Task, CarePlan or CareTeam)
- POST AuditEvent (at local endpoint)
- PUT CarePlan, CareTeam (at local endpoint)

TODO: FHIR capabilitystatement (mode=server):
- POST, PUT, GET Task, CarePlan, CareTeam and AuditEvent (including authorization of CP-User)

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

---
### Transactions

An essential part of SCP is the workflow where one care provider requests another care provider to do something for a patient/CarePlan. If the latter one accepts the request (Task), the Task filler (a.k.a. Task.owner) can be added to the participants of the CareTeam. If a Task is rejected or cancelled, the Task.owner could be removed from the CareTeam. Once a Task is completed, the Task.owner remains a member of the CareTeam, but 'inactive' (CareTeam.participant.period gets an enddate). 
The CareTeam instance is used to find other participants in the CareTeam and health data for the patient/CarePlan. The CareTeam instance is also used to authorize incoming requests for health data for a patient/CarePlan.

Next, we'll go into these three transactions in SCP:

1. Creating and responding to a Task
1. Updating CarePlan and CareTeam
1. Getting data from CareTeam members


#### Creating and responding to a Task
The CarePlan author or an 'active' CareTeam participant can create a new request and send the request to another Care provider. This Care provider may not be a current participant of the CareTeam. The Task status and state transitions are important part in the lifecycle of these requests.
The Task state machine for SCP is a subset of the [base FHIR Task state machine](https://hl7.org/fhir/R4/task.html#statemachine). SCP does not use status 'draft' and state 'ready' is used for (sub-)Tasks that do not lead to changes the participants in the CareTeam: 

<img src="Task-state-machine.png" width="32%" style="float: none"/>

The requestor and owner are restricted to make certain state transitions. For some Task states, the Task.owner will become a member of the CareTeam (see transaction [Updating CarePlan and CareTeam](#updating-careplan-and-careteam)). This table shows who must be authorized to make a state transition:

|State from|State to|Allow state transition for|
|-|-|-|
|-|requested|Task.requestor who is also CareTeam-participant|
|requested|received|Task.owner|
|requested|accepted|Task.owner|
|requested|rejected|Task.owner|
|requested|cancelled|Task.requestor, Task.owner|
|received|accepted|Task.owner|
|received|rejected|Task.owner|
|received|cancelled|Task.requestor, Task.owner|
|accepted|in-progress|Task.owner|
|accepted|cancelled|Task.requestor, Task.owner|
|in-progress|completed|Task.owner|
|in-progress|failed|Task.owner|
|in-progress|on-hold|Task.requestor, Task.owner|
|on-hold|in-progress|Task.requestor, Task.owner|
|-|ready|Task.requestor|
|ready|completed|Task.owner|
|ready|failed|Task.owner|
{:.grid .table-hover}

In the first sequence diagram, Care Provider 1 has implemented the (optional) CP-Service role and is requesting Care Provider 2 to do a Task. As a Task MUST always be based on a CarePlan, so if there is none, a CarePlan should be created. 
> Optional: As Care Provider 2 is evaluating the Task, it may create a new Task (a sub-Task that is based on the main Task) containing a Questionnaire for Care Provider 1. As soon as Care Provider 1 provides the response, Care Provider 2 re-evaluates the main Task. This cycle can be repeated. The reason for cycles of (short, incremental) Questionnaires (or conditional segments in a Questionnaire?) is that if Care Provider 2 evaluates the first response (e.g. inclusion criteria for the Task) it might reject the main Task without Practitioner 1 having to answer additional questions. The table above specifies who is able to do certain state transitions. 

<div>
{% include overview-task-negotiation-1-2.svg %}
</div>

This transaction is based on [FHIR workflow pattern H](https://hl7.org/fhir/R4/workflow-management.html#optionh) which uses a 'workflow broker' that stores and manages Task resources. In SCP, the 'workflow broker' is implemented by the Care Plan Service. The Care Plan Service store and manages Tasks, CarePlans and CareTeam resources.

In the second diagram, Care Provider 2 will send Care Provider 3 a request, still using Care Provider 1 as the 'workflow broker' (the CP-Service where the CarePlan, CareTeam and Tasks reside). In this example, Care provider 3 is not able to accept the Task automatically and needs an practitioner to evaluate it. 

<div>
{% include overview-task-negotiation-1-2-3.svg %}
</div>

For more information on this transaction, see [Transactions - Creating and responding to a Task](./transaction-task-negotiation.html)

#### Updating CarePlan and CareTeam
The CarePlan Service is responsible for updating the CareTeam and, for convenience, the CarePlan.activities. This transaction is triggered by a Task creation or update at the CP-Service. 

The CP-Service evaluates the Task update (is state transition allowed?). The Task state determines if the Task.owner should or shouldn't be a participant in the CareTeam (see the table below). Once a Task is completed or failed, the Task.owner remains a participant, but the (active) period is ended, unless there are other active Tasks for the participant. Active CareTeam.participants are authorized to access patient data at other CareTeam.participants. Inactive (period has ended) CareTeam.participants can access the Tasks, CarePlan and CareTeam. Other Care providers can only access their Tasks (for more info see [security-authorization](authorization.html)).  

The CarePlan.author and CarePlan.subject are always active participants in the CareTeam.

|State to|Task.owner is <br>CareTeam.participant|CareTeam.participant.period|
|-|-|-|
|requested|No|-|
|received|No|-|
|accepted|Yes|period.start=date accepted|
|rejected|No|-|
|cancelled|No|-|
|in-progress|Yes|period.start=date accepted|
|on-hold|Yes|period.start=date accepted|
|completed*|Yes|period.start=date accepted<br>period.end=date completed|
|failed*|Yes|period.start=date accepted<br>period.end=date failed|
|ready|No|-|
{:.grid .table-hover}

*: If the Task was never in state 'accepted' (thus state 'ready' was used), the Task.owner is not a CareTeam.participant and CareTeam.participant.period will be empty.

 

<div>
{% include overview-careplan-careteam-management.svg %}
</div>


#### Getting data from CareTeam members

The first two transactions allow practitioners to collaborate across organizational borders. Having the CarePlan and CareTeam in place, also allows for CareTeam members to get additional information for the patient/CarePlan. In this transaction, Care Provider 2 is using the CareTeam from the CP-Service to locate other CareTeam members and ask each CareTeam-member for health data for this patient.
The 'responding' CareTeam-member (data holders) use the CareTeam, CarePlan and Tasks to authorize incoming requests.

<div>
{% include overview-getting-data-from-careteam-members.svg %}
</div>

Note that the CP-Service will notify all CP-Contributors on changed CarePlans and CareTeams. It might not be necessary to retrieve these from the CP-Service if the CarePlan and CareTeam are stored locally at the CP-Contributor.

### Deployment considerations
***TODO*** Use Orca and you'll be fine.

---
### Related Standards

The above specification is an extension of the IHE Dynamic Care Planning profile (DCP). This specification extends the IHE profile with workflows (between organizations), CareTeam-member/data localization and CareTeam-member authorization for this data. Naturally, there are other standards within healthcare that overlap with this specification. In drafting this specification, efforts have been made to reuse existing standards as much as possible.
We'll briefly describe the differences between SCP and other standards. The 'use case' section of this IG contains some examples of how to implement these other standards using SCP (e.g. [Nursing handoff (eOverdracht)](./usecase-nursing-handoff.html)).

#### IHE: DCP
***TODO***This specification has copied many of the concepts used in IHE DCP. However.... describe difference

#### IHE: mCSD
***TODO***

#### US: Bi-directional ServiceRequest (BSER)
***TODO***

#### NL: eOverdracht
***TODO*** beschrijving overeenkomsten en verschillen met eOverdracht standaard


#### NL: Koppeltaal 2.0
***TODO*** beschrijving overeenkomsten en verschillen met Koppeltaal 2.0 standaard

#### NL: Technical Agreement Notified Pull
***TODO*** beschrijving overeenkomsten en verschillen met TA NP standaard