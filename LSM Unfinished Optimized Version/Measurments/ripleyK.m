function [K,L] = ripleyK(xyPositions,s,lengthX,lengthY)

    numberPoints = length(xyPositions);
    area_plane = lengthX*lengthY;
    
%% Duplicate and translate points into 9x9 grid
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
    
%% Calculate statistics    
    
    DX = pdist2(xyPositions,xyDuplicated);
    
    W = zeros(size(s));
    for i = 1:length(s)
        W(i) = nnz(DX < s(i));
    end
    W = W - numberPoints; %Removes zeros on diagonal of matrix
    
    K = W*area_plane/numberPoints^2;
    L = sqrt(K/pi)-s;
    
    
end