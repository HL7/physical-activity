Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $task-code = http://hl7.org/fhir/CodeSystem/task-code
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $pa-temporary-codes = http://hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes
Alias: $SDOHCC-CodeSystemTemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes
Alias: $condition-clinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $condition-ver-status = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category


Instance: scen2ProviderToPersonaltrainerReferral
InstanceOf: ExampleScenario
Title:       "Scenario 2 - Provider to Personal Trainer Post-Rehabilitation Referral"
Description: "A detailed scenario involving the referral of a patient from a healthcare provider to personal training services post-rehabilitation. The scenario includes subscription creation, task updates, and queries related to service request, patient health conditions, observations, and diagnostic reports."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "ProviderToPersonalTrainerReferral"
* actor[0]
  * actorId = "ehr"
  * type = #entity
  * name = "EHR"
* actor[+]
  * actorId = "getfit"
  * type = #entity
  * name = "Get Fit Training"
  * description = "Light Service Provider"
* actor[+]
  * actorId = "fit4life"
  * type = #entity
  * name = "Fit 4 Life"
  * description = "Full Service Provider"
* instance[0]
  * resourceId = "scen2SubscriptionEhr"
  * resourceType = #Subscription
  * version
    * versionId = "1"
    * description = "Subscription successfully created"
* instance[+]
  * resourceId = "scen2SubscriptionGetfit"
  * resourceType = #Subscription
  * version
    * versionId = "1"
    * description = "Get Fit Training Subscription successfully created"
* instance[+]
  * resourceId = "scen2PractitionerTrainerSearchsetBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning list of personal trainers"
* instance[+]
  * resourceId = "scen2SubscriptionNotificationNewtaskBundle"
  * resourceType = #Bundle
  * version
    * versionId = "1"
    * description = "Subscription notification(indicating new Task) successfully created"
* instance[+]
  * resourceId = "scen2TaskGetfitResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning Task, associated ServiceRequest and Patient"
* instance[+]
  * resourceId = "scen2TaskGetfit"
  * resourceType = #Task
  * version[0]
    * versionId = "1"
    * description = "Initial Task"
  * version[+]
    * versionId = "2"
    * description = "GetFit to EHR - Update Task to refused with reason"
* instance[+]
  * resourceId = "scen2TaskFit4life"
  * resourceType = #Task
  * version[0]
    * versionId = "1"
    * description = "EHR to Fit4Life - Task (seeking fulfillment of ServiceRequest) successfully created"
  * version[+]
    * versionId = "2"
    * description = "Updated Task"
  * version[+]
    * versionId = "3"
    * description = "Completed Task (includes diagnostic report)"
* instance[+]
  * resourceId = "scen2TaskFit4lifeResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning Task, associated ServiceRequest and Patient"
* instance[+]
  * resourceId = "scen2ConditionResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning conditions"
* instance[+]
  * resourceId = "scen2ObservationResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning observations"
* instance[+]
  * resourceId = "scen2NotificationUpdatedtaskBundle"
  * resourceType = #Bundle
  * version
    * versionId = "1"
    * description = "Subscription Notification that Task has updated"
* instance[+]
  * resourceId = "scen2NotificationCompletedtaskBundle"
  * resourceType = #Bundle
  * version
    * versionId = "1"
    * description = "Subscription Notification that Task has completed"
* instance[+]
  * resourceId = "scen2DiagnosticReportObservationsResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning referenced observations"
