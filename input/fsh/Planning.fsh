Profile:        PACarePlan
Parent:         USCoreCarePlanProfile
Id:             pa-careplan
Title:          "Physical Activity Care Plan"
Description:    "A plan describing the plan to improve or maintain a patient's level of physical activity"
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = TemporaryCodes#PhysicalActivity


Profile:        PAGoal
Parent:         USCoreGoalProfile
Id:             pa-goal
Title:          "Physical Activity-Related Goal"
Description:    "A goal that sets a target for a patient's physical activity level"
* achievementStatus MS
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = TemporaryCodes#PhysicalActivity
* target MS
* target.measure 0..1 MS
* target.measure from ValueSetEVS (extensible)
* target.measure ^comment = "... If a target is specified with only a date and no measure, then it 
  is generally indicating a due date for the overall Goal as specified in the description"
* target.detailQuantity MS
* addresses ^slicing.discriminator.type = #profile
* addresses ^slicing.discriminator.path = "$this"
* addresses ^slicing.rules = #open
* addresses contains SupportedAddresses 0..* MS
* addresses[SupportedAddresses] only Reference(LowPACondition or EVSDaysPerWeek or EVSMinutesPerDay)


Profile:        LowPACondition
Parent:         USCoreCondition
Id:             pa-condition
Title:          "Low Physical Actity Condition"
Description:    "A condition that conveys the fact that a patient has a clinically significant and 
  insufficient level of physical activity"
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = TemporaryCodes#PhysicalActivity
* code = TemporaryCodes#LowActivity
* bodySite 0..0
* onset[x] MS 
* onset[x] only dateTime or Period
* abatement[x] MS 
* abatement[x] only dateTime or Period
* asserter MS 
* asserter only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile)
* stage 0..0
* evidence MS
* evidence.detail ^slicing.discriminator.type = #profile
* evidence.detail ^slicing.discriminator.path = "$this"
* evidence.detail ^slicing.rules = #open
* evidence.detail contains SupportedDetail 0..* MS
* evidence.detail[SupportedDetail] only Reference(EVSMinutesPerDay or EVSDaysPerWeek)
* evidence.detail[SupportedDetail] ^comment = "... A variety of resources might provide support for 
  asserting this condition, however at minimum, systems must support the two Exercise Vital Sign 
  observations."