function hBar = displayStats(type, base_name, trials, center, width, color, ymax)
    metric = [];
    for i = trials
        file_name = [base_name,'_v',num2str(i),'.mat'];
        try
            P = load(file_name);
        catch
            continue
        end
        metric = [metric, grab_metric(type, P)];
        
    end
    
        disp(base_name)
        for i = 1:length(metric)
            fprintf('%.4f\n',metric(i))
        end
    
    hBar = mystats(metric, center, width, color, ymax);
    
    if strcmp(type,'Lstar')
        ylabel('$L^*$ (nm)', 'interpreter', 'latex')
    elseif strcmp(type,'Rstar')
        ylabel('R^* (nm)')
    elseif strcmp(type,'LRstar')
        ylabel('L^*\cdot R^* (nm^2)')
    elseif strcmp(type,'Area')
        ylabel('Area (nm^2)')
    elseif strcmp(type, 'maxRate')
        ylabel('$B_{max}$ (1/s)', 'interpreter', 'latex')
    elseif strcmp(type, 'onsetTime')
        ylabel('Time at First Bond (s)')
    elseif strcmp(type, 'onsetRate')
        ylabel('Onset Bond Rate (s)')
    elseif strcmp(type, 'adjHalfwayTime')
        ylabel('$T_{1/2}$ (s)', 'fontsize',18, 'Interpreter', 'Latex')
    elseif strcmp(type, 'halfwayRate')
        ylabel('Rate at halfway (1/s)')
    end
    
    grid on
    
    %% 
    function out = grab_metric(type, P)
        L = P.LMatrix(end,:);
        [m, ind] = max(L);
        s = P.S(ind);
        if strcmp(type, 'Lstar')
            out = m;
        elseif strcmp(type, 'Rstar')
            out = s;
        elseif strcmp(type, 'LRstar')
            out = m * s;
        elseif strcmp(type, 'Area')
            out = trapz(P.S,L);
        elseif strcmp(type, 'maxRate')
            bondFrac = P.bondFrac;
            deltaBond = bondFrac(2:end) - bondFrac(1:end-1);
            out = max(deltaBond);
        elseif strcmp(type, 'onsetTime')
            bondFrac = P.bondFrac;
            idx = find(bondFrac~=0, 1, 'first');
            out = idx - 1;
        elseif strcmp(type, 'onsetRate')
            bondFrac = P.bondFrac;
            idx = find(bondFrac~=0, 1, 'first');
            out = bondFrac(idx) - bondFrac(idx-1);
        elseif strcmp(type, 'adjHalfwayTime')
            bondFrac = P.bondFrac;
            idx = find(bondFrac > 0.5, 1, 'first');
            out = idx - (find(bondFrac~=0, 1, 'first') - 1);
            % haldway time - onset time
        elseif strcmp(type, 'halfwayRate')
            bondFrac = P.bondFrac;
            idx = find(bondFrac > 0.50, 1, 'first');
            out = (bondFrac(idx+1) - bondFrac(idx-2))/3;
        end
            
            
    end 
 end
    