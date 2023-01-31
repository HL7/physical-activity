Alias: $conf     = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $security = http://terminology.hl7.org/CodeSystem/restful-security-service

Instance:       pa-care-manager
InstanceOf:     CapabilityStatement
Usage:          #definition
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
    'advanced' [service providers](CapabilityStatement-pa-service-provider.html) which have their 
    own FHIR server interfaces.  In this mode, the Care Manager can create and/or retrieve 
    information from the referral recipient.  There is no expectation that [patient engagement](
    CapabilityStatement-pa-patient-engagement.html) systems will have their own FHIR server 
    interfaces."
* rest[+]
  * mode          = #server
  * documentation = "Care Managers act primarily as servers, allowing [service providers](
      CapabilityStatement-pa-service-provider.html) and [patient engagement systems](
      CapabilityStatement-pa-patient-engagement.html) to retrieve information stored on the
      manager, and in some cases to create and update information present on the manager."
  * security.service[+]  = $security#OAuth
  * security.description = "See additional guidance on the [security](security.html) page."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #CarePlan
    * supportedProfile[+] = Canonical(PACarePlan)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Shares and, ideally, allows external systems to add and update care plans."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of care plans referenced by other resources and/or checking
        to see if an existing known care plan has changed."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows patients or service providers to modify a care plan.  Allowing 
        patients, care-givers and service providers to help maintain care plans is a key aspect of 
        a patient-centered care plan.  However, not all care manager systems (or their organizations)
        yet have the technical mechanisms or policies in place to support this."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #create
      * documentation = "Allows patients or service providers to add additional physical activity
        related care plans.  As with updates, this is a key part of a patient-centered care plan, 
        but not all systems or organizations will be able to do this."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of care plans for a given patient."
    * interaction[+]
      * extension[$conf].valueCode = #MAY
      * code          = #history-instance
      * documentation = "Allows seeing how a care plan has changed over time.  This may be 
        particularly important if multiple stakeholders have the ability to make adjustments to 
        the plan.  However, history is not widely supported."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/CarePlan-category"
      * type          = #token
      * documentation = "Allows retrieving only those plans related to physical activity."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "date"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-date"
      * type          = #date
      * documentation = "Allows filtering plans based on the time frame they apply(ied) to."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "lifecycle-status"
      * definition    = "http://hl7.org/fhir/SearchParameter/CarePlan-status"
      * type          = #token
      * documentation = "Allows filtering to only active or draft plans."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those plans for a specific patient.  Most systems
        will treat this as a mandatory search parameter, though systems MAY support cross-patient 
        search, at least through bulk-data interfaces for payer or research use."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Condition
    * supportedProfile[+] = Canonical(LowPACondition)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Shares information about any concerns about a patient's physical activity
      level.  There is no expectation that Conditions can be created or modified by other systems."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of care plans referenced by other resources and/or checking
        to see if an existing known care plan has changed."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of conditions for a given patient."
    * interaction[+]
      * extension[$conf].valueCode = #MAY
      * code          = #history-instance
      * documentation = "Allows seeing how a condition has changed over time."
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/Condition-category"
      * type          = #token
      * documentation = "Allows retrieving only those plans related to physical activity."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "clinical-status"
      * definition    = "http://hl7.org/fhir/SearchParameter/Condition-clinical-status"
      * type          = #token
      * documentation = "Allows filtering to only active conditions."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "code"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-code"
      * type          = #token
      * documentation = "Allows retrieving specific patient conditions - e.g. all 'low physical
        activity' conditions."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those plans for a specific patient.  Most systems
        will treat this as a mandatory search parameter, though systems MAY support cross-patient 
        search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "verification-status"
      * definition    = "http://hl7.org/fhir/SearchParameter/Condition-verification-status"
      * type          = #token
      * documentation = "Allows excluding refuted or erroneous conditions."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Consent
    * supportedProfile[+] = Canonical(SDOHCCConsent)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows recording and retrieval of consent allowing sharing of clinical data
      with other (particularly non-HIPAA) providers."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of referral referenced by other resources (e.g. referrals)."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows searching for existing consents."
    * referencePolicy = #literal
    * searchInclude[+] = "Consent:source-reference:DocumentReference"
      * extension[$conf].valueCode = #SHOULD
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "actor"
      * definition    = "http://hl7.org/fhir/SearchParameter/Consent-actor"
      * type          = #reference
      * documentation = "Allows filtering by an intended data recipient for the consent."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/Consent-category"
      * type          = #token
      * documentation = "Allows filtering to only information disclosure consents."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to consents for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support 
        cross-patient search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "source-reference"
      * definition    = "http://hl7.org/fhir/SearchParameter/Consent-source-reference"
      * type          = #reference
      * documentation = "Allows including the document that contains the PDF or similar representation 
        of a paper consent."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #DocumentReference
    * supportedProfile[+] = Canonical(USCoreDocumentReferenceProfile)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows retrieving PDFs or similar content referenced by a Consent or Task."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieving a PDF, image, or other document referenced by another 
        resource."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows monitoring of previously-retrieved DocumentReferences in the event the
        image/document is amended, corrected, or updated."
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Goal
    * supportedProfile[+] = Canonical(PAGoal)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Shares and, ideally, allows external systems to add and update goals."
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
        providers to help maintain goals is a key aspect of a patient-centered care plan.  However, 
        not all care manager systems (or their organizations) yet have the technical mechanisms or 
        policies in place to support this."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #create
      * documentation = "Allows patients or service providers to add additional physical activity
        related goals.  As with updates, this is a key part of a patient-centered care plan, but not
        all systems or organizations will be able to do this."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of goals for a given patient."
    * interaction[+]
      * extension[$conf].valueCode = #MAY
      * code          = #history-instance
      * documentation = "Allows seeing how goals have changed over time.  This may be particularly
        important if multiple stakeholders have the ability to make adjustments to goals.  However,
        history is not widely supported."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
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
        search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "target-date"
      * definition    = "http://hl7.org/fhir/SearchParameter/Goal-target-date"
      * type          = #date
      * documentation = "Allows filtering goals based on when they're to be achieved."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Observation
    * supportedProfile[+] = Canonical(EVSDaysPerWeek)
      * extension[$conf].valueCode = #SHALL
    * supportedProfile[+] = Canonical(EVSMinutesPerDay)
      * extension[$conf].valueCode = #SHALL
    * supportedProfile[+] = Canonical(ExerciseMinutesPerWeek)
      * extension[$conf].valueCode = #SHALL
    * supportedProfile[+] = Canonical(StrengthDaysPerWeek)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(ActivityMeasure)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(ActivityGroup)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(TimeMeasure)
      * extension[$conf].valueCode = #SHOULD
    * documentation = "Exposes and allows manipulation of exercise vital sign and supporting
      observations."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of observations referenced by other resources."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows correction of or adding comments to previously recorded 
        observations."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #create
      * documentation = "Allows other systems to record physical-activity related observations."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of observations for a given patient."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
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
        search, at least through bulk-data interfaces for payer or research use."
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
    * type = #DiagnosticReport
    * supportedProfile[+] = Canonical(PADiagnosticReport)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows recording and retrieval of the reports on physical 
      activity-related interventions."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #create
      * documentation = "Allows recording of reports about physical activity interventions."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows updating/correcting a report on physical activity interventions.  E.g. updating to
        change status, add notes, etc."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of the report(s) referenced by Task output."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows searching for reports for a particular patient or checking
        for updates to previously retrieved records."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known reports - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "basedOn"
      * definition    = "http://hl7.org/fhir/SearchParameter/Procedure-based-on"
      * type          = #reference
      * documentation = "Allows filtering to reports created in fulfillement of a particular
        order or referral."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "code"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-code"
      * type          = #token
      * documentation = "Allows filtering to specific types of reports."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "date"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-date"
      * type          = #date
      * documentation = "Allows filtering reports based on the period the cover."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/Procedure-category"
      * type          = #token
      * documentation = "Allows retrieving only those reports related to physical activity."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those reports for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support 
        cross-patient search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "performer"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-performer"
      * type          = #reference
      * documentation = "Allows filtering to only retrieve reports created by a specific performer."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-status"
      * type          = #token
      * documentation = "Allows filtering to only retrieve active or completed reports."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Questionnaire
    * supportedProfile[+] = Canonical(SDCQuestionnairePopulateObservation)
      * extension[$conf].valueCode = #SHOULD
    * supportedProfile[+] = Canonical(SDCQuestionnaireExtractObservation)
      * extension[$conf].valueCode = #SHOULD
    * documentation = "Allows retrieval of Questionnaires to be filled in."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of questionnaires to be completed."
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "context-type-value"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-context-type-value"
      * type          = #composite
      * documentation = "Allows filtering for Questionnaires that are phyical activity-related."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "identifier"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-identifier"
      * type          = #token
      * documentation = "Allows retrieving Questionnaires with a known identifier."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "publisher"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-publisher"
      * type          = #string
      * documentation = "Allows retrieving Questionnaires based on who is responsible for having
        defined the form."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-status"
      * type          = #token
      * documentation = "Allows filtering to only retrieve active questionnaires."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "subject-type"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-subject-type"
      * type          = #token
      * documentation = "Allows retrieving Questionnaires that are intended to provide information
        about patients - as opposed to practitioenrs, organizations, etc."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "title"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-title"
      * type          = #string
      * documentation = "Allows searching for forms by name."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "url"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-url"
      * type          = #uri
      * documentation = "Allows retrieving a referenced Questionnaire."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "version"
      * definition    = "http://hl7.org/fhir/SearchParameter/Questionnaire-version"
      * type          = #token
      * documentation = "Allows retrieving a specific version of a referenced questionnaire."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #QuestionnaireResponse
    * supportedProfile[+] = Canonical(SDCQuestionnaireResponse)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows recording and retrieval of questionnaire responses."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of questionnaire responses referenced by other resources."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #update
      * documentation = "Allows correction of or continued editing of a previously recorded 
        questionnaire response."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #create
      * documentation = "Allows other systems to record questionnaire responses."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows retrieval of completed or in-progresss questionnaire responses."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "author"
      * definition    = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-author"
      * type          = #reference
      * documentation = "Allows filtering responses previously created by a particular individual."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "authored"
      * definition    = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-authored"
      * type          = #date
      * documentation = "Allows filtering responses based on when they were completed."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those responses for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support 
        cross-patient search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "questionnaire"
      * definition    = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-questionnaire"
      * type          = #reference
      * documentation = "Allows retrieving a referenced Questionnaire."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-status"
      * type          = #token
      * documentation = "Allows filtering to only retrieve completed questionnaire responses."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #ServiceRequest
    * supportedProfile[+] = Canonical(PAServiceRequest)
      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows recording and retrieval of physical activity-related referrals and
      orders."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows retrieval of referrals referenced by other resources."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows searching for orders or referrals for a particular patient or for
        updates to previously retrieved orders."
    * referencePolicy = #literal
    * searchInclude[+] = "ServiceRequest:supporting-info"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:pertains-to-goal"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:patient"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:requester"
      * extension[$conf].valueCode = #SHOULD
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "authored"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-authored"
      * type          = #date
      * documentation = "Allows filtering orders based on when they were created."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "category"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-category"
      * type          = #token
      * documentation = "Allows retrieving only those referrals related to physical activity."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "code"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-code"
      * type          = #token
      * documentation = "Allows retrieving only orders for particular types of interventions."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those orders for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support 
        cross-patient search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "performer"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-performer"
      * type          = #reference
      * documentation = "Allows filtering to only retrieve orders targeted to a specific performer."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "requester"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-requester"
      * type          = #reference
      * documentation = "Allows filtering to only retrieve orders solicited by a specific provider."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-status"
      * type          = #token
      * documentation = "Allows filtering to only retrieve active or completed orders."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "supporting-info"
      * definition    = "http://hl7.org/fhir/us/sdoh-clinicalcare/SearchParameter/ServiceRequest-supporting-info"
      * type          = #reference
      * documentation = "Allows _include to retrieve supporting information for an order/referral,
        particularly Consent."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Task
    * supportedProfile[+] = Canonical(PATaskForReferralManagement)
      * extension[$conf].valueCode = #SHALL
