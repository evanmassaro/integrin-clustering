clc; clear;
    
% Specify metric and variable here
metric = 'onsetB'; by = 'L'; savefig = true;




%% Load data set

S = load('all_stats');
all_data = S.all_data;

groups = findgroups(all_data(:,1), all_data(:,2), all_data(:,3));
[sorted_groups, indices] = sort(groups);
all_data = [sorted_groups, all_data(indices,:)];

E = log10(all_data(:,2)+1);
L = all_data(:,3);
k = all_data(:,4);
Lstar = all_data(:,5);
Rstar = all_data(:,6);
Area = all_data(:,7);
LRstar = all_data(:,8);

maxB = all_data(:,9);
onsetB = all_data(:,10);
onsetT = all_data(:,11);
halfT = all_data(:,12) - onsetT;
halfB = all_data(:,13);


switch metric
    case 'Lstar'
        fit_color = [0.4, 0.6, 1];
    case 'Rstar'
        fit_color = [0.4, 0.6, 1];
    case 'Area'
        fit_color = [0.8, 0.8, 0.4];
    case 'maxB'
        fit_color = [0.4, 0.6, 1];
    case 'onsetB'
        fit_color = [159, 120, 194]/255;
    case 'halfB'
        fit_color = [0.8, 0.8, 0.4];
    case 'halfT'
        fit_color = [159, 120, 194]/255;
    otherwise
        error('Invalid metric')
end
 

CM1 =[39, 104, 204;
      165, 35, 203;
      0, 205, 34;
      101, 235, 203]/255;

CM2 =[0, 223, 191;
      255, 186, 181;
      255, 225, 105;
      242, 128, 233]/255;
  
  
