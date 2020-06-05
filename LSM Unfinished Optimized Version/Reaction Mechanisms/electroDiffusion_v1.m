function integrinPositions = electroDiffusion_v1(System,Del,Coordinates,Reactions,...
                            integrinPositions,index)
%% Unpack system variables    
    REAL_LENX = System.REAL_LENX;
    Del_SUB = Del.SUB;
    Del_HOP = Reactions.Del_HOP;
    x_Coordinate = Coordinates.xCoordinate;
                        
%% Move integrin positions                        
    
    % Change sign depending on direction of drift velocity. Assumes only in
    % positive x direction right now
    integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) + Del_HOP;
    
    
%% Periodic boundary conditions
    if integrinPositions(index,x_Coordinate) > REAL_LENX + Del_SUB/2
        integrinPositions(index,x_Coordinate) = integrinPositions(index,x_Coordinate) - REAL_LENX;
    elseif integrinPositions(index,x_Coordinate) < Del_SUB/2
        integrinPositions(index,x_Coordinate) = integrinPositions(index,1) + REAL_LENX;
    end

end