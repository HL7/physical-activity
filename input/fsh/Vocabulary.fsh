Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct

CodeSystem:     TemporaryCodes
Id:             temporary-codes
Title:          "Temporary Codes"
Description:    "Codes that will eventually be proposed for LOINC or other code systems, but which 
  do not yet exist in 'official' code systems"
* ^caseSensitive = true
* #daily-log "Daily Exercise Log" "A record of the number of minutes exercised on a given day."
* #PhysicalActivity "Physical Activity" "A category assigned to resources pertaining to evaluating,
  improving or sustaining a patient's level of physical activity."
* #LowActivity "Low Physical Activity" "The patient's level of physical activity is sufficiently
  below guidelines that it is likely to negatively impact their health."

ValueSet:      ValueSetEVS
Title:         "Exercise Vital Sign Value Set"
Description:   "Codes for Exercise Vital Sign components"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* $loinc#89574-8 ""
* $loinc#68516-4 ""

ValueSet:    USCorePAServiceRequestCategory
Title:       "US Core Physical Activity ServiceRequest Category"
Description: "A subset of US-Core ServiceRequest category codes that are applicable to physical
  activity interventions."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* $sct#409063005 "Counselling"
* $sct#409073007 "Education"
* $sct#386053000 "Evaluation procedure (procedure)"
* $sct#91251008  "Physical therapy procedure (regime/therapy)" // TODO: propose adding to US-Core

ValueSet:    PAInterventions
Title:       "Physical Activity Intervention Codes"
Description: "Codes for types of physical activity interventions"
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* $sct#819961005       "Physical activity guidance (Procedure)"
* $sct#398636004       "Physical activity assessment (Procedure)"
* $sct#435551000124105 "Counseling about physical activity (Procedure)"
* $sct#390893007       "Referral to physical activity program (Procedure)"
* $sct#426866005       "Determination of phyisical activity tolerance (Procedure)"
* $sct#229095001       "Exercise class (regime/therapy)"
* $sct#229065009       "Exercise therapy (regime/therapy)"
// TODO - what other codes should be in this list?  Should we add more detailed codes?