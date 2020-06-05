function displayIntegrins_v3()

    mSize = 50; 
    mWidth = 2;
    
    global integrinPositions
    global inactiveSites activeSites bondedSites
   
    dispLen = 0.5;  
    
    if isempty(bondedSites) == false 
        % Display bonded sites
        bonded_X = integrinPositions(bondedSites,1);
        bonded_Y = integrinPositions(bondedSites,2);
        bonded_Z = integrinPositions(bondedSites,3)+dispLen;

        color_bonded= [0.7 0.2 0.2];
        scatter3(bonded_X, bonded_Y, bonded_Z, mSize,...
            'MarkerEdgeColor','k','MarkerFaceColor',color_bonded,'LineWidth',mWidth);
    end
    
%     if isempty(inactiveSites) == false
%         % Display inactive sites
%         inactive_X = integrinPositions(inactiveSites,1);
%         inactive_Y = integrinPositions(inactiveSites,2);
%         inactive_Z = integrinPositions(inactiveSites,3)+dispLen;
% 
%         color_inactive = [1 0.65 0];
%         scatter3(inactive_X, inactive_Y, inactive_Z, mSize,...
%             'MarkerEdgeColor','k','MarkerFaceColor',color_inactive,'LineWidth',mWidth);
%     end
    
    if isempty(activeSites) == false
        % Display active sites
        active_X = integrinPositions(activeSites,1);
        active_Y = integrinPositions(activeSites,2);
        active_Z = integrinPositions(activeSites,3)+dispLen;

        color_active = [0.2 0.8 1];
        scatter3(active_X, active_Y, active_Z, mSize,...
            'MarkerEdgeColor','k','MarkerFaceColor',color_active,'LineWidth',mWidth);
    end
    

end