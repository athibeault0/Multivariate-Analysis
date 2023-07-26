options ls=78;
 
data stocks;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L11\stocks.txt' delimiter='09'x;
input jpm citibank wellsf royalds exxon;
run;
 
 /* The princomp procedure performs pca on the stocks data.
  * The cov option specifies results are calculated from the covariance
  * matrix, instead of the default correlation matrix.
  * The out=a option saves results to a data set named 'a'.
  */
 
proc princomp data=stocks cov out=a;
var jpm citibank wellsf royalds exxon;
run;
 
 /* The corr procedure is used to calculate pairwise correlations
  * between the first 5 principal components and the original variables.
  */
 
proc corr data=a;
var prin1 prin2 prin3 prin4 prin5 jpm citibank wellsf royalds exxon;
run;
 
 /* The gplot procedure is used to plot the first 2 principal components.
  * axis1 and axis2 options set the plotting window size,
  * and these are then set to vertical and horizontal axes, respectively.
  */
 
proc gplot data=a;
  axis1 length=5 in;
  axis2 length=5 in;
  plot prin2*prin1 / vaxis=axis1 haxis=axis2;
  run;

/*Scree*/
proc factor data = a cov scree ev method = principal;
var prin1 prin2 prin3 prin4 prin5;
run;
