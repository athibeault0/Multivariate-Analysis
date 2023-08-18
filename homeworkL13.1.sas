/*Assignment L13: Written by Arielle Thibeault*/

data paper;
  infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L13\paper.dat' delimiter='09'x;
  input x1 x2 x3 x4 y1 y2 y3 y4;
  run;

/*Cannonical Correlation Analysis*/
proc cancorr data=paper out=canout
    vprefix=paper vname="Paper Characteristics" 
    wprefix=fiber wname="Fiber Characteristics";
  var x1 x2 x3 x4;
  with y1 y2 y3 y4;
  run;
 
proc gplot data=canout;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot paper1*fiber1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special h=2 i=r color=black;
  run;
