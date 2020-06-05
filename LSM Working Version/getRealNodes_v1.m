function [realNodes, virtualNodes, virtualMap] = getRealNodes_v1()
    
    global totalHeight numDepth numWidth numPlane numTot positions
    nodeIndex = 1;
    realNodes = [];
    virtualNodes = [];
    virtualMap = zeros(numTot,3);
    
    for z = 1:totalHeight
        for y = 1:numDepth
            for x = 1:numWidth
                
                if (x ~= 1 && x ~= numWidth) && (y ~= 1 && y ~= numDepth)
                    realNodes = [realNodes nodeIndex];    
                    
%                     disp([x y])
                    k = 1;
                    modIndex = mod(nodeIndex,numPlane);
                    if modIndex == 0
                        modIndex = numPlane;
                    end
        
                    if y == 2
                        virtualMap(nodeIndex,k) = modIndex + numPlane-2*numWidth;
                        k = k + 1;
                       
                        if x == 2
                            virtualMap(nodeIndex,k) = numPlane;
                            k = k + 1;
                        end
                    end

                    if y == numDepth - 1 
                        virtualMap(nodeIndex,k) = modIndex - numPlane+2*numWidth;
                        k = k + 1;
                        if x == 2
                            virtualMap(nodeIndex,k) = numWidth;
                            k = k + 1;
                        elseif x == numWidth - 1
                            virtualMap(nodeIndex,k) = 1;
                            k = k + 1;
                        end
                    end

                    if x == 2
                        virtualMap(nodeIndex,k) = modIndex + numWidth - 2;
                        k = k + 1;
                    end
                    
                    if x == numWidth - 1
                        virtualMap(nodeIndex,k) = modIndex - numWidth + 2;
                        k = k + 1;
                        
                        if y == 2
                            virtualMap(nodeIndex,k) = numPlane-numWidth+1;
                            k = k + 1;
                        end
                    end
                    
%                     %Display nodes
%                     cla;
%                     updateDisplay_v1()
%                     scatter3(positions(nodeIndex,1),positions(nodeIndex,2),positions(nodeIndex,3)+0.5, 50,'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',2);
                    k = k - 1;
                    virtualMap(nodeIndex,1:k) = virtualMap(nodeIndex,1:k) + (z-1)*numPlane;
%                     for i = 1:length(virtualMap(nodeIndex,:))
%                         if virtualMap(nodeIndex,i) > 0
%                             scatter3(positions(virtualMap(nodeIndex,i),1),positions(virtualMap(nodeIndex,i),2),positions(virtualMap(nodeIndex,i),3)+0.5, 50,'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',2);
%                         end
%                     end
%                     
%                     disp(virtualMap(nodeIndex,:))
%                     a = input('Next...');
                    
                else
                    virtualNodes = [virtualNodes nodeIndex];
                end
                
                nodeIndex = nodeIndex + 1;
                
            end
        end
    end

