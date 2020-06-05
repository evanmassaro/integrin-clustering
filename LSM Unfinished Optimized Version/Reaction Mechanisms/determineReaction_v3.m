function [index, state, mu, tau, reactionMatrix] = determineReaction_v3(Reactions,Integrins_S,k_forward, k_reverse)
               
    inactiveSites = Integrins_S.inactiveSites;
    activeSites = Integrins_S.activeSites;
    bondedSites = Integrins_S.bondedSites;
                
    k_A   = Reactions.k_A;
    k_D   = Reactions.k_D;
    k_HOP = Reactions.k_HOP;
    k_E   = Reactions.k_E;
 
    NUM_REACTIONS = Reactions.NUM_REACTIONS;
    
    numInactive = length(inactiveSites);
    numActive = length(activeSites);
    numBonded = length(bondedSites);
    numNotBonded = length(inactiveSites) + length(activeSites);
    NUM_INTEGRINS = Reactions.NUM_INTEGRINS;
    
    assert(numInactive+numActive+numBonded == NUM_INTEGRINS)
    
    
    reactionMatrix = zeros(NUM_INTEGRINS,NUM_REACTIONS);

%% Reaction indexing scheme
% 1. Thermal diffusion
% 2. Bond formation
% 3. Electrophoretic diffusion
% 4. Integrin deactivation
% 5. Integrin activation 
% 6. Bond rupture

    inactiveRates = [k_HOP 0 k_E k_D k_A 0];
    reactionMatrix(1:numNotBonded,:) = repmat(inactiveRates,numNotBonded,1);
    reactionMatrix(numInactive+1:end,2) = k_forward;
    reactionMatrix(numInactive+1:end,6) = k_reverse;
    
        
    total = sum(reactionMatrix(:));
    partialTarget = rand*total;
    
    % Determine most likely reaction
    partial_array = cumsum(reactionMatrix(:));
    i = find(partial_array > partialTarget,1,'first');
    

    % return integrin where reaction occurs
    integrin = mod(i,NUM_INTEGRINS);
    if integrin == 0
        integrin = NUM_INTEGRINS;
    end
    
    % return elapsed time
    tau = -log(rand)/total;
   
    % return reaction that occurs
    mu = ceil(i/NUM_INTEGRINS);
    
    % determine original state of integrin
    if integrin <= length(inactiveSites)
        index = integrin;
        state = 'Inactive';
    elseif integrin <= length(inactiveSites)+length(activeSites)
        index = integrin - length(inactiveSites);
        state = 'Active';
    else
        index = integrin - length(inactiveSites)-length(activeSites);
        state = 'Bonded';
    end
   
end    
    