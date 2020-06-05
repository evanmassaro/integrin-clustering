function neighborTest(node)

    global numTot allDistances allNeighbors positions  allSprings
    %disp(['    Index ' ,'   cNode ', '    nNode  | ', 'delX ','     equiX ','    delY ','    equiY ','     delZ ','     equiZ ', '      k'])
    %disp('----------------------------------------------------------------------------------------------------')
    cla
    for i = 1:length(allDistances(node,:,:))

        neighborNode = allNeighbors(node,i);


        if neighborNode > 0        
            x1 = positions(node,1);
            x2 = positions(neighborNode,1);
            y1 = positions(node,2);
            y2 = positions(neighborNode,2);
            z1 = positions(node,3);
            z2 = positions(neighborNode,3);

            x = [x1 x2];
            y = [y1 y2];
            z = [z1 z2];

            line(x,y,z, 'linewidth',3,'color','r');
            hold on
            scatter3(positions(node,1),positions(node,2),positions(node,3),100,'MarkerEdgeColor','k','MarkerFaceColor','b','LineWidth',2);
            scatter3(positions(neighborNode,1),positions(neighborNode,2),positions(neighborNode,3),50,'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',2);
            
            d = abs(positions(node,:) - positions(neighborNode,:));
            b = [allDistances(node, i, 1), allDistances(node, i, 2), allDistances(node, i, 3)];
            %disp([i node neighborNode d(1) b(1) d(2) b(2) d(3) b(3) allSprings(node,i)]);
            
             if d(1) ~= b(1) || d(2) ~= b(2) || d(3) ~= b(3)
                error(['Node ', num2str(node), ' is invalid'])
             end
        end    
    end
   %disp('----------------------------------------------------------------------------------------------------')
end