CodeSystem:     PATemporaryCodes
Id:             pa-temporary-codes
Title:          "Temporary Codes"
Description:    "Codes that will eventually be proposed for LOINC or other code systems, but which 
  do not yet exist in 'official' code systems"
* ^caseSensitive = true
* ^hierarchyMeaning = #is-a
* ^experimental  = false
* ^property[+].code = #notSelectable
* ^property[=].uri = "http://hl7.org/fhir/concept-properties#notSelectable"
* ^property[=].type = #boolean
* #PhysicalActivity       "Physical Activity"              "A category assigned to resources pertaining to evaluating, improving or sustaining a patient's level of physical activity."
* #PAPanel                "Physical Activity Panel"        "A panel observation intended to group measures related to a specific occurrence of physical activity."
* #DeviceActivePercentage "Device Active Percentage"       "Indicates the percentage of the overall time associated with an aggregate or average measure that the device capturing the raw data used to calculate the sum or average was enabled and available to take measurements.  For example, if a pedometer capturing steps was only worn for 2 hours when calculating a daily step count, the percentage would be 2/24 - or 8%."
* #PAConsultNote          "Physical activity Consult note" "A consult note that describes assessments and interventions related to a patient's level of physical activity."
* #Experience             "Experience of Activity"         "Indicates how the performer felt during the activity"
* #_experienceCode        "Experience codes"               "Codes used to evaluate a performer's experience"
* #_experienceCode ^property[+].code = #notSelectable
* #_experienceCode ^property[=].valueBoolean = true
  * #-5                   "Very Bad"
  * #-4
  * #-3                   "Bad"
  * #-2
  * #-1                   "Fairly Bad"
  * #0                    "Neutral"
  * #1                    "Fairly Good"
  * #2
  * #3                    "Good"
  * #4
  * #5                    "Very Good"

ValueSet:      PAFeelingScale
Id:            pa-feeling-scale
Title:         "PA Observation Activity Feeling Scale"
Description:   "Codes to express the 'experience' of a physical activity."
* ^experimental = false
* include codes from system PATemporaryCodes where concept is-a #_experienceCode
* $obsStatus#final
* $obsStatus#amended
* $obsStatus#corrected
* $obsStatus#entered-in-error

ValueSet:      PAObservationStatus
Id:            pa-observation-status
Title:         "PA Observation Statuses"
Description:   "Codes for Observation.status for Observations that are appropriate for exchange for physical activity purposes.  Excludes non-completed and unknown-status Observations.  Entered-in-error is retained to allow correction of previously shared results that should not have existed."
* ^experimental = false
* $obsStatus#final
* $obsStatus#amended
* $obsStatus#corrected
* $obsStatus#entered-in-error

ValueSet:      PAConditionVerificationStatus
Id:            pa-condition-verification-status
Title:         "PA Condition Verification Status"
Description:   "Codes for Condition.verificationStatus for conditions that are appropriate for exchange for physical activity purposes.  Excludes unconfirmed, provisional and differential."
* ^experimental = false
* $verifyStatus#confirmed
* $verifyStatus#refuted
* $verifyStatus#entered-in-error

ValueSet:      PADiagnosticReportStatus
Id:            pa-diagnosticreport-status
Title:         "PA DiagnosticReport Statuses"
Description:   "Codes for DiagnosticReport.status for reports that are appropriate for exchange for physical activity purposes.  Excludes non-completed and unknown-status Observations.  Entered-in-error is retained to allow correction of previously shared results that should not have existed."
* ^experimental = false
* $reportStatus#partial
* $reportStatus#preliminary
* $reportStatus#final
* $reportStatus#amended
* $reportStatus#corrected
* $reportStatus#appended
* $reportStatus#entered-in-error

ValueSet:      PAServiceRequestIntent
Id:            pa-servicerequest-intent
Title:         "PA ServiceRequest Intents"
Description:   "Codes for ServiceRequest.intent for exercise prescriptions and referrals."
* ^experimental = false
* $requestIntent#original-order
* $requestIntent#order
* $requestIntent#filler-order

ValueSet:      PAObservationCodeEVS
Id:            pa-observation-code-evs
Title:         "PA Observation Vital Sign Codes"
Description:   "Codes for Physical Activity Vital Sign components"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental = false
* $loinc#89555-7 "How many days per week did you engage in moderate to strenuous physical activity in the last 30 days"
* $loinc#68516-4 "On those days that you engage in moderate to strenuous exercise, how many minutes, on average, do you exercise"
* $loinc#82290-8 "Frequency of moderate to vigorous aerobic physical activity"
* $loinc#82291-6 "Frequency of muscle-strengthening physical activity"

