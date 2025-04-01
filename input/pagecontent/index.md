
# Motivation for Shared Care Planning
Rising healthcare costs are unsustainable in the long term. By making healthcare more efficient, we can ensure the sustainability of healthcare systems, safeguarding access to care for future generations. In The Netherlands, many patients visit multiple practitioners during their treatment, at different organizations. Continuous care coordination and/or collaboration comes with high costs. Currently, these practitioners either handover the patient to a different care-provider or practitioners use the same IT-system for collaboration. Both methods have severe disadvantages. 

Using the Dutch handover-process, it requires the initiating party to write a hand-over-letter, collect and send data. The 'receiving' party has to read this letter and decide what to do with the data; either reconciliate (copy) the data in their own system or discard the data. The receiving party is often required to send back a 'discharge' letter after treatment. The process of handovers involves a significant amount of administrative work. When two practitioners would like to collaborate (back and forth) using this handover-process, the administrative burden increases because data might be duplicated at every handover. When more than two parties are involved in a collaboration, the handover-process is even more challenging to coordinate care and relevant/up-to-date data.
When practitioners of different organizations use the same IT-system, collaboration is often a lot easier. These systems (e.g. a regio-wide implemented EHR or a care network/collaboration platform) usually provides members of the careteam functionality to share medical records, to communicate and to coordinate/plan care activities for a patient. The downside of these systems is that every participant of the careteam has to use that same system. In The Netherlands, many care organizations participate in multiple organization-associations. Implementing an IT-system in a group of care-organizations can be challenging and often results in a lock-in with that vendor. In some organizations, different systems have been implemented for multiple organization-affiliations. This already leads to multiple care-network-platforms that a practitioner has to use, in addition to the EHR. Switching between different applications decreases productivity and practitioner-satisfaction. Using multiple (collaboration) systems also create new silo's of disconnected medical data for a patient.

Shared Care Planning (SCP) provides the structures and transactions for care planning, collaboration between practitioners by cross-organizational ordering processes, data localization and authorization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxillary collaboration-systems. For practitioners and patients, Shared Care Planning provides an overview of related activities and participants in a care plan and care team. Shared Care Planning lowers the barriers that may exists between care organisations. Cross-organization referrals, communication or data access should be as simple and ubiquitous as a practitioner would do within a single care organization.

### Concepts
In order to create a standard for cross-organizational workflow and data access, we'll set some guiding principles:
- Data at the source system remains the single-point-of-truth. Data may be copied from one to the other organization, but these copies are just to reduce operational dependencies (i.e. cache). An update should be always be applied on the original instance.
- Shared Care Planning builds on international standards HL7 FHIR and IHE profiles. It is basically a selection (not an extension) of existing specifications which are used/combined to create a guide for cross-organizational workflow and data access.
- Care providers should not need a central facility/platform to use Shared Care Planning. For various reasons (privacy, security, commercial, high availability) you could argue that you don't want to be dependant on a single service or vendor. Shared Care Planning should support such a federated IT landscape. 

The 'care network' within Shared Care Planning is formed by a FHIR **CarePlan** that references FHIR **Tasks** and vice versa. New participants or, e.g., the FHIR endpoint of a participant can be found by using a **care services** directory. Participants of a CarePlan or Tasks are always **notified** of updates. For privacy *and security* reasons, the Patient can be asked to approve certain changes in Tasks or CarePlans.

