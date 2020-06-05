function normForce = calculateNetForce_v1()

    global positions allNeighbors allSprings allDistances nm2m
    netForce = zeros(length(positions),3);
    normForce = zeros(length(positions),1);
    
    for centralNode = 1:length(positions)
        for j = 1:length(allNeighbors(centralNode,:))    
            
            neighborNode = allNeighbors(centralNode,j);
            if neighborNode > 0
                equilibriumDistance = norm(permute(allDistances(centralNode,j,:),[1,3,2]));
                absDistance = norm(positions(neighborNode,:) - positions(centralNode,:));
                distance = positions(neighborNode,:) - positions(centralNode,:);
                
                force = allSprings(centralNode,j).*(absDistance - equilibriumDistance)/absDistance*distance*nm2m;
                
                netForce(centralNode,1:3) = netForce(centralNode,1:3) + force; 
                    
            end 
        end
        
        normForce(centralNode) = norm(netForce(centralNode,1:3));
        
    end
    
    
end