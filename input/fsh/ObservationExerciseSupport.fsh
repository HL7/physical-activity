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
* note MS
* note ^comment = "...Comments allows supporting and qualifying information"


Profile:        ExerciseSupportDailyLog
Parent:         ExerciseSupportGeneric
Id:             observation-sup-daily
Title:          "Daily Exercise Minutes per day log"
Description:    "A profile for observations that capture the number of minutes of moderate to high intensity exercise a 
  patient has performed on a given day."
* code = TemporaryCodes#daily-log
* effective[x] only dateTime
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #min/d


Profile:        ExerciseSupportHeartRate
Parent:         ExerciseSupportGeneric
Id:             observation-sup-hr
Title:          "Average heart rate during exercise period"
Description:    "A profile for observations that capture the average heart rate of a patient during a period of exercise."
* code = http://loinc.org#55425-3
* effective[x] only dateTime or Period
* effectivePeriod.start 1..1 MS
* effectivePeriod.end 1..1 MS
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #/min
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains timeframe 1..1 MS
* component[timeframe] ^short = "Duration"
* component[timeframe] ^definition = "Indicates the duration of the period over which the average heart rate occurred"
* component[timeframe] ^definition = "This is the value that is added to the period of exercise for the day (presuming the heart 
  rate is sufficiently elevated to qualify as moderate to high exertion)."
* component[timeframe].code = http://loinc.org#8838-5
* component[timeframe].value[x] only Quantity
* component[timeframe].valueQuantity.code = #min


Profile:        ExerciseSupportSteps
Parent:         ExerciseSupportGeneric
Id:             observation-sup-steps
Title:          "Total steps during exercise period"
Description:    "A profile for observations that capture the pedometer step count for a patient during a period of exercise."
* code = http://loinc.org#55423-8
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #/min
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains timeframe 1..1 MS
* component[timeframe] ^short = "Duration"
* component[timeframe] ^definition = "Indicates the duration of the period over which the steps were taken"
* component[timeframe] ^definition = "This is the value that is added to the period of exercise for the day (presuming the number 
  of steps within the period are sufficiently high to qualify as moderate to high exertion)."
* component[timeframe].code = http://loinc.org#8838-5
* component[timeframe].value[x] only Quantity
* component[timeframe].valueQuantity.code = #min

