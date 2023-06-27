/**Homework 4.2: Written by Arielle Thibeault**/
options ls=78;

data kite;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 4\kite.dat';
input tail wing;
run;

proc print data = kite;
run;

/*Linear relationship between tail and wing?*/
PROC CORR DATA = kite OUTP = pcor COV;
  VAR tail wing;
RUN;

/*checking linearity assumption*/
PROC UNIVARIATE data=kite NORMAL;
VAR tail wing; 
HISTOGRAM tail wing;
RUN;

/**/
data kiteratio;
set kite;
ratio = wing/tail;
run;

proc means data=kiteratio;
  var ratio;
  output out=b n=n mean=xbar var=s2;
run;

data ratiotest;
set b;
tr = (1.4905955-1.5)/(0.0089128/45)**0.5;
run;

proc print data = ratiotest;
run;
