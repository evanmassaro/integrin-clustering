function [Nodes_S,Integrins_S,tau] = dynamicModel(K,Del,System,Coordinates,Reactions,Fits,Nodes_S,Integrins_S)

    
    % Instead of doing this for all sites, we could only update changed states    
    [k_forward, k_reverse] = calculateBondRates_v4(K,Del,System,Coordinates,Reactions,Fits,Nodes_S,Integrins_S);

    [index, state, mu, tau, reactionMatrix] = determineReaction_v3(Reactions,Integrins_S,k_forward, k_reverse);

                                     
    [Nodes_S,Integrins_S] = transitionStates_v4(K,Del,System,Coordinates,Reactions,Fits,...
                                                 Nodes_S,Integrins_S,index,state,mu);
                                        
end