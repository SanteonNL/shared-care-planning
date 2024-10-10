### The user story

#### Community nurse creates CarePlan/CareTeam and retrieves data

A Community nurse, Hilda House, is seeing a new client called: Cedric Collins. Hilda was told that Cedric was discharged from a hospital after surgery. Hilda decides to search for Cedric's data at the hospital and General Practitioner. She takes her tablet, logs in, opens Cedric's dossier and asks Cedric for the names of his GP and the hospital and if he wants to share the GP/hospital data with her. In the 'care team' tab of the dossier, she adds/selects 'GP Dr. Greene' and 'Hospital X'. Just after this action, the GP-system responds with (small) questionnaire: "To add GP Dr. Greene to your client's care team, please provide the 6-digit number that was send to your client via sms/email" Cedric takes his phone and gives Hilda the 6-digit number. Cedric's GP/Hospital-data is now showing up in the appropriate sections of the dossier. If needed, Hilda can see what the original source of the data is.

> In the background, Hilda's EHR is performing a number of actions: 
> 1. The service endpoints of the care providers (GP & hospital) are looked up in the local provider directory
> 1. A 'simple' request is send to the GP; are you a care provider of Cedric?
>    1. The GP-system recognizes Cedric's ID, looks up if he is currently registered as a client. 
>    1. In order to check if Cedric consents to share the GP-data with the home care organization, an sms with a code is send to the phonenumber of Cedric and a (sub-) Task/Questionnaire is send Hilda's EHR to fill in that same code
>    1. Hilda's EHR shows a questionnaire that requests the code that was send to Cedric.
>    1. As soon as the code is return by Cedric/Hilda, the GP-system checks if the code is correct.
>    1. The code is correct; the GP-system accepts the first request "are you a care provider of Cedric?" 
> 1. A 'simple' request is send to the hospital; are you a care provider of Cedric?   
>    1. The hospital-system recognizes Cedric's ID, looks up what activities were done or are planned and checks an external consent-registry. 
>    1. the hospital-system accepts the first request "are you a care provider of Cedric?"
> 1. A 'Shared CarePlan' (including the 2 requests) and a 'Shared CareTeam' (including Cedric, Hilda's home care organization, the GP and the hospital) are created.
> 1. As the GP/Hospital-systems have agreed/accepted the requests, these organizations are all member of the same CareTeam for Cedric. As an active members in the CareTeam, Hilda's EHR is authorized by the GP's system and the hospital to fetch Cedric's data.
> 1. Hilda's EHR displays the data of all care team members of Cedric  

#### GP using the CareTeam

After two weeks, Cedric doesn't feel well. He decides to consult his GP Dr. Gregory Greene. Dr. Gregory opens Cedric's dossier and reads his that left foot was amputated three weeks ago and he is now getting home care. At the hospital, Cedric was diagnosed with diabetes. From the last couple of home care notes, he reads that Cedric keeps complaining about his right hand. 
Gregory is happy that all recent/relevant data is showing up in his system; he can now focus on the problem at hand; Cedric's right hand.... 


> In the background, Gregory's EHR is fetching data. It knows where to fetch the data because the request from Hilda was based on a Shared CarePlan. This CarePlan has a CareTeam with 4 members (Cedric, GP, hospital and home care). Gregory's EHR also got a notification of this specific CarePlan and CareTeam; it was used two weeks ago to authorize Hilda's request for data, but now it is used to locate the healthcare data of Cedric at the home care organization and the hospital.


#### But what if....multiple overlapping CarePlans/CareTeams?

Imagine that the hospital requested a medicalservicecentre last year to provide telemonitoring. That resulted in a CarePlan and a CareTeam consisting of 3 members (Cedric, hospital and the medicalservicecentre). Read [Enroll patient in home monitoring](./usecase-enrollment.html) for more details on this example.  
Now Hilda's EHR sends out the requests to the GP and the hospital ('are you a care provider of Cedric?') like in the first paragraph. The hospital is already a member of a Care Team for Cedric. Should these CareTeams be merged? Or should they remain separate?  In the hospital, a request is created to merge both CarePlans/CareTeams. This request is evaluated/approved by a coordinating nurse Caroline van Dijk before it is send to Hilda. As the hospital and Caroline are member of both CarePlans/CareTeams, she can determine if it would make sense to merge.

> In the background, The hospital system creates a draft request which can be 'approved' by coordinating nurse Caroline van Dijk. After approval, this request is send to Hilda's EHR.

 Now, Hilda gets a request/alert on her worklist/inbox: 'Hospital X is a member of an existing CarePlan/CareTeam for Cedric. Do you want to merge your CareTeam with the existing CareTeam?' She reviews the other/older CarePlan and CareTeam. After consulting Cedric, she decides that the CarePlans and CareTeams should be merged; she approves the request. This enables her and the medicalservicecentre to cooperate with each other and view Cedric's data; both parties interact with Cedric on a weekly basis.
 
 > In the background, the CarePlanService of the other/older CarePlan/CareTeam adds the data of the new CarePlan/CareTeam and copies associated Tasks and other data. The Hospital system also requests to Hilda's system to de-active the (now obsolete) CarePlan. Hilda's system accepts and de-activates the CarePlan

<!-- 
### Data set definition

The data set that is relevant for the combination of the condition Heart Failure and the Request type "Telemonitoring" is defined as follows:

Franks magic here. I think a table that lists all expected FHIR queries
Sometghing like

|Description|HTTP request to be sent by MSC to data holder|HTTP request to be executed internally by data holder|
|-----------|----------|-----------|
|Patient details|GET Patient| GET Patient/?identifier=http://fhir.nl/fhir/NamingSystem/bsn|[BSN from CarePlan]|
|Condition|GET Condition| GET Condition/?xxxx=yyyyy|
|Medication|GET MedicationStatement| GET MedicationStatement/?xxxx=yyyyy|
|...|...|...| -->



### Authentication

#### Home monitoring nurse

NutsEmployeeCredential. Elements of credentials are filled based on attributes that are available in user session of medisch service center software.

#### Medical Service Center

NutsUraCredential.


### Authorization

#### Policy

##### Rules
- generic Care Plan Contributor Policy applies: [link](https://santeonnl.github.io/shared-care-planning/security-authorization.html#access-to-resources-of-which-the-care-plan-contributor-is-data-holder)
- no filtering on request/activity type
- no filtering on condition

##### Required VC's/VP's for access token request
NutsUraCredential
NutsEmployeeCredential

##### Search narrowing
search narrowing has to be performed by data holder according to table.

### Transactions 'Community nurse creates CarePlan/CareTeam and retrieves data'

<div>
{% include usecase-view-all-data.svg %}
</div>

Step 2: Care@Home: Find existing 'Shared' CarePlan for Patient
- [cUrl GET CarePlan from cps-base-url](cUrl-GET-CarePlan-from-cps-base-url.txt)


Step 3: Care@Home: Create Task 
assumption no CarePlan was found (so no Task.basedOn), create a Bundle with a new Task and a copy of the referred ServiceRequest and Condition:
- [cUrl POST Bundle-cps-bundle-01 to cps-base-url](cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt), payload: [Bundle-cps-bundle-01](Bundle-cps-bundle-01.json)

Step 4-infinite: WIP


### Transactions 'GP using the CareTeam'

<div>
{% include usecase-view-all-data-gp.svg %}
</div>

Step 1-infinite: WIP

### Transactions 'But what if....multiple overlapping CarePlans/CareTeams?'

<div>
{% include usecase-view-all-data-merge.svg %}
</div>

Step 1-infinite: WIP