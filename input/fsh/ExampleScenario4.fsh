Instance: Scen4PhysicalActivityPlan
InstanceOf: ExampleScenario
Title:       "Scenario 4 - Patient Works with Personal Trainer"
Description: "This scenario outlines a patient-provider interaction for managing a physical activity plan. It involves creating and updating care plans and goals, posting patient activity observations, and asking patient to fill surveys. This adaptive care approach allows providers to modify plans and set new goals based on the patient's progress."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "PatientWorksWithPersonalTrainer"
* insert ActorEntity(patient-app,  "Patient Application",  [[A phone or web-based app used by Ms. Scarborough to track her physical activity]])
* insert ActorEntity(provider-app, "Provider Application", [[A phone or web-based app used by Ms. Rocha to manage her clients' data]])
* insert Instance_Empty(Scen4query1,   Binary,   "Query for patient physical activity care plans",       [[Query for CarePlans for a patient: `GET https://ufit.example.org/fhir/CarePlan?patient=Patient/Scen4PatientScarborough&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen4query2,   Binary,   "Query for patient physical activity goals",            [[Query for Goals for a patient: `GET https://ufit.example.org/fhir/Goal?patient=Patient/Scen4PatientScarborough&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen4query3,   Binary,   "Query for patient uncomplete tasks",                   [[Query for uncomplete patient Tasks for a patient: `GET https://ufit.example.org/fhir/Task?owner=Patient/Scen4PatientScarborough&status=active,on-hold`]])
* insert Instance_Empty(Scen4CarePlan, CarePlan, "Patient physical activity care plan",                  [[CarePlan describing proposed exercise regime]])
* insert InstanceVersion(1, "Initial CarePlan", Scen4CarePlanV1, [[Planning for weight lifting, 30 minutes/day]])
* insert InstanceVersion(2, "Updated CarePlan", Scen4CarePlanV2, [[Planning for weight lifting, 15 + 30 minutes/day]])
* insert Instance_Empty(Scen4Goal1,             Goal,     "Physical Activity weekly target",             [[Goal indicating target number of minutes/day and days/week weight-lifting]])
* insert InstanceVersion(1, "Initial goal",      Scen4Goal1V1,           [[Initial value of 30 mins/day]])
* insert InstanceVersion(2, "Initial goal",      Scen4Goal1V2,           [[30 mins/day-completed]])
* insert Instance_Empty(Scen4Goal2,             Goal,    "Physical Activity weekly target",              [[Increased goal indicating target number of minutes/day and days/week weight-lifting]])
* insert InstanceVersion(1, "Initial goal",      Scen4Goal2V1,           [[Initial value of 45 mins/day]])
* insert InstanceVersion(2, "Initial goal",      Scen4Goal2V2,           [[Sustaining 45 mins/day]])
* insert Instance_Content(Scen4CarePlanBundle1,               Bundle,         "Search-set of Care Plans",                 [[Initial search results on Care plan for the patient]])
* insert InstanceContains(Scen4CarePlan, 1)
* insert Instance_Content(Scen4CarePlanBundle2,               Bundle,         "Search-set of Care Plans#2",               [[New search results on Care plan for the patient]])
* insert InstanceContains(Scen4CarePlan, 2)
* insert Instance_Content(Scen4GoalBundle1,                   Bundle,         "Search-set of Goals",                      [[Initial search results on Goal for the patient]])
* insert InstanceContains(Scen4Goal1, 1)
* insert Instance_Content(Scen4GoalBundle2,                   Bundle,         "Search-set of Goals",                      [[Initial search results on Goal for the patient]])
* insert InstanceContains(Scen4Goal1, 2)
* insert InstanceContains(Scen4Goal2, 1)
* insert Instance_Content(Scen4TaskBundle1,                   Bundle,         "Search-set of active patient Tasks#1",     [[Initial search results of uncomplete patient Tasks.  (Triggered by notification from trainer's app.)]])
* insert InstanceContains(Scen4TaskFillSurvey, 1)
* insert Instance_Content(Scen4TaskBundle2,                   Bundle,         "Search-set of active patient Tasks#2",     [[Second search results of uncomplete patient Tasks.  (Triggered by notification from trainer's app.)]])
* insert InstanceContains(Scen4TaskReviewVideo, 1)
* insert Instance_Content(Scen4TaskBundle3,                   Bundle,         "Search-set of active patient Tasks#3",     [[Third search results of uncomplete patient Tasks.  (Triggered by notification from trainer's app.)]])
* insert InstanceContains(Scen4TaskFillSurvey2, 1)
* insert Instance_Content(Scen4ObservationActivityType,       Observation,    "Example physical activity type record",    [[A sample record indicating the type of physical activity performed by the patient]])
* insert Instance_Content(Scen4ObservationEVSMinutesPerDay,   Observation,    "Initial minutes/day of cardio",            [[A sample record of the minutes per day of cardio done by the patient]])
* insert Instance_Content(Scen4ObservationPeakDailyHeartRate, Observation,    "Example peak daily heart rate",            [[A sample record of daily calories captured by the patient]])
* insert Instance_Content(Scen4ObservationEVSMinutesPerDay2,  Observation,    "Updated minutes/day of cardio",            [[A second sample record of the minutes per day of cardio done by the patient]])
* insert Instance_Content(Scen4ObservationDailySteps,         Observation,    "Example daily step count",                 [[A sample record of daily steps captured by the patient]])
* insert Instance_Content(Scen4ObservationCaloriesPerDay,     Observation,    "Example daily calories",                   [[A sample record of daily calories captured by the patient]])
* insert Instance_Content(Scen4ObservationEVSMinutesPerDay3,  Observation,    "Final minutes/day of cardio",              [[A third sample record of the minutes per day of cardio done by the patient]])
* insert Instance_Empty(Scen4TaskFillSurvey,    Task,   "Request for patient to fill out survey",        [[Patient Task requesting patient to fill out a satisfaction survey]])
* insert InstanceVersion(1, "Initial request",   Scen4TaskFillSurveyV1,  [[Initial request to fill out survey]])
* insert InstanceVersion(2, "Completed request", Scen4TaskFillSurveyV2,  [[Survey has been filled out and response has been attached to Task]])
* insert Instance_Empty(Scen4TaskFillSurvey2,   Task,   "Second request for patient to fill out survey", [[New patient Task requesting patient to fill out a satisfaction survey]])
* insert InstanceVersion(1, "Initial request",   Scen4TaskFillSurvey2V1, [[Initial request to fill out survey]])
* insert InstanceVersion(2, "Completed request", Scen4TaskFillSurvey2V2, [[Survey has been filled out and response has been attached to Task]])
* insert Instance_Empty(Scen4TaskReviewVideo,   Task,   "Request for patient to view video",             [[New patient Task requesting patient to fill out a satisfaction survey]])
* insert InstanceVersion(1, "Initial request",   Scen4TaskReviewVideoV1, [[Initial request to view a video]])
* insert InstanceVersion(2, "Completed request", Scen4TaskReviewVideoV2, [[Updated request indicating video has been viewed]])
* process[+]
  * title = "Physical Activity Plan Establishment and Observations"
  * preConditions = "CarePlan and initial Goal are created, Patient and Provider apps are operational"
  * postConditions = "CarePlan and Goal successfully retrieved"
  * insert ProcessSearch(1,  "Query CarePlan",            patient-app, provider-app, Scen4query1, Scen4CarePlanBundle1,    [[Patient app queries exercise CarePlan describing proposed exercise regime.]])
  * insert ProcessSearch(2,  "Query Goals",               patient-app, provider-app, Scen4query2, Scen4GoalBundle1,        [[Patient app queries Goals.]])
* process[+]
  * title = "Post Observations, CarePlan adjustment and new Goals"
  * preConditions = "Initial care plan and goal retrieved"
  * postConditions = "Care plan followed, various observations are posted by the patient and initial goal accomplished (along with filling survey). Care plan is adjusted, new goal is set, and observations are posted"
  * insert ProcessCreate(3,  "Post activity type",         patient-app, provider-app, Scen4ObservationActivityType, ,       [[Patient app posts an observation indicating type of physical activity. `POST https://ufit.example.org/fhir/Observation`]])
  * insert ProcessCreate(4,  "Post min/day",               patient-app, provider-app, Scen4ObservationEVSMinutesPerDay, ,   [[Patient app posts an observation indicating number of minutes/day of moderate to vigorous physical activity. `POST https://ufit.example.org/fhir/Observation`]])
    * step[=].pause = true
  * insert ProcessCreate(5,  "Post peak daily heart rate", patient-app, provider-app, Scen4ObservationPeakDailyHeartRate, , [[Patient app posts an observation indicating their peak daily heart rate. `POST https://ufit.example.org/fhir/Observation`]])
  * insert ProcessCreate(6,  "Post min/day #2",            patient-app, provider-app, Scen4ObservationEVSMinutesPerDay2, ,  [[Patient app posts another observation indicating number of minutes/day of moderate to vigorous physical activity. `POST https://ufit.example.org/fhir/Observation`]])
    * step[=].pause = true
  * insert ProcessCreate(7,  "Post daily steps",           patient-app, provider-app, Scen4ObservationDailySteps, ,         [[Patient app posts an observation indicating their peak daily heart rate. `POST https://ufit.example.org/fhir/Observation`]])
  * insert ProcessCreate(8,  "Post peak daily calories",   patient-app, provider-app, Scen4ObservationCaloriesPerDay, ,     [[Patient app posts an observation indicating their peak daily heart rate. `POST https://ufit.example.org/fhir/Observation`]])
    * step[=].pause = true
  * insert ProcessUpdate(9,  "Update goal",                patient-app, provider-app, Scen4Goal1, 2,                        [[Patient updates their initial goal to indicate it's achieved. `PUT https://ufit.example.org/fhir/Observation/Scen4Goal1`]])
    * step[=].pause = true
  * insert ProcessSearch(10, "Retrieve patient tasks#1",   patient-app, provider-app, Scen4query3, Scen4TaskBundle1,        [[Based on an SMS prompt from an 'internal' subscription, the patient app checks for new tasks assigned by their trainer and receives request to fill out a survey.]])
    * step[=].pause = true
  * insert ProcessUpdate(11, "Update task#1",              patient-app, provider-app, Scen4TaskFillSurvey, 2,               [[Patient updates the task with the completed survey. `PUT https://ufit.example.org/fhir/Task/Scen4TaskFillSurvey`]])
    * step[=].pause = true
  * insert ProcessSearch(12, "Retrieve patient tasks#2",   patient-app, provider-app, Scen4query3, Scen4TaskBundle2,        [[Based on an SMS prompt from an 'internal' subscription, the patient app checks for new tasks assigned by their trainer and receives request to reivew a video.]])
    * step[=].pause = true
  * insert ProcessUpdate(13, "Update task#2",              patient-app, provider-app, Scen4TaskReviewVideo, 2,              [[Patient updates the task indicating they've watched the video. `PUT https://ufit.example.org/fhir/Task/Scen4TaskReviewVideo`]])
    * step[=].pause = true
  * insert ProcessSearch(14, "Query CarePlan#2",           patient-app, provider-app, Scen4query1, Scen4CarePlanBundle2,    [[After a phone call, patient uses app to retrieve updated CarePlan describing revised exercise regime.]])
  * insert ProcessSearch(15, "Query Goals#2",              patient-app, provider-app, Scen4query2, Scen4GoalBundle2,        [[After a phone call, patient uses app to retrieve updated Goals.]])
    * step[=].pause = true
  * insert ProcessCreate(16, "Post min/day #3",            patient-app, provider-app, Scen4ObservationEVSMinutesPerDay3, ,  [[Patient app posts a third observation indicating number of minutes/day of moderate to vigorous physical activity. `POST https://ufit.example.org/fhir/Observation`]])
    * step[=].pause = true
  * insert ProcessUpdate(17,  "Update goal",               patient-app, provider-app, Scen4Goal2, 2,                        [[Patient updates their second goal to indicate it's achieved, but they want to stay where they are. `PUT https://ufit.example.org/fhir/Observation/Scen4Goal2`]])
    * step[=].pause = true
  * insert ProcessSearch(18, "Retrieve patient tasks#3",   patient-app, provider-app, Scen4query3, Scen4TaskBundle3,        [[Based on an SMS prompt from an 'internal' subscription, the patient app checks for new tasks assigned by their trainer and receives request to complete a second survey.]])
    * step[=].pause = true
  * insert ProcessUpdate(19, "Update task#3",              patient-app, provider-app, Scen4TaskFillSurvey2, 2,              [[Patient updates the task indicating it's complete with the new completed survey. `PUT https://ufit.example.org/fhir/Task/Scen4TaskFillSurvey2`]])


Instance: Scen4CarePlanV1
InstanceOf: PACarePlan
Title:       "CarePlan - initial version - Scenario 4"
Description:  "A care plan for physical activity for patient Scarborough."
Usage: #example
* insert CarePlan(2023-06-24, 2023-12-24, Scen4PatientScarborough, "Ms. Scarborough", Scen4Practitioner, "Ms. Rocha", [[Ms. Scarborough will use her home weights and alternate between lower-body and upper-body on week-days each morning for 30 minutes after waking.]])
* goal[+] = Reference(Scen4Goal1V1)

Instance: Scen4CarePlanV2
InstanceOf: PACarePlan
Title:       "CarePlan - updated version - Scenario 4"
Description:  "An updated care plan for physical activity for patient Scarborough."
Usage: #example
* insert CarePlan(2023-06-24, 2024-03-30, Scen4PatientScarborough, "Ms. Scarborough", Scen4Practitioner, "Ms. Rocha", [[Ms. Scarborough will use her home weights and alternate between lower-body and upper-body on week-days each morning for 15 minutes after waking and 30 minutes before dinner.]])
* goal[+] = Reference(Scen4Goal1V2)
* goal[+] = Reference(Scen4Goal2V1)


Instance: Scen4CarePlanBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - CarePlan - Initial care plan - Scenario 4"
Description:  "Results of a search of all active or on-hold physical-activity related care plans for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/CarePlan?patient=Patient/Scen4PatientScarborough&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen4CarePlanV1)

Instance: Scen4CarePlanBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - CarePlan - Updated care plan - Scenario 4"
Description:  "Results of a second search of all active or on-hold physical-activity related care plans for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/CarePlan?patient=Patient/Scen4PatientScarborough&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen4CarePlanV2)

Instance: Scen4Goal1V1
InstanceOf: PAGoal
Title:       "Goal - Lifting 'active' - Scenario 4"
Description:  "A goal to lift for 30 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* insert Goal(Scen4PatientScarborough, "Jessica Scarborough", in-progress, [[Lifting 30 minutes a day, 5 days a week.]])

Instance: Scen4Goal1V2
InstanceOf: PAGoal
Title:       "Goal - Lifting 'achieved' - Scenario 4"
Description:  "An achieved goal of lifting for 30 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* insert Goal(Scen4PatientScarborough, "Jessica Scarborough", achieved, [[Lifting 30 minutes a day, 5 days a week.]])

Instance: Scen4Goal2V1
InstanceOf: PAGoal
Title:       "Goal - Lifting2 'active' - Scenario 4"
Description:  "A goal to lift for 45 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* insert Goal(Scen4PatientScarborough, "Jessica Scarborough", in-progress, [[Lifting 45 minutes a day, 5 days a week.]])

Instance: Scen4Goal2V2
InstanceOf: PAGoal
Title:       "Goal - Lifting2 'sustaining' - Scenario 4"
Description:  "A sustaining goal of lifting for 45 minutes a day, 5 days a week, for patient Scarborough."
Usage: #example
* insert Goal(Scen4PatientScarborough, "Jessica Scarborough", sustaining, [[Lifting 45 minutes a day, 5 days a week.]])

Instance: Scen4GoalBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Goal - Initial goal(s) - Scenario 4"
Description:  "Results of a search of all active, on-hold and completed physical-activity related goals for the patient."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/Goal?patient=Patient/Scen4PatientScarborough&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(Goal, Scen4Goal1V1)

Instance: Scen4GoalBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Goal - Updated goal(s) - Scenario 4"
Description:  "Results of a second search of all active, on-hold and completed physical-activity related goals for the patient."
Usage: #example
* insert SearchBundle(2, [[https://ufit.example.org/fhir/Goal?patient=Patient/Scen4PatientScarborough&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(Goal, Scen4Goal1V2)
* insert EntryMatch(Goal, Scen4Goal2V1)

Instance: Scen4ObservationActivityType
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Activity Type - Scenario 4"
Description:  "Observation of the exercise activity performed by patient Scarborough."
Usage: #example
* insert ActivityType(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-07-15T12:00:00-07:00, LA11839-0, "Weights")

Instance: Scen4ObservationEVSMinutesPerDay
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Observation - Minutes/Day - Scenario 4"
Description:  "An observation of the number of minutes per day engaged in EVS activity by patient Scarborough."
Usage: #example
* insert MinPerDay(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-07-15T12:00:00-07:00, 20)

Instance: Scen4ObservationPeakDailyHeartRate
InstanceOf: PAObservationTimeMeasure
Title:       "Observation - Peak Daily Heart Rate - Scenario 4"
Description:  "An observation of the peak daily heart rate of patient Scarborough."
Usage: #example
* insert PeakHeartRate(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-08-03T12:00:00-07:00, 179)

Instance: Scen4ObservationEVSMinutesPerDay2
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Observation - Minutes/Day#2 - Scenario 4"
Description:  "An observation of the number of minutes per day engaged in physical activity."
Usage: #example
* insert MinPerDay(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-08-03T12:00:00-07:00, 30)

Instance: Scen4ObservationDailySteps
InstanceOf: PAObservationTimeMeasure
Title:       "Observation - Daily Steps - Scenario 4"
Description:  "An observation of the number of steps taken per day by patient Scarborough."
Usage: #example
* insert DailySteps(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-09-11T12:00:00-07:00, 3000)

Instance: Scen4ObservationCaloriesPerDay
InstanceOf: PAObservationTimeMeasure
Title:       "Observation - Calories/Day - Scenario 4"
Description:  "An observation of the number of calories burned per day by patient Scarborough."
Usage: #example
* insert DailyCalories(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-09-11T12:00:00-07:00, 629)

Instance: Scen4ObservationEVSMinutesPerDay3
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Observation - Minutes/Day#3 - Scenario 4"
Description:  "An observation of the number of minutes per day engaged in physical activity."
Usage: #example
* insert MinPerDay(Scen4PatientScarborough, "Jessica Scarborough", Scen4PatientScarborough, "Jessica Scarborough", 2023-11-30T11:00:00-07:00, 45)

Instance: Scen4TaskFillSurveyV1
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - fill Questionnaire#1 'requested' - Scenario 4"
Description:  "A task to fill out a survey indicating satisfaction with the physical activity plan for patient Scarborough."
Usage: #example
* insert QuestionnaireTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2023-10-14T09:00:00-07:00, requested, https://example.org/fhir/Questionnaire/satisfaction|2.1, [[Fill out a survey indicating satisfaction with plan]])

Instance: Scen4TaskFillSurveyV2
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - fill Questionnaire#1 'completed' - Scenario 4"
Description:  "A completed task of filling out a survey indicating discomfort with shoulder."
Usage: #example
* insert QuestionnaireTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2023-10-14T09:00:00-07:00, completed, https://example.org/fhir/Questionnaire/satisfaction|2.1, [[Fill out a survey indicating satisfaction with plan]])
* output[QuestionnaireResponse].valueReference = Reference(Scen4QuestionnaireResponse)

Instance: Scen4TaskReviewVideoV1
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - view video 'requested' - Scenario 4"
Description:  "A task for patient Scarborough to review an exercise video."
Usage: #example
* insert ReviewTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2023-10-17T09:00:00-07:00, requested, Scen4Video, [[Please review this arm-curl video.  Pay particular attention to the 3:00 - 3:35 portion.  If you adjust your technique accordingly, it may help with your shoulder pain.]])
* contained[+] = Scen4Video

Instance: Scen4Video
InstanceOf: DocumentReference
Title:       "DocumentReference - Video to watch - Scenario 4"
Description:  "A video the patient is asked to view."
Usage: #inline
* insert DocRefVideo(http://example.org/videos/123.mpg)

Instance: Scen4TaskReviewVideoV2
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - view video 'completed' - Scenario 4"
Description:  "A completed task of patient Scarborough reviewing an exercise video."
Usage: #example
* insert ReviewTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2023-10-17T09:00:00-07:00, completed, Scen4Video, [[Please review this arm-curl video.  Pay particular attention to the 3:00 - 3:35 portion.  If you adjust your technique accordingly, it may help with your shoulder pain.]])
* contained[+] = Scen4Video
* output[GeneralInformationResponse].valueMarkdown = "Ok, that makes sense.  Thanks."

Instance: Scen4TaskFillSurvey2V1
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - fill Questionnaire#2 'requested' - Scenario 4"
Description:  "A task to fill out a survey indicating satisfaction with the updated physical activity plan."
Usage: #example
* insert QuestionnaireTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2024-02-20T09:00:00-07:00, requested, https://example.org/fhir/Questionnaire/satisfaction|2.1, [[Fill out a survey indicating satisfaction with plan]])

Instance: Scen4TaskFillSurvey2V2
InstanceOf: SDOHCCTaskForPatient
Title:       "Task - fill Questionnaire#2 'completed' - Scenario 4"
Description:  "A completed task of filling out a survey indicating satisfaction with the updated physical activity plan."
Usage: #example
* insert QuestionnaireTask(Scen4PatientScarborough, "Jessica Scarborough", Scen4Role, "Ms. Rocha", routine, 2024-02-20T09:00:00-07:00, completed, https://example.org/fhir/Questionnaire/satisfaction|2.1, [[Fill out a survey indicating satisfaction with plan]])
* output[QuestionnaireResponse].valueReference = Reference(Scen4QuestionnaireResponse2)

Instance: Scen4TaskBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Task - Initial task(s) - Scenario 4"
Description:  "Results of a search of all active and on-hold tasks assigned to the patient."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/Task?owner=Patient/Scen4PatientScarborough&status=active,on-hold]])
* insert EntryMatch(Task, Scen4TaskFillSurveyV1)

Instance: Scen4TaskBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Task - Second task(s) - Scenario 4"
Description:  "Results of a second search of all active and on-hold tasks assigned to the patient."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/Task?owner=Patient/Scen4PatientScarborough&status=active,on-hold]])
* insert EntryMatch(Task, Scen4TaskReviewVideoV1)

Instance: Scen4TaskBundle3
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Task - Third task(s) - Scenario 4"
Description:  "Results of a third search of all active and on-hold tasks assigned to the patient."
Usage: #example
* insert SearchBundle(1, [[https://ufit.example.org/fhir/Task?owner=Patient/Scen4PatientScarborough&status=active,on-hold]])
* insert EntryMatch(Task, Scen4TaskFillSurvey2V1)

Instance: Scen4Questionnaire
InstanceOf: SDCBaseQuestionnaire
Title:       "Questionnaire - Exercise Satisfaction - Scenario 4"
Description:  "A questionnaire to assess the patient's satisfaction with the exercise plan, including questions about satisfaction and discomfort.."
Usage: #example
* insert Questionnaire(https://example.org/fhir/Questionnaire/satisfaction, 2.1)
* insert Question(1, boolean, [[Are you satisfied with your current exercise plan?]])
* insert Question(2, boolean, [[Did you experience any discomfort with an exercise?]])
* insert Question(3, string,  [[If yes, which exercise?]])

Instance: Scen4QuestionnaireResponse
InstanceOf: SDCQuestionnaireResponse
Title:       "QuestionnaireResponse - Exercise Satisfaction - Scenario 4"
Description:  "A completed questionnaire response indicating the patient's satisfaction with the exercise plan, mentioning experiencing discomfort during shoulder exercises."
Usage: #example
* insert QuestionnaireResponse(Scen4PatientScarborough, "Ms. Scarborough", 2023-10-16, https://example.org/fhir/Questionnaire/satisfaction|2.1)
* basedOn = Reference(Scen4CarePlanV1)
* insert BooleanAnswer(1, true,                [[Are you satisfied with your current exercise plan?]])
* insert BooleanAnswer(2, true,                [[Did you experience any discomfort with an exercise?]])
* insert StringAnswer( 3, "Shoulder exercise", [[If yes, which exercise?]])

Instance: Scen4QuestionnaireResponse2
InstanceOf: SDCQuestionnaireResponse
Title:       "QuestionnaireResponse - Exercise Satisfaction2 - Scenario 4"
Description:  "A completed questionnaire response indicating the patient's satisfaction with the exercise plan, mentioning no discomfort during exercises."
Usage: #example
* insert QuestionnaireResponse(Scen4PatientScarborough, "Ms. Scarborough", 2024-02-21, https://example.org/fhir/Questionnaire/satisfaction|2.1)
* basedOn = Reference(Scen4CarePlanV2)
* insert BooleanAnswer(1, true,                [[Are you satisfied with your current exercise plan?]])
* insert BooleanAnswer(2, true,                [[Did you experience any discomfort with an exercise?]])

Instance: Scen4PatientScarborough
InstanceOf: USCorePatientProfile
Title:       "Patient - Ms. Scarborough - Scenario 4"
Description:  "Patient information for Jessica Scarborough."
Usage: #example
* identifier
  * system = "http://ufit.example.com/fhir/NamingSystem/client-id"
  * value = "1111111"
* name
  * family = "Scarborough"
  * given = "Jessica"
* gender = #female
* birthDate = "1991-05-17"

Instance: Scen4Practitioner
InstanceOf: USCorePractitionerProfile
Title:       "Practitioner - Ms. Rocha - Scenario 4"
Description:  "Practitioner information for Kim Rocha, a healthcare professional involved in patient care."
Usage: #example
* identifier[NPI].value.extension[$dar].valueCode = #not-applicable
* name
  * family = "Rocha"
  * given = "Kim"

Instance: Scen4Role
InstanceOf: USCorePractitionerRoleProfile
Title:       "PractitionerRole - Ms. Rocha - Scenario 4"
Description:  "Practitioner information for Kim Rocha - no assigned organization."
Usage: #example
* practitioner = Reference(Scen4Practitioner)
* organization
  * extension[$dar].valueCode = #not-applicable
  * display = "Independent Practitioner"