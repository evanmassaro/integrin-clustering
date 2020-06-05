function [q1, p1] = getTrials(type,base_name,num_trials,color,time_index)
    countL = 0;
    B = cell(4,1);
    for i = 1:num_trials
        file_name = [base_name,'_v',num2str(i),'.mat'];
        try
            P = load(file_name);
        catch
            continue
        end
        
        countL = max(countL,P.countL);
        if strcmp(type,'displayLStatistic')
            countL = P.countL;
        end
        if nargin > 4
            countL = time_index;
        end
        if strcmp(type,'displayBondFraction')
            [~, bondFrac] = getBondFraction(P.bondFrac,P.countL,color,countL);
            B{i} = bondFrac;
        end
        
        if strcmp(type,'displayLStatistic')
            [S, L] = graphLStatistic_v1(P.S,P.LMatrix,color,countL);
            B{i} = L;
        end
    end

    B1 = B{1};
    B2 = B{2};
    B3 = B{3};
    B4 = B{4};
    
    b_std = [];
    b_avg = [];
    
    max_length = max([length(B1), length(B2), length(B3), length(B4)]);
    for i = 1:max_length
        x = [];
        if i <= length(B1)
            x = [x B1(i)];
        end
        if i <= length(B2)
            x = [x B2(i)];
        end 
        if i <= length(B3)
            x = [x B3(i)];
        end
        if i <= length(B4)
            x = [x B4(i)];
        end
        if length(x) >= 2
            b_std = [b_std std(x)];
            b_avg = [b_avg mean(x)];
        end
    end
    
%     N = size(y,1);                          % Number of ?Experiments? In Data Set
%     yMean = mean(y);                        % Mean Of All Experiments At Each Value Of ?x?
%     
%     ySEM = std(y)/sqrt(N);                  % Compute ?Standard Error Of The Mean? Of All Experiments At Each Value Of ?x?
%     CI95 = tinv([0.025 0.975], N-1);        % Calculate 95% Probability Intervals Of t-Distribution
%     yCI95 = bsxfun(@times, ySEM, CI95(:));  % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ?x?

    if strcmp(type,'displayBondFraction')
        t = 0:length(b_std)-1;
        hold on
        [~, q1] = boundedline(t, b_avg*100, b_std*100, 'cmap', color, 'alpha', 'transparency', 0.2);
        p1 = plot(t, b_avg*100, color, 'linewidth', 2);

        yticks([0, 25, 50, 75, 100])
        yticklabels({'0', '25', '50', '75', '100'})
        xlim([0, max(t)])
        ylim([0, 100])
        xlabel('Time (s)')
        ylabel('Bond Fraction (%)')   
    end
    
    if strcmp(type,'displayLStatistic')
        hold on
        [~, q1] = boundedline(S, b_avg, b_std, 'cmap', color, 'alpha', 'transparency', 0.2);
        p1 = plot(S, b_avg, color, 'linewidth', 2);
        xlim([0, S(end)])
        xticks([0, 200, 400, 600])
        xticklabels({'0', '200', '400', '600'})
        
        ylim([-20,60])
        yticks([-20, 0, 20, 40, 60])
        yticklabels({'-20', '0', '20', '40', '60'})
        xlabel('distance (nm)')
        ylabel('L-statistic (nm)')
    end
 end
    