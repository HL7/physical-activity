// External Code Systems
Alias: $ICD10 = http://hl7.org/fhir/sid/icd-10-cm
Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct

// FHIR Code Systems
Alias: $obsStatus       = http://hl7.org/fhir/observation-status
Alias: $reportStatus    = http://hl7.org/fhir/diagnostic-report-status
Alias: $requestIntent   = http://hl7.org/fhir/request-intent
Alias: $task-code       = http://hl7.org/fhir/CodeSystem/task-code

// THO Code Systems
Alias: $clinicalStatus    = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $goal-achievement  = http://terminology.hl7.org/CodeSystem/goal-achievement
Alias: $obsCategory       = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $practitioner-role = http://terminology.hl7.org/CodeSystem/practitioner-role
Alias: $relationships     = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $security          = http://terminology.hl7.org/CodeSystem/restful-security-service
Alias: $verifyStatus      = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $v2-0203           = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-RoleCode       = http://terminology.hl7.org/CodeSystem/v3-RoleCode

// US-Core Code Systems
Alias: $careplan-category  = http://hl7.org/fhir/us/core/CodeSystem/careplan-category
Alias: $condition-category = http://hl7.org/fhir/us/core/CodeSystem/condition-category

// Gravity Code Systems
Alias: $SDOHCC-Temp        = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes


// Extensions
Alias: $conf             = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $minLength        = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $pertainsToGoal   = http://hl7.org/fhir/StructureDefinition/resource-pertainsToGoal
Alias: $typeMS           = http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support

// Inter-version extensions
Alias: $observationFocus = http://hl7.org/fhir/5.0/StructureDefinition/extension-Observation.focus
Alias: $instanceContent  = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.content
Alias: $verContent       = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.content
Alias: $verTitle         = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.title


// CapabilityStatement RuleSets
RuleSet: SupportedProfile(profile, conf)
* supportedProfile[+] = Canonical({profile})
  * extension[$conf].valueCode = {conf}

RuleSet: Interaction(code, conf, doc)
* interaction[+]
  * extension[$conf].valueCode = {conf}
  * code  = {code}
  * documentation = {doc}

RuleSet: SearchInclude(include, conf)
* searchInclude[+] = {include}
  * extension[$conf].valueCode = {conf}

RuleSet: SearchParam(name, def, type, conf, doc)
* searchParam[+]
  * extension[$conf].valueCode = {conf}
  * name = {name}
  * definition = "http://hl7.org/fhir/SearchParameter/{def}"
  * type = {type}
  * documentation = {doc}

RuleSet: SearchParam2(name, def, type, conf, doc)
* searchParam[+]
  * extension[$conf].valueCode = {conf}
  * name = {name}
  * definition = "{def}"
  * type = {type}
  * documentation = {doc}


// ExampleScenario RuleSets
RuleSet: ActorEntity(id, name, description)
* actor[+]
  * actorId = "{id}"
  * type = #entity
  * name = {name}
  * description = "{description}"

RuleSet: Instance_Empty(id, type, name, description)
* instance[+]
  * resourceId = "{id}"
  * resourceType = #{type}
  * name = {name}
  * description = "{description}"

RuleSet: Instance_Content(id, type, name, description)
* insert Instance_Empty({id}, {type}, {name}, [[{description}]])
* instance[=].extension[$instanceContent].valueReference = Reference({id})

RuleSet: InstanceVersion(id, name, content, description)
* instance[=].version[+]
  * extension[$verTitle].valueString = {name}
  * extension[$verContent].valueReference = Reference({content})
  * versionId = "{id}"
  * description = "{description}"

RuleSet: InstanceContains(id, version)
* instance[=].containedInstance
  * resourceId = "{id}"
  * versionId = "{version}"

RuleSet: ProcessSearch(num, name, sender, receiver, request, response, description)
* step[+].operation
  * number = "{num}"
  * type = "search-type"
  * name = {name}
  * description = "{description}"
  * initiator = "{sender}"
  * receiver = "{receiver}"
  * request.resourceId = "{request}"
  * response.resourceId = "{response}"

RuleSet: ProcessCreate(num, name, sender, receiver, request, version, description)
* step[+].operation
  * number = "{num}"
  * type = "create"
  * name = {name}
  * description = "{description}"
  * initiator = "{sender}"
  * receiver = "{receiver}"
  * request.resourceId = "{request}"
  * request.versionId = "{version}"

RuleSet: ProcessUpdate(num, name, sender, receiver, request, version, description)
* step[+].operation
  * number = "{num}"
  * type = "update"
  * name = {name}
  * description = "{description}"
  * initiator = "{sender}"
  * receiver = "{receiver}"
  * request.resourceId = "{request}"
  * request.versionId = "{version}"

