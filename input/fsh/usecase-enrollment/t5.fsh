Instance: cps-task2-02
InstanceOf: SCPTask
Usage: #example
Title: "1.05 (sub-)Task 2 completion"
Description: "Provide information for telemonitoring"
* meta.versionId = "2"
* contained = hospitalx-servicerequest-telemonitoring
* basedOn = Reference(cps-careplan1-02)
* partOf = Reference(cps-task1-01)
* status = #completed
* intent = #order
* focus = Reference(hospitalx-servicerequest-telemonitoring)
* for = Reference(cps-patrick)
* input.type = $task-input-type#Reference "Reference"
* input.valueReference = Reference(cps-questionnaire-telemonitoring)
* output.type = $task-input-type#Reference "Reference"
* output.valueReference = Reference(cps-questionnaireresponse-telemonitoring)

Instance: cps-questionnaireresponse-telemonitoring
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "1.05 QuestionnaireResponse for telemonitoring"
Description: "Extra information for telemonitoring"
* status = #completed
* questionnaire = Canonical(cps-questionnaire-telemonitoring)
* subject = Reference(cps-patrick)
* item[+].linkId = "1"
* item[=].answer.valueCoding = $sct#195111005 "Hartfalen"
* item[+].linkId = "2" 
* item[=].answer.valueCoding = http://terminology.hl7.org/CodeSystem/v2-0532#yes "Yes"
* item[+].linkId = "3" 
* item[=].answer.valueCoding = http://terminology.hl7.org/CodeSystem/data-absent-reason#asked-unknown "Don't know"
* item[+].linkId = "4" 
* item[=].answer.valueCoding = http://terminology.hl7.org/CodeSystem/v2-0532#no "No"