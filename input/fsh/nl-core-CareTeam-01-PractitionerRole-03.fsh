Instance: nl-core-CareTeam-01-PractitionerRole-03
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* practitioner = Reference(nl-core-CareTeam-01-Practitioner-03) "Healthcare professional (person), R.M. van Heck"
* practitioner.type = "Practitioner"
* specialty.coding.version = "2020-10-23T00:00:00"
* specialty.coding = urn:oid:2.16.840.1.113883.2.4.6.7#0320 "Medisch specialisten, cardiologie"