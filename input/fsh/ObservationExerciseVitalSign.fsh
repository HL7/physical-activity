Profile:        PAObservationEVS
Parent:         PAObservationBase
Id:             pa-observation-evs
Title:          "PA Vital Sign Observation"
Description:    "A generic profile that encapsulates all of the physical activity vital sign observations."
* ^abstract = true
* . ^definition = "A generic profile that encapsulates all of the physical activity vital sign observations."
* code from PAObservationCodeEVS (required)
* effective[x] only dateTime
* effectivePeriod ..0
* value[x] only Quantity
* valueCodeableConcept ..0
* derivedFrom
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "code"
  * ^slicing.rules = #open
* derivedFrom contains supportingObs 0..*
* derivedFrom[supportingObs] only Reference(PAObservationBase)
  * ^comment = "...While this element is not required to be supported, we encourage systems to track supporting observations"

Profile:        PAObservationEVSDaysPerWeek
Parent:         PAObservationEVS
Id:             pa-observation-evs-days-per-week
Title:          "PA Vital Sign Days per Week"
Description:    "A profile for observations that capture a patient's average days per week of moderate-to-vigorous physical activity."
* . ^definition = "A profile for observations that capture a patient's average days per week of moderate-to-vigorous physical activity."
* code = $loinc#89555-7
* valueQuantity.code = #d/wk
  
Profile:        PAObservationEVSMinutesPerDay
Parent:         PAObservationEVS
Id:             pa-observation-evs-min-per-day
Title:          "PA Vital Sign Minutes per Day"
Description:    "A profile for observations that capture a patient's average minutes per day of moderate-to-vigorous physical activity."
* . ^definition = "A profile for observations that capture a patient's average minutes per day of moderate-to-vigorous physical activity."
* code = $loinc#68516-4
* valueQuantity.code = #min/d

Profile:        PAObservationEVSMinutesPerWeek
Parent:         PAObservationEVS
Id:             pa-observation-evs-min-per-week
Title:          "PA Vital Sign Minutes per Week"
Description:    "A profile for observations that capture a patient's average minutes per week of moderate-to-vigorous physical activity."
* . ^definition = "A profile for observations that capture a patient's average minutes per week of moderate-to-vigorous physical activity."
* code = $loinc#82290-8
* valueQuantity.code = #min/wk

Profile:        PAObservationStrengthDaysPerWeek
Parent:         PAObservationEVS
Id:             pa-observation-strength-days-per-week
Title:          "PA Strength Days Week"
Description:    "A profile for observations that capture a patient's average days per week of muscle-strengthing physical activity."
* . ^definition = "A profile for observations that capture a patient's average days per week of muscle-strengthing physical activity."
* code = $loinc#82291-6
* valueQuantity.code = #d/wk