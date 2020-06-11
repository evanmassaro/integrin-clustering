function hopDiffusion_v4(index)
    %Thermal diffusion
    global integrinPositions del_hop lengthX lengthY del_sub
    
    %% Determine random xy-direction to pertube integrin
    direction = randi(4); 

    switch direction
        case 1
            integrinPositions(index,1) = integrinPositions(index,1) + del_hop;
        case 2
            integrinPositions(index,1) = integrinPositions(index,1) - del_hop;
        case 3
            integrinPositions(index,2) = integrinPositions(index,2) + del_hop;
        case 4
            integrinPositions(index,2) = integrinPositions(index,2) - del_hop;
    end

    %% Periodic boundary conditions
    if integrinPositions(index,1) > lengthX+del_sub/2
        integrinPositions(index,1) = integrinPositions(index,1) - lengthX;
    elseif integrinPositions(index,1) < del_sub/2
        integrinPositions(index,1) = integrinPositions(index,1) + lengthX;
    end

    if integrinPositions(index,2) > lengthY+del_sub/2
        integrinPositions(index,2) = integrinPositions(index,2) - lengthY;
    elseif integrinPositions(index,2) < del_sub/2
        integrinPositions(index,2) = integrinPositions(index,2) + lengthY;
    end

end
