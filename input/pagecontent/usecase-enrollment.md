# Enroll patient in home monitoring (in the Netherlands)

### The user story

#### Register diagnosis, get informed consent

A cardiologist, Caroline van Dijk, from Hospital X diagnoses heart failure for patient Patrick Egger and explains about home monitoring at 'Medical service centre' (MSC). Caroline gets informed consent from Patrick to enroll him for home monitoring at MSC. Because Patrick gives informed consent for the enrollment, consent for the processing of the relevant data by MSC can be implied (implied consent).

#### Create order/ Service-request

Caroline makes a (service-)request for 'home monitoring' in the EHR. The diagnosis heart failure is linked to the request for context. Caroline clicks on the 'share request'-button to enroll Patrick. 

#### Search for multidisciplinary careplan

A pop-up window appears. In this window, an existing multidisciplinary CarePlan could be selected from a dropdown menu. However, for Patrick there are no known Careplans, therefore Caroline can only pick 'create new Careplan' from the dropdown menu. 

#### (Auto)fill criteria

The pop-up window now displays questions to determine if the patient is eligible for telemonitoring treatment at MSC. Caroline checks with Patrick if: he has a smartphone, he reads email from his smartphone, he can install apps on his smartphone, he is proficient in Dutch language and that he is in possession of scales and a blood pressure meter. Caroline submits the answers.

> In the background, the MSC checks the answers. If Patrick wouldn't be eligible for telemonitoring at the MSC, the request would be rejected here.

#### Contact information (PII)

The pop-up window now displays questions for basic contact information on patient Patrick and cardiologist Caroline (e.g. name, telephone number and email address). This information has been auto-populated from the EHR. Caroline just has to check and submit.

> In the background, the MSC checks the answers for completeness. The MSC automatically accepts the request and sends the patient an invite for a monitoring app.

#### Request accepted

The pop-up windows now responds that the MSC has accepted the request and has invited the patient to download a monitoring app. The telemonitoring request has been successfully assigned.

#### Monitoring

Caroline monitors the (shared) request in the EHR and sees that a few days later the status is updated to “in progress”, meaning that Patrick has downloaded and started to use the monitoring app.

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
1. Please read the file and execute the ngrok commands first: [docker-compose-nuts-nodes.sh](docker-compose-nuts-nodes.sh)
2. [cUrl-POST-Nuts-hospitalx-create-did-vc](cUrl-POST-Nuts-hospitalx-create-did-vc.sh)

#### Preparation: populating existing data at Hospital X and MedicalServiceCentre 
1. [cUrl POST Bundle-hospitalx-bundle-01 to cpc1-base-url](cUrl-POST-Bundle-hospitalx-bundle-01-to-cpc1-base-url.txt), payload: [Bundle-hospitalx-bundle-01](Bundle-hospitalx-bundle-01.json)
1. [cUrl POST Bundle-msc-bundle-01 to cpc2-base-url](cUrl-POST-Bundle-msc-bundle-01-to-cpc2-base-url.txt), payload: [Bundle-msc-bundle-01](Bundle-msc-bundle-01.json)


#### Hospital X: Find existing 'Shared' CarePlan for Patient
1. [cUrl GET CarePlan from cps-base-url](cUrl-GET-CarePlan-from-cps-base-url.txt)


#### Hospital X: Create Task 
assumption no CarePlan was found (so no Task.basedOn), create a Bundle with a new Task and a copy of the referred ServiceRequest and Condition:
1. [cUrl POST Bundle-cps-bundle-01 to cps-base-url](cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt), payload: [Bundle-cps-bundle-01](Bundle-cps-bundle-01.json)


#### CarePlanService: Create subscriptions, careplan, careteam and notifications
1. [cUrl POST Subscription-cps-sub-medicalservicecentre to cps-base-url](cUrl-POST-Subscription-cps-sub-medicalservicecentre-to-cps-base-url.txt), payload: [Subscription-cps-sub-medicalservicecentre](Subscription-cps-sub-medicalservicecentre.json)
1. [cUrl POST Subscription-cps-sub-hospitalx to cps-base-url](cUrl-POST-Subscription-cps-sub-hospitalx-to-cps-base-url.txt), payload: [Subscription-cps-sub-hospitalx](Subscription-cps-sub-hospitalx.json)
1. [cUrl POST Bundle-notification-msc-01 to cps-base-url](cUrl-POST-Bundle-notification-msc-01-to-cps-base-url.txt), payload: [Bundle-notification-msc-01](Bundle-notification-msc-01.json)
1. [cUrl POST CareTeam-cps-careteam-01 to cps-base-url](cUrl-POST-CareTeam-cps-careteam-01-to-cps-base-url.txt), payload: [CareTeam-cps-careteam-01](CareTeam-cps-careteam-01.json)
1. [cUrl POST CarePlan-cps-careplan-01 to cps-base-url](cUrl-POST-CarePlan-cps-careplan-01-to-cps-base-url.txt), payload: [CarePlan-cps-careplan-01](CarePlan-cps-careplan-01.json)
1. [cUrl POST Bundle-notification-hospitalx-01 to cps-base-url](cUrl-POST-Bundle-notification-hospitalx-01-to-cps-base-url.txt), payload: [Bundle-notification-hospitalx-01](Bundle-notification-hospitalx-01.json)



#### MedicalServiceCentre: Get Task, Create sub-Task with Questionnaire (enrollment criteria)

