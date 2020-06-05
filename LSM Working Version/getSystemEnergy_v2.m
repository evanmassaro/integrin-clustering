function systemEnergy = getSystemEnergy_v2(moveableNodes)
    
    global realNodes allNeighbors allSprings allDistances positions nm2m
    
    
    systemEnergy = 0;
    for k = 1:length(moveableNodes)
        
            neighborList = allNeighbors(moveableNodes(k),:);
            springList = allSprings(moveableNodes(k),:);
            distanceArray = squeeze(allDistances(moveableNodes(k),:,:));
        systemEnergy = systemEnergy + getEnergy_v4(moveableNodes(k), neighborList, springList, positions, distanceArray);
    end
    % Sum of each local energy is twice the total system energy
    systemEnergy = systemEnergy/2;
    
end