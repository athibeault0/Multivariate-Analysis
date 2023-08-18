/*Assignment L13.2: Written by Arielle Thibeault*/

data sales;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L13\sales.txt';
input growth profit new creative mechanical abs math;
run;

/*Find the first canonical correlation*/
proc cancorr data=sales out=canout
    vprefix=sales vname="Sales" 
    wprefix=test wname="Test";
  var growth profit;
  with mechanical abs math;
  run;
