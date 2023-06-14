DATA ok;
INPUT x1 x2 @3;
y1 = (x1 + x2)/2; /*new variable*/
y2 = x2 - 2*x1; /*new variable*/
DATALINES;
3 18
8 21
4 20
RUN;

PROC PRINT data = ok;
RUN;

/*Mean and Variance*/
PROC MEANS data = ok maxdec = 2 mean var; /*Mean procedure producing the mean and variance for y1 and y2*/
	VAR x1 x2 y1 y2;
RUN;

/*Correlation Matrix*/
PROC CORR DATA = ok OUTP = pearson_corr; /*Corr procedure creates a correlation matrix of the included variables*/
  VAR x1 x2 y1 y2;
RUN;

/*Covariance Matrix*/
PROC CORR DATA = ok OUTP = pearson_corr COV; /*Corr procedure creates a correlation matrix of the included variables*/
  VAR x1 x2 y1 y2;
RUN;
