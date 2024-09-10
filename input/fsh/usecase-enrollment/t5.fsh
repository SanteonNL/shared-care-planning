Instance: cps-qr-telemonitoring-enrollment-criteria
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "1.05.1 QuestionnaireResponse for telemonitoring enrollment criteria" 
Description: "Extra information for telemonitoring"
* status = #completed
* questionnaire = Canonical(cps-questionnaire-telemonitoring-enrollment-criteria)
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2208"
* item[=].answer.valueBoolean = true
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2209" 
* item[=].answer.valueBoolean = true
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2210"
* item[=].answer.valueBoolean = true
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2211" 
* item[=].answer.valueBoolean = true
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2212"
* item[=].answer.valueBoolean = true


Instance: cps-task-02-02
InstanceOf: SCPTask
Usage: #example
Title: "1.05.2 (sub-)Task 2 completion"
Description: "Provide information for telemonitoring"
* meta.versionId = "2"
* basedOn = Reference(cps-careplan-01)
* partOf = Reference(cps-task-01)
* status = #completed
* intent = #order
* focus = Reference(cps-servicerequest-telemonitoring)
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-2"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-1"
* input.type = $task-input-type#Reference "Reference"
* input.valueReference = Reference(cps-questionnaire-telemonitoring)
* output.type = $task-input-type#Reference "Reference"
* output.valueReference = Reference(urn:uuid:456)

Instance: cps-bundle-03
InstanceOf: Bundle
Usage: #example
Title: "1.05.3 Bundle"
Description: "Bundle with response for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(urn:uuid:123, cps-task-02-02, #PUT, Task)
* insert BundleEntry(urn:uuid:456, cps-questionnaire-telemonitoring-enrollment-criteria, #PUT, Questionnaire)