Instance: nl-core-CareTeam-01-RelatedPerson-01
InstanceOf: RelatedPerson
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-ContactPerson"
* patient = Reference(nl-core-Patient-01) "Patient, Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* patient.type = "Patient"
* relationship[0] = urn:oid:2.16.840.1.113883.2.4.3.11.22.472#01 "Eerste relatie/contactpersoon"
* relationship[+] = $v3-RoleCode#HUSB "Husband"
* name.use = #official
* name.text = "Jan de Wit"
* name.family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name.family.extension[=].valueString = "de"
* name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension[=].valueString = "Wit"
* name.family = "de Wit"
* name.given = "Jan"
* name.given.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given.extension.valueCode = #BR