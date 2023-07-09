Alias: $physical-activity-category = http://hl7.org/fhir/us/physical-activity/CodeSystem/physical-activity-category
Alias: $careplan-category = http://hl7.org/fhir/us/core/CodeSystem/careplan-category
Alias: $loinc = http://loinc.org
Alias: $goal-achievement = http://terminology.hl7.org/CodeSystem/goal-achievement
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $pa-temporary-codes = http://hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes
Alias: $task-outputtype = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes

Instance: scen4PhysicalActivityPlan
InstanceOf: ExampleScenario
Title:       "Scenario 4 - Patient Works with Personal Trainer"
Description: "This scenario outlines a patient-provider interaction for managing a physical activity plan. It involves creating and updating care plans and goals, posting patient activity observations, and asking patient to fill surveys. This adaptive care approach allows providers to modify plans and set new goals based on the patient's progress."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "PatientWorkswithPersonalTrainer"
* actor[0]
  * actorId = "patient-app"
  * type = #entity
  * name = "Patient App"
* actor[+]
  * actorId = "provider-app"
  * type = #entity
  * name = "Provider App"
* instance[0]
  * resourceId = "scen4Careplan"
  * resourceType = #CarePlan
  * version[0]
    * versionId = "1"
    * description = "Initial care plan"
  * version[+]
    * versionId = "2"
    * description = "Updated care plan with adjusted exercises after physio consultation"
* instance[+]
  * resourceId = "scen4Goal1"
  * resourceType = #Goal
  * version[0]
    * versionId = "1"
    * description = "Initial goal"
  * version[+]
    * versionId = "2"
    * description = "Completed goal"
* instance[+]
  * resourceId = "scen4Goal2"
  * resourceType = #Goal
  * version
    * versionId = "1"
    * description = "Initial goal for next month"
  * version
    * versionId = "2"
    * description = "Completed goal"
* instance[+]
  * resourceId = "scen4ObservationActivityType"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationEVSMinutesPerDay"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationPeakDailyHeartRate"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationEVSMinutesPerDay2"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationCaloriesPerDay"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationDailySteps"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4ObservationEVSMinutesPerDay3"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen4TaskSurvey"
  * resourceType = #Task
  * version[0]
    * versionId = "1"
    * description = "Initial task to fill out survey"
  * version[+]
    * versionId = "2"
    * description = "Patient completes survey, indicates discomfort"
* instance[+]
  * resourceId = "scen4TaskSurvey2"
  * resourceType = #Task
  * version[0]
    * versionId = "1"
    * description = "Initial task to fill out survey"
  * version[+]
    * versionId = "2"
    * description = "Patient completes survey"
* instance[+]
  * resourceId = "scen4TaskReviewVideo"
  * resourceType = #Task
  * version[0]
    * versionId = "1"
    * description = "Task to review exercise video"
  * version[+]
    * versionId = "2"
    * description = "Patient indicates task as done"
* process[0]
  * title = "Physical Activity Plan Establishment and Observations"
  * preConditions = "CarePlan and initial Goal are created, Patient and Provider apps are operational"
  * postConditions = "CarePlan and Goal successfully retrieved"
  * step[0].operation
    * number = "1"
    * type = "search-type"
    * description = "Patient App to Provider App - Search for CarePlan. Request: GET /CarePlan?patient=scen4PatientScarborough&category=PhysicalActivity"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "sc4textFile1"
    * response
      * resourceId = "scen4Careplan"
      * versionId = "1"
  * step[+].operation
    * number = "2"
    * type = "search-type"
    * description = "Patient App to Provider App - Search for Goal. Request: GET /Goal?patient=scen4PatientScarborough"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "sc4textFile2"
    * response
      * resourceId = "scen4Goal1"
      * versionId = "1"
