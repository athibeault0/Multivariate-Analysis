/**Homework 4.1: Written by Arielle Thibeault**/
options ls=78;

data swiss;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 4\swiss.dat';
input length Lwidth Rwidth Bmargin Tmargin diagonal;
run;

/*Use Hotelling's T-square to test printer meets mu0 vector*/
PROC PRINT data = swiss;
RUN;

  /* iml code to compute the hotelling t2 statistic
  * hotel is the name of the module we define here
  * mu0 is the null vector
  * one is a vector of 1s
  * ident is the identity matrix
  * ybar is the vector of sample means
  * s is the sample covariance matrix
  * t2 is the squared statistical distance between ybar and mu0
  * f is the final form of the t2 statistic after scaling
  * to have an f-distribution
  * the module definition is ended with the 'finish' statement
  * use nutrient makes the data set 'swiss' available
  * the variables from swiss are input to x and hotel module is called
  */
 
proc iml;
  start hotel;
    mu0={215, 130, 130, 9, 10};
    one=j(nrow(x),1,1);
    ident=i(nrow(x));
    ybar=x`*one/nrow(x);
    s=x
`*(ident-one*one`
/nrow(x))*x/(nrow(x)-1.0);
    print mu0 ybar;
    print s;
    t2=nrow(x)*(ybar-mu0)
`*inv(s)*(ybar-mu0);
    f=(nrow(x)-ncol(x))*t2/ncol(x)/(nrow(x)-1);
    df1=ncol(x);
    df2=nrow(x)-ncol(x);
    p=1-probf(f,df1,df2);
    print t2 f df1 df2 p;
  finish;
  use swiss;
  read all var{length Lwidth Rwidth Bmargin Tmargin} into x;
  run hotel;


data a;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 4\swiss.dat';
input length Lwidth Rwidth Bmargin Tmargin diagonal;
  variable="length"; x=length; output;
  variable="Lwidth"; x=Lwidth; output;
  variable="Rwidth"; x=Rwidth; output;
  variable="Bmargin"; x=Bmargin; output;
  variable="Tmargin"; x=Tmargin; output;
  variable="diagonal";x=diagonal; output;
  keep variable x;
run;

proc sort data=a;
  by variable;
run;

proc means data=a noprint;
  by variable;
  var x;
  output out=b n=n mean=xbar var=s2;
run;

DATA c;
set b;
f=finv(0.95,5,95);
RUN;

proc print data=c;
run;

/*95% Confidence Intervals for the means*/
%let p=5;
data d;
  set b;
  t1=tinv(1-0.025,n-1);
  tb=tinv(1-0.025/&p,n-1);
  f=finv(0.95,&p,n-&p);
  loone=xbar-t1*sqrt(s2/n);
  upone=xbar+t1*sqrt(s2/n);
  losim=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n);
  upsim=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n);
  lobon=xbar-tb*sqrt(s2/n);
  upbon=xbar+tb*sqrt(s2/n);
  run;
 
proc print data=d;
run;

/*Profile Plot for the ration of the dimensions over their specs*/
%let p=5;
data nutrient;
  infile "D:\Statistics\STAT 505\data\nutrient.csv" firstobs=2 delimiter=','
  input id calcium iron protein a c;
  variable="calcium"; ratio=calcium/1000; output;
  variable="iron";    ratio=iron/15;      output;
  variable="protein"; ratio=protein/60;   output;
  variable="vit a";   ratio=a/800;        output;
  variable="vit c";   ratio=c/75;         output;
  keep variable ratio;
  run;

data e;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\HW 4\swiss.dat';
input length Lwidth Rwidth Bmargin Tmargin diagonal;
  variable="length"; ratio=length/215; output;
  variable="Lwidth"; ratio=Lwidth/130; output;
  variable="Rwidth"; ratio=Rwidth/130; output;
  variable="Bmargin"; ratio=Bmargin/9; output;
  variable="Tmargin"; ratio=Tmargin/10; output;
  keep variable ratio;
run;

proc sort;
  by variable;
  run;

proc means;
  by variable;
  var ratio;
  output out=g n=n mean=xbar var=s2;
  run;

data h;
  set g;
  f=finv(0.95,&p,n-&p);
  ratio=xbar; output;
  ratio=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n); output;
  ratio=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n); output;
  run;
 
proc gplot;
  axis1 length=4 in;
  axis2 length=6 in;
  plot ratio*variable / vaxis=axis1 haxis=axis2 vref=1 lvref=21;
  symbol v=none i=hilot color=black;
  run;
