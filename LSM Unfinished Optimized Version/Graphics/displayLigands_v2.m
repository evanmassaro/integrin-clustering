function displayLigands_v2(node_positions, ligandSites)
    
    mSize = 10;
    mWidth = 2;
    
    % For better display added del_sub/20 term to the ligand and integrin positions
    
    
    L = node_positions(ligandSites,:);
    
    % Ligands
    scatter3(L(:,1), L(:,2), L(:,3),mSize,'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0.9,1,0.3],'LineWidth',mWidth);
    
end

