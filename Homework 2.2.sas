/**Homework 2: Written by Arielle Thibeault**/

OPTIONS PS = 60 LS = 80 NODATE NONUMBER;
DATA parks;
INFILE 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 2\parks.dat';
INPUT size visitors;
RUN;

/*QQ plot relating the squared Mahalanobis distances to the Chi-Square quantiles*/
PROC PRINCOMP std out = parkpcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR size visitors;
RUN;

DATA mahal; 
SET parkpcresult;
dist2 = uss(of prin1-prin4); /*squared Mahalanobis distances*/
RUN;

PROC PRINT DATA = mahal;
VAR dist2; /*checking the results*/
RUN; 

PROC SORT; /*setting up the distance order*/
BY dist2;   
RUN;   
 
DATA plotdata;
SET mahal;
prb = (_n_ -.5)/30; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   

/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN; 

/*Hisograms for each variable*/
PROC UNIVARIATE DATA = parks;
HISTOGRAM size;
RUN; 

PROC UNIVARIATE DATA = parks;
HISTOGRAM visitors;
RUN;

/*Scatterplot of the two variables*/
PROC sgscatter  DATA = parks;
   PLOT size * visitors;
RUN;
