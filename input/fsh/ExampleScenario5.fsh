Instance: Scen5ActivityAndGlucoseObservations
InstanceOf: ExampleScenario
Title:       "Scenario 5 - Patient-Provider Communication on Activity and Blood Glucose Observations"
Description: "Scenario illustrating creation and retrieval of a patient's physical activity and blood glucose observations."
Usage: #definition
* version = "4.0.1"
* name = "PatientProviderCommunicationonActivityandBloodGlucoseObservations"
* status = #draft
* experimental = true
* insert ActorEntity(patient-app, "Rosalie's phone app", [[An app on Rosalie's phone with access to Nadia's record]])
* insert ActorEntity(flores-ehr,  "Mercy Clinic",        [[System that manages data for Dr. Flores's clinic]])
* insert ActorEntity(shea-ehr,    "Mrs. O’Shea's app",   [[System that manages data for Mrs. O'She's practice]])
* insert Instance_Empty(Scen5query1,                       Binary,      "Query for PA and blood glucose observations", [[Query for observations that Mrs. O'Shea has access to related to Rosalie: `GET https://mercy.example.org/fhir/Observation?patient=Patient/Scen5PatientRosalie&status=completed,amended,corrected&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity,http%3A//terminology.hl7.org/CodeSystem/observation-category|laboratory`]])
* insert Instance_Content(Scen5ObsBloodGlucose,            Observation, "Blood Glucose Observation for Rosalie",       [[Sample blood-glucose level captured for Rosalie by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityGroup,           Observation, "Activity Panel Observation for Rosalie",      [[Sample collection of information about one of Rosalie's exercise activities as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityType,            Observation, "Activity Type Observation for Rosalie",       [[Sample record of what type of exercise activity Rosalie was doing as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityDuration,        Observation, "Activity Duration Observation for Rosalie",   [[Sample record of the duration of exercise activity Rosalie was doing as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityModerate,        Observation, "Moderate Duation Observation for Rosalie",    [[Sample record of the duration of moderate exercise activity Rosalie was doing as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityVigorous,        Observation, "Vigorous Duration Observation for Rosalie",   [[Sample record of the duration of vigorous exercise activity Rosalie was doing as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObsActivityMeanHR,          Observation, "Mean Heart Rate Observation for Rosalie",     [[Sample record of Rosalie's average heart rate during her exercise activity as recorded by her mother.  (In practice there would be many.)]])
* insert Instance_Content(Scen5ObservationsResponseBundle, Bundle,      "Observations retrieved by Mrs. O'Shea",       [[Search-set Bundle returning Rosalie's observations (that Mrs. O'Shea has access to)]])
* insert InstanceContains(Scen5ObsBloodGlucose, )
* insert InstanceContains(Scen5ObsActivityGroup, )
* insert InstanceContains(Scen5ObsActivityType, )
* insert InstanceContains(Scen5ObsActivityDuration, )
* insert InstanceContains(Scen5ObsActivityModerate, )
* insert InstanceContains(Scen5ObsActivityVigorous, )
* insert InstanceContains(Scen5ObsActivityMeanHR, )
* process[+]
  * title = "Observation Creation"
  * description = "Nadia records observations for Rosalie.  While only a limited number of records are captured here, in practice there would likely be multiple glucose readings and activity entries per day every day."
  * preConditions = "Nadia has credentials on Dr. Flores's EHR system."
  * postConditions = "Dr. Flores's system has detailed records of Rosalie's blood glucose readings and exercise levels."
  * insert ProcessCreate(1, "Record blood glucose",     patient-app, flores-ehr, Scen5ObsBloodGlucose, ,     [[Nadia's app transmits Rosalie's blood glucose measurement to Dr. Flores's EHR.  (NOTE: This type of data is outside the scope of this IG, but is covered by US Core.) Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(2, "Record activity group",    patient-app, flores-ehr, Scen5ObsActivityGroup, ,    [[Nadia's app transmits a grouper describing Rosalie's exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(3, "Record activity type",     patient-app, flores-ehr, Scen5ObsActivityType, ,     [[Nadia's app transmits Rosalie's type of exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(4, "Record activity duration", patient-app, flores-ehr, Scen5ObsActivityDuration, , [[Nadia's app transmits Rosalie's duration of exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(5, "Record moderate activity", patient-app, flores-ehr, Scen5ObsActivityModerate, , [[Nadia's app transmits Rosalie's duration of moderate exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(6, "Record vigorous activity", patient-app, flores-ehr, Scen5ObsActivityVigorous, , [[Nadia's app transmits Rosalie's duration of vigorous exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
  * insert ProcessCreate(7, "Record mean heart rate",   patient-app, flores-ehr, Scen5ObsActivityMeanHR, ,   [[Nadia's app transmits Rosalie's average heart rate during exercise to Dr. Flores's EHR. Request: `POST https://mercy.example.org/fhir/Observation`  Response: `201 Created`]])
* process[+]
  * title = "Observation Retrieval"
  * description = "Mrs. O'Shea uses her app retrieves the observations created by Nadia from Dr. Flores's EHR."
  * preConditions = "Mrs. O'Shea has permision to retrieve certain types observations for Rosalie.  (There would generally need to be a consent on file with Dr. Flores's clinic.)"
  * postConditions = "Mrs. O'Shea can see the observations about Rosalie."
  * insert ProcessSearch(8, "Retrieve Rosalie's observations", shea-ehr, flores-ehr, Scen5query1, Scen5ObservationsResponseBundle, [[Search to retrieve observations about Rosalie that Mrs. O'Shea has a right to see.]])


Instance: Scen5ObsBloodGlucose
InstanceOf: USCoreLaboratoryResultObservationProfile
Title:       "Observation - US Core Blood Glucose - Scenario 5"
Description:  "Sample blood glucose reading captured by a glucometer andObservation of the exercise activity performed by patient Rosalie."
Usage: #example
* insert Observation(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:32:45-08:00)
* code = $loinc#41653-7 "Glucose [Mass/volume] in Capillary blood by Glucometer"
* valueQuantity = 61 'mg/dL' "mg/dL"

Instance: Scen5ObsActivityGroup
InstanceOf: PAObservationActivityGroup
Title:       "Observation - Activity Group - Scenario 5"
Description:  "A sample observation reporting one of Rosalie's soccer games"
Usage: #example
* insert ActivityGroup(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00)
* insert HasMember(Scen5ObsActivityType)
* insert HasMember(Scen5ObsActivityDuration)
* insert HasMember(Scen5ObsActivityModerate)
* insert HasMember(Scen5ObsActivityVigorous)
* insert HasMember(Scen5ObsActivityMeanHR)
* insert Note(2022-07-18T16:31:00-08:00, Scen5RelatedPersonNadia, "Nadia Belyaev", [[Regular soccer game.  On field for all but 15 minutes]])

Instance: Scen5ObsActivityType
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Activity Type - Scenario 5"
Description:  "Indicates that the specific activity was a run (closest approximation to soccer)"
Usage: #example
* insert ActivityType(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00, LA11836-6, "Running")

Instance: Scen5ObsActivityDuration
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Activity Duration - Scenario 5"
Description:  "The length of a period of physical activity calculated by Nadia's phone based on information transmitted from Rosalie's watch."
Usage: #example
* insert ActivityDuration(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00, 156)

Instance: Scen5ObsActivityModerate
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Moderate Duration - Scenario 5"
Description:  "The length of a period of moderate physical activity calculated by Nadia's phone based on information transmitted from Rosalie's watch."
Usage: #example
* insert ActivityDuration(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00, 117)

Instance: Scen5ObsActivityVigorous
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Vigorous Duration - Scenario 5"
Description:  "The length of a period of vigorous activity calculated by Nadia's phone based on information transmitted from Rosalie's watch."
Usage: #example
* insert ActivityDuration(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00, 39)

Instance: Scen5ObsActivityMeanHR
InstanceOf: PAObservationActivityMeasure
Title:       "Observation - Average Activity Heart Rate - Scenario 5"
Description:  "The average heart rate achieved by the Rosalie over the course of the game."
Usage: #example
* insert MeanHeartRate(Scen5PatientRosalie, "Rosalie Belyaev", Scen5RelatedPersonNadia, "Nadia Belyaev", 2022-07-18T16:31:00-08:00, 153)

Instance: Scen5ObservationsResponseBundle
InstanceOf: Bundle
Title:       "Bundle 'Search Set' - Observation - activity and blood glucose - Scenario 5"
Description:  "Bundle of search results for observations related to physical activity and blood glucose for patient Rosalie."
Usage: #example
* insert SearchBundle(1, [[https://mercy.example.org/fhir/Observation?patient=Patient/Scen5PatientRosalie&status=completed,amended,corrected&category=http%3A//hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes|PhysicalActivity,http%3A//terminology.hl7.org/CodeSystem/observation-category|laboratory]])
* insert EntryMatch(Observation, Scen5ObsBloodGlucose)
* insert EntryMatch(Observation, Scen5ObsActivityType)
* insert EntryMatch(Observation, Scen5ObsActivityDuration)
* insert EntryMatch(Observation, Scen5ObsActivityModerate)
* insert EntryMatch(Observation, Scen5ObsActivityVigorous)
* insert EntryMatch(Observation, Scen5ObsActivityMeanHR)

Instance: Scen5RelatedPersonNadia
InstanceOf: PARelatedPerson
Title:       "Patient - Nadia Belyaev - Scenario 5"
Description:  "Related person information for Nadia Belyaev, the mother of patient Rosalie."
Usage: #example
* patient = Reference(Scen5PatientRosalie)
* relationship = $v3-RoleCode#MTH "mother"
  * text = "Mother"
* name
  * use = #official
  * family = "Belyaev"
  * given = "Nadia"
* gender = #female

Instance: Scen5PatientRosalie
InstanceOf: USCorePatientProfile
Title:       "RelatedPerson - Rosalie Belyaev - Scenario 5"
Description:  "Patient information for Rosalie Belyaev."
Usage: #example
* identifier
  * use = #usual
  * type = $v2-0203#MR "Medical record number"
    * text = "Medical record number"
  * system = "http://someClinic.example.org/identifiers/mrn"
  * value = "13579"
* name
  * use = #official
  * family = "Belyaev"
  * given = "Rosalie"
* gender = #female
* birthDate = "2008-04-14"