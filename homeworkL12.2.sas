/*Homework L12: Written by Arielle Thibeault*/

data pollution;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L12\pollution.dat';
input wind solar co no no2 o3 hc;
run;

/*Factor Analysis on all 7 variables with 2 factors*/
proc factor data=pollution method=principal nfactors=2 rotate=varimax simple scree ev preplot plot residuals;
var wind solar co no no2 o3 hc;
run;

/*Factor Analysis on all 7 variables with 3 factors*/
proc factor data=pollution method=principal nfactors=3 rotate=varimax simple scree ev preplot plot residuals;
var wind solar co no no2 o3 hc;
run;