* process[+]
  * title = "Post Observations, CarePlan adjustment and new Goals"
  * preConditions = "Initial care plan and goal retrieved"
  * postConditions = "Care plan followed, various observations are posted by the patient and initial goal accomplished (along with filling survey). Care plan is adjusted, new goal is set, and observations are posted"
  * step[0]
    * pause = true
    * operation
      * number = "3"
      * type = "create"
      * description = "Patient App to Provider App - Create Activity Type Observation. Request: POST /Observation"
      * initiator = "patient-app"
      * receiver = "provider-app"
      * request.resourceId = "scen4ObservationActivityType"
      * response
        * resourceId = "scen4ObservationActivityType"
        * versionId = "1"
  * step[+].operation
    * number = "4"
    * type = "create"
    * description = "Patient App to Provider App - Create MinutesPerDay Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "scen4ObservationEVSMinutesPerDay"
    * response
      * resourceId = "scen4ObservationEVSMinutesPerDay"
      * versionId = "1"
  * step[+].operation
    * number = "5"
    * type = "create"
    * description = "Patient App to Provider App - Create HeartRate Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "scen4ObservationPeakDailyHeartRate"
    * response
      * resourceId = "scen4ObservationPeakDailyHeartRate"
      * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "6"
      * type = "create"
      * description = "Patient App to Provider App - Create MinutesPerDay Observation. Request: POST /Observation"
      * initiator = "patient-app"
      * receiver = "provider-app"
      * request.resourceId = "scen4ObservationEVSMinutesPerDay2"
      * response
        * resourceId = "scen4ObservationEVSMinutesPerDay2"
        * versionId = "1"
  * step[+].operation
    * number = "7"
    * type = "create"
    * description = "Patient App to Provider App - Create DailyStep Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "scen4ObservationDailySteps"
    * response
      * resourceId = "scen4ObservationDailySteps"
      * versionId = "1"
  * step[+].operation
    * number = "8"
    * type = "create"
    * description = "Patient App to Provider App - Create CaloriesPerDay Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "scen4ObservationCaloriesPerDay"
    * response
      * resourceId = "scen4ObservationCaloriesPerDay"
      * versionId = "1"
  * step[+].operation
    * number = "9"
    * type = "update"
    * description = "Patient App to Provider App - Goal updated to mark status as complete. Request: PUT /Goal/scen4Goal1"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request
      * resourceId = "scen4Goal1"
      * versionId = "1"
    * response
      * resourceId = "scen4Goal1V2"
      * versionId = "2"
  * step[+].operation
    * number = "10"
    * type = "create"
    * description = "Provider App to Patient App - Task to fill survey. Request: POST /Task"
    * initiator = "provider-app"
    * receiver = "patient-app"
    * request.resourceId = "scen4TaskFillSurvey"
    * response
      * resourceId = "scen4TaskFillSurvey"
      * versionId = "1"
  * step[+].operation
    * number = "11"
    * type = "update"
    * description = "Patient App to Provider App - filled survey. Request: PUT /Task/scen4TaskFillSurvey"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request
      * resourceId = "scen4TaskFillSurvey"
      * versionId = "1"
    * response
      * resourceId = "scen4TaskFillSurveyV2"
      * versionId = "2"
  * step[+].operation
    * number = "12"
    * type = "create"
    * description = "Provider App to Patient App - Task to review exercise video. Request: POST /Task"
    * initiator = "provider-app"
    * receiver = "patient-app"
    * request.resourceId = "scen4TaskReviewVideo"
    * response
      * resourceId = "scen4TaskReviewVideo"
      * versionId = "1"
  * step[+].operation
    * number = "13"
    * type = "update"
    * description = "Patient App to Provider App - reviewed exercise video. Request: PUT /Task/scen4TaskReviewVideo"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request
      * resourceId = "scen4TaskReviewVideo"
      * versionId = "1"
    * response
      * resourceId = "scen4TaskReviewVideoV2"
      * versionId = "2"
  * step[+]
    * pause = true
    * operation
      * number = "14"
      * type = "update"
      * description = "Update careplan (made some adjustments to plan after a phone consult with physiotherapist). Request: PUT /CarePlan/scen4Careplan"
      * initiator = "provider-app"
      * receiver = "patient-app"
      * request
        * resourceId = "scen4Careplan"
        * versionId = "1"
      * response
        * resourceId = "scen4Careplan"
        * versionId = "2"
  * step[+].operation
    * number = "15"
    * type = "create"
    * description = "Provider App to Patient App - Create new goal for next month. Request: POST /Goal"
    * initiator = "provider-app"
    * receiver = "patient-app"
    * request.resourceId = "scen4Goal2"
    * response
      * resourceId = "scen4Goal2"
      * versionId = "1"
  * step[+].operation
    * number = "16"
    * type = "search-type"
    * description = "Patient App to Provider App - Search Careplan. Request: GET /CarePlan?patient=scen4PatientScarborough&category=PhysicalActivity"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "sc4textFile1"
    * response
      * resourceId = "scen4Careplan"
      * versionId = "2"
  * step[+].operation
    * number = "17"
    * type = "search-type"
    * description = "Patient App to Provider App - Search Goal. Request: GET /Goal?patient=scen4PatientScarborough"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request.resourceId = "sc4textFile2"
    * response
      * resourceId = "scen4Goal2"
      * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "18"
      * type = "create"
      * description = "Patient App to Provider App - Post Observation MinutesPerDay. Request: POST /Observation"
      * initiator = "patient-app"
      * receiver = "provider-app"
      * request.resourceId = "scen4ObservationEVSMinutesPerDay3"
      * response
        * resourceId = "scen4ObservationEVSMinutesPerDay3"
        * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "14"
      * type = "update"
      * description = "Update Goal - updated to mark status as complete. Request: PUT /Goal/scen4Goal2"
      * initiator = "patient-app"
      * receiver = "provider-app"
      * request
        * resourceId = "scen4Goal2"
        * versionId = "1"
      * response
        * resourceId = "scen4Goal2V2"
        * versionId = "2"
  * step[+].operation
    * number = "15"
    * type = "create"
    * description = "Provider App to Patient App - Task to fill survey. Request: POST /Task"
    * initiator = "provider-app"
    * receiver = "patient-app"
    * request.resourceId = "scen4TaskFillSurvey2"
    * response
      * resourceId = "scen4TaskFillSurvey2"
      * versionId = "1"
  * step[+].operation
    * number = "16"
    * type = "update"
    * description = "Patient App to Provider App - filled survey. Request: PUT /Task/scen4TaskFillSurvey2"
    * initiator = "patient-app"
    * receiver = "provider-app"
    * request
      * resourceId = "scen4TaskFillSurvey2"
      * versionId = "1"
    * response
      * resourceId = "scen4TaskFillSurvey2V2"
      * versionId = "2"


