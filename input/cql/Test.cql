library Test version '0.1.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

parameter "Measurement Period" Interval<DateTime> default Interval[@2023-01-01T00:00:00.0Z, @2023-12-31T23:59:59.999Z]

context Patient

define "Initial Population":
  AgeInYearsAt(start of "Measurement Period") in Interval[6, 75]

define "Denominator":
  true

define "Numerator":
  false