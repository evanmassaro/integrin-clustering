function [K,L] = ripleyK(xyPositions,S,lengthX,lengthY)

    numberPoints = length(xyPositions);
    area = lengthX*lengthY;
    
    
    xyDuplicated = zeros(9*numberPoints,2);
    k = 0;
    for i = -1:1
        for j = -1:1 
            if i ~= 0 || j ~= 0
                xyTranslated = [xyPositions(:,1)+lengthX*i, xyPositions(:,2)+lengthY*j];
                xyDuplicated(1+numberPoints*(k+1):numberPoints+numberPoints*(k+1),1:2) = xyTranslated;
                k = k + 1;
            end
        end
    end
    xyDuplicated(1:numberPoints,1:2) = xyPositions;
    
    K = zeros(1,length(S));
    L = zeros(1,length(S));
    for r = 1:length(S)
        W = 0;

        for i = 1:length(xyPositions)
            for j = 1:length(xyDuplicated)
                distance = sqrt((xyPositions(i,1)-xyDuplicated(j,1))^2 + (xyPositions(i,2)-xyDuplicated(j,2))^2);
                if distance < S(r) && i ~= j
                    W = W + 1;
                end
            end
            
        end
        
        K(r) = W*area/numberPoints^2;
        L(r) = sqrt(K(r)/pi)-S(r);
    end
    
    
end