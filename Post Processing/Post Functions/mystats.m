function hBar = mystats(data, x, width, color, ymax)
    
    data_mean = mean(data);
    data_std = std(data);
    
%     hBar = bar(x, data_mean, width, 'linewidth',1.8);
%     hBar.FaceColor = color;
% 
%     ctr(1,:) = bsxfun(@plus, hBar.XData, hBar.XOffset);
%     ydt(1,:) = hBar.YData;
    
    hold on
% 
%     val = unique(data);
%     cnt = histc(data, val);
%     
%     for j = 1:length(val)
%         y = val(j)*ones(cnt(j), 1);
%         dx = 0.15;
%         if mod(cnt(j),2) == 1
%             num = (cnt(j)-1)/2;
%             x = j-num*dx:dx:j+num*dx;
%         else
%             num = cnt(j)/2;
%             x = j-num/2*dx:dx:j+num/2*dx;
%         end
%         scatter(x,y, 30, 'o', 'markeredgecolor','k','markerfacecolor',color,...
%        'HandleVisibility','off')
% 
%     end
  
    mColor = min([1,1,1], color + [0.3,0.2,0.2]);
    
    
    hwidth = 0.08;
    
    s_data = sort(data);
    
    my_x = x*ones(length(data),1);
    for i = 2:length(data)-1
        if abs(s_data(i) - s_data(i+1))/s_data(i) < 0.1     
            my_mod = mod(i,4);
            if my_mod == 1
                my_x(i) = x - hwidth;
            elseif my_mod == 2
                my_x(i) = x - hwidth/3;
            elseif my_mod == 3
                my_x(i) = x + hwidth/3;
            else
                my_x(i) = x + hwidth;
            end
        end
    end
    s = scatter(my_x, s_data, 20, 'o','fill', 'markeredgecolor', color, 'markerfacecolor', color);
    alpha(s,.3)
    hold on
    hBar = errorbar(x, data_mean, data_std, data_std, 'marker','s','linestyle','none','linewidth',2,'color','k',...
    'HandleVisibility','off', 'CapSize',24, 'markerfacecolor' , mColor, 'markeredgecolor', 'k', 'markersize', 10);

%     set(gca,'xtick',[])
%     set(gca,'xticklabel',[])
    
    grid off
    set(gca,'fontsize',18)
    ax = gca;
    ax.YRuler.Exponent = 0;
%     fig = gcf;
%     fig.PaperUnits = 'inches';
%     fig.PaperPosition = [1 1 5 4];
%     print('max_D','-dpng','-r0')
end