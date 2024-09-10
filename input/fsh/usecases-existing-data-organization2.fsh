Instance: msc-hospitalx
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


Instance: msc-msc
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


Instance: msc-carolinevandijk-hospitalx
InstanceOf: PractitionerRole
Usage: #example
Title: "9.02 PractitionerRole Caroline van Dijk at Hospital X"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* identifier.system = $uzi
* identifier.value = "UZI-1"
* practitioner = Reference(urn:uuid:msc-carolinevandijk)
* organization = Reference(urn:uuid:msc-hospitalx)
* code.coding = $sct#17561000 "Cardiologist"
* specialty.coding = $sct#394579002 "Cardiology"
* telecom[+].system = #email
* telecom[=].value = "c.vandijk@hospitalx.nl"


Instance: msc-carolinevandijk
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

Instance: msc-msc-hcs
InstanceOf: HealthcareService
Usage: #example
Title: "9.02 HealthcareService Telemonitoring at Medical Service Centre"
Description: "Existing data in EHR of Medical Service Centre"
* active = true
* providedBy = Reference(urn:uuid:msc-msc)
* type[+] = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* type[+] = $sct#715191006 "monitoren van asthma via telegeneeskunde (regime/therapie)"
* type[+] = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#473199000 "monitoren van chronische ziekte via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#716358000 "monitoren van chronische obstructieve longziekte via telegeneeskunde (regime/therapie)" 
* name = "Medical Service Centre - Telemonitoring Services"

Instance: msc-questionnaire-telemonitoring-enrollment-criteria
InstanceOf: Questionnaire
Usage: #example
Title: "9.02 Questionnaire for telemonitoring - enrollment criteria"
Description: "Questionnaire for enrollment criteria for telemonitoring"
* meta.lastUpdated = "2024-09-02T13:40:17Z"
* meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
* meta.tag = $FHIR-version#4.0.1
* language = #nl-NL
* url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-1--20240902134017"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-1"
* name = "Telemonitoring - enrollment criteria"
* title = "Telemonitoring - enrollment criteria"
* status = #draft
* experimental = false
* date = "2024-09-02T13:40:17Z"
* publisher = "Medical Service Centre"
* effectivePeriod.start = "2024-09-02T13:40:17Z"
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2208"
* item[=].text = "Patient heeft smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2209"
* item[=].text = "Patient of mantelzorger leest e-mail op smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2210"
* item[=].text = "Patient of mantelzorger kan apps installeren op smartphone"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2211"
* item[=].text = "Patient of mantelzorger is Nederlandse taal machtig"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2212"
* item[=].text = "Patient beschikt over een weegschaal of bloeddrukmeter (of gaat deze aanschaffen)"
* item[=].type = #boolean
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false

