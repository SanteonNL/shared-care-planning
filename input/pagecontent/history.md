<div markdown="1" class="w-100 bg-info">

> [Open issues are discussed/located on the Github repository](https://github.com/SanteonNL/shared-care-planning/issues)

</div>


### Version: current
[Source code](https://github.com/SanteonNL/shared-care-planning), [Compare to version 0.1.0](https://github.com/SanteonNL/shared-care-planning/compare/main...0.1.0).  
Significant changes/Closed issues:


### Version: 0.2.0
- Added use-case [Enroll patient in home monitoring](./usecase-enrollment.html) with example instances and transactions (notifications are work in progress). Lessons learned:
  - During the 'Task negotiation' some data needs to be copied to the CarePlanService because the target CarePlanContributor (Task filler) is (often) not able to read data from the source CarePlanContributor (Task requester). Using instances in transaction Bundles in stead of Contained resources, because separate instances might be referred to by multiple other instances and support for metadata (meta.source, meta.lastupdated)
    - CarePlan Contributor should not create CarePlan; easier and more reliable to create CarePlan at CarePlanService
- Artifacts: cleaned up artifacts and created some (small) profiles (structuredefinitions)
- Auth: describe relation between Verifiable Credentials and FHIR Organization
- [issue #48](https://github.com/SanteonNL/shared-care-planning/issues/48): Task to get additional information for parent-Task


### Version: 0.1.0
Date: 2024-07-18, [Source code](https://github.com/SanteonNL/shared-care-planning/tree/0.1.0)