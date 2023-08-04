Instance:    ExampleRelatedPerson
InstanceOf:  PARelatedPerson
Title:       "Example Relative"
Description: "RelatedPerson conformant with future U.S. core profile used to show caregiver involvement in data sharing."
* active             = true
* patient            = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* relationship       = $relationships#MTH "Mother"
  * text             = "Mother"
* name
  * given            = "Jane"
  * family           = "Doe"
* telecom
  * system           = #email
  * value            = "jane.doe@somewhere.com"
* address
  * line             = "123 Some Street"
  * city             = "Some town"
  * state            = "MI"
  * postalCode       = "012345"

Instance:    ExampleCondition
InstanceOf:  PAConditionLowPA
Title:       "Example Low Physical Activity Condition"
Description: "Condition indicating a diagnosis of 'lack of physical exercise'."
* clinicalStatus     = $clinicalStatus#active
* verificationStatus = $verifyStatus#confirmed
* category[+] = $condition-category#health-concern "Health Concern"
* category[PA] = PATemporaryCodes#PhysicalActivity
* subject	         = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* onsetDateTime      = "2022-06-08"
* asserter           = Reference(http://example.org/fhir/PractitionerRole/1) "Ordering Clinician"
* evidence.detail    = Reference(ExampleEVSMinutesPerWeek)

Instance:       ExampleGoal
InstanceOf:     PAGoal
Title:          "Example Physical Activity Goal"
Description:    "A goal of 100 minutes/week of moderate-vigorous physical activity by a specified date."
* lifecycleStatus     = #active
* achievementStatus   = $goal-achievement#in-progress
* description.text    = """Over the next 6 months\, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breath heavily enough that holding a conversation is difficult."""
* subject	          = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* target
  * measure           = http://loinc.org#82290-8
  * detailQuantity    = 100 'min/wk'
  * dueDate           = 2022-12-08
* addresses           = Reference(ExampleCondition) "Low Exercise"
* note
  * authorReference   = Reference(http://example.org/fhir/PractitionerRole/1) "Ordering Clinician"
  * time              = 2022-12-15
  * text              = "Significant progress.  Regularly exceeding 120 min/week and has found an activity he enjoys.  Need to branch out to one more activity to achieve guideline target."

Instance:       ExampleCarePlan
InstanceOf:     PACarePlan
Title:          "Example Physical Activity Care Plan"
Description: 	  "Sample care plan."
* text
  * status            = #additional
  * div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">This care plan focuses on increasing the patient's physical activity levels. Over the next six months, the goal is to gradually increase the weekly exercise in small increments to at least 100 minutes of physical activity per week that makes the patient sweat and breathe heavily. Regular reviews will be conducted to assess the patient's progress and adjust the plan as necessary.</div>"
* status = #active
* intent              = #plan
* subject	          = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* period
  * start             = 2022-06-08
  * end               = 2023-06-08
* goal = Reference(Goal/ExampleGoal) "Increase physical activity to 100 minutes/week"
* activity.detail                                                           
  * code = $sct#229065009 "Exercise therapy"
  * status = #not-started
  * description = "Over the next 6 months, increase your weekly exercise in small increments to at least 100 minutes/week of physical activity that makes you sweat and breathe heavily."
* note
  * authorReference   = Reference(ExampleRelatedPerson) "Mother"
  * time              = 2022-12-15
  * text = "The patient has been making significant progress, regularly exceeding the target and has found an activity they enjoy. Regular reviews will be conducted to assess the patient's progress and adjust the plan as necessary."

Instance:    ExampleServiceRequest
InstanceOf:  PAServiceRequest
Title:       "Example Physical Activity Referral"
Description: "A referral to a gym."
* extension[pertainsToGoal].valueReference = Reference(ExampleGoal)
* status                   = #active
* intent                   = #original-order
* priority                 = #routine
* category[USCore]              = $sct#409063005 "Counseling"
* category[PA]              = PATemporaryCodes#PhysicalActivity
* code                     = $sct#390893007 "Referral to physical activity program (Procedure)"
* subject                  = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* occurrencePeriod
  * start                  = "2022-06-08"
  * end                    = "2022-08-01"
* authoredOn               = "2022-06-08"
* requester                = Reference(http://example.org/fhir/PractitionerRole/1) "Ordering Clinician"
* performer                = Reference(http://example.org/fhir/Organization/1)
* reasonReference          = Reference(ExampleCondition)

Instance:    ExampleFulfillmentTask
InstanceOf:  PATaskForReferralManagement
Title:       "Example Physical Activity Referral Fulfillment Request"
Description: "An example task seeking fulfillment of a referral"
* status              = #in-progress
//* statusReason.text = */
* businessStatus.text = "Attended orientation meeting"
* priority            = #routine
* focus               = Reference(ExampleServiceRequest) "Referral"
* for                 = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* authoredOn          = "2022-06-08"
* requester           = Reference(http://example.org/fhir/Organization/1) "Requesting Organization"
* owner               = Reference(http://example.org/fhir/Organization/2) "Performing Organization"
* note[+]
  * authorReference   = Reference(http://example.org/fhir/PractitionerRole/2) "Performing Provider"
  * time              = "2022-06-17"
  * text              = "Orientation went well.  Patient is looking forward to attending class."

Instance:    ExampleSubscriptionWebhook
InstanceOf:  BackportSubscription
Title:       "Example Subscription by Care Manager"
Description: "An example showing what a subscription request would look like to monitor Tasks created by a Care Manager, with notifications by web-hook"
* status = #requested
* reason = "Allow monitoring of Tasks created by this organization"
* criteria = "http://hl7.org/fhir/us/sdoh-clinicalcare/SubscriptionTopic/Task"
  * extension[filterCriteria].valueString = "Task?requester=Organization/1"
* channel
  * type = #rest-hook
  * endpoint = "https://example.org/sub-notify/644c53f4-0dee-40bd-b2df-914b66ef43e6"
  * payload = #application/fhir+json
    * extension[content].valueCode = #id-only

Instance:    ExampleSubscriptionEmail
InstanceOf:  BackportSubscription
Title:       "Example Subscription by Service Provider by Email"
Description: "An example showing what a subscription request would look like to monitor Tasks created for a Service Provider, with notifications by email.  (Could have used SMS instead.)"
* status = #requested
* reason = "Allow monitoring of Tasks created for this Practitioner"
* criteria = "http://hl7.org/fhir/us/sdoh-clinicalcare/SubscriptionTopic/Task"
  * extension[filterCriteria].valueString = "Task?owner=PractitionerRole/2"
* channel
  * type = #email
  * endpoint = "mailto:drfit@goodhealthgym.example.org"
  * payload = #application/fhir+json
    * extension[content].valueCode = #empty

Instance:    ExampleSubscriptionSMS
InstanceOf:  BackportSubscription
Title:       "Example Subscription by Patient by SMS"
Description: "An example showing what a subscription request would look like to monitor Tasks created for a Patient, with notifications by SMS.  (Could have used email instead.)"
* status = #requested
* reason = "Allow monitoring of Tasks created for this Patient"
* criteria = "http://hl7.org/fhir/us/sdoh-clinicalcare/SubscriptionTopic/Task"
  * extension[filterCriteria].valueString = "Task?owner=Patient/1"
* channel
  * type = #sms
  * endpoint = "tel:1-234-567-8900"
  * payload = #application/fhir+json
    * extension[content].valueCode = #empty


Instance:    ExampleSubscriptionBundleWithIds
InstanceOf:  BackportSubscriptionNotificationR4
Title:       "Example Subscription Notification Bundle with Ids"
Description: "An example showing a subscription notification that identifies the specific new or changed tasks"
* type              = #history
* entry[+]
  * fullUrl  = "urn:uuid:33d202b6-df23-43fd-b190-d150dca8dd14"
  * resource = ExampleSubscriptionStatusWithIds
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscriptionWebhook/$status"
  * response.status = "200"

Instance:    ExampleSubscriptionBundleWithNoIds
InstanceOf:  BackportSubscriptionNotificationR4
Title:       "Example Subscription Notification Bundle with no Ids"
Description: "An example showing a subscription notification that merely indicates there are new or changed tasks without indicating what they are"
* type              = #history
* entry[+]
  * fullUrl  = "urn:uuid:b4fb4012-ff43-4e9d-8047-813b13914d72"
  * resource = ExampleSubscriptionStatusWithNoIds
  * request
    * method = #GET
    * url = "https://example.org/fhir/Subscription/ExampleSubscriptionEmail/$status"
  * response.status = "200"

Instance:    ExampleSubscriptionStatusWithIds
InstanceOf:  BackportSubscriptionStatusR4
Title:       "Example Subscription Status with Ids"
Description: "An example showing a subscription status instance containing Task ids that are new or changed"
* parameter[subscription].valueReference = Reference(ExampleSubscriptionWebhook)
* parameter[topic].valueCanonical = "http://hl7.org/fhir/us/sdoh-clinicalcare/SubscriptionTopic/Task"
* parameter[status].valueCode = #active
* parameter[type].valueCode = #event-notification
* parameter[eventsSinceSubscriptionStart].valueString = "287"
* parameter[notificationEvent]
  * part[eventNumber].valueString = "288"
  * part[eventTimestamp].valueInstant = "2022-06-17T14:38:55.8826-05:00"
  * part[eventFocus].valueReference = Reference(ExampleFulfillmentTask)
  * part[eventAdditionalContext].valueReference = Reference(http://example.org/fhir/Patient/1) "Example Patient"

Instance:    ExampleSubscriptionStatusWithNoIds
InstanceOf:  BackportSubscriptionStatusR4
Title:       "Example Subscription Status with no Ids"
Description: "An example showing a subscription status instance indicating that there are new or changed tasks, without indicating which ones have changed"
* parameter[subscription].valueReference = Reference(ExampleSubscriptionEmail)
* parameter[topic].valueCanonical = "http://hl7.org/fhir/us/sdoh-clinicalcare/SubscriptionTopic/Task"
* parameter[status].valueCode = #active
* parameter[type].valueCode = #event-notification
* parameter[eventsSinceSubscriptionStart].valueString = "7"

Instance:    ExampleBundleTaskSearchResponse
InstanceOf:  Bundle
Title:       "Example Task Search Response Bundle"
Description: "An example showing the results of a Bundle search returning listed Tasks and their associated ServiceRequests which might be used by a 'light' Service Provider after receiving a subscription notification"
* type = #searchset
* total = 1
* link[+]
  * relation = #self
  * url = "https://example.org/fhir/Task?_id=ExampleFulfillmentTask&patient=http://example.org/fhir/Patient/1&_include=Task.focus"
* entry[+]
  * fullUrl  = "https://example.org/fhir/Task/ExampleFulfillmentTask"
  * resource = ExampleFulfillmentTask
  * search.mode = #match
* entry[+]
  * fullUrl  = "https://example.org/fhir/ServiceRequest/ExampleServiceRequest"
  * resource = ExampleServiceRequest
  * search.mode = #include

Instance:    ExampleReport
InstanceOf:  PADiagnosticReport
Title:       "Example Physical Activity Report"
Description: "An example physical activity report"
* basedOn             = Reference(ExampleServiceRequest) "Referral"
* status              = #final
* category[+] = $loinc#LP29708-2 "Cardiology"
* category[PA] = PATemporaryCodes#PhysicalActivity
* code                = $loinc#11488-4 "Consult note"
* subject             = Reference(http://example.org/fhir/Patient/1) "Example Patient"
* effectivePeriod
  * start             = 2022-06-08
  * start             = 2022-09-18
* issued              = 2022-09-18T13:47:58.0282-05:00
* performer           = Reference(http://example.org/fhir/PractitionerRole/2) "Performing Provider"
* presentedForm
