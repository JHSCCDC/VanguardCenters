************************************************************************************;
*	COMPUTATION OF AN OVERALL CONCORDANCE CORRELATION COEFFICIENT					;
************************************************************************************;
*																					;
*	PROGRAM DESCRIPTION:															;
*   ------------------------------------------------------------------------------ 	;
*	THIS PROGRAM PRODUCES AN OVERALL CONCORDANCE CORRELATION COEFFICIENT FOR ONE	;
*	METHOD WITH TWO OR MORE RATERS AS WELL AS FOR TWO METHODS WITH ONE OR MORE	 	;
*	RATERS.  FOR ONE GROUP WITH TWO RATERS, THE FORMULAS IN LIN (1989) ARE 	    	;
*	APPLIED, INCLUDING THE CCC, THE STANDARD ERROR, AND THE ASYMPTOTIC CONFIDENCE	;
*	INTERVAL BASED UPON THE Z-TRANSFORMATION.  FOR ONE GROUP WITH MORE THAN TWO		;
*	RATERS, THE OVERALL CCC FROM BARNHART (2002) IS	USED.  FOR TWO METHODS WITH 	;
* 	ONE OR MORE RATERS, THE OVERALL CCC FROM WILLIAMSON (ACCEPTED) IS APPLIED. 		;
*	THIS PROGRAM ALSO PERFORMS HYPOTHESIS TESTING FOR TWO INDEPENDENT CCCs WITH 	;
*	EACH CCC ASSESSING ONE METHOD WITH MULTIPLE RATERS, FOR TWO DEPENDENT CCCs 		;
*	WITH EACH CCC ASSESSING ONE METHOD WITH MULTIPLE RATERS AND FOR TWO DEPENDENT 	;
* 	CCCs WITH EACH CCC ASSESSING TWO METHODS WITH MULTIPLE RATERS.					;
*																					;
*																					;
*	DATASET REQUIREMENTS:															;
*   ------------------------------------------------------------------------------ 	;
*	THE DATASET (OR BOTH DATASETS IF YOU ARE COMPARING TWO INDEPENDENT CCCs), MUST	;
*	HAVE ONE LINE PER SUBJECT WHERE EACH SUBJECT IS EVALUATED BY ONE OR TWO 		;
*	METHODS AND BY MULTIPLE RATERS.  THE RESULTS OF THE EVALUATION FOR EACH 		;
*	SUBJECT UNDER EACH METHOD AND RATER COMBINATION MUST BE REPORTED UNDER A 		;
*	DIFFERENT VARIABLE.  FOR EXAMPLE, IF WE HAVE THREE SUBJECTS EVALUATED UNDER		;
*	TWO METHODS BY TWO RATERS, THEN THE DATA WOULD APPEAR AS FOLLOWS (WHERE M1R1	;
*	REPRESENTS THE RESULTS FOR METHOD 1, RATER1).  THIS MACRO IS DESIGNED FOR 		;
*	BALANCED DATA.  ANY SUBJECTS WITH MISSING DATA WILL BE DELETED FROM THE 		;
*	ANALYSIS.																		;
*																					;
*			SUBJECT		M1R1	M1R2	M2R1	M2R2								;
*				1		20		21		30		32									;
*				2		24		28		31		29									;
*				3		22		25		30		31									;
*																					;
*																					;
*	MACRO VARIABLES:																;
*   ------------------------------------------------------------------------------ 	;
*	ANALYSIS: 		NUMERIC VALUE 1-5 INDICATING WHAT TYPE OF ANALYSIS IS DESIRED	;
*					FROM SAS:														;
*																					;
*					1 = ESTIMATE OVERALL CCC FOR ONE METHOD WITH TWO OR MORE 		;
*					RATERS.  IF TWO RATERS ARE EVALUATED, THIS OPTION WILL PRODUCE	;
*					THE CCC, THE ASYMPTOTIC STANDARD ERROR, AND THE ASYMPTOTIC		;
*					CONFIDENCE INTERVAL (LIN, 1989).  A BOOTSTRAP CONFIDENCE 		;
*					INTERVAL IS OPTIONAL.  IF MORE THAN TWO RATERS ARE EVALUATED, 	;
*					THIS OPTION	WILL PRODUCE THE OVERALL CCC (BARNHART, 2002)		;
*					AND A BOOTSTRAP CONFIDENCE INTERVAL.							;
*																					;
*					2 = ESTIMATE OVERALL CCC FOR TWO METHODS WITH ONE OR MORE 		;
*					RATERS, SUCH AS FOR AN EXPERIMENTAL METHOD AND THE CURRENT 		;
*					GOLD STANDARD (WILLIAMSON, SUBMITTED).  THIS OPTION WILL 		;
*					PRODUCE THE CCC AND A BOOTSTRAP	CONFIDENCE INTERVAL.			;											;
*																					;
*					3 = TEST OF TWO OVERALL INDEPENDENT CCCs.  IF TWO RATERS ARE	;
*					EVALUATED FOR EACH GROUP, THIS OPTION WILL PRODUCE THE CCC 		;
*					FOR EACH GROUP OF SUBJECTS (LIN, 1989), THE DIFFERENCE IN CCCs, ;
*					AND THE ASYMPTOTIC STANDARD ERROR, CONFIDENCE INTERVAL, AND 	;
*					P-VALUE (NOT BASED ON THE Z-TRANSFORMATION).  A BOOTSTRAP 		;
*					CONFIDENCE INTERVAL IS OPTIONAL.  IF MORE THAN TWO RATERS ARE 	;
*					EVALUATED, THIS OPTION WILL PRODUCE	THE OVERALL CCC FOR EACH 	;
*					GROUP OF SUBJECTS (BARNHART, 2002), THE DIFFERENCE IN CCCs, 	;
*					AND A BOOTSTRAP CONFIDENCE INTERVAL.  							;
*																					;
*					4 = TEST OF TWO OVERALL DEPENDENT CCCs.  THIS OPTION WILL 		;
*					PRODUCE THE CCC FOR EACH GROUP, THE DIFFERENCE IN CCCs, AND 	;
*					A BOOTSTRAP CONFIDENCE INTERVAL.  IF TWO RATERS ARE SPECIFIED 	;
*					FOR EACH GROUP, THEN THE EQUATION BY LIN (1989) WILL BE APPLIED ;
*					WHILE IF MORE THAN TWO RATERS ARE SPECIFIED, BARNHART'S (2002) 	;
*					OVERALL CCC	WILL BE APPLIED.									;
*																					;
*					5 = TEST OF TWO OVERALL DEPENDENT CCCs, WHERE EACH OVERALL CCC	;
*					IS EVALUATING A METHOD OF INTEREST AND A METHOD OF COMPARISON	;
*					SUCH AS A GOLD STANDARD (WILLIAMSON, SUBMITTED). THIS OPTION 	;
*					WILL PRODUCE THE CCC FOR EACH METHOD/GOLD STANDARD COMPARISON, 	;
*					THE DIFFERENCE IN CCCs, AND A BOOTSTRAP CONFIDENCE INTERVAL.	;
*																					;
*				***NOTE: THE VALUE OF ANALYSIS WILL DETERMINE WHICH OF THE 			;
*				ADDITIONAL VARIABLES WILL BE NECESSARY.  THE NECESSARY 				;
*				VARIABLES FOR EACH TYPE OF ANALYSIS WILL BE DEFINED BELOW.			;
*																					;
*	DATASET1:		MAIN INPUT DATASET.												;
*																					;
*	DATASET2:		SECONDARY INPUT DATASET IF EVALUATING TWO INDEPENDENT CCCs.		;
*																					;
*	RATERS1:		STRING OF NAMES FOR THE VARIABLES REPRESENTING THE RATERS 		;
*					EVALUATING THE FIRST GROUP, SEPARATED BY A SPACE				;
*					EXAMPLE: RATERS1=rater1 rater2 rater3							;
*																					;
*	RATERS2:		STRING OF NAMES FOR THE VARIABLES REPRESENTING THE RATERS		;
*					EVALUATING THE SECOND GROUP, IF APPLICABLE, SEPARATED BY A 		;
*					SPACE.															;
*																					;
*	RATERS_GOLD:	STRING OF NAMES FOR THE VARIABLES REPRESENTING THE RATERS		;
*					EVALUATING THE COMPARISON, OR GOLD STANDARD METHOD, IF AN 		;
*					OVERALL CCC FOR A NEW METHOD AND A GOLD STANDARD IS INVOLVED 	;
*					IN THE COMPUTATIONS.											; 
*																					;
*	ALPHA:			TYPE I ERROR RATE. (1-ALPHA)*100% CONFIDENCE INTERVALS ARE 		;
*					GENERATED IN THE MACRO (DEFAULT=0.05).							;				;
*																					;
*	OUT:			NAME OF THE OUTPUT DATASET CONTAINING THE CCC RESULTS			;
*					(DEFAULT=WORK.OUTDATA).											;
*																					;
*	BOOTCI:			FOR ANALYSES WHERE THE BOOTSTRAP CONFIDENCE INTERVAL IS			;
*					OPTIONAL, INDICATES WHETHER OR NOT THE BOOTSTRAP CI WILL BE		;
*					GENERATED.  POSSIBLE VALUES: 'Y', 'N' (DEFAULT='N').			;
*																					;
*	BOOTSTRAP:		REQUESTS THE TYPE OF BOOTSTRAP CONFIDENCE INTERVAL DESIRED,		;
*					WHERE THE OPTIONS ARE THE PERCENTILE OR THE BcA INTERVALS.		;
*					POSSIBLE VALUES: 'P', 'B' (DEFAULT='B').						;
*																					;
*	BS:				NUMBER OF BOOTSTRAP SAMPLES (DEFAULT=2000).						;
*																					;
*	BOOT_SEED:		SEED FOR BOOTSTRAP CONFIDENCE INTERVALS (DEFAULT=CLOCK).		;
*																					;
*																					;
*	REQUIRED VARIABLES:																;
*   ------------------------------------------------------------------------------ 	;
*	ANALYSIS MUST ALWAYS BE SPECIFIED.												;
*																					;
*	IF ANALYSIS=1:																	;
*		 REQUIRED:		ANALYSIS, DATASET1, RATERS1									;
*		 OPTIONAL:		ALPHA, OUT, BOOTSTRAP, BOOT_SEED, BS, (BOOTCI)				;
*						**BOOTCI IS ONLY OPTIONAL IF THE VARIABLE RATERS1 			;
*						INDICATES THAT TWO RATERS ARE BEING EVALUATED.  OTHERWISE	;
*						IT WILL BE IGNORED.											;
*																					;
*	IF ANALYSIS=2:																	;
*		 REQUIRED:		ANALYSIS, DATASET1, RATERS1, RATERS_GOLD					;
*		 OPTIONAL:		ALPHA, OUT, BOOTSTRAP, BOOT_SEED, BS  						;
*																					;
*	IF ANALYSIS=3:																	;
*		 REQUIRED:		ANALYSIS, DATASET1, RATERS1, DATASET2, RATERS2				;
*		 OPTIONAL:		ALPHA, OUT, BOOTSTRAP, BOOT_SEED, BS, (BOOTCI) ;
*						**BOOTCI IS ONLY OPTIONAL IF THE VARIABLES RATERS1 AND		;
*						RATERS2 INDICATE THAT TWO RATERS ARE BEING EVALUATED.		;
*																					;
*	IF ANALYSIS=4:																	;
*		 REQUIRED:		ANALYSIS, DATASET1, RATERS1, RATERS2						;
*		 OPTIONAL:		ALPHA, OUT, BOOTSTRAP, BOOT_SEED, BS	  					;
*																					;
*	IF ANALYSIS=5:																	;
*		 REQUIRED:		ANALYSIS, DATASET1, RATERS1, RATERS2, RATERS_GOLD			;
*		 OPTIONAL:		ALPHA, OUT, BOOTSTRAP, BOOT_SEED, BS  						;
*																					;
*	**WARNING: ANY OTHER MACRO VARIABLES SPECIFIED WILL BE IGNORED.					;
*																					;
*	EXAMPLE CODE:																	;
*																					;
*   %include 'ccc macro V9.sas'														;
*																					;
*   %ccc(analysis=1, dataset1=inputdata, raters1=observer1 observer2 observer3, 	;
*    alpha=0.05, out=outputdata, bootci='Y', bootstrap='B', boot_seed=123, bs=2000)	;
*																					;
*   %ccc(analysis=2, dataset1=inputdata, raters1=method1rater1 method1rater2, 		;
*    raters_gold=goldrater1 goldrater2, alpha=0.05, out=outputdata, bootstrap='B',	;
*    boot_seed=123, bs=2000)														;
*																					;
*   %ccc(analysis=3, dataset1=inputdata1, raters1=observer1 observer2, 				;
*    dataset2=inputdata2, raters2=observer1 observer2, alpha=0.05, out=outputdata, 	;
*    bootci='Y', bootstrap='B', boot_seed=123, bs=2000)								;
*																					;
*   %ccc(analysis=4, dataset1=inputdata1, raters1=meth1rater1 meth1rater2, 			;
*    raters2=meth2rater1 meth2rater2, alpha=0.05, out=outputdata, bootstrap='B', 	;
*    boot_seed=789, bs=2000)														;
*																					;
*   %ccc(analysis=5, dataset1=inputdata1, raters1=meth1rater1 meth1rater2, 			;
*	 raters2=meth2rater1 meth2rater2, raters_gold=goldrater1 goldrater2, 			;
*	 alpha=0.05, out=outputdata, bootstrap='B', boot_seed=789, bs=2000)  			;
*																					;
************************************************************************************;



