function  integrinActivation_v1()

    global integrinPositions ka kd
    global inactiveSites activeSites
    global inactive_Count active_Count
   
    numSites = size(integrinPositions,1);
    
    prob_steady = ka/(ka+kd);
    
    active_Count = 0; inactive_Count = 0;  
    activeSites = zeros(1,numSites);
    inactiveSites = zeros(1,numSites);
    
    for i = 1:numSites
        %More likely to be inactive
        if prob_steady < rand 
            inactive_Count = inactive_Count + 1;
            inactiveSites(inactive_Count) = i;
        else
            active_Count = active_Count + 1;
            activeSites(active_Count) = i;
        end
    end
    
    inactiveSites = inactiveSites(inactiveSites > 0);
    activeSites = activeSites(activeSites>0);
end
