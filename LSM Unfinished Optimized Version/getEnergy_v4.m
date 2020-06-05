function nodeEnergy = getEnergy_v4(centralNode, ...
                                   listOfNeighbors, ... 
                                   listOfSprings, ...
                                   positions, ...
                                   equilibriumArray)
    
    energy = 0;
    
    for i = 1:length(listOfNeighbors)
        neighborNode = listOfNeighbors(i);
        
        if neighborNode > 0
                       
            displacementVector = abs(positions(centralNode,:) - positions(neighborNode,:));
            distance = norm(displacementVector);
            
            equilibrium = norm(equilibriumArray(i, :));
            
            energy = energy + 1/2*listOfSprings(i)*(equilibrium-distance)^2;
        end
    end
    
    nodeEnergy = energy;
end