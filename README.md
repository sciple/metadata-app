# Metadata-app

GUI for managing MNMS-compliant metadata

> Please review the **code of conduct** (<https://github.com/sciple/metadata-app/blob/main/README.md>) to understand how to behave properly here.

![screenshot of the GUI](screenshot.PNG "Main interface")


## TO DO

- Add global layer (save, load, clear, lock)
- Import data (_.csv_, ._xls_) from AMS export
- Offset newly created windows
- Limit number of windows that can be created
- Export the data as JSON-LD
- Duplicate a cage
- Cage-to-cage connection should be allowed to enable mouse transfer between cages (or cage splitting)
- CRITICAL: audit logging of changes!
- Import pyrat data export (_.csv_)

## Wishlist
- Use llm to SQL for grouping subjects
- Connect to ontology lookup service (<https://www.ebi.ac.uk/ols4>) or OntoBee (<https://ontobee.org/>)
- Enable random allocation of subjects to condition

### 2024-05-25

#### llm queries

Hookup a local llm to the inserted data. the data composed via the interface is exported as structured data. llm reads the data and answers the query via generation of retrieval strings. queries result in "hooks" that can be used to select/filter (visually) the data in the graphical interface. An additional window shows the textual result of the query

### 2024-05-28

#### Pyrat data importer

The importer creates cages and fills each cage with their respective mouse IDs

### 2024-06-01

#### DVC data importer

The importer reads DVC raw data and creates cages (with start-stop date) and populates each cage with its Pyrat IDs

#### Analysis

Quality controls could be performed automatically, while follow-up analyses may be composed using the nodegraphs nodes 

### 2024-06-12

#### Highlight downstream information

Clicking on the title of a window highlights all the downstream connected nodes. all nodes downstream of cage nodes then display the number of subjects that get input from the clicked node and the title of the clicked node is displayed in the downstream results.

Multiple selections could be displayed as a popup table

***

### Colors

_2024-06-20_ Color scheme has been changed to `light`

- #117c9a | Light blue (Background)
- #bc5489 | Pink
- #edf202 | Yellow

### References
- <https://en.wikipedia.org/wiki/Laboratory_information_management_system>
- <https://en.wikipedia.org/wiki/List_of_LIMS_software_packages>
