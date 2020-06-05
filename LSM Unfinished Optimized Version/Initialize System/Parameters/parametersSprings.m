function [K, Del] = parametersSprings(pairs)
    % Spring Constants
    K.GLY = 0.02; %pN/nm
    K.MEM = 0.4;  %pN/nm
    K.SUB = 1000; %pN/nm
    K.BOND = 2;   %pN/nm

    %Equilibrium node spacings
    Del.GLY = 43;  %nm
    Del.SUB = 20;  %nm
    Del.BOND = 27; %nm
    
    K = addParameters(K,pairs);
    Del = addParameters(Del,pairs);

    
    %Equilibrium lengths for glycocalyx in parallel with bond
    Del.EQUILIBRIUM = (K.BOND*Del.BOND + K.GLY*Del.GLY)/(K.BOND+K.GLY);
    K.EQUILIBRIUM = K.BOND + K.GLY;
        
end