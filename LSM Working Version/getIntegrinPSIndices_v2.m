function activeIndices = getIntegrinPSIndices_v2()
    
global integrinPositions numWidth del_sub activeSites numPlane numHeight

roundNearest = 20;
activeIndices = zeros(length(activeSites),1);
    
    for i = 1:length(activeSites) 
        
        activeSite = activeSites(i);

        activePositionX = integrinPositions(activeSite,1);
        activePositionY = integrinPositions(activeSite,2);

        roundedX = round(activePositionX/roundNearest)*roundNearest;
        roundedY = round(activePositionY/roundNearest)*roundNearest;

        siteX = roundedX/del_sub;
        siteY = roundedY/del_sub;
        activeIndices(i) = (siteX+numWidth*siteY+1) + numPlane*numHeight;

    end    
end



