Instance: scen3ProviderToYMCAReferral
InstanceOf: ExampleScenario
Title:       "Scenario 3 - Patient Seeks Referral for Exercise Program"
Description: "This scenario illustrates the process of a referral from a healthcare provider to a fitness service provider. It outlines the creation and monitoring of a ServiceRequest for a patient, communication of task updates between entities, and the eventual completion of the task. "
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "PatientSeeksReferralforExerciseProgram"
* actor[+]
  * actorId = "ehr"
  * type = #entity
  * name = "EHR"
* actor[+]
  * actorId = "ymca"
  * type = #entity
  * name = "Cincinnati Central YMCA"
  * description = "Fitness Service Provider"
* instance[+]
  * resourceId = "scen3query1"
  * resourceType = #Binary
  * description = "Search to retrieve ServiceRequest and Patient: `GET /Task?patient=scen3PatientShevchenko&owner.name=Cincinnati Central YMCA&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus`"
* instance[+]
  * resourceId = "scen3query2"
  * resourceType = #Binary
  * description = "Search to retrieve Task: `GET /Task?patient=scen3PatientShevchenko&owner.name=Cincinnati Central YMCA`"
* instance[+]
  * resourceId = "scen3SubscriptionEhr"
  * resourceType = #Subscription
  * version
    * versionId = "1"
    * description = "Subscription successfully created"
* instance[+]
  * resourceId = "scen3TaskYMCA"
  * resourceType = #Task
  * version[+]
    * versionId = "1"
    * description = "EHR to YMCA - Task (seeking fulfillment of ServiceRequest) successfully created"
  * version[+]
    * versionId = "2"
    * description = "Updated Task"
  * version[+]
    * versionId = "3"
    * description = "Completed Task (includes notes)"
* instance[+]
  * resourceId = "scen3TaskYmcaResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning Task, associated ServiceRequest and Patient"
* instance[+]
  * resourceId = "scen3NotificationUpdatedtaskBundle"
  * resourceType = #Bundle
  * version
    * versionId = "1"
    * description = "Subscription Notification that Task has updated"
* instance[+]
  * resourceId = "scen3NotificationCompletedtaskBundle"
  * resourceType = #Bundle
  * version
    * versionId = "1"
    * description = "Subscription Notification that Task has completed"
* process[+]
  * title = "Subscription Establishment"
  * preConditions = "EHR and YMCA have established connectivity"
  * postConditions = "Subscription is successfully created and posted"
  * step.operation
    * number = "1"
    * type = "create"
    * description = "EHR posts Subscription to YMCA to monitor Tasks. Request: POST /Subscription"
    * initiator = "ehr"
    * receiver = "ymca"
    * request.resourceId = "scen3SubscriptionEhr"
    * response
      * resourceId = "scen3SubscriptionEhr"
      * versionId = "1"
* process[+]
  * title = "A minute after creation of ServiceRequest"
  * preConditions = "EHR has created a ServiceRequest for Mr. Shevchenko"
  * postConditions = "YMCA has retrieved the ServiceRequest and the Patient, and updated the Task"
  * step[+]
    * pause = true
    * operation
      * number = "2"
      * type = "create"
      * description = "EHR to YMCA - Task seeking fulfillment of ServiceRequest. Request: POST /Task"
      * initiator = "ehr"
      * receiver = "ymca"
      * request.resourceId = "scen3TaskYMCA"
      * response
        * resourceId = "scen3TaskYMCA"
        * versionId = "1"
  * step[+].operation
    * number = "3"
    * type = "search-type"
    * description = "YMCA to EHR - Search to retrieve ServiceRequest and Patient."
    * initiator = "ymca"
    * receiver = "ehr"
    * request.resourceId = "scen3query1"
    * response.resourceId = "scen3TaskYmcaResponseBundle"
  * step[+].operation
    * number = "4"
    * type = "create"
    * description = "YMCA to EHR - Subscription Notification that Task has changed. Request: POST /Bundle"
    * initiator = "ymca"
    * receiver = "ehr"
    * request.resourceId = "scen3NotificationUpdatedtaskBundle"
    * response
      * resourceId = "scen3NotificationUpdatedtaskBundle"
      * versionId = "1"
  * step[+].operation
    * number = "5"
    * type = "search-type"
    * description = "EHR to YMCA - Search to retrieve Task."
    * initiator = "ehr"
    * receiver = "ymca"
    * request.resourceId = "scen3query2"
    * response
      * resourceId = "scen3TaskYMCAV2"
      * versionId = "2"