* process[0]
  * title = "Subscription Establishment"
  * preConditions = "EHR, Fit 4 Life, and Get Fit training have established connectivity"
  * postConditions = "Subscriptions are successfully created and posted"
  * step[0].operation
    * number = "1"
    * type = "create"
    * description = "EHR posts Subscription to Fit 4 Life to monitor Tasks. Request: POST /Subscription"
    * initiator = "ehr"
    * receiver = "fit4life"
    * request.resourceId = "scen2SubscriptionEhr"
    * response
      * resourceId = "scen2SubscriptionEhr"
      * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "2"
      * type = "create"
      * description = "Get Fit Training posts Subscription to EHR to monitor Tasks. Request: POST /Subscription"
      * initiator = "getfit"
      * receiver = "ehr"
      * request.resourceId = "scen2SubscriptionGetfit"
      * response
        * resourceId = "scen2SubscriptionGetfit"
        * versionId = "1"
* process[+]
  * title = "1 Hour after appointment"
  * preConditions = "EHR has completed the appointment with the patient"
  * postConditions = "EHR has retrieved list of personal trainers and notified GetFit of new Task"
  * step[0]
    * pause = true
    * operation
      * number = "3"
      * type = "search-type"
      * description = "EHR to Registry - Search to retrieve list of Service Providers for personal trainers near Mrs. Johansson. Request: GET /PractitionerRole?role=228239008&location.address-postalcode=XXXXXX&_include=PractitionerRole:practitioner"
      * initiator = "ehr"
      * receiver = "registry"
      * request.resourceId = "sc2textFile1"
      * response.resourceId = "scen2PractitionerTrainerSearchsetBundle"
  * step[+].operation
    * number = "4"
    * type = "create"
    * description = "EHR to GetFit - Subscription notification indicating new Task. Request: POST /Bundle"
    * initiator = "ehr"
    * receiver = "getfit"
    * request.resourceId = "notification-newtask-bundle"
    * response
      * resourceId = "scen2SubscriptionNotificationNewtaskBundle"
      * versionId = "1"
* process[+]
  * title = "1 Day after appointment"
  * preConditions = "GetFit has received the notification of new Task"
  * postConditions = "GetFit has queried Task, associated ServiceRequest and Patient; and updated Task to refused"
  * step[0]
    * pause = true
    * operation
      * number = "5"
      * type = "search-type"
      * description = "GetFit to EHR - Query Task and associated ServiceRequest and Patient. Request: GET /Task?patient=scen2PatientJohansson&owner.name=Get Fit Training&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus"
      * initiator = "getfit"
      * receiver = "ehr"
      * request.resourceId = "sc2textFile2"
      * response.resourceId = "scen2TaskGetfitResponseBundle"
  * step[+].operation
    * number = "6"
    * type = "update"
    * description = "GetFit to EHR - Update Task to refused with reason (unavailable until 2 months later). Request: PUT /Task/scen2task"
    * initiator = "getfit"
    * receiver = "ehr"
    * request
      * resourceId = "scen2TaskGetfit"
      * versionId = "1"
    * response
      * resourceId = "scen2TaskGetfitV2"
      * versionId = "2"
