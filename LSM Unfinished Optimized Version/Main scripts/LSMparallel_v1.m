%% Initializing variable constants and extent of simulation
    clc; clear;
    addpath('Graphics')
    addpath('Curve Fits')
    addpath('Tests')
    
%% Specify parameters to vary
    simulationTimes = [0.02 0.02 0.02 0.02];
    d_separation = [16 16 16 16];
    ligDen = [200 200 1000 1000];
    k_E = [0 40 0 40];
    
    numSimulations = length(ligDen);

%% Error checking in set up
    assert( length(ligDen) == length(d_separation) )
    assert( length(ligDen) == length(k_E) )
    assert( length(ligDen) == length(simulationTimes) )

%% Parallelized model

    parfor i = 1:numSimulations
        
        % local version of variables
        stop_local = simulationTimes(i);
        d_local = d_separation(i);
        lig_local = ligDen(i);
        k_local = k_E(i);
        
        % Run model and return results
        LSMmodel_v4_3(stop_local, d_local, lig_local, k_local);
    end
    