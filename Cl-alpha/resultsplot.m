clc
clear
close all
%% DATI
angoli = 0:2:12;
CL05 = [0.180357,0.422957, 0.642117,  0.838272, 1.002929, 1.138259, 1.249169, 1.327091];
CL05bis = [0.180357,0.422957, 0.642117,  0.838272, 1.002929, 1.138259, 1.249169, 1.3]; % fare sim a 14gradi
CD05 = [0.015829,0.017967,0.025935,0.037280 , 0.055716,0.080900,  0.106670, 0.141680];

CL01bis =  [-0.147565, 0.316532, 0.699103, 0.995118,  1.194940, 1.337809, 1.391455, 1.443581, 1.484680, 1.514064];
CL01 =  [-0.147565, 0.316532, 0.699103, 0.995118,  1.194940, 1.337809, 1.443581, 1.514064];
CD01bis =  [0.019387, 0.018657, 0.025573, 0.038896, 0.057986, 0.083926, 0.099289, 0.118325, 0.135485, 0.159224];
CD01 =  [0.019387, 0.018657, 0.025573, 0.038896, 0.057986, 0.083926, 0.118325, 0.159224];
alpha01 =  [0, 2, 4, 6, 8, 10, 11, 12, 13, 14];

CL02 = [0.074707, 0.39846, 0.677395, 0.911483, 1.091044, 1.228414, 1.334621, 1.40902];
CD02 = [0.018915, 0.020449, 0.028777, 0.041943, 0.061724, 0.088583, 0.119294, 0.157222];
angoli2 = 0:2:14;

CL1 =  [0.193612, 0.412412, 0.619657, 0.802125, 0.966877, 1.110588, 1.216267, 1.305708];
CD1 =  [0.015841, 0.019242, 0.026000, 0.040299, 0.059269, 0.080843, 0.114448, 0.147260];

CLinf = [0.191757, 0.406343, 0.602691, 0.787853, 0.955122, 1.098695, 1.231557, 1.330825];% fare cl-alpha con simulazioni
CDinf = [0, 0, 0, 0, 0, 0, 0.116104, 0.152801];

altezze = [2, 1, 0.8, 0.5, 0.2, 0.1];
CL_D_0 = [0.191757, 0.193612, 0.189896, 0.180357, 0.074707, -0.147565];
CL_D_2 = [0.406343, 0.412412, 0.418207, 0.422957, 0.39846, 0.316532];
CL_D_4 = [0.602691, 0.619657, 0.621676, 0.642117, 0.677395, 0.699103];
CL_D_8 = [0.96, 0.966877, 0.985446, 1.002929, 1.091044, 1.194940];
%% PLOT
figure( "Name",'CL-ALPHA')
plot( angoli2, CL1, 'rd-', angoli2,CL05, 'kd-', angoli2,CL02, 'gd-', angoli2, CL01, 'bd-')
xlabel('$\alpha [^\circ]$', 'Interpreter','latex')
ylabel('$C_l$', 'Interpreter','latex')
grid on
legend('$h/c= 1$','$h/c= 0.5$','$h/c= 0.2$','$h/c= 0.1$', 'Interpreter', 'latex', 'Location','best' )

figure( "Name",'POLAR')
plot( CD1,CL1, 'rd-', CD05,CL05, 'kd-', CD02, CL02, 'gd-', CD01, CL01, 'bd-')
grid on
xlabel('$C_d$', 'Interpreter','latex')
ylabel('$C_l$', 'Interpreter','latex')
legend('$h/c= 1$','$h/c= 0.5$','$h/c= 0.2$','$h/c= 0.1$', 'Interpreter', 'latex' , 'Location','best')

figure( "Name",'CL-D')
plot( altezze, CL_D_0, 'rd-', altezze, CL_D_2, 'kd-', altezze, CL_D_4, 'gd-', altezze, CL_D_8, 'bd-')
xlabel('$D$', 'Interpreter','latex')
ylabel('$C_l$', 'Interpreter','latex')
grid on
legend('$\alpha = 0 ^\circ$', '$\alpha = 2 ^\circ$', '$\alpha = 4 ^\circ$', '$\alpha = 8 ^\circ$', 'Interpreter', 'latex', 'Location','best' )

%% MAPPA COLORATA

x = 0:2:14;
y = [0.1 0.2 0.5 1];
z = [CL01 - CLinf; CL02 - CLinf; CL05bis - CLinf; CL1 - CLinf];

% Xq = 0:0.01:14;
% Yq = 0.1:0.01:1;
% Vq = interp2(x,y,z,Xq,Yq);

[X, Y] = meshgrid(x, y);
F = griddedInterpolant(X', Y', z', 'linear');
zi = F(X, Y);

figure( "Name",'Mappa colorata')
contourf(X, Y, zi, 35,'linewidth', 0.05);
colorbar;
colormap('jet');
xlabel('$\alpha$', 'Interpreter','latex');
ylabel('$h/c$', 'Interpreter','latex');

%% GRID FINALE 

CL = [1.465877 1.486927 1.495889 1.494064];
ncelle = [280000 470000 700000 1000000];
hpp = [0.0015 0.001 0.00075 0.00063];

for i=1:length(CL)
    err = 100 * abs(CL(i)-CL(end))/CL(end);
    error(i) = err;
end

figure( "Name",'Ultima Grid Conv LO GIURO')
plot(1./hpp,error,'o')
hold on
plot(1./hpp,error,'-')
grid on
xlabel('1/h')
ylabel('Errore relativo %')
title('Grid convergence')