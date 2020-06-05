function integrin_positions = interpolatedSurface_v2(System, node_positions,integrin_positions)
%% Unpack structure
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
%%
    surface_indices = NUMPLANE*END_FIRST_LAYER+1:NUMPLANE*START_SECOND_LAYER;
    x = node_positions(surface_indices,1);
    y = node_positions(surface_indices,2);
    z = node_positions(surface_indices,3);

    F = scatteredInterpolant(x,y,z);

    x_q = integrin_positions(:,1);
    y_q = integrin_positions(:,2);

    integrin_positions(:,3) = F(x_q,y_q);

end
