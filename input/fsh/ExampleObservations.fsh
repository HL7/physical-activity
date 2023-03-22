Instance:    ExampleEVSDaysPerWeek
InstanceOf:  EVSDaysPerWeek
Title:       "Example Observation Exercise Vital Sign Days per Week"
Description: "An example observation capturing a patient's average days per week of moderate to vigorous physical exercise."
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 3 'd/wk' "days per week"

Instance:    ExampleEVSMinutesPerDay
InstanceOf:  EVSMinutesPerDay
Title:       "Example Observation Exercise Vital Sign Minutes per Day"
Description: "An example observation capturing a patient's average minutes per day of moderate to vigorous physical exercise."
* subject	          = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 20 'min/d' "minutes per day"
* note
  * authorReference   = Reference(http://example.org/PractitionerRole/1)
  * time              = 2022-12-15
  * text              = "Felt low-energy for most of month."

Instance:    ExampleEVSMinutesPerWeek
InstanceOf:  EVSMinutesPerWeek
Title:       "Example Observation Exercise Minutes per Week"
Description: "An example observation capturing a patient's average minutes per week of moderate to vigorous physical exercise."
* subject	          = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 70 'min/wk' "minutes per week"

Instance:    ExampleStrengthDaysPerWeek
InstanceOf:  StrengthDaysPerWeek
Title:       "Example Observation Strength Exercise Days per Week"
Description: "An example observation capturing a patient's average minutes per day of exercise."
* subject           = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 2 'd/wk' "days per week"

Instance:    ExampleActivityGroup
InstanceOf:  PAActivityGroup
Title:       "Example Observation Exercise Minutes per Week"
Description: "An example observation capturing information about a specific patient exercise activity."
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* hasMember[+]      = Reference(ExampleActivityType)
* hasMember[+]      = Reference(ExampleActivityDuration)
* hasMember[+]      = Reference(ExampleActivityModerate)
* hasMember[+]      = Reference(ExampleActivityVigorous)
* hasMember[+]      = Reference(ExampleActivityPeakHR)
* hasMember[+]      = Reference(ExampleActivityCalories)


Instance:    ExampleActivityType
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Activity"
Description: "An example observation capturing that a patient ran."
* code                 = $loinc#73985-4 "Exercise Activity"
* subject	           = Reference(http://example.org/Patient/1)
* effectiveDateTime    = "2022-06-08"
* performer            = Reference(http://example.org/Patient/1)
* valueCodeableConcept = $loinc#LA11836-6 "Running"

Instance:    ExampleActivityDuration
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Activity duration"
Description: "An example observation capturing how long the run was."
* code              = $loinc#55411-3 "Exercise duration"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 45 'min'

Instance:    ExampleActivityModerate
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Moderate Minutes"
Description: "An example observation capturing how many minutes of running were at moderate exertion level."
* code              = $loinc#77592-4 "Moderate physical activity [IPAQ]"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 10 'min'

Instance:    ExampleActivityVigorous
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Vigorous Minutes"
Description: "An example observation capturing how many minutes of running were at vigorous exertion level."
* code              = $loinc#77593-2 "Vigorous physical activity [IPAQ]"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 35 'min'

Instance:    ExampleActivityPeakHR
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Peak Heart Rate"
Description: "An example observation capturing the patient's peak heart rate during their run."
* code              = $loinc#55422-0 "Heart rate Encounter maximum"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 178 '/min'

Instance:    ExampleActivityCalories
InstanceOf:  PAActivityMeasure
Title:       "Example Observation Activity Measure - Calories"
Description: "An example observation capturing the patient's estimated calorie expenditure during their run."
* code              = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 738 'kcal'


Instance:    ExampleDailySteps
InstanceOf:  PATimeMeasure
Title:       "Example Observation Daily Steps"
Description: "An example observation the total number of steps the patient has taken over the course of a specific day."
* code              = $loinc#41950-7 "Number of steps in 24 hour Measured"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 7267 '/d'

Instance:    ExamplePeakDailyHeartRate
InstanceOf:  PATimeMeasure
Title:       "Example Observation Peak Daily Heart Rate"
Description: "An example observation showing the patient's peak heart rate over the course of a day."
* code              = $loinc#8873-2 "Heart rate 24 hour maximum"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 178 '/min'

Instance:    ExampleAverageRestingHeartRate
InstanceOf:  PATimeMeasure
Title:       "Example Observation Average Resting Heart Rate"
Description: "An example observation capturing a patient's average resting heart rate over the course of a week."
* code              = $loinc#40443-4 "Heart rate Resting"
* subject	        = Reference(http://example.org/Patient/1)
* effectivePeriod
  * start           = "2022-06-01"
  * end             = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 68 '/min'

Instance:    ExampleCaloriesPerDay
InstanceOf:  PATimeMeasure
Title:       "Example Observation Calories per Day"
Description: "An example observation capturing a patient's calories burned over the last day."
* code              = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* subject	        = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* performer         = Reference(http://example.org/Patient/1)
* valueQuantity     = 1561 'kcal'
