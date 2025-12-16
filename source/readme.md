This folder contains MATLAB functions used by the main analysis scripts.

Function list:

- obtain_adg_443.m
  Reads monthly SeaDAS-exported text files and extracts adg_443 (CDM) values
  for a target pixel defined by Pixel_X and Pixel_Y.

- calpot.m
  Processes adg_443 time series and computes DOC-related variables,
  including gap filling and temporal alignment.

- boxplots.m
  Generates boxplot visualizations of the processed time series.

These functions are called by the scripts located in the /scripts folder.