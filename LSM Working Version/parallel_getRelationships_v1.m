%% Initializing variable constants and extent of simulation
%dbstop if error
    clc; clear;
    addpath('Graphics')
    addpath('Curve Fits')  
    addpath('Tests')
    
% Specify parameters to vary
    
    numSim = 3; % Number of simulations. 
    k_factor = [10, 20, 40]; % Note: k_mem = k_factor*k_gly;
    d_separation = 16*ones(numSim,1); % Note: del_gly = del_bond + d_separation;
    num_bonds = 30*ones(numSim,1); % Simulate 30 bonds form. 
    
    versions = ones(numSim,1); % After ~5 bonds, most the the points in the deformation v force and energy plots have small
    %deformation. It could be more accurate to repeat a couple more experiments of the first ~5 bond formations to get a more
    % accurate overall fit, and then concatenate all the data into one mat file per system parameters.

%% Error checking in set up
    assert( numSim == length(d_separation) )
    assert( numSim == length(k_factor) )
    assert( numSim == length(versions) )

%% Parallelized model
% global positions
    for i = 1:1
        d_local = d_separation(i);
        k_local = k_factor(i);
        bonds_local = num_bonds(i);
        version_local = num2str(versions(i));
        getRelationships_v2(bonds_local, d_local, k_local, version_local)
        fprintf('Combination %d done. \n', i)
    end
    
