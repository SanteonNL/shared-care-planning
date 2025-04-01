For notification, SCP uses the . The backport-subscription-profiles for R4 give the option for 'id-only' subscriptions. Notification bundles for 'id-only-subscriptions' will only contain resource-identifiers (in stead of e.g. the full instances), which doesn't exist in the R4 specifications.

The CarePlan service manages subscriptions and sends out the notifications, following the . 

SCP-nodes will have to implement the capability to receive notifications of type 'handshake', 'heartbeat' and 'event-notification' and respond according to the FHIR spec. If a heartbeat-notificatiuon was not received within the specified window, the client should.... was  receive a notification-bundle whenever a Task, CarePlan or CareTeam is updated where 'they' (e.g. the Organization of the CarePlanContributor) is registered as a requester, author, member, owner, etc. 
Check out the example instances for a [subscription](Subscription-cps-sub-hospitalx.json.html) or [notification-bundle](Bundle-notification-hospitalx-01.json.html).


Tasks  

Exchange 

It is extended by generic, FHIR workflow patterns for cross-organizational requests or orders. An authorization model will also be provided so that members in a distributed careteam will, e.g., be able to read patient-data from other organizations and/or will be able to plan new activities.

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


#### Entities: Patient, RelatedPerson, Practitioner, PractitionerRole, Organization
SCP uses some base FHIR resource types for entities. These entities are referenced in the [CarePlan](#careplan), [CareTeam](#careteam) or [Task](#task). 

For the planning or coordination of care, healthcare professionals should be able to get into contact with each other. The CareTeam-members could, for instance, plan a Multi Disciplinary Team-meeting to discuss the condition of the patient. How to organize these meetings is out of scope for SCP.
The identifiers for Patient, RelatedPerson, Practitioner and Organization are used for authentication and authorization. The key element for these entity-resources are: 
- **identifier**: e.g. Social Security Number for individuals, Care Professional number for PractitionerRoles, Chamber of Commerce number for organizations. 
- **name**: name of the Patient, RelatedPerson, Practitioner or Organization
- **telecom**: contact details of the Patient, RelatedPerson, Practitioner or Organization
For more information, check the FHIR R4 [Patient](https://hl7.org/fhir/R4/patient.html), [RelatedPerson](https://hl7.org/fhir/R4/relatedperson.html), [PractitionerRole](https://hl7.org/fhir/R4/practitionerrole.html) or [Organization](https://hl7.org/fhir/R4/organization.html) documentation

#### Provenance



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


---
### Transactions

An essential part of SCP is the workflow where one care provider requests another care provider to do something for a patient/CarePlan. If the latter one accepts the request (Task), the Task filler (a.k.a. Task.owner) can be added to the participants of the CareTeam. If a Task is rejected or cancelled, the Task.owner could be removed from the CareTeam. Once a Task is completed, the Task.owner remains a member of the CareTeam, but 'inactive' (CareTeam.participant.period gets an enddate). 
The CareTeam instance is used to find other participants in the CareTeam and health data for the patient/CarePlan. The CareTeam instance may also be used to authorize transactions.

Next, we'll go into these three transactions in SCP:

1. Creating and responding to a Task
1. Updating CarePlan and CareTeam
1. Getting data from CareTeam members






#### Notifications

For notification, SCP uses the [Subscriptions R5 Backport for R4](https://hl7.org/fhir/uv/subscriptions-backport/). The backport-subscription-profiles for R4 give the option for 'id-only' subscriptions. Notification bundles for 'id-only-subscriptions' will only contain resource-identifiers (in stead of e.g. the full instances), which doesn't exist in the R4 specifications.

The CarePlan service manages subscriptions and sends out the notifications, following the [Out-of-band (or server) managed subscriptions in the FHIR R6 specifications](https://build.fhir.org/subscriptions.html#workflow-styles). 




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