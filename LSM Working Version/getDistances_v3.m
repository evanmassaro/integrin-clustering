function distances = getDistances_v3()

    global totalHeight numDepth numWidth numTot numPlane endFirstLayer startSecondLayer
    
    %For the family of [1 0 0] anmd [1 1 0] directions, there are 18 possible 
    %neighbors. Edge cases will have less elements and be represented as zeros.
    
    numDimensions = 3; 
    numFirstFamily = 6; %Six possible [1 0 0] directions x,y,z,-x,-y,-z
    numSecondFamily = 4; %Four possible [1 1 0] directions per plane (xy yz or xz)
    maxNumNeighbors = numFirstFamily + 3*numSecondFamily; % 6 + 3*4 = 18
    distanceList = zeros(numTot,maxNumNeighbors,numDimensions);
    
    %Three coordinates
    xCoordinate = 1;
    yCoordinate = 2;
    zCoordinate = 3;
    
    %First six primary directions
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

    %Equilibrium Spacings
    global del_sub del_gly
    
    nodeIndex = 0;
    for z = 1:totalHeight
        for y = 1:numDepth
            for x = 1:numWidth
                nodeIndex = nodeIndex + 1;
                
                %% Six directions in xyz [1 0 0] directions
                
                % Positive X direction
                if x ~= numWidth
                    distanceList(nodeIndex,positiveX,xCoordinate) = del_sub;  
                else
                    distanceList(nodeIndex,positiveX,xCoordinate) = (numWidth-1)*del_sub;
                end
                
                % Negative X direction
                if x ~= 1
                    distanceList(nodeIndex,negativeX,xCoordinate) = del_sub;
                else
                    distanceList(nodeIndex,negativeX,xCoordinate) = (numWidth-1)*del_sub;
                end
                
                % Positive Y direction
                if y ~= numDepth
                    distanceList(nodeIndex,positiveY,yCoordinate) = del_sub;
                else
                    distanceList(nodeIndex,positiveY,yCoordinate) = (numDepth-1)*del_sub;
                end
                
                % Negative Y direction
                if y ~= 1
                    distanceList(nodeIndex,negativeY,yCoordinate) = del_sub;
                else
                    distanceList(nodeIndex,negativeY,yCoordinate) = (numWidth-1)*del_sub;
                end
                
                % Positive Z direction
                if z ~= endFirstLayer 
                    distanceList(nodeIndex,positiveZ,zCoordinate) = del_sub;
                else
                    distanceList(nodeIndex,positiveZ,zCoordinate) = del_gly;
                end
                
                % Negative Z direction
                if z ~= startSecondLayer
                    distanceList(nodeIndex,negativeZ,zCoordinate) = del_sub;
                else
                    distanceList(nodeIndex,negativeZ,zCoordinate) = del_gly;
                end
                
                %% Four directions in xy-plane 
                
                % positiveXpositiveY direction
                distanceList(nodeIndex,positiveXpositiveY,xCoordinate) = ...
                    distanceList(nodeIndex,positiveX,xCoordinate);
                
                distanceList(nodeIndex,positiveXpositiveY,yCoordinate) = ...
                    distanceList(nodeIndex,positiveY,yCoordinate);
                
                % negativeXpositiveY direction
                distanceList(nodeIndex,negativeXpositiveY,xCoordinate) = ...
                    distanceList(nodeIndex,negativeX,xCoordinate);
                
                distanceList(nodeIndex,negativeXpositiveY,yCoordinate) = ...
                    distanceList(nodeIndex,positiveY,yCoordinate);
                
                % negativeXnegativeY direction
                distanceList(nodeIndex,negativeXnegativeY,xCoordinate) = ...
                    distanceList(nodeIndex,negativeX,xCoordinate);
                
                distanceList(nodeIndex,negativeXnegativeY,yCoordinate) = ...
                    distanceList(nodeIndex,negativeY,yCoordinate);
                
                % positiveXnegativeY direction
                distanceList(nodeIndex,positiveXnegativeY,xCoordinate) = ...
                    distanceList(nodeIndex,positiveX,xCoordinate);
                
                distanceList(nodeIndex,positiveXnegativeY,yCoordinate) = ...
                    distanceList(nodeIndex,negativeY,yCoordinate);                
                
                
                %% Four directions in yz-plane 
                
                % positiveYpositiveZ direction
                distanceList(nodeIndex,positiveYpositiveZ,yCoordinate) = ...
                    distanceList(nodeIndex,positiveY,yCoordinate);
                
                distanceList(nodeIndex,positiveYpositiveZ,zCoordinate) = ...
                    distanceList(nodeIndex,positiveZ,zCoordinate);
                
                % positiveYnegativeZ direction
                distanceList(nodeIndex,positiveYnegativeZ,yCoordinate) = ...
                    distanceList(nodeIndex,positiveY,yCoordinate);
                
                distanceList(nodeIndex,positiveYnegativeZ,zCoordinate) = ...
                    distanceList(nodeIndex,negativeZ,zCoordinate);
                
                % negativeYnegativeZ direction
                distanceList(nodeIndex,negativeYnegativeZ,yCoordinate) = ...
                    distanceList(nodeIndex,negativeY,yCoordinate);
                
                distanceList(nodeIndex,negativeYnegativeZ,zCoordinate) = ...
                    distanceList(nodeIndex,negativeZ,zCoordinate);
                
                % negativeYpositiveZ direction
                distanceList(nodeIndex,negativeYpositiveZ,yCoordinate) = ...
                    distanceList(nodeIndex,negativeY,yCoordinate);
                
                distanceList(nodeIndex,negativeYpositiveZ,zCoordinate) = ...
                    distanceList(nodeIndex,positiveZ,zCoordinate);
                
                %%  Four directions in xz-plane 
                
                % positiveXpositiveZ direction
                distanceList(nodeIndex,positiveXpositiveZ,xCoordinate) = ...
                    distanceList(nodeIndex,positiveX,xCoordinate);
                
                distanceList(nodeIndex,positiveXpositiveZ,zCoordinate) = ...
                    distanceList(nodeIndex,positiveZ,zCoordinate);
                
                % positiveXnegativeZ direction
                distanceList(nodeIndex,positiveXnegativeZ,xCoordinate) = ...
                    distanceList(nodeIndex,positiveX,xCoordinate);
                
                distanceList(nodeIndex,positiveXnegativeZ,zCoordinate) = ...
                    distanceList(nodeIndex,negativeZ,zCoordinate);
                
                % negativeXnegativeZ direction
                distanceList(nodeIndex,negativeXnegativeZ,xCoordinate) = ...
                    distanceList(nodeIndex,negativeX,xCoordinate);
                
                distanceList(nodeIndex,negativeXnegativeZ,zCoordinate) = ...
                    distanceList(nodeIndex,negativeZ,zCoordinate);
                
                % negativeXpositiveZ direction
                distanceList(nodeIndex,negativeXpositiveZ,xCoordinate) = ...
                    distanceList(nodeIndex,negativeX,xCoordinate);
                
                distanceList(nodeIndex,negativeXpositiveZ,zCoordinate) = ...
                    distanceList(nodeIndex,positiveZ,zCoordinate);                
                
            end
        end
    end
    
    distances = distanceList;
end