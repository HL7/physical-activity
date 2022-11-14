Profile:        ExerciseBase
Parent:         http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-ObservationAssessment
Id:             observation-exercise-base
Title:          "Exercise Base"
Description:    "A profile describing base requirements for all primary exercise observations."
* ^abstract = true
* subject only Reference(us-core-patient)
* focus ..0
* bodySite ..0
* specimen ..0
* status = #final
* effective[x] 1..1 MS
* effective[x] only dateTime
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* derivedFrom ^slicing.discriminator.type = #pattern
* derivedFrom ^slicing.discriminator.path = "code"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains supportingObs 0..*
* derivedFrom[supportingObs] only Reference(ExerciseSupportGeneric)
* derivedFrom[supportingObs] ^comment = "...While this element is not required to be supported, we encourage
  systems to track supporting observations"
  
Profile:        EVSDaysPerWeek
Parent:         ExerciseBase
Id:             observation-evs-days-per-week
Title:          "Exercise Vital Sign Days per Week"
Description:    "A profile for observations that capture a patient's average days per week of moderate-to-strenuous exercise."
* code = http://loinc.org#89555-7
* valueQuantity.code = #d/wk
  
Profile:        EVSMinutesPerDay
Parent:         ExerciseBase
Id:             observation-evs-min-per-day
Title:          "Exercise Vital Sign Minutes per Day"
Description:    "A profile for observations that capture a patient's average minutes per day of moderate-to-strenuous exercise."
* code = http://loinc.org#68516-4
* valueQuantity.code = #min/d

Profile:        ExerciseMinutesPerWeek
Parent:         ExerciseBase
Id:             observation-min-per-week
Title:          "Exercise Minutes per Week"
Description:    "A profile for observations that capture a patient's average minutes per week of moderate-to-strenuous exercise."
* code = http://loinc.org#82290-8
* valueQuantity.code = #min/wk

Profile:        StrengthDaysPerWeek
Parent:         ExerciseBase
Id:             observation-strength-days-per-week
Title:          "Strength Days Week"
Description:    "A profile for observations that capture a patient's average days per week of muscle-strengthing exercise."
* code = http://loinc.org#82291-6
* valueQuantity.code = #d/wk