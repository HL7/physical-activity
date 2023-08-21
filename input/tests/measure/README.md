# Tests

The `tests` folder supports VS Code execution of unit tests for CQL libraries. Under the `tests` folder, a `measure` folder is used to identify measure unit tests. Within this folder, each measure under test will have a folder with a name corresponding to the name of the CQL Library (`Test` in this case).

Each folder in the `input\tests\measure\Test` folder represents a single patient use case. The name of the folder must match the logical `id` of the patient resource. Any resources in the directory will be loaded and made available to the CQL engine to execute the test.

TODO: Establish unit tests using the example data from the IG