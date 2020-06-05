function addLigandIntegrinBonds_v4(ligandIndex)

    global numPlane positions
    global allSprings allDistances 
    global k_bond k_gly del_bond
    global positiveZ negativeZ
    
    zCordinate = 3;
    
    integrinPSIndex = ligandIndex + numPlane;
               
    allSprings(ligandIndex,positiveZ) =  k_bond + k_gly;
    allSprings(integrinPSIndex,negativeZ) =  k_bond + k_gly;
    
    
    allDistances(ligandIndex,positiveZ,zCordinate) =  del_bond;
    allDistances(integrinPSIndex,negativeZ,zCordinate) =  del_bond;
    
	positions(integrinPSIndex,zCordinate) = positions(ligandIndex,zCordinate) + del_bond;

end
