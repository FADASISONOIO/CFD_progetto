clear all
close all
clc
%% mesh convergence

% tutti i dati
% CL =  [0.214813, 0.230820, 0.244805, 0.252021, 0.249567,  0.248541, 0.247223, 0.246119, 0.245088, 0.245010];
% ncelle =  [18000, 30000, 50000, 100000, 220000, 500000, 800000, 1100000, 1500000, 2000000];
% hpp = [0.024, 0.012, 0.006, 0.003, 0.0015, 0.00075, 0.0005625, 0.00045, 0.000375, 0.0003];

% eliminato il dato strano
CL =  [0.214813, 0.230820, 0.252021, 0.249567,  0.248541, 0.247223, 0.246119, 0.245088, 0.245010];
ncelle =  [18000, 30000, 100000, 220000, 500000, 800000, 1100000, 1500000, 2000000];
hpp = [0.024, 0.012, 0.003, 0.0015, 0.00075, 0.0005625, 0.00045, 0.000375, 0.0003];

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
plot(ncelle,CL,'o')
hold on
plot(ncelle,CL,'-')
grid on
title('CL vs cells')

figure(2)
plot(ncelle(1:end),error,'o')
hold on
plot(ncelle(1:end),error,'-')
grid on
xlabel('Numero di celle')
ylabel('Errore relativo %')
title('Grid convergence')

