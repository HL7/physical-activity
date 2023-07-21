Instance: Scen1ExercisePrescriptionScenario
InstanceOf: ExampleScenario
Title:       "Scenario 1 - Exercise Prescription"
Description: "ExampleScenario instance illustrating how a patient app interacts with an EHR to manage and update an exercise plan. It covers the querying of resources such as CarePlan, Goal, and ServiceRequest, posting of Observations regarding physical activity levels, and how these resources are updated over time."
Usage: #definition
* status = #draft
* version = "4.0.1"
* name = "ExercisePrescription"
* insert ActorEntity(patientApp, "Patient App", [[A patient app used to query resources related to the exercise plan]])
* insert ActorEntity(ehr,        "EHR",         [[EHR that records patient's exercise plan]])
* insert Instance_Empty(Scen1query1,   Binary,   "Query for patient physical activity care plans",         [[Query for CarePlans for a patient: `GET https://example.org/fhir/CarePlan?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1query2,   Binary,   "Query for patient physical activity goals",              [[Query for Goals for a patient: `GET https://example.org/fhir/Goal?patient=Scen1PatientKhatun&status=&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1query3,   Binary,   "Query for patient exercise prescriptions and referrals", [[Query for ServiceRequests for a patient: `GET https://example.org/fhir/ServiceRequest?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity`]])
* insert Instance_Empty(Scen1CarePlan, CarePlan, "Patient physical activity care plan",                    [[CarePlan describing proposed exercise regime]])
* insert InstanceVersion(1, "Initial CarePlan", Scen1CarePlanV1, [[Planning for jogging and stationary bike]])
* insert InstanceVersion(2, "Updated CarePlan", Scen1CarePlanV2, [[Planning for increased stationary bike]])
* insert Instance_Empty(Scen1GoalV1,     Goal,     "Physical Activity weekly target",                        [[Goal indicating target number of minutes/week of moderate-vigorous physical activity]])
* insert InstanceVersion(1, "Initial goal", Scen1GoalV1, [[Initial value of 100 mins/week]])
* insert InstanceVersion(2, "Updated goal", Scen1GoalV2, [[Updated value of 150 mins/week]])
* insert Instance_Content(Scen1CarePlanBundleV1, Scen1CarePlanBundleV1, Bundle, "Initial care plan search response bundle", )
* insert InstanceContains(Scen1CarePlan, 1)
* insert Instance_Content(Scen1CarePlanBundleV2, Scen1CarePlanBundleV2, Bundle, "Second care plan search response bundle", )
* insert InstanceContains(Scen1CarePlan, 2)
* insert Instance_Content(Scen1GoalBundleV1, Scen1GoalBundleV1, Bundle, "Initial goal search response bundle", )
* insert InstanceContains(Scen1GoalV1, 1)
* insert Instance_Content(Scen1GoalBundleV2, Scen1GoalBundleV2, Bundle, "Second goal search response bundle", )
* insert InstanceContains(Scen1GoalV2, 2)
* insert Instance_Content(Scen1ExerciseRx, Scen1ExerciseRx, ServiceRequest, "Prescription for exercise", )
* insert Instance_Content(Scen1ExerciseRxBundle, Scen1ExerciseRxBundle, Bundle, "Search result of exercise prescriptions and referrals", )
* insert InstanceContains(Scen1ExerciseRx, )
* insert Instance_Content(Scen1ObservationDaysPerWeek,         Scen1ObservationDaysPerWeek,         Observation, "Example physical activity days per week record",    [[Average days per week of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationMinsPerDay,          Scen1ObservationMinsPerDay,          Observation, "Example physical activity minutes per day record",  [[Average minutes per day of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationMinsPerWeek,         Scen1ObservationMinsPerWeek,         Observation, "Example physical activity minutes per week record", [[Average minutes per week of moderate-to-vigorous physical activity.]])
* insert Instance_Content(Scen1ObservationStrengthDaysPerWeek, Scen1ObservationStrengthDaysPerWeek, Observation, "Example strength days per week record",             [[Average days per week of muscle-strengthening physical activity.]])
* process[+]
  * title = "Day after appointment"
  * description = "The patient accesses the care plan, goals and exercise prescription made available on the EHR"
  * preConditions = "Encounter (and other supporting) resources created"
  * postConditions = "Patient app has retrieved exercise plan related resources"
  * insert ProcessSearch(1, "Query CarePlan",       patientApp, ehr, Scen1query1, Scen1CarePlanBundleV1, [[Patient app queries exercise CarePlan describing proposed exercise regime.]])
  * insert ProcessSearch(2, "Query Goal",           patientApp, ehr, Scen1query2, Scen1GoalBundleV1,     [[Patient app queries Goals (100 minutes/week).]])
  * insert ProcessSearch(3, "Query ServiceRequest", patientApp, ehr, Scen1query3, Scen1ExerciseRxBundle, [[Patient app queries ServiceRequest (order for ‘exercise’).]])
  * step[=].pause = true
* process[+]
  * title = "A couple of weeks later"
  * description = "The exchange noted here would actually occur many times (though not necessarily regularly).  Only a single set of data is shown for simplicity."
  * preConditions = "Patient app is able to write records to EHR"
  * postConditions = "EHR has weekly activity level observations"
  * insert ProcessCreate(5, "Post days/week",         patientApp, ehr, Scen1ObservationDaysPerWeek,         [[Patient app posts average days per week of moderate-to-vigorous physical activity. `POST https://example.org/fhir/Observation`]])
  * insert ProcessCreate(6, "Post minutes/day",       patientApp, ehr, Scen1ObservationMinsPerDay,          [[Patient app posts average minutes per day of moderate-to-vigorous physical activity. `POST https://example.org/fhir/Observation`]])
  * insert ProcessCreate(7, "Post minutes/week",      patientApp, ehr, Scen1ObservationMinsPerWeek,         [[Patient app posts average minutes per week of moderate-to-vigorous physical activity. `POST https://example.org/fhir/Observation`]])
  * insert ProcessCreate(8, "Post stength days/week", patientApp, ehr, Scen1ObservationStrengthDaysPerWeek, [[Patient app posts average days per week of muscle-strengthening physical activity. `POST https://example.org/fhir/Observation`]])
  * step[=].pause = true
* process[+]
  * title = "A little more than 6 months after first appointment"
  * preConditions = "CarePlan and Goal have been updated in EHR"
  * postConditions = "Patient app retrieves updated CarePlan and Goal"
  * description = "In practice, the patient app would likely check for new CarePlans and Goals each time it launches.  However, this is the first time there'd be something new to retrieve."
  * insert ProcessSearch(9,  "Query revised CarePlan", patientApp, ehr, Scen1query1, Scen1CarePlanBundleV2, [[Patient app queries revised CarePlan with providers notes.]])
  * insert ProcessSearch(10, "Query revised Goal",     patientApp, ehr, Scen1query2, Scen1GoalBundleV2,     [[Patient app queries revised Goal of 150 minutes/week.]])
  * insert ProcessSearch(11, "Query ServiceRequest",   patientApp, ehr, Scen1query3, Scen1ExerciseRxBundle, [[The results of this search are the same as the initial call because the exercise 'prescription' has not changed.]])


Instance: Scen1CarePlanV1
InstanceOf: CarePlan
Title:       "Physical Activity Care Plan for Jorin Khatun"
Description:  "A CarePlan by Dr. Patel targeting physical activity for patient Jorin Khatun, including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* insert CarePlan(2022-12-01, 2023-06-01, Scen1PatientKhatun, "Jorin Khatun", Scen1RolePatel, "Dr. Rajesh Patel", [[Jorin will experiment with jogging in his neighborhood and using an exercise bike at the local gym at least 3 times a week and will continue to monitor his blood pressure.]])
* goal = Reference(Scen1GoalV1)


Instance: Scen1CarePlanV2
InstanceOf: CarePlan
Title:       "Updated Physical Activity CarePlan for Jorin Khatun"
Description:  "A revised CarePlan by Dr. Patel for Jorin Khatun, aiming at an increased level of physical activity including moderate to vigorous and muscle-strengthening exercises."
Usage: #example
* insert CarePlan(2023-05-05, 2024-01-01, Scen1PatientKhatun, "Jorin Khatun", Scen1RolePatel, "Dr. Rajesh Patel", [[Jorin will continue with his exercise bike and will purchase a used one he can use at home, which should allow him to increase his weekly exercise to 150+ minutes.  He will continue to monitor his blood pressure.]])
* goal = Reference(Scen1GoalV2)
* insert Note(2023-05-05, Scen1PractitionerPatel, "Dr. Rajesh Patel", [[Jorin is adhering well and indicates he's motivated by increased energy playing with his children.]])


Instance: Scen1CarePlanBundleV1
InstanceOf: Bundle
Title:       "Initial search response of active care plans for patient"
Description:  "A search of all active or on-hold physical-activity related CarePlans for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[CarePlan?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/PA-Temp|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen1CarePlanV2)


Instance: Scen1CarePlanBundleV2
InstanceOf: Bundle
Title:       "Second search response of active care plans for patient"
Description:  "A search of all active or on-hold physical-activity related CarePlans for the patient.  In this case, we return the updated version of the CarePlan."
Usage: #example
* insert SearchBundle(1, [[CarePlan?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/PA-Temp|PhysicalActivity]])
* insert EntryMatch(CarePlan, Scen1CarePlanV2)


Instance: Scen1GoalV1
InstanceOf: Goal
Title:       "Initial Physical Activity Goal for Jorin Khatun"
Description:  "A goal set for Jorin Khatun to incrementally increase his physical activity to at least 100 minutes per week over the next 6 months."
Usage: #example
* insert Goal(Scen1PatientKhatun, "Jorin Khatun", in-progress, [[Over the next 6 months, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult.]])
* insert GoalTarget(2023-05-01, 82290-8, "Frequency of moderate to vigorous aerobic physical activity", 100 'min/wk')


Instance: Scen1GoalV2
InstanceOf: Goal
Title:       "Updated Physical Activity Goal for Jorin Khatun"
Description:  "An updated goal for Jorin Khatun to further increase his weekly exercise to 150 minutes, with notes on his progress and recommendations."
Usage: #example
* insert Goal(Scen1PatientKhatun, "Jorin Khatun", improving, [[Over the next 6 months, increase your weekly exercise in small increments to at least 150 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult.]])
* insert GoalTarget(2023-08-01, 82290-8, "", 150 'min/wk')
* insert Note(2023-11-01, Scen1PractitionerPatel, "Dr. Rajesh Patel", [[Significant progress.  Regularly exceeding the target and has found an activity he enjoys.  Need to branch out to one more activity to achieve guideline target.]])


Instance: Scen1GoalBundleV1
InstanceOf: Bundle
Title:       "Initial search response of active goals for patient"
Description:  "A search of all active or on-hold physical-activity related Goals for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[Goal?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/PA-Temp|PhysicalActivity]])
* insert EntryMatch(Goal, Scen1GoalV2)


Instance: Scen1GoalBundleV2
InstanceOf: Bundle
Title:       "Second search response of active goals for patient"
Description:  "A search of all active or on-hold physical-activity related Goals for the patient.  In this case, we return the updated version of the Goal."
Usage: #example
* insert SearchBundle(1, [[Goal?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/PA-Temp|PhysicalActivity]])
* insert EntryMatch(Goal, Scen1GoalV2)


Instance: Scen1ExerciseRx
InstanceOf: ServiceRequest
Title:       "Physical Activity Exercise Prescription for Jorin Khatun"
Description:  "Exercise Prescription by Dr. Patel for Jorin Khatun to increase his ."
Usage: #example
* insert ExerciseRx (2022-12-01, 2023-05-01, Scen1PatientKhatun,"Jorin Khatun", Scen1PractitionerPatel, "Dr. Rajesh Patel")
* basedOn = Reference(Scen1CarePlanV1)
* extension[pertainsToGoal].valueReference = Reference(Scen1GoalV1)
* reasonCode[+] = $sct#38341003 "Hypertension"
* reasonCode[+] = $sct#40979000 "Lack of physical exercise"


Instance: Scen1ExerciseRxBundle
InstanceOf: Bundle
Title:       "Search response of prescriptions/referrals  for patient"
Description:  "A search of all active or on-hold physical-activity related ServiceRequests for the patient.  In this case, there's only one, but in theory there could be more than one."
Usage: #example
* insert SearchBundle(1, [[ServiceRequest?patient=Scen1PatientKhatun&status=active,on-hold&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/PA-Temp|PhysicalActivity]])
* insert EntryMatch(ServiceRequest, Scen1ExerciseRx)


Instance: Scen1ObservationDaysPerWeek
InstanceOf: Observation
Title:       "Jorin Khatun's Weekly Physical Activity Observation"
Description:  "Observation record for Jorin Khatun indicating that he is exercising 5 days per week."
Usage: #example
* insert DaysPerWeek(Scen1PatientKhatun, "Jorin Khatun", 2023-03-15, 5)


Instance: Scen1ObservationMinsPerDay
InstanceOf: Observation
Title:       "Jorin Khatun's Daily Physical Activity Duration Observation"
Description:  "Observation record for Jorin Khatun indicating that he is exercising for 15 minutes per day."
Usage: #example
* insert MinPerDay(Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 15)


Instance: Scen1ObservationMinsPerWeek
InstanceOf: Observation
Title:       "Jorin Khatun's Weekly Physical Activity Duration Observation"
Description:  "Observation record for Jorin Khatun indicating that he is exercising for 80 minutes per week."
Usage: #example
* insert MinPerWeek(Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 80)


Instance: Scen1ObservationStrengthDaysPerWeek
InstanceOf: Observation
Title:       "Jorin Khatun's Weekly Strength Training Observation"
Description:  "Observation record for Jorin Khatun indicating that he performs strength training exercises 3 days per week."
Usage: #example
* insert StrengthPerWeek(Scen1PatientKhatun, "Jorin Khatun", 2023-01-15, 3)


Instance: Scen1OrgGoodhealth
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
InstanceOf: Patient
Title:       "Patient - Jorin Khatun"
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
  * value = "Jorin.khatun@example.com"
  * use = #home


Instance: Scen1PractitionerPatel
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
* telecom[+]
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


Instance: Scen1RolePatel
InstanceOf: PractitionerRole
Title:       "Practitioner Role - Dr. Rajesh Patel at Good Health Clinic"
Description:  "Dr. Rajesh Patel's role as a General Practitioner at Good Health Clinic"
Usage: #example
* identifier
  * system = "http://example.com/practitioner-role"
  * value = "PR45678"
* active = true
* practitioner = Reference(Scen1PractitionerPatel) "Dr. Rajesh Patel"
* organization = Reference(Scen1OrgGoodhealth) "Good Health Clinic"
* code = $practitioner-role#doctor "Doctor"
  * text = "Doctor"
* specialty = $sct#394814009 "General practice (specialty)"
  * text = "General Practitioner"