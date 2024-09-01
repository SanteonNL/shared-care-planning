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

Caroline monitors the task in the EHR and sees that a few days later the status of the Task is updated to “in progress”, meaning that Patrick has downloaded and started to use the monitoring app.


### Transactions

#### Hospital X: Find existing CarePlan for Patient

```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/CarePlan/?category=http://snomed.info/sct|135411000146103' --header 'Content-Type: application/json' \
```

#### Hospital X: Create Task 

assumption no CarePlan was found (so no Task.basedOn), create a Bundle with a new Task and a copy of the referred ServiceRequest and Condition:

```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle-01.json %}'
```

#### CarePlanService: Create subscriptions, careplan, careteam and notifications
```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/Subscription/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Subscription-cps-sub-medicalservicecentre.json %}'

curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/Subscription/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Subscription-cps-sub-hospitalx.json %}'

curl --request POST 'https://medicalservicecentre.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-msc-01.json %}'

curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/CarePlan/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include CarePlan-cps-careplan-01.json %}'

curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/CareTeam/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include CareTeam-cps-careteam-01.json %}'

curl --request POST 'https://hospitalx.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-hospitalx-01.json %}'
```


#### MedicalServiceCentre: Get Task, Create sub-Task with Questionnaire (enrollment criteria)

get the Task and referenced data
```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/Task/cps-task-01' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}'
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/ServiceRequest/cps-servicerequest-telemonitoring' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}'
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/Condition/cps-heartfailure' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}'
```
post bundle with new (sub-) task that contains a questionnaire
```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle-02.json %}'
```

#### CarePlanService: notify hospital X

```
curl --request POST 'https://hospitalx.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-hospitalx-02.json %}'
```


#### Hospital X: Get sub-task, Update sub-Task with QuestionnaireResponse (enrollment criteria)
get sub-task and questionnaire
```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/Task/cps-task-02/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/Questionnaire/msc-questionnaire-telemonitoring-enrollment-criteria/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' 
```
fill in QuestionnaireResponse and update the (sub-)Task
```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle-03.json %}'
```

#### CarePlanService: notify medicalservicecentre
```
curl --request POST 'https://medicalservicecentre.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-msc-02.json %}'
```

#### MedicalServiceCentre: Create sub-Task with Questionnaire (patient/practitioner details)

post bundle with new (sub-) task that contains a questionnaire
```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle-04.json %}'
```

#### CarePlanService: notify hospital X

```
curl --request POST 'https://hospitalx.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-hospitalx-03.json %}'
```
#### Hospital X: Update sub-Task with QuestionnaireResponse (patient/practitioner details)
```
curl --request POST '{% raw %}{{cps-base-url}}{% endraw %}/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-cps-bundle-05.json %}'
```
#### CarePlanService: notify medicalservicecentre

```
curl --request POST 'https://medicalservicecentre.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-msc-03.json %}'
```

#### MedicalServiceCentre: Update Task to accepted

```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/Task/cps-task-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \

curl --request PUT '{% raw %}{{cps-base-url}}{% endraw %}/Task/cps-task-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Task-cps-task-01-02.json %}'
```

#### CarePlanService: update CareTeam and CarePlan, notify CareTeam participants

```
curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/CarePlan/cps-careplan-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' 

curl --request PUT '{% raw %}{{cps-base-url}}{% endraw %}/CarePlan/cps-careplan-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include CarePlan-cps-careplan-01-02.json %}'

curl --request GET '{% raw %}{{cps-base-url}}{% endraw %}/CareTeam/cps-careteam-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}'

curl --request PUT '{% raw %}{{cps-base-url}}{% endraw %}/CareTeam/cps-careteam-01/' --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include CareTeam-cps-careteam-01-02.json %}'

curl --request POST 'https://hospitalx.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-hospitalx-11.json %}'

curl --request POST 'https://medicalservicecentre.nl/notifications/'  --header 'Content-Type: application/json' --header 'Authorization: {% raw %}{{access-token}}{% endraw %}' \
--data '{% include Bundle-notification-msc-11.json %}'
```