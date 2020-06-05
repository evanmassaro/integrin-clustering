function displayNodes_v6(positions)
    hold on;
    global numWidth numDepth numPlane del_sub
    global del_bond del_gly
    global startSecondLayer
    
    % Plot initial node positions
    cla;
    xlabel('x axis (nm)');
    ylabel('y axis (nm)');
    zlabel('z axis (nm)');
    division = 10;
    xlin = del_sub/2:del_sub/division:del_sub*(numWidth-1.5);
    ylin = del_sub/2:del_sub/division:del_sub*(numDepth-1.5);
    [X,Y] = meshgrid(xlin,ylin);
    
    i = startSecondLayer;
    A = positions(numPlane*(i-1)+1:numPlane*i, :);
    Z = griddata(A(:,1),A(:,2),A(:,3), X, Y,'natural');
    s = surf(X,Y,Z,'LineWidth',0.1);
    s.EdgeColor = 'none';
    s.FaceAlpha = 0.5;
    
    c = colorbar('northoutside');
    c.Label.String = 'Height (nm)';
    caxis([del_bond del_gly])
    axis square
    colormap(hot)
   
    grid on;
    pause(0);
    
end

