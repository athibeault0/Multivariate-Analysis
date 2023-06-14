/**Homework 3.2: Written by Arielle Thibeault**/

DATA sweat;
INFILE 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 3\sweat.dat';
INPUT sweatrate sodium potassium;
RUN;

PROC PRINT data = sweat;
RUN;
/**Let's attempt to manually calculate the one-at-a-time and simultaneous confidence intervals**/
PROC MEANS data = sweat maxdec = 4 mean var std n;
	VAR sweatrate sodium potassium;
RUN;
data hello;
t1 = tinv((1-0.025),19)
;
PROC PRINT data = hello;
RUN;

/**Now a more sophisticated approach**/
%let p=3;
DATA sweat2; /*New data set for clealiness' sake*/
INPUT sweatrate sodium potassium;
  variable="sweatrate"; x=sweatrate; output;
  variable="sodium"; x=sodium; output;
  variable="potassium"; x=potassium; output;
    keep variable x;
DATALINES;
  3.7  48.5   9.3
  5.7  65.1   8.0
  3.8  47.2  10.9
  3.2  53.2  12.0
  3.1  55.5   9.7
  4.6  36.1   7.9
  2.4  24.8  14.0
  7.2  33.1   7.6
  6.7  47.4   8.5
  5.4  54.1  11.3
  3.9  36.9  12.7
  4.5  58.8  12.3
  3.5  27.8   9.8
  4.5  40.2   8.4
  1.5  13.5  10.1
  8.5  56.4   7.1
  4.5  71.6   8.2
  6.5  52.8  10.9
  4.1  44.1  11.2
  5.5  40.9   9.4
;
RUN;
proc sort data=sweat2;
  by variable;
run;
proc means data=sweat2 noprint;
  by variable;
  var x;
  output out=a n=n mean=xbar var=s2;
run;
data b; /*this section is the dirty work of all the confidence intervals*/
  set a;
  t1=tinv(1-0.025,n-1); /*one-by-one regular t multiplier*/
  tb=tinv(1-0.025/&p,n-1); /*bonferroni method t multiplier*/
  f=finv(0.95,&p,n-&p); /*multivariate simultaneous t multiplier*/
 loone=xbar-t1*sqrt(s2/n); /*One at a time interval for the mean*/
 upone=xbar+t1*sqrt(s2/n);
   lobon=xbar-tb*sqrt(s2/n); /*bonferroni interval for the mean*/
   upbon=xbar+tb*sqrt(s2/n);
 losim=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n); /*simultaneous interval for the mean*/
 upsim=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n);
run;
proc print data=b;
  run;
