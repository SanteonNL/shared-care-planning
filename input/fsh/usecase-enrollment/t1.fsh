Instance: cps-careplan1-01
InstanceOf: SCPCareplan
Usage: #example
Title: "1.01 CarePlan creation"
Description: "Initiation of a care plan for a patient with Heartfailure"
* meta.versionId = "1"
* status = #active
* intent = #order
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject = Reference(cps-patrick)
* subject.display = "Patrick Egger"
* careTeam = Reference(cps-careteam1-01)
* addresses[+] = Reference(hospitalx-heartfailure)
* addresses[=].display = "Heartfailure"
* addresses[+] = Reference(hospitalx-copd)
* addresses[=].display = "COPD"
* author = Reference(cps-carolinevandijk-hospitalx) 
* author.display = "Caroline van Dijk at Hospital X"
//* supportingInfo = Reference(hospitalx-medication-rash)


Instance: cps-careteam1-01
InstanceOf: SCPCareTeam
Usage: #example
Title: "1.01 CareTeam creation"
Description: "Initiation of a care team for a patient with Heartfailure"
* meta.versionId = "1"
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject = Reference(cps-patrick) 
* subject.display = "Patrick Egger"

Instance: cps-patrick
InstanceOf: Patient
Usage: #inline
Title: "1.01 Patient Patrick Egger"
Description: "copy patient to CPS if it doesn't exist"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* name
  * given[0] = "Patrick"
  * family = "Egger"
* telecom[+].system = #phone
* telecom[=].value = "+31612345678"
* telecom[+].system = #email
* telecom[=].value = "patrickegger@myweb.nl"
* gender = #male
* birthDate = "1984-04-01"

Instance: cps-carolinevandijk-hospitalx
InstanceOf: PractitionerRole
Usage: #inline
Title: "1.01 PractitionerRole Caroline van Dijk at Hospital X"
Description: "copy PractitionerRole to CPS if it doesn't exist"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/uzi"
* identifier.value = "UZI-1"
* practitioner = Reference(hospitalx-carolinevandijk)
* organization = Reference(cps-hospitalx)
* code.coding = $sct#17561000 "Cardiologist"
* specialty.coding = $sct#394579002 "Cardiology"
* telecom[+].system = #email
* telecom[=].value = "c.vandijk@hospitalx.nl"

Instance: cps-hospitalx
InstanceOf: Organization
Usage: #inline
Title: "1.01 Organization Hospital X"
Description: "copy Organization to CPS if it doesn't exist"
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

Instance: hospitalx-bundle1-01
InstanceOf: Bundle
Usage: #example
Title: "1.01 Bundle to create CarePlan and CareTeam"
* type = #transaction
* insert BundleEntry(cps-careplan1-01, #POST, CarePlan)
* insert BundleEntry(cps-careteam1-01, #POST, CareTeam)
* insert BundleEntry(cps-patrick, #POST, Patient)
* entry[=].request.ifNoneExist = "identifier=http://fhir.nl/fhir/NamingSystem/bsn|111222333"
* insert BundleEntry(cps-carolinevandijk-hospitalx, #POST, PractitionerRole)
* entry[=].request.ifNoneExist = "identifier=http://fhir.nl/fhir/NamingSystem/uzi|UZI-1"
* insert BundleEntry(cps-hospitalx, #POST, Organization)
* entry[=].request.ifNoneExist = "identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-1"