* process[+]
  * title = "About 4 Months Later"
  * preConditions = "YMCA is actively working on the Task"
  * postConditions = "YMCA has completed the Task"
  * step[+]
    * pause = true
    * operation
      * number = "6"
      * type = "create"
      * description = "YMCA to EHR - Subscription Notification that Task has changed. Request: POST /Bundle"
      * initiator = "ymca"
      * receiver = "ehr"
      * request.resourceId = "scen3NotificationCompletedtaskBundle"
      * response
        * resourceId = "scen3NotificationCompletedtaskBundle"
        * versionId = "1"
  * step[+].operation
    * number = "7"
    * type = "search-type"
    * description = "EHR to YMCA - Search to retrieve Task."
    * initiator = "ehr"
    * receiver = "ymca"
    * request.resourceId = "scen3query2"
    * response
      * resourceId = "scen3TaskYMCAV3"
      * versionId = "3"

Instance: scen3SubscriptionEhr
InstanceOf: Subscription
Title:       "EHR Subscription for Task Monitoring"
Description:  "Subscription to monitor tasks based on the criteria."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2021-10-15T12:00:00Z"
* status = #requested
* criteria = "Task?owner=Organization/scen3OrgYMCA"
* channel
  * type = #rest-hook
  * endpoint = "https://ehr.example.com/Subscription"
  * payload = #application/fhir+json
* contact[+]
  * system = #phone
  * value = "123-456-7890"
  * use = #work
* contact[+]
  * system = #email
  * value = "ehr@example.com"
  * use = #work
* end = "2024-01-01T00:00:00Z"
* reason = "Monitoring tasks"


Instance: scen3TaskYMCA
InstanceOf: Task
Title:       "Physical Activity Task for YMCA"
Description:  "Task assigned to the YMCA organization to fulfill a physical activity service request."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T10:00:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen3Servicerequest)
* for = Reference(Patient/scen3PatientShevchenko)
* authoredOn = "2023-05-15"
* owner = Reference(Organization/scen3OrgYMCA)


Instance: scen3TaskYMCAV2
InstanceOf: Task
Title:       "In-progress Physical Activity Task for YMCA"
Description:  "Task in progress assigned to the YMCA organization to fulfill a physical activity service request."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-05-15T11:00:00Z"
* status = #in-progress
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen3Servicerequest)
* for = Reference(Patient/scen3PatientShevchenko)
* authoredOn = "2023-05-15"
* owner = Reference(Organization/scen3OrgYMCA)


Instance: scen3TaskYMCAV3
InstanceOf: Task
Title:       "Completed Physical Activity Task for YMCA"
Description:  "Task successfully completed by the YMCA organization."
Usage: #example
* meta
  * versionId = "3"
  * lastUpdated = "2023-09-15T11:00:00Z"
* status = #completed
* intent = #order
* code = $task-code#fulfill
* focus = Reference(ServiceRequest/scen3Servicerequest)
* for = Reference(Patient/scen3PatientShevchenko)
* authoredOn = "2023-05-15"
* owner = Reference(Organization/scen3OrgYMCA)
* note.text = "Successful completion of the exercise program."


Instance: scen3TaskYmcaResponseBundle
InstanceOf: Bundle
Title:       "Task Search Results"
Description:  "Bundle of search results for tasks related to physical activity assigned to the YMCA organization."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T10:00:00Z"
* type = #searchset
* total = 1
* link
  * relation = "self"
  * url = "http://example.com/fhir/Task?patient=scen3PatientShevchenko&owner.name=Cincinnati%20Central%20YMCA&focus.category=PhysicalActivity&_include=Task:patient&_include=Task:focus"
* entry[+]
  * fullUrl = "http://example.com/fhir/Task/scen3TaskYMCA"
  * resource = scen3TaskYMCA
  * search.mode = #match
* entry[+]
  * fullUrl = "http://example.com/fhir/Patient/scen3PatientShevchenko"
  * resource = scen3PatientShevchenko
  * search.mode = #include
* entry[+]
  * fullUrl = "http://example.com/fhir/ServiceRequest/scen3Servicerequest"
  * resource = scen3Servicerequest
  * search.mode = #include


Instance: scen3PatientShevchenko
InstanceOf: Patient
Title:       "Patient James Shevchenko"
Description:  "Patient information for James Shevchenko."
Usage: #example
* identifier
  * system = "http://hospital.example.org/patients"
  * value = "123456"
* active = true
* name
  * use = #official
  * family = "Shevchenko"
  * given = "James"
* telecom[+]
  * system = #phone
  * value = "+1-800-123-4567"
  * use = #home
