Alias: $conf     = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $security = http://terminology.hl7.org/CodeSystem/restful-security-service

Instance:       pa-referral-recipient
InstanceOf:     CapabilityStatement
* title       = "Physical Activity Referral Recipient Capability Statement"
* description = "Describes the expected capabilities of a system used by a personal trainer,
  community fitness organization, or other entity that delivers services that help a patient to
  improve or maintain their level of physical activity."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-referral-recipient"
* name        = "PAReferralRecipient"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "'Simple' referral recipients only act as RESTful clients.  Their data is stored
    on the [care manager](CapabilityStatement-pa-care-manager.html) system.  They access the server
    to retrieve data as well as to create and make change to existing data."
// TODO

// TODO: What includes/revincludes should be supported (if any)?  E.g. Provenance when retrieving
// history