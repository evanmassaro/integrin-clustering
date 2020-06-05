function withinCutOff = ligandIntegrinDistance_v2(activeSite,ligSites)
    
global integrinPositions positions
global numWidth del_sub

    roundNearest = 20;
    cutOff = 10;
        
    activePositionX = integrinPositions(activeSite,1);
    activePositionY = integrinPositions(activeSite,2);

    roundedX = round(activePositionX/roundNearest)*roundNearest;
    roundedY = round(activePositionY/roundNearest)*roundNearest;

    siteX = roundedX/del_sub;
    siteY = roundedY/del_sub;
    baseNode = siteX+numWidth*siteY+1;

    %scatter3(positions(baseNode,1),positions(baseNode,2),44,20,'MarkerEdgeColor','k','MarkerFaceColor','k');

    possibleXYPositions = positions(baseNode,:);

    found = binarySearch(ligSites, baseNode);
    if found == true
        %scatter3(possibleXYPositions(1),possibleXYPositions(2),44,20,'MarkerEdgeColor','k','MarkerFaceColor','g');

        ligandX = possibleXYPositions(1);
        ligandY = possibleXYPositions(2);

        distance = sqrt((activePositionX-ligandX)^2 + (activePositionY-ligandY)^2); 

        if distance < cutOff
            withinCutOff = true;
            %scatter3(possibleXYPositions(1),possibleXYPositions(2),44,20,'MarkerEdgeColor','k','MarkerFaceColor','r');
        else
            withinCutOff = false;
        end
    else
        withinCutOff = false;
    end

end