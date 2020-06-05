function displayIntegrins_v3(integrin_positions,inactiveSites,activeSites,bondedSites)

    mSize = 20; 
    mWidth = 2;
   
    dispLen = 0.5;  
    
    if isempty(bondedSites) == false 
        % Display bonded sites
        bonded_X = integrin_positions(bondedSites,1);
        bonded_Y = integrin_positions(bondedSites,2);
        bonded_Z = integrin_positions(bondedSites,3)+dispLen;

        color_bonded= [0.7 0.2 0.2];
        scatter3(bonded_X, bonded_Y, bonded_Z, mSize,...
            'MarkerEdgeColor','k','MarkerFaceColor',color_bonded,'LineWidth',mWidth);
    end
    
    if isempty(inactiveSites) == false
        % Display inactive sites
        inactive_X = integrin_positions(inactiveSites,1);
        inactive_Y = integrin_positions(inactiveSites,2);
        inactive_Z = integrin_positions(inactiveSites,3)+dispLen;

        color_inactive = [1 0.65 0];
        scatter3(inactive_X, inactive_Y, inactive_Z, mSize,...
            'MarkerEdgeColor','k','MarkerFaceColor',color_inactive,'LineWidth',mWidth);
    end
    
    if isempty(activeSites) == false
        % Display active sites
        active_X = integrin_positions(activeSites,1);
        active_Y = integrin_positions(activeSites,2);
        active_Z = integrin_positions(activeSites,3)+dispLen;

        color_active = [0.2 0.8 1];
        scatter3(active_X, active_Y, active_Z, mSize,...
            'MarkerEdgeColor','k','MarkerFaceColor',color_active,'LineWidth',mWidth);
    end
    

end