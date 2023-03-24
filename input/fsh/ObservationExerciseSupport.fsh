Profile:        PAObservationBase
Parent:         http://hl7.org/fhir/us/sdoh-clinicalcare/StructureDefinition/SDOHCC-ObservationAssessment
Id:             pa-observation-base
Title:          "Physical Activity Base Observation"
Description:    "A profile describing base requirements for all primary physical activity observations."
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
* value[x] only CodeableConcept or Quantity
* valueCodeableConcept 0..1
* valueQuantity 0..1
* valueQuantity.value 1..1 MS
* valueQuantity.system = "http://unitsofmeasure.org"
* note MS
* note ^comment = "...Comments allows supporting and qualifying information"
* note.author[x] 1..1 MS
* note.author[x] only Reference(Practitioner or Patient or RelatedPerson)
* note.author[x] ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
* note.author[x] ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
* note.time 1..1 MS
* note.text MS


Profile:        PAActivityMeasure
Parent:         PAObservationBase
Id:             pa-activity-measure
Title:          "Physical Activity Measure - Activity-based"
Description:    "A profile for observations that capture physical activity-related measures that are specific to a single
  physical activity."
* code from PAActivityMeasures (extensible)
* effective[x] ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used
    to indicate the specific start and end times."
* effective[x] ^type[0].extension[$typeMS].valueBoolean = true
* value[x] only Quantity or CodeableConcept
* value[x] ^comment = "...The value **SHALL** be constrained to the type and unit or ValueSet as indicated in [the table](measures.html#activity)"


Profile:        PAActivityGroup
Parent:         PAObservationBase
Id:             pa-activity-group
Title:          "Physical Activity Observation Group"
Description:    "A profile for observations that collect a set of activity-related measures that all pertain to the same physical activity instance."
* code = TemporaryCodes#PAPanel
* effective[x] ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used
    to indicate the specific start and end times.  It **SHOULD** be the same as the effective[x] value for all member Observations."
* effective[x] ^type[1].extension[$typeMS].valueBoolean = true
* value[x] 0..0
* hasMember 1..* 
* hasMember only Reference(PAActivityMeasure)


Profile:        PATimeMeasure
Parent:         PAObservationBase
Id:             pa-time-measure
Title:          "Physical Activity Measure - Time-based"
Description:    "A profile for observations that capture physical activity-related measures that apply over an extended period of time,
  such as a day or week."
* code from PATimeMeasures (extensible)
* value[x] only Quantity
* value[x] ^comment = "...The value **SHALL** be constrained to the unit as indicated in [the table](measures.html#time)"
* effective[x] ^type[0].extension[$typeMS].valueBoolean = true
* effective[x] ^type[1].extension[$typeMS].valueBoolean = true
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
