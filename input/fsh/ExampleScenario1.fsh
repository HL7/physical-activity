Alias: $physical-activity-category = http://hl7.org/fhir/us/physical-activity/CodeSystem/physical-activity-category
Alias: $careplan-category = http://hl7.org/fhir/us/core/CodeSystem/careplan-category
Alias: $sct = http://snomed.info/sct
Alias: $goal-achievement = http://terminology.hl7.org/CodeSystem/goal-achievement
Alias: $pa-temporary-codes = http://hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes
Alias: $loinc = http://loinc.org
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $2.7 = http://terminology.hl7.org/CodeSystem/v2-0360/2.7
Alias: $practitioner-role = http://terminology.hl7.org/CodeSystem/practitioner-role

Instance: scen1ExercisePrescription
InstanceOf: ExampleScenario
Title:       "Scenario 1 - Exercise Prescription"
Description: "ExampleScenario instance illustrating how a patient app interacts with an EHR to manage and update an exercise plan. It covers the querying of resources such as CarePlan, Goal, ServiceRequest, and Task, posting of Observations regarding physical activity levels, and how these resources are updated over time."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "ExercisePrescription"
* actor[0]
  * actorId = "patientApp"
  * type = #entity
  * name = "Patient App"
  * description = "A patient app used to query resources related to the exercise plan"
* actor[+]
  * actorId = "ehr"
  * type = #entity
  * name = "EHR"
  * description = "EHR that records patient's exercise plan"
* instance[0]
  * resourceId = "scen1Careplan"
  * resourceType = #CarePlan
  * description = "CarePlan describing proposed exercise regime"
  * version[0]
    * versionId = "1"
    * description = "Initial CarePlan"
  * version[+]
    * versionId = "2"
    * description = "Updated CarePlan"
* instance[+]
  * resourceId = "scen1Goal"
  * resourceType = #Goal
  * description = "Goal with a target of 100 minutes of exercise per week"
  * version[0]
    * versionId = "1"
    * description = "Initial Goal - 100 mins/week"
  * version[+]
    * versionId = "2"
    * description = "Updated Goal - 150 mins/week"
* instance[+]
  * resourceId = "scen1ServiceRequest"
  * resourceType = #ServiceRequest
  * description = "ServiceRequest for exercise"
* instance[+]
  * resourceId = "scen1Task"
  * resourceType = #Task
  * description = "Tasks assigned to the patient"
* instance[+]
  * resourceId = "scen1ObservationMinsPerDay"
  * resourceType = #Observation
  * description = "Average minutes per day of moderate-to-vigorous physical activity"
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen1ObservationMinsPerWeek"
  * resourceType = #Observation
  * description = "Average minutes per week of moderate-to-vigorous physical activity."
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen1ObservationDaysPerWeek"
  * resourceType = #Observation
  * description = "Average days per week of moderate-to-vigorous physical activity."
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen1ObservationStrengthDaysPerWeek"
  * resourceType = #Observation
  * description = "Average days per week of muscle-strengthening physical activity."
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* process[0]
  * title = "Day after appointment"
  * preConditions = "Encounter (and other supporting) resources created"
  * postConditions = "Patient app retrieves exercise plan related resources"
  * step[0].operation
    * number = "1"
    * type = "search-type"
    * name = "Query CarePlan"
    * description = "Patient app queries exercise CarePlan describing proposed exercise regime. GET /CarePlan?patient=scen1PatientKhatun&category=PhysicalActivity"
    * request.resourceId = "textFile1"
    * response
      * resourceId = "scen1Careplan"
      * versionId = "1"
  * step[+].operation
    * number = "2"
    * type = "search-type"
    * name = "Query Goal"
    * description = "Patient app queries Goals (100 minutes/week). GET /Goal?patient=scen1PatientKhatun&category=PhysicalActivity"
    * request.resourceId = "textFile2"
    * response
      * resourceId = "scen1Goal"
      * versionId = "1"
  * step[+].operation
    * number = "3"
    * type = "search-type"
    * name = "Query ServiceRequest"
    * description = "Patient app queries ServiceRequest (order for ‘exercise’). GET /ServiceRequest?patient=scen1PatientKhatun&code=PhysicalActivity"
    * request.resourceId = "textFile3"
    * response.resourceId = "scen1ServiceRequest"
  * step[+].operation
    * number = "4"
    * type = "search-type"
    * name = "Query Task"
    * description = "Patient app queries for Tasks assigned to patient. GET /Task?patient=scen1PatientKhatun"
    * request.resourceId = "textFile4"
    * response.resourceId = "scen1Task"
