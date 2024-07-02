Instance: minimal-enrollment-Bundle
InstanceOf: Bundle
Title: "Bundle for Minimal Enrollment"
Usage: #example

* type = #transaction

* entry[+].fullUrl = "minimal-enrollment-CarePlan"
* entry[=].resource = minimal-enrollment-CarePlan
* entry[=].request.method = #POST
* entry[=].request.url = "CarePlan"

* entry[+].fullUrl = "minimal-enrollment-Condition"
* entry[=].resource = minimal-enrollment-Condition
* entry[=].request.method = #POST
* entry[=].request.url = "Condition"

* entry[+].fullUrl = "minimal-enrollment-Organization-Performer"
* entry[=].resource = minimal-enrollment-Organization-Performer
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

* entry[+].fullUrl = "minimal-enrollment-Organization-Requester"
* entry[=].resource = minimal-enrollment-Organization-Requester
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

* entry[+].fullUrl = "minimal-enrollment-Patient"
* entry[=].resource = minimal-enrollment-Patient
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"

* entry[+].fullUrl = "minimal-enrollment-Practitioner-HP"
* entry[=].resource = minimal-enrollment-Practitioner-HP
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

* entry[+].fullUrl = "minimal-enrollment-Practitioner-Requester"
* entry[=].resource = minimal-enrollment-Practitioner-Requester
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

* entry[+].fullUrl = "minimal-enrollment-ServiceRequest"
* entry[=].resource = minimal-enrollment-ServiceRequest
* entry[=].request.method = #POST
* entry[=].request.url = "ServiceRequest"

* entry[+].fullUrl = "minimal-enrollment-Task"
* entry[=].resource = minimal-enrollment-Task
* entry[=].request.method = #POST
* entry[=].request.url = "Task"