Instance: msc-questionnaire-patient-details
InstanceOf: Questionnaire
Usage: #example
Title: "9.02 Questionnaire for patient details"
Description: "Questionnaire for patient details"
* meta.lastUpdated = "2024-09-02T13:40:17Z"
* meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
* meta.tag = $FHIR-version#4.0.1
* meta.profile[0] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
* language = #nl-NL
* url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-2--20240902134017"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-2"
* name = "patient contactdetails"
* title = "patient contactdetails"
* status = #draft
* experimental = false
* date = "2024-09-02T13:40:17Z"
* publisher = "Medical Service Centre"
* effectivePeriod.start = "2024-09-02T13:40:17Z"
* extension[0].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext"
* extension[=].extension[0].url = "name"
* extension[=].extension[=].valueCoding = $launchContext#patient
* extension[=].extension[+].url = "type"
* extension[=].extension[=].valueCode = #Patient
* extension[=].extension[+].url = "description"
* extension[=].extension[=].valueString = "The patient that is to be used to pre-populate the form"
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2233"
* item[=].text = "Naamgegevens"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "NameInformation"
* item[=].type = #group
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2234"
* item[=].item[=].text = "Voornamen"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "FirstNames"
* item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].extension.valueExpression.expression = "%patient.name.given.first()"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].readOnly = false
* item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2238"
* item[=].item[=].text = "Geslachtsnaam"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "LastName"
* item[=].item[=].type = #group
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].readOnly = false
* item[=].item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2239"
* item[=].item[=].item[=].text = "Voorvoegsels"
* item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].item[=].text.extension.extension[=].valueString = "Prefix"
* item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension.valueExpression.expression = "%patient.name.given.last()"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].required = false
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = false
* item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2240"
* item[=].item[=].item[=].text = "Achternaam"
* item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].item[=].text.extension.extension[=].valueString = "LastName"
* item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension.valueExpression.expression = "%patient.name.family"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].required = true
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2257"
* item[=].text = "Contactgegevens"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "ContactInformation"
* item[=].type = #group
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2258"
* item[=].item[=].text = "Telefoonnummers"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "TelephoneNumbers"
* item[=].item[=].type = #group
* item[=].item[=].required = true
* item[=].item[=].repeats = false
* item[=].item[=].readOnly = false
* item[=].item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2259"
* item[=].item[=].item.text = "Telefoonnummer"
* item[=].item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item.text.extension.extension[0].url = "lang"
* item[=].item[=].item.text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item.text.extension.extension[+].url = "content"
* item[=].item[=].item.text.extension.extension[=].valueString = "TelephoneNumber"
* item[=].item[=].item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item.extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item.extension.valueExpression.expression = "%patient.telecom.where(system='phone').value"
* item[=].item[=].item.type = #string
* item[=].item[=].item.required = true
* item[=].item[=].item.repeats = false
* item[=].item[=].item.readOnly = false
* item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2263"
* item[=].item[=].text = "EmailAdressen"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "EmailAddresses"
* item[=].item[=].type = #group
* item[=].item[=].required = true
* item[=].item[=].repeats = false
* item[=].item[=].readOnly = false
* item[=].item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2264"
* item[=].item[=].item.text = "EmailAdres"
* item[=].item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item.text.extension.extension[0].url = "lang"
* item[=].item[=].item.text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item.text.extension.extension[+].url = "content"
* item[=].item[=].item.text.extension.extension[=].valueString = "EmailAddress"
* item[=].item[=].item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item.extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item.extension.valueExpression.expression = "%patient.telecom.where(system='email').value"
* item[=].item[=].item.type = #string
* item[=].item[=].item.required = true
* item[=].item[=].item.repeats = false
* item[=].item[=].item.readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2266"
* item[=].text = "Burgerservicenummer (OID: 2.16.840.1.113883.2.4.6.3)"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "Burgerservicenummer (OID: 2.16.840.1.113883.2.4.6.3)"
* item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].extension.valueExpression.language = #text/fhirpath
* item[=].extension.valueExpression.expression = "%patient.identifier.where(system='http://fhir.nl/fhir/NamingSystem/bsn').value"
* item[=].type = #string
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2267"
* item[=].text = "Geboortedatum"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "DateOfBirth"
* item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].extension.valueExpression.language = #text/fhirpath
* item[=].extension.valueExpression.expression = "%patient.birthDate"
* item[=].type = #dateTime
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2268"
* item[=].text = "Geslacht"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "Gender"
* item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].extension.valueExpression.language = #text/fhirpath
* item[=].extension.valueExpression.expression = "%patient.gender"
* item[=].type = #choice
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
// * item[=].answerOption[0].valueCoding = $v3-AdministrativeGender#UN "Undifferentiated"
// * item[=].answerOption[+].valueCoding = $v3-AdministrativeGender#M "Male"
// * item[=].answerOption[+].valueCoding = $v3-AdministrativeGender#F "Female"
// * item[=].answerOption[+].valueCoding = $v3-NullFlavor#UNK "Unknown"
* item[=].answerOption[0].valueCoding = http://hl7.org/fhir/administrative-gender#other "Other"
* item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#male "Male"
* item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#female "Female"
* item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#unknown "Unknown"



