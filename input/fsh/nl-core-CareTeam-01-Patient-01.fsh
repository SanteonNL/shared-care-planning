Instance: nl-core-CareTeam-01-Patient-01
InstanceOf: Patient
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* name.use = #official
* name.text = "Ingrid de Jong-de Wit"
* name.family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name.family.extension[=].valueString = "de"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension[=].valueString = "Jong"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-prefix"
* name.family.extension[=].valueString = "de"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-name"
* name.family.extension[=].valueString = "Wit"
* name.family = "de Jong-de Wit"
* name.given = "Ingrid"
* name.given.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given.extension.valueCode = #BR