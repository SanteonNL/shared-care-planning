The [FHIR Subscription Framework](https://build.fhir.org/subscriptions.html) facilitates real-time event notifications from a FHIR server to other systems. It uses three core resources: SubscriptionTopic (defining events and triggers), Subscription (describing client requests for notifications), and notification Bundles (containing an event-notification, handshake-notification or heartbeat-notification). Clients request notifications based on specific topics, and servers send them using different communication channels. There are two subscription management styles: In-Band (client-managed) and Out-of-Band (server-managed). These interactions may involve technologies like REST hooks or websockets, allowing clients to receive notifications based on predefined conditions. 
In essence, the Out-of-Band (server-managed) style transfers much of the management burden from the client to the server, with the server being responsible for event processing, notification delivery, and system resilience.

#### Notifications in Shared Care Planning

> Within Shared Care Planning, the Out-of-Band (server-managed) subscription style and REST hook channel shall be used. The default endpoint for notification bundles is the FHIR base url (a local API gateway or proxy should be able to handle/forward notification bundles). SCP uses a SubscriptionTopic, which is triggered if your organization is a participant in a SCP-Task or SCP-CarePlan.

#### Example subscription sequence
If Organization-1 creates a Task for PractitionerRole-2 in the local SCP-node, the folowing steps are taken:
- the (local) subscription manager searches the care services directory to get to the FHIR endpoint of PractitionerRole-2 that supports Shared Care Planning. This may involve multiple queries from PractitionerRole-2 to parent organization(s) to an endpoint-resource
- the (local) subscription manager searches for an existing subscription-instance for this endpoint and SubscriptionTopic 'isParticipantInInstance'. If no subscription exists, a new subscription is created and a handshake-notification-bundle is send to the endpoint.
- the (local) subscription manager stores the notification-event (with incremented event-number) and sends the notification-event to the endpoint of PractitionerRole-2 (this may involve retries).
- the (local) subscription manager regularly sends a heartbeat-notification bundle that contains the subscription status and highest event-number. (this may involve retries)
- the subscription client checks each notification-bundle if it hasn't missed any events and it regularly checks if it missed a heartbeat-notification.

#### Required capabilities: endpoint

A Shared Care Planning **endpoint** shall implement the following capabilities:
- support the `Subscription` resource
    - support the `read` interaction
    - support the `search` interaction
        - support searchparameters `status`,`criteria`, `channel.endpoint`, `channel.type` and `channel.payload`
    - support operations `$status` and `$event`
    - supports channel type `rest-hook`
    - supports payload type `id-only`. 

A Shared Care Planning endpoint may support additional capabilities like other payloads or channel types. It's up to subscription manager to decide which e.g. channel/payload type to use given the joint capabilities of both subscription manager and client.

#### Required capabilities: subscription manager

A Shared Care Planning node shall implement the role of a **subscription manager** for out-of-band style subscriptions, i.e.:
- create/update subscriptions for the 'isParticipantInInstance' topic
- send handshake-notifcation-bundles when subscription.status is `requested` (which may involve retries) and update the subscription.status accordingly
- send heartbeat-notifcation-bundles at predefined intervals (which may involve retries) and update the subscription.status accordingly
- send event-notification-bundles (and incrementing the event-number in a concurrent-save way)

#### Required capabilities: subscription client

A Shared Care Planning node shall implement the role of a **subscription client** for out-of-band style subscriptions, i.e.:
- receiving notification-bundles (and forwarding/acting on these notificatiuon-bundles)
- checks each notification-bundle if it hasn't missed any events (using the highest event-number it succesfully processed). Missed notifications are caught up using the $event operation
- checks at predefined intervals if it missed a heartbeat-notification. If a heartbeat-notification is missing, the subscription status is queried using the $status operation.

The subscription client, being responsible for resolving failures, should also track the subscription's state to highlight and fix any erroneous communication.

In order to implement this subscription framework in FHIR version R4, the [Subscriptions R5 Backport for R4](https://hl7.org/fhir/uv/subscriptions-backport/) is used.
Check out the example instances for a [subscription](Subscription-cps-sub-hospitalx.json.html) or [notification-bundle](Bundle-notification-hospitalx-01.json.html).