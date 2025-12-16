# thesis-doc-satelital

This repository contains MATLAB scripts used to process and analyze
satellite-derived CDOM (adg_443) time series for major Colombian rivers,
based on text-file exports generated with SeaDAS.

The code was developed as part of a Master's thesis in Earth Sciences
focused on dissolved organic carbon dynamics in the Colombian Caribbean.

---

## Repository structure

thesis-doc-satelital/
├── scripts/
│ └── SourceCode.m # Main analysis script
├── source/
│ ├── obtain_adg_443.m # Reads monthly SeaDAS text files
│ ├── calpot.m # Time series processing and gap filling
│ ├── boxplots.m # Visualization utilities
│ └── readme.txt
├── data/
│ ├── readme.md # Description of raw data structure
│ └── raw/ # Raw data directory (not included)
└── .gitignore

## Data availability

Raw satellite data are **not included** in this repository due to data volume
and satellite data usage policies.

The scripts expect the raw data to be organized as:

data/raw/<RiverName>/<YEAR>/<MONTH>.txt

Details about the expected data format and structure are provided in
`data/readme.md`.

---

## Usage

The main analysis is executed from:

scripts/SourceCode.m

Before running the script, users must edit the variable `baseDir` to point
to their local raw data directory corresponding to the selected river.

The code was tested using MATLAB R2025b. With the following packages

Statistics and Machine Learning Toolbox
Signal Processing Toolbox
Data adquisition Toolbox


---

## Notes

This repository provides the **processing workflow and analysis code only**.
It is intended to support transparency and reproducibility of the methods
used in the associated thesis and manuscript.

