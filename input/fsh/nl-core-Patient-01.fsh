Instance: nl-core-Patient-01
InstanceOf: Patient
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* extension.extension.url = "code"
* extension.extension.valueCodeableConcept = urn:oid:2.16.840.1.113883.2.4.4.16.32#0001 "Nederlandse"
* extension.url = "http://hl7.org/fhir/StructureDefinition/patient-nationality"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* name[0].use = #official
* name[=].text = "Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* name[=].family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* name[=].family.extension[=].valueString = "van"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name[=].family.extension[=].valueString = "Putten"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-prefix"
* name[=].family.extension[=].valueString = "van der"
* name[=].family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-name"
* name[=].family.extension[=].valueString = "Giessen"
* name[=].family = "van Putten-van der Giessen"
* name[=].given[0] = "Johanna"
* name[=].given[+] = "Petronella"
* name[=].given[+] = "Maria"
* name[=].given[0].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name[=].given[=].extension.valueCode = #BR
* name[=].given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name[=].given[=].extension.valueCode = #BR
* name[=].given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name[=].given[=].extension.valueCode = #BR
* name[+].use = #usual
* name[=].given = "Jo"
* telecom[0].system.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification"
* telecom[=].system.extension.valueCodeableConcept = $v3-AddressUse#MC "Mobile Phone"
* telecom[=].system = #phone
* telecom[=].value = "+31611234567"
* telecom[+].system = #email
* telecom[=].value = "giesput@myweb.nl"
* telecom[=].use = #home
* gender.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification"
* gender.extension.valueCodeableConcept = $v3-AdministrativeGender#F "Female"
* gender = #female
* birthDate = "1934-04-28"
* deceasedBoolean = false
* address.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-AddressInformation.AddressType"
* address.extension.valueCodeableConcept = $v3-AddressUse#HP "Primary Home"
* address.use = #home
* address.type = #both
* address.line = "1e Jacob van Campenstr 15"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "1e Jacob van Campenstr"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "15"
* address.city = "Hoogmade"
* address.district = "Kaag en Braassem"
* address.postalCode = "1012 NX"
* address.country.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification"
* address.country.extension.valueCodeableConcept.coding.version = "2020-10-26T00:00:00"
* address.country.extension.valueCodeableConcept.coding = urn:iso:std:iso:3166#NL "Nederland"
* address.country = "Nederland"
* maritalStatus = $v3-MaritalStatus#D "Divorced"
* multipleBirthBoolean = true
* contact.relationship[0] = urn:oid:2.16.840.1.113883.2.4.3.11.22.472#01 "Eerste relatie/contactpersoon"
* contact.relationship[+] = urn:oid:2.16.840.1.113883.2.4.3.11.22.472#07 "Hulpverlener"
* contact.name.use = #official
* contact.name.text = "J.P.M. van Putten-van der Giessen"
* contact.name.family.extension[0].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-prefix"
* contact.name.family.extension[=].valueString = "van"
* contact.name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* contact.name.family.extension[=].valueString = "Putten"
* contact.name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-prefix"
* contact.name.family.extension[=].valueString = "van der"
* contact.name.family.extension[+].url = "http://hl7.org/fhir/StructureDefinition/humanname-partner-name"
* contact.name.family.extension[=].valueString = "Giessen"
* contact.name.family = "van Putten-van der Giessen"
* contact.name.given[0] = "J."
* contact.name.given[+] = "P."
* contact.name.given[+] = "M."
* contact.name.given[0].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* contact.name.given[=].extension.valueCode = #IN
* contact.name.given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* contact.name.given[=].extension.valueCode = #IN
* contact.name.given[+].extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* contact.name.given[=].extension.valueCode = #IN
* contact.telecom[0].system.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification"
* contact.telecom[=].system.extension.valueCodeableConcept = $v3-AddressUse#MC "Mobile Phone"
* contact.telecom[=].system = #phone
* contact.telecom[=].value = "+31611234567"
* contact.telecom[+].system = #email
* contact.telecom[=].value = "giesput@myweb.nl"
* contact.telecom[=].use = #work
* contact.address.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-AddressInformation.AddressType"
* contact.address.extension.valueCodeableConcept = $v3-AddressUse#HP "Primary Home"
* contact.address.use = #home
* contact.address.type = #both
* contact.address.line = "1e Jacob van Campenstr 15"
* contact.address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* contact.address.line.extension[=].valueString = "1e Jacob van Campenstr"
* contact.address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* contact.address.line.extension[=].valueString = "15"
* contact.address.city = "Hoogmade"
* contact.address.district = "Kaag en Braassem"
* contact.address.postalCode = "1012 NX"
* contact.address.country.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification"
* contact.address.country.extension.valueCodeableConcept.coding.version = "2020-04-01T00:00:00"
* contact.address.country.extension.valueCodeableConcept.coding = urn:oid:2.16.840.1.113883.2.4.4.16.34#6030 "Nederland"
* contact.address.country = "Nederland"
* communication.extension[0].extension[0].url = "level"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityProficiency#G "Good"
* communication.extension[=].extension[+].url = "type"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityMode#RSP "Received spoken"
* communication.extension[=].url = "http://hl7.org/fhir/StructureDefinition/patient-proficiency"
* communication.extension[+].extension[0].url = "level"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityProficiency#F "Fair"
* communication.extension[=].extension[+].url = "type"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityMode#ESP "Expressed spoken"
* communication.extension[=].url = "http://hl7.org/fhir/StructureDefinition/patient-proficiency"
* communication.extension[+].extension[0].url = "level"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityProficiency#G "Good"
* communication.extension[=].extension[+].url = "type"
* communication.extension[=].extension[=].valueCoding = $v3-LanguageAbilityMode#RWR "Received written"
* communication.extension[=].url = "http://hl7.org/fhir/StructureDefinition/patient-proficiency"
* communication.extension[+].url = "http://nictiz.nl/fhir/StructureDefinition/ext-Comment"
* communication.extension[=].valueString = "Bij gesprek met arts zoon uitnodigen voor vertalen"
* communication.language = urn:oid:1.0.639.1#nl "Nederlands"