get the Task and referenced data
1. [cUrl GET Task from cps-base-url](cUrl-GET-cps-task-01-from-cps-base-url.txt)
1. [cUrl GET ServiceRequest from cps-base-url](cUrl-GET-cps-servicerequest-telemonitoring-from-cps-base-url.txt)
1. [cUrl GET Condition from cps-base-url](cUrl-GET-cps-heartfailure-from-cps-base-url.txt)

post bundle with new (sub-) task that contains a questionnaire
1. [cUrl POST Bundle-cps-bundle-02 to cps-base-url](cUrl-POST-Bundle-cps-bundle-02-to-cps-base-url.txt), payload: [Bundle-cps-bundle-02](Bundle-cps-bundle-02.json)


#### CarePlanService: notify hospital X
1. [cUrl POST Bundle-notification-hospitalx-02 to cps-base-url](cUrl-POST-Bundle-notification-hospitalx-02-to-cps-base-url.txt), payload: [Bundle-notification-hospitalx-02](Bundle-notification-hospitalx-02.json)


#### Hospital X: Get sub-task, Update sub-Task with QuestionnaireResponse (enrollment criteria)
get sub-task and questionnaire
1. [cUrl GET Task from cps-base-url](cUrl-GET-cps-task-02-from-cps-base-url.txt)
1. [cUrl GET Questionnaire from cps-base-url](cUrl-GET-cps-questionnaire-telemonitoring-enrollment-criteria-from-cps-base-url.txt)

fill in QuestionnaireResponse and update the (sub-)Task
1. [cUrl POST Bundle-cps-bundle-03 to cps-base-url](cUrl-POST-Bundle-cps-bundle-03-to-cps-base-url.txt), payload: [Bundle-cps-bundle-03](Bundle-cps-bundle-03.json)


#### CarePlanService: notify medicalservicecentre
1. [cUrl POST Bundle-notification-msc-02 to cps-base-url](cUrl-POST-Bundle-notification-msc-02-to-cps-base-url.txt), payload: [Bundle-notification-msc-02](Bundle-notification-msc-02.json)



#### MedicalServiceCentre: Create sub-Task with Questionnaire (patient/practitioner details)
post bundle with new (sub-) task that contains a questionnaire
1. [cUrl POST Bundle-cps-bundle-04 to cps-base-url](cUrl-POST-Bundle-cps-bundle-04-to-cps-base-url.txt), payload: [Bundle-cps-bundle-04](Bundle-cps-bundle-04.json)



#### CarePlanService: notify hospital X
1. [cUrl POST Bundle-notification-hospitalx-03 to cps-base-url](cUrl-POST-Bundle-notification-hospitalx-03-to-cps-base-url.txt), payload: [Bundle-notification-hospitalx-03](Bundle-notification-hospitalx-03.json)


#### Hospital X: Update sub-Task with QuestionnaireResponse (patient/practitioner details)
get sub-task and questionnaire

1. [cUrl GET Task from cps-base-url](cUrl-GET-cps-task-03-from-cps-base-url.txt)
1. [cUrl GET Questionnaire patient details from cps-base-url](cUrl-GET-cps-questionnaire-patient-details-from-cps-base-url.txt)
1. [cUrl GET Questionnaire practitioner details from cps-base-url](cUrl-GET-cps-questionnaire-practitioner-details-from-cps-base-url.txt)
fill in QuestionnaireResponse and update the (sub-)Task

1. [cUrl POST Bundle-cps-bundle-05 to cps-base-url](cUrl-POST-Bundle-cps-bundle-05-to-cps-base-url.txt), payload: [Bundle-cps-bundle-05](Bundle-cps-bundle-05.json)

#### CarePlanService: notify medicalservicecentre
1. [cUrl POST Bundle-notification-msc-03 to cps-base-url](cUrl-POST-Bundle-notification-msc-03-to-cps-base-url.txt), payload: [Bundle-notification-msc-03](Bundle-notification-msc-03.json)


#### MedicalServiceCentre: Update Task to accepted
1. [cUrl GET Task from cps-base-url](cUrl-GET-cps-task-01-from-cps-base-url.txt)
1. [cUrl POST Bundle-cps-bundle-06 to cps-base-url](cUrl-POST-Bundle-cps-bundle-06-to-cps-base-url.txt), payload: [Bundle-cps-bundle-06](Bundle-cps-bundle-06.json)



#### CarePlanService: update CareTeam and CarePlan, notify CareTeam participants

1. [cUrl GET CarePlan from cps-base-url](cUrl-GET-cps-careplan-01-from-cps-base-url.txt)
1. [cUrl GET CareTeam from cps-base-url](cUrl-GET-cps-careteam-01-from-cps-base-url.txt)
1. [cUrl POST Bundle-cps-bundle-07 to cps-base-url](cUrl-POST-Bundle-cps-bundle-07-to-cps-base-url.txt), payload: [Bundle-cps-bundle-07](Bundle-cps-bundle-07.json)
1. [cUrl POST Bundle-notification-hospitalx-11 to cps-base-url](cUrl-POST-Bundle-notification-hospitalx-11-to-cps-base-url.txt), payload: [Bundle-notification-hospitalx-11](Bundle-notification-hospitalx-11.json)
1. [cUrl POST Bundle-notification-msc-11 to cps-base-url](cUrl-POST-Bundle-notification-msc-11-to-cps-base-url.txt), payload: [Bundle-notification-msc-11](Bundle-notification-msc-11.json)
