%% Initializing variable constants and extent of simulation
%dbstop if error
    clc; clear;
    addpath('Graphics')
    addpath('Curve Fits')  
    addpath('Tests')
    
% Specify parameters to vary
    
    numSim = 3; % Number of simulations. 
    k_factor = [10, 20, 40]; % Note: k_mem = k_factor*k_gly; where k_gly = 0.02 pN/nm currently fixed.
    d_separation = 16*ones(numSim,1); % Note: del_gly = del_bond + d_separation; where del_bond = 27 nm currently fixed.
    num_bonds = 30*ones(numSim,1); % Simulate 30 consecutive bond formations
    
    versions = ones(numSim,1);

%% Error checking in set up
    assert( numSim == length(d_separation) )
    assert( numSim == length(k_factor) )
    assert( numSim == length(versions) )

%% Parallelized model
    parfor i = 1:numSim
        d_local = d_separation(i);
        k_local = k_factor(i);
        bonds_local = num_bonds(i);
        version_local = num2str(versions(i));
        getRelationships_v2(bonds_local, d_local, k_local, version_local)
        fprintf('Combination %d done. \n', i)
    end
    
