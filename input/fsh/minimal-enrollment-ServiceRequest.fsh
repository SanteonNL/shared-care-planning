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