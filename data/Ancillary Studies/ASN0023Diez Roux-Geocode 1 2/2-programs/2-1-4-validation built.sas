********************************************************************;
**********  Analytic Dataset of JHS Neighborhood Variables *********;
********************************************************************;

title "Analytic Dataset of JHS Neighborhood Variables: built environment ";

**********************Produce basic statistics**********************;

*Variable List;

  *selected continuous variables: if there are three variables for the same info, like COMMAREA0,COMMAREA1,and COMMAREA14, only COMMAREA1 was chosen ;                    
   %let contvar =PCOM0 PCOM1 PCOM14 PRES0 PRES1 PRES14 PRET0 PRET1 PRET14 PCTLU0 PCTLU1 PCTLU14 INLUCOUNTY POPDENKM0 POPDENKM1 POPDENKM14 POPDENMI0 
POPDENMI1 POPDENMI14 NetRatio0 NetRatio1 NetRatio14 INTCNT0 INTCNT1 INTCNT14 ;

   *Categorical;                   
   %let catvar  = exam ;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries";
proc means data = validation maxdec = 2 fw = 6; 
 class exam;
 var PCOM0 PCOM1 PCOM14 PRES0 PRES1 PRES14 PRET0 PRET1 PRET14 PCTLU0 PCTLU1 PCTLU14 INLUCOUNTY POPDENKM0 POPDENKM1 POPDENKM14 POPDENMI0 
POPDENMI1 POPDENMI14 NetRatio0 NetRatio1 NetRatio14 INTCNT0 INTCNT1 INTCNT14 ;
 run;


proc sort data= validation;
by exam;
 run;
*******************graphs********************************;
*4. JHS Built Environment Data 
*4.1 neighborhood land use;
title2 "Percent Commercial  vs.  Residential  1 mile";
proc sgscatter data= validation ;
plot  PCOM1*PRES1/  group=exam ;
run;

title2 "Percent Commercial  vs. Retail 1 mile";
proc sgscatter data= validation ;
plot  PCOM1*PRET1/  group=exam ;
run;

*Commercial;
title2 "Percent Commercial  1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot  PCOM0*PCOM1/  group=exam ;
run;
title2 "Percent Commercial  1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PCOM0*PCOM14/  group=exam ;
run;
title2 "Percent Commercial  1 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PCOM1*PCOM14/  group=exam ;
run;

*Residential;
title2 "Percent Residential  1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot  PRES0*PRES1/  group=exam ;
run;
title2 "Percent Residential  1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PRES0*PRES14/  group=exam ;
run;
title2 "Percent Residential  1 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PRES1*PRES14/  group=exam ;
run;

*Retail;
title2 "Percent Retail  1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot PRET0*PRET1/  group=exam ;
run;
title2 "Percent Retail  1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PRET0*PRET14/  group=exam ;
run;
title2 "Percent Retail  1 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PRET1*PRET14/  group=exam ;
run;

*buffer in land use data boundary ;
title2 "Percent buffer in land use data boundary 1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot PCTLU0*PCTLU1/  group=exam ;
run;
title2 "Percent buffer in land use data boundary  1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PCTLU0*PCTLU14/  group=exam ;
run;
title2 "Percent buffer in land use data boundary  1 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot  PCTLU1*PCTLU14/  group=exam ;
run;



*4.2 neighborhood population density;
title2 "Population density per square km 1/2 mile vs. per square mile 1/2 mile";
proc sgscatter data= validation ;
plot POPDENKM0*POPDENMI0/  group=exam ;
run;
title2 "Population density per square km 1 mile vs. per square mile 1 mile";
proc sgscatter data= validation ;
plot POPDENKM1*POPDENMI1/  group=exam ;
run;
title2 "Population density per square km 1/4 mile vs. per square mile 1/4 mile";
proc sgscatter data= validation ;
plot POPDENKM14*POPDENMI14/  group=exam ;
run;
 data validation; 
   set validation;
   if POPDENKM1>8000 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "Population density per square km 1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot POPDENKM0*POPDENKM1/ datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "Population density per square km 1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot POPDENKM0*POPDENKM14/ datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "Population density per square km 1 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot POPDENKM1*POPDENKM14/ datalabel=outlier_text_POPDENKM1 group=exam ;
run;
*4.3 street connectivity ;
title2 "Network Ratio vs. Number of intersections in 1/2 mile";
proc sgscatter data= validation ;
plot NetRatio0*INTCNT0/  group=exam ;
run;
title2 "Network Ratio vs. Number of intersections in 1/4 mile";
proc sgscatter data= validation ;
plot NetRatio14*INTCNT14/  group=exam ;
run;
title2 "Network Ratio vs. Number of intersections in 1 mile";
proc sgscatter data= validation ;
plot NetRatio1*INTCNT1/ datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "Network Ratio 1/2 mile vs. 1 mile";
proc sgscatter data= validation ;
plot NetRatio1*NetRatio0/ datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "Network Ratio 1/2 mile vs. 1/4 mile";
proc sgscatter data= validation ;
plot NetRatio1*NetRatio14/   group=exam ;
run;


%put Section 04 Complete;
