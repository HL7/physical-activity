Instance:       ExampleEVSDaysPerWeek
InstanceOf:     EVSDaysPerWeek
Title:          "Example Exercise Vital Sign Days per Week"
Description:    "An example observation capturing a patient's average days per week of moderate to vigorous physical exercise."
* subject	          = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity     = 3 'd/wk' "days per week"

Instance:       ExampleEVSMinutesPerDay
InstanceOf:     EVSMinutesPerDay
Title:          "Example Exercise Vital Sign Minutes per Day"
Description: 	  "An example observation capturing a patient's average minutes per day of moderate to vigorous physical exercise."
* subject	          = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity     = 20 'min/d' "minutes per day"

Instance:    ExampleEVSMinutesPerWeek
InstanceOf:  EVSMinutesPerWeek
Title:       "Example Exercise Minutes per Week"
Description: "An example observation capturing a patient's average minutes per week of moderate to vigorous physical exercise."
* subject	          = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity     = 70 'min/wk' "minutes per week"

Instance:    ExampleStrengthDaysPerWeek
InstanceOf:  StrengthDaysPerWeek
Title:       "Example Strength Exercise Days per Week"
Description: "An example observation capturing a patient's average minutes per day of exercise."
* subject           = Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity     = 2 'd/wk' "days per week"