Instance: scen4Careplan
InstanceOf: CarePlan
Title:       "Physical Activity Care Plan"
Description:  "A care plan for physical activity for patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T11:00:00Z"
* status = #active
* intent = #plan
* category[0] = $pa-temporary-codes#PhysicalActivity "Physical Activity"
  * text = "Physical Activity"
* category[+] = $careplan-category#assess-plan
* subject = Reference(Patient/scen4PatientScarborough)
* period
  * start = "2023-05-15"
  * end = "2023-06-15"
* goal = Reference(Goal/scen4Goal1)
* activity.detail
  * status = #in-progress
  * code = $loinc#82229-6 "Lifting"
  * description = "Lifting 30 minutes a day, 5 days a week"
  * scheduledTiming.repeat
    * frequency = 5
    * period = 1
    * periodUnit = #wk


Instance: scen4CareplanV2
InstanceOf: CarePlan
Title:       "Updated Physical Activity Care Plan"
Description:  "An updated care plan for physical activity for patient Scarborough."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-06-16T11:00:00Z"
* status = #active
* intent = #plan
* category[0] = $pa-temporary-codes#PhysicalActivity "Physical Activity"
  * text = "Physical Activity"
* category[+] = $careplan-category#assess-plan
* subject = Reference(Patient/scen4PatientScarborough)
* period
  * start = "2023-06-16"
  * end = "2023-07-15"
