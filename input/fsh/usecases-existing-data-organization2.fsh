Instance: medicalservicecentre-hospitalx
InstanceOf: Organization
Usage: #example
Title: "9.02 Organization Hospital X"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-1"
* name = "Hospital X"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@hospitalx.nl"
* telecom[=].use = #work
* address.line = "Koekoekslaan 1"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Koekoekslaan"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "1"
* address.city = "Nieuwegein"
* address.postalCode = "3435CM"


Instance: medicalservicecentre-medicalservicecentre
InstanceOf: Organization
Usage: #example
Title: "9.02 Organization Medical Service Centre"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-2"
* name = "Medical Service Centre"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@msc.nl"
* telecom[=].use = #work
* address.line = "Herculesplein 38"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Herculesplein"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "38"
* address.city = "Utrecht"
* address.postalCode = "3584 AA"


Instance: medicalservicecentre-carolinevandijk-hospitalx
InstanceOf: PractitionerRole
Usage: #example
Title: "9.02 PractitionerRole Caroline van Dijk at Hospital X"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* practitioner = Reference(medicalservicecentre-carolinevandijk)
* organization = Reference(medicalservicecentre-hospitalx)
* code.coding = $sct#17561000 "Cardiologist"
* specialty.coding = $sct#394579002 "Cardiology"
* telecom[+].system = #email
* telecom[=].value = "c.vandijk@hospitalx.nl"


Instance: medicalservicecentre-carolinevandijk
InstanceOf: Practitioner
Usage: #example
Title: "9.02 Practitioner Caroline van Dijk"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "Caroline van Dijk"
* name.family = "van Dijk"
* name.given = "Caroline"
* telecom[+].system = #phone
* telecom[=].value = "+31688888888"
* telecom[+].system = #email
* telecom[=].value = "caroline@vandijk.nl"