************************************************************************************;
************CCC for 1 method and two raters using equations from Lin****************;
************************************************************************************;
%macro overall_two(vec=);

  n=nrow(&vec);
  mult=1/n;

  mean1=j(1,n,mult) * &vec[,1];
  mean2=j(1,n,mult) * &vec[,2];
  ssq1=mult * t(&vec[,1]-j(n,1,mean1)) * (&vec[,1]-j(n,1,mean1));
  ssq2=mult * t(&vec[,2]-j(n,1,mean2)) * (&vec[,2]-j(n,1,mean2));
  s1s2=mult * t(&vec[,1]-j(n,1,mean1)) * (&vec[,2]-j(n,1,mean2));

  %if &vec=temp %then %do;
    CCC=(2*s1s2)/(ssq1 + ssq2 + ((mean1 - mean2)**2));
  
    vhat=sqrt(ssq1) / sqrt(ssq2);
    uhat=(mean1 - mean2)/(sqrt( (sqrt(ssq1))*(sqrt(ssq2)) ));
    Cb=1/( (vhat + (1/vhat) + (uhat**2))/2 );
    pearson=CCC/Cb;

    SE = sqrt( (1/(n-2)) * ( ((1-(pearson**2))*(ccc**2)*(1-(ccc**2))/(pearson**2)) + 
      (2*(ccc**3)*(1-ccc)*(uhat**2)/pearson) - ((ccc**4)*(uhat**4)/(2*(pearson**2))) ) );
    zhat=0.5*log((1+ccc)/(1-ccc));
    var_zhat=(1/(n-2)) * ( (((1-(pearson**2))*(ccc**2))/((1-(ccc**2))*(pearson**2))) + 
      ((2*(ccc**3)*(1-ccc)*(uhat**2))/(pearson*((1-(ccc**2))**2))) - 
      (((ccc**4)*(uhat**4))/(2*(pearson**2)*((1-ccc**2)**2))) );
    lcltemp=zhat-(probit(1-&alpha/2))*sqrt(var_zhat);
    ucltemp=zhat+(probit(1-&alpha/2))*sqrt(var_zhat);
    LCL=tanh(lcltemp);
    UCL=tanh(ucltemp);
  %end;
  %if &vec=boot %then %do;
    CCC_boot=(2*s1s2)/(ssq1 + ssq2 + ((mean1 - mean2)**2));
  %end;
  %if &vec=jack %then %do;
    CCC_jack=(2*s1s2)/(ssq1 + ssq2 + ((mean1 - mean2)**2));
  %end;

