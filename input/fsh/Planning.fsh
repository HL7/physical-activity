Profile:        PARelatedPerson
Parent:         RelatedPerson
Id:             pa-relatedperson
Title:          "PA Related Person"
Description:    "A profile on RelatedPerson that mirrors the requirements of future US Core versions"
* . ^definition = "A profile on RelatedPerson that mirrors the requirements of future US Core versions"
* obeys us-core-14
* implicitRules ..0
* modifierExtension ..0
* active MS
* patient 1..1 MS
* patient only Reference(USCorePatientProfile)
* relationship MS
  * ^condition = us-core-14
  * text 1..1 MS
* name MS
  * ^condition = us-core-14
  * obeys pa-relatedperson-1
  * given MS
  * family MS
* telecom MS
  * system 1..1 MS
  * value 1..1 MS
  * use MS
* address MS
  * line MS
  * city MS
  * state MS
  * postalCode MS

Invariant:   us-core-14
Description: "Either a name or a relationship SHALL be provided (or both)"
Expression:  "name.exists() or relationship.exists()"
Severity:    #error
XPath:       "exists(f:name) or exists(f:relationship)"

Invariant:   pa-relatedperson-1
Description: "At least one of given and family must exist"
Expression:  "given.exists() or family.exists()"
Severity:    #error
XPath:       "exists(f:given) or exists(f:family)"


Profile:        PACarePlan
Parent:         USCoreCarePlanProfile
Id:             pa-careplan
Title:          "PA Care Plan"
Description:    "A plan describing the plan to improve or maintain a patient's level of physical activity"
* . ^definition = "A plan describing the plan to improve or maintain a patient's level of physical activity"
* implicitRules ..0
* modifierExtension ..0
* text.div MS
* intent = #plan
  * ^short = "Plan"
* status ^comment = "In most instances, the 'status' of the CarePlan is expected to be 'active'. However, when the goals of the CarePlan are either achieved or no longer applicable, the status should be updated to 'completed' or 'revoked' respectively. While there are additional statuses available, they might not be universally used across all systems.  Even though source systems are only expected to support 'active' and 'completed', receiving systems must handle the others if present, though they do not need to differentiate additional statues other than 'entered-in-error'."
* period MS
  * start MS
  * end MS
* category 
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = PATemporaryCodes#PhysicalActivity
* note MS
  * author[x] 1..1 MS
  // TODO - add support for PractitionerRole when we move to different US Core
  * author[x] only Reference(USCorePractitionerProfile or USCoreOrganizationProfile or USCorePatientProfile or PARelatedPerson)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
//    * ^type[0].targetProfile[3].extension[$typeMS].valueBoolean = true
  * time 1..1 MS
  * text MS


Invariant:    pa-goal-1
Description:  "Either a description or a target SHALL be provided (or both)"
Expression:   "description.exists() or target.exists()"
Severity:     #error
XPath:        "exists(f:description) or exists(f:target)"

Profile:        PAGoal
Parent:         USCoreGoalProfile
Id:             pa-goal
Title:          "PA Goal"
Description:    "A goal that sets a target for a patient's physical activity level"
* . ^definition = "A goal that sets a target for a patient's physical activity level"
* obeys pa-goal-1
* implicitRules ..0
* modifierExtension ..0
* achievementStatus MS
* category
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* category contains PA 1..1 MS
* category[PA] = PATemporaryCodes#PhysicalActivity
* description.text MS
* target MS
  * modifierExtension ..0
  * measure 0..1 MS
  * measure from PAGoalMeasurement (extensible)
    * ^comment = "... If a target is specified with only a date and no measure, then it is generally indicating a due date for the overall Goal as specified in the description"
  * detailQuantity 1.. MS
    * value MS
    * code MS
    * system MS
    * system ^fixedUri = "http://unitsofmeasure.org"
* addresses MS
  * ^slicing.discriminator.type = #profile
  * ^slicing.discriminator.path = "$this.resolve()"
  * ^slicing.rules = #open
