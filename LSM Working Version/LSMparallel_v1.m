%% Initializing variable constants and extent of simulation

    clc; clear all;
    addpath(genpath(pwd))
    
%% Specify parameters to vary
    simulationTimes = 120*ones(1,12);
    d_separation = 16*ones(1,12);
    ligDen = 500*ones(1,12);
    k_E = 40/15*10000*ones(1,12);
    k_mem = 0.8*ones(1,12);
    pulse_width = (1000*10^(-6))*ones(1,12);
    polarity = 2*ones(1,12);
    version = [1,2,3,4,5,6,7,8,9,10,11,12];
    
    numSimulations = length(ligDen);

%% Error checking in set up
    assert( length(ligDen) == length(d_separation) )
    assert( length(ligDen) == length(k_E) )
    assert( length(ligDen) == length(simulationTimes) )
    assert( length(ligDen) == length(k_mem) )
    assert( length(ligDen) == length(polarity) )
    assert( length(ligDen) == length(pulse_width) )

%% Parallelized model
     parfor i = 1:numSimulations
%         rng('shuffle') %Need only in Parfor loop
%         %local version of variables
        stop_local = simulationTimes(i);
        d_local = d_separation(i);
        lig_local = ligDen(i);
        k_E_local = k_E(i);
        k_mem_local = k_mem(i);
        pol = polarity(i);
        p_width = pulse_width(i);
        v = version(i);
        
        % Run model and return results
        LSMmodel_v4_3(stop_local, d_local, lig_local, k_E_local, k_mem_local, pol, p_width, v);
     end
     