%% Initializing variable constants and extent of simulation

    clc; clear all;
    addpath(genpath(pwd))
    
    % Specify parameters to vary
    numSims = 12; # Number of parallel simulations. I dedicated one simulation per CPU core.
    simulationTimes = 120*ones(1,numSims); % 120 seconds (Very overkill. Can cut simulations early or add logic to complete upon bond saturation)
    d_separation = 16*ones(1,numSims); % nm. distances: d_separation = d_glycocalyx - d_bond 
    ligDen = 500*ones(1,numSims); % 1/(\mu m)^2 ligand density
    E = 10000*ones(1,numSims); % V/cm
    k_E = 40/15*E % 1/s electrophoretic reaction rate
    k_mem = 0.8*ones(1,numSims); % pN/nm membrane spring constant 
    pulse_width = (1000*10^(-6))*ones(1,numSims); % seconds
    polarity = 2*ones(1,numSims); % Convention: 0 = constant, 1 = unipolar, 2 = bipolar
    version = 1:numSims; % This generates 12 trials of the same parameter configuration, with different random initial conditions
    
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
     rng('shuffle') % Needed such that each job is not initialized with same random seed, and return the same simulations
     
        %variables local to each worker
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
     
