Instance: CarePlan1-v1
InstanceOf: SCPCareplan
Usage: #example
* meta.versionId = "1"
* status = #active
* intent = #order
* title = "Care Plan [Chronische obstructieve longaandoening (aandoening)]"
* description = "Care plan description here"
* subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* subject.identifier.value = "1722435177438"
* careTeam = Reference(CareTeam/4)
* addresses.identifier.system = "http://snomed.info/sct"
* addresses.identifier.value = "13645005"
* addresses.display = "Chronic obstructive lung disease (disorder)"
* addresses = Reference(scp-condition-diabetes)
* supportingInfo = Reference(scp-condition-hypertensie)
* activity.reference = Reference(Task/5)