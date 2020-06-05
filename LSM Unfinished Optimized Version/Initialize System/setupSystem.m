function [K,Del,System,Coordinates,Reactions,Fits,...
            Nodes_S,Integrin_S] = setupSystem(parameter_pairs)
    
    % Initial parameter structures
    [K, Del] = parametersSprings(parameter_pairs);
    System = parametersGeometry(Del,parameter_pairs);
    Coordinates = parametersCoordinates(parameter_pairs);
    Reactions = parametersLigandsAndIntegrins(System,parameter_pairs);
   
    %Find lattice sites
    node_positions = setLattice_v1(System,Coordinates,Del);
    [realNodes, virtualNodes, virtualMap] = getRealNodes_v1(System);

    allNeighbors = getNeighbors_v3(System, Coordinates);
    allSprings = getSprings_v2(System, Coordinates, K);
    allDistances = getDistances_v3(System, Coordinates, Del);

    [ligandSites,ligandBoolSites] = getLigands(System, Reactions, realNodes);
    integrin_positions = getIntegrins(System, Del, Coordinates, Reactions);
    [inactiveSites, activeSites, activePSIndices, ...
                    bondedSites, bondedPSIndices] ...
                = initializeStates_v1(System, Del, Reactions, integrin_positions);

    Fits = getFitCharacteristics_v1(Del,K);
    
    % Polyval was too slow, so I hard coded in 2nd order polynomial evaluation
    assert(length(Fits.forceC) == 3,'Can only use 2nd order polynomials') 
    
    %% Pack array information
    Nodes_S.node_positions = node_positions;
    Nodes_S.realNodes = realNodes;
    Nodes_S.virtualNodes = virtualNodes;
    Nodes_S.virtualMap = virtualMap;
    Nodes_S.allNeighbors = allNeighbors;
    Nodes_S.allSprings = allSprings;
    Nodes_S.allDistances = allDistances;
    
    Integrin_S.ligandSites = ligandSites;
    Integrin_S.ligandBoolSites = ligandBoolSites;
    Integrin_S.integrin_positions = integrin_positions;
    Integrin_S.inactiveSites = inactiveSites;
    Integrin_S.activeSites = activeSites;
    Integrin_S.activePSIndices = activePSIndices;
    Integrin_S.bondedSites = bondedSites;
    Integrin_S.bondedPSIndices = bondedPSIndices;
    

end