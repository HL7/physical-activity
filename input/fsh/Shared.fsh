Alias: $ICD10          = http://hl7.org/fhir/sid/icd-10-cm
Alias: $loinc          = http://loinc.org
Alias: $sct            = http://snomed.info/sct
Alias: $SDOHCCTemp     = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes

Alias: $clinicalStatus  = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $goalAchievement = http://terminology.hl7.org/CodeSystem/goal-achievement
Alias: $obsCategory     = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $relationships   = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $security        = http://terminology.hl7.org/CodeSystem/restful-security-service
Alias: $verifyStatus    = http://terminology.hl7.org/CodeSystem/condition-ver-status

Alias: $obsStatus       = http://hl7.org/fhir/observation-status
Alias: $reportStatus    = http://hl7.org/fhir/diagnostic-report-status
Alias: $requestIntent   = http://hl7.org/fhir/request-intent

Alias: $conf             = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $minLength        = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $pertainsToGoal   = http://hl7.org/fhir/StructureDefinition/resource-pertainsToGoal
Alias: $observationFocus = http://hl7.org/fhir/5.0/StructureDefinition/extension-Observation.focus
Alias: $typeMS           = http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support
Alias: $verStatus        = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $condition-category = http://hl7.org/fhir/us/core/CodeSystem/condition-category
Alias: $pa-temporary-codes = http://hl7.org/fhir/us/physical-activity/CodeSystem/pa-temporary-codes

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