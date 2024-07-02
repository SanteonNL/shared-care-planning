Instance: minimal-enrollment-CarePlan
InstanceOf: CarePlan
Title: "CarePlan for Minimal Enrollment"
Usage: #example

* status = #draft
* intent = #plan
* title = "CarePlan for Minimal Enrollment"
* subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* subject.identifier.value = "111222333"
//Reference(minimal-enrollment-Patient)
* addresses[+].identifier.system = $sct
* addresses[=].identifier.value = "195111005"
* addresses[=] = Reference(minimal-enrollment-Condition)
//* activity.reference = Reference(mimimal-enrollment-Task)