# CQF Tooling Inclusion

This readme documents the changes made to this repository to support inclusion of measure examples in the PA IG.

1. Reference CQF Measures IG to support the use of profiles for measure specification resources (TODO, QM IG 4 is not yet published)
1. Add `_updateCQFTooling` and `_refresh` scripts to support the use of CQF Tooling to process library and measure resources
1. Add `input\cql` folder to support CQL library source for measure specifications
1. Add `input\cql\cql-options.json` file to specify default configuration for CQL libraries
1. Add `input\cql\Test.cql` file to illustrate test measure library
1. Add `input\resources\library` and `measure` folders to support Library and Measure resources
1. Add `tests\measure` folder to support VS Code unit testing of measure logic
1. Add `vocabulary\valueset` folder to support VS Code unit testing of measure logic

See the README.md files in each of these directories for questions to be answered about how SUSHI vs CQF Tooling processing can be addressed.

CQF Tooling will:

1. Translate all CQL libraries and create/update Library resources for each CQL library in the `input\cql` directory
2. Update Measure resources for any measure in the `input\resources\measure` folder
3. Bundle Measure specifications and place the result in the `bundles\measure` folder

To run CQF Tooling:

1. Ensure the CQFTooling binary is downloaded by running `_updateCQFTooling`
2. Run the `_refresh` script to update Library and Measure resources and resulting bundles

