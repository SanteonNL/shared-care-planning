# Enroll patient in home monitoring (in the Netherlands)

<b>Register diagnosis, get informed consent for enrollment</b>

A cardiologist, Caroline van Dijk, from Hospital X diagnoses heart failure for patient Patrick Egger and explains about home monitoring with Zorg bij jou. Caroline gets informed consent from Patrick to enroll him for home monitoring at Zorg bij jou. Because Patrick gives informed consent for the enrollment, consent for the processing of the relevant data by Zorg bij jou can be implied (implied consent).

<b>Create order/request</b>

Caroline make an order (also called a (service-)request) for 'home monitoring' in the EHR and clicks on the 'share request'-button to enroll Patrick. 

<b>Create careplan</b>

A pop-up window appears. In this window, a CarePlan should be selected from a dropdown menu; for Patrick there are no known Careplans, therefore Caroline can only pick 'create new Careplan' from the dropdown menu. Basic information about Patrick, his name and BSN number, are shown in the window and a multi-select menu appears with all Conditions known for Patrick in the EHR. Caroline selects relevant conditions for the CarePlan from the list, in this case heart failure, COPD and Eczemia. She also indicates that heart failure is the one she is ordering home monitoring on. Zorg bij jou is the default party to perform home monitoring on heart failure and is auto-selected in a dropdown. She clicks 'Next'. 

<b>(Auto)fill Criteria</b>

The Careplan is created in a matter of seconds. The pop-up window now displays more checks/questions based on the selection of heart failure to perform home monitoring on with Zorg bij jou. Caroline checks with Patrick if all criteria for enrollment are met: he has a smartphone, he reads email from his smartphone, he can install apps on his smartphone, he is proficient in Dutch language and that he is in possession of scales and a blood pressure meter. Caroline clicks on checkbox 'validation of pre-requisites completed' and clicks 'Next' again. 

<b>(Auto)fill further information and complete request</b>

Within a matter of seconds the checks are evaluated by Zorg bij jou. Caroline has to do one final step and validates the auto-populated information in the form of a questionnaire required to complete the enrollment process. For the patient: name (Patrick Egger), gender (male), date of birth (12-7-1956) and contact information (phone-number 06-12345678 and e-mail address p.egger@gmail.com) is populated; and, requestor (Caroline van Dijk from Hospital X) details are populated. 

Caroline cliks on "Complete request" and the request is sent to Zorg bij jou including all the information provided. 

<b>Monitoring</b>

As all information is provided, Zorg bij jou automatically accepts the tasks and provides a direct task status update, so Caroline can see that the task is received and subsequently accepted. 

Caroline monitors the task in the EHR and sees that a few days later the status of the Task is updated to “in progress”, meaning that Patrick has downloaded and started to use the monitoring app.

## Identification
Patients, healthcare organizations and healthcare professionals are identified using nationwide logical identifiers that are specific to the Netherlands.
- Patients are identified using the identfier BSN ("BurgerServiceNummer");
- Healthcare Organizations are identified using the identfiier URA ("UZI-Register Abonneenummer");
- Healthcare professionals are preferably identified using the national identifier UZI ("Unieke Zorgverlener Identificatienummer"). For various reasons, the identifier UZI is not always available for all healthcare professionals. In these cases, healthcare professionals are identified using a local identifier (local employee number).

## Authentication
According to [Authentication](authentication.html), healthcare organizations and healthcare professionals are authenticated using Organization Credentials and PractitionerRole Credentials.
- The Organization Credential is implemented using the NutsUraCredential
- The PractitionerRole professionals is implemented using the NutsEmployeeCredential

### NutsUraCredential
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

### NutsEmployeeCredential
The `NutsEmployeeCredential` is specified in [this RFC](https://nuts-foundation.gitbook.io/drafts/rfc/rfc019-employee-identity-means).

## Hospital X: Find existing CarePlan for Patient

```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/CarePlan/?category=http://snomed.info/sct|135411000146103' \
--header 'Content-Type: application/json' \
--header 'Authorization: {% raw %}{{access-token}}{% endraw %}'
```

## Hospital X: Create Task 

assumption no CarePlan was found (so no Task.basedOn), create a Bundle with a new Task and a copy of the referred ServiceRequest and Condition:

```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/' \
--header 'Content-Type: application/json' \
--header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle1.json %}'
```

## MedicalServiceCentre: Create sub-Task with Questionnaire (enrollment criteria)

```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/' \
--header 'Content-Type: application/json' \
--header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle2.json %}'
```

## Hospital X: Update sub-Task with QuestionnaireResponse (enrollment criteria)

```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/' \
--header 'Content-Type: application/json' \
--header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle3.json %}'
```

## MedicalServiceCentre: Create sub-Task with Questionnaire (patient details)

//TO DO//

## Hospital X: Update sub-Task with QuestionnaireResponse (patient details)

//TO DO//

## MedicalServiceCentre: Update Task to accepted

```
curl --request PUT '{% raw %}{{cps-base-url}}{% endraw %}/Task' \
--header 'Content-Type: application/json' \
--header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Task-cps-task1-02.json %}'
```