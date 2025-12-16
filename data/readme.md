# Data description

This directory describes the raw input data used in the analysis.
Raw data files are not included in this repository.
For reference to download the satellital image

Copernicus Marine Service. Global
ocean colour (copernicus-globcolour),
bio-geo-chemical, l4 (monthly and interpolated)
from satellite observations
(1997–ongoing). E.U. Copernicus Marine
Service Information (CMEMS), Marine
Data Store, 2025.
---

## Data origin

The input data consist of satellite-derived variables exported from **SeaDAS**
after manual pixel selection over predefined river-mouth regions. 

The SeaDAS exports were generated for:
- CDOM-related products (e.g., adg_443, CDM)
- Sea Surface Temperature (SST)

---

## Folder structure

Raw data are expected to follow the structure:

data/raw/
 ├─ Atrato/
 ├─ CDD/
 ├─ Magdalena/
 └─ Sinu/

Each river folder contains subfolders organized by year (1997–2021),
with monthly `.txt` files 

---

## File format

Each `.txt` file contains pixel values extracted from SeaDAS and includes
the following columns (among others):

- longitude
- latitude
- CDM / BBP
- uncertainty fields
- quality flags

Processed time series are obtained by spatial averaging of the selected pixels.

---

## Data availability

Due to data size and satellite data policy constraints, raw `.txt` files are
not included in this repository.

To reproduce the analysis, users must export the data from SeaDAS and place
the files following the folder structure described above.