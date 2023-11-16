// ===========================================
// ==================================MESH FILE
// ===========================================

h = 0.0025;
H = 1;
R = 10;
D = 0.5;
BL = 0.08;
AoA = 10;
BL_size  = 1e-05;
BL_thickness = 0.03;
BL_ratio = 1.083;
progsWfwd = 1.09;
progsWaft = 1.001;
prognW = 1.3;
numWfwd = 41;
numWaft = 336;
nblW = 13;
hrat = 10;
// =====================================POINTS
Point(1) = {1, 0, 0.0, 0.8*h};
Point(2) = {0.994046, 0.00127452, 0.0, 0.802431*h};
Point(3) = {0.985294, 0.00306708, 0.0, 0.805997*h};
Point(4) = {0.975054, 0.00507135, 0.0, 0.810163*h};
Point(5) = {0.964257, 0.00709196, 0.0, 0.814548*h};
Point(6) = {0.953226, 0.00906902, 0.0, 0.819022*h};
Point(7) = {0.942125, 0.0109783, 0.0, 0.823518*h};
Point(8) = {0.930989, 0.0128207, 0.0, 0.828024*h};
Point(9) = {0.919832, 0.0146003, 0.0, 0.832535*h};
Point(10) = {0.908657, 0.0163233, 0.0, 0.837049*h};
Point(11) = {0.897467, 0.0179955, 0.0, 0.841565*h};
Point(12) = {0.886262, 0.0196231, 0.0, 0.846086*h};
Point(13) = {0.875043, 0.0212119, 0.0, 0.850609*h};
Point(14) = {0.863811, 0.0227674, 0.0, 0.855136*h};
Point(15) = {0.852566, 0.024295, 0.0, 0.859666*h};
Point(16) = {0.841309, 0.0257994, 0.0, 0.8642*h};
Point(17) = {0.830041, 0.027285, 0.0, 0.868737*h};
Point(18) = {0.818762, 0.0287556, 0.0, 0.873278*h};
Point(19) = {0.807472, 0.0302146, 0.0, 0.877823*h};
Point(20) = {0.796171, 0.0316647, 0.0, 0.882371*h};
Point(21) = {0.784861, 0.0331078, 0.0, 0.886923*h};
Point(22) = {0.773542, 0.0345456, 0.0, 0.891478*h};
Point(23) = {0.762213, 0.0359789, 0.0, 0.896036*h};
Point(24) = {0.750875, 0.0374083, 0.0, 0.900598*h};
Point(25) = {0.739529, 0.0388339, 0.0, 0.905163*h};
Point(26) = {0.728175, 0.0402554, 0.0, 0.909732*h};
Point(27) = {0.716813, 0.0416723, 0.0, 0.914302*h};
Point(28) = {0.705451, 0.043083, 0.0, 0.918873*h};
Point(29) = {0.694101, 0.0444821, 0.0, 0.923439*h};
Point(30) = {0.682765, 0.0458622, 0.0, 0.927997*h};
Point(31) = {0.671445, 0.0472166, 0.0, 0.932549*h};
Point(32) = {0.66014, 0.048539, 0.0, 0.937092*h};
Point(33) = {0.648851, 0.0498235, 0.0, 0.941628*h};
Point(34) = {0.637575, 0.0510645, 0.0, 0.946157*h};
Point(35) = {0.626313, 0.0522572, 0.0, 0.950678*h};
Point(36) = {0.615064, 0.0533972, 0.0, 0.955192*h};
Point(37) = {0.603827, 0.0544807, 0.0, 0.959698*h};
Point(38) = {0.592602, 0.0555047, 0.0, 0.964198*h};
Point(39) = {0.581387, 0.0564665, 0.0, 0.968692*h};
Point(40) = {0.570182, 0.0573642, 0.0, 0.973179*h};
Point(41) = {0.558987, 0.0581965, 0.0, 0.977661*h};
Point(42) = {0.547799, 0.0589625, 0.0, 0.982138*h};
Point(43) = {0.536619, 0.0596616, 0.0, 0.986609*h};
Point(44) = {0.525447, 0.0602938, 0.0, 0.991077*h};
Point(45) = {0.51428, 0.0608594, 0.0, 0.99554*h};
Point(46) = {0.50312, 0.0613588, 0.0, 1*h};
Point(47) = {0.491965, 0.0617926, 0.0, 0.982645*h};
Point(48) = {0.480814, 0.0621615, 0.0, 0.965301*h};
Point(49) = {0.469668, 0.062466, 0.0, 0.947967*h};
Point(50) = {0.458525, 0.0627068, 0.0, 0.930641*h};
Point(51) = {0.447386, 0.0628843, 0.0, 0.913323*h};
Point(52) = {0.43625, 0.0629986, 0.0, 0.896009*h};
Point(53) = {0.425113, 0.0630498, 0.0, 0.878696*h};
Point(54) = {0.413966, 0.0630393, 0.0, 0.861367*h};
Point(55) = {0.402804, 0.0629709, 0.0, 0.844015*h};
Point(56) = {0.39163, 0.0628477, 0.0, 0.826642*h};
Point(57) = {0.380444, 0.0626722, 0.0, 0.809251*h};
Point(58) = {0.369249, 0.0624456, 0.0, 0.791844*h};
Point(59) = {0.358046, 0.0621684, 0.0, 0.774424*h};
Point(60) = {0.346838, 0.0618406, 0.0, 0.756992*h};
Point(61) = {0.335626, 0.0614614, 0.0, 0.739552*h};
Point(62) = {0.324411, 0.0610294, 0.0, 0.722105*h};
Point(63) = {0.313196, 0.060543, 0.0, 0.704653*h};
Point(64) = {0.30198, 0.0600002, 0.0, 0.687197*h};
Point(65) = {0.290766, 0.0593989, 0.0, 0.669739*h};
Point(66) = {0.279555, 0.0587369, 0.0, 0.65228*h};
Point(67) = {0.268348, 0.0580119, 0.0, 0.634822*h};
Point(68) = {0.257147, 0.057222, 0.0, 0.617366*h};
Point(69) = {0.245954, 0.0563651, 0.0, 0.599914*h};
Point(70) = {0.234769, 0.0554397, 0.0, 0.582467*h};
Point(71) = {0.223594, 0.0544441, 0.0, 0.565026*h};
Point(72) = {0.212432, 0.0533772, 0.0, 0.547595*h};
Point(73) = {0.201284, 0.0522377, 0.0, 0.530174*h};
Point(74) = {0.190153, 0.0510243, 0.0, 0.512768*h};
Point(75) = {0.179042, 0.0497359, 0.0, 0.495378*h};
Point(76) = {0.167953, 0.0483708, 0.0, 0.47801*h};
Point(77) = {0.156891, 0.046927, 0.0, 0.460668*h};
Point(78) = {0.145861, 0.0454016, 0.0, 0.443358*h};
Point(79) = {0.13487, 0.0437913, 0.0, 0.426088*h};
Point(80) = {0.123925, 0.0420911, 0.0, 0.408869*h};
Point(81) = {0.113037, 0.0402945, 0.0, 0.391715*h};
Point(82) = {0.10222, 0.0383933, 0.0, 0.374641*h};
Point(83) = {0.0914892, 0.0363774, 0.0, 0.357668*h};
Point(84) = {0.0808693, 0.0342353, 0.0, 0.340826*h};
Point(85) = {0.0703944, 0.031954, 0.0, 0.32416*h};
Point(86) = {0.0601187, 0.0295205, 0.0, 0.307744*h};
Point(87) = {0.0501343, 0.0269263, 0.0, 0.291707*h};
Point(88) = {0.0406062, 0.0241803, 0.0, 0.276292*h};
Point(89) = {0.0318205, 0.021335, 0.0, 0.261935*h};
Point(90) = {0.0241704, 0.0185141, 0.0, 0.24926*h};
Point(91) = {0.0179609, 0.0158793, 0.0, 0.238774*h};
Point(92) = {0.0131837, 0.0135315, 0.0, 0.230499*h};
Point(93) = {0.0095798, 0.0114718, 0.0, 0.224046*h};
Point(94) = {0.00684531, 0.00964432, 0.0, 0.218933*h};
Point(95) = {0.00474832, 0.00798839, 0.0, 0.214779*h};
Point(96) = {0.00313141, 0.00645095, 0.0, 0.211311*h};
Point(97) = {0.00189864, 0.00499461, 0.0, 0.208345*h};
Point(98) = {0.000996541, 0.00359588, 0.0, 0.205757*h};
Point(99) = {0.000390087, 0.00223329, 0.0, 0.203439*h};
Point(100) = {6.5639e-05, 0.000934113, 0.0, 0.201357*h};
Point(101) = {3.22188e-07, 6.37641e-05, 0.0, 0.2*h};
Point(102) = {1.20408e-05, -0.000261051, 0.0, 0.200517*h};
Point(103) = {0.000242843, -0.00139327, 0.0, 0.202357*h};
Point(104) = {0.000810233, -0.00256025, 0.0, 0.204422*h};
Point(105) = {0.00171487, -0.0037182, 0.0, 0.206761*h};
Point(106) = {0.00294536, -0.00486798, 0.0, 0.209442*h};
Point(107) = {0.00454171, -0.00603775, 0.0, 0.212593*h};
Point(108) = {0.0065755, -0.00725389, 0.0, 0.216365*h};
Point(109) = {0.00917929, -0.0085555, 0.0, 0.220998*h};
Point(110) = {0.0125645, -0.00998872, 0.0, 0.22685*h};
Point(111) = {0.0170331, -0.0116009, 0.0, 0.234412*h};
Point(112) = {0.0229225, -0.0134166, 0.0, 0.244223*h};
Point(113) = {0.0303893, -0.0153913, 0.0, 0.256517*h};
Point(114) = {0.0392102, -0.0174102, 0.0, 0.270922*h};
Point(115) = {0.0489336, -0.0193614, 0.0, 0.286708*h};
Point(116) = {0.0591834, -0.0211907, 0.0, 0.303282*h};
Point(117) = {0.069742, -0.0228877, 0.0, 0.320305*h};
Point(118) = {0.0804961, -0.0244595, 0.0, 0.337606*h};
Point(119) = {0.0913841, -0.0259178, 0.0, 0.355093*h};
Point(120) = {0.10237, -0.0272737, 0.0, 0.372713*h};
Point(121) = {0.11343, -0.0285372, 0.0, 0.390433*h};
Point(122) = {0.124548, -0.0297169, 0.0, 0.408231*h};
Point(123) = {0.135713, -0.03082, 0.0, 0.42609*h};
Point(124) = {0.146916, -0.0318527, 0.0, 0.443999*h};
Point(125) = {0.15815, -0.0328204, 0.0, 0.461947*h};
Point(126) = {0.169404, -0.0337272, 0.0, 0.479921*h};
Point(127) = {0.180672, -0.0345746, 0.0, 0.497908*h};
Point(128) = {0.191948, -0.0353637, 0.0, 0.515902*h};
Point(129) = {0.203232, -0.0360952, 0.0, 0.533902*h};
Point(130) = {0.214522, -0.03677, 0.0, 0.551905*h};
Point(131) = {0.225817, -0.0373887, 0.0, 0.569911*h};
Point(132) = {0.237115, -0.037952, 0.0, 0.587919*h};
Point(133) = {0.248416, -0.0384603, 0.0, 0.605926*h};
Point(134) = {0.259719, -0.0389139, 0.0, 0.623933*h};
Point(135) = {0.271023, -0.0393132, 0.0, 0.641939*h};
Point(136) = {0.282327, -0.0396584, 0.0, 0.659941*h};
Point(137) = {0.293631, -0.0399496, 0.0, 0.67794*h};
Point(138) = {0.304932, -0.0401869, 0.0, 0.695935*h};
Point(139) = {0.316232, -0.0403703, 0.0, 0.713924*h};
Point(140) = {0.327528, -0.0404998, 0.0, 0.731907*h};
Point(141) = {0.33882, -0.0405751, 0.0, 0.749882*h};
Point(142) = {0.350107, -0.0405961, 0.0, 0.767849*h};
Point(143) = {0.361387, -0.0405624, 0.0, 0.785806*h};
Point(144) = {0.372661, -0.0404735, 0.0, 0.803752*h};
Point(145) = {0.383925, -0.0403287, 0.0, 0.821684*h};
Point(146) = {0.39518, -0.0401273, 0.0, 0.839603*h};
Point(147) = {0.406423, -0.0398681, 0.0, 0.857505*h};
Point(148) = {0.417654, -0.0395499, 0.0, 0.87539*h};
Point(149) = {0.42887, -0.039171, 0.0, 0.893253*h};
Point(150) = {0.440069, -0.0387295, 0.0, 0.911094*h};
Point(151) = {0.451249, -0.0382231, 0.0, 0.92891*h};
Point(152) = {0.462409, -0.0376488, 0.0, 0.946699*h};
Point(153) = {0.473551, -0.0370033, 0.0, 0.964464*h};
Point(154) = {0.484687, -0.0362842, 0.0, 0.982227*h};
Point(155) = {0.495824, -0.0354936, 0.0, 1*h};
Point(156) = {0.506963, -0.0346343, 0.0, 0.995588*h};
Point(157) = {0.518105, -0.0337089, 0.0, 0.991173*h};
Point(158) = {0.529251, -0.0327203, 0.0, 0.986754*h};
Point(159) = {0.540401, -0.0316712, 0.0, 0.982331*h};
Point(160) = {0.551555, -0.0305644, 0.0, 0.977905*h};
Point(161) = {0.562714, -0.0294029, 0.0, 0.973474*h};
Point(162) = {0.573879, -0.0281895, 0.0, 0.969039*h};
Point(163) = {0.585051, -0.0269274, 0.0, 0.964599*h};
Point(164) = {0.596231, -0.0256196, 0.0, 0.960154*h};
Point(165) = {0.607421, -0.0242694, 0.0, 0.955703*h};
Point(166) = {0.618622, -0.0228802, 0.0, 0.951246*h};
Point(167) = {0.629836, -0.0214557, 0.0, 0.946781*h};
Point(168) = {0.641066, -0.02, 0.0, 0.94231*h};
Point(169) = {0.652314, -0.0185172, 0.0, 0.937829*h};
Point(170) = {0.663583, -0.0170121, 0.0, 0.93334*h};
Point(171) = {0.674876, -0.0154898, 0.0, 0.92884*h};
Point(172) = {0.686195, -0.0139564, 0.0, 0.924329*h};
Point(173) = {0.69754, -0.0124188, 0.0, 0.919808*h};
Point(174) = {0.708895, -0.0108871, 0.0, 0.915283*h};
Point(175) = {0.720227, -0.00937442, 0.0, 0.910768*h};
Point(176) = {0.73152, -0.00789245, 0.0, 0.90627*h};
Point(177) = {0.742766, -0.00645248, 0.0, 0.901793*h};
Point(178) = {0.753959, -0.00506806, 0.0, 0.897339*h};
Point(179) = {0.765097, -0.00375366, 0.0, 0.89291*h};
Point(180) = {0.776185, -0.00252268, 0.0, 0.888504*h};
Point(181) = {0.78723, -0.00138699, 0.0, 0.884119*h};
Point(182) = {0.798241, -0.000356559, 0.0, 0.879752*h};
Point(183) = {0.809227, 0.000560915, 0.0, 0.875399*h};
Point(184) = {0.820198, 0.00136008, 0.0, 0.871055*h};
Point(185) = {0.831164, 0.00203794, 0.0, 0.866716*h};
Point(186) = {0.842134, 0.00259364, 0.0, 0.862378*h};
Point(187) = {0.853115, 0.00302833, 0.0, 0.858038*h};
Point(188) = {0.864114, 0.00334479, 0.0, 0.853693*h};
Point(189) = {0.875133, 0.0035472, 0.0, 0.849341*h};
Point(190) = {0.886177, 0.00364081, 0.0, 0.844979*h};
Point(191) = {0.897246, 0.00363168, 0.0, 0.840608*h};
Point(192) = {0.908343, 0.00352647, 0.0, 0.836226*h};
Point(193) = {0.919464, 0.0033322, 0.0, 0.831833*h};
Point(194) = {0.930611, 0.00305615, 0.0, 0.82743*h};
Point(195) = {0.941774, 0.00270595, 0.0, 0.823019*h};
Point(196) = {0.952945, 0.00228947, 0.0, 0.818604*h};
Point(197) = {0.964056, 0.0018176, 0.0, 0.814213*h};
Point(198) = {0.974963, 0.00130593, 0.0, 0.809901*h};
Point(199) = {0.985314, 0.00078368, 0.0, 0.805808*h};
Point(200) = {0.993991, 0.000324963, 0.0, 0.802377*h};
Point(201) = {1, 0, 0.0, 0.8*h};

 // farfield
