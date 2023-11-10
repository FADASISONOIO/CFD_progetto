#include <fstream>
#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Helper{
private:
    int nPoints;
    double **coordinates;
    int LEid, UPid, LOid, blunt;
    bool isProfile;
public:
    string fileName;
    double LEspacing,TEspacing,wall_BL_size,hpp,H,R,D,BL,AoA,BL_size,BL_thickness,BL_ratio,progsWfwd,progsWaft,prognW,numWfwd,numWaft,nblW,hrat;

    Helper() : fileName(), LEspacing(1), TEspacing(1), nPoints(0), coordinates(nullptr) {};
    ~Helper() {

        for (int iPoint = 0; iPoint < nPoints; ++iPoint)
            delete [] coordinates[iPoint];
        delete [] coordinates;

    }

    void askForData() {

        cout << "Enter file name:\t ";
        cin >> fileName;
        cout << endl;

        string tmp;
        cout << "Enter case type (nozzle, profile):\t ";
        cin >> tmp;
        cout << endl;


        if (tmp == "nozzle") isProfile = false;
        else if (tmp == "profile") isProfile = true;
        else {
            cout << "\n\n[ERROR] case type must be nozzle or profile.\n\n";
            exit(EXIT_FAILURE);
        }



        cout << "Enter inlet/leading edge spacing:\t ";
        cin >> LEspacing;
        cout << endl;

        cout << "Enter outlet/trailing edge spacing:\t ";
        cin >> TEspacing;
        cout << endl;

/*
fileName = "C:/Bash/SU2/GIT_CFD/CFD_progetto/Utils/createGEO/txt_dat/main.dat";*/
LEspacing = 0.001;
TEspacing = 0.02;

    }

    void loadPoints() {

        fileName = "txt_dat/main.dat";
        isProfile = true;

        ifstream input(fileName);

        if (input.is_open()){

            input >> nPoints;

            coordinates = new double*[nPoints];
            for (int iPoint = 0; iPoint < nPoints; ++iPoint)
                coordinates[iPoint] = new double[2];

            for (int iPoint = 0; iPoint < nPoints; iPoint++)
                input  >> coordinates[iPoint][0] >> coordinates[iPoint][1];

            input.close();

        } else cout << "\n\n[ERROR] could not open file\n\n" << endl;
    }

    void findMarkers() {

        int id = -1;
        double val = 1e7;


        if (isProfile) {
            /** find LE as point with smallest x coordinate **/
            for (int iPoint = 0; iPoint < nPoints; ++iPoint) {
                if (coordinates[iPoint][0] < val) {
                    val = coordinates[iPoint][0];
                    id = iPoint;
                }
            }
            LEid = id;

            /** find UP **/
            double UPval = 0.5 * (coordinates[0][0] + coordinates[LEid][0]);
            val = 1e7;
            for (int iPoint = 0; iPoint < nPoints / 2; ++iPoint) {
                if (fabs(coordinates[iPoint][0] - UPval) < val) {
                    val = fabs(coordinates[iPoint][0] - UPval);
                    id = iPoint;
                }
            }
            UPid = id;

            /** find LO **/
            double LOval = 0.5 * (coordinates[0][0] + coordinates[LEid][0]);
            val = 1e7;
            for (int iPoint = int(nPoints / 2); iPoint < nPoints; ++iPoint) {
                if (fabs(coordinates[iPoint][0] - LOval) < val) {
                    val = fabs(coordinates[iPoint][0] - LOval);
                    id = iPoint;
                }
            }
            LOid = id;
        }
        else {
            /** find throat as point with smallest y coordinate **/
            for (int iPoint = 0; iPoint < nPoints; ++iPoint) {
                if (coordinates[iPoint][1] < val) {
                    val = coordinates[iPoint][1];
                    id = iPoint;
                }
            }
            LEid = id;
        }

    }

    inline double dist(const int& p1, const int& p2){
        double p21[2], dist2 = 0;
        p21[0] = coordinates[p1][0] - coordinates[p2][0];
        p21[1] = coordinates[p1][1] - coordinates[p2][1];

        for (double iDim : p21) {
            dist2 += pow(iDim,2);
        }

        return sqrt(dist2);
    }

    void printFile() {
        

                /*FARFIELD*/
        H = 1;

        R = 10;      /* Raggio C*/

                /*PROFILO*/     
        hpp = 0.0015;     /* h piccolo dim triangoli appena fuori bl profilo*/
        D = 1;      /* Distanza dal muro*/
        AoA = 0;  /* Angolo di attacco in deg*/
        BL_size  = 0.0000025;  /*Size prima cella BL*/
        BL_thickness = 0.01; /*Spessore BL profilo*/
        /*viene calcolato*/
        BL_ratio = 1 + (hpp - BL_size)/BL_thickness;  /*rapporto spessori BL profilo*/

                /* STRUTTURATA MURO*/
        hrat = 20; /* Rapporto tra h sul pezzo centrale del muro e h sul profilo*/
        BL = 0.08;   /* Spessore layer vicino al muro*/
        wall_BL_size = 0.0000025;   /*wall cell thickness*/
        progsWfwd = 1.09;  /*infittimento bounday muro in stramwise*/
        progsWaft = 1.001;  /*infittimento bounday muro in stramwise*/
        /* vengono calcolati*/
        prognW = 1 + (hpp*hrat - wall_BL_size)/BL;  /*n layer muro*/
        nblW = ceil(log(hpp*hrat/wall_BL_size)/(log(prognW)));  /*infittimento bounday muro in wall normal*/
        
        /*numW = ceil(log((hpp*hrat)/(R*(1-progsW)))/(log(progsW)));   /*n celle stramwise muro*//**/
        numWfwd = 0;
        double cm_stream = hpp*hrat; 
        while (cm_stream < R) {
            cm_stream = hpp*hrat + progsWfwd*cm_stream;
            numWfwd++;
        }
        numWaft = 0;
        cm_stream = hpp*hrat; 
        while (cm_stream < R) {
            cm_stream = hpp*hrat + progsWaft*cm_stream;
            numWaft++;
        }

        findMarkers();

        /** check blunt TE **/
        bool bluntTE = true;
        if (fabs(coordinates[0][1] - coordinates[nPoints-1][1]) < 1e-15)
            bluntTE = false;

        /** build curvilinear coordinate **/
        vector<double> s(nPoints,0);
        for (int iPoint = 1; iPoint < nPoints; ++iPoint) {
            s[iPoint] = s[iPoint-1] + dist(iPoint,iPoint-1);
        }

        /** build size field **/
        vector<double> h(nPoints,1);

        if (isProfile) {
            /** from TE to UP **/
            double m = (1 - TEspacing) / (s[UPid] - s[0]);
            for (int iPoint = 0; iPoint < UPid; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[0]) + TEspacing;
            }

            /** from UP to LE **/
            m = (LEspacing - 1) / (s[LEid] - s[UPid]);
            for (int iPoint = UPid + 1; iPoint <= LEid; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[UPid]) + 1;
            }

            /** from LE to LO **/
            m = (1 - LEspacing) / (s[LOid] - s[LEid]);
            for (int iPoint = LEid + 1; iPoint < LOid; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[LEid]) + LEspacing;
            }

            /** from LO to TE **/
            m = (TEspacing - 1) / (s[nPoints - 1] - s[LOid]);
            for (int iPoint = LOid + 1; iPoint < nPoints; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[LOid]) + 1;
            }
        } else {
            /** from start to throat **/
            double m = (1 - LEspacing) / (s[LEid] - s[0]);
            for (int iPoint = 0; iPoint < LEid; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[0]) + LEspacing;
            }

            /** from throat to end **/
            m = (TEspacing - 1) / (s[nPoints-1] - s[LEid]);
            for (int iPoint = LEid + 1; iPoint < nPoints; ++iPoint) {
                h[iPoint] = m * (s[iPoint] - s[LEid]) + 1;
            }
        }

        ofstream output("mesh.geo");

        if (output.is_open()){

            output << "// ===========================================\n";
            output << "// ==================================MESH FILE\n";
            output << "// ===========================================\n\n";

            if (isProfile) {
                output << "h = " << hpp << ";\n";
                /*FARFIELD*/
                output << "H = " << H << ";\n";
                output << "R = " << R << ";\n";      /* Raggio C*/
                /*PROFILO*/
                output << "D = " << D << ";\n";      /* Distanza dal muro*/
                output << "BL = " << BL << ";\n";   /* Spessore layer vicino al muro*/
                output << "AoA = " << AoA << ";\n";  /* Angolo di attacco in deg*/
                output << "BL_size  = " << BL_size << ";\n";  /*Size prima cella BL*/
                output << "BL_thickness = " << BL_thickness << ";\n"; /*Spessore BL profilo*/
                output << "BL_ratio = " << BL_ratio << ";\n";  /*rapporto spessori BL profilo*/
                /* STRUTTURATA MURO*/
                output << "progsWfwd = " << progsWfwd << ";\n";  /*infittimento bounday muro in stramwise*/
                output << "progsWaft = " << progsWaft << ";\n";  /*infittimento bounday muro in stramwise*/
                output << "prognW = " << prognW << ";\n";  /*infittimento bounday muro in wall normal*/
                output << "numWfwd = " << numWfwd << ";\n";  /*n celle stramwise muro*/
                output << "numWaft = " << numWaft << ";\n";  /*n celle stramwise muro*/
                output << "nblW = " << nblW << ";\n";  /*n layer muro*/
                output << "hrat = " << hrat << ";\n";  /* Rapporto tra h sul pezzo centrale del muro e h sul profilo*/
            }
            output << "// =====================================POINTS\n";

            for (int iPoint = 0; iPoint < nPoints; iPoint++) {
                /* Point(1) = {0.000000, 0.036000, 0.000000, 0.003600}; */
                output << "Point(" << iPoint+1 << ") = {" << coordinates[iPoint][0]
                       << ", " << coordinates[iPoint][1] << ", 0.0, " << h[iPoint] <<"*h};\n";
            }

            if (isProfile) {

                output << "\n // farfield\n";
                output << "Point(" << nPoints + 2 << ") = {0.5, 0, 0,H};\n";
                output << "Point(" << nPoints + 3 << ") = {R+0.5, 0, 0,1/10*H};\n";
                output << "Point(" << nPoints + 4 << ") = {0.5, R, 0,H};\n";
                output << "Point(" << nPoints + 5 << ") = {0.5-R, 0, 0,H};\n";
                output << "Point(" << nPoints + 6 << ") = {0, -R, 0,H};\n";
                output << "Point(" << nPoints + 7 << ") = {R+0.5,  -D+BL, 0,1/10*H};\n";
                output << "Point(" << nPoints + 8 << ") = {1, -D+BL, 0,1/5*H};\n";
                output << "Point(" << nPoints + 9 << ") = {0, -D+BL, 0,1/5*H};\n";
                output << "Point(" << nPoints + 10 << ") = {0.5-R, -D+BL, 0,H};\n";
                output << "Point(" << nPoints + 11 << ") = {R+0.5,  -D, 0,1/5*H};\n";    
                output << "Point(" << nPoints + 12 << ") = {0.5-R, -D, 0,1/5*H};\n";  
                output << "Point(" << nPoints + 13 << ") = {1, -D, 0,1/5*H};\n";
                output << "Point(" << nPoints + 14 << ") = {0, -D, 0,1/5*H};\n";         

                output << "\n\n// =====================================CURVES\n\n";

                output << "Spline(1) = {1:" << UPid + 1 << "};\n";
                output << "Spline(2) = {" << UPid + 1 << ":" << LEid + 1 << "};\n";
                /*output << "Spline(3) = {" << LEid + 1 << ":" << LOid + 1 << "};\n";
                if (bluntTE)
		    output << "Spline(4) = {" << LOid + 1 << ":" << nPoints << "};\n";
		else
		    output << "Spline(4) = {" << LOid + 1 << ":" << nPoints-1 << ", 1};\n";*/
                output << "Spline(3) = {" << LEid + 1 << ":" << nPoints-1 << ", 1};\n";

                if (bluntTE)
                    output << "Line(9) = {" << nPoints << ",1};\n";

                output << "\n // farfield\n";
                output << "Circle(5) = {" << nPoints + 3 << "," << nPoints + 2 << "," << nPoints + 4 << "};\n";
                output << "Circle(6) = {" << nPoints + 4 << "," << nPoints + 2 << "," << nPoints + 5 << "};\n";
                output << "Line(7) = {" << nPoints + 3 << "," << nPoints + 7 << "};\n";
                /*output << "Line(8) = {" << nPoints + 7 << "," << nPoints + 10 << "};\n";*/
                /*sopra strutturate*/
                output << "Line(8) = {" << nPoints + 7 << "," << nPoints + 8 << "};\n";
                output << "Line(9) = {" << nPoints + 8 << "," << nPoints + 9 << "};\n";
                output << "Line(10) = {" << nPoints + 9 << "," << nPoints + 10 << "};\n";

                /*verticali sopra strutturata*/
                output << "Line(11) = {" << nPoints + 10 << "," << nPoints + 5 << "};\n";
                /*output << "Line(12) = {" << nPoints + 11 << "," << nPoints + 12 << "};\n";*/
                /*Verticali strutturate*/
                output << "Line(13) = {" << nPoints + 7 << "," << nPoints + 11 << "};\n";
                output << "Line(14) = {" << nPoints + 12 << "," << nPoints + 10 << "};\n";

                /*sotto strutturate*/
                output << "Line(15) = {" << nPoints + 11 << "," << nPoints + 13 << "};\n";
                output << "Line(16) = {" << nPoints + 13 << "," << nPoints + 14 << "};\n";
                output << "Line(17) = {" << nPoints + 14 << "," << nPoints + 12 << "};\n";

                /*verticali dentro strutturata*/
                output << "Line(18) = {" << nPoints + 8 << "," << nPoints + 13 << "};\n";
                output << "Line(19) = {" << nPoints + 9 << "," << nPoints + 14 << "};\n";

                /*output << "Line(12) = {" << LEid +1 << "," << nPoints + 5 << "};\n"; */
                /*output << "Line(13) = {" << nPoints + 3 << ",1};\n";*/ 

                /* Transfinite lines for near wall definition */
                /*
                output << "Transfinite Line{" << 12 << " , " << 10 << " , " << 16 << "} = npW Using Progression progW;\n";
                output << "Transfinite Line{" << 13 << " , " << 8 << "} = npW Using Progression 1/progW;\n";

                output << "Transfinite Line{" << 7 << " , " << 14 << ", " << 15 << "} = npD Using Progression progD;\n";
                output << "Transfinite Line{" << 11 << "} = npD Using Progression 1/progD;\n";

                output << "Transfinite Line{" << 6 << "} = npS Using Progression 1/progS;\n";
                output << "Transfinite Line{" << 5 << "} = npS Using Progression progS;\n";
                output << "Transfinite Line{" << 2 << "} = npS Using Progression 1/progS;\n";
                output << "Transfinite Line{" << 1 << "} = npS Using Progression progS;\n";
                
                output << "Transfinite Line{" << 3 << "} = npP Using Bump bumpP;\n";
                output << "Transfinite Line{" << 9 << "} = npP Using Progression 1;\n";
                */
                output << "Transfinite Line{" << 9 << " , " << 16 << "} = 1/h/hrat Using Progression 1;\n";
                output << "Transfinite Line{" << 8 << " , " << 15 << "} = numWaft Using Progression 1/progsWaft;\n";
                output << "Transfinite Line{" << 10 << " , " << 17 << "} = numWfwd Using Progression progsWfwd;\n";
                output << "Transfinite Line{" << 13 << " , " << 18 << ", " << 19 << "} =  nblW Using Progression 1/prognW;\n";
                output << "Transfinite Line{" << 14 << "} =  nblW Using Progression prognW;\n";
                
                output << "\n\n// =====================================LOOPS\n\n";
                if (bluntTE)
                    output << "Line Loop(1) = {1,2,3,9};\n";
                else
                    output << "Line Loop(1) = {1,2,3};\n";

                output << "Line Loop(2) = {-11,-10,-9,-8,-7,5,6};\n";
                output << "Line Loop(3) = {-10,19,17,14};\n";
                output << "Line Loop(4) = {-9,18,16,-19};\n";
                output << "Line Loop(5) = {-8,13,15,-18};\n";

                output << "Rotate {{0, 0, -1}, {0.5, 0, 0}, Pi * AoA / 180} \n {Curve{2}; Curve{1}; Curve{3};}\n";



                output << "\n\n// =====================================SURFS\n\n";
                output << "Plane Surface(1) = {1,2};\n";
                
                output << "Plane Surface(2) = {3};\n";
                output << "Transfinite Surface{2};\n Recombine Surface{2};\n";
                output << "Plane Surface(3) = {4};\n";
                output << "Transfinite Surface{3};\n Recombine Surface{3};\n";
                output << "Plane Surface(4) = {5};\n";
                output << "Transfinite Surface{4};\n Recombine Surface{4};\n";
                // ==================================BOUNDARY LAYER
                output << "Field[1]=BoundaryLayer;\n";
                output << "Field[1].CurvesList={1,2,3};\n";
                output << "Field[1].Quads=1;\n";
                output << "Field[1].Ratio= BL_ratio;\n";
                output << "Field[1].Size=BL_size;\n";
                output << "Field[1].Thickness=BL_thickness;\n";
                //Field[1].PointsList={1};
                output << "Field[1].FanPointsList={1};\n";
                output << "Field[1].FanPointsSizesList={40};\n";
                output << "BoundaryLayer Field = 1;\n";

                output << "Physical Surface(1) = {1,2,3,4};\n";
                output << "Physical Line(\"FARFIELD\") = {14,11,6,5,7,13};\n";
                output << "Physical Line(\"WALL\") = {15,16,17};\n";
                if (bluntTE)
                    output << "Physical Line(\"AIRFOIL\") = {1,2,3,9};\n";
                else
                    output << "Physical Line(\"AIRFOIL\") = {1,2,3};\n";
            } else {

                output << "\n // symmetry\n";
                output << "Point(" << nPoints+2 << ") = {" << coordinates[0][0] << ", 0, 0, " << LEspacing << "*h};\n";
                output << "Point(" << nPoints+3 << ") = {" << coordinates[LEid][0] << ", 0, 0, " << 1 << "*h};\n";
                output << "Point(" << nPoints+4 << ") = {" << coordinates[nPoints-1][0] << ", 0, 0, " << TEspacing << "*h};\n";;


                output << "\n\n// =====================================CURVES\n\n";

                output << "Spline(1) = {1:" << LEid+1 << "};\n";
                output << "Spline(2) = {"<< LEid+1 << ":" << nPoints << "};\n";

                output << "Line(3) = {" << nPoints+2 << ", " << nPoints+3 << "};\n";
                output << "Line(4) = {" << nPoints+3 << ", " << nPoints+4 << "};\n";
                output << "Line(5) = {" << nPoints+2 << ", " << 1 << "};\n";
                output << "Line(6) = {" << nPoints+4 << ", " << nPoints << "};\n";

                output << "\n\n// =====================================LOOPS\n\n";

                output << "Line Loop(1) = {1, 2, -6, -3, -4, 5};\n";

                output << "\n\n// =====================================SURFS\n\n";
                output << "Plane Surface(1) = {1};\n\n";

                output << "Physical Surface(1) = {1};\n";
                output << "Physical Line(\"WALL\") = {1,2};\n";
                output << "Physical Line(\"INLET\") = {5};\n";
                output << "Physical Line(\"OUTLET\") = {6};\n";
                output << "Physical Line(\"SYMMETRY\") = {3,4};\n";


            }

            output << "\n\n// 1: MeshAdapt, 2: Automatic, 3: Initial mesh only, 5: Delaunay, 6: Frontal-Delaunay, "
                      "7: BAMG, 8: Frontal-Delaunay for Quads, 9: Packing of Parallelograms\n";
            output << "Mesh.Algorithm = 2;\n";
            output << "\n//Mesh.RandomFactor = 1e-09;\n";


            output.close();

        } else cout << "\n\n[ERROR] could not open output file\n\n" << endl;


    }


};

int main(){

    Helper help;
/*
    help.askForData();
*/
    help.loadPoints();

    help.printFile();

}
