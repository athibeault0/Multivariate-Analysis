/*Assignment L9: Written by Arielle Thibeault*/

data drugs;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L9\drugs.csv' firstobs=2 delimiter =",";
input person t1-t4 drug $ @@;
run;

/*Split-plot ANOVA*/
data drugs2;
set drugs;
  time=5;  k=t1; output;
  time=10;  k=t2; output;
  time=15;  k=t3; output;
  time=20; k=t4; output;
  drop t1 t2 t3 t4;
run;

PROC PRINT data = drugs2;
RUN;
 
proc glm data=drugs2;
class drug person time;
model k=drug person(drug) time drug*time;
test h=drug e=person(drug);
run;

/*MANOVA model*/
PROC GLM data=drugs;
class drug;
model t1 t2 t3 t4=drug;
manova h=drug / printe printh;
output out=resids r=rt1 rt2 rt3 rt4;
RUN;

PROC SGSCATTER DATA=resids;                                                                                                                 
	MATRIX rt1 rt2 rt3 rt4 /
	DIAGONAL = (histogram normal);                                                                                                                                                                                  
RUN;

/*Variance-Covariance Test*/
PROC DISCRIM data=drugs pool=test;
class drug;
var t1 t2 t3 t4;
RUN;

/*Profile Plot*/
proc sort data=drugs2;
by drug time;
run;

proc means data=drugs2;
by drug time;
var k;
output out=a mean=mean;
run;

proc gplot data=a;
  axis1 length=4 in;
  axis2 length=6 in;
  plot mean*time=drug / vaxis=axis1 haxis=axis2;
  symbol1 v=J f=special h=2 i=join color=black;
  symbol2 v=K f=special h=2 i=join color=black;
  symbol3 v=L f=special h=2 i=join color=black;
  symbol4 v=M f=special h=2 i=join color=black;
run;

/*MANOVA for the interaction between drug and time*/
PROC GLM data=drugs;
class drug;
model t1 t2 t3 t4=drug;
manova h=drug m=t2-t1,t3-t2,t4-t3; /*m is the transformation of differences between successive times*/
output out=resids r=rt1 rt2 rt3 rt4;
RUN;

/*MANOVA for equal effects averaged over time*/
PROC GLM data=drugs;
class drug;
model t1 t2 t3 t4=drug;
manova h=drug m=t1+t2+t3+t4; /*m is the transformation of differences between successive times*/
RUN;

