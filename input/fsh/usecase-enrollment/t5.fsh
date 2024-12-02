Instance: cps-qr-telemonitoring-enrollment-criteria
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "1.26.1 QuestionnaireResponse for telemonitoring enrollment criteria" 
Description: "Extra information for telemonitoring"
* status = #completed
* questionnaire = "https://raw.githubusercontent.com/Zorgbijjou/scp-homemonitoring/refs/tags/0.1.0/fsh-generated/resources/Questionnaire-zbj-questionnaire-telemonitoring-heartfailure-enrollment.json"
* subject = Reference(Patient/{{patient1id}})
* item[+].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].answer.valueString = "Hartfalen"
* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9" 
* item[=].answer.valueString = "Instabiel hartfalen"
* item[+].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
* item[=].answer.valueBoolean = true
* item[+].linkId = "dcba2829-32d8-4390-b1d4-32a5fefda539" 
* item[=].answer.valueBoolean = true
* item[+].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].answer.valueDecimal = 123.5
* item[+].linkId = "135aec2f-e410-4668-9a26-f745dc1789af"
* item[=].answer.valueBoolean = true
* item[+].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261" 
* item[=].answer.valueBoolean = true
* item[+].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161" 
* item[=].answer.valueString = "-"
* item[+].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086" 
* item[=].answer.valueBoolean = true

Instance: cps-task-02-02
InstanceOf: SCPTask
Usage: #example
Title: "1.26.2 (sub-)Task 2 completion"
Description: "Provide information for telemonitoring"
* meta.versionId = "2"
* basedOn = Reference(CarePlan/{{careplan1id}})
* partOf = Reference(Task/{{task1id}})
* status = #completed
* intent = #order
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-2"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-1"
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference.identifier.system = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34"
* input[=].valueReference.identifier.value = "1"
* output[+].type = $task-input-type#Reference "Reference"
* output[=].valueReference = Reference(urn:uuid:cps-qr-telemonitoring-enrollment-criteria)

Instance: cps-bundle-03
InstanceOf: Bundle
Usage: #example
Title: "1.26.3 Bundle"
Description: "Bundle with response for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryPUT(cps-task-02-02, #PUT, Task/{{task2id}},{{task2etag}})
* insert BundleEntryWithFullurl(urn:uuid:cps-qr-telemonitoring-enrollment-criteria, cps-qr-telemonitoring-enrollment-criteria, #POST, QuestionnaireResponse)