// Instance: cps-qr-patient-details
// InstanceOf: QuestionnaireResponse
// Usage: #example
// Title: "1.48.1 QuestionnaireResponse for patient details" 
// Description: "Contact information for telemonitoring"
// * status = #completed
// * questionnaire = Canonical(cps-questionnaire-patient-details)
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2233"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2234"
// * item[=].item[=].answer.valueString = "Patrick"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2238"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2240" 
// * item[=].item[=].item[=].answer.valueString = "Egger"
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2257"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2258"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2259"
// * item[=].item[=].item[=].answer.valueString = "0612345678"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2263"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2264" 
// * item[=].item[=].item[=].answer.valueString = "patrickegger@myweb.nl"
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2267"
// * item[=].answer.valueDate = "1984-04-01"
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2268"
// * item[=].answer.valueCoding = $v3-AdministrativeGender#M

// Instance: cps-qr-practitioner-details
// InstanceOf: QuestionnaireResponse
// Usage: #example
// Title: "1.48.2 QuestionnaireResponse for practitioner details" 
// Description: "Contact information for telemonitoring"
// * status = #completed
// * questionnaire = Canonical(cps-questionnaire-practitioner-details)
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2274"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2275"
// * item[=].item[=].answer.valueString = "Caroline"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2279"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2280" 
// * item[=].item[=].item[=].answer.valueString = "van"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2281" 
// * item[=].item[=].item[=].answer.valueString = "Dijk"
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2300"
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2306"
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2307" 
// * item[=].item[=].item[=].answer.valueString = "c.vandijk@hospitalx.nl"

// Instance: cps-task-03-02
// InstanceOf: SCPTask
// Usage: #example
// Title: "1.48.3 (sub-)Task 3 completion"
// Description: "Provide contact information for telemonitoring"
// * meta.versionId = "2"
// * basedOn = Reference(cps-careplan-01)
// * partOf = Reference(cps-task-01)
// * status = #completed
// * intent = #order
// * for.identifier.system = $bsn
// * for.identifier.value = "111222333"
// * requester.identifier.system = $ura
// * requester.identifier.value = "URA-2"
// * owner.identifier.system = $ura
// * owner.identifier.value = "URA-1"
// * input[+].type = $task-input-type#Reference "Reference"
// * input[=].valueReference.identifier.system = $uuid
// * input[=].valueReference.identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-2"
// * input[+].type = $task-input-type#Reference "Reference"
// * input[=].valueReference.identifier.system = $uuid
// * input[=].valueReference.identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-3"
// * output[+].type = $task-input-type#Reference "Reference"
// * output[=].valueReference = Reference(urn:uuid:901)
// * output[+].type = $task-input-type#Reference "Reference"
// * output[=].valueReference = Reference(urn:uuid:902)

// Instance: cps-bundle-05
// InstanceOf: Bundle
// Usage: #example
// Title: "1.48.4 Bundle"
// Description: "Bundle with response for extra information for telemonitoring"
// * meta.versionId = "1"
// * type = #transaction
// * insert BundleEntry(cps-task-03-02, #PUT, Task/cps-task-03)
// * entry.request.ifMatch = "W/\"1\""
// * insert BundleEntryWithFullurl(urn:uuid:901, cps-qr-patient-details, #POST, QuestionnaireResponse)
// * insert BundleEntryWithFullurl(urn:uuid:902, cps-qr-practitioner-details, #POST, QuestionnaireResponse)
