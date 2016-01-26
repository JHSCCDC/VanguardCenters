********************************************************************;
**********  Analytic Dataset of JHS Neighborhood Variables *********;
********************************************************************;

title "Analytic Dataset of JHS Neighborhood Variables:Food and Physical Activity Resources (NETS derived data)";

**********************Produce basic statistics**********************;

*Variable List;

  *selected continuous variables: if there are three variables for the same info, like COMMAREA0,COMMAREA1,and COMMAREA14, only COMMAREA1 was chosen ;                    
   %let contvar = K1FAV K1MRFEI_NOALC K1MRFEI_TOT K1TOTFOOD K1UNFAV K1UNFAVFO S1FAV S1MRFEI_NOALC S1MRFEI_TOT S1TOTFOOD
S1UNFAV S1UNFAVFO K0FAV K0MRFEI_NOALC K0MRFEI_TOT K0TOTFOOD K0UNFAV K0UNFAVFO S0FAV S0MRFEI_NOALC S0MRFEI_TOT
S0TOTFOOD S0UNFAV S0UNFAVFO K3FAV K3MRFEI_NOALC K3MRFEI_TOT K3TOTFOOD K3UNFAV K3UNFAVFO S3FAV S3MRFEI_NOALC
S3MRFEI_TOT S3TOTFOOD S3UNFAV S3UNFAVFO  ;

   *Categorical;                   
   %let catvar  = exam ;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries";
proc means data = validation maxdec = 2 fw = 6; 
 class exam;
 var  K1FAV K1MRFEI_NOALC K1MRFEI_TOT K1TOTFOOD K1UNFAV K1UNFAVFO S1FAV S1MRFEI_NOALC S1MRFEI_TOT S1TOTFOOD
S1UNFAV S1UNFAVFO K0FAV K0MRFEI_NOALC K0MRFEI_TOT K0TOTFOOD K0UNFAV K0UNFAVFO S0FAV S0MRFEI_NOALC S0MRFEI_TOT
S0TOTFOOD S0UNFAV S0UNFAVFO K3FAV K3MRFEI_NOALC K3MRFEI_TOT K3TOTFOOD K3UNFAV K3UNFAVFO S3FAV S3MRFEI_NOALC
S3MRFEI_TOT S3TOTFOOD S3UNFAV S3UNFAVFO;
 run;


proc sort data= validation;
by exam;
 run;
*******************graphs********************************;
 *3. Neighborhood Social Environment Variables;
*3.1 Food Store ;
title1 "Food and Physical Activity Resources (NETS derived data)";

*****************KERNEL*************;
***********1 mile Kernel;
data validation2; set validation;
if K1MRFEI_NOALC >100 then K1MRFEI_NOALC=.;
if  K1MRFEI_TOT>100 then  K1MRFEI_TOT=.;
run;

title2 "1 mile kernel MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot K1MRFEI_NOALC*K1MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if K1TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "1 mile kernel FAVORABLE FOOD STORES vs. 1 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K1FAV*K1TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1 mile kernel UNFAVORABLE FOOD STORES vs. 1 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K1UNFAV*K1TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1 mile kernel UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot K1UNFAV*K1UNFAVFO /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1 mile kernel UNFAVORABLE FOOD STORES vs. FAVORABLE FOOD STORES";
proc sgscatter data= validation;
plot K1UNFAV*K1FAV /datalabel=outlier_text_POPDENKM1   group=exam ;
run;
***********1/2 mile Kernel;
data validation2; set validation;
if K0MRFEI_NOALC >100 then K0MRFEI_NOALC=.;
if  K0MRFEI_TOT>100 then  K0MRFEI_TOT=.;
run;

title2 "1/2 mile kernel MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot K0MRFEI_NOALC*K0MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if K0TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "1/2 mile kernel FAVORABLE FOOD STORES vs. 1/2 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K0FAV*K0TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1/2 mile kernel UNFAVORABLE FOOD STORES vs. 1/2 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K0UNFAV*K0TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1/2 mile kernel UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot K0UNFAV*K0UNFAVFO /  group=exam ;
run;

