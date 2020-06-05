LSMmodel_v4_3 contains the main model, which LSMparallel_v1 wraps around for performing each simulation in parallel.
Note for new simulations with unseen mechanical parameters, force-distance relationships must be found, stored in Curve Fits folder. These are computed with getRelationships or parallel_getRelationships



Disclaimer: There is probably a large room to improve the speed of each simulation, as the project is based on Matlab code from my Junior year of college.
Some optimizations have began to take place in the Optimized folder, such as removing global variables and unrolling small for loops. Ideas for algorithmic speedup are also explored.
