# Metadata-app

GUI for managing MNMS-compliant metadata

## TO DO

- Add global layer (save, load, clear, lock)
- Import data (_.csv_, ._xls_) from AMS export
- Connect to ontology lookup service (<https://www.ebi.ac.uk/ols4>) or OntoBee (<https://ontobee.org/>)
- Offset newly created windows
- Limit number of windows that can be created
- Export the data as JSON-LD

### 2024-05-25

#### llm queries

Hookup a local llm to the inserted data. the data composed via the interface is exported as structured data. llm reads the data and answers the query via generation of retrieval strings. queries result in "hooks" that can be used to select/filter (visually) the data in the graphical interface. An additional window shows the textual result of the query

### 2024-05-28

#### Pyrat data importer

the importer creates cages and fills each cage with their respective mouse IDs

### 2024-06-01

#### DVC data importer

The importer reads DVC raw data and creates cages (with start-stop date) and populates each cage with its Pyrat IDs

#### Analysis

Quality controls could be performed automatically, while follow-up analyses may be composed using the nodegraphs nodes 

### Colors

- #117c9a | Light blue (Background)
- #bc5489 | Pink
- #edf202 | Yellow
