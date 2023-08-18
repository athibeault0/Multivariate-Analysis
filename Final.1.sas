/*Final Q1: Written by Arielle Thibeault*/

data glass;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\Final\glass.csv' delimiter="," firstobs=2;
input RI Na Mg Al Si K Ca Ba Fe Type $;
run;

proc print data = glass;
run;

/*ANOVA*/
proc glm data=glass;
class Type;
model Na Mg K Ca = Type;

lsmeans Type / stderr;
manova h=Type / printe printh;
run;

/*Checking equal cov condition*/
proc discrim data=glass pool=test;
class Type;
var Na Mg K Ca;
run;

/*Discriminant Analysis: figure out how likely a particular observation is to be of a certain type*/
data test;
  input Na Mg K Ca;
  cards;
  2 8 4 10
  ; 
run;

proc discrim data=glass pool=test crossvalidate testdata=test testout=a;
class Type;
var Na Mg K Ca;
run;

proc print data=a;
run;

/*PCA*/
proc princomp data=glass cov out=a;
var Na Mg K Ca;
run;

proc factor data = a cov scree ev method = principal;
var prin1 prin2 prin3 prin4;
run;
