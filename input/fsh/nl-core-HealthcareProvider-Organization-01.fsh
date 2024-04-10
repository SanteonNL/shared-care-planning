Instance: nl-core-HealthcareProvider-Organization-01
InstanceOf: Organization
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "06020806"
* type[0].coding.version = "2020-10-23T00:00:00"
* type[=].coding = urn:oid:2.16.840.1.113883.2.4.6.7#0320 "Medisch specialisten, cardiologie"
* type[+] = $organization-type#V5 "Universitair Medisch Centrum"
* name = "Erasmus Universitair Medisch Centrum"
* telecom[0].system = #phone
* telecom[=].value = "+31107040704"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@erasmus.nl"
* telecom[=].use = #work
* address.extension.url = "http://nictiz.nl/fhir/StructureDefinition/ext-AddressInformation.AddressType"
* address.extension.valueCodeableConcept = $v3-AddressUse#WP "Work Place"
* address.use = #work
* address.line = "s-Gravendijkwal 230"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "s-Gravendijkwal"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "230"
* address.city = "Rotterdam"
* address.postalCode = "3015 CE"