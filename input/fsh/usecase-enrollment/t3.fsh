Instance: cps-task-02
InstanceOf: SCPTask
Usage: #example
Title: "1.03.1 (sub-)Task 2 creation"
Description: "Ask for extra information for telemonitoring"
* meta.versionId = "1"
* basedOn = Reference(cps-careplan-01)
* partOf = Reference(cps-task-01)
* status = #ready
* intent = #order
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-2"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-1"
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference.identifier.system = "urn:ietf:rfc:3986"
* input[=].valueReference.identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-1"

Instance: cps-bundle-02
InstanceOf: Bundle
Usage: #example
Title: "1.03.2 Bundle"
Description: "Bundle to ask for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-02, #POST, Task)
* insert BundleEntry(cps-questionnaire-telemonitoring-enrollment-criteria, #PUT, Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-1)

//resulting instances at cps:

Instance: cps-questionnaire-telemonitoring-enrollment-criteria
InstanceOf: Questionnaire
Usage: #example
Title: "1.03.3 Questionnaire for telemonitoring - enrollment criteria"
Description: "Questionnaire for enrollment criteria for telemonitoring"
* meta.lastUpdated = "2024-09-02T13:40:17Z"
* meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-1--20240902134017"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-1"
* name = "Telemonitoring - enrollment criteria"
* title = "Telemonitoring - enrollment criteria"
* status = #draft
* experimental = false
* date = "2024-09-02T13:40:17Z"
* publisher = "Medical Service Centre"
* effectivePeriod.start = "2024-09-02T13:40:17Z"
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2208"
* item[=].text = "Patient heeft smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2209"
* item[=].text = "Patient of mantelzorger leest e-mail op smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2210"
* item[=].text = "Patient of mantelzorger kan apps installeren op smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2211"
* item[=].text = "Patient of mantelzorger is Nederlandse taal machtig"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2212"
* item[=].text = "Patient beschikt over een weegschaal of bloeddrukmeter (of gaat deze aanschaffen)"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false