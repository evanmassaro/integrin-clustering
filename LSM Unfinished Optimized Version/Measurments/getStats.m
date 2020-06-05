function Stats = getStats(System,Nodes_S,Integrins_S,Stats)

 %% Unpack structres       
    REAL_LENX = System.REAL_LENX;
    REAL_LENY = System.REAL_LENY;
    
    integrin_positions = Integrins_S.integrin_positions;
    bondedSites = Integrins_S.bondedSites;
    
    if isempty(Stats)
        LMatrix = [];
        bondFrac = [];
    else
        LMatrix = Stats.LMatrix;
        bondFrac = Stats.bondFrac;
    end
    
%% Calculate statistics
    stepsize = 2;
    s = 1:stepsize:REAL_LENX/2;
    
    [~,L] = ripleyK(integrin_positions(:,1:2), s, REAL_LENX, REAL_LENY);
    LMatrix = [LMatrix, L'];
    
    bondFrac = [bondFrac, length(bondedSites)/length(integrin_positions)];
    
    Stats.s = s;
    Stats.LMatrix = LMatrix;
    Stats.bondFrac = bondFrac;
end