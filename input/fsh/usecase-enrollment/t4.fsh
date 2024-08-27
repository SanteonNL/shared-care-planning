Instance: cps-task2-01
InstanceOf: SCPTask
Usage: #example
Title: "1.04 (sub-)Task 2 creation"
Description: "Ask for extra information for telemonitoring"
* meta.versionId = "1"
* contained = hospitalx-servicerequest-telemonitoring
* basedOn = Reference(cps-careplan1-02)
* partOf = Reference(cps-task1-01)
* status = #ready
* intent = #order
* focus = Reference(hospitalx-servicerequest-telemonitoring)
* for = Reference(cps-patrick)
* input.type = $task-input-type#Reference "Reference"
* input.valueReference = Reference(cps-questionnaire-telemonitoring)


Instance: cps-questionnaire-telemonitoring
InstanceOf: Questionnaire
Usage: #example
Title: "1.04 Questionnaire for telemonitoring"
Description: "Questionnaire for extra information for telemonitoring"
* status = #active
* item[+].linkId = "1"
* item[=].text = "For which condition(s) do you want to start telemonitoring?"
* item[=].repeats = true
* item[=].type = #choice
* item[=].answerValueSet = $condition-code

* item[+].linkId = "2"
* item[=].text = "Patient has a smartphone?"
* item[=].type = #choice
* item[=].answerValueSet = $yesnodontknow

* item[+].linkId = "3"
* item[=].text = "Patient can read email on his/her smartphone?"
* item[=].type = #choice
* item[=].answerValueSet = $yesnodontknow

* item[+].linkId = "4"
* item[=].text = "You like this Questionnaire?"
* item[=].type = #choice
* item[=].answerValueSet = $yesnodontknow