function integrinPositions = getIntegrins(System, Del, Coordinates, Reactions)

%% System variables
    REAL_LENX = System.REAL_LENX;
    REAL_LENY = System.REAL_LENY;

    NUM_INTEGRINS = Reactions.NUM_INTEGRINS;
    
    xCoordinate = Coordinates.xCoordinate;
    yCoordinate = Coordinates.yCoordinate;
    zCoordinate = Coordinates.zCoordinate;
    
    Del_SUB = Del.SUB;
    Del_GLY = Del.GLY;
    
    SUBSTRATE_HEIGHT = System.Substrate.LENZ;
    
%% Get integrin positions
    
    integrinPositions = zeros(NUM_INTEGRINS,3); %3 spatial coordinates
    
    integrinPositions(:,xCoordinate) = REAL_LENX*rand(NUM_INTEGRINS,1) + Del_SUB/2;
    integrinPositions(:,yCoordinate) = REAL_LENY*rand(NUM_INTEGRINS,1) + Del_SUB/2;

    integrinPositions(:,zCoordinate) = SUBSTRATE_HEIGHT + Del_GLY;   
 
    
end