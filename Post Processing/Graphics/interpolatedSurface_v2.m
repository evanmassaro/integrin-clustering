function interpolatedSurface_v2()
    global numPlane endFirstLayer integrinPositions positions 
    indices = numPlane*endFirstLayer+1:numPlane*(endFirstLayer+1);
    x = positions(indices,1);
    y = positions(indices,2);
    z = positions(indices,3);

    F = scatteredInterpolant(x,y,z);

    xq = integrinPositions(:,1);
    yq = integrinPositions(:,2);

    integrinPositions(:,3) = F(xq,yq);

end
