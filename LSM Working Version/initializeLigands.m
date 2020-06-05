function ligSites = initializeLigands(ligandDensity)

    global numPlane numPlate del_sub numWidth numDepth endFirstLayer 
    global realNodes totalHeight lengthX lengthY
    
    numNodesInPlane = realNodes(1:length(realNodes)/totalHeight);
    
    ranSites = numNodesInPlane(randperm(length(numNodesInPlane)));

    numLig = floor(lengthX*lengthY*ligandDensity);
    
    ligSites = ranSites(1:numLig) + numPlane*(endFirstLayer-1); 
    ligSites = sort(ligSites);
        
end