* process[+]
  * title = "An Hour later"
  * preConditions = "EHR has a Task seeking fulfillment of ServiceRequest for Fit4Life"
  * postConditions = "Fit4Life has retrieved ServiceRequest, Patient, Conditions, Observations, and updated Task"
  * step[0]
    * pause = true
    * operation
      * number = "7"
      * type = "create"
      * description = "EHR to Fit4Life - Task seeking fulfillment of ServiceRequest. Request: POST /Task"
      * initiator = "ehr"
      * receiver = "fit4life"
      * request.resourceId = "scen2TaskFit4life"
      * response
        * resourceId = "scen2TaskFit4life"
        * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "8"
      * type = "search-type"
      * description = "Fit4Life to EHR - Search to retrieve ServiceRequest and Patient. Request: GET /Task?patient=scen2PatientJohansson&owner.name=Fit 4 Life&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus"
      * initiator = "fit4life"
      * receiver = "ehr"
      * request.resourceId = "sc2textFile3"
      * response.resourceId = "scen2TaskFit4lifeResponseBundle"
  * step[+].operation
    * number = "9"
    * type = "search-type"
    * description = "Fit4Life to EHR - Search to retrieve Conditions. Request: GET /Condition?patient=scen2PatientJohansson&category=PhysicalActivity"
    * initiator = "fit4life"
    * receiver = "ehr"
    * request.resourceId = "sc2textFile4"
    * response.resourceId = "scen2ConditionResponseBundle"
  * step[+].operation
    * number = "10"
    * type = "search-type"
    * description = "Fit4Life to EHR - Search to retrieve Observations. Request: GET /Observation?patient=scen2PatientJohansson&category=PhysicalActivity"
    * initiator = "fit4life"
    * receiver = "ehr"
    * request.resourceId = "sc2textFile5"
    * response.resourceId = "scen2ObservationResponseBundle"
  * step[+].operation
    * number = "11"
    * type = "create"
    * description = "Fit4Life to EHR - Subscription Notification that Task has changed. Request: POST /Bundle"
    * initiator = "fit4life"
    * receiver = "ehr"
    * request.resourceId = "scen2NotificationUpdatedtaskBundle"
    * response
      * resourceId = "scen2NotificationUpdatedtaskBundle"
      * versionId = "1"
  * step[+].operation
    * number = "12"
    * type = "search-type"
    * description = "EHR to Fit4Life - Search to retrieve Task. Request: GET /Task?patient=scen2PatientJohansson&owner.name=Fit 4 Life"
    * initiator = "ehr"
    * receiver = "fit4life"
    * request.resourceId = "sc2textFile6"
    * response
      * resourceId = "scen2TaskFit4lifeV2"
      * versionId = "2"
* process[+]
  * title = "2 Months Later"
  * preConditions = "Fit4Life has updated the Task"
  * postConditions = "EHR has retrieved the completed Task, DiagnosticReport, and associated Observations"
  * step[0]
    * pause = true
    * operation
      * number = "13"
      * type = "create"
      * description = "Fit4Life to EHR - Subscription notification of updated Task. Request: POST /Bundle"
      * initiator = "fit4life"
      * receiver = "ehr"
      * request.resourceId = "scen2NotificationCompletedtaskBundle"
      * response
        * resourceId = "scen2NotificationCompletedtaskBundle"
        * versionId = "1"
  * step[+].operation
    * number = "14"
    * type = "search-type"
    * description = "EHR to Fit4Life - Search on Task, with include for outputs containing DiagnosticReport. Request: GET /Task?patient=scen2PatientJohansson&owner.name=Fit 4 Life"
    * initiator = "ehr"
    * receiver = "fit4life"
    * request.resourceId = "sc2textFile6"
    * response
      * resourceId = "scen2TaskFit4lifeV3"
      * versionId = "3"
  * step[+].operation
    * number = "15"
    * type = "search-type"
    * description = "EHR to Fit4Life - Search on referenced Observations. Request: GET /DiagnosticReport?patient=scen2PatientJohansson&category=PhysicalActivity&_include=DiagnosticReport:result"
    * initiator = "ehr"
    * receiver = "fit4life"
    * request.resourceId = "sc2textFile7"
    * response
      * resourceId = "scen2DiagnosticReportObservationsResponseBundle"
      * versionId = "1"

Instance: scen2SubscriptionEhr
InstanceOf: Subscription
Title:       "EHR Subscription for Task Monitoring"
Description:  "A subscription for Fit4Life organization to monitor task updates."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-15T12:00:00Z"
* status = #requested
* criteria = "Task?owner=Organization/scen2OrgFit4life"
* channel
  * type = #rest-hook
  * endpoint = "https://ehr.example.com/Subscription"
  * payload = #application/fhir+json
* contact[0]
  * system = #phone
  * value = "123-456-7890"
  * use = #work
* contact[+]
  * system = #email
  * value = "ehr@example.com"
  * use = #work
* end = "2024-01-01T00:00:00Z"
* reason = "Monitoring tasks"

