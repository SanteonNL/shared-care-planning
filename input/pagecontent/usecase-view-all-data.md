### The user story

#### Home care nurse creates CarePlan/CareTeam and retrieves data

A home care nurse, Hilda House, is seeing a new client called: Cedric Collins. Hilda was told that Cedric was discharged from a hospital after surgery. Hilda decides to search for Cedric's data at the hospital and General Practitioner. She takes her tablet, logs in, opens Cedric's dossier and asks Cedric for the names of his GP and the hospital. In the 'care team' tab of the dossier, she adds/selects the GP and the hospital. Cedric's GP/Hospital-data is now showing up instantly in the, e.g., conditions, measurements and events sections of the dossier. If needed, Hilda can see what the original source of the data is.

> In the background, Hilda's EHR is performing a number of actions: 
> 1. The data endpoints of the care providers (GP & hospital) are looked up in the local provider directory
> 1. A 'simple' request is send to the GP and hospital; are you a care provider of Cedric?
>    1. The GP-system recognizes Cedric's ID, looks up if he is currently registered as a client and responds 'yes, I'm currently the GP of Cedric'  
>    1. The hospital-system recognizes Cedric's ID, looks up what activities were done or are planned and responds 'yes, we were an active care provider for the last 3 months'
> 1. A 'Shared CarePlan' (including the 2 requests) and a 'Shared CareTeam' (including Cedric, Hilda's home care organization, the GP and the hospital) are created.
> 1. As the GP/Hospital-systems have agreed/accepted the requests, these organizations are all member of the same CareTeam for Cedric. As an active members in the CareTeam, Hilda's EHR is authorized by the GP's system and the hospital to fetch Cedric's data.
> 1. Hilda's EHR displays the data of all care team members of Cedric  

#### GP using the CareTeam

After two weeks, Cedric doesn't feel well. He decides to consult his GP Dr. Gregory Greene. Dr. Gregory opens Cedric's dossier and reads his that left foot was amputated two weeks ago and he is now getting home care. At the hospital, Cedric was diagnosed with diabetes. From the last couple of home care notes, he reads Gregory keeps complaining about his right hand. 
Gregory is happy that all recent/relevant data is showing up in his system; he can now focus on the problem at hand; Cedric's right hand.... 


> In the background, Gregory's EHR is fetching data. It knows where to fetch the data because the request from Hilda was based on a Shared CarePlan. This CarePlan has a CareTeam with 4 members (Cedric, GP, hospital and home care). Gregory's EHR also got a notification of this specific CarePlan and CareTeam; it was used two weeks ago to authorize Hilda's request for data, but now it is used to locate the healthcare data of Cedric.


#### But what if....multiple overlapping CarePlans/CareTeams?

What if Hilda's EHR sends out the requests to the GP and hospital ('are you a care provider of Cedric?') and the hospital already has a Shared Care Plan for Cedric?  
In this (other/older) CarePlan, the hospital requested a medicalservicecentre to provide telemonitoring; this CareTeam consists of 3 members (Cedric, hospital and the medicalservicecentre). Read [Enroll patient in home monitoring](./usecase-enrollment.html) for more details.  

> In the background, The hospital system creates a request for Hilda to merge the CarePlans/CareTeams just after accepting Hilda's original request.

 Now, Hilda gets a request/alert on her worklist/inbox: 'Hospital X is a member of an existing CarePlan/CareTeam for Cedric, do you want to merge your CarePlan into the existing CarePlan/CareTeam?' She reviews the other/older CarePlan and CareTeam. After consulting Cedric, she decides that the CarePlans and CareTeams should be merged; she approves the request. This enables her and the medicalservicecentre to cooperate with each other and view Cedric's data; both parties interact with Cedric on a weekly basis.
 
 > In the background, the CarePlanService of the other/older CarePlan/CareTeam adds the data of the new CarePlan/CareTeam and copies associated Tasks and other data. The Hospital system also requests to Hilda's system to de-active the (now obsolete) CarePlan. Hilda's system accepts and de-activates the (+/- 5 minutes old) CarePlan

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

### Transactions

#### Brams magic here