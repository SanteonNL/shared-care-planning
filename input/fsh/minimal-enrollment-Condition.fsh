Instance: minimal-enrollment-Condition
InstanceOf: Condition
Usage: #example

* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#282291009 "Interpretatie van diagnose"
* code = $sct#195111005 "Hartfalen"
* subject = Reference(minimal-enrollment-Patient) "Patient, Jean Jacques van Putten-van der Giessen"
* subject.type = "Patient"
* note.text = "Hier een zinnige tekst over de diagnose Hartfalen"