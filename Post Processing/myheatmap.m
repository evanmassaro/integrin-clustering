clc; clear;

X = [0,15,150,1500];
Y = [200,500,1000];


% ylabel('$T_{1/2}$ (s)', 'fontsize',18, 'Interpreter', 'Latex')
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 3];
% print('Lstar','-dpng','-r1000') 

% Cp = cbrewer('seq', 'YlGnBu', 100); 
% Cp = Cp(1:end-30, :); 
% Cp(1,:) = [0.85; 0.85; 0.85];
% 
% Cm = cbrewer('seq', 'YlOrRd', 50); 
% Cm = Cm(1:end-30, :); 
% Cm(1,:) = [0.85; 0.85; 0.85];
% 
% C = [flipud(Cm); Cp];

n = 1000;
C = cbrewer('div', 'Spectral', n);

Cm = C(1:n/2,:);
Cp = C(n/2+1:end,:);
Cm = Cm(1:5:end,:);
Cm(end-10:end,:) = [];
Cm(1:24,:) = [];
Cp(1:2:end,:) = [];
Cp(1:2:40,:) = [];

% Cm(end,:) = 0.85;
% Cp(1,:) = 0.85;
C = [Cm; Cp];

%%

title('Percent Change in Metrics by Increasing Membrane Stiffness from 0.4 pN/nm to 0.8 pN/nm; Nonsignificant Changes $(p > 0.05)$ are Gray', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 
          
%%

% fig = gcf;                    
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 3];
print('Lstar','-dpng','-r1000') 




%% Lstar
z = [1.43513167,    1.824058974, 0.781437111,   0.63350822;
     3.113729123,	1.865224599, 1.886878227,	0.598473115;
     2.648281805,	2.09830801,	 2.187213386,	0.712716711]*100;
 
rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);



getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in L^{*} (%)', C)

title('Increase in $L^*$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 
%                     
% fig = gcf;                    
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 3];
% print('Lstar','-dpng','-r1000') 

%% Rstar
z = [0.503003003,	1.174738841,	0.570454545,	0.51187905;
     1.365771812,	0.459657702,	0.871232877,	0.607675906;
     1.635245902,	0.982089552,	1.017751479,	0.337552743]*100;

rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);


z(3,4) = 0;


getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in R^{*} (%)', C) 

title('Increase in $R^*$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 
                    
fig = gcf;                    
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 4.5 3];
print('Rstar','-dpng','-r1000') 

%% A
z = [1.988367018	3.594003517	1.130955649	0.990783788;
     9.655928732	2.594916703	4.69114076	0.752131517;
     8.761407593	5.641578308	5.926897359	1.187984138]*100; 
 
rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);



getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in A (%)', C)   

title('Increase in $A$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 
                    
% fig = gcf;                    
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 4];
% print('A','-dpng','-r1000') 

%% B_max

z = [-0.517358432	-0.46890088	-0.472885906	-0.165476963;
        -0.416955986	-0.39669331	-0.322617443	-0.126122;
        -0.42585919	    -0.33645664	-0.40514636	    -0.167917305]*100;

rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);

z(:,4) = 0;

getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in B_{max} (%)', C)
                    
title('Increase in $B_{max}$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 
                    
% fig = gcf;                    
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 4];
% print('B_max','-dpng','-r1000')  
                    
%% B_onset

z  = [-0.473684211	-0.626666667	-0.610299003	-0.673913043
      -0.946930281	-0.910278965	-0.914911366	-0.676037302
      -0.921382955	-0.945808737	-0.784424235	-0.82467786]*100;

rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);
z(1,:) = 0;

getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in B_{onset} (%)', C)

title('Increase in $B_{initial}$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex')                     
                    
fig = gcf;                    
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 4.5 3];
print('B_onset','-dpng','-r1000')                               
                   
%% B_halfway

z  = [-0.471914348	-0.524772245	-0.393418377	-0.185601057
      -0.429239269	-0.35194106	    -0.338833883	-0.071392212
      -0.42915071	-0.236602497	-0.3770859	    -0.157003592]*100;
  
rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);
    

z(:,4) = 0;
z(2,2) = 0;

getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in B_{halfway} (%)', C)
                    
title('Increase in $B_{halfway}$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 

% fig = gcf;                    
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 4.5 4];
% print('B_halfway','-dpng','-r1000')     

%% T_halfway

z  = [1.484848485	1.349206349	1.058823529	0.411764706
      1.285714286	1.153846154	0.923076923	0.166666667
      1.5	        1.363636364	0.909090909	0.444444444]*100;

rz = roundsd(z(:), 2);
txt = sprintfc('%.0f%%', rz);

z(2,4) = 0;
getHeatmap(txt, z, X, Y, 'Electric Field (V/cm)', ...
                        'Ligand density (\mum^{-2})', ...
                        'Increase in T_{halfway} (%)', C)                   

title('Increase in $T_{1/2}$', 'fontsize',18, 'FontWeight','Normal', 'Interpreter', 'Latex') 

fig = gcf;                    
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 4.5 3];
print('T_halfway','-dpng','-r1000') 



