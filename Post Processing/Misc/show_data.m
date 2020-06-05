function save_data(data_name,num_trials,type)

    data = [];
    for i = 1:num_trials
        if i ~= 2
            fname = [data_name,'_v',num2str(i),'.mat'];
            P = load(fname);
            countL = P.countL;
            if nargin > 2
                countL = returnIndex(P,type);
            end
            
            data = [data; P.LMatrix(countL,:)];
            if i == num_trials
                data = [P.S; data];
            end
        end
    end
    
    file_name = [data_name,'.csv'];
    if nargin > 2
        file_name = [data_name, type, '.csv'];
    end
    csvwrite(file_name,data')
    
    function count = returnIndex(P,type)
        if strcmp(type,'_DD')
            delta_bonds = P.bondFrac(2:P.countL) - P.bondFrac(1:P.countL-1);
            [~, count] = max(delta_bonds);
        end
        
    end
end