* process[+]
  * title = "A couple of weeks later"
  * preConditions = "Patient follows exercise plan for a few weeks"
  * postConditions = "Patient app records weekly activity levels"
  * step[0]
    * pause = true
    * operation
      * number = "5"
      * type = "create"
      * name = "Post Observation"
      * description = "Patient app posts average minutes per day of moderate-to-vigorous physical activity. POST /Observation"
      * request.resourceId = "scen1ObservationMinsPerDay"
      * response
        * resourceId = "scen1ObservationMinsPerDay"
        * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "6"
      * type = "create"
      * name = "Post Observation"
      * description = "Patient app posts average minutes per week of moderate-to-vigorous physical activity. POST /Observation"
      * request.resourceId = "scen1ObservationMinsPerWeek"
      * response
        * resourceId = "scen1ObservationMinsPerWeek"
        * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "7"
      * type = "create"
      * name = "Post Observation"
      * description = "Patient app posts average days per week of moderate-to-vigorous physical activity. POST /Observation"
      * request.resourceId = "scen1ObservationDaysPerWeek"
      * response
        * resourceId = "scen1ObservationDaysPerWeek"
        * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "8"
      * type = "create"
      * name = "Post Observation"
      * description = "Patient app posts average days per week of muscle-strengthening physical activity. POST /Observation"
      * request.resourceId = "scen1ObservationStrengthDaysPerWeek"
      * response
        * resourceId = "scen1ObservationStrengthDaysPerWeek"
        * versionId = "1"
* process[+]
  * title = "A little more than 6 months after first appointment"
  * preConditions = "CarePlan and Goal have been updated"
  * postConditions = "Patient app retrieves updated CarePlan and Goal"
  * step[0]
    * pause = true
    * operation
      * number = "9"
      * type = "search-type"
      * name = "Query revised CarePlan"
      * description = "Patient app queries revised CarePlan with providers notes. GET /CarePlan?patient=scen1PatientKhatun&category=PhysicalActivity"
      * request.resourceId = "textFile1"
      * response
        * resourceId = "scen1CareplanV2"
        * versionId = "2"
  * step[+].operation
    * number = "10"
    * type = "search-type"
    * name = "Query revised Goal"
    * description = "Patient app queries revised Goal of 150 minutes/week. GET /Goal?patient=scen1PatientKhatun&category=PhysicalActivity"
    * request.resourceId = "textFile2"
    * response
      * resourceId = "scen1GoalV2"
      * versionId = "2"


Instance: scen1Careplan
InstanceOf: CarePlan
Title:       "Physical Activity Care Plan for Aisha Khatun"
Description:  "A CarePlan by Dr. Patel targeting physical activity for patient Aisha Khatun, including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-12-01T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-careplan"
* status = #active
* intent = #plan
* category[0] = $pa-temporary-codes#PhysicalActivity "Physical Activity"
  * text = "Physical Activity"
* category[+] = $careplan-category#assess-plan
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* created = "2022-12-01T00:00:00Z"
* author = Reference(PractitionerRole/scen1RolePatel) "Dr. Rajesh Patel"
* goal = Reference(Goal/scen1Goal) "Initial Goal - 100 mins/week"
* activity[0].detail
  * code = $sct#408581006 "Physical activity target moderate exercise"
  * status = #not-started
* activity[+].detail
  * code = $sct#266741004 "Muscle strength exercise (regime/therapy)"
  * status = #not-started


Instance: scen1CareplanV2
InstanceOf: CarePlan
Title:       "Updated Physical Activity CarePlan for Aisha Khatun"
Description:  "A revised CarePlan by Dr. Patel for Aisha Khatun, aiming at an increased level of physical activity including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-05-05T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-careplan"
* status = #active
* intent = #plan
* description = "Updated CarePlan - Increased level of physical activity"
* category[0] = $pa-temporary-codes#PhysicalActivity "Physical Activity"
  * text = "Physical Activity"
* category[+] = $careplan-category#assess-plan
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* created = "2023-05-05T00:00:00Z"
* author = Reference(PractitionerRole/scen1RolePatel) "Dr. Rajesh Patel"
* goal = Reference(Goal/scen1GoalV2) "Updated Goal - 150 mins/week"
* activity[0].detail
  * code = $sct#408581006 "Physical activity target moderate exercise"
  * status = #not-started