%mend;


************************************************************************************;
*******CCC for 1 method and multiple raters using equations from Barnhart***********;
************************************************************************************;

%macro overall_mult(vec=);

  n=nrow(&vec);
  mult=1/n;

  %do u=1 %to &j;
    mean=j(1,n,mult) * &vec[,&u];
	ssq=mult * t(&vec[,&u]-j(n,1,mean)) * (&vec[,&u]-j(n,1,mean));

	if &u=1 then denom1=ssq;
	else denom1=denom1 + ssq;

    if &u^=&j then do;
	  %let v=%eval(&u+1);
	end;
	%do w=&v %to &j;
	  mean1=j(1,n,mult) * &vec[,&u];
	  mean2=j(1,n,mult) * &vec[,&w];
      s1s2=mult * t(&vec[,&u]-j(n,1,mean1)) * (&vec[,&w]-j(n,1,mean2));
	  if &u=1 & &w=&v then do;
	    numer=s1s2;
	    denom2=((mean1-mean2)**2);
	  end;
	  else if &u^=&j then do;
	    numer=numer + s1s2;
	    denom2=denom2 + ((mean1 - mean2)**2);
	  end;
	%end;
  %end;

  %if (&vec=temp | &vec=temp1 | &vec=temp2) %then %do;
    CCC = (2*numer) / (((&j-1)*denom1) + denom2);
  %end;
  %if (&vec=boot | &vec=boot1 | &vec=boot2) %then %do;
    CCC_boot = (2*numer) / (((&j-1)*denom1) + denom2);
  %end;
  %if (&vec=jack | &vec=jack1 | &vec=jack2) %then %do;
    CCC_jack = (2*numer) / (((&j-1)*denom1) + denom2);
  %end;

%mend;


************************************************************************************;
*******CCC for 2 methods and multiple raters using equations from CCC paper*********;
************************************************************************************;

%macro two_methods(vec1=,vec2=);

  n=nrow(&vec1);
  mult=1/n;

  %do u=1 %to &j;
	mean1=j(1,n,mult) * &vec1[,&u];
	mean2=j(1,n,mult) * &vec2[,&u];
	ssq1=mult * t(&vec1[,&u]-j(n,1,mean1)) * (&vec1[,&u]-j(n,1,mean1));
	ssq2=mult * t(&vec2[,&u]-j(n,1,mean2)) * (&vec2[,&u]-j(n,1,mean2));
    s1s2=mult * t(&vec1[,&u]-j(n,1,mean1)) * (&vec2[,&u]-j(n,1,mean2));
    if &u=1 then do;
	  num=s1s2;
	  den1=ssq1 + ssq2;
	  den2=(mean1-mean2)**2;
	end;
	else do;
	  num=num+s1s2;
	  den1=den1 + (ssq1 + ssq2);
	  den2=den2 + ((mean1-mean2)**2);
	end;
  %end;

  %if &vec1=temp1 | &vec1=temp2 %then %do;
    CCC = (2*num)/(den1+den2);
  %end;
  %if &vec1=boot1 | &vec1=boot2 %then %do;
    CCC_boot = (2*num)/(den1+den2);
  %end;
  %if &vec1=jack1 | &vec1=jack2 %then %do;
    CCC_jack = (2*num)/(den1+den2);
  %end;

%mend;


************************************************************************************;
***********Test Diff of independent CCCs for one method with two raters*************;
************************************************************************************;

%macro test_indep_two(vec1=,vec2=);

  %do z=1 %to 2;
    n&z=nrow(&&vec&z);
    mult&z=1/n&z;

    mean1_&z=j(1,n&z,mult&z) * &&vec&z[,1];
    mean2_&z=j(1,n&z,mult&z) * &&vec&z[,2];
    ssq1_&z=mult&z * t(&&vec&z[,1]-j(n&z,1,mean1_&z)) * (&&vec&z[,1]-j(n&z,1,mean1_&z));
    ssq2_&z=mult&z * t(&&vec&z[,2]-j(n&z,1,mean2_&z)) * (&&vec&z[,2]-j(n&z,1,mean2_&z));
    s1s2_&z=mult&z * t(&&vec&z[,1]-j(n&z,1,mean1_&z)) * (&&vec&z[,2]-j(n&z,1,mean2_&z));

    CCC&z=(2*s1s2_&z)/(ssq1_&z + ssq2_&z + ((mean1_&z - mean2_&z)**2));

	%if &vec1=temp1 %then %do;
      vhat&z=sqrt(ssq1_&z) / sqrt(ssq2_&z);
      uhat&z=(mean1_&z - mean2_&z)/(sqrt( (sqrt(ssq1_&z))*(sqrt(ssq2_&z)) ));
      Cb&z=1/( (vhat&z + (1/vhat&z) + (uhat&z**2))/2 );
      pearson&z=CCC&z/Cb&z;

      SE&z = sqrt( (1/(n&z-2)) * ( ((1-(pearson&z**2))*(ccc&z**2)*(1-(ccc&z**2))/(pearson&z**2)) + 
      (2*(ccc&z**3)*(1-ccc&z)*(uhat&z**2)/pearson&z) - ((ccc&z**4)*(uhat&z**4)/(2*(pearson&z**2))) ) );
      zhat&z=0.5*log((1+ccc&z)/(1-ccc&z));
      var_zhat&z=(1/(n&z-2)) * ( (((1-(pearson&z**2))*(ccc&z**2))/((1-(ccc&z**2))*(pearson&z**2))) + 
        ((2*(ccc&z**3)*(1-ccc&z)*(uhat&z**2))/(pearson&z*((1-(ccc&z**2))**2))) - 
        (((ccc&z**4)*(uhat&z**4))/(2*(pearson&z**2)*((1-ccc&z**2)**2))) );
	%end;
  %end;

  %if &vec1=temp1 %then %do;
    CCC_1=CCC1;
	CCC_2=CCC2;
    CCC_diff=CCC1-CCC2;
    VAR_diff=SE1**2 + SE2**2;
	SE_diff=sqrt(VAR_diff);
    test=abs(CCC_diff/sqrt(VAR_diff));
    pvalue=2*(1-probnorm(test));
    lcl=CCC_diff-(probit(1-&alpha/2))*sqrt(var_diff);
	if lcl < -2 then lcl=-2;
    ucl=CCC_diff+(probit(1-&alpha/2))*sqrt(var_diff);
	if ucl > 2 then ucl=2;
  %end;
  %if &vec1=boot1 %then %do;
    CCC_diff_boot=CCC1-CCC2;
  %end;
  %if &vec1=jack1 %then %do;
    CCC_diff_jack=CCC1-CCC2;
  %end;

%mend;


************************************************************************************;
***********Test Diff of independent CCCs for one method with mult raters************;
************************************************************************************;

%macro test_indep_mult(vec1=,vec2=);

  %do z=1 %to 2;
    n&z=nrow(&&vec&z);
    mult&z=1/n&z;

	%if &z=1 %then %let end=%eval(&j+0);
	%if &z=2 %then %let end=%eval(&d+0);

    %do u=1 %to &end;
      mean_&z=j(1,n&z,mult&z) * &&vec&z[,&u];
	  ssq_&z=mult&z * t(&&vec&z[,&u]-j(n&z,1,mean_&z)) * (&&vec&z[,&u]-j(n&z,1,mean_&z));

	  if &u=1 then denom1&z=ssq_&z;
	  else denom1&z=denom1&z + ssq_&z;

      if &u^=&end then do;
	    %let v=%eval(&u+1);
	  end;
	  %do w=&v %to &end;
	    mean1_&z=j(1,n&z,mult&z) * &&vec&z[,&u];
	    mean2_&z=j(1,n&z,mult&z) * &&vec&z[,&w];
        s1s2_&z=mult&z * t(&&vec&z[,&u]-j(n&z,1,mean1_&z)) * (&&vec&z[,&w]-j(n&z,1,mean2_&z));
	    if &u=1 & &w=&v then do;
	      numer&z=s1s2_&z;
	      denom2&z=((mean1_&z-mean2_&z)**2);
	    end;
	    else if &u^=&end then do;
	      numer&z=numer&z + s1s2_&z;
	      denom2&z=denom2&z + ((mean1_&z - mean2_&z)**2);
	    end;
	  %end;
    %end;

    CCC&z = (2*numer&z) / (((&end-1)*denom1&z) + denom2&z);
  %end;

  %if &vec1=temp1 %then %do;
    CCC_1=CCC1;
	CCC_2=CCC2;
    CCC_diff=CCC1-CCC2;
  %end;
  %if &vec1=boot1 %then %do;
    CCC_diff_boot=CCC1-CCC2;
  %end;
  %if &vec1=jack1 %then %do;
    CCC_diff_jack=CCC1-CCC2;
  %end;

