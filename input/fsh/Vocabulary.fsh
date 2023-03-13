CodeSystem:     TemporaryCodes
Id:             temporary-codes
Title:          "Temporary Codes"
Description:    "Codes that will eventually be proposed for LOINC or other code systems, but which 
  do not yet exist in 'official' code systems"
* ^caseSensitive = true
* ^experimental  = false
* #PhysicalActivity "Physical Activity" "A category assigned to resources pertaining to evaluating,
  improving or sustaining a patient's level of physical activity."
* #PAPanel "Physical Activity Panel" "A panel observation intended to group measures related to a
  specific occurrence of physical activity."
* #DeviceActivePercentage "Device Active Percentage" "Indicates the percentage of the overall
  time associated with an aggregate or average measure that the device capturing the raw data
  used to calculate the sum or average was enabled and available to take measurements.  For
  example, if a pedometer capturing steps was only worn for 2 hours when calculating a daily
  step count, the percentage would be 2/24 - or 8%."
* #PAConsultNote "Physical activity Consult note" "A consult note that describes assessments and
  interventions related to a patient's level of physical activity."

ValueSet:      ValueSetEVS
Title:         "Physical Activity Vital Sign Value Set"
Description:   "Codes for Physical Activity Vital Sign components"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental  = false
* $loinc#89555-7 ""
* $loinc#68516-4 ""
* $loinc#82290-8 ""
* $loinc#82291-6 ""


ValueSet:      PAReports
Title:         "Physical Activity Report Types Value Set"
Description:   "Codes types of diagnostic reports relevant to physical activity referrals"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental  = false
* $loinc#11488-4 ""
* $loinc#34833-4 ""
* $loinc#34822-7 ""
* $loinc#34824-3 ""
* TemporaryCodes#PAConsultNote

ValueSet:    USCorePAServiceRequestCategory
Title:       "US Core Physical Activity ServiceRequest Category"
Description: "A subset of US-Core ServiceRequest category codes that are applicable to physical
  activity interventions."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* ^experimental  = false
* $sct#409063005 "Counselling"
* $sct#409073007 "Education"
* $sct#386053000 "Evaluation procedure (procedure)"
* $sct#91251008  "Physical therapy procedure (regime/therapy)" // TODO: propose adding to US-Core

ValueSet:    PAInterventions
Title:       "Physical Activity Intervention Codes"
Description: "Codes for types of physical activity interventions"
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* ^experimental  = false
* $sct#819961005       "Physical activity guidance (Procedure)"
* $sct#398636004       "Physical activity assessment (Procedure)"
* $sct#435551000124105 "Counseling about physical activity (Procedure)"
* $sct#390893007       "Referral to physical activity program (Procedure)"
* $sct#426866005       "Determination of phyisical activity tolerance (Procedure)"
* $sct#229095001       "Exercise class (regime/therapy)"
* $sct#229065009       "Exercise therapy (regime/therapy)"
// TODO - what other codes should be in this list?  Should we add more detailed codes?

ValueSet:    PAActivityMeasures
Title:       "Activity-instance related codes"
Description: "Codes physical activity measures that relate to a single contiguous period of physical activity/exercise"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental  = false
* $loinc#73985-4 ""
* $loinc#55411-3 ""
* $loinc#77592-4 ""
* $loinc#77593-2 ""
* $loinc#55422-0 ""
* $loinc#55424-6 ""

ValueSet:    PATimeMeasures
Title:       "Physical Activity time-related codes"
Description: "Codes for physical activity measures that aggregate or summarize activity over a period of time, such as a day or week"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* ^experimental  = false
* $loinc#8873-2 ""
* $loinc#40443-4 ""
* $loinc#41979-6 ""

ValueSet:    PAReferralTaskStatus
Title:       "Physical Activity Referral Task Status"
Description: "Codes indicating allowed for Tasks seeking fulfillment of physical activity-related referrals"
* ^experimental  = false
* ^compose.include[0].valueSet = http://hl7.org/fhir/ValueSet/task-status
* ^compose.exclude[0].system = http://hl7.org/fhir/task-status
* ^compose.exclude[0].concept[+].code = #received
* ^compose.exclude[0].concept[+].code = #ready
