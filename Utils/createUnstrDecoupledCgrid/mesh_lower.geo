// ===========================================
// ==================================MESH FILE
// ===========================================

h = 0.0008;
H = 1;
R = 10;
D = 1;
BL = 0.3;
AoA = 0.3;
BL_size  = 0.00005;
BL_thickness = 0.01;
BL_ratio = 1.1;
bumpW = 7;
progW = 1.1;
numW = 200;

 // farfield
Point(208) = {R+0.5,  -D+BL, 0,1/5*H};
Point(209) = {1, -D+BL, 0,1/5*H};
Point(210) = {0, -D+BL, 0,1/5*H};
Point(211) = {0.5-R, -D+BL, 0,1/5*H};
Point(212) = {R+0.5,  -D, 0,1/5*H};
Point(213) = {0.5-R, -D, 0,1/5*H};

 // farfield
Line(8) = {208,211};
Line(9) = {209,210};
Line(10) = {210,211};
Line(12) = {212,213};
Line(13) = {208,212};
Line(14) = {213,211};
Transfinite Line{8 , 12} = numW Using Bump bumpW;
Transfinite Line{13} =  20 Using Progression 1/progW;
Transfinite Line{14} =  20 Using Progression progW;


// =====================================LOOPS

Line Loop(1) = {-8,13,12,14};


// =====================================SURFS

Plane Surface(1) = {1};
Transfinite Surface{1};
 Recombine Surface{1};
Physical Surface(1) = {1};
Physical Line("FARFIELD") = {14,13};
Physical Line("WALL") = {12};
Physical Line("LOWER_INTERFACE") = {8};


// 1: MeshAdapt, 2: Automatic, 3: Initial mesh only, 5: Delaunay, 6: Frontal-Delaunay, 7: BAMG, 8: Frontal-Delaunay for Quads, 9: Packing of Parallelograms
Mesh.Algorithm = 2;

//Mesh.RandomFactor = 1e-09;
