function  [samplingRegion, samplingTime] = getSamplingRegion_v1(centralNode)

    global numPlane virtualBuffer numWidth numDepth
    global endFirstLayer startSecondLayer totalHeight
    
    length = 10;
    samplingTime = (2*length+1)^2*(totalHeight-endFirstLayer)*5*10^3; %5*10^3 MC Sweeps
    
    %% Establish point in base layer
    
    baseNode = centralNode;
    while baseNode > numPlane
        baseNode = baseNode - numPlane;
    end
    
    xCenter = mod(baseNode,numWidth);
    if xCenter == 0
        xCenter = numWidth;
    end    
    
    assert( (xCenter > 1) && (xCenter < numWidth))
    
    %% Find nodes in x direction
    
    %Forward x   
    modXForward = mod(xCenter+length,numWidth-2*virtualBuffer);
    if modXForward == 0
        modXForward = numWidth-2*virtualBuffer;
    end
    
    if modXForward < xCenter
        xOverflow = virtualBuffer+1:modXForward;
        xForward = xCenter+1:numWidth-virtualBuffer;
    else
        xForward = xCenter+1:modXForward;
        xOverflow = [];
    end
    
    %Reverse x   
    modXReverse = mod(xCenter-length,numWidth-2*virtualBuffer);
    if modXReverse == 0
        modXReverse= numWidth-2*virtualBuffer;
    end
    
        
    if modXReverse > xCenter
        xUnderflow = modXReverse:numWidth-virtualBuffer;
        xReverse = virtualBuffer+1:xCenter-virtualBuffer;
    else
        if modXReverse == 1
            xReverse = modXReverse+1:xCenter-1;
            xUnderflow = numWidth-virtualBuffer;
        else
            xReverse = modXReverse:xCenter-1;
            xUnderflow = [];
        end
    end
    
    possibleX = [xOverflow xReverse xCenter xForward xUnderflow];

    %% Find nodes in y direction
    
    yCenter = ceil(baseNode/numDepth);  
    
    assert( (yCenter > 1) && (yCenter < numWidth))
    
    if (yCenter + length < numWidth)
        yForward = yCenter+1:yCenter+length;
        yOverflow = [];
    else
        yLow = yCenter+length - numDepth +2*virtualBuffer;
        yForward = yCenter+1:numDepth-virtualBuffer;
        yOverflow = 1+virtualBuffer:yLow;
    end
    
    if (yCenter - length > 1)
        yReverse = yCenter-length:yCenter-1;
        yUnderflow = [];
    else
        yHigh = yCenter-length + numDepth;
        yReverse = 1+virtualBuffer:yCenter-1;
        yUnderflow = yHigh-2*virtualBuffer:numDepth-virtualBuffer;
    end
    
    possibleY = [yOverflow yReverse yCenter yForward yUnderflow];
    
    %% Get entire sampling region
    
    lenX = size(possibleX,2);
    lenY = size(possibleY,2);
    lenPlane = lenX*lenY;
    nodesInPlane = zeros(lenX*lenY,1);
    
    for i = 1:lenY
        nodesInPlane((i-1)*lenY+1:i*lenY) = (possibleY(i)-1)*numWidth+possibleX;
    end
    
    samplingRegion = zeros(lenPlane*(totalHeight-startSecondLayer+1),1);
    for j = startSecondLayer:totalHeight
        samplingRegion((j-startSecondLayer)*lenPlane+1:(j-startSecondLayer+1)*lenPlane) = nodesInPlane+(j-startSecondLayer+1)*numPlane;
    end

%     global positions realNodes
%     cla
%     scatter3(positions(1:numPlane,1),positions(1:numPlane,2),positions(1:numPlane,3))
%          nodes = realNodes(1:size(realNodes,2)/4);
%     scatter3(positions(nodes,1),positions(nodes,2),positions(nodes,3))
%     hold on
%     scatter3(positions(samplingRegion,1),positions(samplingRegion,2),positions(samplingRegion,3))
    
end