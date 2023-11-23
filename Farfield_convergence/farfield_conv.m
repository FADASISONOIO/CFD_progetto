clear all
close all
clc
%% farfield convergence

CL =  [0.249565, 0.251434, 0.252643, 0.253344, 0.253270];
ncorde =  [30, 45, 60, 75, 80];
%hpp = [0.024, 0.012, 0.003, 0.0015, 0.00075, 0.0005625, 0.00045, 0.000375, 0.0003];

% % tre punti
% CL =  [0.214813, 0.252021, 0.248541, 0.245088];
% ncelle =  [18000, 100000, 500000, 1500000];
% hpp = [0.024, 0.003, 0.00075, 0.000375];

for i=1:length(CL)
    err = 100 * abs(CL(i)-CL(end))/CL(end);
    error(i) = err;
end

%% plot

figure(1)
plot(ncorde,CL,'o')
hold on
plot(ncorde,CL,'-')
grid on
title('CL vs cells')

figure(2)
plot(ncorde(1:end),error,'o')
hold on
plot(ncorde(1:end),error,'-')
grid on
xlabel('Dimensione del raggio della circonferenza che definisce il farfield')
ylabel('Errore relativo %')
title('Farfield convergence')

