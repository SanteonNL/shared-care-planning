### Summary of workflow in FHIR core specification
The FHIR R4 Workflow Module provides a standardized approach to managing processes and workflows within healthcare systems using FHIR standards. It defines a set of resources and operations to model, manage, and track workflow activities across various healthcare applications. This can be used for several use cases, to basically, 'ask for stuff' like:
- Here's a drug prescription/lab order
- Referrals
- Please fill out this form
- Please suspend this order
- Please discharge this patient
- Please call me

It defines resources across three categories:

- Definitions: Resources such as ActivityDefinition and PlanDefinition, which describe possible activities and how they should be performed.
- Requests: Resources like ServiceRequest, MedicationRequest or DeviceRequest that represent the medical authorization for an activity to occur. The existence of a "Request" instance doesn't necessarily imply that fulfillment will be requested immediately - or even ever. The decision to request fulfillment may be delegated to the patient or to down-stream practitioners. Such fulfilling practitioners may need to capture additional information prior to executing the fulfillment.
- Events: Resources such as Procedure, Observation and MedicationAdministration that capture what has been done in response to a request.

The FHIR Task resource is a special case. The Task resource in the Workflow module is designed to represent specific actions or work items that need to be completed within a healthcare workflow. It provides a way to track the status, progress, and outcomes of tasks and specify who is accountable for the task and what is expected. Given a request (e.g. ServiceRequest), multiple Tasks may be used for this request to seek a care provider that is able to fullfill the request. Given a request (e.g. MedicationRequest), multiple Tasks may be used for this request to actually administer a dosage of the medication at a given time or interval. A Task resource can handle dependencies between tasks. For instance, one task may need to be completed before another can begin. This ensures tasks are executed in the correct sequence.

FHIR Workflow Module descibes various communication patterns to implement a workflow. Depending on the requirements, this can range from simple to more advanced workflows. 