Instance: scen2SubscriptionGetfit
InstanceOf: Subscription
Title:       "GetFit Subscription for Task Monitoring"
Description:  "A subscription for GetFit Training organization to monitor task updates."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-07-15T12:00:00Z"
* status = #requested
* criteria = "Task?owner=Organization/scen2OrgGetfittraining"
* channel
  * type = #rest-hook
  * endpoint = "https://getfit.example.com/Subscription"
  * payload = #application/fhir+json
* contact[0]
  * system = #phone
  * value = "987-654-3210"
  * use = #work
* contact[+]
  * system = #email
  * value = "getfit@example.com"
  * use = #work
* end = "2024-01-01T00:00:00Z"
* reason = "Monitoring task updates"


Instance: scen2PractitionerTrainerSearchsetBundle
InstanceOf: Bundle
Title:       "Personal Trainers Searchset Bundle"
Description:  "Bundle representing the search results for personal trainers within the specified postcode."
Usage: #example
* type = #searchset
* total = 2
* entry[0]
  * fullUrl = "http://example.com/fhir/PractitionerRole/scen2RoleWang"
  * resource = scen2RoleWang
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Practitioner/scen2PractitionerWang"
  * resource = scen2PractitionerWang
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/PractitionerRole/scen2RoleMatthew"
  * resource = scen2RoleMatthew
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Practitioner/scen2PractitionerMatthew"
  * resource = scen2PractitionerMatthew
  * search.mode = #include
* link
  * relation = "self"
  * url = "http://example.com/fhir/PractitionerRole?role=228239008&location.address-postalcode=XXXXXX&_include=PractitionerRole:practitioner"

Instance: scen2RoleWang
InstanceOf: PractitionerRole
Title:       "Role - Wang"
Description:  "Mrs. Kim Wang is a personal trainer working for Get Fit Training."
Usage: #example
* active = true
* practitioner = Reference(scen2PractitionerWang) "Mrs. Wang"
* organization = Reference(Organization/scen2OrgGetfittraining) "Get Fit Training"
* code = $sct#228239008 "Trainers"

Instance: scen2PractitionerWang
InstanceOf: Practitioner
Title:       "Practitioner Kim Wang"
Description:  "Mrs. Kim Wang is a qualified personal trainer at Get Fit Training."
Usage: #example
* identifier
  * system = "http://example.com/identifier"
  * value = "78903"
* active = true
* name
  * use = #official
  * family = "Wang"
  * given = "Kim"
* qualification
  * identifier
    * system = "http://example.org/identifier"
    * value = "12347"
  * code = $sct#228239008 "Trainers"
  * period.start = "2000-01-01"
  * issuer = Reference(Organization/scen2OrgGetfittraining) "Get Fit Training"

Instance: scen2RoleMatthew
InstanceOf: PractitionerRole
Title:       "Trainer Role for Mr. Matthew"
Description:  "Role of Mr. Matthew who serves as a personal trainer at the Fit 4 Life organization."
Usage: #example
* active = true
* practitioner = Reference(scen2PractitionerMatthew) "Mr. Matthew"
* organization = Reference(Organization/scen2OrgFit4life) "Fit 4 Life"
* code = $sct#228239008 "Trainers"

Instance: scen2PractitionerMatthew
InstanceOf: Practitioner
Title:       "Practitioner - Daniel Matthew"
Description:  "Profile of Mr. Daniel Matthew who serves as a personal trainer at the Fit 4 Life organization."
Usage: #example
* identifier
  * system = "http://example.com/identifier"
  * value = "78904"
* active = true
* name
  * use = #official
  * family = "Matthew"
  * given = "Daniel"
* qualification
  * identifier
    * system = "http://example.org/identifier"
    * value = "12348"
  * code = $sct#228239008 "Trainers"
  * period.start = "2000-01-01"
  * issuer = Reference(Organization/scen2OrgFit4life) "Fit 4 Life"

