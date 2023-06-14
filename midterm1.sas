/*Midterm 1: Written by Arielle Thibeault*/

DATA raisin_orig;
INFILE 'C:\Users\arielle.thibeault\Desktop\raisin.csv' delimiter="," firstobs=2;
INPUT Area MajorAxisLength MinorAxisLength Eccentricity ConvexArea Extent Perimeter Class $; 
RUN;

DATA raisin;
SET raisin_orig;
WHERE class="Kecimen";
DROP class; 
RUN;

/****Question a: Assess the normality and provide a transform for the skewed distributions****/
PROC SGSCATTER DATA=raisin;                                                                                                                 
	MATRIX Area MajorAxisLength MinorAxisLength Eccentricity ConvexArea Extent Perimeter /
	DIAGONAL = (histogram normal);                                                                                                                                                                                  
RUN;

/**For my own use**/
PROC UNIVARIATE DATA = raisin;
HISTOGRAM Area MajorAxisLength MinorAxisLength Eccentricity ConvexArea Extent Perimeter;
RUN;

/*To decide which one fits the best for each variable, we'll calculate out the tranformations*/
DATA raisin2;
SET raisin;
  L_area = log(area);
  S_area = area**.5;
  S_S_area = area**.25;

  L_maj = log(MajorAxisLength);
  S_maj = MajorAxisLength**.5;
  S_S_maj = MajorAxisLength**.25;
  
  L_min = log(MinorAxisLength);
  S_min = MinorAxisLength**.5;
  S_S_min = MinorAxisLength**.25;

  L_ecc = log(Eccentricity);
  S_ecc = Eccentricity**.5;
  S_S_ecc = Eccentricity**.25;

  L_con = log(ConvexArea);
  S_con = ConvexArea**.5;
  S_S_con = ConvexArea**.25;

  L_ext = log(Extent);
  S_ext = Extent**.5;
  S_S_ext = Extent**.25;

  L_per = log(Perimeter);
  S_per = Perimeter**.5;
  S_S_per = Perimeter**.25;
RUN;

PROC PRINT data = raisin2;
RUN;

/*First one: Area*/
proc univariate data=raisin2;
VAR Area L_area S_area S_S_area;
histogram Area L_area S_area S_S_area;
run;

/*MajAL*/
proc univariate data=raisin2;
VAR MajorAxisLength L_maj S_maj S_S_maj;
histogram MajorAxisLength L_maj S_maj S_S_maj;
run;

/*MinAL*/
proc univariate data=raisin2;
VAR MinorAxisLength L_min S_min S_S_min;
histogram MinorAxisLength L_min S_min S_S_min;
run;

/*Ecc*/
proc univariate data=raisin2;
VAR Eccentricity L_ecc S_ecc S_S_ecc;
histogram Eccentricity L_ecc S_ecc S_S_ecc;
run;

/*We need a little extra help finding the best transformation*/
 	proc univariate data=raisin2 normal; 
	qqplot Eccentricity L_ecc S_ecc S_S_ecc /Normal(mu=est sigma=est color=red l=1);
	run;

/*Conv*/
proc univariate data=raisin2;
VAR ConvexArea L_con S_con S_S_con;
histogram ConvexArea L_con S_con S_S_con;
run;

/**Question c: Estimate the mean values for the seven variables simultaneously with 95% confidence**/
%let p=7;
DATA raisin3;
SET raisin;
  variable="Area"; x=Area; output;
  variable="MajorAxisLength"; x=MajorAxisLength; output;
  variable="MinorAxisLength"; x=MinorAxisLength; output;
  variable="Eccentricity"; x=Eccentricity; output;
  variable="ConvexArea"; x=ConvexArea; output;
  variable="Extent"; x=Extent; output;
  variable="Perimeter"; x=Perimeter; output;
keep variable x;
RUN;

proc sort data=raisin3;
  by variable;
run;

proc means data=raisin3 noprint;
  by variable;
  var x;
  output out=a n=n mean=xbar var=s2 cov=qwq;
run;

data b; /*this section is the dirty work of all the confidence intervals*/
	set a; 
	f=finv(0.95,&p,n-&p); /*multivariate simultaneous t multiplier*/
 	losim=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n); /*simultaneous interval for the mean*/
 	upsim=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n);
run;
proc print data=b;
  run;

/**Question d:  Are any of the 4 variables Area, Eccentricity, ConvexArea, and Extent significantly correlated?**/
ODS output covariancematrix=cm;
proc princomp data=raisin cov out=hello;
  var Area Eccentricity ConvexArea Extent;
  run;

Proc Corr data=raisin outp=corrtable cov;
var Area Eccentricity ConvexArea Extent;
run;

proc print data=corrtable;
  var Area Eccentricity ConvexArea Extent;
  run;

data test;
tb=tinv(0.00625,448);
run;

proc print data=test;
  run;

proc corr data=raisin fisher(alpha=.05 biasadj=no);
var Area Eccentricity ConvexArea Extent;
run;

proc corr data=raisin fisher(alpha=.0125 biasadj=no);
var Area Eccentricity ConvexArea Extent;
run;

/**Question e: Partial Correlation on MajAL and MinAL**/
proc corr data=raisin fisher(alpha=.05 biasadj=no);
var Area Eccentricity ConvexArea Extent;
partial MajorAxisLength MinorAxisLength;
run;
