Instance: 			ExampleEVSDaysPerWeek
InstanceOf: 		EVSDaysPerWeek
Title: 				"Example Exercise Vital Sign Days per Week"
Description: 		"An example observation capturing a patient's average days per week of exercise."
* subject			= Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity 	= 3 'd/wk' "days per week"

Instance: 			ExampleEVSMinutesPerDay
InstanceOf: 		EVSMinutesPerDay
Title: 				"Example Exercise Vital Sign Minutes per Day"
Description: 		"An example observation capturing a patient's average minutes per day of exercise."
* subject			= Reference(http://example.org/Patient/1)
* effectiveDateTime = "2022-06-08"
* valueQuantity 	= 20 'min/d' "minutes per day"