Instance: scen2PractitionerLopez
InstanceOf: Practitioner
Title:       "Practitioner - John Lopez"
Description:  "Profile of Dr. Lopez."
Usage: #example
* name
  * family = "Lopez"
  * given = "John"

Instance: scen2RoleLopez
InstanceOf: PractitionerRole
Title:       "PractitionerRole - John Lopez"
Description:  "Role of Dr. Lopez who serves as a cardiologist at the Good Health Cardiology organization."
Usage: #example
* practitioner = Reference(Practitioner/scen2PractitionerLopez)
* code = $sct#17561000 "Cardiologist"
* organization.display = "Good Health Cardiology"

Instance: scen2SubscriptionNotificationNewtaskBundle
InstanceOf: Bundle
Title:       "Notification Bundle for New Task at Get Fit Training"
Description:  "Bundle represents a subscription notification triggered by the creation of a new task."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-03-15T12:00:00Z"
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/scen2parameters"
  * resource = scen2parameters
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscription/$status"
  * response.status = "200"

Instance: scen2parameters
InstanceOf: Parameters
Title:       "Subscription Notification Parameters for New Task"
Description:  "Parameters include the reference to the subscription, the type of notification, and the focus of the notification."
Usage: #example
* parameter[0]
  * name = "subscription"
  * valueReference = Reference(Subscription/scen2SubscriptionGetfit)
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference(Task/scen2TaskGetfit)


Instance: scen2TaskGetfitResponseBundle
InstanceOf: Bundle
Title:       "Task Query Response Bundle for Get Fit Training"
Description:  "Bundle represents a search response to a Task query made for tasks related to patient 'Johansson' and owned by 'Get Fit Training'."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-16T10:00:00Z"
* type = #searchset
* total = 1
* link
  * relation = "self"
  * url = "http://example.com/fhir/Task?patient=scen2PatientJohansson&owner.name=Get%20Fit%20Training&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus"
* entry[0]
  * fullUrl = "http://example.com/fhir/Task/scen2TaskGetfit"
  * resource = scen2TaskGetfit
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Patient/scen2PatientJohansson"
  * resource = scen2PatientJohansson
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/ServiceRequest/scen2Servicerequest"
  * resource = scen2Servicerequest
  * search.mode = #include


Instance: scen2TaskGetfit
InstanceOf: Task
Title:       "Get Fit Training Task for Patient Johansson"
Description:  "Task instance represents a 'Fulfill' order task for patient Johansson."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-03-15T12:00:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen2Servicerequest)
* for = Reference(Patient/scen2PatientJohansson)
* authoredOn = "2023-03-15"
* owner = Reference(Organization/scen2OrgGetfittraining)


Instance: scen2TaskGetfitV2
InstanceOf: Task
Title:       "Updated Get Fit Training Task for Patient Johansson"
Description:  "The updated Task instance shows the 'Fulfill' order task for patient Johansson has been refused. "
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-03-16T10:00:00Z"
* status = #rejected
* statusReason.text = "unavailable until 2 months later"
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen2Servicerequest)
* for = Reference(Patient/scen2PatientJohansson)
* authoredOn = "2023-03-15"
* owner = Reference(Organization/scen2OrgGetfittraining)

Instance: scen2PatientJohansson
InstanceOf: Patient
Title:       "Patient Johansson"
Description:  "Patient instance represents Nancy Johansson"
Usage: #example
* identifier
  * use = #usual
  * type = $v2-0203#MR "Medical record number"
    * text = "Medical record number"
  * system = "http://hospital.example.org/identifiers/mrn"
  * value = "123456"
* active = true
* name
  * use = #official
  * family = "Johansson"
  * given = "Nancy"
* telecom[0]
  * system = #phone
  * value = "+1 (555) 555-5555"
  * use = #home
* telecom[+]
  * system = #email
  * value = "nancy.johansson@example.com"
  * use = #home
