function positions = setLattice_v1()
    %% Initial Node Configuration
    nodeIndex = 0;
    global numTot totalHeight numHeight numWidth numDepth;
    global del_sub del_gly
    pos = zeros(numTot,3);

    % Initialize starting node pos for subtsrate, glycocalyx, and membrane
    for k = 1:totalHeight
        for j = 1:numDepth
            for i = 1:numWidth
                nodeIndex = nodeIndex+1;
                pos(nodeIndex,1) = (i-1)*del_sub;
                pos(nodeIndex,2) = (j-1)*del_sub;
 
                if k <= numHeight
                    pos(nodeIndex,3) = (k-1)*del_sub; 
                else
                    pos(nodeIndex,3) = (k-2)*del_sub +del_gly;
                end
            end
        end
    end
    
    positions = pos;
end    