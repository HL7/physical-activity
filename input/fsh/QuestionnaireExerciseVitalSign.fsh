Alias: $obsExtract = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract
Alias: $extractCat = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observation-extract-category
Alias: $unit 	   = http://hl7.org/fhir/StructureDefinition/questionnaire-unit
Alias: $UCUM       = http://unitsofmeasure.org

Instance:       questionnaire-evs
InstanceOf:     SDCBaseQuestionnaire
Title:          "Exercise Vital Sign Questionnaire"
Description:    "Questionnaire that allows capturing the Exercise Vital Sign."
* extension[http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract].valueBoolean = true
* extension[$obsExtract].valueBoolean = true
* url			         = "http://hl7.org/fhir/us/physical-activity/Questionnaire/questionnaire-evs"
* name             = "QuestionnaireEVS"
* status           = #active
* item[+].linkId	 = "89574-8"
* item[=].extension[$unit].valueCoding = $UCUM#d/wk
* item[=].code 		 = http://loinc.org#89574-8
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
