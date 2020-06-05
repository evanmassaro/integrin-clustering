function Reactions = parametersLigandsAndIntegrins(System,pairs)
%%

    Reactions.LIGAND_DENSITY = 2500/10^6; 
    Reactions.INTEGRIN_DENSITY = 100/10^6;
    
    Reactions.D = 5*10^4; %mm^2/s
    Reactions.Del_HOP = 5; % mm
    
    % Reaction rates for all mechanisms
    Reactions.k_D = 5;                   % Deactivation rate
    Reactions.k_A = 0.5;                 % Activation rate
    Reactions.k_E = 40;                  % Electrophoretic diffusion rate
    Reactions.k_REVERSE_INIT = 10^(-2);  % Reverse rate of bond formation
    Reactions.k_FORWARD_INIT = 10^5;     % Forward rate of bond formation    
    
    Reactions.kBT = 4.28; % Thermal engery
    Reactions.COMPLIANCE = 0.4;
    
    Reactions = addParameters(Reactions,pairs);
    
%% Integrin and ligand densities
    assert(Reactions.LIGAND_DENSITY <= 2500/10^6) % Maximum possible 2500/10^6
    
    REAL_PLANE_AREA = System.REAL_PLANE_AREA;
    
    Reactions.NUM_LIGANDS = floor(REAL_PLANE_AREA*Reactions.LIGAND_DENSITY);
    Reactions.NUM_INTEGRINS = floor(REAL_PLANE_AREA*Reactions.INTEGRIN_DENSITY);
    
    Reactions.k_HOP = 4*Reactions.D/Reactions.Del_HOP^2;    % Thermal diffusion rate
    
    Reactions.NUM_REACTIONS = 6;
     
end