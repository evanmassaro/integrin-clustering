function displayNodes_v6(System,Del,node_positions)
    LENX = System.LENX ;
    LENY = System.LENY;
    
    NUMPLANE = System.NUMPLANE;
    Del_SUB = Del.SUB;
    Del_BOND = Del.BOND;
    Del_GLY = Del.GLY;
    START_SECOND_LAYER = System.START_SECOND_LAYER;
    
    
    hold on;

    % Plot initial node positions
    cla;
    xlabel('x axis (nm)');
    ylabel('y axis (nm)');
    zlabel('z axis (nm)');
    division = 10;
    xlin = 0:Del_SUB/division:LENX;
    ylin = 0:Del_SUB/division:LENY;
    [X,Y] = meshgrid(xlin,ylin);
    
    i = START_SECOND_LAYER;
    A = node_positions(NUMPLANE*(i-1)+1:NUMPLANE*i, :);
    Z = griddata(A(:,1),A(:,2),A(:,3), X, Y,'natural');
    
    
    C = Del_GLY - Z;
    s = surf(X,Y,Z,C,'LineWidth',0.1);
    s.EdgeColor = 'none';
    s.FaceAlpha = 0.5;
    
    c = colorbar('eastoutside');
    c.Label.String = 'Deformation (nm)';
    caxis([0 Del_BOND])
    set(c,'Ytick',linspace(0,Del_BOND,4),'fontsize',14)
    colormap(flipud(hot))
   
    pause(0);
    
end

