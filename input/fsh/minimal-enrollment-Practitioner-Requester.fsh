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