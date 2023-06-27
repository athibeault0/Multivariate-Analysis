/*Homework 5.2: Written by Arielle Thibeault*/

data iris;
infile 'C:\Users\arielle.thibeault\Desktop\iris.csv' firstobs=2 delimiter=",";
input slength swidth plength pwidth type;
run;

PROC PRINT data = iris;
RUN;


proc glm data=iris;
  class type;
  model slength plength = type;
  lsmeans type / stderr;
  manova h=type / printe printh;
  run;

/*Homogineity in Variance-Covariance*/
  proc discrim data=iris pool=test;
  class type;
  var slength plength;
  run;

/*Contrasts*/
  proc glm data=iris;
  class type;
  model slength plength = type;
  estimate '1-(2+3)/2' type  2 -1 -1/ divisor=2;
  lsmeans type / stderr;
/*  manova h=type / printe printh;*/
  run;


%let p=3;
data e;
infile 'C:\Users\arielle.thibeault\Desktop\iris.csv' firstobs=2 delimiter=",";
input slength swidth plength pwidth type;
run;

proc sort;
  by type;
  run;

proc means;
  by type;
  var slength plength;
  output out=g n=n mean=xbar var=s2;
  run;

data h;
  set g;
  f=finv(0.95,&p,n-&p);
  losim=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n); output;
  upsim=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n); output;
  run;

PROC PRINT data= h;
RUN;
