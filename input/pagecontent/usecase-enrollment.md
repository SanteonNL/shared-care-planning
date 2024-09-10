### The user story

#### Diagnosis, informed consent, implied consent

A cardiologist, Caroline van Dijk, from Hospital X diagnoses heart failure for patient Patrick Egger and explains about home monitoring at 'Medical service centre' (MSC). Caroline gets informed consent from Patrick to enroll him for home monitoring at MSC. Because Patrick gives informed consent for the enrollment, consent for the processing of the relevant data by MSC can be implied (implied consent).

#### Order/ Service-request

Caroline makes a (service-)request for 'home monitoring' in the EHR. The diagnosis heart failure is linked to the request for context. Caroline clicks on the 'share request'-button to enroll Patrick. 

#### Careplan

A pop-up window appears. In this window, an existing multidisciplinary CarePlan could be selected from a dropdown menu. However, for Patrick there are no known Careplans, therefore Caroline can only pick 'create new Careplan' from the dropdown menu. 

> In the background, the MSC receives the request and determines if there are enough resources available to execute the request. As Patrick (his Dutch-citizen-id) is unknown to the MSC, the MSC responds with a questionnaire. If the MSC wouldn't be able to execute te request, it would be rejected here.

#### Criteria

The pop-up window now displays questions to determine if the patient is eligible for telemonitoring treatment at MSC. Caroline checks with Patrick if: he has a smartphone, he reads email from his smartphone, he can install apps on his smartphone, he is proficient in Dutch language and that he is in possession of scales and a blood pressure meter. Caroline submits the answers.

> In the background, the MSC checks the answers. If Patrick wouldn't be eligible for telemonitoring at the MSC, the request would be rejected here.

#### Contact information (PII)

The pop-up window now displays questions for basic contact information on patient Patrick and cardiologist Caroline (e.g. name, telephone number and email address). This information has been auto-populated from the EHR. Caroline just has to check and submit.

> In the background, the MSC checks the answers for completeness. The MSC automatically accepts the request and sends the patient an invite for a monitoring app.

#### Request accepted

The pop-up windows now responds that the MSC has accepted the request and has invited the patient to download a monitoring app. The telemonitoring request has been successfully assigned.

#### Monitoring

Caroline monitors the (shared) request in the EHR and sees that a few days later the status is updated to “in progress”, meaning that Patrick has downloaded and started to use the monitoring app.


### Transactions

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