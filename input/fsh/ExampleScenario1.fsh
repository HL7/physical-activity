// TODO:
// 1. Make sure the queries are complete and correct
// 2. Make sure the queries are consistent in the Query definition and in the 'self' link
// 3. Make sure the URLs are correct for all POST and PUT operations (note that Subscription notifications go to the endpoint nominated in the Subscription, not the RESTful Subscription endpoint)
// 4. Make sure the patient and provider names, genders, ages, roles, etc. jive with what's in the scenarios.  (I fixed several places where they weren't, but I may have missed some)
// 5. Make sure we're declaring InstanceOf for the specific US Core, Physical Activity, Subscription Backport, etc. profile.  We shouldn't *ever* have an InstanceOf a plain resource
// 6. Look at the titles and descriptions for things and make sure they're a) right, and b) consistent within (and ideally across) scenarios
// 7. Show 'contained' instances in rendering, show name of 'payload' when linking
// 8. Make sure 'contained' instances are defined

Instance: Scen1ExercisePrescriptionScenario
InstanceOf: ExampleScenario
Title:       "Scenario 1 - Exercise Prescription"
Description: "ExampleScenario instance illustrating how a patient app interacts with an EHR to manage and update an exercise plan. It covers the querying of resources such as CarePlan, Goal, and ServiceRequest, posting of Observations regarding physical activity levels, and how these resources are updated over time."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "ExercisePrescription"
* insert ActorEntity(patientApp, "Patient App", [[A patient app used to query resources related to the exercise plan]])
* insert ActorEntity(goodHealth,        "EHR",         [[EHR that records patient's exercise plan]])
* insert Instance_Empty(Scen1query1,   Binary,   "Query for patient physical activity care plans",         [[Query for CarePlans for a patient: `GET https://goodhealth.example.org/fhir/CarePlan?patient=Patient/Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1query2,   Binary,   "Query for patient physical activity goals",              [[Query for Goals for a patient: `GET https://goodhealth.example.org/fhir/Goal?patient=Patient/Scen1PatientKhatun&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1query3,   Binary,   "Query for patient exercise prescriptions and referrals", [[Query for ServiceRequests for a patient: `GET https://goodhealth.example.org/fhir/ServiceRequest?patient=Patient/Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1CarePlan, CarePlan, "Patient physical activity care plan",                    [[CarePlan describing proposed exercise regime]])
* insert InstanceVersion(1, "Initial CarePlan", Scen1CarePlanV1, [[Planning for jogging and stationary bike]])
* insert InstanceVersion(2, "Updated CarePlan", Scen1CarePlanV2, [[Planning for increased stationary bike]])
* insert Instance_Empty(Scen1Goal,     Goal,     "Physical Activity weekly target",                      [[Goal indicating target number of minutes/week of moderate-vigorous physical activity]])
* insert InstanceVersion(1, "Initial goal", Scen1GoalV1, [[Initial value of 100 mins/week]])
* insert InstanceVersion(1, "Initial goal", Scen1GoalV2, [[Initial value of 100 mins/week-completed]])
* insert Instance_Content(Scen1Goal2,                          Bundle,         "Updated goal",                                     [[Updated value of 150 mins/week]])
* insert Instance_Content(Scen1CarePlanBundle1,                Bundle,         "Initial care plan search response bundle", [[Only contains 1 plan, though in practice, more than one is possible]])
* insert InstanceContains(Scen1CarePlan, 1)
* insert Instance_Content(Scen1CarePlanBundle2,                Bundle,         "Second care plan search response bundle", [[In a real system, the id would be the same as the original]])
* insert InstanceContains(Scen1CarePlan, 2)
* insert Instance_Content(Scen1GoalBundle1,                    Bundle,         "Initial goal search response bundle", [[There could be multiple goals, but in the scenario there's only one.]])
* insert InstanceContains(Scen1Goal, 1)
* insert Instance_Content(Scen1GoalBundle2,                    Bundle,         "Second goal search response bundle", [[In a real system, the id would be the same as the original]])
* insert InstanceContains(Scen1Goal, 2)
* insert InstanceContains(Scen1Goal2, )
* insert Instance_Content(Scen1ExerciseRx,                     ServiceRequest, "Prescription for exercise", [[Expressed as a ServiceRequest with performer of the patient]])
* insert Instance_Content(Scen1ExerciseRxBundle,               Bundle,         "Search result of exercise prescriptions and referrals", [[There could be a mix of an exercise prescription plus referrals, but in this case there's only the prescription.]])
* insert InstanceContains(Scen1ExerciseRx, )
* insert Instance_Content(Scen1ObservationDaysPerWeek,         Observation,    "Example physical activity days per week record",    [[Average days per week of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationMinsPerDay,          Observation,    "Example physical activity minutes per day record",  [[Average minutes per day of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationMinsPerWeek,         Observation,    "Example physical activity minutes per week record", [[Average minutes per week of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationStrengthDaysPerWeek, Observation,    "Example strength days per week record",             [[Average days per week of muscle-strengthening physical activity.]])
* process[+]
  * title = "Day after appointment"
  * description = "The patient accesses the care plan, goals and exercise prescription made available on the EHR"
  * preConditions = "Encounter (and other supporting) resources created"
  * postConditions = "Patient app has retrieved exercise plan related resources"
  * insert ProcessSearch(1, "Query CarePlan",       patientApp, goodHealth, Scen1query1, Scen1CarePlanBundle1,  [[Patient app queries exercise CarePlan describing proposed exercise regime.]])
  * insert ProcessSearch(2, "Query Goal",           patientApp, goodHealth, Scen1query2, Scen1GoalBundle1,      [[Patient app queries Goals (100 minutes/week).]])
  * insert ProcessSearch(3, "Query ServiceRequest", patientApp, goodHealth, Scen1query3, Scen1ExerciseRxBundle, [[Patient app queries ServiceRequest (order for ‘exercise’).]])
* process[+]
  * title = "A couple of weeks later"
  * description = "The exchange noted here would actually occur many times (though not necessarily regularly).  Only a single set of data is shown for simplicity."
  * preConditions = "Patient app is able to write records to EHR"
  * postConditions = "EHR has weekly activity level observations"
  * insert ProcessCreate(5, "Post days/week",         patientApp, goodHealth, Scen1ObservationDaysPerWeek, ,         [[Patient app posts average days per week of moderate-to-vigorous physical activity. `POST https://goodhealth.example.org/fhir/Observation`]])
  * insert ProcessCreate(6, "Post minutes/day",       patientApp, goodHealth, Scen1ObservationMinsPerDay, ,          [[Patient app posts average minutes per day of moderate-to-vigorous physical activity. `POST https://goodhealth.example.org/fhir/Observation`]])
  * insert ProcessCreate(7, "Post minutes/week",      patientApp, goodHealth, Scen1ObservationMinsPerWeek, ,         [[Patient app posts average minutes per week of moderate-to-vigorous physical activity. `POST https://goodhealth.example.org/fhir/Observation`]])
  * insert ProcessCreate(8, "Post stength days/week", patientApp, goodHealth, Scen1ObservationStrengthDaysPerWeek, , [[Patient app posts average days per week of muscle-strengthening physical activity. `POST https://goodhealth.example.org/fhir/Observation`]])
* process[+]
  * title = "A little more than 6 months after first appointment"
  * preConditions = "CarePlan and Goal have been updated in EHR"
  * postConditions = "Patient app retrieves updated CarePlan and Goal"
  * description = "In practice, the patient app would likely check for new CarePlans and Goals each time it launches.  However, this is the first time there'd be something new to retrieve."
  * insert ProcessSearch(9,  "Query revised CarePlan", patientApp, goodHealth, Scen1query1, Scen1CarePlanBundle2,  [[Patient app queries revised CarePlan with providers notes.]])
  * insert ProcessSearch(10, "Query revised Goal",     patientApp, goodHealth, Scen1query2, Scen1GoalBundle2,      [[Patient app queries new Goals.]])
  * insert ProcessSearch(11, "Query ServiceRequest",   patientApp, goodHealth, Scen1query3, Scen1ExerciseRxBundle, [[The results of this search are the same as the initial call because the exercise 'prescription' has not changed.]])


Instance: Scen1CarePlanV1
InstanceOf: PACarePlan
Title:       "CarePlan - initial - Scenario 1"
Description:  "A CarePlan by Dr. Patel targeting physical activity for patient Jorin Khatun, including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* insert CarePlan(2022-12-01, 2023-06-01, Scen1PatientKhatun, "Jorin Khatun", Scen1RolePatel, "Dr. Rajesh Patel", [[Jorin will experiment with jogging in his neighborhood and using an exercise bike at the local gym at least 3 times a week and will continue to monitor his blood pressure.]])
* goal = Reference(Scen1GoalV1)


Instance: Scen1CarePlanV2
InstanceOf: PACarePlan
Title:       "CarePlan - updated - Scenario 1"
Description:  "A revised CarePlan by Dr. Patel for Jorin Khatun, aiming at an increased level of physical activity including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* insert CarePlan(2023-05-05, 2024-01-01, Scen1PatientKhatun, "Jorin Khatun", Scen1RolePatel, "Dr. Rajesh Patel", [[Jorin will continue with his exercise bike and will purchase a used one he can use at home, which should allow him to increase his weekly exercise to 150+ minutes.  He will continue to monitor his blood pressure.]])
* goal = Reference(Scen1GoalV2)
* insert Note(2023-05-05, Scen1PractitionerPatel, "Dr. Rajesh Patel", [[Jorin is adhering well and indicates he's motivated by increased energy playing with his children.]])


Instance: Scen1CarePlanBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - CarePlan - initial - Scenario 1"
Description:  "A search of all active or on-hold physical-activity related CarePlans for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[https://goodhealth.example.org/fhir/CarePlan?patient=Patient/Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen1CarePlanV2)


Instance: Scen1CarePlanBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Care Plan - updated - Scenario 1"
Description:  "A search of all active or on-hold physical-activity related CarePlans for the patient.  In this case, we return the updated version of the CarePlan."
Usage: #example
* insert SearchBundle(1, [[https://goodhealth.example.org/fhir/CarePlan?patient=Patient/Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen1CarePlanV2)


Instance: Scen1GoalV1
InstanceOf: PAGoal
Title:       "Goal - 100 min/wk 'in-progress' - Scenario 1"
Description:  "A goal set for Jorin Khatun to incrementally increase his physical activity to at least 100 minutes per week over the next 6 months."
Usage: #example
* insert Goal(Scen1PatientKhatun, "Jorin Khatun", in-progress, [[Over the next 6 months, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult.]])
* insert GoalTarget(2023-05-01, 82290-8, "Frequency of moderate to vigorous aerobic physical activity", 100 'min/wk')


Instance: Scen1GoalV2
InstanceOf: PAGoal
Title:       "Goal - 100 min/wk 'completed' - Scenario 1"
Description:  "A goal set for Jorin Khatun to incrementally increase his physical activity to at least 100 minutes per week over the next 6 months."
Usage: #example
* insert Goal(Scen1PatientKhatun, "Jorin Khatun", in-progress, [[Over the next 6 months, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult.]])
* insert GoalTarget(2023-05-01, 82290-8, "Frequency of moderate to vigorous aerobic physical activity", 100 'min/wk')


Instance: Scen1Goal2
InstanceOf: PAGoal
Title:       "Goal - 150 min/wk 'in-progress' - Scenario 1"
Description:  "A new goal for Jorin Khatun to further increase his weekly exercise to 150 minutes, with notes on his progress and recommendations."
Usage: #example
* insert Goal(Scen1PatientKhatun, "Jorin Khatun", improving, [[Over the next 6 months, increase your weekly exercise in small increments to at least 150 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult.]])
* insert GoalTarget(2023-08-01, 82290-8, "", 150 'min/wk')
* insert Note(2023-11-01, Scen1PractitionerPatel, "Dr. Rajesh Patel", [[Significant progress.  Regularly exceeding the target and has found an activity he enjoys.  Need to branch out to one more activity to achieve guideline target.]])


Instance: Scen1GoalBundle1
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Goal - Initial goal - Scenario 1"
Description:  "A search of all active or on-hold physical-activity related Goals for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[https://goodhealth.example.org/fhir/Goal?patient=Patient/Scen1PatientKhatun&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(Goal, Scen1GoalV2)


Instance: Scen1GoalBundle2
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Goal - Updated goals - Scenario 1"
Description:  "A search of all active or on-hold physical-activity related Goals for the patient.  In this case, we return the updated version of the Goal."
Usage: #example
* insert SearchBundle(2, [[https://goodhealth.example.org/fhir/Goal?patient=Patient/Scen1PatientKhatun&status=active,on-hold,completed&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(Goal, Scen1GoalV2)
* insert EntryMatch(Goal, Scen1Goal2)


Instance: Scen1ExerciseRx
InstanceOf: PAServiceRequest
Title:       "ServiceRequest - Prescription - Scenario 1"
Description:  "Exercise Prescription by Dr. Patel for Jorin Khatun to increase his physical activity level."
Usage: #example
* insert ExerciseRx(2022-12-01, 2023-05-01, Scen1PatientKhatun,"Jorin Khatun", Scen1PractitionerPatel, "Dr. Rajesh Patel")
* basedOn = Reference(Scen1CarePlanV1)
* extension[pertainsToGoal].valueReference = Reference(Scen1GoalV1)
* reasonCode[+] = $sct#38341003 "Hypertension"
* reasonCode[+] = $sct#40979000 "Lack of physical exercise"


Instance: Scen1ExerciseRxBundle
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - ServiceRequest - Scenario 1"
Description:  "A search of all active or on-hold physical-activity related ServiceRequests for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[https://goodhealth.example.org/fhir/ServiceRequest?patient=Patient/Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity]])
* insert EntryMatch(ServiceRequest, Scen1ExerciseRx)


Instance: Scen1ObservationDaysPerWeek
InstanceOf: PAObservationEVSDaysPerWeek
Title:       "Observation - Days per week - Scenario 1"
Description:  "Observation record for Jorin Khatun indicating that he is exercising 5 days per week."
Usage: #example
* insert DaysPerWeek(Scen1PatientKhatun, "Jorin Khatun", Scen1PatientKhatun, "Jorin Khatun", 2023-03-15, 5)


Instance: Scen1ObservationMinsPerDay
InstanceOf: PAObservationEVSMinutesPerDay
Title:       "Observation - Minutes per Day - Scenario 1"
Description:  "Observation record for Jorin Khatun indicating that he is exercising for 15 minutes per day."
Usage: #example
* insert MinPerDay(Scen1PatientKhatun, "Jorin Khatun", Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 15)


Instance: Scen1ObservationMinsPerWeek
InstanceOf: PAObservationEVSMinutesPerWeek
Title:       "Observation - Minutes per Week - Scenario 1"
Description:  "Observation record for Jorin Khatun indicating that he is exercising for 80 minutes per week."
Usage: #example
* insert MinPerWeek(Scen1PatientKhatun, "Jorin Khatun", Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 80)


Instance: Scen1ObservationStrengthDaysPerWeek
InstanceOf: PAObservationStrengthDaysPerWeek
Title:       "Observation - Strength Days per Week - Scenario 1"
Description:  "Observation record for Jorin Khatun indicating that he performs strength training exercises 3 days per week."
Usage: #example
* insert StrengthPerWeek(Scen1PatientKhatun, "Jorin Khatun", Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 3)


Instance: Scen1OrgGoodhealth
InstanceOf: USCoreOrganizationProfile
Title:       "Organization - Good Health Clinic - Scenario 1"
Description:  "Good Health Clinic, a healthcare provider."
Usage: #example
* identifier
  * system = "http://example.org/organization"
  * value = "GH12345"
* active = true
* name = "Good Health Clinic"
* type = $organization-type#prov "Healthcare Provider"
  * text = "Healthcare Provider"
* telecom[+]
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

Instance: Scen1PatientKhatun
InstanceOf: USCorePatientProfile
Title:       "Patient - Jorin Khatun - Scenario 1"
Description:  "Profile of the patient Mr. Jorin Khatun."
Usage: #example
* identifier
  * system = "http://hospital.example.org/patients"
  * value = "123456"
* active = true
* name
  * family = "Khatun"
  * given = "Jorin"
  * prefix = "Mr."
* gender = #male
* birthDate = "1967-05-20"
* address
  * line = "123 Main St"
  * city = "Anytown"
  * state = "CA"
  * postalCode = "12345"
  * country = "USA"
* telecom[+]
  * system = #phone
  * value = "+1(555) 555-1234"
  * use = #home
* telecom[+]
  * system = #email
  * value = "Jorin.khatun@example.org"
  * use = #home


Instance: Scen1PractitionerPatel
InstanceOf: USCorePractitionerProfile
Title:       "Practitioner - Dr. Patel - Scenario 1"
Description:  "Profile of Dr. Rajesh Patel."
Usage: #example
* identifier
  * system = "http://example.org/practitioner"
  * value = "P12345"
* active = true
* name
  * family = "Patel"
  * given = "Rajesh"
  * prefix = "Dr."
* telecom[+]
  * system = #phone
  * value = "+1(555) 555-4321"
  * use = #work
* telecom[+]
  * system = #email
  * value = "rajesh.patel@example.org"
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
    * system = "http://example.org/qualification"
    * value = "Q98765"
  * code.text = "General Practitioner"
  * period.start = "2000-07-01"


Instance: Scen1RolePatel
InstanceOf: USCorePractitionerRoleProfile
Title:       "Practitioner Role - Dr. Patel - Scenario 1"
Description:  "Dr. Rajesh Patel's role as a General Practitioner at Good Health Clinic"
Usage: #example
* identifier
  * system = "http://example.org/practitioner-role"
  * value = "PR45678"
* active = true
* practitioner = Reference(Scen1PractitionerPatel) "Dr. Rajesh Patel"
* organization = Reference(Scen1OrgGoodhealth) "Good Health Clinic"
* code = $practitioner-role#doctor "Doctor"
  * text = "Doctor"
* specialty = $sct#394814009 "General practice (specialty)"
  * text = "General Practitioner"