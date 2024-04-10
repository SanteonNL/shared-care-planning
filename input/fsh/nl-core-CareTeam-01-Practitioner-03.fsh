Instance: nl-core-CareTeam-01-Practitioner-03
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "R.M. van Heck"
* name.family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name.family.extension[=].valueString = "van"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension[=].valueString = "Heck"
* name.family = "van Heck"
* name.given[0] = "R."
* name.given[+] = "M."
* name.given[0].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[=].extension.valueCode = #IN
* name.given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[=].extension.valueCode = #IN
* name.prefix = "Dr."