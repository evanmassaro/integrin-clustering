function deactivateBonds_v1(index)
    
global positions allSprings allDistances del_gly k_gly
global numPlane bondedPSIndices
    
    integrinPSIndex = bondedPSIndices(index);
    ligandIndex = bondedPSIndices(index) - numPlane;
    
    bondedPSIndices(index) = [];
    
    global positiveZ negativeZ
    zCordinate = 3;
               
    allSprings(ligandIndex,positiveZ) =  k_gly;
    allSprings(integrinPSIndex,negativeZ) =  k_gly;
    
    
    allDistances(ligandIndex,positiveZ,zCordinate) =  del_gly;
    allDistances(integrinPSIndex,negativeZ,zCordinate) =  del_gly;
    
	%positions(integrinPSIndex,zCordinate) = positions(ligandIndex,zCordinate) + del_gly;
    
    
end



