function updateDisplay_v1()
    global positions ligSites del_sub numWidth del_gly numHeight activePSIndices bondedPSIndices
    cla
    figure(1)
    displayNodes_v6(positions);
    interpolatedSurface_v2()
    displayIntegrins_v3();
    
    
    mSize = 20;
    mWidth = 2;
    % For better display added del_sub/20 term to the ligand and integrin positions
    L = positions(activePSIndices,:);
    % Ligands
    scatter3(L(:,1), L(:,2), L(:,3),mSize,'MarkerEdgeColor','k',...
        'MarkerFaceColor','b','LineWidth',mWidth);
    L = positions(bondedPSIndices,:);
    % Ligands
    scatter3(L(:,1)-5, L(:,2)-5, L(:,3),mSize,'MarkerEdgeColor','k',...
        'MarkerFaceColor','r','LineWidth',mWidth);
    

    
    set(gca,'fontsize',18)
    pause(0);
    rotate3d on

%     axis([-del_sub, numWidth*del_sub, -del_sub, numWidth*del_sub, 0, del_sub*numHeight + del_gly*1.1]);

end