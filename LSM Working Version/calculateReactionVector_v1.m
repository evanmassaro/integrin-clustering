function reactionVector = calculateReactionVector_v1()
    global inactiveSites activeSites bondedSites
    global ka kd k_hop k_forward k_reverse k_electric
    
    %% Calculate vector of reactions
    numReactions = 6;
    
    k = 1;
    for i = 1:length(inactiveSites)
        reactionVector(k:k+numReactions-1) = [ka kd 0 0 k_hop k_electric];
        k = k + numReactions;
    end
    
    for i = 1:length(activeSites)
        reactionVector(k:k+numReactions-1) = [ka kd k_reverse(i) k_forward(i) k_hop k_electric];
        k = k + numReactions;
    end
    
    for i = 1:length(bondedSites)
        reactionVector(k:k+numReactions-1) = [0 0 k_reverse(i+length(activeSites)) k_forward(i+length(activeSites)) 0 0];
        k = k + numReactions;
    end

end