Instance: msc-questionnaire-practitioner-details
InstanceOf: Questionnaire
Usage: #example
Title: "9.02 Questionnaire for practitioner details"
Description: "Questionnaire for practitioner details"
* meta.lastUpdated = "2024-09-02T13:40:17Z"
* meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
* meta.tag = $FHIR-version#4.0.1
* meta.profile[0] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
* language = #nl-NL
* url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-3--20240902134017"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-3"
* name = "practitioner details"
* title = "practitioner details"
* status = #draft
* experimental = false
* date = "2024-09-02T13:40:17Z"
* publisher = "Medical Service Centre"
* effectivePeriod.start = "2024-09-02T13:40:17Z"
* extension[+].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext"
* extension[=].extension[0].url = "name"
* extension[=].extension[=].valueCoding = $launchContext#user
* extension[=].extension[+].url = "type"
* extension[=].extension[=].valueCode = #Practitioner
* extension[=].extension[+].url = "description"
* extension[=].extension[=].valueString = "The practitioner user that is to be used to pre-populate the form"
* item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2274"
* item[=].text = "Naamgegevens"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "NameInformation"
* item[=].type = #group
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2275"
* item[=].item[=].text = "Voornamen"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "FirstNames"
* item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].extension.valueExpression.expression = "%user.name.given.first()"
* item[=].item[=].type = #string
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].readOnly = false
* item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2279"
* item[=].item[=].text = "Geslachtsnaam"
* item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].text.extension.extension[=].valueString = "LastName"
* item[=].item[=].type = #group
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].readOnly = false
* item[=].item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2280"
* item[=].item[=].item[=].text = "Voorvoegsels"
* item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].item[=].text.extension.extension[=].valueString = "Prefix"
* item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension.valueExpression.expression = "%user.name.given.last()"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].required = true
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = false
* item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2281"
* item[=].item[=].item[=].text = "Achternaam"
* item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item[=].item[=].text.extension.extension[0].url = "lang"
* item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
* item[=].item[=].item[=].text.extension.extension[+].url = "content"
* item[=].item[=].item[=].text.extension.extension[=].valueString = "LastName"
* item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension.valueExpression.expression = "%user.name.family"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].required = true
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2300"
* item[=].text = "Contactgegevens"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "ContactInformation"
* item[=].type = #group
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2306"
* item[=].item.text = "EmailAdressen"
* item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item.text.extension.extension[0].url = "lang"
* item[=].item.text.extension.extension[=].valueCode = #en-US
* item[=].item.text.extension.extension[+].url = "content"
* item[=].item.text.extension.extension[=].valueString = "EmailAddresses"
* item[=].item.type = #group
* item[=].item.required = true
* item[=].item.repeats = false
* item[=].item.readOnly = false
* item[=].item.item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2307"
* item[=].item.item.text = "EmailAdres"
* item[=].item.item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item.item.text.extension.extension[0].url = "lang"
* item[=].item.item.text.extension.extension[=].valueCode = #en-US
* item[=].item.item.text.extension.extension[+].url = "content"
* item[=].item.item.text.extension.extension[=].valueString = "EmailAddress"
* item[=].item.item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
* item[=].item.item.extension.valueExpression.language = #text/fhirpath
* item[=].item.item.extension.valueExpression.expression = "%user.telecom.where(system='email').value"
* item[=].item.item.type = #string
* item[=].item.item.required = true
* item[=].item.item.repeats = false
* item[=].item.item.readOnly = false
* item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2309"
* item[=].text = "Zorgaanbieder"
* item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].text.extension.extension[0].url = "lang"
* item[=].text.extension.extension[=].valueCode = #en-US
* item[=].text.extension.extension[+].url = "content"
* item[=].text.extension.extension[=].valueString = "HealthcareProvider"
* item[=].type = #group
* item[=].required = true
* item[=].repeats = false
* item[=].readOnly = false
* item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2310"
* item[=].item.text = "Zorgaanbieder"
* item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
* item[=].item.text.extension.extension[0].url = "lang"
* item[=].item.text.extension.extension[=].valueCode = #en-US
* item[=].item.text.extension.extension[+].url = "content"
* item[=].item.text.extension.extension[=].valueString = "HealthcareProvider"
* item[=].item.type = #group
* item[=].item.required = true
* item[=].item.repeats = false
* item[=].item.readOnly = false

// Instance: msc-actdef-telemon-heartfailure
// InstanceOf: ActivityDefinition
// Usage: #example
// Title: "9.02 ActivityDefinition for telemonitoring heartfailure patients"
// * url = "http://medicalservicecentre.nl/assets/ActivityDefinition/telemon-heartfailure"
// * title = "Telemonitoring for heartfailure patients"
// * description = "Telemonitoring for heartfailure patients"
// * status = #active
// * version = "1.0.0 - initial version"
// * kind = http://hl7.org/fhir/request-resource-types#ServiceRequest
// * intent = #order
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * useContext[+].code = $usage-context-type#focus "Focus"
// * useContext[=].valueCodeableConcept = $sct#195111005 "Heart failure"

// Instance: msc-actdef-telemon-copd
// InstanceOf: ActivityDefinition
// Usage: #example
// Title: "9.02 ActivityDefinition for telemonitoring COPD patients"
// * url = "http://medicalservicecentre.nl/assets/ActivityDefinition/telemon-copd"
// * title = "Telemonitoring for COPD patients"
// * description = "Telemonitoring for COPD patients"
// * status = #active
// * version = "1.0.0 - initial version"
// * kind = http://hl7.org/fhir/request-resource-types#ServiceRequest
// * intent = #order
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * useContext[+].code = $usage-context-type#focus "Focus"
// * useContext[=].valueCodeableConcept = $sct#13645005 "Chronic obstructive pulmonary disease"

Instance: msc-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "9.02 Bundle"
Description: "Existing data in EHR of MedicalServiceCentre"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryWithFullurl(urn:uuid:msc-hospitalx, msc-hospitalx, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:msc-msc, msc-msc, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:msc-carolinevandijk-hospitalx, msc-carolinevandijk-hospitalx, #POST, PractitionerRole)
* insert BundleEntryWithFullurl(urn:uuid:msc-carolinevandijk, msc-carolinevandijk, #POST, Practitioner)
* insert BundleEntryWithFullurl(urn:uuid:msc-msc-hcs, msc-msc-hcs, #POST, HealthcareService)
* insert BundleEntryWithFullurl(urn:uuid:msc-questionnaire-telemonitoring-enrollment-criteria, msc-questionnaire-telemonitoring-enrollment-criteria, #POST, Questionnaire)
* insert BundleEntryWithFullurl(urn:uuid:msc-questionnaire-patient-details, msc-questionnaire-patient-details, #POST, Questionnaire)
* insert BundleEntryWithFullurl(urn:uuid:msc-questionnaire-practitioner-details, msc-questionnaire-practitioner-details, #POST, Questionnaire)