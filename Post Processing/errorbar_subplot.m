function s = errorbar_subplot(sorted_groups, z1, z2, z3, z1_levels, z2_levels, z3_levels, var_a, var_b, Y, color, marker)

    levels_a = get_levels(z1_levels, z2_levels, z3_levels, var_a);
    levels_b = get_levels(z1_levels, z2_levels, z3_levels, var_b);
    
    vars = [1,2,3];
    vars(var_a) = 0;
    vars(var_b) = 0;
    var_x = vars(vars > 0);
   
    z_a = get_levels(z1, z2, z3, var_a);
    z_b = get_levels(z1, z2, z3, var_b);
    z_x = get_levels(z1, z2, z3, var_x);
    
            
    for i = 1:max(sorted_groups)
        bool_a = 0;
        bool_b = 0;
        
        id = find(sorted_groups == i);
        
%         disp([levels_a, levels_b])
        x = z_x(id);
        y = Y(id);
        
        is_match_a = abs(z_a(id)-levels_a) < 10^(-6);
        if all(is_match_a) > 10^(-6)
%             disp([levels_a, z_a(id)'])
            bool_a = 1;
        end
        is_match_b = abs(z_b(id)-levels_b) < 10^(-6);
        if all(is_match_b)
%             disp([levels_b, z_b(id)'])
            bool_b = 1; 
        end
        
        if bool_a && bool_b
             %disp([z_a(id)-levels_a, z_b(id)-levels_b])
            
            s = errorbar(mean(x), mean(y), -std(y), std(y), 'marker',marker,...
                'linestyle','none','linewidth',1.0,'color','k',...
                'HandleVisibility','off', 'CapSize',3, 'markerfacecolor', ...
                color, 'markersize',4);
        
        end
    end
end


function levels = get_levels(z1_levels, z2_levels, z3_levels, var)
    if var == 1
        levels = z1_levels;
    elseif var == 2
        levels = z2_levels;
    elseif var == 3
        levels = z3_levels;
    else
        error('invalid axis')
    end
end