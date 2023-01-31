Alias: $conf     = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $security = http://terminology.hl7.org/CodeSystem/restful-security-service

Instance:       pa-patient-engagement
InstanceOf:     CapabilityStatement
Usage:          #definition
* title       = "Physical Activity Patient Engagement Capability Statement"
* description = "Describes the expected capabilities of a system intended for use by patients and
  caregivers of patients who are working to enhance or maintain their levels of physical activity.
  These will typically be web-based or mobile applications."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-patient-engagement"
* name        = "PAPatientEngagement"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "Systems for patients  only act as RESTful clients.  While they may create and
    store some of their own data, this data is always made available by 'pushing' it to the server
    of a [care manager](CapabilityStatement-pa-care-manager.html) or, more rarely, a
    [service providers](CapabilityStatement-pa-service-provider.html) system.  Key data such as 
    the care plan, goals, condition and other information only resides on the care manager system."

// TODO

// TODO: What includes/revincludes should be supported (if any)?  E.g. Provenance when retrieving
// history