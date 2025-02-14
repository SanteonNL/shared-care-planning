### Summary of IHE Dynamic Care Planning


### Care Planning in Shared Care Planning


The FHIR CarePlan resource is a framework for documenting and managing healthcare interventions and goals. It ensures that all relevant information is available to all stakeholders, promoting coordinated and effective care delivery. Key elements of a CarePlan for SCP:
- **subject**: The patient to whom the care plan is intended.
- **addresses**: Conditions/problems/concerns/diagnoses that this plan is addressing.
- **activity**: References to SCP-Tasks. Details of the planned interventions, including scheduled activities, performed activities, and their outcomes.
- **careTeam**: All the individuals and organizations who are expected to be involved in the care plan’s execution. As a CarePlan and a CareTeam always exist in a 1-on-1 relation, the CareTeam-instance is contained in the CarePlan.
- **author**: The person or organization that authored the care plan and is responsible for the CarePlan.
- **supportingInfo**: Additional (relevant) information to support the care plan, such as diagnostic reports, procedures, family member history, observations, etc.
- **goal**: The intended outcomes or objectives of the care plan. 

For SCP, CarePlan will be validated using [this profile](TODO). For more information, check the [FHIR R4 CarePlan documentation](https://hl7.org/fhir/R4/careplan.html)


#### Transaction - 

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


#### Authorization
Authorization; based on conditions, task-type, careteam-member-status (active/inactive) and/or role
Member(-status) in the CareTeam are only updated by the CPS after 'agreement' on a Task in the CarePlan. 