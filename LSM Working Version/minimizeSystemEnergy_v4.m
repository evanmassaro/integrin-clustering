function [meanE, stdE] = minimizeSystemEnergy_v4(moveableNodes, numIter)

    global numPlane del_sub  k_bond
    global positions allNeighbors allSprings allDistances 
    global nm2m kBT
    global realNodes
    j = 1;
    numL = floor(numIter*(1/10));
    numAccepted = 0;
    
    % Monte Carlo tuning parameters
    dispacementFactor = 100;
    nodeDeviation = del_sub/dispacementFactor;
    unitEnergy = 1/2*k_bond*(del_sub/400)^2; %Length units in mnm
    
    totalEnergy = zeros(numIter,1);
    totalEnergy(1) = getSystemEnergy_v2(moveableNodes);
    
    for i = 1:numIter
        
        %% Determine properties in immediate neighborhood
        
        randIndex = randi(length(moveableNodes));
        randNode = moveableNodes(randIndex);

        neighborList = allNeighbors(randNode,:);
        springList = allSprings(randNode,:);
        distanceArray = squeeze(allDistances(randNode,:,:));
        
        oldPositions = positions;

        %% Get energy for node before displacement
        
        oldEnergy = getEnergy_v4(randNode, ...
                                 neighborList, ...
                                 springList, ...
                                 positions, ...
                                 distanceArray);
        
        %% Perturbe node position 
                             
        delXYZ = (2*rand(1,3)-1)*nodeDeviation;
        
        positions(randNode,:) = positions(randNode,:) + delXYZ;
        
        %% Get energy for node after displacement
        
        newEnergy = getEnergy_v4(randNode, ...
                                 neighborList, ...
                                 springList, ...
                                 positions, ...
                                 distanceArray);
        
        delLocalEnergy = newEnergy - oldEnergy;
        
        %% Acceptance criteria
        
        if delLocalEnergy < 0
            moveVirtualNode_v1(randNode, delXYZ)
            numAccepted = numAccepted + 1;
            
            j = j + 1;
            totalEnergy(j) = totalEnergy(j-1) + delLocalEnergy;
            
        elseif exp(-1*delLocalEnergy/unitEnergy) > rand
            moveVirtualNode_v1(randNode, delXYZ)
            numAccepted = numAccepted + 1;
            
            j = j + 1;
            totalEnergy(j) = totalEnergy(j-1) + delLocalEnergy;
            
        else
            positions = oldPositions;
        end                      
      
        
        %% Display Progress Bar
        
        if mod(i,numL) == 1 || i == numIter     
%             figure(1)
%             updateDisplay_v1();
%             disp(['MC progress: ', num2str((i-1)/numIter, '%.2f')])
%           
            % Update total energy directly, to prevent error accumulation
            totalEnergy(j) = getSystemEnergy_v2(moveableNodes);
        end   
        
    end   
    if (j-50) >0
        sampledEnergy = totalEnergy(j-50:j);
    elseif (j-4) > 0
        sampledEnergy = totalEnergy(j-4:j);
    else
        sampledEnergy = totalEnergy(j);
    end
    meanE = mean(sampledEnergy);
    stdE = std(sampledEnergy);
end