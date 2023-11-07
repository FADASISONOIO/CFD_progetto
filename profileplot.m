clc
clear
close all
alpha=deg2rad(-1);

pp=[0.0000 0.0000	0.0000 0.0000;
 0.0010	-0.0076 	0.0010 0.0079 ;
0.0020  -0.0107 	 0.0020  0.0109; 
0.0049  -0.0168 	 0.0051  0.0173 ;
 0.0099  -0.0228 	 0.0101 0.0232 ;
 0.0149  -0.0266	 0.0151  0.0271 ;
0.0199  -0.0294 	0.0201  0.0300;
 0.0249  -0.0320 	 0.0251 0.0313 ;
 0.0298  -0.0345 	 0.0301  0.0322 ;
 0.0348  -0.0369 	 0.0351  0.0330 ;
0.0398  -0.0393 	 0.0401  0.0338 ;
0.0448  -0.0416		0.0451  0.0346;
 0.0498  -0.0438 	 0.0501  0.0354; 
 0.0548  -0.0460 	0.0551  0.0361 ;
 0.0598  -0.0481 	 0.0601  0.0369 ;
 0.0698  -0.0520	 0.0701  0.0382 ;
 0.0797  -0.0557 	 0.0801  0.0395 ;
 0.0897  -0.0591	 0.0902 0.0407 ;
 0.0997 -0.0622	 	0.1002  0.0417 ;
 0.1197 -0.0676 	0.1202  0.0436 ;
 0.1396 -0.0718 	 0.1402  0.0451 ;
0.1596 -0.0750 	 	0.1602  0.0463 ;
 0.1796 -0.0769 	0.1802  0.0472 ;
 0.1996 -0.0778 	 0.2002 0.0480 ;
 0.2496 -0.0762 	 0.2501  0.0498 ;
0.2996  -0.0732 	 0.3001 0.0515 ;
 0.3496 -0.0692 	 0.3501  0.0527 ;
 0.3996  -0.0645 	0.4001 	0.0534 ;
0.4496  -0.0590 	 0.4501 0.0537 ;
 0.4996  -0.0526 	 0.5001 0.0535 ;
0.5497  -0.0454 	 0.5501 0.0529;
 0.5997  -0.0373 	 0.6001  0.0518; 
 0.6497 -0.0285 	0.6500 0.0503;
 0.6997  -0.0188 	 0.7000 0.0482; 
0.7498 -0.0083 	 	0.7500 0.0456;
 0.7998 0.0031 		 0.8000  0.0438;
 0.8498  0.0152 	 0.8500  0.0443 ;
 0.8999 0.0282 		0.9000 0.0479 ;
 0.9199  0.0336	 	0.9200 0.0502 ;
 0.9399  0.0392		 0.9400 0.0530;
 0.9599  0.0449 	 0.9600  0.0562; 
 0.9799  0.0507 	0.9800  0.0599 ;
 0.9900 0.0537 		0.9900 0.0619 ;
1.0000 0.0567 		1.0000 0.0640 ];
% rotpp conrìtiene i punti ad alpha=0°
rotpp=[pp(:,1)*cos(-alpha)+pp(:,2)*sin(-alpha), -pp(:,1)*sin(-alpha)+pp(:,2)*cos(alpha), pp(:,3)*cos(-alpha)+pp(:,4)*sin(-alpha), -pp(:,3)*sin(-alpha)+pp(:,4)*cos(alpha)];
figure(1)
hold on
p1ss=plot(pp(:,1), pp(:, 2), 'k');
p1ps=plot(pp(:,3), pp(:, 4), 'k');

p2ss=plot(rotpp(:,1), rotpp(:, 2), 'r');
p2ps=plot(rotpp(:,3), rotpp(:, 4), 'r');
axis equal
legend([p1ss, p2ss], {'points at alpha=1°', 'points at alpha=0°'})


rightpoints= [rotpp(end:-1:1, 3), rotpp(end:-1:1, 4); rotpp(2:end, 1), rotpp(2:end, 2)];

%traslazione
theta=-deg2rad(3.6);
trasl=[rightpoints(:,1)-0.5, rightpoints(:,2)];
final= [trasl(:,1)*cos(theta)+trasl(:,2)*sin(theta), -trasl(:,1)*sin(theta)+ trasl(:,2)*cos(theta)];
figure(2)
p1=plot(trasl(:,1), trasl(:,2), 'k');
hold on
p2=plot(final(:,1), final(:,2), 'r');
axis equal
legend('traslato', 'finale')

deltay= min(final(:,2));
h=0.224;
D= deltay+ h