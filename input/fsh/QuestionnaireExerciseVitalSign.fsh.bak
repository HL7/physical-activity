/*
Alias: $obsExtract           = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract
Alias: $extractCat           = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observation-extract-category
Alias: $variable             = http://hl7.org/fhir/StructureDefinition/variable
Alias: $calculatedExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression
Alias: $unit 	               = http://hl7.org/fhir/StructureDefinition/questionnaire-unit
Alias: $UCUM                 = http://unitsofmeasure.org

Instance:       questionnaire-evs
InstanceOf:     SDCBaseQuestionnaire
Title:          "Exercise Vital Sign Questionnaire"
Usage:          #definition
Description:    "Questionnaire that allows capturing the Exercise Vital Sign and associated measures."
//* extension[http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract].valueBoolean = true
* extension[$obsExtract].valueBoolean = true
* extension[$variable].valueExpression
  * name       = "weeklyExercise"
  * language   = #text/fhirpath
  * expression = "item.where(linkId='89555-7').answer.value * item.where(linkId='68516-4').answer.value"
* url			         = "http://hl7.org/fhir/us/physical-activity/Questionnaire/questionnaire-evs"
* name             = "QuestionnaireEVS"
* status           = #active
* item[+].linkId	 = "89555-7"
* item[=].extension[$unit].valueCoding = $UCUM#d/wk
* item[=].code 		 = http://loinc.org#89555-7
* item[=].text 		 = "For an average week in the last 30 days, how many days per week did you engage in moderate to strenuous exercise (like walking fast, running, jogging, dancing, swimming, biking, or other activities that cause a light or heavy sweat)?"
* item[=].type 		 = #decimal
* item[=].repeats  = false
* item[=].required = true
* item[+].linkId 	 = "68516-4"
* item[=].extension[$unit].valueCoding = $UCUM#min/d
* item[=].code 		 = http://loinc.org#68516-4
* item[=].text 		 = "On those days that you engage in moderate to strenuous exercise, how many minutes, on average, do you exercise?"
* item[=].type 		 = #decimal
* item[=].repeats  = false
* item[=].required = true
* item[+].linkId 	 = "82290-8"
* item[=].extension[$unit].valueCoding = $UCUM#d/wk
* item[=].extension[$calculatedExpression].valueExpression
  * language   = #text/fhirpath
  * expression = "$weeklyExercise"
* item[=].code 		 = http://loinc.org#82290-8
* item[=].text 		 = "Frequency of moderate to vigorous aerobic physical activity"
* item[=].readOnly = true
* item[=].type 		 = #decimal
* item[=].repeats  = false
* item[=].required = false
* item[+].linkId 	 = "82291-6"
* item[=].extension[$unit].valueCoding = $UCUM#d/wk
* item[=].code 		 = http://loinc.org#82291-6
* item[=].text 		 = "On average, how many days per week do you engage in muscle-strengthening physical activity (e.g. lifting weights, resistance training)?"
* item[=].type 		 = #decimal
* item[=].repeats  = false
* item[=].required = true
*/