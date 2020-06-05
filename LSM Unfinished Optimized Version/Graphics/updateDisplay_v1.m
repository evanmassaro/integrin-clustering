function updateDisplay_v1(System,Del,Nodes_S,Integrins_S)
                      
%% Unpack structure    
    REAL_LENX = System.REAL_LENX;
    REAL_LENY = System.REAL_LENY;
    
    Del_SUB = Del.SUB;
    Del_GLY = Del.GLY;
    
    
    % Unpack nodal quantity arrays
    node_positions = Nodes_S.node_positions;

    % Unpack integrin - ligand quantity arrays
    ligandSites = Integrins_S.ligandSites;
    ligandBoolSites = Integrins_S.ligandBoolSites;
    integrin_positions = Integrins_S.integrin_positions;
    inactiveSites = Integrins_S.inactiveSites;
    activeSites = Integrins_S.activeSites;
    activePSIndices = Integrins_S.activePSIndices;
    bondedSites = Integrins_S.bondedSites;
    bondedPSIndices = Integrins_S.bondedPSIndices;
%%
    cla; 
    figure(1);
    axis square
    grid off
    box on
    
    x_limits = [0, REAL_LENX];
    y_limits = [0, REAL_LENY];
    z_limits = [0, Del_GLY*1.1];
    xlim(x_limits)
    ylim(y_limits)
    zlim(z_limits)
    xticks(linspace(x_limits(1),x_limits(2),3))
    yticks(linspace(y_limits(1),y_limits(2),3))
    
    %% SHIFT POSITIONS JUST FOR VISUALIZATION
    integrin_positions(:,1:2) = integrin_positions(:,1:2) - Del_SUB;
    node_positions(:,1:2) = node_positions(:,1:2) - Del_SUB;

    %%
    
    view(2)
    displayNodes_v6(System,Del,node_positions);
    
    integrin_positions = interpolatedSurface_v2(System, node_positions, integrin_positions);
    displayIntegrins_v3(integrin_positions,inactiveSites, activeSites, bondedSites)
    
    %displayLigands_v2(node_positions, ligandSites);
    set(gca,'fontsize',14)
    pause(0);



end