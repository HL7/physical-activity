Instance:       pa-patient-engagement
InstanceOf:     CapabilityStatement
Usage:          #definition
* title       = "Physical Activity Patient Engagement Capability Statement"
* description = "Describes the expected capabilities of a system intended for use by patients and caregivers of patients who are working to enhance or maintain their levels of physical activity.  These will typically be web-based or mobile applications."
* url         = "http://hl7.org/fhir/us/physical-activity/CapabilityStatement/pa-patient-engagement"
* name        = "PAPatientEngagement"
* status      = #active
* kind        = #requirements
* date        = 2022-06-18
* imports[+]  = "http://hl7.org/fhir/us/core/CapabilityStatement/us-core-client"
* fhirVersion = #4.0.1
* format[+]   = #json
* format[+]   = #xml
* rest[+]
  * mode          = #client
  * documentation = "Systems for patients  only act as RESTful clients.  While they may create and store some of their own data, this data is always made available by 'pushing' it to the server of a [care manager](CapabilityStatement-pa-care-manager.html) or a [full service provider](CapabilityStatement-pa-service-provider-full.html) system."
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #CarePlan
    * insert SupportedProfile(PACarePlan, #SHALL)
    * documentation = "Allows accessing and manipulating Care Plans."
    * insert Interaction(#update, #SHOULD, "Allows a patient system to make updates to a plan.")
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
    * extension[$conf].valueCode = #MAY
    * type = #DiagnosticReport
    * insert SupportedProfile(PADiagnosticReport, #SHALL)
    * documentation = "Allows viewiong of the reports summarizing the results of a referral."
    * insert Interaction(#search-type, #SHALL, "Allows searching for recorded reports.")
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
    * documentation = "Allows retrieving up PDFs or similar content to referenced in Patient Tasks."
    * insert Interaction(#search-type, #SHALL, "Allows retrieving a referenced artifact.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known document reference records - and more specifically\, retrieving  more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
  * resource[+]
    * extension[$conf].valueCode = #SHOULD
    * type = #Goal
    * insert SupportedProfile(PAGoal, #SHALL)
    * documentation = "Allows accessing and potentially updating patient goals."
    * insert Interaction(#create, #SHOULD, "Allows patients to create new goals.")
    * insert Interaction(#update, #SHOULD, "Allows patients to modify a goal - for example shifting target values or dates\, updating the status\, etc.  Allowing patients and care-givers to help maintain goals is a key aspect of a patient-centered care plan.  However not all care manager or service provider systems (or their organizations\) yet have the technical mechanisms or policies in place to support this.")
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
    * documentation = "Allows recording and viewing patient physical activity observations."
    * insert Interaction(#create, #SHALL, "Allows recording new observations")
    * insert Interaction(#create, #SHOULD, "Allows correcting a previous observation or revising the status")
    * insert Interaction(#search-type, #SHALL, "Allows viewing of previously recorded observations - e.g. to help calculate primary measures and/or to view trends.")
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
    * documentation = "Allows retrieval of Questionnaires referenced by a patient Task."
    * insert Interaction(#search-type, #SHALL, "Allows retrieval of questionnaires to be completed.")
    * referencePolicy = #literal
    * insert SearchParam("_id", Resource-id, #token, #SHALL, "Allows retrieving known questionnaire records - and more specifically\, retrieving more than one in a single call to poll for updates.")
    * insert SearchParam("_lastUpdated", Resource-lastUpdated, #date, #SHOULD, "Allows filtering for only records that have changed since last query.")
    * insert SearchParam("url", Questionnaire-url, #uri, #SHALL, "Allows retrieving a referenced Questionnaire.")
    * insert SearchParam("version", Questionnaire-version, #token, #SHOULD, "Allows retrieving a specific version of a referenced questionnaire.")
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #QuestionnaireResponse
    * insert SupportedProfile(SDCQuestionnaireResponse, #SHALL)
    * documentation = "Allows recording and updating of questionnaire responses in response to patient tasks."
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
    * documentation = "Allows retrieval 'execise prescriptions' - referrals addressed to the patient themselves - as well as monitoring of referrals assigned to others."
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
    * insert SearchParam("url",Subscription-url, #uri, #SHALL, "Allows filtering only for subscriptions that notify a specific endpoint.  Substituting for the 'owner' search parameter\, which doesn't exist in R4.")    
//    * insert SearchParam("owner",Subscription-owner, #reference, #SHALL, "Allows filtering only for tasks that are owned by the Patient Engagement system.")    
  * resource[+]
    * extension[$conf].valueCode = #SHALL
    * type = #Task
    * insert SupportedProfile(PATaskForReferralManagement, #MAY)
    * insert SupportedProfile(SDOHCCTaskForPatient, #SHALL)
    * documentation = "Allows creation of tasks assigned to the patient, as well as potentially monitoring Tasks assigned to a service provider."
    * insert Interaction(#update, #SHOULD, "Allows updating the status and/or specifying outputs for patient tasks.")
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