An example of a [simple workflow](https://hl7.org/fhir/R4/workflow-ad-hoc.html) would be to create a request (e.g. ServiceRequest or MedicationRequest) for a performer and tag it to be 'actionable'. It does not use a Task resource to manage the status of a request. This workflow pattern has the lowest amount of overhead, but also has limitations:
- Can only use when requesting fulfillment (can't use to request status change or other updates)
- No indication of agreement to act on the request
- There's no ability to negotiate fulfillment - no ability to say "no"
- The only way to stop fulfillment is to update the Request to have a 'cancelled' status
Another option would be to just use a Task resource without the 'request' resource. This is applicable for simple requests that do not require medical authorization. E.g. 'change this bed' or 'fill out this form'. 

More [advanced FHIR workflow patterns](https://hl7.org/fhir/R4/workflow-management.html) make use of a Task resource to enable negotiation and state-management for a specific request (e.g. ServiceRequest or MedicationRequest). It 'solves' the limitations of the simpler workflows, but it adds extra overhead and may add requirements for the healthcare systems of requester and performer.

### Workflow in Shared Care Planning

In Shared Care Planning, an advanced FHIR workflow pattern is used to cover all requirements for a generic workflow process between organizations. The process is based on [FHIR workflow pattern G](https://hl7.org/fhir/R4/workflow-management.html#optiong), but SCP nodes can also use pattern [F](https://hl7.org/fhir/R4/workflow-management.html#optionf) or [H](https://hl7.org/fhir/R4/workflow-management.html#optionh) depending on the capabilities of their healthcare systems. The main difference between these 3 patterns (F, G and H) is the location of the Task; it can be stored at the requester, performer or at a third party (broker). For example; if you'd want to create a Task at the performer, but their EHR does not support it, you may choose to create a Task at your own EHR and notify the performer (and thus following pattern [F](https://hl7.org/fhir/R4/workflow-management.html#optionf) in stead of [G](https://hl7.org/fhir/R4/workflow-management.html#optiong)). SCP uses [notifications](./notification.md) in between nodes to provide quick feedback/updates in initial phase of a Task (creation to acceptance/rejectance).

#### Task workflow Option G: Creation of Task on performer's system
<div>
{% include workflow-base-g.svg %}
</div>

#### Notification of stakeholders
If a SCP-Task is created/updated, participating organizations MUST be notified of this change. 

Stakeholders may have a ***role*** in the Task. For example, an external care provider department may be set as the Task.owner. The Organization or HealthcareService instance of this care provider department may exist locally (or at a Care Service Directory service), so to find the notification-endpoint of the care provider may involve searching/fetching the HealthcareService.endpoint, HealthcareService.managingOrganizations, Organization.partOf and/or Organization.endpoint

Stakeholders may also host instances that are ***referenced*** in the Task (e.g. an external CarePlan in Task.basedOn, an external ServiceRequest in Task.focus or an external Task in Task.partOf). The base-url in the literal reference may be used to find the notification-endpoint.


#### Task state and lifecycle
The Task status and state transitions are important part in the lifecycle of a Task.
The Task state machine for SCP is a subset of the [base FHIR Task state machine](https://hl7.org/fhir/R4/task.html#statemachine). In comparison to base FHIR Task state machine, the SCP-Task does not use status 'draft' or state 'ready', but does allows states-transition and from 'requested to completed: 

<img src="Task-state-machine.png" width="32%" style="float: none"/>

|State from|State to|Allow state transition for|
|-|-|-|
|-|requested|Task.requestor who is also CarePlan-participant|
|requested|received, accepted, rejected, cancelled, in-progress, completed, failed|Task.owner|
|received|accepted, rejected, cancelled, in-progress, completed, failed|Task.owner|
|accepted|cancelled, in-progress, completed, failed|Task.owner|
|in-progress|completed, failed, on-hold|Task.owner|
|on-hold|in-progress, completed, failed|Task.owner|
{:.grid .table-hover}

An SCP-Task can only be created by the requester. Tasks can only be updated by the owner/performer. However, some elements SHALL not be updated by the performer, depending on the Task.intent. This table indicates the elements a performer can ***update*** (immutability is the default):

| Mutable elements | notes |
|-|-|
| status | changing status to `requested` is prohibited|
| statusReason | - |
| businessstatus | - |
| executionPeriod| if intent = `order` and the status is updated to `received` or `accepted`, the executionPeriod should ***not*** be updated |
| lastModified | - |
| owner| the owner may be changed to an entity within current organization |
| location | - |
| note | - |
| relevantHistory| - |
| output | - |
{:.grid .table-hover}

To avoid losing data during updates, actors MUST support the directives in [FHIR transactional integrity](http://hl7.org/fhir/R4/http.html#transactional-integrity) and [FHIR concurrency](https://hl7.org/fhir/R4/http.html#concurrency)


#### Using planned Tasks
When a requester sets Task.intent to `plan`, it may use this to find the care organization that is able to perform the Task closest to the Patient or at the earliest date (by changing the executionPeriod). 
Multiple Tasks may be created in parallel for different care providers. For privacy reasons, the Patient instance (or non-relevant parts of the Patient instance) should not be shared with care providers in this phase.
Performers MUST respond real-time to allow the requester to select the best performer (based on location, executionPeriod or other data like cost and patient satisfaction ratings). A new Task SHALL be created with intent = `order`, status = `requested` and the selected performer to proceed with the usual acceptance/execution of the Task. 






<!-- 
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

#### State transitions

The Task has a state (requested, accepted, completed, etc.) and it refers to a focal resource (ServiceRequest, CommunicationRequest, MedicationRequest, Questionnaire, Consent, etc.). The focal resource contains the actual specification of what is requested, wheras the task manages metadata like requester, performer, state and if e.g. fulfilled or approval is desired by the requester.

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
|requested|in-progress|Task.owner|
|requested|completed|Task.owner|
|requested|cancelled|Task.requestor, Task.owner|
|received|accepted|Task.owner|
|received|rejected|Task.owner|
|received|in-progress|Task.owner|
|received|completed|Task.owner|
|received|cancelled|Task.requestor, Task.owner|
|accepted|in-progress|Task.owner|
|accepted|cancelled|Task.requestor, Task.owner|
|accepted|completed|Task.owner|
|in-progress|completed|Task.owner|
|in-progress|failed|Task.owner|
|in-progress|on-hold|Task.requestor, Task.owner|
|on-hold|in-progress|Task.requestor, Task.owner|

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

For more information on this transaction, see [Transactions - Request workflow with additional response workflow](./transaction-request-response-workflow.html) -->