%% Show response as a function of L
if strcmp(by, 'L')
    E = all_data(:,2)*40/15;
    set(0,'DefaultAxesTitleFontWeight','normal');
    s1 = {};
    s2 = {};
    c = 1;
    marker = {'s', 'o'};
    for E_i = [0, 40, 400, 4000]
        subplot(2,2,c)
        grid on; hold on

        L_vector = linspace(200, 1000, 100);
        for k_i = [0.4, 0.8] %[0.4, 0.8]
            if strcmp(metric,'Lstar')
                predicted = Lstar_fit(k_i, L_vector, E_i);
                response = Lstar;
                color_index = 1;
                ylabel('$L^*$ (nm)','interpreter','latex')
                ylim([0, 120])
                yticks([0 40 80 120])
            elseif strcmp(metric,'Rstar')
                predicted = Rstar_fit(k_i, L_vector, E_i); 
                response = Rstar;
                color_index = 1;
                ylabel('$R^*$ (nm)','interpreter','latex')
                ylim([0, 500])
                yticks([0 125 250 375 500])
            elseif strcmp(metric,'Area')
                predicted = Areastar_fit(k_i, L_vector, E_i)/1000; 
                response = Area/1000;
                color_index = 3;
                ylabel('$A$ (10^3. nm^2)','interpreter','latex')
                ylim([0, 60])
                yticks([0, 20, 40, 60])
            elseif strcmp(metric,'maxB')
                predicted = maxB_fit(k_i, L_vector, E_i); 
                response = maxB;
                color_index = 1;
                ylabel('$B_{max}$ $(1/s)$','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'onsetB')
                predicted = onsetB_fit(k_i, L_vector, E_i); 
                response = onsetB;
                color_index = 2;
                ylabel('$B_{initial}$ $(1/s)$','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'halfB')
                predicted = halfwayB_fit(k_i, L_vector, E_i); 
                response = halfB;
                color_index = 3;
                ylabel('$B_{halfway}$ $(1/s)$','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'halfT')
                predicted = halfwayT_fit(k_i, L_vector, E_i); 
                response = halfT;
                color_index = 2;
                ylabel('$T_{halfway}$ (s)','interpreter','latex')
                ylim([0, 18])
                yticks([0, 6, 12, 18])
            end


            if k_i == 0.4
                color = CM1(color_index,:);
                m = marker{1};
            else
                color = CM2(color_index,:);
                m = marker{2};
            end

            s1{end+1} = plot(L_vector, predicted, 'linewidth',1.0, 'color', fit_color, 'linestyle', '-');
            s2{end+1} = errorbar_subplot(sorted_groups, k, L, E, k_i, [], E_i, 3, 1, response, color, m);
            
        end

        if c == 1
%             legend([s2{1}, s2{2}, s1{1}], {'\sigma_m = 0.4 pN/nm', '\sigma_m = 0.8 pN/nm', ...
%                 'T_{halfway}(\sigma_m, \rho, E)'}, ...
%                 'location', 'northoutside', 'Orientation', 'horizontal', 'NumColumns', 3)
            legend([s1{1}], {'R^*(\sigma_m, \rho, E)'}, ...
                'location', 'northoutside', 'Orientation', 'horizontal', 'NumColumns', 3)
        end
        title(['E = ',num2str(E_i*15/40), ' V/cm'])
        xlim([150, 1050])
        xticks([200, 500, 1000])
        xlabel('\rho (\mum^{-2})')  
%         if c > 2
%              
%         else
%             set(gca, 'xticklabels', [])
%         end
%         if mod(c,2) == 0
%             set(gca, 'yticklabels', [])
%             ylabel('')
%         end
        c = c+1;
    end
    if savefig
        fig = gcf;
        fig.PaperPosition = [0 0 5 4.75];
        print(metric,'-dpng','-r1000')
    end
    
end
% fig = gcf;
% %fig.PaperPosition = [0 0 5 5];
% print(metric,'-dpng','-r400')

%% Show response as a function of E
if strcmp(by, 'E')
    s1 = {};
    s2 = {};
    c = 1;
    marker = {'s', 'o'};
    for L_i = [200, 500, 1000]
        subplot(3,1, c)
        grid on; hold on

        E_vector = logspace(-1, log10(4000), 100);

        for k_i = [0.4, 0.8]

            if strcmp(metric,'Lstar')
                predicted = Lstar_fit(k_i, L_i, E_vector); 
                response = Lstar;
                color_index = 1;
                ylabel('L^* (nm)')
                ylim([0, 120])
                yticks([0 30 60 90 120])
            elseif strcmp(metric,'Rstar')
                predicted = Rstar_fit(k_i, L_i, E_vector); 
                response = Rstar;
                color_index = 2;
                ylabel('R^* (nm)')
                ylim([0, 500])
                yticks([0 125 250 375 500])
            elseif strcmp(metric,'Area')
                predicted = Areastar_fit(k_i, L_i, E_vector)/1000; 
                response = Area/1000;
                color_index = 3;
                ylabel('A (10^3. nm^2)')
                ylim([0, 60])
                yticks([0, 20, 40, 60])
            elseif strcmp(metric,'maxB')
                predicted = maxB_fit(k_i,L_i, E_vector); 
                response = maxB;
                color_index = 1;
                ylabel('$B_{max}$ (1/s)','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'onsetB')
                predicted = onsetB_fit(k_i,L_i, E_vector); 
                response = onsetB;
                color_index = 2;
                ylabel('$B_{onset}$ (1/s)','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'halfB')
                predicted = halfwayB_fit(k_i,L_i, E_vector); 
                response = halfB;
                color_index = 3;
                ylabel('$B_{halfway}$ (1/s)','interpreter','latex')
                ylim([0, 0.4])
                yticks([0, 0.1, 0.2, 0.3, 0.4])
            elseif strcmp(metric,'halfT')
                predicted = halfwayT_fit(k_i,L_i, E_vector); 
                response = halfT;
                color_index = 4;
                ylabel('$T_{halfway}$ (s)','interpreter','latex')
                ylim([0, 18])
                yticks([0, 6, 12, 18])
            end

            if k_i == 0.4
                color = CM1(color_index,:);
                m = marker{1};
            else
                color = CM2(color_index,:);
                m = marker{2};
            end
            s1{end+1} = plot(log10(E_vector*15/40+1), predicted, 'linewidth',1.0, 'color', fit_color, 'linestyle', '-');
            s2{end+1} = errorbar_subplot(sorted_groups, k, L, E, k_i, L_i, [], 2, 1, response, color, m);
        end

%         if c == 1
%             legend([s2{1}, s2{2}, s1{1}], {'\sigma_m = 0.4 pN/nm', '\sigma_m = 0.8 pN/nm', ...
%                 'T_{halfway}(\sigma_m, \rho, E)'}, ...
%                 'location', 'northoutside', 'Orientation', 'horizontal', 'NumColumns', 1)
%         end

        if c < 3
            set(gca,'xticklabel',[])
        end
        if c == 3
            xlabel('log_{10}(E+1)')
        end
        xlim([-0.2,3.35])
        set(gca, 'xtick', [0, 1, 2, 3])
    %         title(['\sigma_m = ', num2str(k_i), ' pN/nm'],'FontWeight','Normal')
    %         ylabel(['\rho = ', num2str(L_i), ' \mum^{-2}'])

        c = c+1;
    end
    
    if savefig
        fig = gcf;
        fig.PaperPosition = [0 0 2.5 7.5];
        print(metric,'-dpng','-r1000')
    end
end
% fig = gcf;
% fig.PaperPosition = [0 0 2.5 7.5];
% print(metric,'-dpng','-r400')