* gender = #male
* birthDate = "1960-05-15"
* address
  * use = #home
  * line = "123 Main St"
  * city = "Springfield"
  * state = "IL"
  * postalCode = "62701"
  * country = "USA"

Instance: scen2Servicerequest
InstanceOf: ServiceRequest
Title:       "Service Request for Physical Activity Program"
Description:  "This ServiceRequest instance represents a physical activity request for patient Nancy Johansson"
Usage: #example
* status = #active
* intent = #original-order
* priority = #routine
* category[0] = $sct#409063005 "Counseling"
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $sct#390893007 "Referral to physical activity program (Procedure)"
* requester = Reference(PractitionerRole/scen2RoleLopez)
* subject = Reference(Patient/scen2PatientJohansson)
* reasonCode[0] = $sct#40979000 "Lack of physical exercise"


Instance: scen2TaskFit4life
InstanceOf: Task
Title:       "Task for Nancy Johansson by Fit 4 Life"
Description:  "Task instance represents a 'Fulfill' order task for patient Johansson."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-03-16T11:00:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen2Servicerequest)
* for = Reference(Patient/scen2PatientJohansson)
* authoredOn = "2023-03-16"
* owner = Reference(Organization/scen2OrgFit4life)


Instance: scen2TaskFit4lifeV2
InstanceOf: Task
Title:       "Updated Fit 4 Life Task for Patient Johansson"
Description:  "This updated Task instance (version 2) represents an in-progress task for patient Nancy Johansson."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-03-16T12:00:00Z"
* status = #in-progress
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen2Servicerequest)
* for = Reference(Patient/scen2PatientJohansson)
* authoredOn = "2023-03-16"
* owner = Reference(Organization/scen2OrgFit4life)


Instance: scen2TaskFit4lifeV3
InstanceOf: Task
Title:       "Completed Physical Activity Program Task"
Description:  "This updated Task instance (version 3) represents a completed task for patient Nancy Johansson"
Usage: #example
* meta
  * versionId = "3"
  * lastUpdated = "2023-05-16T12:00:00Z"
* status = #completed
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen2Servicerequest)
* for = Reference(Patient/scen2PatientJohansson)
* authoredOn = "2023-03-16"
* lastModified = "2023-05-16"
* owner = Reference(Organization/scen2OrgFit4life)
* output
  * type = $SDOHCC-CodeSystemTemporaryCodes#resulting-activity "Resulting Activity"
  * valueReference = Reference(DiagnosticReport/scen2DiagnosticReport)


Instance: scen2TaskFit4lifeResponseBundle
InstanceOf: Bundle
Title:       "Task Response Bundle"
Description:  "Bundle instance returning 1 Task entry"
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-16T12:00:00Z"
* type = #searchset
* total = 1
* link
  * relation = "self"
  * url = "http://example.com/fhir/Task?patient=scen2PatientJohansson&owner.name=Fit%204%20Life&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus"
* entry[0]
  * fullUrl = "http://example.com/fhir/Task/scen2TaskFit4life"
  * resource = scen2TaskFit4life
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Patient/scen2PatientJohansson"
  * resource = scen2PatientJohansson
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/ServiceRequest/scen2Servicerequest"
  * resource = scen2Servicerequest
  * search.mode = #include



Instance: scen2ConditionResponseBundle
InstanceOf: Bundle
Title:       "Condition Response Bundle"
Description:  "Bundle returning conditions for Patient Johansson"
Usage: #example
* type = #searchset
* total = 2
* link
  * relation = "self"
  * url = "http://example.com/fhir/Condition?patient=scen2PatientJohansson&category=PhysicalActivity"
* entry[0]
  * fullUrl = "http://example.com/fhir/Condition/scen2ConditionLackOfExercise"
  * resource = scen2ConditionLackOfExercise
* entry[+]
  * fullUrl = "http://example.com/fhir/Condition/scen2ConditionCardio"
  * resource = scen2ConditionCardio

