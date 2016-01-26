**************************************************
**************************************************
1-data: Load relevant data, derive new variables
**************************************************
**************************************************;


*Load necessary AnalysisWide variables;
data analysiswide; set analysis.analysiswide;
	rename
		malev1=male
		agev1=age
		scrccv1=scrCC
		scridmsv1=scrIDMS;
	keep subjid malev1 agev1 scrccv1 scridmsv1;
run;


*Load visit 1 Cycstatin C variable;
data cena; set v1.cena;
	keep subjid cystatinc;
run;


*Sort and merge datasets;
proc sort data=analysiswide; by subjid; run;
proc sort data=cena; by subjid; run;

data ckd;
	merge
		analysiswide
		cena;
	by subjid;
run;


*Derive new variables;
data ckd; set ckd;

	*Create temporary, sex-specific constants for formula;
	if male=1 then _female=1;
	if male=0 then _female=0.932;

	*Variable #1: ckdEPIcysC;
	if ^missing(cystatinC) then do;
	ckdEPIcysC = 133*(min(cystatinC/0.8,1)**-0.499)*(max(cystatinC/0.8,1)**-1.328)*(0.996**age)*_female;
	end;
	label ckdEPIcysC = "CKD-EPI cystatin C equation";
	format ckdEPIcysC 8.2;

	*Create temporary, sex=specific constants for formulas;
	if male=1 then _kappa=0.9;
	if male=0 then _kappa=0.7;

	if male=1 then _alpha=-0.207;
	if male=0 then _alpha=-0.248;

	if male=1 then _female=1;
	if male=0 then _female=0.969;

	*Variable #2: ckdEPIcreatininecysC_CC;
	if ^missing(scrcc) & ^missing(cystatinC) then do;
	ckdEPIcreatininecysC_CC = 	135*
								(min(scrcc/_kappa,1)**_alpha)*
								(max(scrcc/_kappa,1)**-0.601)*
								(min(cystatinc/0.8,1)**-0.375)*
								(max(cystatinc/0.8,1)**-0.711)*
								(0.995**age)*
								_female*
								1.08;
	end;
	label ckdEPIcreatininecysC_CC = "CKD-EPI creatinine-cystatin C equation (Cleveland Clinic)";
	format ckdEPIcreatininecysC_CC 8.2;

	*Variable #3: ckdEPIcreatininecysC_IDMS;
	if ^missing(scrIDMS) & ^missing(cystatinc) then do;
	ckdEPIcreatininecysC_IDMS = 135*
								(min(scrIDMS/_kappa,1)**_alpha)*
								(max(scrIDMS/_kappa,1)**-0.601)*
								(min(cystatinc/0.8,1)**-0.375)*
								(max(cystatinc/0.8,1)**-0.711)*
								(0.995**age)*
								_female*
								1.08;
	end;
	label ckdEPIcreatininecysC_IDMS = "CKD-EPI creatinine-cystatin C equation (IDMS)";
	format ckdEPIcreatininecysC_IDMS 8.2;

	*Housekeeping;
	drop _female _kappa _alpha;

run;


*Check;
proc print data=ckd (obs=10) label; run;


*Output CKD analysis dataset;
data project.ckd; set ckd;
	keep subjid ckdEPIcysC ckdEPIcreatininecysC_CC ckdEPIcreatininecysC_IDMS;
run;


*Housekeeping;
proc datasets lib=work memtype=data nolist kill;
run; quit;