%mend;


************************************************************************************;
*************Test Diff of dependent CCCs for one method with mult raters************;
************************************************************************************;

%macro test_dep(vector1=,vector2=);

  %let j=&j1;
  %overall_mult(vec=&vector1);
  %if &vector1=temp1 %then %do;
    CCC1=CCC;
  %end;
  %if &vector1=boot1 %then %do;
    CCC1=CCC_boot;
  %end;
  %if &vector1=jack1 %then %do;
    CCC1=CCC_jack;
  %end;
  %let j=&j2;
  %overall_mult(vec=&vector2);
  %if &vector2=temp2 %then %do;
    CCC2=CCC;
  %end;
  %if &vector2=boot2 %then %do;
    CCC2=CCC_boot;
  %end;
  %if &vector2=jack2 %then %do;
    CCC2=CCC_jack;
  %end;

  %if &vector1=temp1 %then %do;
    CCC_1=CCC1;
	CCC_2=CCC2;
    CCC_diff=CCC1-CCC2;
  %end;
  %if &vector1=boot1 %then %do;
    CCC_diff_boot=CCC1-CCC2;
  %end;
  %if &vector1=jack1 %then %do;
    CCC_diff_jack=CCC1-CCC2;
  %end;

%mend;


************************************************************************************;
*************Test Diff of dependent CCCs for two methods with mult raters***********;
************************************************************************************;

%macro test_dep_two(vector1=,vector2=,vector3=);

  %two_methods(vec1=&vector1,vec2=&vector3);
  %if &vector1=temp1 %then %do;
    CCC1=CCC;
  %end;
  %if &vector1=boot1 %then %do;
    CCC1=CCC_boot;
  %end;
  %if &vector1=jack1 %then %do;
    CCC1=CCC_jack;
  %end;
 %two_methods(vec1=&vector2,vec2=&vector3);
  %if &vector2=temp2 %then %do;
    CCC2=CCC;
  %end;
  %if &vector2=boot2 %then %do;
    CCC2=CCC_boot;
  %end;
  %if &vector2=jack2 %then %do;
    CCC2=CCC_jack;
  %end;

  %if &vector1=temp1 %then %do;
    CCC_1=CCC1;
	CCC_2=CCC2;
    CCC_diff=CCC1-CCC2;
  %end;
  %if &vector1=boot1 %then %do;
    CCC_diff_boot=CCC1-CCC2;
  %end;
  %if &vector1=jack1 %then %do;
    CCC_diff_jack=CCC1-CCC2;
  %end;

%mend;


************************************************************************************;
*********************Percentile Bootstrap Confidence Interval***********************;
************************************************************************************;

%macro percentile_boot();

  %do i=1 %to &bs;

    %if &analysis=1 %then %do;
      do m=1 to n;
	    *generates a random number from 1 to n1-1 and then truncates in order to produce
	    integers from 1 to n1;
	    rannum=uniform(&boot_seed);
	    x=int((rannum*(n))+1);
	    if m=1 then do;
          boot=temp[x,]; 
	    end;
	    else do;
	      boot=boot//temp[x,]; 
	    end;
	  end;
	  %if &j=2 %then %do;
	    %overall_two(vec=boot);
	  %end;
	  %if &j>2 %then %do;
	    %overall_mult(vec=boot);
	  %end;
	  if &i=1 then ccc_bootstrap=ccc_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_boot;
	%end;

	%if &analysis=2 %then %do;
      do m=1 to n;
	    *generates a random number from 1 to n1-1 and then truncates in order to produce
	    integers from 1 to n1;
	    rannum=uniform(&boot_seed);
	    x=int((rannum*(n))+1);
	    if m=1 then do;
          boot1=temp1[x,];
          boot2=temp2[x,]; 
	    end;
	    else do;
	      boot1=boot1//temp1[x,];
          boot2=boot2//temp2[x,]; 
	    end;
	  end;
	  %two_methods(vec1=boot1,vec2=boot2);
	  if &i=1 then ccc_bootstrap=ccc_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_boot;
	%end;

    %if &analysis=3 %then %do;
      do m=1 to n1;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n1))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
	    end;
	  end;
      do m=1 to n2;
	    rannum2=uniform(&boot_seed);
	    x2=int((rannum2*(n2))+1);
	    if m=1 then do;
          boot2=temp2[x2,]; 
	    end;
	    else do;
	      boot2=boot2//temp2[x2,]; 
	    end;
	  end;
	  %if &j=2 & &d=2 %then %do;
	    %test_indep_two(vec1=boot1,vec2=boot2);
	  %end;
	  %else %do;
	    %test_indep_mult(vec1=boot1,vec2=boot2);
	  %end;
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

	%if &analysis=4 %then %do;
      do m=1 to n;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
		  boot2=temp2[x1,];
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
		  boot2=boot2//temp2[x1,];
	    end;
	  end;
      %test_dep(vector1=boot1,vector2=boot2);
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

    %if &analysis=5 %then %do;
      do m=1 to n;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
		  boot2=temp2[x1,];
		  boot3=temp3[x1,];
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
		  boot2=boot2//temp2[x1,];
		  boot3=boot3//temp3[x1,];
	    end;
	  end;
      %test_dep_two(vector1=boot1,vector2=boot2,vector3=boot3);
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

  %end;

  call sort (ccc_bootstrap,{1});
  *calculate the percentiles using a weighted average;
  lower=&alpha/2*&bs;
  lower_int=int(lower);
  lower_frac=lower-lower_int;
  lower_p1=lower_int + 1;
  upper=(1-&alpha/2)*&bs + 1;
  upper_int=int(upper);
  upper_frac=upper-upper_int;
  upper_p1=upper_int + 1;
  Bootstrap_LCL=(1-lower_frac)*ccc_bootstrap[lower_int,] + lower_frac*ccc_bootstrap[lower_p1,];
  Bootstrap_UCL=(1-upper_frac)*ccc_bootstrap[upper_int,] + upper_frac*ccc_bootstrap[upper_p1,];

%mend;


************************************************************************************;
***************************BCa Bootstrap Confidence Interval************************;
************************************************************************************;

%macro bca_boot();

  %do i=1 %to &bs;

    %if &analysis=1 %then %do;
      do m=1 to n;
	    *generates a random number from 1 to n1+1 and then truncates in order to produce
	    integers from 1 to n1;
	    rannum=uniform(&boot_seed);
	    x=int((rannum*(n))+1);
	    if m=1 then do;
          boot=temp[x,]; 
	    end;
	    else do;
	      boot=boot//temp[x,]; 
	    end;
	  end;
	  %if &j=2 %then %do;
