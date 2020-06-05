function neighbors = getNeighbors_v3(System, Coordinates)
    
    %% System variables
    NUMZ = System.NUMZ;
    NUMY = System.NUMY;
    NUMX = System.NUMX;
    TOTAL = System.TOTAL;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    % Six primary directions
    posX = Coordinates.posX;
    negX = Coordinates.negX;
    posY = Coordinates.posY;
    negY = Coordinates.negY;
    posZ = Coordinates.posZ;
    negZ = Coordinates.negZ;
    
    % Next 4 directions in xy-plane 
    posX_posY = Coordinates.posXposY;
    negX_posY = Coordinates.negXposY;
    negX_negY = Coordinates.negXnegY;
    posX_negY = Coordinates.posXnegY;
    
    % Next 4 directions in yz-plane 
    posY_posZ = Coordinates.posYposZ;
    posY_negZ = Coordinates.posYnegZ;
    negY_negZ = Coordinates.negYnegZ;
    negY_posZ = Coordinates.negYposZ;
    
    % Next 4 directions in xz-plane 
    posX_posZ = Coordinates.posXposZ;
    posX_negZ = Coordinates.posXnegZ;
    negX_negZ = Coordinates.negXnegZ;
    negX_posZ = Coordinates.negXposZ;
    
    
    %% Initialize all possible neigbor interactions 
    neighborList = zeros(System.TOTAL,Coordinates.MAX_NEIGHBORS);
    

    k = 0;
    for z = 1:NUMZ
        for y = 1:NUMY
            for x = 1:NUMX
                
                k = k + 1; %Index of node in lattice
                
                %% First Six Neigbors are from [1 0 0] family of directions (i.e. +x,-x, +y,-y, +z,-z)
                
                %Neighbors for x-directions in family of [1,0,0] (i.e. +x,-x)
                if x ~= NUMX
                    neighborList(k,posX) = k+1;
                else
                    neighborList(k,posX) = k+1-NUMX; %Interaction term
                end
                if x ~= 1
                    neighborList(k,negX) = k-1;
                else
                    neighborList(k,negX) = k-1+NUMX; %Interaction term
                end
                
                %Neighbors for y-directions in family of [0,1,0] (i.e. +y,-y)
                if y ~= NUMY
                    neighborList(k,posY) = k+NUMX;
                else
                    neighborList(k,posY) = k+NUMX-NUMPLANE; %Interaction term
                end
                if y ~= 1
                    neighborList(k,negY) = k-NUMX;
                else
                    neighborList(k,negY) = k-NUMX+NUMPLANE; %Interaction term
                end
                
                %Neighbors for z-directions in family of [0,0,1] (i.e. +z,-z)
                if z ~= NUMZ
                    neighborList(k,posZ) = k+NUMPLANE;
                end
                if z ~= 1 
                    neighborList(k,negZ) = k-NUMPLANE;
                end
                
                %% Next Four Neigbors are from [1 1 0] family of directions in the xy-plane (i.e. +y+x, +y-x, -y-x, -y+x)
                
                %Neighbors in directions of (1,1,0) and (1,-1,0)
                if x~= NUMX %look one ahead
                    if y ~= NUMY
                        neighborList(k,posX_posY) = k+NUMX+1;
                    else
                        %Back face interaction term for (1,1,0)
                        neighborList(k,posX_posY) = k+NUMX+1-NUMPLANE; 
                    end
                    
                    if y ~= 1
                        neighborList(k,posX_negY) = k-NUMX+1;
                    else
                        %Front face interaction term (1,-1,0)
                        neighborList(k,posX_negY) = k-NUMX+1+NUMPLANE; 
                    end
                else
                    if y ~= NUMY
                        %Right face interaction term (1,1,0)
                        neighborList(k,posX_posY) = k+1; 
                    else
                        %Right-Back edge interaction term (1,1,0)
                        neighborList(k,posX_posY) = k+1-NUMPLANE;
                    end
                    
                    if y ~= 1
                        %Right face interaction term (1,-1,0)
                        neighborList(k,posX_negY) = k-2*NUMX+1;
                    else
                        %Right-Front edge interaction term
                        neighborList(k,posX_negY) = k-2*NUMX+1+NUMPLANE;
                    end
                end
                
                
                if x ~= 1 %look one behind
                    if y ~= NUMY
                        neighborList(k,negX_posY) = k+NUMX-1;
                    else
                        neighborList(k,negX_posY) = k+NUMX-1-NUMPLANE; %Interaction term
                    end    
                     
                    if y ~= 1
                        neighborList(k,negX_negY) = k-NUMX-1;
                    else
                        neighborList(k,negX_negY) = k-NUMX-1+NUMPLANE; %Interaction term
                    end
                else
                    if y ~= NUMY
                        neighborList(k,negX_posY) = k+2*NUMX-1; %Interaction term
                    else
                        neighborList(k,negX_posY) = k+2*NUMX-1-NUMPLANE; %Interaction term
                    end    
                     
                    if y ~= 1
                        neighborList(k,negX_negY) = k-1; %Interaction term
                    else
                        neighborList(k,negX_negY) = k+NUMPLANE-1; %Interaction term
                    end
                end
                
                
                %% Next Four Neigbors (11,12,13,14) are from [1 1 0] family of directions in the yz-plane
                % Best case for second family [nodeIndex+NUMX+NUMPLANE, nodeIndex+NUMX-NUMPLANE, nodeIndex-NUMX-NUMPLANE, nodeIndex-NUMX+NUMPLANE];
                
                if y~= NUMY %
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,posY_posZ) = k+NUMX+NUMPLANE;
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,posY_negZ) = k+NUMX-NUMPLANE;
                    end
                else
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,posY_posZ) = k+NUMX; %Interaction term
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,posY_negZ) = k+NUMX-2*NUMPLANE; %Interaction term
                    end 
                end
                
                
                if y ~= 1 %
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,negY_posZ) = k-NUMX+NUMPLANE;
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,negY_negZ) = k-NUMX-NUMPLANE;
                    end
                else
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,negY_posZ) = k-NUMX+2*NUMPLANE; %Interaction term
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,negY_negZ) = k-NUMX; %Interaction term
                    end
                end
                
                
                %% Next Four Neigbors (15,16,17,18) are from [1 1 0] family of directions in the xz-plane
                % Best case for second family [nodeIndex+1+NUMPLANE, nodeIndex+1-NUMPLANE, nodeIndex-1-NUMPLANE, nodeIndex-1+NUMPLANE];
                
                if x~= NUMX %
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,posX_posZ) = k+1+NUMPLANE;
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,posX_negZ) = k+1-NUMPLANE;
                    end
                else
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,posX_posZ) = k+1-NUMX+NUMPLANE; %Interaction term
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,posX_negZ) = k+1-NUMX-NUMPLANE; %Interaction term
                    end
                end
                
                
                if x ~= 1 %
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,negX_posZ) = k-1+NUMPLANE;
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,negX_negZ) = k-1-NUMPLANE;
                    end
                else
                    if z ~= NUMZ && z ~= END_FIRST_LAYER
                        neighborList(k,negX_posZ) = k-1+NUMX+NUMPLANE; %Interaction term
                    end
                    if z ~= 1 && z ~= START_SECOND_LAYER
                        neighborList(k,negX_negZ) = k-1+NUMX-NUMPLANE; %Interaction term
                    end
                end
                
                % Last of neighbors. End of loop
            end
        end
    end
    
    % return variable
    neighbors = neighborList;
end

