/**Homework 3: Written by Arielle Thibeault**/
DATA air;
INFILE 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 3\air.dat';
INPUT x1 x2 x3 x4 x5 x6 x7;
RUN;

PROC PRINT data = air;
RUN;

/**Question 2: check multivariate normality for each pair**/
proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x3 x5;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN; 


proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x3 x6;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN; 


proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x3 x7;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN;


proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x5 x6;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN;


proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x5 x7;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN;


proc princomp std out=pcresult; /*using princomp to calcualte the Mahalanobis distances*/
VAR x6 x7;
RUN;
DATA mahal; 
SET pcresult;
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
prb = (_n_ -.5)/42; /*This calculates the probabilities to be used in the chi-square quantiles*/
chiquant = cinv(prb,4);   
RUN;   
/*finally, the actual plot*/
PROC gplot;
PLOT dist2*chiquant;   
RUN;


/*Question 3: Provide a matrix of scatterplots of CO (x3), NO2 (x5), O3 (x6), and HC (x7)*/
PROC SGSCATTER data = air;
TITLE "Scatterplot Matrix for Air Data";
MATRIX x3 x5 x6 x7;
RUN;

/*Correlation matrix*/
PROC CORR DATA = air OUTP = pearson_corr; 
  VAR x3 x5 x6 x7;
RUN;

/**Confidence Interval with Bonferoni adjustment for multiplicity**/


