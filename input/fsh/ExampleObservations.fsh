Instance:    ExampleEVSDaysPerWeek
InstanceOf:  PAObservationEVSDaysPerWeek
Title:       "Observation - Exercise Vital Sign Days per Week"
Description: "An example observation capturing a patient's average days per week of moderate to vigorous physical exercise."
* insert DaysPerWeek(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 3)

Instance:    ExampleEVSMinutesPerDay
InstanceOf:  PAObservationEVSMinutesPerDay
Title:       "Observation - Exercise Vital Sign Minutes per Day"
Description: "An example observation capturing a patient's average minutes per day of moderate to vigorous physical exercise."
* insert MinPerDay(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 20)
* insert Note(2022-12-15, http://example.org/Patient/1, "Example Patient", [[Felt low-energy for most of month.]])

Instance:    ExampleEVSMinutesPerWeek
InstanceOf:  PAObservationEVSMinutesPerWeek
Title:       "Observation - Exercise Vital Sign Minutes per Week"
Description: "An example observation capturing a patient's average minutes per week of moderate to vigorous physical exercise."
* insert MinPerWeek(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 60)

Instance:    ExampleStrengthDaysPerWeek
InstanceOf:  PAObservationStrengthDaysPerWeek
Title:       "Observation - Exercise Vital Sign Strength Days per Week"
Description: "An example observation capturing a patient's average minutes per day of exercise."
* insert StrengthPerWeek(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 2)

Instance:    ExampleActivityGroup
InstanceOf:  PAObservationActivityGroup
Title:       "Observation - Activity Group"
Description: "An example observation grouping a collection of observations specific to an exercise activity."
* insert ActivityGroup(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08)
* hasMember[+] = Reference(ExampleActivityType)
* hasMember[+] = Reference(ExampleActivityDuration)
* hasMember[+] = Reference(ExampleActivityModerate)
* hasMember[+] = Reference(ExampleActivityVigorous)
* hasMember[+] = Reference(ExampleActivityPeakHR)
* hasMember[+] = Reference(ExampleActivityCalories)

Instance:    ExampleActivityType
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Type"
Description: "An example observation capturing that a patient ran."
* insert ActivityType(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, LA11836-6, "Running")

Instance:    ExampleActivityDuration
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Duration"
Description: "An example observation capturing how long the run was."
* insert ActivityDuration(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 45)

Instance:    ExampleActivityModerate
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Moderate Minutes"
Description: "An example observation capturing how many minutes of running were at moderate exertion level."
* insert ActivityModerate(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 10)

Instance:    ExampleActivityVigorous
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Vigorous Minutes"
Description: "An example observation capturing how many minutes of running were at vigorous exertion level."
* insert ActivityVigorous(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 35)

Instance:    ExampleActivityMeanHR
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation  - Activity Measure - Mean Heart Rate"
Description: "An example observation capturing the patient's average heart rate during their run."
* insert MeanHeartRate(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 150)

Instance:    ExampleActivityPeakHR
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Peak Heart Rate"
Description: "An example observation capturing the patient's peak heart rate during their run."
* insert PeakHeartRate(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 178)

Instance:    ExampleActivityCalories
InstanceOf:  PAObservationActivityMeasure
Title:       "Observation - Activity Measure - Calories"
Description: "An example observation capturing the patient's estimated calorie expenditure during their run."
* insert ActivityCalories(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 738)

// Example time-based
Instance:    ExampleDailySteps
InstanceOf:  PAObservationTimeMeasure
Title:       "Observation - Daily Steps"
Description: "An example observation the total number of steps the patient has taken over the course of a specific day."
* insert DailySteps(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 7267)

Instance:    ExamplePeakDailyHeartRate
InstanceOf:  PAObservationTimeMeasure
Title:       "Observation - Peak Daily Heart Rate"
Description: "An example observation showing the patient's peak heart rate over the course of a day."
* insert DailyPeakHR(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 178)

Instance:    ExampleAverageRestingHeartRate
InstanceOf:  PAObservationTimeMeasure
Title:       "Observation - Average Resting Heart Rate"
Description: "An example observation capturing a patient's average resting heart rate over the course of a week."
* insert RestingHR(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-01, 2022-06-08, 68)

Instance:    ExampleCaloriesPerDay
InstanceOf:  PAObservationTimeMeasure
Title:       "Observation - Calories per Day"
Description: "An example observation capturing a patient's calories burned over the last day."
* insert DailyCalories(http://example.org/Patient/1, "Example Patient", http://example.org/Patient/1, "Example Patient", 2022-06-08, 1561)
