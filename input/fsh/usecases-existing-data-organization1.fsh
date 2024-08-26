Instance: patient-patrick
InstanceOf: Patient
Title: "Patient Patrick Egger"
Description: "An example of a SCP patient."
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* name
  * given[0] = "Patrick"
  * family = "Egger"
* telecom[+].system = #phone
* telecom[=].value = "+31612345678"
* telecom[+].system = #email
* telecom[=].value = "patrickegger@myweb.nl"
* gender = #female
* birthDate = "1984-04-01"

Instance: condition-dementia
InstanceOf: Condition
Usage: #example
Title: "Diagnose vasculaire dementie"
Description: "An example of a diagnosis of vascular dementia."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#282291009 "Interpretatie van diagnose"
* code = $sct#429998004 "vasculaire dementie"
* subject = Reference(patient-patrick) // Patient Patrick Egger
* subject.type = "Patient"
* note.text = "De laatste weken erg onrustig in de nacht"

Instance: condition-heartfailure
InstanceOf: Condition
Usage: #example
Title: "Diagnose hartfalen"
Description: "An example of a diagnosis of heart failure."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#282291009 "Interpretatie van diagnose"
* code = $sct#195111005 "Hartfalen"
* subject = Reference(patient-patrick) // Patient Patrick Egger
* subject.type = "Patient"
* note.text = "Hier een zinnige tekst over de diagnose Hartfalen"


Instance: condition-medication-rash
InstanceOf: Condition
Usage: #example
Title: "Skin rash due to medication"
Description: "An example of a skin rash due to medication."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#116223007 "Complicatie"
* code = $sct#62014003 "Geneesmiddel-interacties"
* subject = Reference(patient-patrick) // Patient Patrick Egger
* subject.type = "Patient"
* note.text = "Huiduitslag met veel jeuk door medicatie"

// PractitionerRole1
Instance: practitionerrole-vanderLinden
InstanceOf: PractitionerRole
Usage: #example
Title: "Healthcare professional (role), K. van der Linden"
* practitioner = Reference(practitioner-vanderLinden)
* practitioner.type = "Practitioner"


Instance: practitioner-vanderLinden
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "K. van der Linden"
* name.family = "van der Linden"
* name.given = "Karel"
* name.given.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given.extension.valueCode = #IN
* name.prefix = "Prof."
* telecom[+].system = #phone
* telecom[=].value = "+31688888888"
* telecom[+].system = #email
* telecom[=].value = "hb@icloud.com"


Instance: organization-hospital
InstanceOf: Organization
Usage: #example
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-1"
* name = "Hospital X"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@erasmus.nl"
* telecom[=].use = #work
* address.line = "s-Gravendijkwal 230"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "s-Gravendijkwal"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "230"
* address.city = "Rotterdam"
* address.postalCode = "3015 CE"


Instance: organization-medicalservicecentre
InstanceOf: Organization
Usage: #example
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-2"
* name = "Medical Service Centre"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@erasmus.nl"
* telecom[=].use = #work
* address.line = "s-Gravendijkwal 230"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "s-Gravendijkwal"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "230"
* address.city = "Rotterdam"
* address.postalCode = "3015 CE"

Instance: servicerequest-telemonitoring
InstanceOf: ServiceRequest
Usage: #example
* status = #active
* intent = #order
* subject = Reference(patient-patrickegger) "Patient Patrick Egger"
* subject.type = "Patient"
* requester = Reference(organization-hospital) "Hospital X"
* performer = Reference(organization-medicalservicecentre) "Medical Service Centre"
* performer.type = "Organization"
* code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
//* orderDetail.text = "COPD Thuismonitoring pakket Light"
* reasonReference = Reference(minimal-enrollment-Condition) "Diagnose Hartfalen"
//* patientInstruction = "# streefwaarden\n- 30 kg\n- 180 cm\n# aantekeningen\n- Grote hond\n-grote mond\n"

// Instance: scp-req-bloedpanel
// InstanceOf: ServiceRequest
// Title: "Request: Compleet bloedbeeld bepalen"

// * status = #active
// * intent = #order
// * code = LOINC#58410-2 "Compleet bloedbeeld panel in bloed d.m.v. geautomatiseerde telling"
// * subject = Reference(SharonCynthiaProef)