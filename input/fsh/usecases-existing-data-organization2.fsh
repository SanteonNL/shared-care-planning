// PractitionerRole2
Instance: nl-core-CareTeam-01-PractitionerRole-03
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* practitioner = Reference(nl-core-CareTeam-01-Practitioner-03) "Healthcare professional (person), R.M. van Heck"
* practitioner.type = "Practitioner"
* specialty.coding.version = "2020-10-23T00:00:00"
* specialty.coding = urn:oid:2.16.840.1.113883.2.4.6.7#0320 "Medisch specialisten, cardiologie"

Instance: minimal-enrollment-Practitioner-Requester
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "A. Aanvrager"
* name.family.extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension.valueString = "Aanvrager"
* name.family = "Aanvrager"
* name.given = "Anton"
* name.given.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given.extension.valueCode = #IN
* name.prefix = "Drs."
* telecom[+].system = #phone
* telecom[=].value = "+31687654321"
* telecom[+].system = #email
* telecom[=].value = "av@icloud.com"