* addresses contains PAIssues 0..* MS
* addresses[PAIssues] only Reference(PAConditionLowPA or PAObservationEVSMinutesPerWeek or PAObservationStrengthDaysPerWeek)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
* note MS
  * author[x] 1..1 MS
  // TODO Add support for PractitionerRole when we move to newer US Core
  * author[x] only Reference(USCorePractitionerProfile or USCoreOrganizationProfile or USCorePatientProfile or PARelatedPerson)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
//    * ^type[0].targetProfile[3].extension[$typeMS].valueBoolean = true
  * time 1..1 MS
  * text MS


Profile:        PAConditionLowPA
Parent:         USCoreCondition
Id:             pa-condition-low-pa
Title:          "PA Condition - Low Physical Activity"
Description:    "A condition that conveys the fact that a patient has a clinically significant and insufficient level of physical activity"
* . ^definition = "A condition that conveys the fact that a patient has a clinically significant and insufficient level of physical activity"
* implicitRules ..0
* modifierExtension ..0
* verificationStatus from PAConditionVerificationStatus (required)
  * ^short = "confirmed | refuted | entered-in-error"
* category 2..*
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
  * ^definition = "Category codes related to the condition. This element is intended to allow inclusion of any of the three codes from the US Core Condition Category codes or other extensibly identified existing concepts. However, in addition to these, a coding instance with the temporary code 'PhysicalActivity' should be included in this category."
* category contains PA 1..1 MS
//* category[PA] from PATemporaryCodesValueSet (required)
* category[PA] = PATemporaryCodes#PhysicalActivity
  * ^short = "Additional category indicating the condition is related to physical activity"
* code = $ICD10#Z72.3 "Lack of physical exercise"
  * ^short = "Lack of physical exercise"
* bodySite 0..0
* onset[x] MS 
* onset[x] only dateTime or Period
  * ^type[0].extension[$typeMS].valueBoolean = true
* abatement[x] MS 
* abatement[x] only dateTime or Period
  * ^type[0].extension[$typeMS].valueBoolean = true
* asserter MS 
* asserter only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
* stage 0..0
* evidence MS
  * modifierExtension ..0
  * detail
    * ^slicing.discriminator.type = #profile
    * ^slicing.discriminator.path = "resolve()"
    * ^slicing.rules = #open
  * detail contains SupportedDetail 0..* MS
  * detail[SupportedDetail] only Reference(PAObservationEVSMinutesPerDay or PAObservationEVSDaysPerWeek or PAObservationEVSMinutesPerWeek or PAObservationStrengthDaysPerWeek)
    * ^comment = "... A variety of resources might provide support for asserting this condition, however at minimum, systems must support the Physical Activity Vital Sign observations."
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true


Invariant: pa-sr-1
Description: "At least one of reasonCode or reasonReference must be provided"
Expression: "reasonCode.exists() or reasonReference.exists()"
Severity: #error
XPath: "exists(f:reasonCode) or exists(f:reasonReference)"


Profile:        PAServiceRequest
Parent:         ServiceRequest
Id:             pa-servicerequest
Title:          "PA Service Request"
Description:    "Represents orders and referrals for interventions that help to improve or maintain a patient's level of physical activity"
* . ^definition = "Represents orders and referrals for interventions that help to improve or maintain a patient's level of physical activity"
* obeys pa-sr-1 
* implicitRules ..0
* modifierExtension ..0
* extension contains 
    $pertainsToGoal named pertainsToGoal 0..* MS and
    $observationFocus named observationFocus 0..1
* extension[pertainsToGoal]
  * ^requirements = "Allows linking a referral or exercise prescription to the goal(s) it's trying to address"
  * valueReference only Reference(PAGoal)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* extension[observationFocus]
  * ^requirements = "Allows referrals seeking services for relatives rather than the patient themselves - e.g. training or counselling for parents of a minor."
  * valueReference only Reference(PARelatedPerson)
* intent MS
* intent from PAServiceRequestIntent
  * ^short   = "original-order | order | filler-order"
  * ^comment = "...Multiple codes are allowed to support situations where a Task might point to a filler order instead of an original.  However, in almost all cases, the intent should be 'original-order' or just 'order'."
* status MS
* status from PAServiceRequestStatus (required)
  * ^short = "draft | active | on-hold | revoked | completed | entered-in-error"
