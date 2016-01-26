**************************************************
**************************************************
2-EDA: Exploratory data analysis
**************************************************
**************************************************;

*Load CKD derived variables, bring in analysis derived variables;
data ckd;
	merge
		project.ckd
		analysis.analysiswide (keep=subjid malev1 agev1 rename=(malev1=male agev1=age));
	by subjid;
	ckdEPIcreatininecysC_diff = ckdEPIcreatininecysC_IDMS-ckdEPIcreatininecysC_CC;
	label ckdEPIcreatininecysC_diff = "CKD-EPI Creat-CysC equation difference (IDMS minus CC)";
	format ckdEPIcreatininecysC_diff 8.2;
run;


*Sort by male;
proc sort data=ckd; by male; run;

ods pdf file="working groups\CKD\3-results\EDA.pdf";

	*Summary statistics, histograms, scatterplots;
	proc means data=ckd;
		by male;
		var ckdEPIcysC ckdEPIcreatininecysC_CC ckdEPIcreatininecysC_IDMS;
	run;

	proc sgscatter data=ckd;
		by male;
		matrix ckdEPIcysC ckdEPIcreatininecysC_CC ckdEPIcreatininecysC_IDMS / diagonal=(histogram kernel normal);
	run;

	proc corr data=ckd;
		by male;
		var ckdEPIcysC ckdEPIcreatininecysC_CC ckdEPIcreatininecysC_IDMS;
	run;

	proc sgplot data=ckd;
		title "Bland-Altman Plot for CKD-EPI creatinine cystatin C equations";
		title2 "Difference between IDMS and CC, vs CC";
		by male;
		scatter x=ckdEPIcreatininecysC_CC y=ckdEPIcreatininecysC_diff / markerattrs=(symbol=trianglefilled color=maroon size=5 px);
		refline 0 / axis=y lineattrs=(thickness=2);
		yaxis min=-1;
	run;

ods pdf close;

*Housekeeping;
proc datasets lib=work memtype=data nolist kill; run; quit;
