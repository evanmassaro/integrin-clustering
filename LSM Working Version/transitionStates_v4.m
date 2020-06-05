function transitionStates_v4(index,state,mu, e_direction, forceC, energyC)

    global inactiveSites activeSites bondedSites
    global activePSIndices savedStates bondedPSIndices
    global reactionVector k_forward k_reverse
    
    numReactions = 6;

    % Change state of integrin according to the reaction
    switch state
        case 'Inactive'
            switch mu
                %Switch from inactive to active state
                case 1
                    activeSites = [activeSites inactiveSites(index)]; % Transition to active state  
                    inactiveSites(index) = []; % Remove from inactive list
                    
                    activePSIndices = getIntegrinPSIndices_v2();
                    updateBondRates_v4(forceC, energyC, 1:length(activeSites), 1:length(bondedSites))
                    reactionVector = calculateReactionVector_v1();
                case 2
                    % Do nothing
                case 5
                    hopDiffusion_v4(inactiveSites(index))
                case 6
                    electroDiffusion_v1(inactiveSites(index), e_direction)
                otherwise 
                    error('Impossible Reaction')
                    
            end
            
        case 'Active'
            %Switch from active to inactive or bounded
            switch mu
                case 1
                    % Do nothing
                % Switch from active to inactive state
                case 2
                    inactiveSites = [inactiveSites activeSites(index)]; % Transition to inactive state
                    activeSites(index) = []; % Remove from inactive list
                    
                    % Must update new indices for active integrins
                    activePSIndices = getIntegrinPSIndices_v2();
                    
                    updateBondRates_v4(forceC, energyC, 1:length(activeSites), 1:length(bondedSites))
                    reactionVector = calculateReactionVector_v1();
                case 3
                    % Do nothing
                    
                case 4  
                    occupied = siteOccupied_v1(bondedPSIndices, activePSIndices(index));
                    
                    % Throw error for debugging purposes
                    assert(occupied == false)
                    
                    % This also updates bondedPSIndices
                    activateBonds_v5(activeSites(index));             
                    bondedSites = [bondedSites activeSites(index)]; % Transition to bonded state 
                    
                    [sampleRegion, MCSteps] = getSamplingRegion_v1(activePSIndices(index));               
                    
                    activeSites(index) = []; % Remove from active list  
                    savedStates = false; 
 
                    minimizeSystemEnergy_v4(sampleRegion,MCSteps);
                    
                    % Must update new indices for active integrins
                    activePSIndices = getIntegrinPSIndices_v2();
                    
                    updateBondRates_v4(forceC, energyC, 1:length(activeSites), 1:length(bondedSites))
                    reactionVector = calculateReactionVector_v1();
                case 5
                    hopDiffusion_v4(activeSites(index))
                    % Must update new indices for active integrins
                    activePSIndices = getIntegrinPSIndices_v2();
                    
                    updateBondRates_v4(forceC, energyC, index, [])
                    reactionVector(numReactions*(length(inactiveSites)+index)-2) = k_forward(index);
                    reactionVector(numReactions*(length(inactiveSites)+index)-3) = k_reverse(index);
        
                case 6
                    electroDiffusion_v1(activeSites(index), e_direction)
                    % Must update new indices for active integrins
                    activePSIndices = getIntegrinPSIndices_v2();
                    
                    updateBondRates_v4(forceC, energyC, index, [])
                    reactionVector(numReactions*(length(inactiveSites)+index)-2) = k_forward(index);
                    reactionVector(numReactions*(length(inactiveSites)+index)-3) = k_reverse(index);
                otherwise 
                    error('Impossible Reaction')
            end
            
        case 'Bonded'
            switch mu
                %Switch from bonded to unbonded state
                case 3
                    activeSites = [activeSites bondedSites(index)]; % Transition to active state 

                    [sampleRegion, MCSteps] = getSamplingRegion_v1(bondedPSIndices(index));
                    
                    % This also removes bondedPSIndices
                    deactivateBonds_v1(index);
                    bondedSites(index) = []; % Remove from inactive list
                    minimizeSystemEnergy_v4(sampleRegion,MCSteps);

                        savedStates = false;

                    activePSIndices = getIntegrinPSIndices_v2();
                    updateBondRates_v4(forceC, energyC, 1:length(activeSites), 1:length(bondedSites))
                    reactionVector = calculateReactionVector_v1();
                case 4
                    % Do nothing
                otherwise 
                    error('Impossible Reaction')
            end
        otherwise 
            error('Invalid state')
            
    end   
    
    
end