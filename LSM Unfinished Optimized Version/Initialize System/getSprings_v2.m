function springList = getSprings_v2(System, Coordinates, K)

    %% System variables
    NUMZ = System.NUMZ;
    NUMY = System.NUMY;
    NUMX = System.NUMX;
    TOTAL = System.TOTAL;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    posZ = Coordinates.posZ;
    negZ = Coordinates.negZ;
    MAX_NEIGHBORS = Coordinates.MAX_NEIGHBORS;
    
    K_GLY = K.GLY;
    K_SUB = K.SUB;
    K_MEM = K.MEM;
    
    springList = zeros(TOTAL,MAX_NEIGHBORS);

    k = 1;
    for z = 1:NUMZ
        for y = 1:NUMY
            for x = 1:NUMX
                if z <= END_FIRST_LAYER
                    springList(k,:) = K_SUB;
                    if z == END_FIRST_LAYER
                        springList(k, posZ) = K_GLY;
                    end           
                else
                    springList(k,:) = K_MEM;   
                    if z == START_SECOND_LAYER
                        springList(k, negZ) = K_GLY;
                    end
                end
                k = k + 1; %Index of node in lattice   
            end
        end
    end

end

