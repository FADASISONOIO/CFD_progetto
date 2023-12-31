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
    double LEspacing,TEspacing;

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
LEspacing = 0.01;
TEspacing = 0.2;

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
            output << "h = 0.0005;\n";
            if (isProfile) {
                output << "H = 1;\n";
                output << "R = 10;\n";
                output << "D = 1;\n";
                output << "npW = 100;\n";
                output << "npS = 100;\n";
                output << "npP = 150;\n";
                output << "npD = 100;\n";
                output << "progW = 1.1;\n";
                output << "progS = 1.05;\n";
                output << "progP = 1;\n";
                output << "progD = 1.1;\n";
                output << "bumpP = 0.1;\n";
            }
            output << "// =====================================POINTS\n";

            for (int iPoint = 0; iPoint < nPoints; iPoint++) {
                /* Point(1) = {0.000000, 0.036000, 0.000000, 0.003600}; */
                output << "Point(" << iPoint+1 << ") = {" << coordinates[iPoint][0]
                       << ", " << coordinates[iPoint][1] << ", 0.0, " << h[iPoint] <<"*h};\n";
            }

            if (isProfile) {

                output << "\n // farfield\n";
                output << "Point(" << nPoints + 2 << ") = {0.5, 0, 0};\n";
                output << "Point(" << nPoints + 3 << ") = {R+0.5, 0, 0};\n";
                output << "Point(" << nPoints + 4 << ") = {0.5, R, 0};\n";
                output << "Point(" << nPoints + 5 << ") = {0.5-R, 0, 0};\n";
                output << "Point(" << nPoints + 6 << ") = {0, -R, 0};\n";
                output << "Point(" << nPoints + 7 << ") = {R+0.5,  -D, 0};\n";
                output << "Point(" << nPoints + 8 << ") = {1, -D, 0};\n";
                output << "Point(" << nPoints + 9 << ") = {0, -D, 0};\n";
                output << "Point(" << nPoints + 10 << ") = {0.5-R, -D, 0};\n";

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
                output << "Line(8) = {" << nPoints + 7 << "," << nPoints + 8 << "};\n";
                output << "Line(9) = {" << nPoints + 8 << "," << nPoints + 9 << "};\n";
                output << "Line(10) = {" << nPoints + 9 << "," << nPoints + 10 << "};\n";
                output << "Line(11) = {" << nPoints + 10 << "," << nPoints + 5 << "};\n";
                output << "Line(12) = {" << LEid +1 << "," << nPoints + 5 << "};\n";
                output << "Line(13) = {" << nPoints + 3 << ",1};\n";
                output << "Line(14) = {" << LEid +1 << "," << nPoints + 9 << "};\n";
                output << "Line(15) = {1," << nPoints + 8 << "};\n";
                output << "Line(16) = {" << UPid + 1<< "," << nPoints + 4 << "};\n";

                /* Transfinite lines for near wall definition */
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
                
                
                
                output << "\n\n// =====================================LOOPS\n\n";
                if (bluntTE)
                    output << "Line Loop(1) = {1,2,3,9};\n";
                else
                    output << "Line Loop(1) = {13,15,-8,-7};\n";

                output << "Line Loop(2) = {3,15,9,-14};\n";
                output << "Line Loop(3) = {10,11,-12,14};\n";
                output << "Line Loop(4) = {1,16,-5,13};\n";
                output << "Line Loop(5) = {2,12,-6,-16};\n";

                output << "\n\n// =====================================SURFS\n\n";
                output << "Plane Surface(1) = {1};\n";
                output << "Transfinite Surface{1};\n Recombine Surface{1};\n";
                output << "Plane Surface(2) = {2};\n";
                output << "Transfinite Surface{2};\n Recombine Surface{2};\n";
                output << "Plane Surface(3) = {3};\n";
                output << "Transfinite Surface{3};\n Recombine Surface{3};\n";
                output << "Plane Surface(4) = {4};\n";
                output << "Transfinite Surface{4};\n Recombine Surface{4};\n";
                output << "Plane Surface(5) = {5};\n";
                output << "Transfinite Surface{5};\n Recombine Surface{5};\n";

                output << "Physical Surface(1) = {1,2,3,4,5};\n";
                output << "Physical Line(\"FARFIELD\") = {11,6,5,7};\n";
                output << "Physical Line(\"WALL\") = {8,9,10};\n";
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
            output << "Mesh.Algorithm = 1;\n";
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
