Instance: scen5ActivityAndGlucoseObservations
InstanceOf: ExampleScenario
Title:       "Scenario 5 - Patient-Provider Communication on Activity and Blood Glucose Observations"
Description: "Scenario illustrating creation and retrieval of a patient's physical activity and blood glucose observations."
Usage: #definition
* version = "4.0.1"
* name = "PatientProviderCommunicationonActivityandBloodGlucoseObservations"
* status = #draft
* experimental = true
* actor[+]
  * actorId = "patient-app"
  * type = #entity
  * name = "Rosalie's phone app (w/ access to Nadia)"
* actor[+]
  * actorId = "flores-ehr"
  * type = #entity
  * name = "Dr. Flores's EHR"
* actor[+]
  * actorId = "shea-ehr"
  * type = #entity
  * name = "Mrs. O’Shea's EHR"
* instance[+]
  * resourceId = "scen5query1"
  * resourceType = #Binary
  * description = "Search for PA and Blood Glucose observations: GET /Observation?patient=scen5PatientRosalie&category=PhysicalActivity,laboratory"
* instance[+]
  * resourceId = "scen5ObservationActivityType"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationEVSMinutesPerDay"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationPeakDailyHeartRate"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationCaloriesPerDay"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationDailySteps"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationBloodGlucose1"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationBloodGlucose2"
  * resourceType = #Observation
  * version
    * versionId = "1"
    * description = "Observation successfully created"
* instance[+]
  * resourceId = "scen5ObservationsResponseBundle"
  * resourceType = #Bundle
  * description = "Search-set Bundle returning Rosalie's observations"
* process[+]
  * title = "Observation Creation"
  * description = "In this process, Nadia creates observations for Rosalie."
  * preConditions = "Nadia has access to create observations for Rosalie."
  * postConditions = "Nadia successfully creates observations for Rosalie."
  * step[+].operation
    * number = "1"
    * type = "create"
    * description = "Patient to Provider - Create Activity Type Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationActivityType"
    * response
      * resourceId = "scen5ObservationActivityType"
      * versionId = "1"
  * step[+].operation
    * number = "2"
    * type = "create"
    * description = "Patient to Provider - Create EVS Minutes Per Day Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationEVSMinutesPerDay"
    * response
      * resourceId = "scen5ObservationEVSMinutesPerDay"
      * versionId = "1"
  * step[+].operation
    * number = "3"
    * type = "create"
    * description = "Patient to Provider - Create Peak Daily Heart Rate Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationPeakDailyHeartRate"
    * response
      * resourceId = "scen5ObservationPeakDailyHeartRate"
      * versionId = "1"
  * step[+].operation
    * number = "4"
    * type = "create"
    * description = "Patient to Provider - Create First Blood Glucose Reading. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationBloodGlucose1"
    * response
      * resourceId = "scen5ObservationBloodGlucose1"
      * versionId = "1"
  * step[+].operation
    * number = "5"
    * type = "create"
    * description = "Patient to Provider - Create Calories Per Day Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationCaloriesPerDay"
    * response
      * resourceId = "scen5ObservationCaloriesPerDay"
      * versionId = "1"
  * step[+].operation
    * number = "6"
    * type = "create"
    * description = "Patient to Provider - Create Daily Steps Observation. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationDailySteps"
    * response
      * resourceId = "scen5ObservationDailySteps"
      * versionId = "1"
  * step[+].operation
    * number = "7"
    * type = "create"
    * description = "Patient to Provider - Create First Blood Glucose Reading. Request: POST /Observation"
    * initiator = "patient-app"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5ObservationBloodGlucose1"
    * response
      * resourceId = "scen5ObservationBloodGlucose1"
      * versionId = "1"
  * step[+]
    * pause = true
    * operation
      * number = "7"
      * type = "create"
      * description = "Patient to Provider - Create Second Blood Glucose Reading. Request: POST /Observation"
      * initiator = "patient-app"
      * receiver = "flores-ehr"
      * request.resourceId = "scen5ObservationBloodGlucose2"
      * response
        * resourceId = "scen5ObservationBloodGlucose2"
        * versionId = "1"
* process[+]
  * title = "Observation Retrieval"
  * description = "In this process, Mrs. O'Shea retrieves the observations created by Nadia."
  * preConditions = "Mrs. O'Shea has access to retrieve observations for Rosalie."
  * postConditions = "Mrs. O'Shea successfully retrieves the observations created by Nadia."
  * step.operation
    * number = "8"
    * type = "search-type"
    * description = "O’Shea to Provider - search for PA and Blood Glucose observations."
    * initiator = "shea-ehr"
    * receiver = "flores-ehr"
    * request.resourceId = "scen5query1"
    * response.resourceId = "scen5ObservationsResponseBundle"


