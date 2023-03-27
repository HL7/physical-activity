Instance:       pa-service-provider-light
InstanceOf:     CapabilityStatement
Usage:          #definition
* title       = "Physical Activity Light Service Provider Capability Statement"
* description = "Describes the expected capabilities of a system used by a personal trainer, community fitness organization, or other entity that delivers services that help a patient to improve or maintain their level of physical activity.  This set of capabilities is appropriate for service providers that CANNOT expose their own FHIR server and that rely on the Care Manager to store Tasks, reports and other resources."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-service-provider-light"
* name        = "PAServiceProviderLight"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "A 'light' Service Provider has less sophistication than a [full Service Provider](CapabilityStatement-pa-service-provider-full.html).  They rely exclusively on the [care manager](CapabilityStatement-pa-care-manager.html) to store the Tasks and any reports associated with referrals.  Therefore, all interactions are handled as 'client' functionality."
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #CarePlan
    * insert SupportedProfile(PACarePlan, #SHALL)
    * documentation = "Allows accessing and manipulating Care Plans stored on a Care Manager."
    * insert Interaction(#update, #SHOULD, "Allows a service provider to make updates to a plan owned by a care manager.")
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
    * extension[$conf].valueCode = #SHALL
    * type = #DiagnosticReport
    * insert SupportedProfile(PADiagnosticReport, #SHALL)
    * documentation = "Allows creation of the reports summarizing the results of a referral."
    * insert Interaction(#create, #SHALL, "Allows submitting new reports.")
    * insert Interaction(#update, #SHALL, "Allows updating/correcting a previously submitted report.")
    * insert Interaction(#search-type, #SHALL, "Allows searching for reports already submitted.")
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
    * type = #DocumentReference
    * insert SupportedProfile(USCoreDocumentReferenceProfile, #SHALL)
    * documentation = "Allows looking up PDFs or similar content to referenced in Patient Tasks and later retrieved by Patient Engagement systems.  Note: These resources will not be patient-specific."
    * insert Interaction(#create, #SHOULD, "Allows adding additional images/documents for later retrieval.")
    * insert Interaction(#update, #MAY, "Allows replacing an existing image/document with a newer version.")
    * insert Interaction(#search-type, #SHALL, "Allows searching for appropriate an appropriate image/document to reference.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known document reference records - and more specifically\, retrieving  more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("contenttype", DocumentReference-contenttype, #token, #SHALL, "Allows filtering for only PDFs\, images\, etc.")
    * insert SearchParam("category", DocumentReference-category, #token, #SHALL, "Allows filtering for only records tied to a particular category (e.g. physical-activity\).")
    * insert SearchParam("description", DocumentReference-description, #string, #SHOULD, "Allows filtering based on words found in the description - i.e. with a 'contains' search.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Goal
    * insert SupportedProfile(PAGoal, #SHALL)
    * documentation = "Allows accessing and potentially updating goals maintained by a Care Manager."
    * insert Interaction(#update, #SHOULD, "Allows patients or service providers to modify a goal - for example shifting target values or dates\, updating the status\, etc.  Allowing patients\, care-givers\, and service providers to help maintain goals is a key aspect of a patient-centered care plan.  However\, not all care manager systems (or their organizations\) yet have the technical mechanisms or policies in place to support this.")
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
    * extension[$conf].valueCode = #SHALL
    * type = #Questionnaire
    * insert SupportedProfile(SDCQuestionnairePopulateObservation, #SHOULD)
    * insert SupportedProfile(SDCQuestionnaireExtractObservation, #SHOULD)
    * documentation = "Allows retrieval of Questionnaires to be filled in."
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of questionnaires to be completed.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known questionnaire records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("url", Questionnaire-url, #uri, #SHALL, "Allows retrieving a referenced Questionnaire.")
    * insert SearchParam("version", Questionnaire-version, #token, #SHOULD, "Allows retrieving a specific version of a referenced questionnaire.")
    * insert SearchParam("context-type-value", Questionnaire-context-type-value, #composite, #SHOULD, "Allows filtering for Questionnaires that are phyical activity-related.")
    * insert SearchParam("identifier", Questionnaire-identifier, #token, #SHOULD, "Allows retrieving Questionnaires with a known identifier.")
    * insert SearchParam("publisher", Questionnaire-publisher, #string, #SHOULD, "Allows retrieving Questionnaires based on who is responsible for having defined the form.")
    * insert SearchParam("status", Questionnaire-status, #token, #SHOULD, "Allows filtering to only retrieve active questionnaires.")
    * insert SearchParam("subject-type", Questionnaire-subject-type, #token, #SHOULD, "Allows retrieving Questionnaires that are intended to provide information about patients - as opposed to practitioners\, organizations\, etc.")
    * insert SearchParam("title",Questionnaire-title, #string, #SHOULD, "Allows searching for forms by name.")
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
    * extension[$conf].valueCode = #SHALL
    * type = #Subscription
    * insert SupportedProfile(BackportSubscription, #SHALL)
    * documentation = "Allows establishing and maintaining subscriptions for Task notifications.  Only needed if not handled manually."
    * insert Interaction(#create, #SHALL, "Allows establishing a new subscription.")
    * insert Interaction(#update, #SHALL, "Allows revising an existing subscription - to cancel it or change the email address or SMS number.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of existing subscriptions prior to update.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchParam2("topic", http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-topic, #uri, #SHOULD, "Allows filtering for just subscriptions for Task monitoring.")
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known subscription records.")
//    * insert SearchParam("owner",Subscription-owner, #reference, #SHALL, "Allows filtering only for tasks that are owned by the Service Provider system.")    
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Task
    * insert SupportedProfile(PATaskForReferralManagement, #SHALL)
    * insert SupportedProfile(SDOHCCTaskForPatient, #SHALL)
    * documentation = "Allows creation of tasks for patients, as well as retrieval of Tasks assigned to the Service Provider."
    * insert Interaction(#create, #SHALL, "Allows a service provider to create a patient-assigned Task.")
    * insert Interaction(#update, #SHOULD, "Allows existing tasks to be updated - to change their status and/or to attach 'outputs' resulting from the Task.")
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of existing tasks to check for changes or prior to making updates.  This will typically be prompted by a subscription notification.")
    * versioning      = #versioned-update
    * referencePolicy = #literal
    * insert SearchInclude("Task:output", #SHOULD)
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known task records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("code", clinical-code, #token, #SHALL, "Allows filtering for 'fulfill' tasks as opposed to others. Some systems may require code to be included as a filter criteria as different Task codes may correspond to  different internal database tables.")
    * insert SearchParam("owner",Task-owner, #reference, #SHALL, "Allows filtering only for tasks that are assigned to a particular owner (or alternatively\, tasks that have not yet been assigned\).")
    * insert SearchParam("patient", clinical-patient, #reference, #SHALL, "Allows filtering to only those tasks for a specific patient.  Most systems will treat this as a mandatory search parameter\, though systems MAY support cross-patient search\, at least through bulk-data interfaces for payer or research use.")
    * insert SearchParam("requester", Task-requester, #reference, #SHALL, "Allows filtering to only retrieve tasks initiated by a specific provider.")
    * insert SearchParam("status", ServiceRequest-status, #token, #SHALL, "Allows filtering to only retrieve active or completed orders.")
    * insert SearchParam("focus", Task-focus, #reference, #SHOULD, "Allows retrieving the task(s\) seeking fulfillment of a particular ServiceRequest.")
    * insert SearchParam2("output", http://hl7.org/fhir/us/sdoh-clinicalcare/SearchParameter/Task-output-reference, #reference, #SHOULD, "Allows for the 'output' of a Task to be included when retrieving a Task.")
