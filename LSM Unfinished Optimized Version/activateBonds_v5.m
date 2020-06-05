function [node_positions,allSprings,...
          allDistances,integrin_positions] = activateBonds_v5(K,Del,System,Coordinates,Nodes_S,Integrins_S,...
                                                              integrin_index,integrinPSIndex)
    
                                                
 %% Unpack structures   
    NUMPLANE = System.NUMPLANE;
    Del_BOND = Del.BOND;
    K_EQUILIBRIUM = K.EQUILIBRIUM;
    Del_EQUILIBRIUM = Del.EQUILIBRIUM;
    
    negZ = Coordinates.negZ;
    posZ = Coordinates.posZ;
    zCoordinate = Coordinates.zCoordinate;

    node_positions = Nodes_S.node_positions;
    allSprings = Nodes_S.allSprings;
    allDistances = Nodes_S.allDistances;

    ligandBoolSites = Integrins_S.ligandBoolSites;
    integrin_positions = Integrins_S.integrin_positions;

%%
    ligandPSIndex = integrinPSIndex - NUMPLANE;
    assert(ligandBoolSites(ligandPSIndex) == 1,'There is not a ligand beneath this active site') 
               
    allSprings(ligandPSIndex,posZ) =  K_EQUILIBRIUM;
    allSprings(integrinPSIndex,negZ) =  K_EQUILIBRIUM;
    
    allDistances(posZ,zCoordinate,ligandPSIndex) =  Del_EQUILIBRIUM;
    allDistances(negZ,zCoordinate,integrinPSIndex) =  Del_EQUILIBRIUM;


    node_positions(integrinPSIndex,3) = node_positions(ligandPSIndex,3) + Del_BOND;
    integrin_positions(integrin_index,:) = node_positions(integrinPSIndex,:);

end



