# Vocabulary

The `vocabulary\valueset` folder supports VS Code unit test execution as well as measure specification bundling using CQF Tooling.

The bundling and unit test execution functionality will load any file in the `vocabulary\valueset` directory, and any sub-directories, recursively, and attempt to treat the file as a FHIR resource. If it is a ValueSet, it will be made available to the CQL engine and CQF tooling. If it is a Bundle, any ValueSet resources in the Bundle will be made available.

The `external` folder is used because the IG is often configured to load vocabulary resources from the `input\vocabulary` folder, but not recursively. So local terminology (i.e. published as part of the IG) can be placed in the `input\vocabulary` folder, but external terminology (i.e. published in other IGs or made available in other terminology locations) can be placed in the `external` folder. VSCode can then find all the terminology required to evaluate unit tests, and the bundling logic can also access it. (It is a current task in CQF Tooling to make the VSCode plugin and bundling work off NPM packages to avoid having to copy external terminologies around).

TODO: For SUSHI use, because SUSHI places local terminology in the fsh-generated-resources folder, the local terminology will need to be copied to the `input\vocabulary` folder. If the IG is also configured to pick terminology up from there, a `local` sub-folder could be established to make the vocabularies available to the unit testing and bundling tooling.