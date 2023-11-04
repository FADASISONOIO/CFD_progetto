%% GRID CONVERGENCE
clc
clear
close all
%% DATI
CL = [-0.006722328615, -0.007396214012, -0.007706408986];
elementi = [50e3, 100e3, 250e3]';
%% FIGURE
figure(1)
plot(elementi,CL,'-') 
xlabel('elementi')
ylabel('Cl')
legend('data', 'Location', 'Best')