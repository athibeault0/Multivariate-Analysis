/*Final Q3: Written by Arielle Thibeault*/

data diabetic;
infile "C:\Users\arielle.thibeault\Desktop\STAT 505\Final\AHdata.csv" delimiter="," firstobs=2;
input id x1 x2 y1 y2;
run;

/*CCA: Find the canonical correlations and the squared canonical correlations*/
proc cancorr data=diabetic out=canout
    vprefix=primary vname="Primary Variables" 
    wprefix=secondary wname="Secondary Variables";
  var y1 y2;
  with x1 x2;
run;

proc gplot data=canout;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot primary1*secondary1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special h=2 i=r color=black;
  run;
