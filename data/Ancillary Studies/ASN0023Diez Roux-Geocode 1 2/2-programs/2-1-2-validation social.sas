********************************************************************;
**********  Analytic Dataset of JHS Neighborhood Variables *********;
********************************************************************;

title "Analytic Dataset of JHS Neighborhood Variables: Neighborhood Social Environment ";

**********************Produce basic statistics**********************;

*Variable List;

  *selected continuous variables: if there are three variables for the same info, like COMMAREA0,COMMAREA1,and COMMAREA14, only COMMAREA1 was chosen ;                    
   %let contvar = SCPCA_UEBE  VOPCA_UEBE 	NPPCA_UEBE ;

   *Categorical;                   
   %let catvar  = exam ;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries";
proc means data = validation maxdec = 2 fw = 6; 
 class exam;
 var SCPCA_UEBE VOPCA_UEBE 	NPPCA_UEBE	;
 run;


proc sort data= validation;
by exam;
 run;

*2. Neighborhood Social Environment Variables; 
title1 "Neighborhood Social Environment Variables";
title2 "Age & gender adjusted Unconditional Empirical Bayes Estimate (UEBE) for NB Problem PCA-based vs. Cohesion";
proc sgscatter data= validation;
plot  NPPCA_UEBE*SCPCA_UEBE/group=exam ;
run;

title2 "Age & gender adjusted Unconditional Empirical Bayes Estimate (UEBE) for NB  Cohesion PCA-based vs. Violence ";
proc sgscatter data= validation;
plot  SCPCA_UEBE*VOPCA_UEBE/group=exam ;
run;

title2 "Age & gender adjusted Unconditional Empirical Bayes Estimate (UEBE) for NB Problem PCA-based vs. Violence";
proc sgscatter data= validation;
plot  NPPCA_UEBE*VOPCA_UEBE/group=exam ;
run;
 

%put Section 02 Complete;
