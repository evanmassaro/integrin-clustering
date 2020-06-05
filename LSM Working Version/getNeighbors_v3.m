function neighbors = getNeighbors_v3()
    
    global totalHeight numDepth numWidth numTot numPlane endFirstLayer startSecondLayer

    %For the family of [1 0 0] anmd [1 1 0] directions, there are 18 possible 
    %neighbors. Edge cases will have less elements and be represented as zeros.
    
    numFirstFamily = 6; %Six possible [1 0 0] directions x,y,z,-x,-y,-z
    numSecondFamily = 4; %Four possible [1 1 0] directions per plane (xy yz or xz)
    maxNumNeighbors = numFirstFamily + 3*numSecondFamily; % 6 + 3*4 = 18
    neighborList = zeros(numTot,maxNumNeighbors);
    
    %First six primary directions
    global positiveZ negativeZ
    positiveX = 1;
    negativeX = 2;
    positiveY = 3;
    negativeY = 4;
    positiveZ = 5;
    negativeZ = 6;
    
    % Next 4 directions in xy-plane 
    positiveXpositiveY = 7;
    negativeXpositiveY = 8;
    negativeXnegativeY = 9;
    positiveXnegativeY = 10; 
    
    % Next 4 directions in yz-plane 
    positiveYpositiveZ = 11;
    positiveYnegativeZ = 12;
    negativeYnegativeZ = 13;
    negativeYpositiveZ = 14;
    
    % Next 4 directions in xz-plane 
    positiveXpositiveZ = 15;
    positiveXnegativeZ = 16;
    negativeXnegativeZ = 17;
    negativeXpositiveZ = 18;
    
    
    nodeIndex = 0;
    for z = 1:totalHeight
        for y = 1:numDepth
            for x = 1:numWidth
                
                nodeIndex = nodeIndex + 1; %Index of node in lattice
                
                %% First Six Neigbors are from [1 0 0] family of directions (i.e. +x,-x, +y,-y, +z,-z)
                
                %Neighbors for x-directions in family of [1,0,0] (i.e. +x,-x)
                if x ~= numWidth
                    neighborList(nodeIndex,positiveX) = nodeIndex+1;
                else
                    neighborList(nodeIndex,positiveX) = nodeIndex+1-numWidth; %Interaction term
                end
                if x ~= 1
                    neighborList(nodeIndex,negativeX) = nodeIndex-1;
                else
                    neighborList(nodeIndex,negativeX) = nodeIndex-1+numWidth; %Interaction term
                end
                
                %Neighbors for y-directions in family of [0,1,0] (i.e. +y,-y)
                if y ~= numDepth
                    neighborList(nodeIndex,positiveY) = nodeIndex+numWidth;
                else
                    neighborList(nodeIndex,positiveY) = nodeIndex+numWidth-numPlane; %Interaction term
                end
                if y ~= 1
                    neighborList(nodeIndex,negativeY) = nodeIndex-numWidth;
                else
                    neighborList(nodeIndex,negativeY) = nodeIndex-numWidth+numPlane; %Interaction term
                end
                
                %Neighbors for z-directions in family of [0,0,1] (i.e. +z,-z)
                if z ~= totalHeight
                    neighborList(nodeIndex,positiveZ) = nodeIndex+numPlane;
                end
                if z ~= 1 
                    neighborList(nodeIndex,negativeZ) = nodeIndex-numPlane;
                end
                
                %% Next Four Neigbors are from [1 1 0] family of directions in the xy-plane (i.e. +y+x, +y-x, -y-x, -y+x)
                
                %Neighbors in directions of (1,1,0) and (1,-1,0)
                if x~= numWidth %look one ahead
                    if y ~= numDepth
                        neighborList(nodeIndex,positiveXpositiveY) = nodeIndex+numWidth+1;
                    else
                        %Back face interaction term for (1,1,0)
                        neighborList(nodeIndex,positiveXpositiveY) = nodeIndex+numWidth+1-numPlane; 
                    end
                    
                    if y ~= 1
                        neighborList(nodeIndex,positiveXnegativeY) = nodeIndex-numWidth+1;
                    else
                        %Front face interaction term (1,-1,0)
                        neighborList(nodeIndex,positiveXnegativeY) = nodeIndex-numWidth+1+numPlane; 
                    end
                else
                    if y ~= numDepth
                        %Right face interaction term (1,1,0)
                        neighborList(nodeIndex,positiveXpositiveY) = nodeIndex+1; 
                    else
                        %Right-Back edge interaction term (1,1,0)
                        neighborList(nodeIndex,positiveXpositiveY) = nodeIndex+1-numPlane;
                    end
                    
                    if y ~= 1
                        %Right face interaction term (1,-1,0)
                        neighborList(nodeIndex,positiveXnegativeY) = nodeIndex-2*numWidth+1;
                    else
                        %Right-Front edge interaction term
                        neighborList(nodeIndex,positiveXnegativeY) = nodeIndex-2*numWidth+1+numPlane;
                    end
                end
                
                
                if x ~= 1 %look one behind
                    if y ~= numDepth
                        neighborList(nodeIndex,negativeXpositiveY) = nodeIndex+numWidth-1;
                    else
                        neighborList(nodeIndex,negativeXpositiveY) = nodeIndex+numWidth-1-numPlane; %Interaction term
                    end    
                     
                    if y ~= 1
                        neighborList(nodeIndex,negativeXnegativeY) = nodeIndex-numWidth-1;
                    else
                        neighborList(nodeIndex,negativeXnegativeY) = nodeIndex-numWidth-1+numPlane; %Interaction term
                    end
                else
                    if y ~= numDepth
                        neighborList(nodeIndex,negativeXpositiveY) = nodeIndex+2*numWidth-1; %Interaction term
                    else
                        neighborList(nodeIndex,negativeXpositiveY) = nodeIndex+2*numWidth-1-numPlane; %Interaction term
                    end    
                     
                    if y ~= 1
                        neighborList(nodeIndex,negativeXnegativeY) = nodeIndex-1; %Interaction term
                    else
                        neighborList(nodeIndex,negativeXnegativeY) = nodeIndex+numPlane-1; %Interaction term
                    end
                end
                
                
                %% Next Four Neigbors (11,12,13,14) are from [1 1 0] family of directions in the yz-plane
                % Best case for second family [nodeIndex+numWidth+numPlane, nodeIndex+numWidth-numPlane, nodeIndex-numWidth-numPlane, nodeIndex-numWidth+numPlane];
                
                if y~= numDepth %
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,positiveYpositiveZ) = nodeIndex+numWidth+numPlane;
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,positiveYnegativeZ) = nodeIndex+numWidth-numPlane;
                    end
                else
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,positiveYpositiveZ) = nodeIndex+numWidth; %Interaction term
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,positiveYnegativeZ) = nodeIndex+numWidth-2*numPlane; %Interaction term
                    end 
                end
                
                
                if y ~= 1 %
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,negativeYpositiveZ) = nodeIndex-numWidth+numPlane;
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,negativeYnegativeZ) = nodeIndex-numWidth-numPlane;
                    end
                else
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,negativeYpositiveZ) = nodeIndex-numWidth+2*numPlane; %Interaction term
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,negativeYnegativeZ) = nodeIndex-numWidth; %Interaction term
                    end
                end
                
                
                %% Next Four Neigbors (15,16,17,18) are from [1 1 0] family of directions in the xz-plane
                % Best case for second family [nodeIndex+1+numPlane, nodeIndex+1-numPlane, nodeIndex-1-numPlane, nodeIndex-1+numPlane];
                
                if x~= numWidth %
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,positiveXpositiveZ) = nodeIndex+1+numPlane;
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,positiveXnegativeZ) = nodeIndex+1-numPlane;
                    end
                else
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,positiveXpositiveZ) = nodeIndex+1-numWidth+numPlane; %Interaction term
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,positiveXnegativeZ) = nodeIndex+1-numWidth-numPlane; %Interaction term
                    end
                end
                
                
                if x ~= 1 %
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,negativeXpositiveZ) = nodeIndex-1+numPlane;
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,negativeXnegativeZ) = nodeIndex-1-numPlane;
                    end
                else
                    if z ~= totalHeight && z ~= endFirstLayer
                        neighborList(nodeIndex,negativeXpositiveZ) = nodeIndex-1+numWidth+numPlane; %Interaction term
                    end
                    if z ~= 1 && z ~= startSecondLayer
                        neighborList(nodeIndex,negativeXnegativeZ) = nodeIndex-1+numWidth-numPlane; %Interaction term
                    end
                end
                
                % Last of neighbors. End of loop
            end
        end
    end
    
    % return variable
    neighbors = neighborList;
end

