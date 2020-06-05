function updateBondRates_v4(forceC, energyC, activeIndArray, bondedIndArray)
    % Determine unique forward and reverse reactions
    global activeSites bondedSites bondedPSIndices
    global activePSIndices numPlane ligSites
    global del_equilibrium k_equilibrium positions nm2m
    global k_reverse_Init k_forward_Init kBT compliance k_forward k_reverse
    global maxForce
    
    for i = activeIndArray

        integrin = activePSIndices(i);
        ligand = integrin - numPlane;
        
        d = positions(integrin,3) - positions(ligand,3)-del_equilibrium;
        force = polyval(forceC,d);
    
        deltaEnergy = polyval(energyC,d^2);
        
        k_reverse(i) = k_reverse_Init*exp(force*compliance/kBT);
        
        % Check if lateral distance is too far for bonding to occur
        withinCutOff = ligandIntegrinDistance_v2(activeSites(i),ligSites);
        
        if withinCutOff == true           
            k_forward(i) = k_forward_Init*exp((force*compliance-deltaEnergy)/kBT);
        else
            k_forward(i) = 0;
        end
        
        % Check if site is already occupied for bonding to occur
        occupied = siteOccupied_v1(bondedPSIndices, activePSIndices(i));
        
        if occupied == true
            k_forward(i) = 0;
        end
        
        
            
    end
    
    for i = bondedIndArray
        
        integrin = bondedPSIndices(i);
        ligand = integrin - numPlane;

        deformation = (positions(integrin,3) - positions(ligand,3)) - del_equilibrium;
        force = k_equilibrium*abs(deformation)*nm2m;
        
        % Saturate the force so we don't get imaginary roots
        if force > maxForce
            force = maxForce;
        end
        
        A = forceC(1);
        B = forceC(2);
        C = forceC(3)-force;
        
        % Need to change the sign of +- depending on curvature
        d1 = (-B+sqrt(B^2-4*A*C))/(2*A);
        d2 = (-B-sqrt(B^2-4*A*C))/(2*A);
        
        mind = min(d1,d2);
        if mind > 0
            d = mind;
        else
            d = max(d1,d2);
        end
        
        assert(isreal(d))

        deltaEnergy = polyval(energyC,d^2);

        k_reverse(i+length(activeSites)) = k_reverse_Init*exp(force*compliance/kBT);
        k_forward(i+length(activeSites)) = k_forward_Init*exp((force*compliance-deltaEnergy)/kBT);

    end

end