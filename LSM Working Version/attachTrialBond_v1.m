function attachTrialBond_v1(index)

    global numPlane positions integrinPositions activePSIndices activeSites
    global allSprings allDistances 
    global k_bond k_gly del_bond
    global positiveZ negativeZ  
    
    zCordinate = 3;
    
    integrinPSIndex = activePSIndices(index);
    ligandIndex = integrinPSIndex - numPlane;
               
    allSprings(ligandIndex,positiveZ) =  k_bond;
    allSprings(integrinPSIndex,negativeZ) =  k_bond;
    
    
    allDistances(ligandIndex,positiveZ,zCordinate) =  del_bond;
    allDistances(integrinPSIndex,negativeZ,zCordinate) =  del_bond;
    
    integrinPositions(activeSites(index),:) = positions(integrinPSIndex,:);

end
