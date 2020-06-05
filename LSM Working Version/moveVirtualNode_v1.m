function moveVirtualNode_v1(node, delXYZ)
    global virtualMap positions

    for i = 1:length(virtualMap(node,:))
        vNode = virtualMap(node,i);
        if vNode > 0
            positions(vNode,:) = positions(vNode,:) + delXYZ;
        end
    end

end