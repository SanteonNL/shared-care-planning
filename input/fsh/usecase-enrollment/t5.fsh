Instance: msc-telemonitoring-heartfailure-enrollment-response
InstanceOf: QuestionnaireResponse
Usage: #inline
Title: "1.26.1 QuestionnaireResponse for telemonitoring enrollment criteria" 
Description: "Extra information for telemonitoring"
* status = #completed
* questionnaire = "http://example.org/Questionnaire-msc-telemonitoring-heartfailure-enrollment|0.3"
* subject = Reference(Patient/{{patient1id}})
* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].answer.valueCoding = $sct#84114007 "Hartfalen"
* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Meetprotocol"
* item[=].answer.valueCoding = $sct#255299009 "Instabiel"
* item[+].linkId = "2f505566-ac92-4347-8731-840e6bc84851"
* item[=].item.linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
* item[=].item.text = "Titratie"
* item[=].item.answer.valueCoding = $sct#373066001 "ja, titratie"
* item[+].linkId = "170292e5-3163-43b4-88af-affb3e4c27ab"
* item[=].item[0].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].item[=].text = "Streefgewicht"
* item[=].item[=].answer.valueDecimal = 75
* item[=].item[+].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261"
* item[=].item[=].text = "Apparatuur beschikbaar"
* item[=].item[=].answer.valueCoding = $sct#373066001 "ja, patiënt beschikt over een weegschaal en bloeddrukmeter (of is bereid deze aan te schaffen)"
* item[=].item[+].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161"
* item[=].item[=].text = "Notitie"
* item[=].item[=].answer.valueString = "important text"
* item[+].linkId = "2bc0b73f-506a-48a4-994d-fe355a5825f3"
* item[=].text = "Begeleiding bij onboarding"
* item[=].item.linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].item.text = "Moeite met apps"
* item[=].item.answer.valueCoding = $sct#373066001 "ja, patiënt heeft hulp nodig bij het downloaden en inloggen in de app"



Instance: cps-task-02-02
InstanceOf: SCPTask
Usage: #example
Title: "1.26.2 (sub-)Task 2 completion"
Description: "Provide information for telemonitoring"
* meta.versionId = "2"
* contained[0] = msc-telemonitoring-heartfailure-enrollment
* contained[+] = msc-telemonitoring-heartfailure-enrollment-response
* contained[+] = hospitalx-carolinevandijk-hospitalx
* contained[+] = msc-msc
* basedOn = Reference({{org1-fhir-url}}CarePlan/{{careplan1id}})
* partOf = Reference({{org1-fhir-url}}Task/{{task1id}})
* status = #ready
* intent = #order
* code = $task-code#fullfill
* focus = Reference(msc-telemonitoring-heartfailure-enrollment)
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert RefIdentifierContained(owner, PractitionerRole, hospitalx-carolinevandijk-hospitalx, $uzi, UZI-1, $ura, URA-1)
* insert RefIdentifierContained(requester, Organization, msc-msc, $ura, URA-2, $ura, URA-2)
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

Instance: cps-task-signature-02-02
InstanceOf: Provenance
Usage: #example
// when deploying resources to a HAPIFHIR-server, it automatrically deletes the _history part (version) of the reference
// to prevent this, the extension "auto-version-references-at-path" is used here
* meta.extension.url = "http://hapifhir.io/fhir/StructureDefinition/auto-version-references-at-path"
* meta.extension.valueString = "target"
* target = Reference(Task/{{task2id}}/_history/{{task2etag}})
* recorded = "2024-12-19T15:41:12+01:00"
* reason = $v3-ActReason#TREAT "treatment"
* activity = $v3-DataOperation#CREATE "create"
* agent.type = $provenance-participant-type#author
* insert RefIdentifier(agent.who, Organization, 2, $ura, URA-2, $ura, URA-2, org2)
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2024-12-19T15:41:12+01:00"
* insert RefIdentifier(signature.who, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/jose
// signature data created using: https://test.webpki.org/jws-ct/create
// FHIR R6 JSON Signature Rules should be applied: https://build.fhir.org/datatypes.html#JSON 
// copy best practices from: https://hl7.org/fhir/us/davinci-cdex/signatures.html#digital-signatures
* signature.data = "c29tZSBzaWduYXR1cmUgZGF0YQ=="