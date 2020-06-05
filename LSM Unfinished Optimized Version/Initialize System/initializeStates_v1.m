function  [inactiveSites, ...
           activeSites, activePSIndices, ...
           bondedSites, bondedPSIndices] = initializeStates_v1(System, Del, Reactions, integrinPositions)
%% System variables
    NUM_INTEGRINS = Reactions.NUM_INTEGRINS;
    k_A = Reactions.k_A;
    k_D = Reactions.k_D;
    
%% Get initial population states
    prob_steady_state = k_A/(k_A+k_D);
    
    random = rand(NUM_INTEGRINS,1);
    activeSites = find((random < prob_steady_state) == 1);
    inactiveSites = find((random < prob_steady_state) == 0);
    bondedSites = [];
    
    
 %% Get closest nodal positions
    bondedPSIndices = [];
    activePSIndices = getIntegrinPSIndices_v2(System, Del, integrinPositions, activeSites);

end
