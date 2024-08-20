Instance: Patient1
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

Instance: nl-core-CareTeam-01-Condition-01
InstanceOf: Condition
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#282291009 "Interpretatie van diagnose"
* code = $sct#429998004 "vasculaire dementie"
* subject = Reference(nl-core-Patient-01) "Patient, Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* subject.type = "Patient"
* note.text = "De laatste weken erg onrustig in de nacht"

Instance: nl-core-CareTeam-01-Condition-02
InstanceOf: Condition
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#282291009 "Interpretatie van diagnose"
* code = $sct#195111005 "Hartfalen"
* subject = Reference(nl-core-Patient-01) "Patient, Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* subject.type = "Patient"
* note.text = "Houdt veel vocht vast, kortademig"

Instance: nl-core-CareTeam-01-Condition-03
InstanceOf: Condition
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#116223007 "Complicatie"
* code = $sct#62014003 "Geneesmiddel-interacties"
* subject = Reference(nl-core-Patient-01) "Patient, Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* subject.type = "Patient"
* note.text = "Huiduitslag met veel jeuk door medicatie"

// PractitionerRole1
Instance: nl-core-CareTeam-01-PractitionerRole-06
InstanceOf: PractitionerRole
Usage: #example
* practitioner = Reference(nl-core-CareTeam-01-Practitioner-06) "Healthcare professional (person), K. van der Linden"
* practitioner.type = "Practitioner"


Instance: minimal-enrollment-Practitioner-HP
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "H.B. Hoofdbehandelaar"
* name.family.extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.family.extension.valueString = "Hoofdbehandelaar"
* name.family = "Hoofdbehandelaar"
* name.given = "Hendrik Bernard"
* name.given.extension.url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given.extension.valueCode = #IN
* name.prefix = "Prof."
* telecom[+].system = #phone
* telecom[=].value = "+31688888888"
* telecom[+].system = #email
* telecom[=].value = "hb@icloud.com"



Instance: Organization1
InstanceOf: Organization
Usage: #example
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "1"
* name = "Hospital X"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
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


Instance: Organization2
InstanceOf: Organization
Usage: #example
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "2"
* name = "Medical Service Centre"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
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

Instance: minimal-enrollment-ServiceRequest
InstanceOf: ServiceRequest
Usage: #example
* status = #draft
* intent = #order
* subject = Reference(minimal-enrollment-Patient) "Patient, Jean Jacques van Putten-van der Giessen"
* subject.type = "Patient"
* requester = Reference(minimal-enrollment-Organization-Requester) "Requester Organization St. Antonius Ziekenhuis"
* requester.type = "Organization"
* performer = Reference(minimal-enrollment-Organization-Performer) "Performer Organization Zorg bij jou"
* performer.type = "Organization"
* code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
//* orderDetail.text = "COPD Thuismonitoring pakket Light"
* reasonReference = Reference(minimal-enrollment-Condition) "Diagnose Hartfalen"
//* patientInstruction = "# streefwaarden\n- 30 kg\n- 180 cm\n# aantekeningen\n- Grote hond\n-grote mond\n"