# Authorization

Shared Care Planning involves authorizations to certain resources. Authorizations are described in an access policy. It is the responsibility of the systems of the Care Plan Contributor and Care Plan Service to adhere to the policy when resources are being requested.

Shared Care Planning involves two different access policies. 
1. The Care Plan Service policy controls access to the resources stored in the Care Plan Service (FHIR-ResourceTypes CarePlan, CareTeam and Task)
2. The Care Plan Contributor policy controls access to resources of which the Care Plan Contributior is Data Holder and controls access to notification service endpoints the Care Plan Contributor exposes.

## Care Plan Service Policy

The Care Plan Service Policy describes access to the resources stored in the Care Plan Service. When requesting an access token from the authorization server of the Care Plan Service, attributes of both the requesting organization and requesting person MUST be presented (see page Authentication for the exact requirements).



## Care Plan Contributor Policy

