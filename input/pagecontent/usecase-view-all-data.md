# Get data for home monitoring (in the Netherlands)

### The user story

This user story takes place after the user story [enrollment for homemonitroing (NL)](usecase-enrollment.html) has taken place. 

#### Monitoring

A home monitoring nurse, <<Hilda House>>, from Medical Service Center MSC is monitoring patient Patrick Egger in the context of his condition Heart Failure (see user story [enrollment for homemonitroing (NL)](usecase-enrollment.html). During the monitoring phase, the hospital X had also added the General Practitioner GP to the multidisciplinbairy careplan that handles Patrick Eggers Heart Failure Condition.

#### Incoming alert/flag

Hilda House receives an alert in her software about an incoming meaurement/ observation that requires her attention.

#### open record

Hilda opens the record of Patrick Egger in her software.

> In the background, the MSC software uses the bsn of Patrick Egger to retrieve the organizations that participate in Patrick Eggers Heart Failure Condition and then fetches the relevant data from these organizations.

#### display local and remote data

The software displays the data about Patrick that is relevant for his condition Heart Failure. On the screen data that is stored in systems of the MSC and data that is stored in the hospital and other participants is displayed in an integrated manner. Hilda can easily view the data holder organization of each individual data element.

### Data set definition

The data set that is relevant for the combination of the condition Heart Failure and the Request type "Telemonitoring" is defined as follows:

Franks magic here. I think a table that lists all expected FHIR queries
Sometghing like

|Description|HTTP request to be sent by MSC to data holder|HTTP request to be executed internally by data holder|
|-----------|----------|-----------|
|Patient details|GET Patient| GET Patient/?identifier=http://fhir.nl/fhir/NamingSystem/bsn|[BSN from CarePlan]|
|Condition|GET Condition| GET Condition/?xxxx=yyyyy|
|Medication|GET MedicationStatement| GET MedicationStatement/?xxxx=yyyyy|
|...|...|...|

### Authorization

#### Policy

##### Rules
- generic Care Plan Contributor Policy applies: [link](https://santeonnl.github.io/shared-care-planning/security-authorization.html#access-to-resources-of-which-the-care-plan-contributor-is-data-holder)
- no filtering on organization type
- no filtering on practitioner role

##### Required VC's/VP's for access token request
NutsUraCredential
NutsEmployeeCredential

##### Search narrowing
search narrowing has to be performed by data holder according to table.



### Authentication

#### Home monitoring nurse

NutsEmployeeCredential. Elements of credentials are filled based on attributes that are available in user session of medisch service center software.

#### Medical Service Center

NutsUraCredential.

### Service Discovery

necessary? how does MSC know what organization acts as CPS?

### Data Localization

On behalf of the logged in user, the MSC software, fetches the CarePlan (bsn = Patrick Egger, snomed = multidisc careplan).
What information is specific to zorginzage here? Most of it just the same as in transaction "Getting data from CareTeam members"

### Transactions

#### Brams magic here