* activity[+].detail
  * code = $sct#266741004 "Muscle strength exercise (regime/therapy)"
  * status = #not-started


Instance: scen1Goal
InstanceOf: Goal
Title:       "Initial Physical Activity Goal for Aisha Khatun"
Description:  "A goal set for Aisha Khatun to incrementally increase her physical activity to at least 100 minutes per week over the next 6 months."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-12-01T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-goal"
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#in-progress
* category = $pa-temporary-codes#PhysicalActivity
* description.text = "Over the next 6 months\\, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult."
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* target
  * measure = $loinc#82290-8
  * detailQuantity = 100 'min/wk'
  * dueDate = "2023-05-01"


Instance: scen1GoalV2
InstanceOf: Goal
Title:       "Updated Physical Activity Goal for Aisha Khatun"
Description:  "An updated goal for Aisha Khatun to further increase her weekly exercise to 150 minutes, with notes on her progress and recommendations."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-05-01T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-goal"
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#in-progress
* category = $pa-temporary-codes#PhysicalActivity
* description.text = "Over the next 6 months\\, increase your weekly exercise in small increments to at least 150 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult."
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* target
  * measure = $loinc#82290-8
  * detailQuantity = 150 'min/wk'
  * dueDate = "2023-08-01"
* note
  * authorReference = Reference(Practitioner/scen1PractitionerPatel) "Dr. Rajesh Patel"
  * time = "2023-11-01"
  * text = "Significant progress.  Regularly exceeding the target and has found an activity he enjoys.  Need to branch out to one more activity to achieve guideline target."


Instance: scen1ServiceRequest
InstanceOf: ServiceRequest
Title:       "Physical Activity Program Referral for Aisha Khatun"
Description:  "Service request by Dr. Patel for Aisha Khatun to be referred to a physical activity program at Good Health Clinic as part of her care plan."
Usage: #example
* status = #active
* intent = #order
* category[0] = $sct#409063005 "Counseling"
* category[+] = $pa-temporary-codes#PhysicalActivity
* priority = #routine
* code = $sct#390893007 "Referral to physical activity program (Procedure)"
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* requester = Reference(Practitioner/scen1PractitionerPatel) "Dr. Rajesh Patel"
* occurrencePeriod
  * start = "2022-12-01"
  * end = "2023-05-01"
* performer = Reference(Organization/scen1OrgGoodhealth) "Good Health Clinic"
* basedOn = Reference(CarePlan/scen1Careplan) "CarePlan for Aisha Khatun"
* reasonCode[0] = $sct#38341003 "Hypertension"
* reasonCode[+] = $sct#40979000 "Lack of physical exercise"

Instance: scen1Task
InstanceOf: Task
Title:       "Aerobic Exercise Order Task for Aisha Khatun"
Description:  "Task order by Dr. Patel for Aisha Khatun to undertake an aerobic exercise regime as per the service request from December 1, 2022, to May 1, 2023."
Usage: #example
* status = #requested
* intent = #order
* priority = #routine
* focus = Reference(ServiceRequest/scen1ServiceRequest) "Aerobic exercise order for Aisha Khatun"
* for = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* authoredOn = "2022-12-01"
* requester = Reference(PractitionerRole/scen1RolePatel) "Dr. Rajesh Patel"
* executionPeriod
  * start = "2022-12-01T00:00:00Z"
  * end = "2023-05-01T23:59:59Z"


Instance: scen1ObservationDaysPerWeek
InstanceOf: Observation
Title:       "Aisha Khatun's Weekly Physical Activity Observation"
Description:  "Observation record for Aisha Khatun indicating that she is exercising 5 days per week."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-03-15T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-observation-evs-days-per-week"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#89555-7
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* effectiveDateTime = "2023-03-15"
* performer = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* valueQuantity = 5 'd/wk' "days per week"


Instance: scen1ObservationMinsPerDay
InstanceOf: Observation
Title:       "Aisha Khatun's Daily Physical Activity Duration Observation"
Description:  "Observation record for Aisha Khatun indicating that she is exercising for 15 minutes per day."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-01-08T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-observation-evs-min-per-day"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* effectiveDateTime = "2023-01-08"
* performer = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* valueQuantity = 15 'min/d' "minutes per day"


