### The user story

#### Register diagnosis, get informed consent

A cardiologist, Caroline van Dijk, from Hospital X diagnoses heart failure for patient Patrick Egger and explains about home monitoring at 'Medical service centre' (MSC). Caroline gets informed consent from Patrick to enroll him for home monitoring at MSC. Because Patrick gives informed consent for the enrollment, consent for the processing of the relevant data by MSC can be implied (implied consent).

#### Create order/ Service-request

Caroline makes a (service-)request for 'home monitoring' in the EHR. The diagnosis heart failure is linked to the request for context. Caroline clicks on the 'share request'-button to enroll Patrick. 

#### Search for multidisciplinary careplan

A pop-up window appears. In this window, an existing multidisciplinary CarePlan could be selected from a dropdown menu. However, for Patrick there are no known Careplans, therefore Caroline can only pick 'create new Careplan' from the dropdown menu. 

> In the background, the MSC receives the request and determines if there are enough resources available to execute the request. As Patrick (his Dutch-citizen-id) is unknown to the MSC, the MSC responds with a questionnaire. If the MSC wouldn't be able to execute te request, it would be rejected here.

#### (Auto)fill criteria

The pop-up window now displays questions to determine if the patient is eligible for telemonitoring treatment at MSC. Caroline checks with Patrick if: he has a smartphone, he reads email from his smartphone, he can install apps on his smartphone, he is proficient in Dutch language and that he is in possession of scales and a blood pressure meter. Caroline submits the answers.

> In the background, the MSC checks the answers and accepts the Task. If Patrick wouldn't be eligible for telemonitoring at the MSC, the request would be rejected here. However, the MSC wants to send out an activation-email to Patrick. This is not possible without email-address. The MSC sends a new questionnaire to get the contact details.

#### Contact information (PII)

The pop-up window now displays questions for basic contact information on patient Patrick and cardiologist Caroline (e.g. name, telephone number and email address). This information has been auto-populated from the EHR. Caroline just has to check and submit.

> In the background, the MSC checks the answers for completeness. The MSC updates the Task-status to 'in-progress' and automatically sends the patient an invite for a monitoring app.

#### Request accepted

The pop-up windows now responds that the MSC has started working on the request. The telemonitoring request has been successfully assigned.


### Identification
Patients, healthcare organizations and healthcare professionals are identified using nationwide logical identifiers that are specific to the Netherlands.
- Patients are identified using the identfier BSN ("BurgerServiceNummer");
- Healthcare Organizations are identified using the identfiier URA ("UZI-Register Abonneenummer");
- Healthcare professionals are preferably identified using the national identifier UZI ("Unieke Zorgverlener Identificatienummer"). For various reasons, the identifier UZI is not always available for all healthcare professionals. In these cases, healthcare professionals are identified using a local identifier (local employee number).

### Authentication
According to [Authentication](authentication.html), healthcare organizations and healthcare professionals are authenticated using Organization Credentials and PractitionerRole Credentials.
- The Organization Credential is implemented using the NutsUraCredential
- The PractitionerRole professionals is implemented using the NutsEmployeeCredential

