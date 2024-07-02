Instance: minimal-enrollment-Task
InstanceOf: Task
Usage: #example
* basedOn = Reference(minimal-enrollment-CarePlan)
* status = #requested
* intent = #order
* focus = Reference(minimal-enrollment-ServiceRequest)