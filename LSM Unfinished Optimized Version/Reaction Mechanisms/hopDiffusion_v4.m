function integrinPositions = hopDiffusion_v4(System,Del,Coordinates,Reactions,...
                            integrinPositions,index)
%% Unpack system variables    
    REAL_LENX = System.REAL_LENX;
    REAL_LENY = System.REAL_LENY;
    Del_SUB = Del.SUB;
    Del_HOP = Reactions.Del_HOP;
    x_Coordinate = Coordinates.xCoordinate;
    y_Coordinate = Coordinates.yCoordinate;
    
%% Determine random xy-direction to pertube integrin
    direction = randi(4); 

    switch direction
        % change x position
        case 1
            integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) + Del_HOP;
        case 2
            integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) - Del_HOP;
        % Change y position    
        case 3
            integrinPositions(index,y_Coordinate) = integrinPositions(index,y_Coordinate) + Del_HOP;
        case 4
            integrinPositions(index,y_Coordinate) = integrinPositions(index,y_Coordinate) - Del_HOP;
    end

%% Enforce periodic boundary conditions
    
    % change x position
    if integrinPositions(index,x_Coordinate) > REAL_LENX+Del_SUB/2
        integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) - REAL_LENX;
        
    elseif integrinPositions(index,x_Coordinate) < Del_SUB/2
        integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) + REAL_LENX;
    end

    
    % change y position
    if integrinPositions(index,y_Coordinate) > REAL_LENY+Del_SUB/2
        integrinPositions(index,y_Coordinate) = integrinPositions(index,y_Coordinate) - REAL_LENY;
        
    elseif integrinPositions(index,y_Coordinate) < Del_SUB/2
        integrinPositions(index,y_Coordinate) = integrinPositions(index,y_Coordinate) + REAL_LENY;
    end

end