title2 "1/2 mile kernel UNFAVORABLE FOOD STORES vs. FAVORABLE FOOD STORES";
proc sgscatter data= validation;
plot K0UNFAV*K0FAV /  group=exam ;
run;
***********3 mile Kernel;
data validation2; set validation;
if K3MRFEI_NOALC >100 then K3MRFEI_NOALC=.;
if  K3MRFEI_TOT>100 then  K3MRFEI_TOT=.;
run;

title2 "3 mile kernel MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot K3MRFEI_NOALC*K3MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if K3TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "3 mile kernel FAVORABLE FOOD STORES vs. 3 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K3FAV*K3TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "3 mile kernel UNFAVORABLE FOOD STORES vs. 3 mile kernel TOTAL FOOD STORES";
proc sgscatter data= validation;
plot K3UNFAV*K3TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "3 mile kernel UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot K3UNFAV*K3UNFAVFO /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "3 mile kernel UNFAVORABLE FOOD STORES vs. FAVORABLE FOOD STORES";
proc sgscatter data= validation;
plot K3UNFAV*K3FAV /  group=exam ;
run;
*****************SIMPLE*************;
***********1 mile Simple;
data validation2; set validation;
if s1MRFEI_NOALC >100 then s1MRFEI_NOALC=.;
if  s1MRFEI_TOT>100 then  s1MRFEI_TOT=.;
run;

title2 "1 mile simple MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot s1MRFEI_NOALC*s1MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if s1TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "1 mile simple FAVORABLE FOOD STORES vs. 1 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s1FAV*s1TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1 mile simple UNFAVORABLE FOOD STORES vs. 1 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s1UNFAV*s1TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1 mile simple UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot s1UNFAV*s1UNFAVFO /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

***********1/2 mile Simple;
data validation2; set validation;
if s0MRFEI_NOALC >100 then s0MRFEI_NOALC=.;
if  s0MRFEI_TOT>100 then  s0MRFEI_TOT=.;
run;

title2 "1/2 mile simple MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot s0MRFEI_NOALC*s0MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if s0TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "1/2 mile simple FAVORABLE FOOD STORES vs. 1/2 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s0FAV*s0TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1/2 mile simple UNFAVORABLE FOOD STORES vs. 1/2 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s0UNFAV*s0TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "1/2 mile simple UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot s0UNFAV*s0UNFAVFO /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

***********3 mile Kernel;
data validation2; set validation;
if s3MRFEI_NOALC >100 then s3MRFEI_NOALC=.;
if  s3MRFEI_TOT>100 then  s3MRFEI_TOT=.;
run;

title2 "3 mile simple MODIFIED RETAIL FOOD ENVIRONMENT INDEX EXCLUDE ALCOHOL vs. INCLUDE ALCOHOL ";
proc sgscatter data= validation2;
plot s3MRFEI_NOALC*s3MRFEI_TOT /group=exam ;
run;

 data validation; 
   set validation;
   if s3TOTFOOD>200 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 

title2 "3 mile simple FAVORABLE FOOD STORES vs. 3 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s3FAV*s3TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "3 mile simple UNFAVORABLE FOOD STORES vs. 3 mile simple TOTAL FOOD STORES";
proc sgscatter data= validation;
plot s3UNFAV*s3TOTFOOD /datalabel=outlier_text_POPDENKM1   group=exam ;
run;

title2 "3 mile simple UNFAVORABLE FOOD STORES vs. UNFAVORABLE FOOD STORES EXCLUDING ALCOHOL";
proc sgscatter data= validation;
plot s3UNFAV*s3UNFAVFO /datalabel=outlier_text_POPDENKM1   group=exam ;
run;


**********Kernel vs. Simple;
title2 "1 mile kernel FAVORABLE FOOD STORES vs. 1 mile simple FAVORABLE FOOD STORES ";
proc sgscatter data= validation;
plot  K1FAV*S1FAV /group=exam ;
run;
title2 "0 mile kernel FAVORABLE FOOD STORES vs. 1/2 mile simple FAVORABLE FOOD STORES ";
proc sgscatter data= validation;
plot  K0FAV*S0FAV /group=exam ;
run;
title2 "3 mile kernel FAVORABLE FOOD STORES vs. 3 mile simple FAVORABLE FOOD STORES ";
proc sgscatter data= validation2;
plot  K3FAV*S3FAV /datalabel=outlier_text_POPDENKM1 group=exam ;
run;

 

%put Section 03-1 Complete;
