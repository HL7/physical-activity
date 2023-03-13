Alias: $ICD10          = http://hl7.org/fhir/sid/icd-10-cm
Alias: $loinc          = http://loinc.org
Alias: $sct            = http://snomed.info/sct
Alias: $SDOHCCTemp     = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes

Alias: $conf           = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
Alias: $minLength      = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $pertainsToGoal = http://hl7.org/fhir/StructureDefinition/resource-pertainsToGoal
Alias: $security       = http://terminology.hl7.org/CodeSystem/restful-security-service
Alias: $typeMS         = http://hl7.org/fhir/StructureDefinition/elementdefinition-type-must-support


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

RuleSet: SearchParam2(name, def, type, conf, doc)
* searchParam[+]
  * extension[$conf].valueCode = {conf}
  * name = {name}
  * definition = "{def}"
  * type = {type}
  * documentation = {doc}

RuleSet: SearchParam(name, def, type, conf, doc)
* searchParam[+]
  * extension[$conf].valueCode = {conf}
  * name = {name}
  * definition = "http://hl7.org/fhir/SearchParameter/{def}"
  * type = {type}
  * documentation = {doc}