#### CarePlan
SCP builds upon the IHE 'Dynamic Care Planning' profile ([IHE-DCP](https://wiki.ihe.net/index.php/Dynamic_Care_Planning_(DCP))). A Shared Care Planning-CarePlan (SCP-CarePlan) contains the activities (Tasks) that were used for requests/referrals in the context of one or more related conditions and/or goals. The participants of these requests are consolidated as the 'care network' of the patient. A SCP-CarePlan participant can active or inactive, depending on the state of the requests/referrals. Active participants in the SCP-CarePlan should be able to access relevant data at all other participants.
This implementation guide does not assume a SCP-CarePlan to be the one and only CarePlan for a patient; every care provider may have a seperate detailed CarePlan or EpisodeOfCare. 
Whenever a SCP-CarePlan is created or updated, all stakeholders are notified.

#### Workflow
Activities in the CarePlan are represented by FHIR Tasks. These Tasks are communicated between a requester and a performer using the [FHIR Workflow Management Communication patterns](https://hl7.org/fhir/R4/workflow-management.html). 

The main premise of SCP is that all Tasks should refer to the same CarePlan, as long as they are related to one or more associated conditions or goals. The requesters and performers of all Tasks are consolidated as the CarePlan participants or a 'care network' of that patient. A performer shall be added as a careplan participant as soon as it accepts a SCP-Task with the intent to order (accepting 'proposal-Tasks' does not lead to CarePlan-membership). The patient should be informed (using the notification framework) or should actively approve this change (using the workflow framework). Being a participant in a CarePlan may be used for data localization and autorization (to read healthcare data from other careplan participants or to invite new participants). Whenever a SCP-Task is created or updated, all Task stakeholders are notified.

#### Care Services
In order to address a (potential) performer, a directory of care services and technical endpoints is required. [IHE mobile Care Service Discovery](https://profiles.ihe.net/ITI/mCSD/ImplementationGuide/ihe.iti.mcsd|3.9.0) specifies such a directory: 
- FHIR Organizations specify care providers and departments within that care provider. 
- FHIR HealthcareServices and/or FHIR PractitionerRole may be used to specify which services are offered by an organization.
- FHIR Locations specify the physical location where a HealthcareService, PractitionerRole or Organization offers services 
- FHIR Endpoints specify the technical location (url) for communication or data exchange.

When a practitioner is creating a Task, it will query the care services directory for the service-type that is requested, possibily within some geographical boundaries (using Location). Once a HealthcareService, PractitionerRole or Organization is selected, a system should lookup the appropriate endpoint/url to send a Task or notification.

SCP does not specify the geographical area of a care service directory. It could cover a small region or multiple countries. A broad scope could improve collaboration between practitioners for patients that are temporarily living abroad, near country borders, suffer from a rare disease or require highly specialized care.

#### Notifications
The [FHIR Workflow Mangement Communication patterns](https://hl7.org/fhir/R4/workflow-management.html) specify that a Task could either 'live' at the requester, performer or a broker (pattern [F](https://hl7.org/fhir/R4/workflow-management.html#optionf), [G](https://hl7.org/fhir/R4/workflow-management.html#optiong) or [H](https://hl7.org/fhir/R4/workflow-management.html#optionh)). For some steps in these workflow patterns, a notification mechanism is needed (SCP does not use 'polling'; we'll come back to this later). SCP uses the [Topic-based, out-of-band/server managed subscription framework from the FHIR R6 specifications](https://build.fhir.org/subscriptions.html). In order to implement this in FHIR version R4, the [Subscriptions R5 Backport for R4](https://hl7.org/fhir/uv/subscriptions-backport/) is used. This subscription framework provides a way to create very reliable organization-to-organization communication using ordinary http-requests. This server-managed-subscription-framework does not require up-front registration of clients or subscriptions making it very flexible to create and assign a Task to a HealthcareService, PractitionerRole or Organization.

### Organization of this Implementation Guide

- [CarePlan](./careplan.html)
    - [Updating CarePlan and CareTeam](./careplan.html#updates)
    - [Getting data from CarePlan participants](./careplan.html#data-localization)
    - [Authorizing CarePlan participants](./careplan.html#authorization)
- [Tasks](./task.html)
    - [Basic Request workflow](./task.html#basic-request-workflow)
    - [Request workflow with additional response workflow](./task.html#request-response-workflow)
- [Care Services](./care-services.html)
- [Notifications](./notification.html)
- [Authorization](./authorization.html)

- Use Cases/Examples

    - [Enroll patient in home monitoring](./usecase-enrollment.html)
    - [Get data for home care](./usecase-view-all-data.html)
    - [Referral/Nursing handoff](./usecase-nursing-handoff.html)

- [Artifacts](./artifacts.html): a comprehensive list of all artifacts that are used in SCP 

- [Changes & Issues](history.html)


<!-- ### Glossary
- Personally Identifiable Information (PII) 
- Protected Health Information (PHI)
- FHIR
- HL7
- IHE -->


### Conformance Expectations

SCP uses the normative words: Shall, Should, and May according to standards conventions. 
SCP uses the HL7 FHIR standaard, version R4

> [!NOTE]
> It is recommended that readers have a foundational understanding of FHIR R4 to fully grasp the content presented in this document. 



<!-- add other conventions -->

### Download 

You can also download:

* [this entire guide](full-ig.zip),
* the definition resources in [json](definitions.json.zip), [xml](definitions.xml.zip), [ttl](definitions.ttl.zip), or [csv](csvs.zip) format, or
* the example resources in [json](examples.json.zip), [xml](examples.xml.zip) or [ttl](examples.ttl.zip) format.
