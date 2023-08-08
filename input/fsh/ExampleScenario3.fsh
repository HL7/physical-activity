Instance: Scen3ProviderToYMCAReferral
InstanceOf: ExampleScenario
Title:       "Scenario 3 - Patient Seeks Referral for Exercise Program"
Description: "This scenario illustrates the process of a referral from a healthcare provider to a fitness service provider. It outlines the creation and monitoring of a ServiceRequest for a patient, communication of task updates between entities, and the eventual completion of the task. "
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "PatientSeeksReferralforExerciseProgram"
* insert ActorEntity(mainClinic, "Main Street Clinic",      [[Dr. Blackrock's EHR - creates referral at patient's request]])
* insert ActorEntity(YMCA,       "Cincinnati Central YMCA", [[Fitness service provider who offers exercise program]])
* insert Instance_Empty(Scen3query1, Binary, "Query for Referral & Patient for YMCA Task",      [[Search to retrieve ServiceRequest and Patient for specified Task: `GET https://mainClinic.example.org/fhir/ServiceRequest?_id=Scen3ServiceRequest&_include=ServiceRequest:patient`]])
* insert Instance_Empty(Scen3query2, Binary, "Query for EHR-issued task based on notification", [[Search to retrieve Task: `GET https://YMCA.example.org/fhir/Task?_id=Scen3TaskYMCA`]])
* insert Instance_Content(Scen3SubscriptionEhr,                       Subscription, "Subscription from EHR", [[Establishes the subscription for the EHR to monitor tasks it's created]])
* insert Instance_Empty(Scen3TaskYMCA, Task, "Task seeking FitLife to fulfill referral", [[A Task seeking fulfillment by the YMCA of the referral for an exercise program]])
* insert InstanceVersion(1, "Initial YMCA Task",   Scen3TaskYMCAV1, [[Initial version of the referral fulfillment request for YMCA with a status of 'requested']])
* insert InstanceVersion(2, "Updated YMCA Task",   Scen3TaskYMCAV2, [[Version of the referral fulfillment request for YMCA after it has been changed to 'accepted']])
* insert InstanceVersion(3, "Completed YMCA Task", Scen3TaskYMCAV3, [[Version of the referral fulfillment request for YMCA after it has been changed to 'completed' and a link to the report added]])
* insert Instance_Content(Scen3ServiceRequestYMCAResponseBundle,      Bundle,       "ServiceRequest search response for YMCA", [[Search-set Bundle returning ServiceRequest and Patient for the Task posted to the YMCA]])
* insert Instance_Content(Scen3NotificationUpdatedTaskBundle,              Bundle, "Subscription Notification that Task has updated", [[Pointer to the Task that has been updated]])
* insert Instance_Content(Scen3NotificationCompletedTaskBundle,            Bundle, "Subscription Notification that Task has completed", [[Pointer to the Task that has been updated]])
* insert Instance_Content(Scen3TaskEHRResponseBundle1,                     Bundle, "Accepted Task search response for EHR", [[Search-set Bundle returning 'accepted' Task with id based on subscription notification]])
* insert InstanceContains(Scen3TaskYMCA, 2)
* insert Instance_Content(Scen3TaskEHRResponseBundle2,                     Bundle, "Completed Task search response for EHR", [[Search-set Bundle returning 'completed' Task with id based on subscription notification]])
* insert InstanceContains(Scen3TaskYMCA, 3)
* process[+]
  * title = "Subscription Establishment"
  * preConditions = "Main Street Clinic and Cinicinnati Central YMCA have established legal and technical arrangements for interoperability"
  * postConditions = "Subscription is successfully created allowing Main Street Clinic to monitor YMCA-assigned Tasks"
  * insert ProcessCreate(1, "Create EHR-monitoring Subscription", YMCA,       mainClinic, Scen3SubscriptionEhr, ,                             [[YMCA posts Subscription to EHR to monitor Tasks. Request: `POST https://mainClinic.example.org/fhir/Subscription`  Response: `201 Created`]])
* process[+]
  * title = "A minute after creation of ServiceRequest"
  * preConditions = "EHR has created a ServiceRequest for Mr. Shevchenko"
  * postConditions = "YMCA has retrieved the ServiceRequest and the Patient, and updated the Task to 'in-progress'"
  * insert ProcessCreate(2, "Create Task on YMCA",                mainClinic, YMCA,       Scen3TaskYMCA, 1,                                   [[New Task is created directly on YMCA's server.  Request: `POST https://YMCA.example.org/fhir/Task` Response: `201 Created`]])
  * insert ProcessSearch(3, "YMCA retrieves referral",            YMCA,       mainClinic, Scen3query1, Scen3ServiceRequestYMCAResponseBundle, [[YMCA retrieves the ServiceRequest and Patient referenced by the Task.]])
  * insert ProcessCreate(4, "EHR gets referral acceptance",       YMCA,       mainClinic, Scen3NotificationUpdatedTaskBundle, ,               [[A subscription notification to the EHR is triggered when YMCA changes the prescription status to 'in-progress'.  Request: `POST https://mainClinic.example.org/mySubscriptions` Response: `200 Ok`]])
  * insert ProcessSearch(5, "EHR retrieves in-progress Task",     mainClinic, YMCA,       Scen3query2, Scen3TaskEHRResponseBundle1,           [[EHR retrieves the Task referenced by the subscription notification]])
* process[+]
  * title = "About 4 Months Later"
  * preConditions = "YMCA is actively working on the Task"
  * postConditions = "YMCA has completed the referral and Dr. Blackrock is aware of the results"
  * insert ProcessCreate(6, "EHR gets referral acceptance",       YMCA,       mainClinic, Scen3NotificationCompletedTaskBundle, ,             [[A subscription notification to the EHR is triggered when the YMCA changes the Task status to 'completed'.  Request: `POST https://mainClinic.example.org/mySubscriptions` Response: `200 Ok`]])
  * insert ProcessSearch(7, "EHR retrieves completed Task",       mainClinic, YMCA,       Scen3query2, Scen3TaskEHRResponseBundle2,           [[EHR retrieves the Task referenced by the subscription notification]])

Instance: Scen3SubscriptionEhr
InstanceOf: BackportSubscription
Title:       "Subscription - EHR Monitoring Task - Scenario 3"
Description:  "Subscription to monitor tasks based on the criteria."
Usage: #example
* status = #requested
* criteria = "Task?owner=https://registry.example.org/fhir/Organization/Scen3YMCA"
* channel
  * type = #rest-hook
  * endpoint = "https://ehr.example.com/Subscription"
  * payload = #application/fhir+json
    * extension[content].valueCode = #id-only
* contact[+]
  * system = #phone
  * value = "123-456-7890"
  * use = #work
* contact[+]
  * system = #email
  * value = "ehr3@example.com"
  * use = #work
* end = "2024-01-01T00:00:00Z"
* reason = "Monitoring tasks"


Instance: Scen3ServiceRequest
InstanceOf: PAServiceRequest
Title:       "ServiceRequest - PA Program Referral - Scenario 3"
Description:  "Service request for a physical activity program, including counseling, for patient James Shevchenko."
Usage: #example
* insert ExerciseReferral(2023-05-15, 2023-08-30, Scen3PatientShevchenko, "Nancy Johansson", Scen3RoleBlackrock, "Dr. Blackrock", $sct#390893007, [[Referral to physical activity program]])
* reasonCode[+] = $sct#40979000 "Lack of physical exercise"

Instance: Scen3TaskYMCAV1
InstanceOf: PATaskForReferralManagement
Title:       "Task - Seeking fufillment from YMCA 'requested' - Scenario 3"
Description:  "Task assigned to the YMCA organization to fulfill a physical activity service request."
Usage: #example
* insert FulfillTask(Scen3PatientShevchenko, "James Shevchenko", Scen3OrgMainClinic, "Main Street Clinic", Scen3OrgYMCA, "Cincinnati Central YMCA", Scen3ServiceRequest, requested, 2023-05-15)

Instance: Scen3TaskYMCAV2
InstanceOf: PATaskForReferralManagement
Title:       "Task - Seeking fufillment from YMCA 'in-progress' - Scenario 3"
Description:  "Task in progress assigned to the YMCA organization to fulfill a physical activity service request."
Usage: #example
* insert FulfillTask(Scen3PatientShevchenko, "James Shevchenko", Scen3OrgMainClinic, "Main Street Clinic", Scen3OrgYMCA, "Cincinnati Central YMCA", Scen3ServiceRequest, in-progress, 2023-05-15)

Instance: Scen3TaskYMCAV3
InstanceOf: PATaskForReferralManagement
Title:       "Task - Seeking fulfillment from YMCA 'completed' - Scenario 3"
Description:  "Task successfully completed by the YMCA organization."
Usage: #example
* insert FulfillTask(Scen3PatientShevchenko, "James Shevchenko", Scen3OrgMainClinic, "Main Street Clinic", Scen3OrgYMCA, "Cincinnati Central YMCA", Scen3ServiceRequest, completed, 2023-05-15)
* insert Note(2023-08-21T15:37:18-04:00, Scen3OrgYMCA, "Cincinnati Central YMCA", [[Successful completion of the exercise program.]])

Instance: Scen3ServiceRequestYMCAResponseBundle
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - ServiceRequest - Exercise program referral - Scenario 3"
Description:  "Bundle containing ServiceRequest and Patient referenced by Task received by the YMCA organization."
Usage: #example
* insert SearchBundle(1, [[https://mainClinic.example.org/fhir/ServiceRequest?_id=Scen3ServiceRequest&_include=ServiceRequest:patient]])
* insert EntryMatch(ServiceRequest, Scen3ServiceRequest)
* insert EntryInclude(Patient, Scen3PatientShevchenko)

Instance: Scen3NotificationUpdatedTaskBundle
InstanceOf: BackportSubscriptionNotificationR4
Title:       "Bundle 'Subscription Notification' - Task - accepted - Scenario 3"
Description:  "Bundle containing the notification of an updated task related to physical activity."
Usage: #example
* insert SubNotification(Scen3Parameters1, mainClinic, Scen3SubscriptionEhr)

Instance: Scen3Parameters1
InstanceOf: BackportSubscriptionStatusR4
Title:       "Parameters 'Subscription Status' - Task - accepted - Scenario 3"
Description:  "Parameters include the reference to the subscription, the type of notification, and the focus of the notification."
Usage: #example
* insert SubParameters(Scen3SubscriptionEhr, Scen3TaskYMCAV2, 10721)

Instance: Scen3NotificationCompletedTaskBundle
InstanceOf: BackportSubscriptionNotificationR4
Title:       "Bundle 'Subscription Notification' - Task - completed - Scenario 3"
Description:  "Bundle containing the notification of a completed task related to physical activity."
Usage: #example
* insert SubNotification(Scen3Parameters2, mainClinic, Scen3SubscriptionEhr)

Instance: Scen3Parameters2
InstanceOf: BackportSubscriptionStatusR4
Title:       "Parameters 'Subscription Status' - Task - completed - Scenario 3"
Description:  "Parameters include the reference to the subscription, the type of notification, and the focus of the notification."
Usage: #example
* insert SubParameters(Scen3SubscriptionEhr, Scen3TaskYMCAV3, 11676)

Instance: Scen3TaskEHRResponseBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - YMCA Task 'accepted' - Scenario 3"
Description: "Bundle instance returning accepted Task to EHR, prompted by subscription notification"
Usage: #example
* insert SearchBundle(1, [[https://YMCA.example.org/fhir/Task?_id=Scen3TaskYMCA]])
* insert EntryMatch(ServiceRequest, Scen3TaskYMCAV2)

Instance: Scen3TaskEHRResponseBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - YMCA Task 'completed' - Scenario 3"
Description: "Bundle instance returning completed Task to EHR, prompted by subscription notification"
Usage: #example
* insert SearchBundle(1, [[https://YMCA.example.org/fhir/Task?_id=Scen3TaskYMCA]])
* insert EntryMatch(ServiceRequest, Scen3TaskYMCAV3)

Instance: Scen3PatientShevchenko
InstanceOf: USCorePatientProfile
Title:       "Patient - James Shevchenko - Scenario 3"
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

Instance: Scen3OrgMainClinic
InstanceOf: USCoreOrganizationProfile
Title:       "Organization - Main Street Clinic - Scenario 3"
Description:  "Organization information for the Main Street Clinic."
Usage: #example
* identifier[NPI].value = "123456"
* active = true
* name = "Main Street Clinic"

Instance: Scen3OrgYMCA
InstanceOf: USCoreOrganizationProfile
Title:       "Organization - Cincinnati Central YMCA - Scenario 3"
Description:  "Organization information for the Cincinnati Central YMCA."
Usage: #example
* identifier[NPI].value = "1234567890"
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

Instance: Scen3PractitionerBlackrock
InstanceOf: USCorePractitionerProfile
Title:       "Practitioner - Dr. Blackrock - Scenario 3"
Description:  "Practitioner information for Dr. Blackrock, a general practitioner."
Usage: #example
* identifier[NPI].value = "78910"
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

Instance: Scen3RoleBlackrock
InstanceOf: USCorePractitionerRoleProfile
Title:       "PractitionerRole - Dr. Blackrock - Scenario 3"
Description:  "Practitioner role of Dr. Blackrock as a general practitioner at the Main Street Clinic."
Usage: #example
* active = true
* practitioner = Reference(Scen3PractitionerBlackrock) "Dr. Blackrock"
* organization = Reference(Scen3OrgMainClinic) "Main Street Clinic"
* code = $practitioner-role#doctor
  * text = "General Practitioner"