Instance: scen2ConditionLackOfExercise
InstanceOf: Condition
Title:       "Patient Johansson's Lack of physical exercise Condition"
Description:  "This instance represents Patient Johansson's condition, which is clinically active and confirmed."
Usage: #example
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed
* category = $pa-temporary-codes#PhysicalActivity
* code =  $sct#40979000 "Lack of physical exercise"
* subject = Reference(Patient/scen2PatientJohansson)
* onsetDateTime = "2022-02-01"
* asserter = Reference(PractitionerRole/scen2RoleLopez) "Dr. Lopez"

Instance: scen2ConditionCardio
InstanceOf: Condition
Title:       "Patient Johansson's Hypertension Condition"
Description:  "This instance represents Patient Johansson's hypertension condition, which is clinically active and confirmed."
Usage: #example
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed
* category = $pa-temporary-codes#PhysicalActivity
* code = $sct#38341003 "Hypertension"
* subject = Reference(Patient/scen2PatientJohansson)
* onsetDateTime = "2022-03-01"
* asserter = Reference(PractitionerRole/scen2RoleLopez) "Dr. Lopez"


Instance: scen2ObservationResponseBundle
InstanceOf: Bundle
Title:       "Bundle returning Physical Activity Observations"
Description:  "This bundle includes Patient Johansson's physical activity observations, including the number of days per week engaged in physical activity and the number of minutes per day spent on physical activity."
Usage: #example
* type = #searchset
* total = 2
* link
  * relation = "self"
  * url = "http://example.com/fhir/Observation?patient=scen2PatientJohansson&category=PhysicalActivity"
* entry[0]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsDaysPerWeek"
  * resource = scen2ObsDaysPerWeek
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsMinutesPerDay"
  * resource = scen2ObsMinutesPerDay

Instance: scen2ObsDaysPerWeek
InstanceOf: Observation
Title:       "Weekly Physical Activity Observation"
Description:  "This observation represents the number of days per week that Patient Johansson engages in physical activity."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#89555-7
* subject = Reference(Patient/scen2PatientJohansson)
* performer = Reference(PractitionerRole/scen2RoleLopez) "Dr. Lopez"
* valueQuantity = 1 'd/wk' "day per week"

Instance: scen2ObsMinutesPerDay
InstanceOf: Observation
Title:       "Daily Physical Activity Observation"
Description:  "This observation represents the number of minutes per day that Patient Johansson engages in physical activity."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen2PatientJohansson)
* performer = Reference(PractitionerRole/scen2RoleLopez) "Dr. Lopez"
* valueQuantity = 15 'min/d' "minutes per day"

Instance: scen2NotificationUpdatedtaskBundle
InstanceOf: Bundle
Title:       "Updated Task Notification Bundle"
Description:  "This bundle contains notifications for updated tasks for Patient Johansson."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-03-16T12:00:00Z"
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/scen2parameters2"
  * resource = scen2parameters2
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscription/$status"
  * response.status = "200"

Instance: scen2parameters2
InstanceOf: Parameters
Title:       "Notification Parameters for Updated Task"
Description:  "These parameters contain information about the updated task notification, including the associated subscription and the focus task."
Usage: #example
* parameter[0]
  * name = "subscription"
  * valueReference = Reference(Subscription/scen2SubscriptionEhr)
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference(Task/scen2TaskFit4life)

Instance: scen2NotificationCompletedtaskBundle
InstanceOf: Bundle
Title:       "Completed Task Notification Bundle"
Description:  "This bundle contains notifications for completed tasks related to physical activity."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-16T12:00:00Z"
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/scen2parameters3"
  * resource = scen2parameters3
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscription/$status"
  * response.status = "200"

Instance: scen2parameters3
InstanceOf: Parameters
Title:       "Notification Parameters for Completed Task"
Description:  "These parameters contain information about the completed task notification."
Usage: #example
* parameter[0]
  * name = "subscription"
  * valueReference = Reference(Subscription/scen2SubscriptionEhr)
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference(Task/scen2TaskFit4life)


