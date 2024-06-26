Alias: SCT = http://snomed.info/sct
Alias: LOINC = http://loinc.org

Instance: minimal-enrollment-CarePlan
InstanceOf: CarePlan
Title: "CarePlan for Minimal Enrollment"
Usage: #example

* status = #draft
* intent = #plan
* title = "CarePlan for Minimal Enrollment"
* subject = Reference(minimal-enrollment-Patient)
* addresses = Reference(minimal-enrollment-Condition)
* activity.reference = Reference(mimimal-enrollment-Task)


Instance: scp-req-bloedpanel
InstanceOf: ServiceRequest
Title: "Request: Compleet bloedbeeld bepalen"

* status = #active
* intent = #order
* code = LOINC#58410-2 "Compleet bloedbeeld panel in bloed d.m.v. geautomatiseerde telling"
* subject = Reference(SharonCynthiaProef)

