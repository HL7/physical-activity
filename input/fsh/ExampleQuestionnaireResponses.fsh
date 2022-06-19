Instance:       qr-evs-example
InstanceOf:     SDCQuestionnaireResponse
Title:          "Example Exercise Vital Sign QuestionnaireResponse"
Description:    "Example QuestionnaireResponse that contains the answers for an Exercise Vital Sign."
* subject		= Reference(http://example.org/Patient/1)
* questionnaire = Canonical(questionnaire-evs)
* status		= #completed
* authored		= 2022-06-09T08:58:37-05:00
* item[+].linkId 				= "89574-8"
* item[=].answer.valueDecimal	= 3.5
* item[+].linkId				= "68516-4"
* item[=].answer.valueDecimal 	= 20
