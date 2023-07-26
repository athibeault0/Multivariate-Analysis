options ls=78;
 
data minerals;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L11\mineral.DAT';
input dominant_radius radius dominant_humerus humerus dominant_ulna ulna;
run;

/*PCA*/ 
proc princomp data=minerals cov out=pcresults;
var dominant_radius radius dominant_humerus humerus dominant_ulna ulna;
run;
 
proc corr data=pcresults;
var prin1 prin2 prin3 prin4 prin5 jpm citibank wellsf royalds exxon;
run;

/*Biplot*/
proc gplot data=pcresults;
  axis1 length=5 in;
  axis2 length=5 in;
  plot prin2*prin1 / vaxis=axis1 haxis=axis2;
  run;

/*Scree*/
proc factor data = pcresults cov scree ev method = principal;
var prin1 prin2 prin3 prin4 prin5;
run;

/*QQ plot*/
proc univariate data=minerals;
var dominant_radius radius dominant_humerus humerus dominant_ulna ulna;
qqplot;
run;

/*QQ plots for PC1-3*/
proc univariate data=pcresults;
var prin1 prin2 prin3;
qqplot;
run;
