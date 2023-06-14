/**Homework 1: Written by Arielle Thibeault**/

/*Define new variables Y1 = X1 +X2 +X3 and Y2 = X3 -X1. Find the mean and variance for
each of Y1 and Y2. Also, find the correlation between Y1 and Y2.*/

OPTIONS PS = 60 LS = 80 NODATE NONUMBER;
DATA companies;
	INFILE 'C:\Users\arielle.thibeault\Desktop\STAT 505\companies.dat';
	INPUT x1 x2 x3;
	y1 = x1 + x2 + x3; /*new variable*/
	y2 = x3 - x1; /*new variable*/
RUN;

PROC PRINT data = companies;
RUN; /*Printing out the raw data + calculations*/

PROC MEANS data = companies maxdec = 2 mean var; /*Mean procedure producing the mean and variance for y1 and y2*/
	VAR y1 y2;
RUN;

PROC CORR DATA = companies OUTP = pearson_corr; /*Corr procedure creates a correlation matrix of the included variables*/
  VAR y1 y2;
RUN;
