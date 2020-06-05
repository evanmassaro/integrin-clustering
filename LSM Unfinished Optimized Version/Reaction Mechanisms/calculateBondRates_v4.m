function [k_forward, k_reverse] = calculateBondRates_v4(K,Del,System,Coordinates,Reactions,Fits,Nodes_S,Integrins_S)
%% Unpack structures
    node_positions = Nodes_S.node_positions;

    integrin_positions = Integrins_S.integrin_positions;
    ligandBoolSites = Integrins_S.ligandBoolSites;
    activeSites = Integrins_S.activeSites;
    activePSIndices = Integrins_S.activePSIndices;
    bondedSites = Integrins_S.bondedSites;
    bondedPSIndices = Integrins_S.bondedPSIndices;


    NUMPLANE = System.NUMPLANE;
    
    Del_EQUILIBRIUM = Del.EQUILIBRIUM;
    K_EQUILIBRIUM = K.EQUILIBRIUM;
    
    kBT = Reactions.kBT;
    k_REVERSE_INIT = Reactions.k_REVERSE_INIT;
    k_FORWARD_INIT = Reactions.k_FORWARD_INIT;
    COMPLIANCE = Reactions.COMPLIANCE;
    
    forceC = Fits.forceC;
    energyC = Fits.energyC;
    force_MAX = Fits.force_MAX;
    
 %% Find rates for active sites
 
    k_reverse = zeros(length(activeSites)+length(bondedSites),1);
    k_forward = zeros(length(activeSites)+length(bondedSites),1);
    
    ligands = activePSIndices - NUMPLANE;

    d = node_positions(activePSIndices,3) - node_positions(ligands,3) - Del_EQUILIBRIUM;
    
    force = forceC(1)*d.^2 + forceC(2)*d + forceC(3);
    deltaEnergy = energyC(1)*d.^4 + energyC(2)*d.^2 + energyC(3);

    k_reverse(1:length(activeSites)) = k_REVERSE_INIT*exp(force*COMPLIANCE/kBT);
    k_forward(1:length(activeSites)) = k_FORWARD_INIT*exp((force*COMPLIANCE-deltaEnergy)/kBT);
        
    % Check if lateral distance is too far for bonding to occur
    allowable_Complex = ligandIntegrinDistance_v2(System,Del,node_positions,integrin_positions,...
                           activeSites,activePSIndices,ligandBoolSites);                  
    k_forward(~allowable_Complex) = 0;
%     k_reverse(~allowable_Complex) = 0;
    
    % Check if site is already occupied such that bonding cannot occur
    occupied = ismember(activePSIndices,bondedPSIndices);
    k_forward(occupied == 1) = 0;
%     k_reverse(occupied == 1) = 0;

    
    
%% Find rates for BONDED SITES

    if ~isempty(bondedSites)

        ligands = bondedPSIndices - NUMPLANE;

        deformation = (node_positions(bondedPSIndices,3) - node_positions(ligands,3)) - Del_EQUILIBRIUM;
        force = K_EQUILIBRIUM*abs(deformation);

        % Saturate the force so we don't get imaginary roots
        force(force > force_MAX) = force_MAX;
        
        A = forceC(1);
        B = forceC(2);
        C_v = forceC(3)-force;

        % Need to pick the sign of +- depending on curvature
        assert(all((B^2-4*A*C_v)>=0)) % Impossible to have imaginary positions
        d1 = (-B+sqrt(B^2-4*A*C_v))/(2*A);
        d2 = (-B-sqrt(B^2-4*A*C_v))/(2*A);

        min_d = min(d1,d2);
        max_d = max(d1,d2);
        d = min_d.*(min_d > 0) + max_d.*(min_d < 0);

        deltaEnergy = energyC(1)*d.^4 + energyC(2)*d.^2 + energyC(3);

        k_reverse(length(activeSites)+1:end) = k_REVERSE_INIT*exp(force*COMPLIANCE/kBT);
        k_forward(length(activeSites)+1:end) = k_FORWARD_INIT*exp((force*COMPLIANCE-deltaEnergy)/kBT);
    end

end