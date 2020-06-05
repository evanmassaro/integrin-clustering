%% Initializing variable constants and extent of simulation
%dbstop if error
    clc; clear;
    addpath('Graphics')
    addpath('Curve Fits')  
    addpath('Tests')
    
% Specify parameters to vary
    
    numSim = 72;
    k_factor = zeros(numSim,1);
    d_separation = 16*ones(numSim,1);
    num_bonds = 5*ones(numSim,1);
    num_bonds(1:12) = 30;
    
    versions = zeros(numSim,1);
    
    v = 1;
    for i = 1:numSim
        type = mod(i,3);
        if type == 0
            type = 3;
        end
        
        if mod(i,6) == 1
            versions(i:i+5) = v;
            v = v + 1;
        end
        
        if type == 1
            k_factor(i) = 10;
            
            if mod(i,2) == 0
                d_separation(i:i+2) = 16;
            else
                d_separation(i:i+2) = 14;
            end
                
        elseif type == 2
            k_factor(i) = 20;
        else
            k_factor(i) = 40;
        end
        
    end

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
    