Instance: scen5ObservationActivityType
InstanceOf: Observation
Title:       "Exercise Activity Observation"
Description:  "Observation of the exercise activity performed by patient Rosalie."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-15T12:00:00Z"
* status = #final
* category[+] = $observation-category#activity
* category[+] = $PA-Temp#PhysicalActivity
* code = $loinc#73985-4 "Exercise Activity"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueCodeableConcept = $loinc#LA11836-6 "Running"

Instance: scen5ObservationEVSMinutesPerDay
InstanceOf: Observation
Title:       "Minutes per Day Observation"
Description:  "Observation of the number of minutes per day engaged in physical activity by patient Rosalie."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-15T12:00:00Z"
* status = #final
* category[+] = $observation-category#activity
* category[+] = $PA-Temp#PhysicalActivity
* code = $loinc#68516-4
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 30 'min/d' "minutes per day"

Instance: scen5ObservationPeakDailyHeartRate
InstanceOf: Observation
Title:       "Peak Daily Heart Rate Observation"
Description:  "Observation of the peak daily heart rate of patient Rosalie."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-15T12:00:00Z"
* status = #final
* category[+] = $observation-category#activity
* category[+] = $PA-Temp#PhysicalActivity
* code = $loinc#8873-2 "Heart rate 24 hour maximum"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 170 '/min' "bpm"

Instance: scen5ObservationCaloriesPerDay
InstanceOf: Observation
Title:       "Calories per Day Observation"
Description:  "Observation of the number of calories burned per day by patient Rosalie."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-16T12:00:00Z"
* status = #final
* category[+] = $observation-category#activity
* category[+] = $PA-Temp#PhysicalActivity
* code = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 400 'kcal' "kcal"

Instance: scen5ObservationDailySteps
InstanceOf: Observation
Title:       "Daily Steps Observation"
Description:  "Observation of the number of steps taken per day by patient Rosalie."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-16T12:00:00Z"
* status = #final
* category[+] = $observation-category#activity
* category[+] = $PA-Temp#PhysicalActivity
* code = $loinc#41950-7 "Number of steps in 24 hour Measured"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 4500 '{steps}' "steps"

Instance: scen5ObservationBloodGlucose1
InstanceOf: Observation
Title:       "Blood Glucose Observation 1"
Description:  "Observation of the blood glucose level."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-15T12:00:00Z"
* status = #final
* category = $observation-category#laboratory "Laboratory"
* code = $loinc#2339-0 "Glucose Bld-mCnc"
  * text = "Glucose Bld-mCnc"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-15T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 60 'mg/dL' "mg/dL"

Instance: scen5ObservationBloodGlucose2
InstanceOf: Observation
Title:       "Blood Glucose Observation 2"
Description:  "Observation of the blood glucose level."
Usage: #example
* meta
  * versionId = "1"
  * lastUpdated = "2022-03-16T12:00:00Z"
* status = #final
* category = $observation-category#laboratory "Laboratory"
* code = $loinc#2339-0 "Glucose Bld-mCnc"
  * text = "Glucose Bld-mCnc"
* subject = Reference(Patient/scen5PatientRosalie)
* effectiveDateTime = "2022-03-16T11:00:00Z"
* performer = Reference(RelatedPerson/scen5RelatedpersonNadia)
* valueQuantity = 65 'mg/dL' "mg/dL"

Instance: scen5ObservationsResponseBundle
InstanceOf: Bundle
Title:       "Observations Search Results"
Description:  "Bundle of search results for observations related to physical activity and blood glucose for patient Rosalie."
Usage: #example
* type = #searchset
* total = 7
* link
  * relation = "self"
  * url = "http://example.com/fhir/Observation?patient=scen5PatientRosalie&category=PhysicalActivity,laboratory"
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationActivityType"
  * resource = scen5ObservationActivityType
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationEVSMinutesPerDay"
  * resource = scen5ObservationEVSMinutesPerDay
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationPeakDailyHeartRate"
  * resource = scen5ObservationPeakDailyHeartRate
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationCaloriesPerDay"
  * resource = scen5ObservationCaloriesPerDay
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationDailySteps"
  * resource = scen5ObservationDailySteps
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationBloodGlucose1"
  * resource = scen5ObservationBloodGlucose1
* entry[+]
  * fullUrl = "http://example.com/fhir/Observation/scen5ObservationBloodGlucose2"
  * resource = scen5ObservationBloodGlucose2


Instance: scen5RelatedpersonNadia
InstanceOf: RelatedPerson
Title:       "Nadia Doe"
Description:  "Related person information for Nadia Doe, the mother of patient Rosalie."
Usage: #example
* patient = Reference(Patient/scen5PatientRosalie)
* relationship = $v3-RoleCode#MTH "mother"
* name
  * use = #official
  * family = "Doe"
  * given = "Nadia"
* gender = #female

Instance: scen5PatientRosalie
InstanceOf: Patient
Title:       "Rosalie Doe"
Description:  "Patient information for Rosalie Doe."
Usage: #example
* name
  * use = #official
  * family = "Doe"
  * given = "Rosalie"
* gender = #female
* birthDate = "2008-04-14"