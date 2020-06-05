function integrinPositions = initializeIntegrins(integrinDensity)

    global del_sub del_gly numWidth numDepth endFirstLayer lengthX lengthY
    
    numIntegrins = floor(lengthX*lengthY*integrinDensity);
    integrinPositions = zeros(numIntegrins,3);
    zPosition = (del_sub*(endFirstLayer-1)+del_gly).*(1:numIntegrins)';
    
    xPosition = lengthX*rand(numIntegrins,1)+del_sub/2;
    yPosition = lengthY*rand(numIntegrins,1)+del_sub/2;

    integrinPositions = [xPosition yPosition zPosition];     
    
end