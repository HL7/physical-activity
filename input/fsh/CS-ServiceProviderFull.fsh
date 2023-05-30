Instance:       pa-service-provider-full
InstanceOf:     CapabilityStatement
Usage:          #definition
Title:        "Physical Activity Full Service Provider Capability Statement"
* description = "Describes the expected capabilities of a system used by a personal trainer, community fitness organization, or other entity that delivers services that help a patient to improve or maintain their level of physical activity.  This set of capabilities is appropriate for service providers that CAN expose their own FHIR server and that store Tasks, reports and other resources locally and expose them for query by [Care Managers](CapabilityStatement-pa-care-manager.html) and [Patient Engagement systems](CapabilityStatement-pa-patient-engagement.html)."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-service-provider-full"
* name        = "PAServiceProviderFull"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* imports[+]  = "http://hl7.org/fhir/us/core/CapabilityStatement/us-core-client"
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "A 'full' Service Provider needs less client capabilities than a [light](CapabilityStatement-pa-service-provider-light.html) one, as it does not rely on the [care manager](CapabilityStatement-pa-care-manager.html) to store the Task or report.  However, it might still need to access and sometimes manipulate observations, goals, plans and other resources stored on external systems."
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #CarePlan
    * insert SupportedProfile(PACarePlan, #SHALL)
    * documentation = "Allows accessing and manipulating Care Plans stored on a Care Manager."
    * insert Interaction(#update, #SHOULD, "Allows a service provider to make updates to a plan owned by a care manager.")
    * insert Interaction(#search-type, #SHOULD, "Allows retrieval of care plans for a given patient.")
    * insert Interaction(#history-instance, #MAY, "Allows seeing how a care plan has changed over time.  This may be particularly important if multiple stakeholders have the ability to make adjustments to the plan.  However\, history is not widely supported.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known care plan records - and more specifically\, retrieving more than one in a single call to check for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", CarePlan-category, #token, #SHOULD, "Allows retrieving only those plans related to physical activity.")
    * insert SearchParam("date", clinical-date, #date, #SHOULD, "Allows filtering plans based on the time frame they apply(ied\) to.")
    * insert SearchParam("lifecycle-status", CarePlan-status, #token, #SHALL, "Allows filtering to only active or draft plans.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those plans for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Condition
    * insert SupportedProfile(PAConditionLowPA, #SHOULD)
    * documentation = "Accessing the formal 'low physical activity' condition may be necessary to support prior authorization or claims."
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of conditions for a given patient.")
    * insert Interaction(#history-instance, #MAY, "Allows seeing how a condition has changed over time.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known condition records - and more specifically\, retrieving more than one in a single call to check for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", Condition-category, #token, #SHALL, "Allows retrieving only those plans related to physical activity.")
    * insert SearchParam("clinical-status", Condition-clinical-status, #token, #SHOULD, "Allows filtering to only active conditions.")
    * insert SearchParam("code", clinical-code, #token, #SHOULD, "Allows retrieving specific patient conditions - e.g. all 'low physical activity' conditions.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those plans for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("verification-status", Condition-verification-status, #token, #SHOULD, "Allows excluding refuted or erroneous conditions.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Goal
    * insert SupportedProfile(PAGoal, #SHALL)
    * documentation = "Allows accessing and potentially updating goals maintained by a Care Manager."
    * insert Interaction(#update, #SHOULD, "Allows patients or service providers to modify a goal - for example shifting target values or dates\, updating the status\, etc.  Allowing patients\, care-givers\, and service providers to help maintain goals is a key aspect of a patient-centered care plan.  However\, not all care manager systems (or their organizations\) yet have the technical mechanisms or policies in place to support this.")
    * insert Interaction(#search-type, #SHOULD, "Allows retrieval of goals for a given patient.")
    * insert Interaction(#history-instance, #MAY, "Allows seeing how goals have changed over time.  This may be particularly important if multiple stakeholders have the ability to make adjustments to goals.  However\, history is not widely supported.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known goal records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", Goal-category, #token, #SHOULD, "Allows retrieving only those goals related to physical activity.")
    * insert SearchParam("lifecycle-status", Goal-lifecycle-status, #token, #SHOULD, "Allows filtering to only active\, completed or other goal statuses.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those goals for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("target-date", Goal-target-date, #date, #SHOULD, "Allows filtering goals based on when they're to be achieved.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Observation
    * insert SupportedProfile(PAObservationEVSDaysPerWeek, #SHALL)
    * insert SupportedProfile(PAObservationEVSMinutesPerDay, #SHALL)
    * insert SupportedProfile(PAObservationEVSMinutesPerWeek, #SHALL)
    * insert SupportedProfile(PAObservationStrengthDaysPerWeek, #SHOULD)
    * insert SupportedProfile(PAObservationActivityMeasure, #SHOULD)
    * insert SupportedProfile(PAObservationActivityGroup, #SHOULD)
    * insert SupportedProfile(PAObservationTimeMeasure, #SHOULD)
    * documentation = "Allows accessing observations maintained by a Care Manager."
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of observations for a given patient.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known observation records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", Observation-category, #token, #SHALL, "Allows retrieving only those observations related to physical activity.  As well\, many clinical systems will require searches to specify a category so the server knows which part of the database to search as different types of observations are stored in different areas.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows filtering to only retrieve a specific type of physical activity vital sign or supporting observation.")
    * insert SearchParam("date", clinical-date, #date, #SHALL, "Allows filtering to only retrieve a observations from a particular time period.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those observations for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("status", Observation-status, #token, #SHALL, "Allows excluding entered-in-error or non-final observations.")
    * insert SearchParam("value-quantity", Observation-value-quantity, #quantity, #SHOULD, "Allows retrieval of only those observations that fall in a particular range.  Particularly useful for cross-patient queries.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Patient
    * documentation = "Allows searching of the patients."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the patients.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("birthdate", individual-birthdate, #date, #MAY, "Allows filtering of individuals based on their date of birth.")
    * insert SearchParam("family", individual-family, #string, #MAY, "Allows filtering of individuals based on their family name.")
    * insert SearchParam("gender", individual-gender, #token, #MAY, "Allows filtering of individuals based on their gender.")
    * insert SearchParam("given", individual-given, #string, #MAY, "Allows filtering of individuals based on their given name.")
    * insert SearchParam("identifier", Patient-identifier, #token, #SHALL, "Enables filtering of patients based on their unique identifiers.")
    * insert SearchParam("name", Patient-name, #string, #SHALL, "Enables filtering of patients based on their full name.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Practitioner
    * documentation = "Allows searching of the practitioners."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the practitioners.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("identifier", Practitioner-identifier, #token, #SHOULD, "Enables filtering of practitioners based on their unique identifiers.")
    * insert SearchParam("name", Practitioner-name, #string, #SHOULD, "Enables filtering of practitioners based on their full name.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #PractitionerRole
    * documentation = "Allows searching of the practitioner roles."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the practitioner roles.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("specialty", PractitionerRole-specialty, #token, #SHOULD, "Allows filtering of practitioner specialty.")
    * insert SearchParam("practitioner", PractitionerRole-practitioner, #reference, #SHOULD, "Enables filtering of practitioner roles based on the associated practitioner.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #ServiceRequest
    * insert SupportedProfile(PAServiceRequest, #SHALL)
    * documentation = "Allows retrieval of physical activity-related referrals from Care managers."
    * insert Interaction(#search-type, #SHALL, "Allows searching for orders or referrals for a particular patient or for updates to previously retrieved orders.")
    * referencePolicy = #literal
    * insert SearchInclude("ServiceRequest:patient", #SHOULD)
    * insert SearchInclude("ServiceRequest:requester", #SHOULD)
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known service request records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("authored", ServiceRequest-authored, #date, #SHOULD, "Allows filtering orders based on when they were created.")
    * insert SearchParam("category", ServiceRequest-category, #token, #SHALL, "Allows retrieving only those referrals related to physical activity.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows retrieving only orders for particular types of interventions.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those orders for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("performer", ServiceRequest-performer, #reference, #SHOULD, "Allows filtering to only retrieve orders targeted to a specific performer.")
    * insert SearchParam("requester", ServiceRequest-requester, #reference, #SHOULD, "Allows filtering to only retrieve orders solicited by a specific provider.")
    * insert SearchParam("status", ServiceRequest-status, #token, #SHOULD, "Allows filtering to only retrieve active or completed orders.")
  * resource[+]
    * extension[$conf].valueCode = #MAY
    * type = #Subscription
    * insert SupportedProfile(BackportSubscription, #SHALL)
    * documentation = "Allows subscribing to Patient Tasks hosted on a CareManager."
    * insert Interaction(#create, #SHALL, "Allows establishing a new subscription.")
    * insert Interaction(#update, #SHALL, "Allows revising an existing subscription - to cancel it or change the email address or SMS number.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of existing subscriptions prior to update.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam2("topic", http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-topic, #uri, #SHOULD, "Allows filtering for just subscriptions for Task monitoring.")
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known subscription records.")
    * insert SearchParam("url",Subscription-url, #uri, #SHALL, "Allows filtering only for subscriptions that notify a specific endpoint.  Substituting for the 'owner' search parameter\, which doesn't exist in R4.")    
//    * insert SearchParam("owner",Subscription-owner, #reference, #SHALL, "Allows filtering only for tasks that are owned by the subscribing system.")    
* rest[+]
  * mode = #server
  * documentation = "Unlike a [light Service Provider](CapabilityStatement-pa-service-provider-light.html), 'full' Service Providers expose a RESTful endpoint to allow submission of tasks as well as creation and/or manipulation of other resources by [Care Managers](CapabilityStatement-pa-care-manager.html) and [Patient Engagement systems](CapabilityStatement-pa-patient-engagement.html)."
  * security.service[+]  = $security#OAuth
  * security.description = "See additional guidance on the [security](security.html) page."
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #CarePlan
    * insert SupportedProfile(PACarePlan, #SHALL)
    * documentation = "Shares and, ideally, allows external systems to add and update care plans. If 'create' interaction is supported, 'update' becomes mandatory."
    * insert Interaction(#update, #SHOULD, "Allows patients or service providers to modify a care plan.  Allowing patients\, care-givers\, and service providers to help maintain care plans is a key aspect of a patient-centered care plan.  However\, not all care manager systems (or their organizations\) yet have the technical mechanisms or policies in place to support this. Please note if 'create' is supported\, 'update' becomes mandatory\, as systems supporting creation should have the necessary mechanisms in place to support updates.")
    * insert Interaction(#create, #SHOULD, "Allows patients or service providers to add additional physical activity related care plans.  As with updates\, this is a key part of a patient-centered care plan\, but not all systems or organizations will be able to do this.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of care plans for a given patient.")
    * insert Interaction(#history-instance, #MAY, "Allows seeing how a care plan has changed over time.  This may be particularly important if multiple stakeholders have the ability to make adjustments to the plan.  However\, history is not widely supported.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known care plan records - and more specifically\, retrieving more than one in a single call to check for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", CarePlan-category, #token, #SHOULD, "Allows retrieving only those plans related to physical activity.")
    * insert SearchParam("date", clinical-date, #date, #SHOULD, "Allows filtering plans based on the time frame they apply(ied\) to.")
    * insert SearchParam("lifecycle-status", CarePlan-status, #token, #SHALL, "Allows filtering to only active or draft plans.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those plans for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #DocumentReference
    * insert SupportedProfile(USCoreDocumentReferenceProfile, #SHALL)
    * documentation = "Allows retrieving PDFs or similar content referenced by a Patient Task.  These generally will not be patient-specific resources."
    * insert Interaction(#create, #SHOULD, "Allows a ServiceProvider to add additional images/documents for later retrieval.")
    * insert Interaction(#update, #MAY, "Allows a ServiceProvider to replace an existing image/document with a newer version.")
    * insert Interaction(#search-type, #SHOULD, "Allows monitoring of previously-retrieved DocumentReferences in the event the image/document is amended\, corrected\, or updated.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known document-reference records - and more specifically\, retrieving  more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("contenttype", DocumentReference-contenttype, #token, #SHOULD, "Allows filtering for only PDFs\, images\, etc.")
    * insert SearchParam("category", DocumentReference-category, #token, #SHOULD, "Allows filtering for only records tied to a particular category (e.g. physical-activity\).")
    * insert SearchParam("description", DocumentReference-description, #string, #SHOULD, "Allows filtering based on words found in the description - i.e. with a 'contains' search.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Goal
    * insert SupportedProfile(PAGoal, #SHALL)
    * documentation = "Shares and, ideally, allows external systems to add and update goals. If 'create' interaction is supported, 'update' becomes mandatory."
    * insert Interaction(#update, #SHOULD, "Allows patients or service providers to modify a goal - for example shifting target values or dates\, updating the status\, etc.  Allowing patients\, care-givers\, and service providers to help maintain goals is a key aspect of a patient-centered care plan.  However\, not all care manager systems (or their organizations\) yet have the technical mechanisms or policies in place to support this. Please note if 'create' is supported\, 'update' becomes mandatory\, as systems supporting creation should have the necessary mechanisms in place to support updates.")
    * insert Interaction(#create, #SHOULD, "Allows patients or service providers to add additional physical activity related goals.  As with updates\, this is a key part of a patient-centered care plan\, but not all systems or organizations will be able to do this.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of goals for a given patient.")
    * insert Interaction(#history-instance, #MAY, "Allows seeing how goals have changed over time.  This may be particularly important if multiple stakeholders have the ability to make adjustments to goals.  However\, history is not widely supported.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known goal records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", Goal-category, #token, #SHALL, "Allows retrieving only those goals related to physical activity.")
    * insert SearchParam("lifecycle-status", Goal-lifecycle-status, #token, #SHOULD, "Allows filtering to only active\, completed or other goal statuses.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those goals for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("target-date", Goal-target-date, #date, #SHOULD, "Allows filtering goals based on when they're to be achieved.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Observation
    * insert SupportedProfile(PAObservationEVSDaysPerWeek, #SHALL)
    * insert SupportedProfile(PAObservationEVSMinutesPerDay, #SHALL)
    * insert SupportedProfile(PAObservationEVSMinutesPerWeek, #SHALL)
    * insert SupportedProfile(PAObservationStrengthDaysPerWeek, #SHOULD)
    * insert SupportedProfile(PAObservationActivityMeasure, #SHOULD)
    * insert SupportedProfile(PAObservationActivityGroup, #SHOULD)
    * insert SupportedProfile(PAObservationTimeMeasure, #SHOULD)
    * documentation = "Exposes and allows manipulation of physical activity vital sign and supporting observations."
    * insert Interaction(#update, #SHOULD, "Allows correction of or adding comments to previously recorded observations.")
    * insert Interaction(#create, #SHALL, "Allows other systems to record physical-activity related observations.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of observations for a given patient.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known observation records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("category", Observation-category, #token, #SHALL, "Allows retrieving only those observations related to physical activity.  As well\, many clinical systems will require searches to specify a category so the server knows which part of the database to search as different types of observations are stored in different areas.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows filtering to only retrieve a specific type of physical activity vital sign or supporting observation.")
    * insert SearchParam("date", clinical-date, #date, #SHALL, "Allows filtering to only retrieve a observations from a particular time period.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those observations for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("status", Observation-status, #token, #SHALL, "Allows excluding entered-in-error or non-final observations.")
    * insert SearchParam("value-quantity", Observation-value-quantity, #quantity, #SHOULD, "Allows retrieval of only those observations that fall in a particular range.  Particularly useful for cross-patient queries.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Patient
    * documentation = "Allows searching of the patients."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the patients.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("birthdate", individual-birthdate, #date, #MAY, "Allows filtering of individuals based on their date of birth.")
    * insert SearchParam("family", individual-family, #string, #MAY, "Allows filtering of individuals based on their family name.")
    * insert SearchParam("gender", individual-gender, #token, #MAY, "Allows filtering of individuals based on their gender.")
    * insert SearchParam("given", individual-given, #string, #MAY, "Allows filtering of individuals based on their given name.")
    * insert SearchParam("identifier", Patient-identifier, #token, #SHALL, "Enables filtering of patients based on their unique identifiers.")
    * insert SearchParam("name", Patient-name, #string, #SHALL, "Enables filtering of patients based on their full name.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Practitioner
    * documentation = "Allows searching of the practitioners."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the practitioners.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("identifier", Practitioner-identifier, #token, #SHOULD, "Enables filtering of practitioners based on their unique identifiers.")
    * insert SearchParam("name", Practitioner-name, #string, #SHOULD, "Enables filtering of practitioners based on their full name.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #PractitionerRole
    * documentation = "Allows searching of the practitioner roles."
    * insert Interaction(#search-type, #SHALL, "Allows searching of the practitioner roles.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("specialty", PractitionerRole-specialty, #token, #SHOULD, "Allows filtering of practitioner specialty.")
    * insert SearchParam("practitioner", PractitionerRole-practitioner, #reference, #SHOULD, "Enables filtering of practitioner roles based on the associated practitioner.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #DiagnosticReport
    * insert SupportedProfile(PADiagnosticReport, #SHALL)
    * documentation = "Allows retrieval of the reports on physical activity-related interventions."
    * insert Interaction(#search-type, #SHALL, "Allows searching for reports for a particular patient or checking for updates to previously retrieved records.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known reports - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("basedOn", Procedure-based-on, #reference, #SHOULD, "Allows filtering to reports created in fulfillement of a particular order or referral.")
    * insert SearchParam("code", clinical-code, #token, #SHOULD, "Allows filtering to specific types of reports.")
    * insert SearchParam("date", clinical-date, #date, #SHOULD, "Allows filtering reports based on the period the cover.")
    * insert SearchParam("category", Procedure-category, #token, #SHALL, "Allows retrieving only those reports related to physical activity.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those reports for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("performer", ServiceRequest-performer, #reference, #SHOULD, "Allows filtering to only retrieve reports created by a specific performer.")
    * insert SearchParam("status", ServiceRequest-status, #token, #SHOULD, "Allows filtering to only retrieve active or completed reports.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Questionnaire
    * insert SupportedProfile(SDCQuestionnairePopulateObservation, #SHOULD)
    * insert SupportedProfile(SDCQuestionnaireExtractObservation, #SHOULD)
    * documentation = "Allows retrieval of Questionnaires to be filled in."
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of questionnaires to be completed.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known questionnaire records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("url", CanonicalResource-url, #uri, #SHALL, "Allows retrieving a referenced Questionnaire.")
    * insert SearchParam("version", CanonicalResource-version, #token, #SHOULD, "Allows retrieving a specific version of a referenced questionnaire.")
    * insert SearchParam("context-type-value", CanonicalResource-context-type-value, #composite, #SHOULD, "Allows filtering for Questionnaires that are phyical activity-related.")
    * insert SearchParam("identifier", CanonicalResource-identifier, #token, #SHOULD, "Allows retrieving Questionnaires with a known identifier.")
    * insert SearchParam("publisher", CanonicalResource-publisher, #string, #SHOULD, "Allows retrieving Questionnaires based on who is responsible for having defined the form.")
    * insert SearchParam("status", CanonicalResource-status, #token, #SHOULD, "Allows filtering to only retrieve active questionnaires.")
    * insert SearchParam("subject-type", Questionnaire-subject-type, #token, #SHOULD, "Allows retrieving Questionnaires that are intended to provide information about patients - as opposed to practitioners\, organizations\, etc.")
    * insert SearchParam("title", CanonicalResource-title, #string, #SHOULD, "Allows searching for forms by name.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #QuestionnaireResponse
    * insert SupportedProfile(SDCQuestionnaireResponse, #SHALL)
    * documentation = "Allows recording and retrieval of questionnaire responses."
    * insert Interaction(#update, #SHOULD, "Allows correction of or continued editing of a previously recorded questionnaire response.")
    * insert Interaction(#create, #SHALL, "Allows other systems to record questionnaire responses.")
    * insert Interaction(#search-type, #SHALL,"Allows retrieval of completed or in-progresss questionnaire responses.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known questionnaire response records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("author", QuestionnaireResponse-author, #reference, #SHALL, "Allows filtering responses previously created by a particular individual.")
    * insert SearchParam("authored", QuestionnaireResponse-authored, #date, #SHOULD, "Allows filtering responses based on when they were completed.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those responses for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("questionnaire", QuestionnaireResponse-questionnaire, #reference, #SHALL, "Allows retrieving a referenced Questionnaire.")
    * insert SearchParam("status", QuestionnaireResponse-status, #token, #SHOULD, "Allows filtering to only retrieve completed questionnaire responses.")
  * resource[+]
    * extension[$conf].valueCode = #MAY
    * type = #ServiceRequest
    * insert SupportedProfile(PAServiceRequest, #SHALL)
    * documentation = "Allows 'prescribing' physical activity for a patient - for retrieval by a Patient Engagement system."
    * insert Interaction(#search-type, #SHALL, "Allows searching for orders or referrals for a particular patient or for updates to previously retrieved orders.")
    * referencePolicy = #literal
    * insert SearchInclude("ServiceRequest:patient", #SHOULD)
    * insert SearchInclude("ServiceRequest:requester", #SHOULD)
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known service request records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("authored", ServiceRequest-authored, #date, #SHOULD, "Allows filtering orders based on when they were created.")
    * insert SearchParam("category", ServiceRequest-category, #token, #SHALL, "Allows retrieving only those referrals related to physical activity.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows retrieving only orders for particular types of interventions.")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those orders for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("performer", ServiceRequest-performer, #reference, #SHOULD, "Allows filtering to only retrieve orders targeted to a specific performer.")
    * insert SearchParam("requester", ServiceRequest-requester, #reference, #SHOULD, "Allows filtering to only retrieve orders solicited by a specific provider.")
    * insert SearchParam("status", ServiceRequest-status, #token, #SHOULD, "Allows filtering to only retrieve active or completed orders.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Subscription
    * insert SupportedProfile(BackportSubscription, #SHALL)
    * documentation = "Allows establishing and maintaining subscriptions for Task notifications.  Needed for both referral and patient tasks."
    * insert Interaction(#create, #SHALL, "Allows establishing a new subscription.")
    * insert Interaction(#update, #SHALL, "Allows revising an existing subscription - to cancel it or change the email address or SMS number.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of existing subscriptions prior to update.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam2("topic", http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-topic, #uri, #SHOULD, "Allows filtering for just subscriptions for Task monitoring.")
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known subscription records.")
    * insert SearchParam("url",Subscription-url, #uri, #SHALL, "Allows filtering only for subscriptions that notify a specific endpoint.  Substituting for the 'owner' search parameter\, which doesn't exist in R4.")    
//    * insert SearchParam("owner",Subscription-owner, #reference, #SHALL, "Allows filtering only for tasks that are owned by the subscribing system.")    
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Task
    * insert SupportedProfile(PATaskForReferralManagement, #SHALL)
    * insert SupportedProfile(SDOHCCTaskForPatient, #SHALL)
    * documentation = "Allows receipt of requests to fulfill referrals from a Service Provider, possible cancellations or notes on those requests, as well as surfacing the status of the referral back to the Care Manager and possibly Patient Engagement systems."
    * insert Interaction(#create, #SHALL, "Allows a service provider to create a patient-assigned Task.")
    * insert Interaction(#update, #SHALL, "Allows existing tasks to be updated - to change their status and/or to attach 'outputs' resulting from the Task.")
    * insert Interaction(#search-type, #SHALL, "Allows polling multiple tasks simultaneously\, as well as retrieving referenced resources as part of a single query.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchInclude("Task:focus", #SHOULD)
    * insert SearchInclude("Task:output", #SHOULD)
    * insert SearchInclude("Task:patient", #SHOULD)
    * insert SearchInclude("ServiceRequest:requester", #SHOULD)
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known task records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows filtering for 'fulfill' tasks as opposed to others. Some systems may require code to be included as a filter criteria as different Task codes may correspond to  different internal database tables.")
    * insert SearchParam("owner",Task-owner, #reference, #SHALL, "Allows filtering only for tasks that are assigned to a particular owner (or alternatively\, tasks that have not yet been assigned\).")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those tasks for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("requester", Task-requester, #reference, #SHALL, "Allows filtering to only retrieve tasks initiated by a specific provider.")
    * insert SearchParam("status", ServiceRequest-status, #token, #SHALL, "Allows filtering to only retrieve active or completed orders.")
    * insert SearchParam("focus", Task-focus, #reference, #SHALL, "Allows retrieving the task(s\) seeking fulfillment of a particular ServiceRequest.")
    * insert SearchParam2("output", http://hl7.org/fhir/us/sdoh-clinicalcare/SearchParameter/Task-output-reference, #reference, #SHOULD, "Allows for the 'output' of a Task to be included when retrieving a Task.")