// Todo - put this back when version is properly supported 
//    * supportedProfile[+] = "http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-TaskForReferralManagement"
//      * extension[$conf].valueCode = #SHALL
    * documentation = "Allows retrieval and updating of tasks seeking fulfillment of orders and 
      referrals as well as creation, updating and retrieval of tasks assigned to patients."
    * interaction[+]
      * extension[$conf].valueCode = #SHOULD
      * code          = #create
      * documentation = "Allows a service provider to create a patient-assigned Task."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #update
      * documentation = "Allows existing tasks to be updated - to change their status and/or to
        attach 'outputs' resulting from the Task."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #read
      * documentation = "Allows polling a single Task for changes or on notification from a
        subscription."
    * interaction[+]
      * extension[$conf].valueCode = #SHALL
      * code          = #search-type
      * documentation = "Allows polling multiple tasks simultaneously, as well as retrieving
        referenced resources as part of a single query."
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * searchInclude[+] = "Task:focus"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "Task:output"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:supporting-info"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:pertains-to-goal"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:patient"
      * extension[$conf].valueCode = #SHOULD
    * searchInclude[+] = "ServiceRequest:requester"
      * extension[$conf].valueCode = #SHOULD
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "_id"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-id"
      * type          = #token
      * documentation = "Allows retrieving known consent records - and more specifically, retrieving 
        more than one in a single call to poll for updates."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "_lastUpdated"
      * definition    = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
      * type          = #date
      * documentation = "Allows filtering for only records that have changed since last query."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "code"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-code"
      * type          = #token
      * documentation = "Allows filtering for 'fulfill' tasks as opposed to others. Some systems may 
        require code to be included as a filter criteria as different Task codes may correspond to 
        different internal database tables."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "owner"
      * definition    = "http://hl7.org/fhir/SearchParameter/Task-owner"
      * type          = #reference
      * documentation = "Allows filtering only for tasks that are assigned to a particular owner (or 
        alternatively, tasks that have not yet been assigned)"
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "patient"
      * definition    = "http://hl7.org/fhir/SearchParameter/clinical-patient"
      * type          = #reference
      * documentation = "Allows filtering to only those tasks for a specific patient.  Most 
        systems will treat this as a mandatory search parameter, though systems MAY support 
        cross-patient search, at least through bulk-data interfaces for payer or research use."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "requester"
      * definition    = "http://hl7.org/fhir/SearchParameter/Task-requester"
      * type          = #reference
      * documentation = "Allows filtering to only retrieve tasks initiated by a specific provider."
    * searchParam[+]
      * extension[$conf].valueCode = #SHALL
      * name          = "status"
      * definition    = "http://hl7.org/fhir/SearchParameter/ServiceRequest-status"
      * type          = #token
      * documentation = "Allows filtering to only retrieve active or completed orders."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "focus"
      * definition    = "http://hl7.org/fhir/SearchParameter/Task-focus"
      * type          = #reference
      * documentation = "Allows retrieving the task(s) seeking fulfillment of a particular 
        ServiceRequest."
    * searchParam[+]
      * extension[$conf].valueCode = #SHOULD
      * name          = "supporting-info"
      * definition    = "http://hl7.org/fhir/us/sdoh-clinicalcare/SearchParameter/Task-output-reference"
      * type          = #reference
      * documentation = "Allows for the 'output' of a Task to be included when retrieving a Task."



// TODO: What includes/revincludes should be supported (if any)?  E.g. Provenance when retrieving
// history