* telecom[+]
  * system = #email
  * value = "mshevchenko@example.com"
  * use = #home
* gender = #male
* birthDate = "1980-01-01"
* address
  * use = #home
  * line = "123 Main St"
  * city = "Cincinnati"
  * state = "OH"
  * postalCode = "45202"
  * country = "USA"

Instance: scen3Servicerequest
InstanceOf: ServiceRequest
Title:       "Physical Activity Service Request"
Description:  "Service request for a physical activity program, including counseling, for patient James Shevchenko."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T09:59:00Z"
* status = #active
* intent = #original-order
* priority = #routine
* category[+] = $sct#409063005 "Counseling"
* category[+] = $PA-Temp#PhysicalActivity
* code = $sct#390893007 "Referral to physical activity program (Procedure)"
* requester = Reference(PractitionerRole/scen3RoleBlackrock)
* subject = Reference(scen3PatientShevchenko)

Instance: scen3NotificationUpdatedtaskBundle
InstanceOf: Bundle
Title:       "Updated Task Notification Bundle"
Description:  "Bundle containing the notification of an updated task related to physical activity."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T11:00:00Z"
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/scen3parameters1"
  * resource = scen3parameters1
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscription/$status"
  * response.status = "200"

Instance: scen3parameters1
InstanceOf: Parameters
Title:       "Subscription Notification Parameters for Updated Task"
Description:  "Parameters include the reference to the subscription, the type of notification, and the focus of the notification."
Usage: #example
* parameter[+]
  * name = "subscription"
  * valueReference = Reference(Subscription/scen3SubscriptionEhr)
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference(Task/scen3TaskYMCA)

Instance: scen3NotificationCompletedtaskBundle
InstanceOf: Bundle
Title:       "Completed Task Notification Bundle"
Description:  "Bundle containing the notification of a completed task related to physical activity."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-09-15T11:00:00Z"
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/scen3parameters2"
  * resource = scen3parameters2
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscription/$status"
  * response.status = "200"

Instance: scen3parameters2
InstanceOf: Parameters
Title:       "Subscription Notification Parameters for Completed Task"
Description:  "Parameters include the reference to the subscription, the type of notification, and the focus of the notification."
Usage: #example
* parameter[+]
  * name = "subscription"
  * valueReference = Reference(Subscription/scen3SubscriptionEhr)
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference(Task/scen3TaskYMCA)

Instance: scen3OrgMainclinic
InstanceOf: Organization
Title:       "Main Street Clinic"
Description:  "Organization information for the Main Street Clinic."
Usage: #example
* identifier
  * system = "http://hospital.example.org"
  * value = "123456"
* active = true
* name = "Main Street Clinic"


Instance: scen3OrgYMCA
InstanceOf: Organization
Title:       "Cincinnati Central YMCA"
Description:  "Organization information for the Cincinnati Central YMCA."
Usage: #example
* identifier
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value = "1234567890"
* active = true
* type = $organization-type#prov "Healthcare Provider"
* name = "Cincinnati Central YMCA"
* telecom
  * system = #phone
  * value = "+1-513-1234567"
  * use = #work
* address
  * use = #work
  * line = "1105 Elm St"
  * city = "Cincinnati"
  * state = "OH"
  * postalCode = "45202"
  * country = "USA"

Instance: scen3PractitionerBlackrock
InstanceOf: Practitioner
Title:       "Dr. Blackrock"
Description:  "Practitioner information for Dr. Blackrock, a general practitioner."
Usage: #example
* identifier
  * system = "http://hospital.example.org"
  * value = "78910"
* active = true
* name
  * use = #official
  * family = "Blackrock"
  * given = "Doctor"
* telecom[+]
  * system = #phone
  * value = "+1-800-456-7890"
  * use = #work
* telecom[+]
  * system = #email
  * value = "drblackrock@example.com"
  * use = #work
* address
  * use = #work
  * line = "123 Main St"
  * city = "City"
  * state = "State"
  * postalCode = "12345"
  * country = "Country"
* gender = #male


Instance: scen3RoleBlackrock
InstanceOf: PractitionerRole
Title:       "General Practitioner Role"
Description:  "Practitioner role of Dr. Blackrock as a general practitioner at the Main Street Clinic."
Usage: #example
* active = true
* practitioner = Reference(Practitioner/scen3PractitionerBlackrock) "Dr. Blackrock"
* organization = Reference(Organization/scen3OrgMainclinic) "Main Street Clinic"
* code = $practitioner-role#doctor
  * text = "General Practitioner"