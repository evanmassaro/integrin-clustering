function [Nodes_S,Integrins_S] = transitionStates_v4(K,Del,System,Coordinates,Reactions,Fits,...
                                                 Nodes_S,Integrins_S,old_index,old_state,mu)
%% unpack structures                                                 
                                             
    % Unpack nodal quantity arrays
    node_positions = Nodes_S.node_positions;
    realNodes = Nodes_S.realNodes;
    virtualNodes = Nodes_S.virtualNodes;
    virtualMap = Nodes_S.virtualMap;
    allNeighbors = Nodes_S.allNeighbors;
    allSprings = Nodes_S.allSprings;
    allDistances = Nodes_S.allDistances;

    % Unpack integrin - ligand quantity arrays
    ligandSites = Integrins_S.ligandSites;
    ligandBoolSites = Integrins_S.ligandBoolSites;
    integrin_positions = Integrins_S.integrin_positions;
    inactiveSites = Integrins_S.inactiveSites;
    activeSites = Integrins_S.activeSites;
    activePSIndices = Integrins_S.activePSIndices;
    bondedSites = Integrins_S.bondedSites;
    bondedPSIndices = Integrins_S.bondedPSIndices;
    
%% Reaction indexing scheme
    % 1. Thermal diffusion
    % 2. Bond formation
    % 3. Electrophoretic diffusion
    % 4. Integrin deactivation
    % 5. Integrin activation 
    % 6. Bond rupture

    % Change state of integrin according to the reaction
    switch old_state
        case 'Inactive'
            switch mu
                case 1 % Diffuse inactive integrin by modifying integrin positions
                    integrin_positions = hopDiffusion_v4(System,Del,Coordinates,Reactions,...
                                            integrin_positions,inactiveSites(old_index));  
                                        
                case 3 % Diffuse inactive integrin by modifying integrin positions
                    integrin_positions = electroDiffusion_v1(System,Del,Coordinates,Reactions,...
                                            integrin_positions,inactiveSites(old_index));
                                        
                case 5 % Switch from inactive to active state
                    newActivePSIndex = getIntegrinPSIndices_v2(System, Del, integrin_positions, inactiveSites(old_index)); 
                    activePSIndices = [activePSIndices; newActivePSIndex];               
                    activeSites = [activeSites; inactiveSites(old_index)]; % Transition to active state  
 
                    inactiveSites(old_index) = []; % Remove from inactive list  
                    
            end
            
        case 'Active'
            %Switch from active to inactive or bounded
            switch mu
                case 1 % Diffuse active integrin by modifying integrin positions
                    integrin_positions = hopDiffusion_v4(System,Del,Coordinates,Reactions,...
                                            integrin_positions,activeSites(old_index));
                                        
                    activePSIndices(old_index) = getIntegrinPSIndices_v2(System, Del, integrin_positions, activeSites(old_index));
                    
                case 3 % Diffuse active integrin by modifying integrin positions
                    integrin_positions = electroDiffusion_v1(System,Del,Coordinates,Reactions,...
                                            integrin_positions,activeSites(old_index));
                        
                    activePSIndices(old_index) = getIntegrinPSIndices_v2(System, Del, integrin_positions, activeSites(old_index));
                    
                case 4 % Switch from active to inactive state
                    inactiveSites = [inactiveSites; activeSites(old_index)]; % Transition to inactive state                   
                    
                    activeSites(old_index) = []; % Remove from inactive list
                    activePSIndices(old_index) = [];
                    
                case 2 % Switch from active to bonded state  
                    [node_positions,allSprings,...
                     allDistances,integrin_positions] = activateBonds_v5(K,Del,System,Coordinates,Nodes_S,Integrins_S,...
                                                                        activeSites(old_index),activePSIndices(old_index));
                                                        
                    bondedSites = [bondedSites; activeSites(old_index)]; % Transition to bonded state 
                    bondedPSIndices = [bondedPSIndices; activePSIndices(old_index)];
%                     [sampleRegion, MCSteps] = getSamplingRegion_v1(activePSIndices(index));               
                    
%                     minimizeSystemEnergy_v4(sampleRegion,MCSteps);

                    activeSites(old_index) = []; % Remove from active list 
                    activePSIndices(old_index) = [];
            end
            
        case 'Bonded'  
            if mu == 6 % Switch from bonded to active state
                activeSites = [activeSites; bondedSites(old_index)]; % Transition to active state 
% %                 [sampleRegion, MCSteps] = getSamplingRegion_v1(bondedPSIndices(index));
%                 deactivateBonds_v1(index);
% %                 minimizeSystemEnergy_v4(sampleRegion,MCSteps);

                activePSIndices = [activePSIndices; bondedPSIndices(old_index)];
                bondedSites(old_index) = []; % Remove from inactive list
                bondedPSIndices(old_index) = [];
            end
        otherwise 
            error('Invalid state')         
    end   

%% Repack structures

    Nodes_S.node_positions = node_positions;
    Nodes_S.realNodes = realNodes;
    Nodes_S.virtualNodes = virtualNodes;
    Nodes_S.allNeighbors = allNeighbors;
    Nodes_S.allSprings = allSprings;
    Nodes_S.allDistances = allDistances;

    Integrins_S.integrin_positions = integrin_positions;
    Integrins_S.inactiveSites = inactiveSites;
    Integrins_S.activeSites = activeSites;
    Integrins_S.activePSIndices = activePSIndices;
    Integrins_S.bondedSites = bondedSites;
    Integrins_S.bondedPSIndices = bondedPSIndices;
    
end