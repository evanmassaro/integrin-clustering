function [index, state, mu, tau, e_direction] = determineReaction_v4(simTime, polarity, k_E)
    
    global activeSites inactiveSites bondedSites
    global k_electric reactionVector
 
    numReactions = 6;
    % Set k_electric and direction. Is this necessary to update each time?
    e_direction = setPulseState_v1(simTime, polarity, k_E);
    reactionVector(numReactions:numReactions:numReactions*(length(inactiveSites)+length(activeSites))) = k_electric;
    
    mod_simTime = mod(simTime, 1);
    
    %% Determine elapsed time
    if  polarity == 0 || (mod_simTime > 0.1 && mod_simTime < 0.9) %max(tau) ~ 10^(-3) s
        tau = -log(rand)/sum(reactionVector);
    else
        tau = reactionTime_v1(simTime, reactionVector);
        
        e_direction = setPulseState_v1(simTime+tau, polarity, k_E);
        reactionVector(numReactions:numReactions:numReactions*(length(inactiveSites)+length(activeSites))) = k_electric;
    end

    [mu, ind] = sampleReaction(reactionVector);
   
    % return integrin reaction occurs
    integrin = ceil(ind/numReactions);
    
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
    