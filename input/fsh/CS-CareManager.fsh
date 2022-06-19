Alias: $conf     = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $security = http://terminology.hl7.org/CodeSystem/restful-security-service

Instance:       pa-care-manager
InstanceOf:     CapabilityStatement
* title       = "Physical Activity Care Manager Capability Statement"
* description = "Describes the expected capabilities of a system that is responsible for managing 
  issues related to the physical activity level of a patient."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-care-manager"
* name        = "PACareManager"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "Care managers only act as clients in situation where they are interacting with 
    'advanced' [referral recipients](CapabilityStatement-pa-referral-recipient.html) which have their 
    own FHIR server interfaces.  In this mode, the Care Manager can create and/or retrieve 
    information from the referral recipient.  There is no expectation that [patient engagement](
    CapabilityStatement-pa-patient-engagement.html) systems will have their own FHIR server 
    interfaces."
* rest[+]
  * mode          = #server
  * documentation = "Care Managers act primarily as servers, allowing [referral recipients](
      CapabilityStatement-pa-referral-recipient.html) and [patient engagement systems](
      CapabilityStatement-pa-patient-engagement.html) to retrieve information stored on the
      manager, and in some cases to create and update information present on the manager."
  * security.service[+]  = $security#OAuth
  * security.description = "See additional guidance on the [security](security.html) page."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Observation
    * supportedProfile[+] = Canonical(EVSDaysPerWeek)
      * extension[$conf].valueCode = #SHALL
    * supportedProfile[+] = Canonical(EVSMinutesPerDay)
      * extension[$conf].valueCode = #SHALL
    * supportedProfile[+] = Canonical(ExerciseSupportDailyLog)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(ExerciseSupportHeartRate)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(ExerciseSupportSteps)
      * extension[$conf].valueCode = #SHOULD
    * documentation = "Exposes and allows manipulation of exercise vital sign and supporting
      observations"
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of observations referenced by other resources"
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows correction of or adding comments to previously recorded observations"
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #create
      * documentation = "Allows other systems to record physical-activity related observations"
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of observations for a given patient"
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/Observation-category"
      * type          = #token
      * documentation = "Allows retrieving only those observations related to physical activity.
        As well, many clinical systems will require searches to specify a category so the server
        knows which part of the database to search as different types of observations are stored in 
        different areas."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "code"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-code"
      * type          = #token
      * documentation = "Allows filtering to only retrieve a specific type of exercise vital sign
        or supporting observation."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "date"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-date"
      * type          = #date
      * documentation = "Allows filtering to only retrieve a observations from a particular time
        period."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those observations for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support cross-patient 
        search, at least through bulk-data interfaces for payer or researchuse."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/Observation-status"
      * type          = #token
      * documentation = "Allows excluding entered-in-error or non-final observations."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "value-quantity"
      * definition    = "http://hl7.org/fhir/SearchParameter/Observation-value-quantity"
      * type          = #quantity
      * documentation = "Allows retrieval of only those observations that fall in a particular
        range.  Particularly useful for cross-patient queries."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Goal
    * supportedProfile[+] = Canonical(PAGoal)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Shares and, ideally, allows external systems to add and update goals"
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of goals referenced by other resources and/or checking
        to see if an existing known goal has changed."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows patients or service providers to modify a goal - for example shifting 
        target values or dates, updating the status, etc.  Allowing patients, care-givers and service 
        providersto help maintain goals is a key aspect of a patient-centered care plan.  However, not 
        all care manager systems (or their organizations) yet have the technical mechanisms or policies
        in place to support this."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #create
      * documentation = "Allows patients or service providers to add additional physical activity
        related goals.  As with updates, this is a key part of a patient-centered care plan, but not
        all systems or organizations will be able to do this"
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of goals for a given patient"
    * interaction[+]
      * extension[$conf].valueCode = #MAY
      * code          = #history-instance
      * documentation = "Allows seeing how goals have changed over time.  This may be particularly
        important if multiple stakeholders have the ability to make adjustments to goals.  However,
        history is not widely supported."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/Goal-category"
      * type          = #token
      * documentation = "Allows retrieving only those goals related to physical activity."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "lifecycle-status"
      * definition    = "http://hl7.org/fhir/SearchParameter/Goal-lifecycle-status"
      * type          = #token
      * documentation = "Allows filtering to only active, completed or other goal statuses."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those goals for a specific patient.  Most systems
        will treat this as a mandatory search parameter, though systems MAY support cross-patient 
        search, at least through bulk-data interfaces for payer or researchuse."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "target-date"
      * definition    = "http://hl7.org/fhir/SearchParameter/Goal-target-date"
      * type          = #date
      * documentation = "Allows filtering goals based on when they're to be achieved"


// TODO: What includes/revincludes should be supported (if any)?  E.g. Provenance when retrieving
// history