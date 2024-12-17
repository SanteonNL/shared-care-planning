Instance: msc-telemonitoring-heartfailure-enrollment-response
InstanceOf: QuestionnaireResponse
Usage: #inline
Title: "1.26.1 QuestionnaireResponse for telemonitoring enrollment criteria" 
Description: "Extra information for telemonitoring"
* status = #completed
* questionnaire = "https://raw.githubusercontent.com/Zorgbijjou/scp-homemonitoring/refs/tags/0.1.0/fsh-generated/resources/Questionnaire-zbj-questionnaire-telemonitoring-heartfailure-enrollment.json"
* subject = Reference(Patient/{{patient1id}})
* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].answer.valueString = "Hartfalen"
* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Selecteer het Meetprotocol"
* item[=].answer.valueString = "Instabiel hartfalen"
* item[+].linkId = "2f505566-ac92-4347-8731-840e6bc84851"
* item[=].text = ""
* item[=].item[0].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
* item[=].item[=].text = "Titratie"
* item[=].item[=].answer.valueString = "Titratie"
* item[=].item[+].linkId = "dcba2829-32d8-4390-b1d4-32a5fefda539"
* item[=].item[=].text = "Recompensatie"
* item[=].item[=].answer.valueString = "Recompensatie"
* item[+].linkId = "170292e5-3163-43b4-88af-affb3e4c27ab"
* item[=].text = ""
* item[=].item[0].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].item[=].text = "Streefgewicht"
* item[=].item[=].answer.valueDecimal = 106.5
* item[=].item[+].linkId = "135aec2f-e410-4668-9a26-f745dc1789af"
* item[=].item[=].text = ""
* item[=].item[=].answer.valueString = "De patiënt is opgenomen geweest"
* item[=].item[+].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261"
* item[=].item[=].text = ""
* item[=].item[=].answer.valueString = "De patiënt beschikt over een weegschaal en bloeddrukmeter (of is bereid deze aan te schaffen)"
* item[=].item[+].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161"
* item[=].item[=].text = ""
* item[=].item[=].answer.valueString = "-"
* item[+].linkId = "2bc0b73f-506a-48a4-994d-fe355a5825f3"
* item[=].text = "Begeleiding bij onboarding"
* item[=].item.linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].item.text = "De patiënt heeft hulp nodig bij het downloaden en inloggen in de app"
* item[=].item.answer.valueString = "De patiënt heeft hulp nodig"



Instance: cps-task-02-02
InstanceOf: SCPTask
Usage: #example
Title: "1.26.2 (sub-)Task 2 completion"
Description: "Provide information for telemonitoring"
* meta.versionId = "2"
* contained[0] = msc-telemonitoring-heartfailure-enrollment
* contained[1] = msc-telemonitoring-heartfailure-enrollment-response
* basedOn = Reference(CarePlan/{{careplan1id}})
* partOf = Reference(Task/{{task1id}})
* status = #completed
* intent = #order
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, cpc1)
* insert RefIdentifier(requester, Organization, 2, $ura, URA-2, $ura, URA-2, cpc2)
* insert RefIdentifier(owner, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-2, cpc2)
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference = Reference(msc-telemonitoring-heartfailure-enrollment)
* output[+].type = $task-input-type#Reference "Reference"
* output[=].valueReference = Reference(msc-telemonitoring-heartfailure-enrollment-response)

Instance: cps-bundle-03
InstanceOf: Bundle
Usage: #example
Title: "1.26.3 Bundle"
Description: "Bundle with response for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryPUT(cps-task-02-02, #PUT, Task/{{task2id}},{{task2etag}})
//* insert BundleEntryWithFullurl(urn:uuid:cps-qr-telemonitoring-enrollment-criteria, cps-qr-telemonitoring-enrollment-criteria, #POST, QuestionnaireResponse)