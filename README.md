# Integrin-Clustering  
Electro-chemo-mechanical model to investigate multi-pulse electric-field-driven integrin clustering  
[![DOI](https://zenodo.org/badge/269767974.svg)](https://zenodo.org/badge/latestdoi/269767974)

* Working version contains the simulations used in publications.
* The Post-processing contains the summarized data output from the simulations, as well as plot functions.
* Optimized version contains the begininnging of a restructured model, which is currently incomplete.

# Running Models
To run one simulation, one could call [LSMmodel_v4_3](integrin-clustering/LSM\ Working\ Version/LSMmodel_v4_3.m). This function contains the default system parameters, as well as takes additional arguments for common parameters that are varied. However, for a simpler introduction, we first suggest calling [LSMparallel_v1](LSM\ Working\ Version/LSMparallel_v1.m), which is a wrapper that introduces the additional, necessary parameters.
In this function one specifies the parameter values of interest, and the number of repeated trials.
After satisfied with the parameter choices, one calls [LSMparallel_v1](LSM\ Working\ Version/LSMparallel_v1.m) to initiate the simulations. It is simplest for an introduction if one keeps $d_separation = 16 or 14 nm, and k_mem = 0.2, 0.4, or 0.8 pN/nm<sup>1</sup>.

# Interpretting Data
The simulation outputs all data in a folder with a name identifying the parameter values. Data from each simulation is stored by default every simulated second. By analyzing the saved output data, you can also choose to stop the simulations early if necessary.
The saved data contains two important arrays of interest up until that simulated time: Ripley's L statistic 'LMatrix' and the bond fraction 'bondFrac'. 
These two metrics can quantify spatial and temporal changes in integrin clustering as a function of the input parameters.
We suggest using the most recent saved data output, as it contains the most temporal information for the bond fraction and the L statistic as a function of time.
One can then post processed this data to find measurable changes in the clustering characteristics.

*<sup>1</sup>Note: For each set of mechanical parameters (e.g. d_separation and k_mem), integrin-ligand distance depdendent forces need to be precomputed as a function of compression. Some common parameter configurations are stored in [Curve Fits](LSM\ Working\ Version/Curve Fits/) (e.g. k_mem = 0.2, 0.4, 0.8 pN/nm; d_separation = d_glycocalyx - d_bond = 43nm - 27nm = 16nm or 41nm - 27 nm = 14 nm). See [README](LSM\ Working\ Version/README.md) for precomputed details for other choices of mechanical properties*
