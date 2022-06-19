Profile:        EVSDaysPerWeek
Parent:         http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-ObservationAssessment
Id:             observation-evs-days-per-week
Title:          "Exercise Vital Sign Days per Week"
Description:    "A profile for observations that capture a patient's average days per week of exercise."
* subject only Reference(us-core-patient)
* focus ..0
* bodySite ..0
* specimen ..0
* status = #final
* effective[x] 1..1 MS
* effective[x] only dateTime
* code = http://loinc.org#89555-7
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #d/wk
* derivedFrom ^slicing.discriminator.type = #pattern
* derivedFrom ^slicing.discriminator.path = "code"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains supportingObs 0..*
* derivedFrom[supportingObs] only Reference(ExerciseSupportGeneric)
* derivedFrom[supportingObs] ^comment = "...While this element is not required to be supported, we encourage
  systems to track supporting observations"
  

Profile:        EVSMinutesPerDay
Parent:         http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-ObservationAssessment
Id:             observation-evs-min-per-day
Title:          "Exercise Vital Sign Minutes per Day"
Description:    "A profile for observations that capture a patient's average minutes per day of exercise."
* subject only Reference(us-core-patient)
* focus ..0
* bodySite ..0
* specimen ..0
* status = #final
* effective[x] 1..1 MS
* effective[x] only dateTime
* code = http://loinc.org#68516-4
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #min/d
* derivedFrom ^slicing.discriminator.type = #pattern
* derivedFrom ^slicing.discriminator.path = "code"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains supportingObs 0..*
* derivedFrom[supportingObs] only Reference(ExerciseSupportGeneric)
* derivedFrom[supportingObs] ^comment = "...While this element is not required to be supported, we encourage
  systems to track supporting observations"
