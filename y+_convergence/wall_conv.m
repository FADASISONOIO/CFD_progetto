clear all
close all
clc
%% mesh convergence

% CL =  [0.249567, 0.250064, 0.250753];
% yplus =  [0.5, 1, 1.5];
% hpp = [0.00001, 0.00002, 0.00003];

CL =  [0.249567, 0.250064, 0.250700];
yplus =  [0.5, 1, 2];
hpp = [0.00001, 0.00002, 0.00004];

for i=1:length(CL)
    err = 100 * abs(CL(i)-CL(1))/CL(1);
    error(i) = err;
end

%% plot

figure(1)
plot(yplus,CL,'o')
hold on
plot(yplus,CL,'-')
grid on
title('CL vs cells')

figure(2)
plot(yplus(1:end),error,'o')
hold on
plot(yplus(1:end),error,'-')
grid on
xlabel('Y+')
ylabel('Errore relativo %')
title('Grid convergence')