*	    %overall_two_boot();
	    %overall_two(vec=boot);
	  %end;
	  %if &j>2 %then %do;
	    %overall_mult(vec=boot);
	  %end;
	  if &i=1 then ccc_bootstrap=ccc_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_boot;
	%end;

	%if &analysis=2 %then %do;
      do m=1 to n;
	    *generates a random number from 1 to n1-1 and then truncates in order to produce
	    integers from 1 to n1;
	    rannum=uniform(&boot_seed);
	    x=int((rannum*(n))+1);
	    if m=1 then do;
          boot1=temp1[x,];
          boot2=temp2[x,]; 
	    end;
	    else do;
	      boot1=boot1//temp1[x,];
          boot2=boot2//temp2[x,]; 
	    end;
	  end;
	  %two_methods(vec1=boot1,vec2=boot2);
	  if &i=1 then ccc_bootstrap=ccc_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_boot;
	%end;

    %if &analysis=3 %then %do;
      do m=1 to n1;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n1))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
	    end;
	  end;
      do m=1 to n2;
	    rannum2=uniform(&boot_seed);
	    x2=int((rannum2*(n2))+1);
	    if m=1 then do;
          boot2=temp2[x2,]; 
	    end;
	    else do;
	      boot2=boot2//temp2[x2,]; 
	    end;
	  end;
	  %if &j=2 & &d=2 %then %do;
	    %test_indep_two(vec1=boot1,vec2=boot2);
	  %end;
	  %else %do;
	    %test_indep_mult(vec1=boot1,vec2=boot2);
	  %end;
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

	%if &analysis=4 %then %do;
      do m=1 to n;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
		  boot2=temp2[x1,];
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
		  boot2=boot2//temp2[x1,];
	    end;
	  end;
      %test_dep(vector1=boot1,vector2=boot2);
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

    %if &analysis=5 %then %do;
      do m=1 to n;
		rannum1=uniform(&boot_seed);
		x1=int((rannum1*(n))+1);
	    if m=1 then do;
          boot1=temp1[x1,]; 
		  boot2=temp2[x1,];
		  boot3=temp3[x1,];
	    end;
	    else do;
	      boot1=boot1//temp1[x1,]; 
		  boot2=boot2//temp2[x1,];
		  boot3=boot3//temp3[x1,];
	    end;
	  end;
      %test_dep_two(vector1=boot1,vector2=boot2,vector3=boot3);
	  if &i=1 then ccc_bootstrap=ccc_diff_boot;
	  else ccc_bootstrap=ccc_bootstrap//ccc_diff_boot;
	%end;

  %end;

  *jackknife;
  %if &analysis=1 %then %do;
    nstar=nrow(temp);
	multstar=1/nstar;
    do m=1 to nstar;
      if m=1 then do;
        jack=temp[2:nstar,];
      end;
      else if m < nstar then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack1=temp[1:mm1,];
	    jack2=temp[mp1:nstar,];
	    jack=jack1//jack2;
	  end;
	  else if m=nstar then do;
	    mm1=m-1;
	    jack=temp[1:mm1,];
	  end;
      %if &j=2 %then %do;
	    %overall_two(vec=jack);
	  %end;
      %if &j>2 %then %do;
	    %overall_mult(vec=jack);
	  %end;
      if m=1 then CCC_jackknife = CCC_jack;
	  else CCC_jackknife=CCC_jackknife // CCC_jack;
	end;
  %end;

  %if &analysis=2 %then %do;
    nstar=nrow(temp1);
	multstar=1/nstar;
    do m=1 to nstar;
      if m=1 then do;
        jack1=temp1[2:nstar,];
   	    jack2=temp2[2:nstar,];
	  end;
	  else if m < nstar then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack1_1=temp1[1:mm1,];
	    jack1_2=temp1[mp1:nstar,];
	    jack2_1=temp2[1:mm1,];
	    jack2_2=temp2[mp1:nstar,];
	    jack1=jack1_1//jack1_2;
	    jack2=jack2_1//jack2_2;
	  end;
	  else if m=nstar then do;
	    mm1=m-1;
	    jack1=temp1[1:mm1,];
	    jack2=temp2[1:mm1,];
	  end;
	  %two_methods(vec1=jack1,vec2=jack2);
      if m=1 then CCC_jackknife = CCC_jack;
	  else CCC_jackknife=CCC_jackknife // CCC_jack;
	end;
  %end;

  %if &analysis=3 %then %do;
    n1star=nrow(temp1);
	n2star=nrow(temp2);
	nstar=n1star+n2star;
	multstar=1/nstar;
    do m=1 to n1star;
      if m=1 then do;
        jack1=temp1[2:n1star,];
	  end;
	  else if m < n1star then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack1_1=temp1[1:mm1,];
	    jack1_2=temp1[mp1:n1star,];
	    jack1=jack1_1//jack1_2;
	  end;
	  else if m=n1star then do;
	    mm1=m-1;
	    jack1=temp1[1:mm1,];
	  end;
	  jack2=temp2;
	  %if &j=2 & &d=2 %then %do;
	    %test_indep_two(vec1=jack1,vec2=jack2);
	  %end;
	  %else %do;
	    %test_indep_mult(vec1=jack1,vec2=jack2);
	  %end;
	  if m=1 then CCC_jackknife = CCC_diff_jack;
	  else CCC_jackknife = CCC_jackknife // CCC_diff_jack;
	end;
    do m=1 to n2star;
      if m=1 then do;
        jack2=temp2[2:n2star,];
	  end;
	  else if m < n2star then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack2_1=temp2[1:mm1,];
	    jack2_2=temp2[mp1:n2star,];
	    jack2=jack2_1//jack2_2;
	  end;
	  else if m=n2star then do;
	    mm1=m-1;
	    jack2=temp2[1:mm1,];
	  end;
	  jack1=temp1;
	  %if &j=2 & &d=2 %then %do;
	    %test_indep_two(vec1=jack1,vec2=jack2);
	  %end;
	  %else %do;
	    %test_indep_mult(vec1=jack1,vec2=jack2);
	  %end;
	  CCC_jackknife = CCC_jackknife // CCC_diff_jack;
	end;
  %end;

  %if &analysis=4 %then %do;
    nstar=nrow(temp1);
	multstar=1/nstar;
    do m=1 to nstar;
      if m=1 then do;
        jack1=temp1[2:nstar,];
   	    jack2=temp2[2:nstar,];
	  end;
	  else if m < nstar then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack1_1=temp1[1:mm1,];
	    jack1_2=temp1[mp1:nstar,];
	    jack2_1=temp2[1:mm1,];
	    jack2_2=temp2[mp1:nstar,];
	    jack1=jack1_1//jack1_2;
	    jack2=jack2_1//jack2_2;
	  end;
	  else if m=nstar then do;
	    mm1=m-1;
	    jack1=temp1[1:mm1,];
	    jack2=temp2[1:mm1,];
	  end;
      %test_dep(vector1=jack1,vector2=jack2);
      if m=1 then CCC_jackknife = CCC_diff_jack;
	  else CCC_jackknife=CCC_jackknife // CCC_diff_jack;
	end;
  %end;

  %if &analysis=5 %then %do;
    nstar=nrow(temp1);
	multstar=1/nstar;
    do m=1 to nstar;
      if m=1 then do;
        jack1=temp1[2:nstar,];
   	    jack2=temp2[2:nstar,];
		jack3=temp3[2:nstar,];
	  end;
	  else if m < nstar then do;
	    mp1=m+1;
	    mm1=m-1;
	    jack1_1=temp1[1:mm1,];
	    jack1_2=temp1[mp1:nstar,];
	    jack2_1=temp2[1:mm1,];
	    jack2_2=temp2[mp1:nstar,];
		jack3_1=temp3[1:mm1,];
		jack3_2=temp3[mp1:nstar,];
	    jack1=jack1_1//jack1_2;
	    jack2=jack2_1//jack2_2;
		jack3=jack3_1//jack3_2;
	  end;
	  else if m=nstar then do;
	    mm1=m-1;
	    jack1=temp1[1:mm1,];
	    jack2=temp2[1:mm1,];
		jack3=temp3[1:mm1,];
	  end;
      %test_dep_two(vector1=jack1,vector2=jack2,vector3=jack3);
      if m=1 then CCC_jackknife = CCC_diff_jack;
	  else CCC_jackknife=CCC_jackknife // CCC_diff_jack;
	end;
  %end;

  mean_CCC=j(1,nstar,multstar) * CCC_jackknife;
  mean_vec=j(nstar,1,mean_CCC);
  diff_cubed=(mean_vec - CCC_jackknife)##3;
  diff_sq=(mean_vec - CCC_jackknife)##2;
  num_jack=j(1,nstar,1) * diff_cubed;
  den_jack=j(1,nstar,1) * diff_sq;
  a_hat=num_jack/(6*((den_jack)**(3/2)));

  call sort (ccc_bootstrap,{1});
  %if &analysis=1 | &analysis=2 %then %do;
	ind_boot=ccc_bootstrap<ccc;
  %end;
  %if &analysis=3 | &analysis=4 | &analysis=5 %then %do;
    ind_boot=ccc_bootstrap<ccc_diff;
  %end;
  sum_boot=sum(ind_boot);
  zhat_0=probit(sum_boot/&bs);

  z_alpha=probit(&alpha/2);
  z_1m_alpha=probit(1-&alpha/2);

  alpha1=probnorm(zhat_0 + ( (zhat_0 + z_alpha)/(1 - (a_hat*(zhat_0 + z_alpha))) ));
  alpha2=probnorm(zhat_0 + ( (zhat_0 + z_1m_alpha)/(1 - (a_hat*(zhat_0 + z_1m_alpha))) ));

  *calculate the percentiles using a weighted average;
  lower=(alpha1)*&bs;
  lower_int=int(lower);
  lower_frac=lower-lower_int;
  lower_p1=lower_int + 1;
  upper=(alpha2)*&bs + 1;
  upper_int=int(upper);
  upper_frac=upper-upper_int;
  upper_p1=upper_int + 1;
  Bootstrap_LCL=(1-lower_frac)*ccc_bootstrap[lower_int,] + lower_frac*ccc_bootstrap[lower_p1,];
  Bootstrap_UCL=(1-upper_frac)*ccc_bootstrap[upper_int,] + upper_frac*ccc_bootstrap[upper_p1,];

