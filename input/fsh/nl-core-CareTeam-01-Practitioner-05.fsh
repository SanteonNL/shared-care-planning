Instance: nl-core-CareTeam-01-Practitioner-05
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "G.F. de Haan"
* name.family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name.family.extension[=].valueString = "de"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension[=].valueString = "Haan"
* name.family = "de Haan"
* name.given[0] = "G."
* name.given[+] = "F."
* name.given[0].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[=].extension.valueCode = #IN
* name.given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[=].extension.valueCode = #IN
* name.prefix = "Drs."