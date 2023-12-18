clear all
close all
clc
%%mesh convergence vicino al suolo più giù !!!

%% mesh convergence, D=0.5, alpha=0

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
plot(1./hpp,CL,'o')
hold on
plot(1./hpp,CL,'-')
grid on
xlabel('1/h')
ylabel('CL')
title('CL vs h lontano')
    
figure(2)
plot(1./(hpp),error,'o')
hold on
plot(1./(hpp),error,'-')
grid on
xlabel('h')
ylabel('Errore relativo %')
title('Grid convergence lontano')


%% ERRATA SOTTO QUELLA GIUSTA
% mesh convergence, D=0.1, alpha=5, hrat=5
% 
% CL2 =  [0.836448, 0.838259, 0.843375, 0.843904, 0.843592];
% ncelle2 =  [125000, 250000, 500000, 750000, 1000000];
% hpp2 = [0.00275, 0.00135, 0.00075, 0.0006, 0.00055 ];
% 
% for i=1:length(CL2)
%     err2 = 100 * abs(CL2(i)-CL2(end))/CL2(end);
%     error2(i) = err2;
% end
% 
% 
% %% plot
% 
% figure(3)
% plot(1./hpp2,CL2,'o')
% hold on
% plot(1./hpp2,CL2,'-')
% grid on
% xlabel('h')
% ylabel('CL')
% title('CL vs h vicino')
% 
% figure(4)
% plot(1./hpp2(1:end),error2,'o')
% hold on
% plot(1./hpp2(1:end),error2,'-')
% grid on
% xlabel('h')
% ylabel('Errore relativo %')
% title('Grid convergence vicino')

%% GRID FINALE D=0.1 alpha=14

CL3 = [1.465877 1.486927 1.495889 1.494064];
ncelle = [280000 470000 700000 1000000];
hpp3 = [0.0015 0.001 0.00075 0.00063];

for i=1:length(CL3)
    err = 100 * abs(CL3(i)-CL3(end))/CL3(end);
    error3(i) = err;
end

figure(3)
plot(1./hpp3,error3,'o')
hold on
plot(1./hpp3,error3,'-')
grid on
xlabel('1/h')
ylabel('Errore relativo %')
title('Grid convergence')
