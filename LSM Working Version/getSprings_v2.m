function springs = getSprings_v2()
    
    global totalHeight numDepth numWidth numTot endFirstLayer startSecondLayer
    global positiveZ negativeZ
    global k_mem k_gly k_sub k_bond %Spring constants
    
    %For the family of [1 0 0] anmd [1 1 0] directions, there are 18 possible 
    %neighbors. Edge cases will have less elements and be represented as zeros.
    numFirstFamily = 6; %Six possible [1 0 0] directions x,y,z,-x,-y,-z
    numSecondFamily = 4; %Four possible [1 1 0] directions per plane (xy yz or xz)
    maxNumNeighbors = numFirstFamily + 3*numSecondFamily; % 6 + 3*4 = 18
    springList = zeros(numTot,maxNumNeighbors);

    nodeIndex = 0;
    for z = 1:totalHeight
        for y = 1:numDepth
            for x = 1:numWidth
                
                nodeIndex = nodeIndex + 1; %Index of node in lattice                
                if z <= endFirstLayer
                    springList(nodeIndex,:) = k_sub;
                    if z == endFirstLayer
                        springList(nodeIndex, positiveZ) = k_gly;
                    end           
                else
                    springList(nodeIndex,:) = k_mem;   
                    if z == startSecondLayer
                        springList(nodeIndex, negativeZ) = k_gly;
                    end
                end
        
            end
        end
    end

    % return variable
    springs = springList;
end

