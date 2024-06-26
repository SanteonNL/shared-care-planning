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