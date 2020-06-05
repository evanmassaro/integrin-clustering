function removeTrialBond_v1(index)

    global numPlane positions integrinPositions activePSIndices activeSites
    global allSprings allDistances 
    global k_gly del_gly
    global positiveZ negativeZ  
    
    zCordinate = 3;
    
    integrinPSIndex = activePSIndices(index);
    ligandIndex = integrinPSIndex - numPlane;
               
    allSprings(ligandIndex,positiveZ) = k_gly;
    allSprings(integrinPSIndex,negativeZ) = k_gly;
    
    
    allDistances(ligandIndex,positiveZ,zCordinate) =  del_gly;
    allDistances(integrinPSIndex,negativeZ,zCordinate) =  del_gly;
    
	positions(integrinPSIndex,zCordinate) = positions(ligandIndex,zCordinate) + del_gly;
    integrinPositions(activeSites(index),:) = positions(integrinPSIndex,:);

end