Instance: scen2DiagnosticReportObservationsResponseBundle
InstanceOf: Bundle
Title:       "Diagnostic Report with Physical Activity Observations"
Description:  "This bundle contains a diagnostic report and related observations for physical activity."
Usage: #example
* type = #searchset
* total = 1
* link
  * relation = "self"
  * url = "http://example.com/fhir/DiagnosticReport?patient=scen2PatientJohansson&category=PhysicalActivity&_include=DiagnosticReport:result"
* entry[0]
  * fullUrl = "http://example.com/fhir/DiagnosticReport/scen2DiagnosticReport"
  * resource = scen2DiagnosticReport
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsDaysPerWeek2"
  * resource = scen2ObsDaysPerWeek2
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsMinutesPerDay2"
  * resource = scen2ObsMinutesPerDay2
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsActivityCalories"
  * resource = scen2ObsActivityCalories
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen2ObsActivityPeakHR"
  * resource = scen2ObsActivityPeakHR
  * search.mode = #include

Instance: scen2DiagnosticReport
InstanceOf: DiagnosticReport
Title:       "Physical Activity Consultation Report"
Description:  "A diagnostic report documenting the physical activity consultation for patient Aisha Khatun."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-16T12:00:00Z"
* basedOn = Reference(ServiceRequest/scen2Servicerequest)
* status = #final
* category = $pa-temporary-codes#PhysicalActivity "Physical Activity"
* code = $loinc#11488-4 "Consult note"
* subject = Reference(Patient/scen2PatientJohansson)
* performer = Reference(Organization/scen2OrgFit4life)
* result[0] = Reference(scen2ObsDaysPerWeek2)
* result[+] = Reference(scen2ObsMinutesPerDay2)
* result[+] = Reference(scen2ObsActivityCalories)
* result[+] = Reference(scen2ObsActivityPeakHR)

Instance: scen2ObsDaysPerWeek2
InstanceOf: Observation
Title:       "Weekly Physical Activity Days"
Description:  "The number of days per week the patient engages in physical activity."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#89555-7
* subject = Reference(Patient/scen2PatientJohansson)
* valueQuantity = 5 'd/wk' "days per week"

Instance: scen2ObsMinutesPerDay2
InstanceOf: Observation
Title:       "Daily Physical Activity Duration"
Description:  "The duration of physical activity in minutes per day for the patient."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen2PatientJohansson)
* valueQuantity = 20 'min/d' "minutes per day"

Instance: scen2ObsActivityCalories
InstanceOf: Observation
Title:       "Calories Burned in 24 hours"
Description:  "The number of calories burned by the patient through physical activity in a 24-hour period."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* subject = Reference(Patient/scen2PatientJohansson)
* effectiveDateTime = "2023-05-16"
* valueQuantity = 500 'kcal'

Instance: scen2ObsActivityPeakHR
InstanceOf: Observation
Title:       "Maximum Heart Rate during Activity"
Description:  "The maximum heart rate achieved by the patient during physical activity."
Usage: #example
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#55422-0 "Heart rate Encounter maximum"
* subject = Reference(Patient/scen2PatientJohansson)
* effectiveDateTime = "2023-05-16"
* valueQuantity = 150 '/min'


Instance: scen2OrgFit4life
InstanceOf: Organization
Title:       "Fit 4 Life"
Description:  "An organization named Fit 4 Life."
Usage: #example
* identifier
  * system = "http://example.com/identifier"
  * value = "65432"
* active = true
* name = "Fit 4 Life"

Instance: scen2OrgGetfittraining
InstanceOf: Organization
Title:       "Get Fit Training"
Description:  "An organization named Get Fit Training."
Usage: #example
* identifier
  * system = "http://example.com/identifier"
  * value = "54321"
* active = true
* name = "Get Fit Training"

