    
global realNodes  positions virtualMap
    cla; clc;
    updateDisplay_v1()
    
    
for i = 1:length(realNodes)
    
    node = realNodes(i);
    scatter3(positions(node,1),positions(node,2),positions(node,3)+0.5, 50,'MarkerEdgeColor','k','MarkerFaceColor','b','LineWidth',2);
    
    for j = 1:length(virtualMap(node,:)) 
        virtualNode = virtualMap(node,j);

        if virtualNode > 0
            scatter3(positions(virtualNode,1),positions(virtualNode,2),positions(virtualNode,3)+0.5, 60,'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',2); 
        end
    end
    
    x = input('Next...');
    updateDisplay_v1()
end