RuleSet: SubNotification(parameters, endpointPrefix, subscriptionId)
* type = #history
* entry
  * fullUrl = "http://example.com/fhir/Parameters/{parameters}"
  * resource = {parameters}
  * request
    * method = #GET
    * url = "https://{endpointPrefix}.example.org/fhir/Subscription/{subscriptionId}/$status"
  * response.status = "200"

RuleSet: SubParameters(subscription, resource)
* parameter[+]
  * name = "subscription"
  * valueReference = Reference({subscription})
* parameter[+]
  * name = "type"
  * valueCode = #event-notification
* parameter[+]
  * name = "focus"
  * valueReference = Reference({resource})


// PA RuleSets
RuleSet: Note(time, author, authorName, note)
* note[+]
  * authorReference = Reference({author}) {authorName}
  * time = {time}
  * text = "{note}"

RuleSet: Condition(patient, patientName, asserter, asserterName, code, display, onset)
* clinicalStatus = $clinicalStatus#active
* verificationStatus = $verifyStatus#confirmed
* category[+] = $condition-category#health-concern
* category[+] = PATemporaryCodes#PhysicalActivity
* code = {code} {display}
* subject = Reference({patient}) {patientName}
* onsetDateTime = "{onset}"
* asserter = Reference({asserter}) {asserterName}

RuleSet: CarePlan(start, end, patient, patientName, author, authorName, detail)
* text
  * status = #additional
  * div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">{detail}</div>"
* status = #active
* intent = #plan
* category[+] = PATemporaryCodes#PhysicalActivity
* category[+] = $careplan-category#assess-plan
* subject = Reference({patient}) {patientName}
* period
  * start = "{start}"
  * start = "{end}"
* author = Reference({author}) {authorName}

RuleSet: Goal(patient, patientName, status, description)
* lifecycleStatus = #active
* achievementStatus = $goal-achievement#{status}
* category = PATemporaryCodes#PhysicalActivity
* description.text = "{description}"
* subject = Reference({patient}) {patientName}

RuleSet: GoalTarget(due, loinc, display, quantity)
* target
  * measure = $loinc#{loinc} {display}
  * detailQuantity = {quantity}
  * dueDate = "{due}"

RuleSet: ExerciseReferral(start, end, patient, patientName, author, authorName, code, display)
* status = #active
* intent = #order
* category[+] = PATemporaryCodes#PhysicalActivity
* priority = #routine
* code = {code} "{display}"
* subject = Reference({patient}) {patientName}
* requester = Reference({author}) {authorName}
* occurrencePeriod
  * start = "{start}"
  * end = "{end}"