* category 1..*
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* category contains PA 1..1 MS and USCore 0..*
* category[PA] = PATemporaryCodes#PhysicalActivity
* category[USCore] from PAServiceRequestCategory (required)
* priority MS
* doNotPerform ..0
* code 1..1 MS
* code from PAServiceRequestInterventions (extensible)
* subject 1..1 MS 
* subject only Reference(USCorePatientProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* occurrence[x] MS
* occurrence[x] only dateTime or Period or Timing
  * ^type[1].extension[$typeMS].valueBoolean = true
* occurrencePeriod MS
  * start MS
  * end MS
* authoredOn 1..1 MS
* requester 1..1 MS
* requester only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
* performer MS
* performer only Reference(USCorePatientProfile or USCorePractitionerProfile or USCorePractitionerRoleProfile or USCoreOrganizationProfile or PARelatedPerson)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest-or-logical"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[3].extension[$typeMS].valueBoolean = true
* reasonCode MS
* reasonCode from USCoreConditionCode (extensible)
  * text MS
* reasonReference
  * ^slicing.discriminator.type = #profile
  * ^slicing.discriminator.path = "resolve()"
  * ^slicing.rules = #open
* reasonReference contains SupportedReasonReference 0..* MS
* reasonReference[SupportedReasonReference] only Reference(USCoreCondition)
* supportingInfo
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
  * ^slicing.discriminator.type = #profile
  * ^slicing.discriminator.path = "resolve()"
  * ^slicing.rules = #open
* supportingInfo contains SupportedSupportingInfo 0..* MS
* supportingInfo[SupportedSupportingInfo] only Reference(PAObservationEVS)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* specimen 0..0
* note
  * ^short = "Additional details about the service request"
  * ^definition = "This field contains additional details about the service request (for e.g. the appropriate time and mechanism for the service provider to contact the patient). Please note that service providers typically won't see notes that are added once a ServiceRequest has been accepted."
  * author[x] 1..1 MS
  // TODO - add support for PractitionerRole when we move to different US Core
  * author[x] only Reference(USCorePractitionerProfile or USCoreOrganizationProfile)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * time 1..1 MS
  * text MS

Profile:        PADiagnosticReport
Parent:         USCoreDiagnosticReportProfileNoteExchange
Id:             pa-diagnosticreport
Title:          "PA Intervention Report"
Description:    "Conveys a summary of the interventions and patient interactions that have occurred over the course of the services delivered by a Service Provider, typically in response to a referral"
* . ^definition = "Conveys a summary of the interventions and patient interactions that have occurred over the course of the services delivered by a Service Provider, typically in response to a referral"
* implicitRules ..0
* modifierExtension ..0
* basedOn
  * ^slicing.discriminator.type = #profile
  * ^slicing.discriminator.path = "resolve()"
  * ^slicing.rules = #open
* basedOn contains SupportedBasedOn 0..* MS
* basedOn[SupportedBasedOn] only Reference(PAServiceRequest)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* category 1..*
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
  * ^definition = "Category codes related to the service category. This element is intended to allow inclusion of any of the three codes from the US Core Diagnostic report Category codes or other extensibly identified existing concepts. However, in addition to these, a coding instance with the temporary code 'PhysicalActivity' should be included in this category."
* category contains PA 1..1 MS
* category[PA] = PATemporaryCodes#PhysicalActivity
  * ^short = "Additional category indicating that the service category is related to physical activity"
* status from PADiagnosticReportStatus
  * ^short = "partial | preliminary | final | amended | corrected | appended | entered-in-error"
* code from PADiagnosticReportType (extensible)
* encounter ^comment = "... While this is inherited as MustSupport from US Core, this element will typically not be relevant in the physical activity space as most reports will describe events spanning multiple encounters"
* result
  * ^slicing.discriminator.type = #profile
  * ^slicing.discriminator.path = "resolve()"
  * ^slicing.rules = #open
* result contains SupportedResult 0..* MS
* result[SupportedResult] only Reference(PAObservationEVS or PAObservationActivityMeasure or PAObservationTimeMeasure or PAObservationActivityGroup)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[3].extension[$typeMS].valueBoolean = true
* presentedForm
  * obeys pa-dr-1
  * contentType = urn:ietf:bcp:13#application/pdf
    * ^comment = "... Implementers are encouraged to identify additional formats they would like to see supported, if any."
  * data MS
    * ^condition = pa-dr-1
  * url MS
    * ^condition = pa-dr-1

Invariant:   pa-dr-1
Description: "At least one of data and url must be present."
Expression:  "data.exists() or url.exists()"
Severity:    #error
XPath:       "exists(f:data) or exists(f:url)"


Profile:        PATaskForReferralManagement
Parent:         Task
Id:             pa-task-for-referral-management
Title:          "PA Task for Referral Management"
Description:    "Represents a request for fulfillment of a physical activity-related referral or order and supports management of the same."
* . ^definition = "Represents a request for fulfillment of a physical activity-related referral or order and supports management of the same."
* obeys pa-taskrm-1
* implicitRules ..0
* modifierExtension ..0
* intent = #order
* status MS
* status from PATaskFulfillmentStatus (required)
  * ^condition = pa-taskrm-1
* statusReason MS
  * ^condition = pa-taskrm-1
  * text MS
* businessStatus ^comment = "... This may be used to convey more fine-grained status if such tracking
  is supported by the performer (and of interest to the requester).  Support for this element is
  optional."
  * text 1..1 MS
* intent = #order
  * ^short = "order"
* priority MS
* code ..1
* code = http://hl7.org/fhir/CodeSystem/task-code#fulfill
* focus 1..1 MS
* focus only Reference(PAServiceRequest)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* for 1..1 MS
* for only Reference(USCorePatientProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
* authoredOn 1..1 MS
* reasonCode.text 1..1 MS
* note MS
  * author[x] 1..1 MS
  // TODO - add support for PractitionerRole when we move to different US Core
  * author[x] only Reference(USCorePractitionerProfile or USCoreOrganizationProfile)
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
    * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * time 1..1 MS
  * text MS
* requester 1..1 MS
* requester only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile or USCoreOrganizationProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
* owner 1..1 MS
* owner only Reference(USCorePractitionerProfile or USCorePractitionerRoleProfile or USCoreOrganizationProfile)
  * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
  * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[1].extension[$typeMS].valueBoolean = true
  * ^type[0].targetProfile[2].extension[$typeMS].valueBoolean = true
* output
  * ^slicing.discriminator[+].type = #pattern
  * ^slicing.discriminator[=].path = "type"
  * ^slicing.discriminator[+].type = #type
  * ^slicing.discriminator[=].path = "value"
  * ^slicing.rules = #open
  * modifierExtension ..0
* output contains
    PerformedActivityType 0..* MS and
    PerformedActivityReference 0..* MS
* output[PerformedActivityType]
  * modifierExtension ..0
  * type = $SDOHCC-Temp#resulting-activity
  * value[x] MS
  * value[x] only CodeableConcept
    * ^type[0].extension[$typeMS].valueBoolean = true
  * valueCodeableConcept MS
  * valueCodeableConcept.text 1..1 MS
* output[PerformedActivityReference]
  * modifierExtension ..0
  * type = $SDOHCC-Temp#resulting-activity
  * value[x] MS
  * value[x] only Reference(PADiagnosticReport or Resource)
    * ^type[0].extension[$typeMS].valueBoolean = true
    * ^type[0].profile[0] = "http://hl7.org/fhir/us/physical-activity/StructureDefinition/reference-rest"
    * ^type[0].targetProfile[0].extension[$typeMS].valueBoolean = true
  * valueReference MS
    * ^comment = "This element MAY resolve to a contained resource in situations where the resulting report is not available from a stand-alone endpoint"

Invariant:   pa-taskrm-1
Description: "Task.statusReason is required if Task.status is 'rejected', 'on-hold', 'cancelled', or 'failed' and is not permitted otherwise."
Expression:  "statusReason.exists() = (status='rejected' or status='on-hold' or status='cancelled' or status='failed')"
Severity:    #error
XPath:       "exists(f:statusReason) = (f:status/@value=('rejected', 'on-hold', 'cancelled', 'failed'))"
