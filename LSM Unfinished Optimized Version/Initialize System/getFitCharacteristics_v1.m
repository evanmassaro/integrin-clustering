function Fits = getFitCharacteristics_v1(Del,K,version)
    if ~exist('version','var')
        version = '1';
    end
    [forceC, energyC] = getFits_v1(Del.GLY,K.GLY,K.MEM,version);

    d_MAX = Del.GLY-Del.BOND;
    force_MAX = 1.1*polyval(forceC,d_MAX);
    
    Fits.forceC = forceC;
    Fits.energyC = energyC;
    Fits.force_MAX = force_MAX;
    
end