RuleSet: ExerciseRx(start, end, patient, patientName, author, authorName)
* insert ExerciseReferral({start}, {end}, {patient}, {patientName}, {author}, {authorName}, $sct#229065009, [[Exercise therapy (regime/therapy)]])
* performer = Reference({patient}) {patientName}

RuleSet: FulfillTask(patient, patientName, requester, requesterName, owner, ownerName, order, status, date)
* status = #{status}
* intent = #order
* code = $task-code#fulfill
* focus = Reference({order})
* requester = Reference({requester}) {requesterName}
* for = Reference({patient}) {patientName}
* authoredOn = "{date}"
* owner = Reference({owner}) {ownerName}

RuleSet: TaskOutput(report)
* output
  * type = $SDOHCC-Temp#resulting-activity "Resulting Activity"
  * valueReference = Reference({report})

RuleSet: DiagnosticReport(patient, patientName, performer, performerName, code, display, order, start, end, base64)
* basedOn = Reference({order})
* status = #final
* category = PATemporaryCodes#PhysicalActivity "Physical Activity"
* code = {code} {display}
* subject = Reference({patient}) {patientName}
* effectivePeriod
  * start = "{start}"
  * end   = "{end}"
* performer = Reference({performer}) {performerName}
* presentedForm
  * contentType = #application/pdf
  * data = {base64}


// Bundle RuleSets
RuleSet: SearchBundle(count, search)
* type = #searchset
* total = {count}
* link
  * relation = "self"
  * url = "http://example.com/fhir/{search}"

RuleSet: EntryMatch(type, resourceId)
* entry[+]
  * fullUrl = "http://example.com/fhir/{type}/{resourceId}"
  * resource = {resourceId}
  * search.mode = #match

RuleSet: EntryInclude(type, resourceId)
* entry[+]
  * fullUrl = "http://example.com/fhir/{type}/{resourceId}"
  * resource = {resourceId}
  * search.mode = #include


// Observation RuleSets
RuleSet: Observation(patient, patientName, effective)
* status = #final
* category[+] = $obsCategory#activity
* category[+] = PATemporaryCodes#PhysicalActivity
* subject = Reference({patient}) {patientName}
* effectiveDateTime = "{effective}"
* performer = Reference({patient}) {patientName}

// Exercise Vital Sign
RuleSet: DaysPerWeek(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#89555-7 "How many days per week did you engage in moderate to strenuous physical activity in the last 30 days"
* valueQuantity = {value} 'd/wk' "days per week"

RuleSet: MinPerDay(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#68516-4 "On those days that you engage in moderate to strenuous exercise, how many minutes, on average, do you exercise"
* valueQuantity = {value} 'min/d' "minutes per day"

RuleSet: MinPerWeek(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#82290-8 "Frequency of moderate to vigorous aerobic physical activity"
* valueQuantity = {value} 'min/wk' "minutes per week"

RuleSet: StrengthPerWeek(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#82291-6 "Frequency of muscle-strengthening physical activity"
* valueQuantity = {value} 'd/wk' "days per week"

// Activity Measures
RuleSet: ActivityGroup(patient, patientName, effective)
* insert Observation({patient}, {patientName}, {effective})
* code = PATemporaryCodes#PAPanel "Physical Activity Panel"

RuleSet: HasMember(target)
* hasMember = Reference({target})

RuleSet: ActivityType(patient, patientName, effective, code, display)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#73985-4 "Exercise activity"
* valueCodeableConcept = $loinc#{code} {display}

RuleSet: ActivityDuration(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#55411-3 "Exercise duration"
* valueQuantity = {value} 'min' "minutes"

RuleSet: ActivityModerate(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#577592-4 "Moderate physical activity [IPAQ]"
* valueQuantity = {value} 'min' "minutes"

RuleSet: ActivityVigorous(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#77593-2 "Vigorous physical activity [IPAQ]"
* valueQuantity = {value} 'min' "minutes"

RuleSet: PeakHeartRate(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#55426-1 "Heart rate unspecified time maximum by Pedometer"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: MeanHeartRate(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#55425-3 "Heart rate unspecified time mean by Pedometer"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: ActivityCalories(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#55424-6 "Calories burned in unspecified time Pedometer"
* valueQuantity = {value} 'kcal' "kilocalories"

RuleSet: ActivityExperience(patient, patientName, effective, code, display)
* insert Observation({patient}, {patientName}, {effective})
* code = PATemporaryCodes#Experience "Experience of Activity"
* valueCodeableConcept = PATemporaryCodes#{code} {display}


// Time-based Measures
RuleSet: DailySteps(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#41950-7 "Number of steps in 24 hour Measured"
* valueQuantity = {value} '/d' "steps per day"

RuleSet: DailyPeakHR(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#8873-2  "Heart rate 24 hour maximum"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: RestingHR(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#40443-4 "Heart rate --resting"
* valueQuantity = {value} '/min' "beats per minute"

RuleSet: DailyCalories(patient, patientName, effective, value)
* insert Observation({patient}, {patientName}, {effective})
* code = $loinc#41979-6 "Calories burned in 24 hour Calculated"
* valueQuantity = {value} 'kcal/d' "kilokalories per day"


Profile:        ReferenceRest
Parent:         Reference
Id:             reference-rest
Title:          "Reference - RESTful"
Description:    "A Reference data type where the referenced resource is expected to be resolvable RESTfully."
* reference 1..1 MS
* display MS

Profile:       ReferenceRestOrLogical
Parent:        Reference
Id:            reference-rest-or-logical
Title:         "Reference - RESTful or Logical"
Description:   "A Reference data type where the referenced resource could be resolvable RESTfully or pointed to logically."
* obeys PA-ident-1 and PA-ident-2
* reference MS
  * ^condition[+] = PA-ident-1
  * ^condition[+] = PA-ident-2
* identifier MS
  * ^condition[+] = PA-ident-1
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value 1..1 MS
* display MS
  * ^condition[+] = PA-ident-2

Invariant:   PA-ident-1
Description: "reference or identifier must be present"
Expression:  "reference.exists() or identifier.exists()"
Severity:    #error
XPath:       "exists(f:reference) or exists(f:identifier)"

Invariant:   PA-ident-2
Description: "If reference is not present, display must be present"
Expression:  "reference.exists().not() implies display.exists()"
Severity:    #error
XPath:       "exists(f:reference) or exists(f:display)"