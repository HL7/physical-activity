Profile:        PAObservationBase
Parent:         Observation
Id:             pa-observation-base
Title:          "PA Base Observation"
Description:    "A profile describing base requirements for all primary physical activity observations."
* ^abstract = true
* . ^definition = "A profile describing base requirements for all primary physical activity observations."
* implicitRules ..0
* modifierExtension ..0
* status MS
* status from ObservationStatus
  * ^short = "final | amended | corrected | entered-in-error"
  * ^comment = "In the vast majority of cases, the status value will be 'final'.  Systems are not expected to distinguish amended and corrected results."
* category
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* category contains SocialHistory 1..1 MS and PhysicalActivity 0..1
* category[SocialHistory] = $obsCategory#social-history
* category[PhysicalActivity] = PATemporaryCodes#PhysicalActivity
* code 1..1 MS 
* code from LOINCCodes (preferred)
* subject 1..1 MS
* subject only Reference(us-core-patient)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* focus ..0
* bodySite ..0
* specimen ..0
* effective[x] 1..1 MS
* effective[x] only dateTime or Period
* effectiveDateTime ^extension[$minLength].valueInteger = 10
//* effectiveDateTime ^extension[$typeMS].valueBoolean = true
* effectivePeriod.start 1..1 MS
  * ^extension[$minLength].valueInteger = 10
* effectivePeriod.end 1..1 MS
  * ^extension[$minLength].valueInteger = 10
* performer MS
* performer only Reference(USCorePatientProfile or USCorePractitionerProfile or USCorePractitionerRoleProfile or RelatedPerson)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
* value[x] MS
* value[x] only CodeableConcept or Quantity
* valueCodeableConcept 0..1
* valueQuantity 0..1
* valueQuantity only SimpleQuantity
  * value 1..1 MS
  * system = "http://unitsofmeasure.org"
  * code 1..1 MS
* note MS
  * ^comment = "...Comments allows supporting and qualifying information"
  * author[x] 1..1 MS
  * author[x] only Reference(Practitioner or Patient or RelatedPerson)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * time 1..1 MS
  * text MS


Profile:        PAObservationActivityMeasure
Parent:         PAObservationBase
Id:             pa-observation-activity-measure
Title:          "PA Observation - Activity-based"
Description:    "A profile for observations that capture physical activity-related measures that are specific to a single
  physical activity."
* . ^definition = "A profile for observations that capture physical activity-related measures that are specific to a single physical activity."
* code from PAObservationActivityMeasures (extensible)
* effective[x]
  * ^type[0].extension[$typeMS].valueBoolean = true
  * ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used to indicate the specific start and end times."
* value[x] ^comment = "...The value **SHALL** be constrained to the type and unit or ValueSet as indicated in [the table](measures.html#activity)"


Profile:        PAObservationActivityGroup
Parent:         PAObservationBase
Id:             pa-observation-activity-group
Title:          "PA Observation Activity Group"
Description:    "A profile for observations that collects a set of activity-related measures that all pertain to the same physical activity instance."
* . ^definition = "A profile for observations that collects a set of activity-related measures that all pertain to the same physical activity instance."
* code = PATemporaryCodes#PAPanel
* effective[x]
  * ^type[0].extension[$typeMS].valueBoolean = true
  * ^comment = "...This will typically be a dateTime specific to the day.  If the information is available, a Period can be used to indicate the specific start and end times.  It **SHOULD** be the same as the effective[x] value for all member Observations."
* value[x] ..0
* hasMember 1..* MS
* hasMember only Reference(PAObservationActivityMeasure)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"


Profile:        PAObservationTimeMeasure
Parent:         PAObservationBase
Id:             pa-observation-time-measure
Title:          "PA Measure - Time-based"
Description:    "A profile for observations that capture physical activity-related measures that apply over an extended period of time, such as a day or week."
* . ^definition = "A profile for observations that capture physical activity-related measures that apply over an extended period of time, such as a day or week."
* code from PAObservationTimeMeasures (extensible)
* value[x] only Quantity
  * ^comment = "...The value **SHALL** be constrained to the unit as indicated in [the table](measures.html#time)"
* valueCodeableConcept ..0
* effective[x]
  * ^type[0].extension[$typeMS].valueBoolean = true
  * ^type[1].extension[$typeMS].valueBoolean = true
* component
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "code"
  * ^slicing.rules = #open
* component contains percentActive 0..1 MS
* component[percentActive]
  * code = PATemporaryCodes#DeviceActivePercentage
  * value[x] only Quantity
  * valueQuantity
    * system = "http://unitsofmeasure.org"
    * code = #%
    * value 1..1 MS
