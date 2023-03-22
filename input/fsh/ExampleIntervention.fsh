Instance:    ExampleCondition
InstanceOf:  LowPACondition
Title:       "Example Low Physical Activity Condition"
Description: "Condition indicating a diagnosis of 'lack of physical exercise'."
* clinicalStatus     = $clinicalStatus#active
* verificationStatus = $verifyStatus#confirmed
* subject	         = Reference(http://example.org/Patient/1)
* onsetDateTime      = "2022-06-08"
* asserter           = Reference(http://example.org/PractitionerRole/1)
* evidence.detail    = Reference(ExampleEVSMinutesPerWeek)

Instance:       ExampleGoal
InstanceOf:     PAGoal
Title:          "Example Physical Activity Goal"
Description:    "An goal of 100 minutes/week of moderate-vigorous physical activity by a specified date."
* lifecycleStatus     = #active
* achievementStatus   = $goalAchievement#in-progress
* description.text    = """Over the next 6 months\, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult."""
* subject	          = Reference(http://example.org/Patient/1)
* target
  * measure           = http://loinc.org#82290-8
  * detailQuantity    = 100 'min/wk'
  * dueDate           = 2022-12-08
* addresses           = Reference(ExampleCondition)
* note
  * authorReference   = Reference(http://example.org/PractitionerRole/1)
  * time              = 2022-12-15
  * text              = "Significant progress.  Regularly exceeding 120 min/week and has found an activity he enjoys.  Need to branch out to one more activity to achieve guideline target."

Instance:       ExampleCarePlan
InstanceOf:     PACarePlan
Title:          "Example Physical Activity Care Plan"
Description: 	  "Sample care plan."
* text
  * status            = #additional
  * div               = """<div xmlns="http://www.w3.org/1999/xhtml">Put contents of CarePlan here</div>"""
* status              = #active
* intent              = #plan
* subject	          = Reference(http://example.org/Patient/1)
* period
  * start             = 2022-06-08
  * end               = 2023-06-08
* note
  * authorReference   = Reference(http://example.org/PractitionerRole/1)
  * time              = 2022-12-15
  * text              = "Some comments."

Instance:    ExampleServiceRequest
InstanceOf:  PAServiceRequest
Title:       "Example Physical Activity Referral"
Description: "A referral to a gym."
* extension[pertainsToGoal].valueReference = Reference(ExampleGoal)
* status                   = #active
* intent                   = #original-order
* priority                 = #routine
* category[1]              = $sct#409063005 "Counseling"
* code                     = $sct#390893007 "Referral to physical activity program (Procedure)"
* subject                  = Reference(http://example.org/Patient/1)
* occurrencePeriod
  * start                  = "2022-06-08"
  * end                    = "2022-08-01"
* authoredOn               = "2022-06-08"
* requester                = Reference(http://example.org/PractitionerRole/1)
* performer                = Reference(http://example.org/Organization/1)
* reasonReference          = Reference(ExampleCondition)

Instance:    ExampleFufillmentTask
InstanceOf:  PATaskForReferralManagement
Title:       "Example Physical Activity Referral Fulfillment Request"
Description: "An example task seeking fulfillment of a referral"
* status              = #in-progress
//* statusReason.text = */
* businessStatus.text = "Attended orientation meeting"
* priority            = #routine
* focus               = Reference(ExampleServiceRequest)
* for                 = Reference(http://example.org/Patient/1)
* authoredOn          = "2022-06-08"
* owner               = Reference(http://example.org/Organization/1)
* note[+]
  * authorReference   = Reference(http://example.org/PractitionerRole/2)
  * time              = "2022-06-17"
  * text              = "Orientation went well.  Patient is looking forward to attending class."


Instance:    ExampleReport
InstanceOf:  PADiagnosticReport
Title:       "Example Physical Activity Report"
Description: "An example physical activity report"
* basedOn             = Reference(ExampleServiceRequest)
* status              = #final
* code                = $loinc#11488-4 "Consult note"
* subject             = Reference(http://example.org/Patient/1)
* effectivePeriod
  * start             = 2022-06-08
  * start             = 2022-09-18
* issued              = 2022-09-18T13:47:58.0282-05:00
* performer           = Reference(http://example.org/PractitionerRole/2)
* presentedForm
