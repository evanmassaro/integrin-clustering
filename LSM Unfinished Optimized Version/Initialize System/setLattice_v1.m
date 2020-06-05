function node_positions = setLattice_v1(System,Coordinates,Del)
    %% System variables
    NUMZ = System.NUMZ;
    NUMY = System.NUMY;
    NUMX = System.NUMX;
    TOTAL = System.TOTAL;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    xCoordinate = Coordinates.xCoordinate;
    yCoordinate = Coordinates.yCoordinate;
    zCoordinate = Coordinates.zCoordinate;
    
    %% Initialize node positions in lattice
    node_positions = zeros(System.TOTAL,3);
    
    x = ((1:NUMX)-1)*Del.SUB;
    y = ((1:NUMY)-1)*Del.SUB;
    z_substrate = ((1:END_FIRST_LAYER)-1)*Del.SUB;
    z_cell = ((START_SECOND_LAYER:NUMZ)-2)*Del.SUB + Del.GLY;
    z = [z_substrate z_cell];
    
    node_positions(:,xCoordinate) = repmat(x,[1,TOTAL/NUMX]);

    tmp_y = repelem(y,NUMX);
    node_positions(:,yCoordinate) = repmat(tmp_y,[1,NUMZ]);
    
    node_positions(:,zCoordinate)= repelem(z,NUMPLANE);
    
end    