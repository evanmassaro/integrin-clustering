function PSIndices = getIntegrinPSIndices_v2(System, Del, integrinPositions, integrinSites)
%% System variables
    NUMX = System.NUMX;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    
    Del_SUB = Del.SUB;
    
%% Find nearest node point to active integrins

    roundNearest = Del_SUB;
    
    activePositionX = integrinPositions(integrinSites,1);
    activePositionY = integrinPositions(integrinSites,2);

    roundedX = round(activePositionX/roundNearest)*roundNearest;
    roundedY = round(activePositionY/roundNearest)*roundNearest;

    siteX = roundedX/Del_SUB;
    siteY = roundedY/Del_SUB;
    PSIndices = (siteX + NUMX*siteY + 1) + NUMPLANE*END_FIRST_LAYER;

end



