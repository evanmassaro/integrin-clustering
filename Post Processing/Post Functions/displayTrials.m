function displayTrials(type,base_name,num_trials,color,time_index)
    countL = 0;
    for i = 1:num_trials
        file_name = [base_name,'_v',num2str(i),'.mat'];
        try
            P = load(file_name);
        catch
            continue
        end
        
        countL = max(countL,P.countL);
        if strcmp(type,'graphLStatistic_v1')
            countL = P.countL;
        end
        if nargin > 4
            countL = time_index;
        end
        
        plot_type(type,P,countL)
    end

    
    function plot_type(type,P,count)
        if strcmp(type,'graphLStatistic_v1')
            graphLStatistic_v1(P.S,P.LMatrix,color,count)
            hold on
        elseif strcmp(type,'displayBondRate')
            displayBondRate(P.bondFrac,P.countL,color,count,0.4)
            hold on
        elseif strcmp(type,'displayBondFraction')
            displayBondFraction(P.bondFrac,P.countL,color,count)
            hold on
        end
    end 
 end
    