* goal[0] = Reference(Goal/scen4Goal1V2) "completed"
* goal[+] = Reference(Goal/scen4Goal2) "in-progress"
* activity[0].detail
  * status = #in-progress
  * code = $loinc#LA33432-8 "Stretching Exercises (stretching out your muscles)"
  * description = "Stretching exercises for 20 minutes a day, 5 days a week to reduce shoulder discomfort"
  * scheduledTiming.repeat
    * frequency = 5
    * period = 1
    * periodUnit = #wk
* activity[+].detail
  * status = #in-progress
  * code = $loinc#82229-6 "Lifting"
  * description = "Lifting 45 minutes a day, 5 days a week"
  * scheduledTiming.repeat
    * frequency = 5
    * period = 1
    * periodUnit = #wk
* note.text = "CarePlan adjusted after phone consultation with physiotherapist. Stretching exercises are now recommended prior to lifting to address shoulder discomfort."


Instance: scen4Goal1
InstanceOf: Goal
Title:       "Goal: Lifting 30 minutes a day, 5 days a week"
Description:  "A goal to lift for 30 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-05-15T11:00:00Z"
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#in-progress
* description.text = "Lifting 30 minutes a day, 5 days a week"
* subject = Reference(Patient/scen4PatientScarborough)
* startDate = "2023-05-15"
* target
  * measure = $loinc#82229-6 "Lifting"
  * dueDate = "2023-06-15"

Instance: scen4Goal1V2
InstanceOf: Goal
Title:       "Completed Goal: Lifting 30 minutes a day, 5 days a week"
Description:  "A completed goal of lifting for 30 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-06-15T11:00:00Z"
* lifecycleStatus = #completed
* achievementStatus = $goal-achievement#achieved
* description.text = "Lifting 30 minutes a day, 5 days a week"
* subject = Reference(Patient/scen4PatientScarborough)
* startDate = "2023-05-15"
* statusDate = "2023-06-15"
* target
  * measure = $loinc#82229-6 "Lifting"
  * dueDate = "2023-06-15"

Instance: scen4Goal2
InstanceOf: Goal
Title:       "Goal: Lifting 45 minutes a day, 5 days a week"
Description:  "A goal to lift for 45 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-16T11:00:00Z"
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#in-progress
* description.text = "Lifting 45 minutes a day, 5 days a week"
* subject = Reference(Patient/scen4PatientScarborough)
* startDate = "2023-06-16"
* target
  * measure = $loinc#82229-6 "Lifting"
  * dueDate = "2023-07-15"

Instance: scen4Goal2V2
InstanceOf: Goal
Title:       "Completed Goal: Lifting 45 minutes a day, 5 days a week"
Description:  "A completed goal of lifting for 45 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-07-15T11:00:00Z"
* lifecycleStatus = #completed
* achievementStatus = $goal-achievement#achieved
* description.text = "Lifting 45 minutes a day, 5 days a week"
* subject = Reference(Patient/scen4PatientScarborough)
* startDate = "2023-06-16"
* statusDate = "2023-07-15"
* target
  * measure = $loinc#82229-6 "Lifting"
  * dueDate = "2023-07-15"

Instance: scen4ObservationActivityType
InstanceOf: Observation
Title:       "Exercise Activity Observation"
Description:  "Observation of the exercise activity performed by patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-05-20T12:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#73985-4 "Exercise Activity"
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2022-05-20T12:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueCodeableConcept = $loinc#82229-6 "Lifting"

Instance: scen4ObservationDailySteps
InstanceOf: Observation
Title:       "Daily Steps Observation"
Description:  "An observation of the number of steps taken per day by patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-15T11:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#41950-7 "Number of steps in 24 hour Measured"
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 3000 '{steps}' "steps"

