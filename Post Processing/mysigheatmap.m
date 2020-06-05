clc; clear;
X = [0,15,150,1500];
Y = [200,500,1000];


Lstar = [1.43513167, 1.824058974, 0.781437111, 0.63350822;
         3.113729123,	1.865224599, 1.886878227,	0.598473115;
         2.648281805,	2.09830801,	2.187213386,	0.712716711]*100;

Psig = [0.0289	0.0153,	0.038,	0.005;
        0.0002,	0.0072,	0.0004,	0.04;
        0.0026,	0.0007,	0.0015,	0.0256];


getSigHeatmap(Lstar, Psig, X, Y, 'Electric field (V/cm)', ...
                                 'Ligand density (\mum^{-2})', ...
                                 'Increase in L* (%)',...
                                 1,...
                                 'YlGnBu')
fig = gcf;
fig.PaperUnits = 'inches' ;
fig.PaperPosition = [0 0 5 5];
print('Lstar_sig','-dpng','-r400')

%%
Rstar = [0.503003003,	1.174738841,	0.570454545,	0.51187905;
         1.365771812,	0.459657702,	0.871232877,	0.607675906;
         1.635245902,	0.982089552,	1.017751479,	0.337552743]*100;
     
Psig = [0.0406	0.0001	0.0217	0.0124;
        0.0001	0.0148	0.0024	0.0056;
        0.0031	0.0016	0.0001	0.0563];
    
getSigHeatmap(Rstar, Psig, X, Y, 'Electric field (V/cm)', ...
                                 'Ligand density (\mum^{-2})', ...
                                 'Increase in R* (%)',...
                                 1,...
                                 'YlGnBu')
    
fig = gcf;
fig.PaperUnits = 'inches' ;
fig.PaperPosition = [0 0 5 5];
print('Rstar_sig','-dpng','-r400')

%%
LRstar = [2.825243171	5.251906995	1.690491318	1.381723062;
        8.903632	3.358418113	4.265994562	1.360027178;
        8.710338897	5.111739763	5.519612883	1.383460817]*100;
     
Psig = [0.0384	0.0057	0.0227	0.004;
        0.0007	0.0243	0.0015	0.013;
        0.0112	0.0009	0.0015	0.0295];
    
getSigHeatmap(LRstar, Psig, X, Y, 'Electric field (V/cm)', ...
                                 'Ligand density (\mum^{-2})', ...
                                 'Increase in L*R* (%)',...
                                 1,...
                                 'YlOrRd')

fig = gcf;
fig.PaperUnits = 'inches' ;
fig.PaperPosition = [0 0 5 5];
print('LRstar_sig','-dpng','-r400')

%%
Area = [1.988367018	3.594003517	1.130955649	0.990783788;
        9.655928732	2.594916703	4.69114076	0.752131517;
        8.761407593	5.641578308	5.926897359	1.187984138]*100;
     
Psig = [0.0412	0.0077	0.0477	0.0023;
        0.0001	0.0184	0.0004	0.0392;
        0.003	0.0013	0.0006	0.0204];
    
getSigHeatmap(Area, Psig, X, Y, 'Electric field (V/cm)', ...
                                 'Ligand density (\mum^{-2})', ...
                                 'Increase in Area (%)',...
                                 1,...
                                 'YlOrRd')

fig = gcf;
fig.PaperUnits = 'inches' ;
fig.PaperPosition = [0 0 5 5];
print('Area_sig','-dpng','-r400')                             