Instance: careteam-v1
InstanceOf: CareTeam
Usage: #example
* name = "Shared Care Team"
* category = LOINC#LA28865-6 "Longitudinal care-coordination focused care team"
* participant[0].member = Reference(nl-core-CareTeam-01-RelatedPerson-01) "Contact person, Jan de Wit"
* participant[=].member.type = "RelatedPerson"
* participant[+].member = Reference(nl-core-CareTeam-01-Patient-01) "Patient, Ingrid de Jong-de Wit"
* participant[=].member.type = "Patient"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-01) "Healthcare professional (role), W. Klaasen, Huisartsen, niet nader gespecificeerd"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-02) "Healthcare professional (role), S. Curie, Medisch specialisten, geriatrie"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-03) "Healthcare professional (role), R.M. van Heck, Medisch specialisten, cardiologie"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-04) "Healthcare professional (role), A. Schele, Medisch specialisten, inwendige geneeskunde"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-05) "Healthcare professional (role), G.F. de Haan, Apothekers"
* participant[=].member.type = "PractitionerRole"

Instance: CarePlan1-v2
InstanceOf: CarePlan
Usage: #example
* meta.versionId = "2"
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