The [LSMmodel_v4_3](LSMmodel_v4_3.m) contains the main model, which [LSMparallel_v1](LSMparallel_v1.m) wraps around for performing each simulation in parallel.
Note for new simulations with unseen mechanical parameters specified in [LSMparallel_v1](LSMparallel_v1.m), force-distance relationships must be found, and stored in the Curve Fits folder. These are computed with the simple wrapper [parallel_getRelationships](parallel_getRelationships_v1.m), where one inputs the mechanical properties such as the glycocalyx thickness or membrane stiffness. After obtaining the new data, place the folder in the Curve Fits directory.

The speed of the simulations by [LSMmodel_v4_3](LSMmodel_v4_3.m) could probably be significantly improved, as the project is based on Matlab code from my undergraduate career.
Some optimizations did begin to take place in the Optimized folder, such as removing global variables and unrolling small for loops. Ideas for algorithmic speedup are also explored.
