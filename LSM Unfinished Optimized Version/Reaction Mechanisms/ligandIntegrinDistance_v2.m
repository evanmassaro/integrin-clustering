function allowable_Complex = ligandIntegrinDistance_v2(System,Del,...
                           node_positions,integrin_positions,...
                           activeSites,activePSIndices,ligandBoolSites)
    
    NUMPLANE = System.NUMPLANE;
    CUT_OFF = Del.SUB/2;

    node_beneath_active = activePSIndices - NUMPLANE;
    
    near_Ligand_Flag = ligandBoolSites(node_beneath_active,1);
    
    del_x = node_positions(activePSIndices,1) - integrin_positions(activeSites,1);
    del_y = node_positions(activePSIndices,2) - integrin_positions(activeSites,2);
    
    distance = sqrt(del_x.^2 + del_y.^2); 
    
    within_Cutoff = (distance < CUT_OFF);
    allowable_Complex = within_Cutoff & near_Ligand_Flag;

end