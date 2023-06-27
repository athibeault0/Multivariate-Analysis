/*Homework 5: Written by Arielle Thibeault*/

data oxygen;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 5\oxygen.csv' firstobs=2 delimiter=",";
input x1-x4 sex $;
run;

/*MANOVA Model*/
 /* The lsmeans option provides standard error estimates and 
  * standard errors for the differences between the site groups.
  * The manova statement is used for multivariate tests and results.
  * The h= option specifies the groups for comparison, and the 
  * options printe and printh display the sums of squares and cross
  * products matrices for error and the hypothesis, respectively.
  */

proc glm data=oxygen;
class sex;
model x1 x2 x3 x4 = sex;
lsmeans sex / stderr;
manova h=sex / printe printh;
run;

/*Checking Model Assumptions*/

/*Normality*/
PROC SGSCATTER DATA=oxygen;                                                                                                                 
	MATRIX x1 x2 x3 x4 /
	DIAGONAL = (histogram normal);                                                                                                                                                                                  
RUN;

/*Common variance*/
proc discrim data=oxygen pool=test;
class sex;
var x1 x2 x3 x4;
run;

 /* The class statement specifies the categorical variable site.
  * The model statement specifies the five responses to the left
  * and the categorical predictor to the right of the = sign.
  * The output statement is optional and can be used to save the
  * residuals, which are named with the r= option for later use.
  */
 
proc glm data=oxygen;
  class sex;
  model x1 x2 x3 x4 = sex;
  output out=resids r=rx1 rx2 rx3 rx4;
  run;
 
proc print data=resids;
  run;

PROC SGSCATTER DATA=resids;                                                                                                                 
	MATRIX rx1 rx2 rx3 rx4 /
	DIAGONAL = (histogram normal);                                                                                                                                                                                  
RUN;


%let p=5;
DATA a; /*New data set for clealiness' sake*/
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 5\oxygen.csv' firstobs=2 delimiter=",";
  variable="x1"; x=x1; output;
  variable="x2"; x=x2; output;
  variable="x3"; x=x3; output;
  variable="x4"; x=x4; output;
  variable="sex"; x=sex; output;
keep variable x;
RUN;

proc sort data=a;
  by variable;
run;
proc means data=a;
  by variable;
  var x;
  output out=a n=n mean=xbar var=s2;
run;
data b;
set a;
tb=tinv(1-0.025/&p,n-1); /*bonferroni method t multiplier*/
f=finv(0.95,&p,n-&p);
lobon=xbar-tb*sqrt(s2/n); /*bonferroni interval for the mean*/
upbon=xbar+tb*sqrt(s2/n);
run;
proc print data=b;
  run;