Point(203) = {0.5, 0, 0,H};
Point(204) = {R+0.5, 0, 0,1/10*H};
Point(205) = {0.5, R, 0,H};
Point(206) = {0.5-R, 0, 0,H};
Point(207) = {0, -R, 0,H};
Point(208) = {R+0.5,  -D+BL, 0,1/10*H};
Point(209) = {1, -D+BL, 0,1/5*H};
Point(210) = {0, -D+BL, 0,1/5*H};
Point(211) = {0.5-R, -D+BL, 0,H};
Point(212) = {R+0.5,  -D, 0,1/5*H};
Point(213) = {0.5-R, -D, 0,1/5*H};
Point(214) = {1, -D, 0,1/5*H};
Point(215) = {0, -D, 0,1/5*H};
Point(216) = {1.2, -0.130171, 0,2*h};
Point(217) = {1.4, -0.130171, 0,3*h};


// =====================================CURVES

Spline(1) = {1:46};
Spline(2) = {46:101};
Spline(3) = {1 :200, 1};

 // farfield
Circle(5) = {204,203,205};
Circle(6) = {205,203,206};
Line(7) = {204,208};
Line(8) = {208,209};
Line(9) = {209,210};
Line(10) = {210,211};
Line(11) = {211,206};
Line(13) = {208,212};
Line(14) = {213,211};
Line(15) = {212,214};
Line(16) = {214,215};
Line(17) = {215,213};
Line(18) = {209,214};
Line(19) = {210,215};
Transfinite Line{9 , 16} = 1/h/hrat Using Progression 1;
Transfinite Line{8 , 15} = numWaft Using Progression 1/progsWaft;
Transfinite Line{10 , 17} = numWfwd Using Progression progsWfwd;
Transfinite Line{13 , 18, 19} =  nblW Using Progression 1/prognW;
Transfinite Line{14} =  nblW Using Progression prognW;


