clc; clear;
dbstop if error

parameter_pairs = {{'Reactions.INTEGRIN_DENSITY',100/10^6},...
                   {'K.MEM',0.2},...
                   {'Reactions.k_E',40}};
         
               
rng(0) % Seed random variable
LSMmodel_v5_1(parameter_pairs,1)