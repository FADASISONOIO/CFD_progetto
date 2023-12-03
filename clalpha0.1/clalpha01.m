clear all
close all
clc


CL =  [-0.147415, 0.317107, 0.700351, 0.996172,  1.195895, 1.338029, 1.391967, 1.443815, 1.486585];
CD =  [0.019045, 0.018444, 0.025394, 0.038792, 0.057867, 0.083637, 0.098987, 0.117870, 0.135338];
alpha =  [0, 2, 4, 6, 8, 10, 11, 12, 13];

figure(1)
plot(alpha,CL,'o')
hold on
plot(alpha,CL,'-')
grid on
title('CL vs alpha')

figure(2)
plot(alpha,CD,'o')
hold on
plot(alpha,CD,'-')
grid on
title('CD vs alpha')

figure(3)
plot(CD,CL,'o')
hold on
plot(CD,CL,'-')
grid on
title('polare')

