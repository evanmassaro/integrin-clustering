function electroDiffusion_v1(index, direction)
    global integrinPositions del_hop lengthX del_sub
    
    % Change sign depending on direction of drift velocity. Assumes only in
    % positive x direction right now
   switch direction
        case 1
            integrinPositions(index,1) = integrinPositions(index,1) + del_hop;
        case 2
            integrinPositions(index,1) = integrinPositions(index,1) - del_hop;
   end
    
    %% Periodic boundary conditions
    if integrinPositions(index,1) > lengthX+del_sub/2
        integrinPositions(index,1) = integrinPositions(index,1) - lengthX;
    elseif integrinPositions(index,1) < del_sub/2
        integrinPositions(index,1) = integrinPositions(index,1) + lengthX;
    end

end