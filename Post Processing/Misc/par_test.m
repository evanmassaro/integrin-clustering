clc; clear
rng('default')
pause_time = rand(12,1);

A = zeros(12,10);

parfor j = 1:12
    rng('default')
    pause(pause_time)
    rng('shuffle')
    for i = 1:10
%          rng('shuffle')
        A(i,j) = rand()
    end
    
end
%%
plot(A', 'linestyle', 'none', 'marker', 'o')

% % fileID = fopen(['test_',num2str(j), '.txt'],'w');
% % fprintf(fileID,'%6.2f', rand(10,1));
% % fclose(fileID);
% 
% fileID = fopen(['test_', num2str(12), '.txt'],'w')
% fprintf(fileID,'%8.4f', rand(10,1));
% fclose(fileID);