Instance: scen4ObservationEVSMinutesPerDay
InstanceOf: Observation
Title:       "EVS Minutes per Day Observation"
Description:  "An observation of the number of minutes per day engaged in EVS activity by patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-05-20T12:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2022-05-20T12:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 20 'min/d' "minutes per day"

Instance: scen4ObservationPeakDailyHeartRate
InstanceOf: Observation
Title:       "Peak Daily Heart Rate Observation"
Description:  "An observation of the peak daily heart rate of patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-05-20T12:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#8873-2 "Heart rate 24 hour maximum"
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2022-05-20T12:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 140 '/min' "bpm"

Instance: scen4ObservationCaloriesPerDay
InstanceOf: Observation
Title:       "Calories per Day Observation"
Description:  "An observation of the number of calories burned per day by patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-15T11:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 500 'kcal' "kcal"

Instance: scen4ObservationEVSMinutesPerDay2
InstanceOf: Observation
Title:       "Second EVS Minutes per Day Observation"
Description:  "An observation of the number of minutes per day engaged in physical activity."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-15T11:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2023-06-15T11:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 30 'min/d' "minutes per day"

Instance: scen4ObservationEVSMinutesPerDay3
InstanceOf: Observation
Title:       "Third EVS Minutes per Day Observation"
Description:  "An observation of the number of minutes per day engaged in physical activity."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-07-15T11:00:00Z"
* status = #final
* category[0] = $observation-category#activity
* category[+] = $pa-temporary-codes#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen4PatientScarborough)
* effectiveDateTime = "2023-07-15T11:00:00Z"
* performer = Reference(Patient/scen4PatientScarborough)
* valueQuantity = 45 'min/d' "minutes per day"


Instance: scen4TaskFillSurvey
InstanceOf: Task
Title:       "Fill Survey Task"
Description:  "A task to fill out a survey indicating satisfaction with the physical activity plan for patient Scarborough."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-15T11:00:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* description = "Fill out a survey indicating satisfaction with plan"
* focus = Reference(CarePlan/scen4Careplan)
* for = Reference(Patient/scen4PatientScarborough)
* requester = Reference(Practitioner/scen4Practitioner)


Instance: scen4TaskFillSurveyV2
InstanceOf: Task
Title:       "Completed Fill Survey Task"
Description:  "A completed task of filling out a survey indicating discomfort with shoulder."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-06-15T11:10:00Z"
* status = #completed
* intent = #order
* code = $task-code#fulfill
* description = "Fill out a survey indicating satisfaction with plan"
* for = Reference(Patient/scen4PatientScarborough)
* authoredOn = "2023-06-15T13:00:00Z"
* requester = Reference(Practitioner/scen4Practitioner)
* output
  * type = $task-outputtype#resulting-activity
    * text = "Questionnaire Response"
  * valueReference = Reference(QuestionnaireResponse/scen4QuestionnaireResponse)

Instance: scen4TaskReviewVideo
InstanceOf: Task
Title:       "Review Exercise Video Task"
Description:  "A task for patient Scarborough to review an exercise video."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-06-15T11:15:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* description = "Review Exercise Video"
* for = Reference(Patient/scen4PatientScarborough)
* requester = Reference(Practitioner/scen4Practitioner)

Instance: scen4TaskReviewVideoV2
InstanceOf: Task
Title:       "Completed Review Exercise Video Task"
Description:  "A completed task of patient Scarborough reviewing an exercise video."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-06-15T11:16:00Z"
* status = #completed
* intent = #order
* code = $task-code#fulfill
* description = "Review Exercise Video"
* for = Reference(Patient/scen4PatientScarborough)
* requester = Reference(Practitioner/scen4Practitioner)
* output
  * type = $task-outputtype#resulting-activity
    * text = "Patient annotation"
  * valueAnnotation.text = "Reviewed the exercise video"

