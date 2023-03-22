Profile:        EVS
Parent:         PAObservationBase
Id:             observation-evs
Title:          "Physical Activity Vital Sign Observation"
Description:    "A generic profile that encapsulates all of the physical activity vital sign observations."
* ^abstract = true
* code from ValueSetEVS (required)
* effective[x] only dateTime
* value[x] only Quantity
* derivedFrom ^slicing.discriminator.type = #pattern
* derivedFrom ^slicing.discriminator.path = "code"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains supportingObs 0..*
* derivedFrom[supportingObs] only Reference(PAObservationBase)
* derivedFrom[supportingObs] ^comment = "...While this element is not required to be supported, we encourage
  systems to track supporting observations"

Profile:        EVSDaysPerWeek
Parent:         EVS
Id:             observation-evs-days-per-week
Title:          "Physical Activity Vital Sign Days per Week"
Description:    "A profile for observations that capture a patient's average days per week of moderate-to-vigorous physical activity."
* code = $loinc#89555-7
* valueQuantity.code = #d/wk
  
Profile:        EVSMinutesPerDay
Parent:         EVS
Id:             observation-evs-min-per-day
Title:          "Physical Activity Vital Sign Minutes per Day"
Description:    "A profile for observations that capture a patient's average minutes per day of moderate-to-vigorous physical activity."
* code = $loinc#68516-4
* valueQuantity.code = #min/d

Profile:        EVSMinutesPerWeek
Parent:         EVS
Id:             observation-evs-min-per-week
Title:          "Physical Activity Vital Sign Minutes per Week"
Description:    "A profile for observations that capture a patient's average minutes per week of moderate-to-vigorous physical activity."
* code = $loinc#82290-8
* valueQuantity.code = #min/wk

Profile:        StrengthDaysPerWeek
Parent:         EVS
Id:             observation-strength-days-per-week
Title:          "Physical Activity Strength Days Week"
Description:    "A profile for observations that capture a patient's average days per week of muscle-strengthing physical activity."
* code = $loinc#82291-6
* valueQuantity.code = #d/wk