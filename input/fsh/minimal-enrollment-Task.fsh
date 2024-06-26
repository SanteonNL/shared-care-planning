Instance: minimal-enrollment-Task
InstanceOf: Task
Usage: #example
* basedOn = CareTeam/minimal-enrollment-CareTeam
* status = "requested"
* intent = "order"
* focus = Reference(minimal-enrollment-ServiceRequest)