Instance: scen1ObservationMinsPerWeek
InstanceOf: Observation
Title:       "Aisha Khatun's Weekly Physical Activity Duration Observation"
Description:  "Observation record for Aisha Khatun indicating that she is exercising for 80 minutes per week."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-02-08T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-observation-evs-min-per-week"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#82290-8
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* effectiveDateTime = "2023-02-08"
* performer = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* valueQuantity = 80 'min/wk' "minutes per week"


Instance: scen1ObservationStrengthDaysPerWeek
InstanceOf: Observation
Title:       "Aisha Khatun's Weekly Strength Training Observation"
Description:  "Observation record for Aisha Khatun indicating that she performs strength training exercises 3 days per week."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-04-30T00:00:00Z"
  * profile = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/pa-observation-strength-days-per-week"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#82291-6
* subject = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* effectiveDateTime = "2023-04-30"
* performer = Reference(Patient/scen1PatientKhatun) "Aisha Khatun"
* valueQuantity = 3 'd/wk' "days per week"


Instance: scen1OrgGoodhealth
InstanceOf: Organization
Title:       "Good Health Clinic Organization"
Description:  "Good Health Clinic, a healthcare provider."
Usage: #example
* identifier
  * system = "http://example.com/organization"
  * value = "GH12345"
* active = true
* name = "Good Health Clinic"
* type = $organization-type#prov "Healthcare Provider"
  * text = "Healthcare Provider"
* telecom[0]
  * system = #phone
  * value = "+1(555) 555-6789"
  * use = #work
* telecom[+]
  * system = #email
  * value = "info@goodhealthclinic.com"
  * use = #work
* address
  * line = "456 Health Avenue"
  * city = "Medicity"
  * state = "NY"
  * postalCode = "54321"
  * country = "USA"

Instance: scen1PatientKhatun
InstanceOf: Patient
Title:       "Patient - Aisha Khatun"
Description:  "Profile of the patient Ms. Aisha Khatun."
Usage: #example
* identifier
  * system = "http://hospital.example.org/patients"
  * value = "123456"
* active = true
* name
  * family = "Khatun"
  * given = "Aisha"
  * prefix = "Ms."
* gender = #female
* birthDate = "1990-05-20"
* address
  * line = "123 Main St"
  * city = "Anytown"
  * state = "CA"
  * postalCode = "12345"
  * country = "USA"
* telecom[0]
  * system = #phone
  * value = "+1(555) 555-1234"
  * use = #home
* telecom[+]
  * system = #email
  * value = "aisha.khatun@example.com"
  * use = #home


Instance: scen1PractitionerPatel
InstanceOf: Practitioner
Title:       "Practitioner - Dr. Rajesh Patel"
Description:  "Profile of Dr. Rajesh Patel."
Usage: #example
* identifier
  * system = "http://example.com/practitioner"
  * value = "P12345"
* active = true
* name
  * family = "Patel"
  * given = "Rajesh"
  * prefix = "Dr."
* telecom[0]
  * system = #phone
  * value = "+1(555) 555-4321"
  * use = #work
* telecom[+]
  * system = #email
  * value = "rajesh.patel@example.com"
  * use = #work
* address
  * line = "456 Health Avenue"
  * city = "Medicity"
  * state = "NY"
  * postalCode = "54321"
  * country = "USA"
* gender = #male
* birthDate = "1975-06-15"
* qualification
  * identifier
    * system = "http://example.com/qualification"
    * value = "Q98765"
  * code.text = "General Practitioner"
  * period.start = "2000-07-01"


Instance: scen1RolePatel
InstanceOf: PractitionerRole
Title:       "Practitioner Role - Dr. Rajesh Patel at Good Health Clinic"
Description:  "Dr. Rajesh Patel's role as a General Practitioner at Good Health Clinic"
Usage: #example
* identifier
  * system = "http://example.com/practitioner-role"
  * value = "PR45678"
* active = true
* practitioner = Reference(Practitioner/scen1PractitionerPatel) "Dr. Rajesh Patel"
* organization = Reference(Organization/scen1OrgGoodhealth) "Good Health Clinic"
* code = $practitioner-role#doctor "Doctor"
  * text = "Doctor"
* specialty = $sct#394814009 "General practice (specialty)"
  * text = "General Practitioner"