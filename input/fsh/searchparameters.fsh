Instance: CarePlan-subject-identifier
InstanceOf: SearchParameter
Usage: #definition
* url = "http://santeonnl.github.io/shared-care-planning/cps-searchparameter-careplan-subject-identifier.json"
* name = "subject-identifier"
* status = #active
* description = "Search CarePlans by subject identifier"
* code = #subject-identifier
* base = #CarePlan
* type = #token
* expression = "CarePlan.subject.identifier"
* xpathUsage = #normal
* xpath = "f:CarePlan/f:subject/f:identifier"