Instance: scen4TaskFillSurvey2
InstanceOf: Task
Title:       "Fill Second Survey Task"
Description:  "A task to fill out a survey indicating satisfaction with the updated physical activity plan."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2023-07-15T11:00:00Z"
* status = #requested
* intent = #order
* code = $task-code#fulfill
* description = "Fill out a survey indicating satisfaction with plan"
* focus = Reference(CarePlan/scen4Careplan)
* for = Reference(Patient/scen4PatientScarborough)
* requester = Reference(Practitioner/scen4Practitioner)

Instance: scen4TaskFillSurvey2V2
InstanceOf: Task
Title:       "Completed Second Survey Task"
Description:  "A completed task of filling out a survey indicating satisfaction with the updated physical activity plan."
Usage: #example
* meta
  * versionId = "2"
  * lastUpdated = "2023-07-15T11:10:00Z"
* status = #completed
* intent = #order
* code = $task-code#fulfill
* description = "Fill out a survey indicating satisfaction with plan"
* for = Reference(Patient/scen4PatientScarborough)
* authoredOn = "2023-06-15T13:00:00Z"
* requester = Reference(Practitioner/scen4Practitioner)
* output
  * type = $task-outputtype#resulting-activity
    * text = "Questionnaire Response"
  * valueReference = Reference(QuestionnaireResponse/scen4QuestionnaireResponse2)

Instance: scen4Questionnaire
InstanceOf: Questionnaire
Title:       "Exercise Satisfaction Questionnaire"
Description:  "A questionnaire to assess the patient's satisfaction with the exercise plan, including questions about satisfaction and discomfort.."
Usage: #example
* status = #active
* subjectType = #Patient
* item[0]
  * linkId = "1"
  * text = "Are you satisfied with your current exercise plan?"
  * type = #boolean
* item[+]
  * linkId = "2"
  * text = "Did you experience any discomfort with an exercise?"
  * type = #boolean
* item[+]
  * linkId = "3"
  * text = "If yes, which exercise?"
  * type = #string

Instance: scen4QuestionnaireResponse
InstanceOf: QuestionnaireResponse
Title:       "Exercise Satisfaction Questionnaire Response"
Description:  "A completed questionnaire response indicating the patient's satisfaction with the exercise plan, mentioning experiencing discomfort during shoulder exercises."
Usage: #example
* status = #completed
* questionnaire = "http://example.org/Questionnaire/scen4Questionnaire"
* subject = Reference(Patient/scen4PatientScarborough)
* basedOn = Reference(CarePlan/scen4Careplan)
* item[0]
  * linkId = "1"
  * answer.valueBoolean = true
* item[+]
  * linkId = "2"
  * answer.valueBoolean = true
* item[+]
  * linkId = "3"
  * answer.valueString = "Shoulder exercise"

Instance: scen4QuestionnaireResponse2
InstanceOf: QuestionnaireResponse
Title:       "Exercise Satisfaction Questionnaire Response"
Description:  "A completed questionnaire response indicating the patient's satisfaction with the exercise plan, mentioning no discomfort during exercises."
Usage: #example
* status = #completed
* questionnaire = "http://example.org/Questionnaire/scen4Questionnaire"
* subject = Reference(Patient/scen4PatientScarborough)
* basedOn = Reference(CarePlan/scen4Careplan)
* item[0]
  * linkId = "1"
  * answer.valueBoolean = true
* item[+]
  * linkId = "2"
  * answer.valueBoolean = false
* item[+]
  * linkId = "3"
  * answer.valueString = "None"

Instance: scen4PatientScarborough
InstanceOf: Patient
Title:       "Patient - Scarborough, Jessica"
Description:  "Patient information for Jessica Scarborough."
Usage: #example
* name
  * family = "Scarborough"
  * given = "Jessica"
* gender = #female
* birthDate = "1991-05-17"

Instance: scen4Practitioner
InstanceOf: Practitioner
Title:       "Practitioner - Rocha, Kim"
Description:  "Practitioner information for Kim Rocha, a healthcare professional involved in patient care."
Usage: #example
* name
  * family = "Rocha"
  * given = "Kim"