function [realNodes, virtualNodes, virtualMap] = getRealNodes_v1(System)
    
    %% System variables
    NUMZ = System.NUMZ;
    NUMY = System.NUMY;
    NUMX = System.NUMX;
    TOTAL = System.TOTAL;
    NUMPLANE = System.NUMPLANE;
    END_FIRST_LAYER = System.END_FIRST_LAYER;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    
    nodeIndex = 1;
    realNodes = [];
    virtualNodes = [];
    virtualMap = zeros(TOTAL,3);
    
    for z = 1:NUMZ
        for y = 1:NUMY
            for x = 1:NUMX
                
                if (x ~= 1 && x ~= NUMX) && (y ~= 1 && y ~= NUMY)
                    realNodes = [realNodes nodeIndex];    
                    
%                     disp([x y])
                    k = 1;
                    modIndex = mod(nodeIndex,NUMPLANE);
                    if modIndex == 0
                        modIndex = NUMPLANE;
                    end
        
                    if y == 2
                        virtualMap(nodeIndex,k) = modIndex + NUMPLANE-2*NUMX;
                        k = k + 1;
                       
                        if x == 2
                            virtualMap(nodeIndex,k) = NUMPLANE;
                            k = k + 1;
                        end
                    end

                    if y == NUMY - 1 
                        virtualMap(nodeIndex,k) = modIndex - NUMPLANE+2*NUMX;
                        k = k + 1;
                        if x == 2
                            virtualMap(nodeIndex,k) = NUMX;
                            k = k + 1;
                        elseif x == NUMX - 1
                            virtualMap(nodeIndex,k) = 1;
                            k = k + 1;
                        end
                    end

                    if x == 2
                        virtualMap(nodeIndex,k) = modIndex + NUMX - 2;
                        k = k + 1;
                    end
                    
                    if x == NUMX - 1
                        virtualMap(nodeIndex,k) = modIndex - NUMX + 2;
                        k = k + 1;
                        
                        if y == 2
                            virtualMap(nodeIndex,k) = NUMPLANE-NUMX+1;
                            k = k + 1;
                        end
                    end
                    
%                     %Display nodes
%                     cla;
%                     updateDisplay_v1()
%                     scatter3(positions(nodeIndex,1),positions(nodeIndex,2),positions(nodeIndex,3)+0.5, 50,'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',2);
                    k = k - 1;
                    virtualMap(nodeIndex,1:k) = virtualMap(nodeIndex,1:k) + (z-1)*NUMPLANE;
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

