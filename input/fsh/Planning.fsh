Alias: $pertainsToGoal = http://hl7.org/fhir/StructureDefinition/resource-pertainsToGoal
Alias: $SDOHCCTemp     = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes
Alias: $ICD10          = http://hl7.org/fhir/sid/icd-10-cm

Profile:        PACarePlan
Parent:         USCoreCarePlanProfile
Id:             pa-careplan
Title:          "Physical Activity Care Plan"
Description:    "A plan describing the plan to improve or maintain a patient's level of physical activity"
* intent = #plan
* period MS
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
* category ^slicing.discriminator.type = #pattern
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
Title:          "Low Physical Activity Condition"
Description:    "A condition that conveys the fact that a patient has a clinically significant and 
  insufficient level of physical activity"
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = TemporaryCodes#PhysicalActivity
* code = $ICD10#Z72.3 "Lack of physical exercise"
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
* evidence.detail ^slicing.discriminator.path = "resolve()"
* evidence.detail ^slicing.rules = #open
* evidence.detail contains SupportedDetail 0..* MS
* evidence.detail[SupportedDetail] only Reference(EVSMinutesPerDay or EVSDaysPerWeek)
* evidence.detail[SupportedDetail] ^comment = "... A variety of resources might provide support for 
  asserting this condition, however at minimum, systems must support the two Exercise Vital Sign 
  observations."


Profile:        PAServiceRequest
Parent:         ServiceRequest
Id:             pa-servicerequest
Title:          "Physical Activity Service Request"
Description:    "Represents orders and referrals for interventions that help to improve or maintain
  a patient's level of physical activity"
* extension contains $pertainsToGoal named pertainsToGoal 0..* MS
* extension[pertainsToGoal].valueReference only Reference(PAGoal)
* status MS
* intent MS
* intent ^comment = "... In most cases, this will be Order.  However, in some cases a service
  delivery provider might create a 'proposed' ServiceRequest or a 'filler' or other type."
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains PA 1..1 MS and USCore 1..1
* category[PA] = TemporaryCodes#PhysicalActivity
* category[USCore] from USCorePAServiceRequestCategory (extensible)
* priority MS
* code 1..1 MS
* code from PAInterventions (extensible)
* subject 1..1 MS
* subject only Reference(USCorePatientProfile)
// TODO add support for 'focus'
* occurrence[x] MS
* occurrencePeriod MS
* authoredOn 0..1 MS
* requester MS
* requester only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile or 
  USCoreOrganizationProfile)
* performer MS
* performer only Reference(HealthcareService or RelatedPerson or USCorePatientProfile or
  USCorePractitionerProfile or USCorePractitionerRoleProfile or USCoreOrganizationProfile or 
  USCoreCareTeam)
* reasonReference ^slicing.discriminator.type = #profile
* reasonReference ^slicing.discriminator.path = "resolve()"
* reasonReference ^slicing.rules = #open
* reasonReference contains SupportedReasonReference 0..* MS
* reasonReference[SupportedReasonReference] only Reference(LowPACondition)
* supportingInfo ^slicing.discriminator.type = #profile
* supportingInfo ^slicing.discriminator.path = "resolve()"
* supportingInfo ^slicing.rules = #open
* supportingInfo contains SupportedSupportingInfo 0..* MS
* supportingInfo[SupportedSupportingInfo] only Reference(SDOHCCConsent)
* specimen 0..0


Profile:        PADiagnosticReport
Parent:         USCoreDiagnosticReportProfileNoteExchange
Id:             pa-diagnosticreport
Title:          "Physical Activity Intervention Report"
Description:    "Conveys a summary of the interventions and patient interactions that have occurred over the
course of the services delivered by a Service Provider, typically in response to a referral"
* basedOn ^slicing.discriminator.type = #profile
* basedOn ^slicing.discriminator.path = "resolve()"
* basedOn ^slicing.rules = #open
* basedOn contains SupportedBasedOn 0..* MS
* basedOn[SupportedBasedOn] only Reference(PAServiceRequest)
//* category contains PAProcedure 1..1 MS
//* category[PAProcedure] = TemporaryCodes#PhysicalActivity
* code from PAReports (extensible)
* encounter ^comment = "... While this is inherited as MustSupport from US Core, this element will typically
  not be relevant in the physical activity space as most reports will describe events spanning multiple
  encounters"
* result ^slicing.discriminator.type = #profile
* result ^slicing.discriminator.path = "resolve()"
* result ^slicing.rules = #open
* result contains SupportedResult 0..* MS
* result[SupportedResult] only Reference(EVS or ActivityMeasure or TimeMeasure or ActivityGroup)
* presentedForm.contentType = urn:ietf:bcp:13#application/pdf
* presentedForm.contentType ^comment = "... Implementers are encouraged to identify additional formats they would
  like to see supported, if any."


Profile:        PATaskForReferralManagement
Parent:         Task
Id:             pa-task-for-referral-management
Title:          "Physical Activity Task for Referral Management"
Description:    "Represents a request for fufillment of a physical activity-related referral or
  order and supports management of the same."
* status MS
* statusReason MS
  * text MS
* businessStatus ^comment = "... This may be used to convey more fine-grained status if such tracking
  is supported by the performer (and of interest to the requester).  Support for this element is
  optional."
  * text 1..1 MS
* intent = #order
* priority MS
* code = http://hl7.org/fhir/CodeSystem/task-code#fulfill
* focus 1..1 MS
* focus only Reference(PAServiceRequest)
* for 1..1 MS
* for only Reference(USCorePatientProfile)
* authoredOn 1..1 MS
* owner MS
* owner only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile or
  USCoreOrganizationProfile)
* output ^slicing.discriminator[+].type = #pattern
* output ^slicing.discriminator[=].path = "type"
* output ^slicing.discriminator[+].type = #type
* output ^slicing.discriminator[=].path = "value"
* output ^slicing.rules = #open
* output contains PerformedActivity 0..* MS
* output[PerformedActivity]
  * type = $SDOHCCTemp#resulting-activity
  * value[x] MS
  * value[x] only Reference or CodeableConcept