// =====================================LOOPS

Line Loop(1) = {3};
Line Loop(2) = {-11,-10,-9,-8,-7,5,6};
Line Loop(3) = {-10,19,17,14};
Line Loop(4) = {-9,18,16,-19};
Line Loop(5) = {-8,13,15,-18};
Rotate {{0, 0, -1}, {0.25, 0, 0}, Pi * AoA / 180} 
 {Curve{3};}


// =====================================SURFS

Plane Surface(1) = {1,2};
Plane Surface(2) = {3};
Transfinite Surface{2};
 Recombine Surface{2};
Plane Surface(3) = {4};
Transfinite Surface{3};
 Recombine Surface{3};
Plane Surface(4) = {5};
Transfinite Surface{4};
 Recombine Surface{4};
Point{216} In Surface{1};
Point{217} In Surface{1};
Field[1]=BoundaryLayer;
Field[1].CurvesList={3};
Field[1].Quads=1;
Field[1].Ratio= BL_ratio;
Field[1].Size=BL_size;
Field[1].Thickness=BL_thickness;
Field[1].FanPointsList={1};
Field[1].FanPointsSizesList={40};
BoundaryLayer Field = 1;
Physical Surface(1) = {1,2,3,4};
Physical Line("FARFIELD") = {14,11,6,5,7,13};
Physical Line("WALL") = {15,16,17};
Physical Line("AIRFOIL") = {3};


// 1: MeshAdapt, 2: Automatic, 3: Initial mesh only, 5: Delaunay, 6: Frontal-Delaunay, 7: BAMG, 8: Frontal-Delaunay for Quads, 9: Packing of Parallelograms
Mesh.Algorithm = 2;

//Mesh.RandomFactor = 1e-09;