%mend;


************************************************************************************;
*************************************Final Macro************************************;
************************************************************************************;

%macro ccc(analysis=.,dataset1=' ',dataset2=' ',raters1=' ',raters2=' ',raters_gold=' ',
alpha=0.05,bootCI='N',bootstrap='B',boot_seed=0,bs=2000,out=outdata);

%if &analysis=. %then %do;
  proc iml;
    print,"WARNING: NEED TO SPECIFY THE TYPE OF ANALYSIS","PROGRAM WILL TERMINATE",;
  quit;
%end;

%if &analysis=1 %then %do;

  %if &dataset1=' ' | &raters1=' ' %then %do;
    proc iml;
      print,"WARNING: NEED TO SPECIFY DATASET1 AND RATERS1","PROGRAM WILL TERMINATE",;
	quit;
  %end;
  %else %do;

    data dataset1;
	  set &dataset1;
	run;

    proc iml;

      use dataset1;
	  read all var{&raters1} into ratername;
	  j=ncol(ratername);
	  call symput('j',left(char(j)));

	  %do u=1 %to &j;
        %let rater&u = %scan(&raters1,&u,%str( ));
	    edit dataset1;
	    delete all where (&&rater&u=.);
        purge;
      %end;

      use dataset1;
	  read all var{&raters1} into temp;

	  %if &j=2 %then %do;
        %overall_two(vec=temp);

	    %if &bootCI='N' | &bootCI='n' | &bootCI='NO' | &bootCI='No' | &bootCI='no' %then %do;
          percent=(1-&alpha)*100;
          percent=char(percent,4,1);
          phrase0={"One Method with Two Raters"};
          phrase1={"Concordance Correlation Coefficient and SE, (Lin, 1989)"};
          phrase2={"% Asymptotic Confidence Interval, Z-transformation"};
          phrase3=concat(percent,phrase2);

		  N=nrow(temp);
          R=ncol(temp);
          reset center spaces=3 fw=6 noname;
          print,phrase0,phrase1,phrase3,;
          reset center spaces=3 fw=6 name;
          print,N R CCC SE LCL UCL;

		  results=N||R||CCC||SE||LCL||UCL;
		  col={N R CCC SE Asymp_LCL Asymp_UCL};
		  create &out from results[colname=col];
		  append from results;
        %end;
	    %if &bootCI='Y' | &bootCI='y' | &bootCI='YES' | &bootCI='Yes' | &bootCI='yes' %then %do;
		  %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' |
            &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	        %percentile_boot();
            percent=(1-&alpha)*100;
            percent=char(percent,4,1);
            phrase0={"One Method with Two Raters"};
            phrase1={"Concordance Correlation Coefficient and SE (Lin, 1989)"};
            phrase2={"% Asymptotic Confidence Interval, Z-transformation"};
            phrase4={"% Percentile Bootstrap Confidence Interval"};
            phrase3=concat(percent,phrase2);
			phrase5=concat(percent,phrase4);
		  %end;
		  %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='Bca' |
            &bootstrap='BCa' | &bootstrap='bca' %then %do;
	        %bca_boot();
            percent=(1-&alpha)*100;
            percent=char(percent,4,1);
            phrase0={"One Method with Two Raters"};
            phrase1={"Concordance Correlation Coefficient and SE (Lin, 1989)"};
            phrase2={"% Asymptotic Confidence Interval, Z-transformation"};
            phrase4={"% BCa Bootstrap Confidence Interval"};
            phrase3=concat(percent,phrase2);
			phrase5=concat(percent,phrase4);
		  %end;

		  N=nrow(temp);
          R=ncol(temp);
		  BS=&bs;
          reset center spaces=3 fw=6 noname;
          print,phrase0,phrase1,phrase3,phrase5,;
          reset center spaces=3 fw=6 name;
          print,N R CCC SE LCL UCL;
          print,BS Bootstrap_LCL Bootstrap_UCL;

		  results=N||R||CCC||SE||LCL||UCL||BS||Bootstrap_LCL||Bootstrap_UCL;
		  col={N R CCC SE Asymp_LCL Asymp_UCL BS Boot_LCL Boot_UCL};
		  create &out from results[colname=col];
		  append from results;
        %end;

	  %end;
	  %if &j>2 %then %do;
	    %overall_mult(vec=temp);

		%if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' |
          &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	      %percentile_boot();
          percent=(1-&alpha)*100;
          percent=char(percent,4,1);
          phrase0={"One Method with Multiple Raters"};
          phrase1={"Overall Concordance Correlation Coefficient (Barnhart, 2002)"};
          phrase2={"% Percentile Bootstrap Confidence Interval"};
          phrase3=concat(percent,phrase2);
        %end;
		%if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='Bca' |
          &bootstrap='BCa' | &bootstrap='bca' %then %do;
	      %bca_boot();
          percent=(1-&alpha)*100;
          percent=char(percent,4,1);
          phrase0={"One Method with Multiple Raters"};
          phrase1={"Overall Concordance Correlation Coefficient (Barnhart, 2002)"};
          phrase2={"% BCa Bootstrap Confidence Interval"};
          phrase3=concat(percent,phrase2);
        %end;

		N=nrow(temp);
        R=ncol(temp);
		BS=&bs;
        reset center spaces=3 fw=6 noname;
        print,phrase0,phrase1,phrase3,;
        reset center spaces=3 fw=6 name;
        print,N R CCC BS Bootstrap_LCL Bootstrap_UCL;

		results=N||R||CCC||BS||Bootstrap_LCL||Bootstrap_UCL;
		col={N R CCC BS Boot_LCL Boot_UCL};
		create &out from results[colname=col];
		append from results;

	  %end;

	quit;
  %end;
%end;
	  
