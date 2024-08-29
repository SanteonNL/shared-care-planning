# Enroll patient in home monitoring

<b>Diagnosis, informed consent, implied consent</b>

A cardiologist, Caroline van Dijk, from Hospital X diagnoses heart failure for patient Patrick Egger and explains about home monitoring with Zorg bij jou. Caroline gets informed consent from Patrick to enroll him for home monitoring at Zorg bij jou. Because Patrick gives informed consent for the enrollment, consent for the processing of the relevant data by Zorg bij jou can be implied (implied consent).

<b>Order/ Service-request</b>

Caroline make a (service-)request for 'home monitoring' in the EHR and clicks on the 'share request'-button to enroll Patrick. 

<b>Careplan</b>

A pop-up window appears. In this window, a CarePlan should be selected from a dropdown menu; for Patrick there are no known Careplans, therefore Caroline can only pick 'create new Careplan' from the dropdown menu. Basic information about Patrick, his name and BSN number, are shown in the window and a multi-select menu appears with all Conditions known for Patrick in the EHR. Caroline selects relevant conditions for the CarePlan from the list, in this case heart failure, COPD and Eczemia. She also indicates that heart failure is the one she is ordering home monitoring on. Zorg bij jou is the default party to perform home monitoring on heart failure and is auto-selected in a dropdown. She clicks 'Next'. 

<b>Criteria</b>

The Careplan is created in a matter of seconds. The pop-up window now displays more checks/questions based on the selection of heart failure to perform home monitoring on with Zorg bij jou. Caroline checks with Patrick if all criteria for enrollment are met: he has a smartphone, he reads email from his smartphone, he can install apps on his smartphone, he is proficient in Dutch language and that he is in possession of scales and a blood pressure meter. Caroline clicks on checkbox 'validation of pre-requisites completed' and clicks 'Next' again. 

<b>Further information and complete request</b>

Within a matter of seconds the checks are evaluated by Zorg bij jou. Caroline has to do one final step and validates the auto-populated information in the form of a questionnaire required to complete the enrollment process. For the patient: name (Patrick Egger), gender (male), date of birth (12-7-1956) and contact information (phone-number 06-12345678 and e-mail address p.egger@gmail.com) is populated; and, requestor (Caroline van Dijk from Hospital X) details are populated. 

Caroline cliks on "Complete request" and the request is sent to Zorg bij jou including all the information provided. 

<b>Monitoring</b>

As all information is provided, Zorg bij jou automatically accepts the tasks and provides a direct task status update, so Caroline can see that the task is received and subsequently accepted. 

Caroline monitors the task in the EHR and sees that a few days later the status of the Task is updated to “in progress”, meaning that Patrick has downloaded and started to use the monitoring app.


# Transactions

## Creating the CarePlan/CareTeam

bla bla, it goes like this:

```json
curl <fhir-base-url>/CarePlan/?category=http://snomed.info/sct|135411000146103

{% include Bundle-hospitalx-bundle1-01.json %}

```


en nog een keer (console):

```console
curl <fhir-base-url>/CarePlan/?category=http://snomed.info/sct|135411000146103

{% include Bundle-hospitalx-bundle1-01.json %}

```