ValueSet:      PADiagnosticReportType
Id:            pa-diagnosticreport-type
Title:         "PA DiagnosticReport Types"
Description:   "Codes for types of diagnostic reports relevant to physical activity referrals"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental = false
* $loinc#11488-4 "Consult Note"
* $loinc#34833-4 "Recreational therapy Consult note"
* $loinc#34822-7 "Physical medicine and rehab Consult note"
* $loinc#34824-3 "Physical therapy Consult note"
* PATemporaryCodes#PAConsultNote "Physical activity Consult note"

ValueSet:    PAServiceRequestCategory
Id:          pa-diagnosticreport-category
Title:       "PA ServiceRequest Category - USCore"
Description: "A subset of US-Core ServiceRequest category codes that are applicable to physical activity interventions."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* ^experimental  = false
* $sct#409063005 "Counselling"
* $sct#409073007 "Education"
* $sct#386053000 "Evaluation procedure"
* $sct#91251008  "Physical therapy procedure" // TODO: propose adding to US-Core

ValueSet:    PAServiceRequestInterventions
Id:          pa-servicerequest-code
Title:       "PA ServiceRequest Intervention Codes"
Description: "Codes for types of physical activity interventions"
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* ^experimental = false
* $sct#819961005       "PA guidance"
* $sct#398636004       "PA assessment"
* $sct#435551000124105 "Counseling about physical activity"
* $sct#390893007       "Referral to physical activity program"
* $sct#426866005       "Determination of phyisical activity tolerance"
* $sct#229095001       "Exercise class"
* $sct#229065009       "Exercise therapy"

ValueSet:    PAObservationActivityMeasures
Id:          pa-observation-code-activity
Title:       "PA Observation Activity-related codes"
Description: "Codes physical activity measures that relate to a single contiguous period of physical activity/exercise"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental = false
* $loinc#73985-4 "Exercise activity"
* $loinc#55411-3 "Exercise duration"
* $loinc#77592-4 "Moderate physical activity [IPAQ]"
* $loinc#77593-2 "Vigorous physical activity [IPAQ]"
* $loinc#55426-1 "Heart rate unspecified time maximum by Pedometer"
* $loinc#55425-3 "Heart rate unspecified time mean by Pedometer"
* $loinc#55424-6 "Calories burned in unspecified time Pedometer"
* PATemporaryCodes#Experience "Experience of Activity"

ValueSet:    PAObservationTimeMeasures
Id:          pa-observation-code-time
Title:       "PA Observation Time-related codes"
Description: "Codes for physical activity measures that aggregate or summarize activity over a time period, such as a day or week"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental = false
* $loinc#41950-7 "Number of steps in 24 hour Measured"
* $loinc#8873-2  "Heart rate 24 hour maximum"
* $loinc#40443-4 "Heart rate --resting"
* $loinc#41979-6 "Calories burned in 24 hour Calculated"

ValueSet:    PATaskFulfillmentStatus
Id:          pa-task-status
Title:       "PA Task Fulfillment Status"
Description: "Codes indicating allowed for Tasks seeking fulfillment of physical activity-related referrals"
* ^experimental = false
* ^compose.include[0].valueSet = "http://hl7.org/fhir/ValueSet/task-status"
* ^compose.exclude[0].system = "http://hl7.org/fhir/task-status"
* ^compose.exclude[0].concept[+].code = #received
* ^compose.exclude[0].concept[+].code = #ready

ValueSet: PAGoalMeasurement
Id: pa-goal-target-measure
Title: "PA Goal Target Measure Codes"
Description: "Value set for measure codes used in the target element of a Physical Activity-related Goal"
* ^status = #draft
* ^experimental = true
* include codes from valueset PAObservationTimeMeasures
* include codes from valueset PAObservationCodeEVS

ValueSet: PAServiceRequestStatus
Id: pa-servicerequest-status
Title: "PA ServiceRequest Status"
Description: "The status values that are permitted for the PAServiceRequest resource, excluding 'unknown'"
* ^status = #draft
* ^experimental = true
* http://hl7.org/fhir/request-status#draft
* http://hl7.org/fhir/request-status#active
* http://hl7.org/fhir/request-status#on-hold
* http://hl7.org/fhir/request-status#revoked
* http://hl7.org/fhir/request-status#completed
* http://hl7.org/fhir/request-status#entered-in-error
