function getSigHeatmap(L,P,X,Y, xlab, ylab, ti, cbool, color)

    c_level = zeros(size(P));

    for i = 1:length(P(:))
        if P(i) <= 0.0001
            c_level(i) = 4;
        elseif P(i) <= 0.001
            c_level(i) = 3;
        elseif P(i) <= 0.01
            c_level(i) = 2;
        elseif P(i) <= 0.05
            c_level(i) = 1;
        end

    end

%     cmap = [237, 252, 235;
%             171, 255, 182;
%             8, 201, 147;
%             0, 197, 227;
%             0, 89, 179]/255;
    
    M = L.*(c_level > 0);
    
    pcolor([M, zeros(size(M,1), 1); zeros(1, size(M,2)+1)])

    x = 1:size(M,2);
    y = 1:size(M,1);
    
    rounded_num = roundsd(L(:), 2);
    txt = sprintfc('%.0f%%', rounded_num);
    [XX,YY] = meshgrid(x+0.5, y+0.5);
    text(XX(:), YY(:), txt, 'horizontalalignment','center','verticalalignment','middle','fontsize',16)
    
    cmap = cbrewer('seq', color, 100);
    cmap(1,:) = 0.8*ones(1,3);
    cmap(end-30:end,:) = [];
    colormap(cmap);
    caxis([0, max(L, [], 'all')])
        
    if cbool
        cbh = colorbar('location','northoutside');
%         set(cbh,'YTick',(0:4)+0.5)
%         set(cbh,'YTickLabel',{'P > 0.05','P \leq 0.05','P \leq 0.01','P \leq 0.001', 'P \leq 0.0001'})
        title(cbh, ti, 'fontsize', 18)
    else
        title(ti,'fontsize', 18)
    end

    axis equal
    set(gca, 'xtick',x+0.5)
    set(gca, 'xticklabels',X)


    set(gca, 'ytick',y+0.5)
    set(gca, 'yticklabels',Y)

    xlim([min(XX,[],'all')-0.5, max(XX,[],'all')+0.5])
    ylim([min(YY,[],'all')-0.5, max(YY,[],'all')+0.5])
    
    xlabel(xlab)
    ylabel(ylab)
    
    set(gca,'fontsize',18)
end