%if &analysis=2 %then %do;

  %if &dataset1=' ' | &raters1=' ' | &raters_gold=' ' %then %do;
    proc iml;
      print,"WARNING: NEED TO SPECIFY DATASET1, RATERS1, AND RATERS_GOLD","PROGRAM WILL TERMINATE",;
	quit;
  %end;
  %else %do;

    data dataset1;
	  set &dataset1;
	run;

    proc iml;

      use dataset1;
	  read all var{&raters1} into ratername1;
	  j=ncol(ratername1);
	  call symput ('j',left(char(j)));
	  read all var{&raters_gold} into ratername2;
	  d=ncol(ratername2);
	  call symput ('d',left(char(d)));

	  %if &j=1 %then %do;
	    print,"WARNING: ONLY ONE RATER IS SPECIFIED, USE ANALYSIS=1","PROGRAM WILL TERMINATE",;
      %end;

	  %if &j^=&d %then %do;
	    print,"WARNING: THE NUMBER OF RATERS ASSESSING THE TWO METHODS ARE NOT EQUAL","THE PROGRAM WILL TERMINATE",;
	  %end;

	  %if &j=&d & &j>1 %then %do;

	  %do u=1 %to &j;
        %let rater1&u = %scan(&raters1,&u,%str( ));
		%let rater2&u = %scan(&raters_gold,&u,%str( ));
	    edit dataset1;
	    delete all where (&&rater1&u=. | &&rater2&u=.);
        purge;
      %end;

      use dataset1;
      read all var{&raters1} into temp1;
      read all var{&raters_gold} into temp2;

	  %two_methods(vec1=temp1,vec2=temp2);

      %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' |
        &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	    %percentile_boot();
        percent=(1-&alpha)*100;
        percent=char(percent,4,1);
        phrase0={"Experimental Method and Gold Standard with Two or More Raters"};
        phrase1={"Overall Concordance Correlation Coefficient (Williamson, accepted)"};
        phrase2={"% Percentile Bootstrap Confidence Interval"};
        phrase3=concat(percent,phrase2);
      %end;
      %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='Bca' |
        &bootstrap='BCa' | &bootstrap='bca' %then %do;
	    %bca_boot();
        percent=(1-&alpha)*100;
        percent=char(percent,4,1);
        phrase0={"Experimental Method and Gold Standard with Two or More Raters"};
        phrase1={"Overall Concordance Correlation Coefficient (Williamson, accepted)"};
        phrase2={"% BCa Bootstrap Confidence Interval"};
        phrase3=concat(percent,phrase2);
      %end;

	  N=nrow(temp1);
      R=ncol(temp1);
	  BS=&bs;
      reset center spaces=3 fw=6 noname;
      print,phrase0,phrase1,phrase3,;
      reset center spaces=3 fw=6 name;
      print,N R CCC BS Bootstrap_LCL Bootstrap_UCL;

	  results=N||R||CCC||BS||Bootstrap_LCL||Bootstrap_UCL;
	  col={N R CCC BS Boot_LCL Boot_UCL};
	  create &out from results[colname=col];
	  append from results;

	  %end;

    quit;
  %end;
%end;

