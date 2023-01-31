Alias: $loinc     = http://loinc.org
Alias: $minLength = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $typeMS    = http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support

Profile:        ExerciseSupportGeneric
Parent:         http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-ObservationAssessment
Id:             observation-support
Title:          "Exercise Supporting Observation"
Description:    "An abstract observation profile that serves as the parent for various supporting observations related to exercise"
* ^abstract = true
* subject only Reference(us-core-patient)
* focus ..0
* bodySite ..0
* specimen ..0
* status = #final
* effective[x] 1..1 MS 
* effective[x] only dateTime or Period
* effectiveDateTime ^extension[$minLength].valueInteger = 10
//* effectiveDateTime ^extension[$typeMS].valueBoolean = true
* effectivePeriod.start 1..1 MS
* effectivePeriod.start ^extension[$minLength].valueInteger = 10
* effectivePeriod.end 1..1 MS
* effectivePeriod.end ^extension[$minLength].valueInteger = 10
* valueQuantity.value 1..1 MS
* valueQuantity.system = "http://unitsofmeasure.org"
* note MS
* note ^comment = "...Comments allows supporting and qualifying information"


Profile:        ActivityMeasure
Parent:         ExerciseSupportGeneric
Id:             pa-activity-measure
Title:          "Activity-based Physical Activity Measure"
Description:    "A profile for observations that capture physical activity-related measures that are specific to a single
  exercise activity."
* code from PAActivityMeasures (extensible)
* effective[x] ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used
    to indicate the specific start and end times."
* value[x] only Quantity or CodeableConcept
* value[x] ^comment = "...The value **SHALL** be constrained to the type and unit or ValueSet as indicated in [the table](measures.html#activity)"


Profile:        ActivityGroup
Parent:         ExerciseSupportGeneric
Id:             pa-activity-group
Title:          "Physical Activity Group"
Description:    "A profile for observations that collect a set of activity-related measures that all pertain to the same exercise instance."
* code = TemporaryCodes#ExercisePanel
* effective[x] ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used
    to indicate the specific start and end times.  It **SHOULD** be the same as the effective[x] value for all member Observations."
* value[x] 0..0
* hasMember 1..* 
* hasMember only Reference(ActivityMeasure)


Profile:        TimeMeasure
Parent:         ExerciseSupportGeneric
Id:             pa-time-measure
Title:          "Time-based Physical Activity Measure"
Description:    "A profile for observations that capture physical activity-related measures that apply over an extended period of time,
  such as a day or week."
* code from PATimeMeasures (extensible)
* effectiveDateTime ^maxLength = 10
* effectivePeriod.start ^maxLength = 10
* effectivePeriod.end ^maxLength = 10
* value[x] only Quantity
* value[x] ^comment = "...The value **SHALL** be constrained to the unit as indicated in [the table](measures.html#time)"
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    percentActive 0..1 MS
* component[percentActive].code = TemporaryCodes#DeviceActivePercentage
* component[percentActive].value[x] only Quantity
* component[percentActive].valueQuantity.system = "http://unitsofmeasure.org"
* component[percentActive].valueQuantity.code = #%
* component[percentActive].valueQuantity.value 1..1 MS
