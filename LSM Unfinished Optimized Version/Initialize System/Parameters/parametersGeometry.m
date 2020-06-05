function System = parametersGeometry(Del,pairs)
    
    System.REAL_X = 70;  % USE: 12 for curve fits else 70 for full simulation
    System.REAL_Y = 70;  % USE: 12 for curve fits else 70 for full simulation
    System.Substrate_NUMZ = 1; % number of elements in each column 
    System.Cell_NUMZ = 3; % number of elements per cell height
    
    System = addParameters(System,pairs);
    
    %% Define planar geometry for System
    BUFFER = 1; % We add one layer of nodes on each side for periodic boundary conditions
    
    System.NUMX = System.REAL_X + 2*BUFFER; % number of elements in each row   
    System.NUMY = System.REAL_Y + 2*BUFFER; % number of elements into the page
    System.NUMPLANE = System.NUMX * System.NUMY;
   
    System.LENX = Del.SUB*(System.NUMX-BUFFER);
    System.LENY = Del.SUB*(System.NUMY-BUFFER);
    
    System.REAL_LENX = Del.SUB*(System.NUMX-BUFFER-1);
    System.REAL_LENY = Del.SUB*(System.NUMY-BUFFER-1);
    System.REAL_PLANE_AREA = System.REAL_LENX * System.REAL_LENY;
    
    %% Define additional Substrate features
    Substrate.TOTAL = System.Substrate_NUMZ * System.NUMPLANE;
    Substrate.LENZ = Del.SUB*(System.Substrate_NUMZ-1);
    
    %% Define additional Cell membrane features
    Cell.TOTAL =  System.Cell_NUMZ * System.NUMPLANE;
    Cell.LENZ = Del.SUB*(System.Cell_NUMZ-1);
    
    %% Define additional System features
    System.NUMZ = System.Substrate_NUMZ + System.Cell_NUMZ;
    System.TOTAL = Cell.TOTAL + Substrate.TOTAL; % Total number of nodes
    System.LENZ = Substrate.LENZ + Del.GLY + Cell.LENZ;

    System.END_FIRST_LAYER = System.Substrate_NUMZ;
    System.START_SECOND_LAYER = System.Substrate_NUMZ + 1;

    System.Substrate = Substrate;
    System.Cell = Cell;
end