/*Assignment L14.1: Written by Arielle Thibeault*/

data mali;
infile 'C:\Users\arielle.thibeault\Desktop\STAT 505\L14\mali.dat' delimiter='09'x firstobs=2;
input x1-x9;
ident=_n_;
run;

/**Cluster using Ward's method**/
proc sort data=mali;
by ident;
run;

/*Heirarchical clustering*/
proc cluster data=mali method=ward outtree=clust1;
var x1-x9;
id ident;
run;

/*Dendrogram*/
proc tree data=clust1 horizontal nclusters=6 out=clust2;
id ident;
run;

proc sort data=clust2;
by ident;
run;

/*Combining the two datasets*/
data combine;
merge mali clust2;
by ident;
run;

/*Clusters and ANOVA stats*/
proc glm data=combine;
class cluster;
model x1-x9 = cluster;
means cluster;
run;


/**Cluster using K-means method, K = 4**/
/*mali is already sorted by ident, so we can just get into it*/
proc fastclus data=mali maxclusters=4 replace=random;
var x1-x9;
id ident;
run;

proc fastclus data=mali maxclusters=5 replace=random;
var x1-x9;
id ident;
run;

proc fastclus data=mali maxclusters=6 replace=random;
var x1-x9;
id ident;
run;
