function [index, state, mu, tau, e_direction] = determineReaction_v4(simTime, polarity, k_E)
    
    global activeSites inactiveSites bondedSites
    global k_electric reactionVector
 
    numReactions = 6;
    % Set k_electric and direction. Is this necessary to update each time?
    e_direction = setPulseState_v1(simTime, polarity, k_E);
    reactionVector(numReactions:numReactions:numReactions*(length(inactiveSites)+length(activeSites))) = k_electric;
    
    mod_simTime = mod(simTime, 1);
    
    %% Determine elapsed time
    % to make sure we don't miss burst activity, hard cutoff at 0.1 and 0.9 seconds of each 1 Hz cycle.
    if  polarity == 0 || (mod_simTime > 0.1 && mod_simTime < 0.9) %max(tau) ~ 10^(-3) s
        tau = -log(rand)/sum(reactionVector);
    else
        % determine time by time-dependent reaction rates
        tau = reactionTime_v1(simTime, reactionVector);
        
        e_direction = setPulseState_v1(simTime+tau, polarity, k_E);
        reactionVector(numReactions:numReactions:numReactions*(length(inactiveSites)+length(activeSites))) = k_electric;
    end
    
    % determine most probable reaction
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
    
