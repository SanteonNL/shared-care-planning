Alias: SCT = http://snomed.info/sct
Alias: LOINC = http://loinc.org

Instance: scp-plan-diabetes
InstanceOf: CarePlan
Title: "Plan for Diabetes Sharon Cynthia Proef"
Usage: #example

* status = #draft
* intent = #plan
* title = "Plan voor behandeling Diabetes Sharon Cynthia Proef"
* subject = Reference(SharonCynthiaProef)
* addresses = Reference(scp-condition-diabetes)
* supportingInfo = Reference(scp-condition-hypertensie)
* activity.reference = Reference(scp-task-bloedpanel)

Instance: scp-condition-diabetes
InstanceOf: Condition
Title: "Diabetes Sharon Cynthia Proef"

* clinicalStatus = #active
* code = SCT#73211009 "Diabetes mellitus (disorder)"
* subject = Reference(SharonCynthiaProef)
* recorder = Reference(nl-core-CareTeam-01-Practitioner-01)

Instance: scp-condition-hypertensie
InstanceOf: Condition
Title: "Hypertensie Sharon Cynthia Proef"

* clinicalStatus = #active
* code = SCT#38341003 "Hypertensive disorder, systemic arterial (disorder)"
* subject = Reference(SharonCynthiaProef)

Instance: scp-task-bloedpanel
InstanceOf: Task
Title: "Taak: Compleet bloedbeeld bepalen"

* status = #requested
* intent = #order
* code = LOINC#58410-2 "Compleet bloedbeeld panel in bloed d.m.v. geautomatiseerde telling"
* focus = Reference(scp-req-bloedpanel)

Instance: scp-req-bloedpanel
InstanceOf: ServiceRequest
Title: "Request: Compleet bloedbeeld bepalen"

* status = #active
* intent = #order
* code = LOINC#58410-2 "Compleet bloedbeeld panel in bloed d.m.v. geautomatiseerde telling"
* subject = Reference(SharonCynthiaProef)

