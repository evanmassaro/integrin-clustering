##Further Ideas/Nuances to Check

Initial active site population varies. May want to fix random number sequence across all trial simulations to reduce noise

Units in optimized code may not match yet for Metropolis-Hastings algorithm for acceptance rate, unit energy

Verify how I am interpolating new positions for integrins in deformed membrane, how this is used later at each step of kinetic monte carlo
-This is used in graphics, but never passed to integral positions

Changed indexing for equilibrium distance stored in 3D matrix, verify energy functions use this correctly

Could change the number of MCS steps based on the distance d from a ligand to speed up code.

Each time bond forms or ruptures, calculate kinetic rates at all possible locations, save in matrix. Update each integrin rate only each time active one moves or bond forms/ruptures.

Don't compute reaction rates each time, only for the one integrin that moves or changes states.
