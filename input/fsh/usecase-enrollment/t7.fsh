Instance: cps-task-03
InstanceOf: SCPTask
Usage: #example
Title: "1.07.1 (sub-)Task 3 creation"
Description: "Ask for extra contact information for telemonitoring"
* meta.versionId = "1"
* basedOn = Reference(cps-careplan-01)
* partOf = Reference(cps-task-01)
* status = #ready
* intent = #order
* focus = Reference(cps-servicerequest-telemonitoring)
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-2"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-1"
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference.identifier.system = "urn:ietf:rfc:3986"
* input[=].valueReference.identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-2"
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference.identifier.system = "urn:ietf:rfc:3986"
* input[=].valueReference.identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-3"


Instance: cps-bundle-04
InstanceOf: Bundle
Usage: #example
Title: "1.07.2 Bundle"
Description: "Bundle to ask for contact information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-03, #POST, Task)
* insert BundleEntry(cps-questionnaire-patient-details, #PUT, Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-2)
* insert BundleEntry(cps-questionnaire-practitioner-details, #PUT, Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-3)

//resulting instances at cps:

Instance: cps-questionnaire-patient-details
InstanceOf: Questionnaire
Usage: #example
Title: "1.07.3 Questionnaire for patient details"
Description: "copy of MSC Questionnaire"
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

Instance: cps-questionnaire-practitioner-details
InstanceOf: Questionnaire
Usage: #example
Title: "1.07.4 Questionnaire for practitioner details"
Description: "copy of MSC Questionnaire"
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