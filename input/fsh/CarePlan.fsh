Instance: scp-plan-diabetes
InstanceOf: CarePlan
Title: "Plan for Diabetes Sharon Cynthia Proef"
Usage: #example

* status = #draft
* intent = #plan
* title = "Plan voor behandeling Diabetes Sharon Cynthia Proef"
* subject = Reference(SharonCynthiaProef)
* addresses = Reference(scp-condition-diabetes)

Instance: scp-condition-diabetes
InstanceOf: Condition
Title: "Diabetes Sharon Cynthia Proef"

* clinicalStatus = #active
* code = $sct#73211009 "Diabetes mellitus (disorder)"
* subject = Reference(SharonCynthiaProef)