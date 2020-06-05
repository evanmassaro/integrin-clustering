clc; clear;

% folders = {'del_gly 41 k_gly 0.02 k_mem 0.2',...
%            'del_gly 41 k_gly 0.02 k_mem 0.4',...
%            'del_gly 41 k_gly 0.02 k_mem 0.8'};
    
% folders = {'del_gly 41 k_gly 0.02 k_mem 0.8',...
%            'del_gly 43 k_gly 0.02 k_mem 0.8'};
       
for i = 1:length(folders)
    [~,~,~] = mkdir(folders{i});
    addpath(folders{i})    
end

%% Make merged files
% close all
% for i = 1:length(folders)
%     ls = dir(folders{i});
%     files =ls.name;
%     fullstr = [ls.name];
%     C = strsplit(fullstr,'.mat');
%     C{1} = C{1}(4:end);
%     C(end) = [];
%     C = strcat(C,'.mat');
%     
%     newName = [folders{i}, '_Merged.mat'];
%     mergeMAT(newName,C{:})
%     
% end

%%
randC = 'rgb';
for i = 1:length(folders)
    ls = dir(folders{i});
    files =ls.name;
    fullstr = [ls.name];
    C = strsplit(fullstr,'.mat');
    C{1} = C{1}(4:end);
    C(end) = [];
    
    
    G = strsplit(folders{i},'del_gly ');
    F = strsplit(folders{i},'k_gly ');
    H = strsplit(folders{i},'k_mem ');
    
    
    del_gly = str2double(G{2}(1:2));
    k_gly = str2double(F{2}(1:4))/10^3;
    k_mem = str2double(H{2})/10^3;
    
    %figure(i)
    set(gcf,'position',[200,0,550,800])
    subplot(2,1,1); %cla;
    subplot(2,1,2); %cla;
    for j = 1:length(C)
        vers = num2str(j);
        [forceC, energyC] = getFits_v1(del_gly,k_gly,k_mem,vers,true,randC(i));
    end
end