#### NutsUraCredential
The `NutsUraCredential` ([JSON-LD context](https://nuts.nl/credentials/2024)) is a Verifiable Credential that contains the following properties:
- URA number: a unique identifier for healthcare organizations in the Netherlands.
- Name: the name of the organization.
- City: locality of the organization.

The credential is to be issued by a party trusted in the particular SCP use case, as currently, there's no governing body that issues it.
It can be represented in both JWT and JSON-LD format. The JSON-LD version of the credential can look as follows:

```json
{
  "@context": [
    "https://www.w3.org/2018/credentials/v1",
    "https://nuts.nl/credentials/2024"
  ],
  "id": "did:web:ministryofhealth.example.com:issuer#1",
  "type": ["VerifiableCredential", "NutsUraCredential"],
  "issuer": "did:web:example.com:issuer#1",
  "issuanceDate": "2024-01-01T00:00:00Z",
  "expirationDate": "2025-01-01T00:00:00Z",
  "credentialSubject": {
    "id": "did:web:hospital.example.com:holder#1",
    "organization": {
      "ura": "3732",
      "name": "Example Hospital",
      "city": "Amsterdam"
    }
  }
}
```

This then translates to the following Organization resource:

```json
{
  "resourceType": "Organization",
  "identifier": [
    {
      "system": "http://fhir.nl/fhir/NamingSystem/ura",
      "value": "3732"
    }
  ],
  "name": "Example Hospital",
  "address": [
    {
      "city": "Amsterdam"
    }
  ]
}
```

This Organization resource can then be used for authorizing access to SCP services.

#### NutsEmployeeCredential
The `NutsEmployeeCredential` is specified in [this RFC](https://nuts-foundation.gitbook.io/drafts/rfc/rfc019-employee-identity-means).

### Transactions

#### Preparation: did and VCs
- Please read the file and execute the ngrok commands first: [docker-compose-nuts-nodes.sh](docker-compose-nuts-nodes.sh)
- [cUrl-POST-Nuts-create-did-and-vcs.sh](cUrl-POST-Nuts-create-did-and-vcs.sh)

#### Get the access_tokens
- [cUrl-POST-Nuts-access_tokens.sh](cUrl-POST-Nuts-access_tokens.sh)

#### Preparation: populating existing data at Hospital X and MedicalServiceCentre
- [cUrl POST Bundle-hospitalx-bundle-01 to cpc1-fhir-url](cUrl-POST-Bundle-hospitalx-bundle-01-to-cpc1-fhir-url.txt), payload: [Bundle-hospitalx-bundle-01](Bundle-hospitalx-bundle-01.json)
- [cUrl POST Bundle-msc-bundle-01 to cpc2-fhir-url](cUrl-POST-Bundle-msc-bundle-01-to-cpc2-fhir-url.txt), payload: [Bundle-msc-bundle-01](Bundle-msc-bundle-01.json)

<div>
{% include usecase-enrollment.svg %}
</div>

   
Step 2: Hospital X: Find existing 'Shared' CarePlan for Patient
- [cUrl GET CarePlan from org1-fhir-url](cUrl-GET-CarePlan-from-org1-fhir-url.txt)


Step 3: Hospital X: Create Task 
assumption no CarePlan was found (so no Task.basedOn), create a Bundle with a new Task and a copy of the referred ServiceRequest and Condition:
- [cUrl POST Bundle-cps-bundle-01 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-01-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-01](Bundle-cps-bundle-01.json)


Step 4: CarePlanService: Create subscriptions, careplan, careteam and notifications
    
- [cUrl POST Subscription-cps-sub-medicalservicecentre to org1-fhir-url](cUrl-POST-Subscription-cps-sub-medicalservicecentre-to-org1-fhir-url.txt), payload: [Subscription-cps-sub-medicalservicecentre](Subscription-cps-sub-medicalservicecentre.json)
- [cUrl POST Subscription-cps-sub-hospitalx to org1-fhir-url](cUrl-POST-Subscription-cps-sub-hospitalx-to-org1-fhir-url.txt), payload: [Subscription-cps-sub-hospitalx](Subscription-cps-sub-hospitalx.json)
- [cUrl POST CareTeam-cps-careteam-01 to org1-fhir-url](cUrl-POST-CareTeam-cps-careteam-01-to-org1-fhir-url.txt), payload: [CareTeam-cps-careteam-01](CareTeam-cps-careteam-01.json)
- [cUrl POST CarePlan-cps-careplan-01 to org1-fhir-url](cUrl-POST-CarePlan-cps-careplan-01-to-org1-fhir-url.txt), payload: [CarePlan-cps-careplan-01](CarePlan-cps-careplan-01.json)

Step 5: CarePlanService: notify hospital X

- [cUrl POST Bundle-notification-hospitalx-01 to org1-fhir-url](cUrl-POST-Bundle-notification-hospitalx-01-to-org1-fhir-url.txt), payload: [Bundle-notification-hospitalx-01](Bundle-notification-hospitalx-01.json)

Step 6: CarePlanService: notify medicalservicecentre
- [cUrl POST Bundle-notification-msc-01 to org1-fhir-url](cUrl-POST-Bundle-notification-msc-01-to-org1-fhir-url.txt), payload: [Bundle-notification-msc-01](Bundle-notification-msc-01.json)



Step 20: MedicalServiceCentre: Get Task, Create sub-Task with Questionnaire (enrollment criteria)

get the Task and referenced data
- [cUrl GET Task from org1-fhir-url](cUrl-GET-cps-task-01-from-org1-fhir-url.txt)
- [cUrl GET ServiceRequest from org1-fhir-url](cUrl-GET-cps-servicerequest-telemonitoring-from-org1-fhir-url.txt)
- [cUrl GET Condition from org1-fhir-url](cUrl-GET-cps-heartfailure-from-org1-fhir-url.txt)

Step 22: post bundle with new (sub-) task that contains a questionnaire
- [cUrl POST Bundle-cps-bundle-02 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-02-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-02](Bundle-cps-bundle-02.json)


Step 23: CarePlanService: notify hospital X
- [cUrl POST Bundle-notification-hospitalx-02 to org1-fhir-url](cUrl-POST-Bundle-notification-hospitalx-02-to-org1-fhir-url.txt), payload: [Bundle-notification-hospitalx-02](Bundle-notification-hospitalx-02.json)


Step 24: Hospital X: Get sub-task, Update sub-Task with QuestionnaireResponse (enrollment criteria)
get sub-task and questionnaire

- [cUrl GET Task from org1-fhir-url](cUrl-GET-cps-task-02-from-org1-fhir-url.txt)
- [cUrl GET Questionnaire from org1-fhir-url](cUrl-GET-cps-questionnaire-telemonitoring-enrollment-criteria-from-org1-fhir-url.txt)

Step 26: fill in QuestionnaireResponse and update the (sub-)Task
- [cUrl POST Bundle-cps-bundle-03 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-03-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-03](Bundle-cps-bundle-03.json)


Step 27:  CarePlanService: notify medicalservicecentre
- [cUrl POST Bundle-notification-msc-02 to org1-fhir-url](cUrl-POST-Bundle-notification-msc-02-to-org1-fhir-url.txt), payload: [Bundle-notification-msc-02](Bundle-notification-msc-02.json)



Step 42:  MedicalServiceCentre: Task accepted & Create sub-Task with Questionnaire (patient/practitioner details)

post bundle with new (sub-) task that contains a questionnaire  

- [cUrl GET Task from org1-fhir-url](cUrl-GET-cps-task-01-from-org1-fhir-url.txt)
- [cUrl POST Bundle-cps-bundle-04 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-04-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-04](Bundle-cps-bundle-04.json)

Step 43:  CarePlanService: update CarePlan/CareTeam, notify hospital X and medicalservicecentre
- [cUrl POST Bundle-cps-bundle-07 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-07-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-07](Bundle-cps-bundle-07.json)

Step 44: 
- [cUrl POST Bundle-notification-hospitalx-11 to org1-fhir-url](cUrl-POST-Bundle-notification-hospitalx-11-to-org1-fhir-url.txt), payload: [Bundle-notification-hospitalx-11](Bundle-notification-hospitalx-11.json)

Step 45: 
- [cUrl POST Bundle-notification-msc-11 to org1-fhir-url](cUrl-POST-Bundle-notification-msc-11-to-org1-fhir-url.txt), payload: [Bundle-notification-msc-11](Bundle-notification-msc-11.json)


Step 48:  Hospital X: Update sub-Task with QuestionnaireResponse (patient/practitioner details)
get sub-task and questionnaire

- [cUrl GET Task from org1-fhir-url](cUrl-GET-cps-task-03-from-org1-fhir-url.txt)
- [cUrl GET Questionnaire patient details from org1-fhir-url](cUrl-GET-cps-questionnaire-patient-details-from-org1-fhir-url.txt)
- [cUrl GET Questionnaire practitioner details from org1-fhir-url](cUrl-GET-cps-questionnaire-practitioner-details-from-org1-fhir-url.txt)

fill in QuestionnaireResponse and update the (sub-)Task
- [cUrl POST Bundle-cps-bundle-05 to org1-fhir-url](cUrl-POST-Bundle-cps-bundle-05-to-org1-fhir-url.txt), payload: [Bundle-cps-bundle-05](Bundle-cps-bundle-05.json)

Step 49:  CarePlanService: notify medicalservicecentre
- [cUrl POST Bundle-notification-msc-03 to org1-fhir-url](cUrl-POST-Bundle-notification-msc-03-to-org1-fhir-url.txt), payload: [Bundle-notification-msc-03](Bundle-notification-msc-03.json)