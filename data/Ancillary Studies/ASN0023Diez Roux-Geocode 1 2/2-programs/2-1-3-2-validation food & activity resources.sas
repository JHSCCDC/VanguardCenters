********************************************************************;
**********  Analytic Dataset of JHS Neighborhood Variables *********;
********************************************************************;

title "Analytic Dataset of JHS Neighborhood Variables:Food and Physical Activity Resources (NETS derived data)";

**********************Produce basic statistics**********************;

*Variable List;

  *selected continuous variables: if there are three variables for the same info, like COMMAREA0,COMMAREA1,and COMMAREA14, only COMMAREA1 was chosen ;                    
   %let contvar =  K1IPAI K1OPAI K1PAI S1IPAI S1OPAI S1PAI K0IPAI K0OPAI K0PAI S0IPAI
S0OPAI S0PAI K3IPAI K3OPAI K3PAI S3IPAI S3OPAI S3PAI K1SOC S1SOC K0SOC S0SOC K3SOC S3SOC K1WALK S1WALK K0WALK
S0WALK K3WALK S3WALK K1TOTSTR S1TOTSTR K0TOTSTR S0TOTSTR K3TOTSTR S3TOTSTR ;

   *Categorical;                   
   %let catvar  = exam ;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries";
proc means data = validation maxdec = 2 fw = 6; 
 class exam;
 var  K1IPAI K1OPAI K1PAI S1IPAI S1OPAI S1PAI K0IPAI K0OPAI K0PAI S0IPAI
S0OPAI S0PAI K3IPAI K3OPAI K3PAI S3IPAI S3OPAI S3PAI K1SOC S1SOC K0SOC S0SOC K3SOC S3SOC K1WALK S1WALK K0WALK
S0WALK K3WALK S3WALK K1TOTSTR S1TOTSTR K0TOTSTR S0TOTSTR K3TOTSTR S3TOTSTR  ;
 run;


proc sort data= validation;
by exam;
 run;
*******************graphs********************************;
 *3. Neighborhood Social Environment Variables;
title1 "Food and Physical Activity Resources (NETS derived data)";
*3.2 Recreational facilities;
*********1 mile kernel;
 data validation; 
   set validation;
   if K1IPAI>20 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 
title2 "1 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  K1PAI*K1IPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot  K1PAI*K1OPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;


*********1/2 mile kernel;
title2 "1/2 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  K0PAI*K0IPAI/group=exam ;
run;

title2 "1/2 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot  K0PAI*K0OPAI/ group=exam ;
run;
*********3 mile kernel;
 data validation; 
   set validation;
   if K3PAI>12 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 
title2 "3 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  K3PAI*K3IPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "3 mile kernel TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot  K3PAI*K3OPAI/datalabel=outlier_text_POPDENKM1  group=exam ;
run;

*********1 mile simple;
 data validation; 
   set validation;
   if s1IPAI>20 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 
title2 "1 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  s1PAI*s1IPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot s1PAI*s1OPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

*********1/2 mile simple;
title2 "1/2 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  s0PAI*s0IPAI/group=exam ;
run;

title2 "1/2 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot  s0PAI*s0OPAI/ group=exam ;
run;
*********3 mile simple;
 data validation; 
   set validation;
   if s3PAI>12 then do;
  		outlier = 1; *indicator for outlier status;
		outlier_text_POPDENKM1= cats("Outlier: ", subjid);
  	end;
  run; 
title2 "3 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. INDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL";
proc sgscatter data= validation ;
plot  s3PAI*s3IPAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "3 mile simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER vs. OUTDOOR TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+WATER";
proc sgscatter data= validation ;
plot  s3PAI*s3OPAI/datalabel=outlier_text_POPDENKM1  group=exam ;
run;

**********Kernel vs. Simple;
title2 "1 mile kernel vs simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER ";
proc sgscatter data= validation ;
plot  K1PAI*s1PAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "1/2 mile kernel vs simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER ";
proc sgscatter data= validation ;
plot  K0PAI*s0PAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;
title2 "3 mile kernel vs simple TOTAL PHYSICAL ACTIVITIES+INSTRUCTIONAL+INSTRUCTIONAL+WATER ";
proc sgscatter data= validation ;
plot  K3PAI*s3PAI/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

*3.3 Social engagement;
title2 "1 mile kernel vs simple total social engagement destinations ";
proc sgscatter data= validation ;
plot  K1SOC*S1SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1/2 mile kernel vs simple total social engagement destinations ";
proc sgscatter data= validation ;
plot  K0SOC*S0SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "3 mile kernel vs simple total social engagement destinations ";
proc sgscatter data= validation ;
plot  K3SOC*S3SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs 1/2 mile kernel total social engagement destinations ";
proc sgscatter data= validation ;
plot  K1SOC*K0SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs 3 mile kernel total social engagement destinations ";
proc sgscatter data= validation ;
plot  K1SOC*K3SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs 1/2 mile simple total social engagement destinations ";
proc sgscatter data= validation ;
plot  s1SOC*s0SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs 3 mile simple total social engagement destinations ";
proc sgscatter data= validation ;
plot  s1SOC*s3SOC/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

*3.4 Walking destination;
title2 "1 mile kernel vs simple total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  K1WALK*S1WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1/2 mile kernel vs simple total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  K0WALK*S0WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "3 mile kernel vs simple total neighborhood popular walking destinations ";
proc sgscatter data= validation ;
plot  K3WALK*S3WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs 1/2 mile kernel total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  K1WALK*K0WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs 3 mile kernel total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  K1WALK*K3WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs 1/2 mile simple total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  s1WALK*s0WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs 3 mile simple total neighborhood popular walking destinations";
proc sgscatter data= validation ;
plot  s1WALK*s3WALK/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

*3.5 Total store ; 
title2 "1 mile kernel vs simple TOTAL STORES";
proc sgscatter data= validation ;
plot  K1TOTSTR*S1TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1/2 mile kernel vs. simple TOTAL STORES";
proc sgscatter data= validation ;
plot  K0TOTSTR*S0TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "3 mile kernel vs. simple TOTAL STORES ";
proc sgscatter data= validation ;
plot  K3TOTSTR*S3TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs. 1/2 mile kernel TOTAL STORES";
proc sgscatter data= validation ;
plot  K1TOTSTR*K0TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile kernel vs. 3 mile kernel TOTAL STORES";
proc sgscatter data= validation ;
plot  K1TOTSTR*K3TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs. 1/2 mile simple TOTAL STORES";
proc sgscatter data= validation ;
plot  s1TOTSTR*s0TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

title2 "1 mile simple vs. 3 mile simple TOTAL STORES";
proc sgscatter data= validation ;
plot  s1TOTSTR*s3TOTSTR/datalabel=outlier_text_POPDENKM1 group=exam ;
run;

%put Section 03 Complete;
