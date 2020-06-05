function activateBonds_v5(index)
    
global positions integrinPositions ligSites 
global numPlane bondedPSIndices del_bond
    
    ligandPositions = positions(ligSites,:);

    integrinX = integrinPositions(index,1);
    integrinY = integrinPositions(index,2);

    ligandX = ligandPositions(:,1);
    ligandY = ligandPositions(:,2);
    
    dimLigands = length(ligandX);
    
    
    distances = zeros(dimLigands,1);
    for j = 1:dimLigands
        distances(j)  = sqrt( (integrinX - ligandX(j) )^2 + (integrinY - ligandY(j))^2 );
    end

    [~, nearestIndex] = min(distances);

    nearestLigand = ligSites(nearestIndex); 
    addLigandIntegrinBonds_v4(nearestLigand); 

    k = nearestLigand + numPlane;
    bondedPSIndices = [bondedPSIndices k];

    nearestLigand = ligSites(nearestIndex); 
    bondedPSIndex = nearestLigand + numPlane;
    positions(bondedPSIndex,3) = positions(nearestLigand,3)+del_bond;
    integrinPositions(index,:) = positions(bondedPSIndex,:);

end



