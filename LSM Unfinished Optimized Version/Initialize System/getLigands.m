function [ligandSites,ligandBoolSites] = getLigands(System, Reactions, realNodes)

%% System variables
    NUMZ = System.NUMZ;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    
    NUM_LIGANDS = Reactions.NUM_LIGANDS ;
    
%% Calculate ligand sites
    NUM_REAL_PLANE = length(realNodes)/NUMZ;
    substrateSurfaceNodes = realNodes(1:NUM_REAL_PLANE) + NUMPLANE*(END_FIRST_LAYER-1);
    
    
    ligandSites = sort(randsample(substrateSurfaceNodes,NUM_LIGANDS));  
    
    ligandBoolSites = zeros(NUMPLANE,1);
    ligandBoolSites(ligandSites) = 1;
    
end