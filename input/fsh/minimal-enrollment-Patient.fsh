Instance: minimal-enrollment-Patient
InstanceOf: Patient
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* name[0].use = #official
* name[=].text = "Jean Jacques van Putten-van der Giessen"
* name[=].family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name[=].family.extension[=].valueString = "van"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name[=].family.extension[=].valueString = "Putten"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-prefix"
* name[=].family.extension[=].valueString = "van der"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-name"
* name[=].family.extension[=].valueString = "Giessen"
* name[=].family = "van Putten-van der Giessen"
* name[=].given[0] = "Jean"
* name[=].given[+] = "Jacques"
* birthDate = "1974-01-01"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* contact.telecom[+].system = #email
* contact.telecom[=].value = "jj@icloud.com"
* contact.telecom[=].system = #phone
* contact.telecom[=].value = "+31612345678"