%if &analysis=3 %then %do;

  %if &dataset1=' ' | &raters1=' ' | &dataset2=' ' | &raters2=' ' %then %do;
    proc iml;
      print,"WARNING: NEED TO SPECIFY DATASET1, RATERS1, DATASET2, AND RATERS2","PROGRAM WILL TERMINATE",;
    quit;
  %end;
  %else %do;

    data dataset1;
	  set &dataset1;
	run;
	data dataset2;
	  set &dataset2;
	run;

    proc iml;

      use dataset1;
	  read all var{&raters1} into ratername1;
	  j=ncol(ratername1);
	  call symput ('j',left(char(j)));

	  use dataset2;
	  read all var{&raters2} into ratername2;
	  d=ncol(ratername2);
	  call symput ('d',left(char(d)));
 
	  %if &j=&d %then %do;

	  %do u=1 %to &j;
        %let rater1&u = %scan(&raters1,&u,%str( ));
		%let rater2&u = %scan(&raters2,&u,%str( ));
	    edit dataset1;
	    delete all where (&&rater1&u=.);
        purge;
		edit dataset2;
		delete all where (&&rater2&u=.);
		purge;
      %end;

      use dataset1;
      read all var{&raters1} into temp1;
	  use dataset2;
      read all var{&raters2} into temp2;

	  %end;

	  %if &j^=&d %then %do;
	    print,"WARNING: NUMBER OF RATERS ASSESSING THE TWO METHODS ARE NOT EQUAL","PROGRAM WILL TERMINATE",;
	  %end;

	  %else %if &j=2 & &d=2 %then %do;
        %test_indep_two(vec1=temp1,vec2=temp2);
		percent=(1-&alpha)*100;
        percent=char(percent,4,1);
        phrase0={"Two Independent Groups, Each with Two Raters"};
        phrase1={"Difference in Concordance Correlation Coefficients and SE (Lin, 1989)"};

	      %if &bootCI='N' | &bootCI='n' | &bootCI='NO' | &bootCI='No' | &bootCI='no' %then %do;
              phrase2={"% Asymptotic Confidence Interval and P-value"};
              phrase3=concat(percent,phrase2);

		      N_1=nrow(temp1);
			  N_2=nrow(temp2);
              R=ncol(temp1);
              reset center spaces=3 fw=6 noname;
              print,phrase0,phrase1,phrase3,;
              reset center spaces=3 fw=6 name;
              print,N_1 N_2 R CCC_1 CCC_2 CCC_Diff SE_Diff;
              print,LCL UCL pvalue;

		      results=N_1||N_2||CCC_1||CCC_2||CCC_Diff||SE_Diff||LCL||UCL||pvalue;
		      col={N1 N2 CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL Asymp_p};
		      create &out from results[colname=col];
		      append from results;
          %end;
	      %if &bootCI='Y' | &bootCI='y' | &bootCI='YES' | &bootCI='Yes' | &bootCI='yes' %then %do;
            %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' | 
              &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	          %percentile_boot();
                phrase2={"% Asymptotic and Percentile Bootstrap CI, Asymp P-value"};
                phrase3=concat(percent,phrase2);
	            reset center spaces=3 fw=6 noname;
                print,phrase0,phrase1,phrase3,;
                reset center spaces=3 fw=6 name;
				Boot_LCL=Bootstrap_LCL;
				Boot_UCL=Bootstrap_UCL;
		        N_1=nrow(temp1);
			    N_2=nrow(temp2);
                R=ncol(temp1);
			    BS=&bs;
                print,N_1 N_2 R CCC_1 CCC_2 CCC_Diff SE_Diff;
				print,LCL UCL pvalue BS Boot_LCL Boot_UCL;

		        results=N_1||N_2||R||CCC_1||CCC_2||CCC_Diff||SE_Diff||LCL||UCL||pvalue||BS||Bootstrap_LCL||Bootstrap_UCL;
		        col={N1 N2 R CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL Asymp_p BS Boot_LCL Boot_UCL};
		        create &out from results[colname=col];
		        append from results;
            %end;

	        %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='BCa' |
			  &bootstrap='Bca' | &bootstrap='bca' %then %do;
	          %bca_boot();
                phrase2={"% Asymptotic and BCa Bootstrap Confidence Interval, Asymp P-value"};
                phrase3=concat(percent,phrase2);
	            reset center spaces=3 fw=6 noname;
                print,phrase0,phrase1,phrase3,;
                reset center spaces=3 fw=6 name;
				Boot_LCL=Bootstrap_LCL;
				Boot_UCL=Bootstrap_UCL;
		        N_1=nrow(temp1);
			    N_2=nrow(temp2);
                R=ncol(temp1);
			    BS=&bs;
                print,N_1 N_2 R CCC_1 CCC_2 CCC_Diff SE_Diff;
				print,LCL UCL pvalue BS Boot_LCL Boot_UCL;

		        results=N_1||N_2||R||CCC_1||CCC_2||CCC_Diff||SE_Diff||LCL||UCL||pvalue||BS||Bootstrap_LCL||Bootstrap_UCL;
		        col={N1 N2 R CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL Asymp_p BS Boot_LCL Boot_UCL};
		        create &out from results[colname=col];
		        append from results;
            %end;

          %end;
	    %end;
	    %else %do;
	      %test_indep_mult(vec1=temp1,vec2=temp2);
		  percent=(1-&alpha)*100;
          percent=char(percent,4,1);
          phrase0={"Two Independent Groups, Each with Multiple Raters"};
          phrase1={"Difference in Overall Concordance Correlation Coefficients (Barnhart, 2002)"};

          %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' | 
            &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	        %percentile_boot();
              phrase2={"% Percentile Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);

		      N_1=nrow(temp1);
			  N_2=nrow(temp2);
              R=ncol(temp1);
			  BS=&bs;
			  reset center spaces=3 fw=6 noname;
              print,phrase0,phrase1,phrase3,;
              reset center spaces=3 fw=6 name;
              print,N_1 N_2 R CCC_1 CCC_2 CCC_Diff;
			  print,BS Bootstrap_LCL Bootstrap_UCL;

		      results=N_1||N_2||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N1 N2 R CCC1 CCC2 CCC_Diff BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

	      %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='BCa' |
		    &bootstrap='Bca' | &bootstrap='bca' %then %do;
	        %bca_boot();
              phrase2={"% Asymptotic and BCa Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);
	          reset center spaces=3 fw=6 noname;
              print,phrase0,phrase1,phrase3,;
		      N_1=nrow(temp1);
			  N_2=nrow(temp2);
              R=ncol(temp1);
			  BS=&bs;
              reset center spaces=3 fw=6 name;
              print,N_1 N_2 R CCC_1 CCC_2 CCC_Diff;
              print,BS Bootstrap_LCL Bootstrap_UCL;

              results=N_1||N_2||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N1 N2 R CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

        %end;
	quit;
  %end;
%end;

%if &analysis=4 %then %do;

  %if &dataset1=' ' | &raters1=' ' | &raters2=' ' %then %do;
    proc iml;
      print,"WARNING: NEED TO SPECIFY DATASET1, RATERS1, AND RATERS2","PROGRAM WILL BE TERMINATED",;
    quit;
  %end;
  %else %do;

    data dataset1;
	  set &dataset1;
	run;

    proc iml;

      use dataset1;
	  read all var{&raters1} into ratername1;
	  j1=ncol(ratername1);
	  call symput ('j1',left(char(j1)));
	  read all var{&raters2} into ratername2;
	  j2=ncol(ratername2);
	  call symput ('j2',left(char(j2)));
 
	  %do u=1 %to &j1;
        %let rater1&u = %scan(&raters1,&u,%str( ));
		%let rater2&u = %scan(&raters2,&u,%str( ));
	    edit dataset1;
	    delete all where (&&rater1&u=. | &&rater2&u=.);
        purge;
      %end;

      use dataset1;
      read all var{&raters1} into temp1;
      read all var{&raters2} into temp2;

	  %if &j1^=&j2 %then %do;
	    print,"WARNING: THE NUMBER OF RATERS ASSESSING THE TWO METHODS ARE NOT EQUAL","THE PROGRAM WILL BE TERMINATED",;
	  %end;
	  %else %do;

      if &j1=2 then phrase0={"Two Dependent Methods, Each with Two Raters (Lin, 1989)"};
      if &j1>2 then phrase0={"Two Dependent Methods, Each with Multiple Raters (Barnhart, 2002)"};
      phrase1={"Difference in Overall Concordance Correlation Coefficients"};
      percent=(1-&alpha)*100;
      percent=char(percent,4,1);
	  %test_dep(vector1=temp1,vector2=temp2);

          %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' | 
            &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	        %percentile_boot();
              phrase2={"% Percentile Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);

	          N=nrow(temp1);
              R=ncol(temp1);
			  BS=&bs;
			  reset center spaces=3 fw=6 noname;
              print,phrase0,phrase1,phrase3,;
              reset center spaces=3 fw=6 name;
              print,N R CCC_1 CCC_2 CCC_Diff;
			  print,BS Bootstrap_LCL Bootstrap_UCL;

		      results=N||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N R CCC1 CCC2 CCC_Diff BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

	      %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='BCa' |
		    &bootstrap='Bca' | &bootstrap='bca' %then %do;
	        %bca_boot();
              phrase2={"% BCa Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);
	          reset center spaces=3 fw=6 noname;
              print,phrase0,phrase1,phrase3,;
	          N=nrow(temp1);
              R=ncol(temp1);
			  BS=&bs;
              reset center spaces=3 fw=6 name;
              print,N R CCC_1 CCC_2 CCC_Diff;
              print,BS Bootstrap_LCL Bootstrap_UCL;

              results=N||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N R CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

	  %end;

    quit;
  %end;
%end;

%if &analysis=5 %then %do;

  %if &dataset1=' ' | &raters1=' ' | &raters2=' ' | &raters_gold=' ' %then %do;
    proc iml;
      print,"WARNING: NEED TO SPECIFY DATASET1, RATERS1, RATERS2, AND RATERS_GOLD","PROGRAM WILL BE TERMINATED",;
    quit;
  %end;
  %else %do;

    data dataset1;
	  set &dataset1;
	run;

    proc iml;

      use dataset1;
	  read all var{&raters1} into ratername1;
	  j=ncol(ratername1);
	  call symput ('j',left(char(j)));
	  read all var{&raters2} into ratername2;
	  d1=ncol(ratername2);
	  call symput ('d1',left(char(d1)));
	  read all var{&raters_gold} into ratername3;
	  d2=ncol(ratername3);
	  call symput ('d2',left(char(d2)));
 
	  %if &j=1 | &d1=1 | &d2=1 %then %do;
	    print,"WARNING: ONLY ONE RATER IS SPECIFIED","PROGRAM WILL TERMINATE",;
      %end;

	  %if &j^=&d1 | &j^=&d2 | &d1^=&d2 %then %do;
	    print,"WARNING: THE NUMBER OF RATERS ASSESSING ALL THREE METHODS ARE NOT EQUAL","THE PROGRAM WILL BE TERMINATED",;
	  %end;

	  %if &j=&d1 & &j=&d2 & &d1=&d2 & &j^=1 & &d1^=1 & &d2^=1 %then %do;

	  %do u=1 %to &j;
        %let rater1&u = %scan(&raters1,&u,%str( ));
		%let rater2&u = %scan(&raters2,&u,%str( ));
		%let rater3&u = %scan(&raters_gold,&u,%str( ));
	    edit dataset1;
	    delete all where (&&rater1&u=. | &&rater2&u=. | &&rater3&u=.);
        purge;
      %end;

      use dataset1;
      read all var{&raters1} into temp1;
      read all var{&raters2} into temp2;
	  read all var{&raters_gold} into temp3;

	  %test_dep_two(vector1=temp1,vector2=temp2,vector3=temp3);
	  percent=(1-&alpha)*100;
      percent=char(percent,4,1);
      phrase0={"Agreement Between Two Dependent Experimental Methods and a Gold Standard"};
      phrase01={"Each with Two or More Raters (Williamson, accepted)"};
      phrase1={"Difference in Overall Concordance Correlation Coefficients"};
	  N=nrow(temp1);
      R=ncol(temp1);
	  BS=&bs;

          %if &bootstrap='P' | &bootstrap='p' | &bootstrap='PERCENTILE' | 
            &bootstrap='Percentile' | &bootstrap='percentile' %then %do;
	        %percentile_boot();
              phrase2={"% Percentile Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);
	          N=nrow(temp1);
              R=ncol(temp1);
			  BS=&bs;
			  reset center spaces=3 fw=6 noname;
              print,phrase0,phrase01,phrase1,phrase3,;
              reset center spaces=3 fw=6 name;
              print,N R CCC_1 CCC_2 CCC_Diff;
			  print,BS Bootstrap_LCL Bootstrap_UCL;

		      results=N||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N R CCC1 CCC2 CCC_Diff BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

	      %if &bootstrap='B' | &bootstrap='b' | &bootstrap='BCA' | &bootstrap='BCa' |
		    &bootstrap='Bca' | &bootstrap='bca' %then %do;
	        %bca_boot();
              phrase2={"% BCa Bootstrap Confidence Interval"};
              phrase3=concat(percent,phrase2);
	          reset center spaces=3 fw=6 noname;
              print,phrase0,phrase01,phrase1,phrase3,;
	          N=nrow(temp1);
              R=ncol(temp1);
			  BS=&bs;
              reset center spaces=3 fw=6 name;
              print,N R CCC_1 CCC_2 CCC_Diff;
              print,BS Bootstrap_LCL Bootstrap_UCL;

              results=N||R||CCC_1||CCC_2||CCC_Diff||BS||Bootstrap_LCL||Bootstrap_UCL;
		      col={N R CCC1 CCC2 CCC_Diff SE_Diff Asymp_LCL Asymp_UCL BS Boot_LCL Boot_UCL};
		      create &out from results[colname=col];
		      append from results;
          %end;

	  %end;

    quit;
  %end;
%end;

%mend;
