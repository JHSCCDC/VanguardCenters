***************************************************************************
***************************************************************************
BPCS program file: 1-data-calibration
Overview:
	0) Bring in raw BP data
	1) Create "Ignore-the-change" BP values
	2) Create "OLS"-calibrated BP values
	3) Create "Avg Diff"-calibrated BP values
	4) Create "Deming"-calibrated BP values
	5) Create "Robust"-calibrated BP values
	6) Perform data QC checks
	7) Output calibration dataset
***************************************************************************
***************************************************************************;

****0) Bring in raw BP data;

	*Bring in visit 1 BP data;
	data bp1; set v1.sbpa;
		if sbpa19 in (9,999) then sbpa19 = .;
		if sbpa20 in (9,999) then sbpa19 = .;
		rename
			sbpa19=sbp_rzs_v1
			sbpa20=dbp_rzs_v1;
		label
			subjid="subjid"
			sbpa19="SBP RZS V1"
			sbpa20="DBP RZS V1";
		keep subjid sbpa19 sbpa20;
	run;

	*Bring in visit 2 BP data;
	data bp2; set v2.sbpb;
		if sbpb22 in (9,999) then sbpb22 = .;
		if sbpb23 in (9,999) then sbpb23 = .;
		if sbpb29 in (9,999) then sbpb29 = .;
		if sbpb30 in (9,999) then sbpb30 = .;
		rename
			sbpb22=sbp_rzs_v2
			sbpb23=dbp_rzs_v2
			sbpb29=sbp_aod_v2
			sbpb30=dbp_aod_v2;
		label
			subjid="subjid"
			sbpb22="SBP RZS V2"
			sbpb23="DBP RZS V2"
			sbpb29="SBP AOD V2"
			sbpb30="DBP AOD V2";
		keep subjid sbpb22 sbpb23 sbpb29 sbpb30;
	run;

	*Bring in visit 3 BP data;
	data bp3; set v3.sbpc;
		if sbpc19 in (9,999) then sbpc19 = .;
		if sbpc20 in (9,999) then sbpc20 = .;
		rename
			sbpc19=sbp_aod_v3
			sbpc20=dbp_aod_v3;
		label
			subjid="subjid"
			sbpc19="SBP AOD V3"
			sbpc20="DBP AOD V3";
		keep subjid sbpc19 sbpc20;
	run;

	*Sort data;
	proc sort data=bp1; by subjid; run;
	proc sort data=bp2; by subjid; run;
	proc sort data=bp3; by subjid; run;

	*Merge data;
	data bp;

		merge bp1 bp2 bp3;
		by subjid;

		*Create indicator for BPCS study participants;
		if ^missing(sbp_rzs_v2) & ^missing(sbp_aod_v2) then bpcs=1;
		if missing(sbp_rzs_v2) | missing(sbp_aod_v2) then bpcs=0;
		label bpcs="Blood Pressure Comparability Study participant";
		format bpcs ynfmt.;

		*Calculate (AOD-RZS) differences for systolic and diastolic blood pressures;
		sbp_diff=sbp_aod_v2-sbp_rzs_v2;
		dbp_diff=dbp_aod_v2-dbp_rzs_v2;
		label sbp_diff="SBP Difference: AOD-RZS";
		label dbp_diff="DBP Difference: AOD-RZS";

	run;


****1) Create "Ignore-the-change" BP values;

	data bp; set bp;

		*RZS at visit 1 is unchanged;
		sbp1_ignore = sbp_rzs_v1;
		dbp1_ignore = dbp_rzs_v1;

		label sbp1_ignore = "V1 SBP - Ignoring the change";
		label dbp1_ignore = "V1 DBP - Ignoring the change";

		*Take AOD value at visit 2 if available, and take RZS value otherwise;
		if ^missing(sbp_aod_v2) then sbp2_ignore = sbp_aod_v2;
		else sbp2_ignore = sbp_rzs_v2;

		if ^missing(dbp_aod_v2) then dbp2_ignore = dbp_aod_v2;
		else dbp2_ignore = dbp_rzs_v2;

		label sbp2_ignore = "V2 SBP - Ignoring the change";
		label dbp2_ignore = "V2 DBP - Ignoring the change";

		*AOD at visit 3 is unchanged;
		sbp3_ignore = sbp_aod_v3;
		dbp3_ignore = dbp_aod_v3;

		label sbp3_ignore = "V3 SBP - Ignoring the change";
		label dbp3_ignore = "V3 DBP - Ignoring the change";

	run;


****2) Create "OLS"-calibrated BP values;

	*Calculate regression parameters for systolic blood pressure;
	proc glm data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		model sbp_aod_v2=sbp_rzs_v2;
		ods output ParameterEstimates=systolic;
	run; quit;

	*Store regression parameters as macro variables;
	data _null_; set systolic;
		if upcase(parameter)="INTERCEPT" then call symput("sbp_int",estimate);
		if upcase(parameter)="SBP_RZS_V2" then call symput("sbp_slope",estimate);
	run;

	%Put &sbp_int &sbp_slope;

	*Calculate regression parameters for diastolic blood pressure;
	proc glm data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		model dbp_aod_v2=dbp_rzs_v2;
		ods output ParameterEstimates=diastolic;
	run; quit;

	*Store regression parameters as macro variables;
	data _null_; set diastolic;
		if upcase(parameter)="INTERCEPT" then call symput("dbp_int",estimate);
		if upcase(parameter)="DBP_RZS_V2" then call symput("dbp_slope",estimate);
	run;

	%Put &dbp_int &dbp_slope;

	*Derive calibrated values;
	data bp; set bp;

		*RZS at visit 1 is calibrated using regression parameters;
		sbp1_ols = &sbp_slope*sbp_rzs_v1 + &sbp_int;
		dbp1_ols = &dbp_slope*dbp_rzs_v1 + &dbp_int;

		label sbp1_ols = "V1 SBP - OLS";
		label dbp1_ols = "V1 DBP - OLS";

		*Take AOD value at visit 2 if available, and calibrate RZS value otherwise;
		if ^missing(sbp_aod_v2) then sbp2_ols = sbp_aod_v2;
		else sbp2_ols = &sbp_slope*sbp_rzs_v2 + &sbp_int;

		if ^missing(dbp_aod_v2) then dbp2_ols = dbp_aod_v2;
		else dbp2_ols = &dbp_slope*dbp_rzs_v2 + &dbp_int;

		label sbp2_ols = "V2 SBP - OLS";
		label dbp2_ols = "V2 DBP - OLS";

		*AOD at visit 3 is unchanged;
		sbp3_ols = sbp_aod_v3;
		dbp3_ols = dbp_aod_v3;

		label sbp3_ols = "V3 SBP - OLS";
		label dbp3_ols = "V3 DBP - OLS";

	run;


****3) Create "Avg Diff"-calibrated BP values;

	*Calculate offset term for systolic blood pressure;
	proc means data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		var sbp_diff;
		ods output summary=systolic;
	run;

	*Store offset term as macro variables;
	data _null_; set systolic;
		if _n_=1 then call symput("sbp_diff",sbp_diff_mean);
	run;

	%Put &sbp_diff;

	*Calculate offset term for diastolic blood pressure;
	proc means data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		var dbp_diff;
		ods output summary=diastolic;
	run;

	*Store offset term as macro variables;
	data _null_; set diastolic;
		if _n_=1 then call symput("dbp_diff",dbp_diff_mean);
	run;

	%Put &dbp_diff;

	*Derive calibrated values;
	data bp; set bp;

		*RZS at visit 1 is calibrated using offset terms;
		sbp1_avg_diff = sbp_rzs_v1 + &sbp_diff;
		dbp1_avg_diff = dbp_rzs_v1 + &dbp_diff;

		label sbp1_avg_diff = "V1 SBP - Avg Diff";
		label dbp1_avg_diff = "V1 DBP - Avg Diff";

		*Take AOD value at visit 2 if available, and calibrate RZS value otherwise;
		if ^missing(sbp_aod_v2) then sbp2_avg_diff = sbp_aod_v2;
		else sbp2_avg_diff = sbp_rzs_v2 + &sbp_diff;

		if ^missing(dbp_aod_v2) then dbp2_avg_diff = dbp_aod_v2;
		else dbp2_avg_diff = dbp_rzs_v2 + &dbp_diff;

		label sbp2_avg_diff = "V2 SBP - Avg Diff";
		label dbp2_avg_diff = "V2 DBP - Avg Diff";

		*AOD at visit 3 is unchanged;
		sbp3_avg_diff = sbp_aod_v3;
		dbp3_avg_diff = dbp_aod_v3;

		label sbp3_avg_diff = "V3 SBP - Avg Diff";
		label dbp3_avg_diff = "V3 DBP - Avg Diff";

	run;


****4) Create "Deming"-calibrated BP values;

	*Create separate dataset to process with Deming macro;
	data _deming; set bp;
		if bpcs=1; *Subset data for BPCS cohort;
		keep subjid sbp_rzs_v2 sbp_aod_v2 dbp_rzs_v2 dbp_aod_v2;
	run;

	options nonotes;
	
	*Calculate regression parameters for systolic blood pressure;
	%DoIt(_deming,subjid,sbp_aod_v2,sbp_rzs_v2);

	*Store regression parameters as macro variables;
	proc transpose data=estimates out=estimates; run;
	data _null_; set estimates;
		if upcase(_name_)="A0_EST" then call symput("sbp_int",col1);
		if upcase(_name_)="B_EST" then call symput("sbp_slope",col1);
	run;

	%Put &sbp_int &sbp_slope;

	*Calculate regression parameters for diastolic blood pressure;
	%DoIt(_deming,subjid,dbp_aod_v2,dbp_rzs_v2);

	*Store regression parameters as macro variables;
	proc transpose data=estimates out=estimates; run;
	data _null_; set estimates;
		if upcase(_name_)="A0_EST" then call symput("dbp_int",col1);
		if upcase(_name_)="B_EST" then call symput("dbp_slope",col1);
	run;

	%Put &dbp_int &dbp_slope;

	*Housekeeping;
	proc datasets lib=work memtype=data nolist;
		delete deming: jack: variance: estimates means N;
	run; quit;

	options notes;

	*Derive calibrated values;
	data bp; set bp;

		*RZS at visit 1 is calibrated using regression parameters;
		sbp1_deming = &sbp_slope*sbp_rzs_v1 + &sbp_int;
		dbp1_deming = &dbp_slope*dbp_rzs_v1 + &dbp_int;

		label sbp1_deming = "V1 SBP - Deming";
		label dbp1_deming = "V1 DBP - Deming";

		*Take AOD value at visit 2 if available, and calibrate RZS value otherwise;
		if ^missing(sbp_aod_v2) then sbp2_deming = sbp_aod_v2;
		else sbp2_deming = &sbp_slope*sbp_rzs_v2 + &sbp_int;

		if ^missing(dbp_aod_v2) then dbp2_deming = dbp_aod_v2;
		else dbp2_deming = &dbp_slope*dbp_rzs_v2 + &dbp_int;

		label sbp2_deming = "V2 SBP - Deming";
		label dbp2_deming = "V2 DBP - Deming";

		*AOD at visit 3 is unchanged;
		sbp3_deming = sbp_aod_v3;
		dbp3_deming = dbp_aod_v3;

		label sbp3_deming = "V3 SBP - Deming";
		label dbp3_deming = "V3 DBP - Deming";

	run;


****5) Create "Robust"-calibrated BP values;

	*Calculate regression parameters for systolic blood pressure;
	proc robustreg data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		model sbp_diff=sbp_rzs_v2; *Modeling difference (AOD-RZS) as a function of RZS;
		ods output ParameterEstimates=systolic;
	run; quit;

	*Store regression parameters as macro variables;
	data _null_; set systolic;
		if upcase(parameter)="INTERCEPT" then call symput("sbp_int",estimate);
		if upcase(parameter)="SBP_RZS_V2" then call symput("sbp_slope",estimate);
	run;

	%Put &sbp_int &sbp_slope;

	*Calculate regression parameters for diastolic blood pressure;
	proc robustreg data=bp;
		where bpcs=1; *Subset data for BPCS cohort;
		model dbp_diff=dbp_rzs_v2; *Modeling difference (AOD-RZS) as a function of RZS;
		ods output ParameterEstimates=diastolic;
	run; quit;

	*Store regression parameters as macro variables;
	data _null_; set diastolic;
		if upcase(parameter)="INTERCEPT" then call symput("dbp_int",estimate);
		if upcase(parameter)="DBP_RZS_V2" then call symput("dbp_slope",estimate);
	run;

	%Put &dbp_int &dbp_slope;

	*Derive calibrated values;
	data bp; set bp;

		*RZS at visit 1 is calibrated using regression parameters;
		sbp1_robust = &sbp_int + sbp_rzs_v1 + &sbp_slope*sbp_rzs_v1;
		dbp1_robust = &dbp_int + dbp_rzs_v1 + &dbp_slope*dbp_rzs_v1;

		label sbp1_robust = "V1 SBP - Robust";
		label dbp1_robust = "V1 DBP - Robust";

		*Take AOD value at visit 2 if available, and calibrate RZS value otherwise;
		if ^missing(sbp_aod_v2) then sbp2_robust = sbp_aod_v2;
		else sbp2_robust = &sbp_int + sbp_rzs_v2 + &sbp_slope*sbp_rzs_v2;

		if ^missing(dbp_aod_v2) then dbp2_robust = dbp_aod_v2;
		else dbp2_robust = &dbp_int + dbp_rzs_v2 + &dbp_slope*dbp_rzs_v2;

		label sbp2_robust = "V2 SBP - Robust";
		label dbp2_robust = "V2 DBP - Robust";

		*AOD at visit 3 is unchanged;
		sbp3_robust = sbp_aod_v3;
		dbp3_robust = dbp_aod_v3;

		label sbp3_robust = "V3 SBP - Robust";
		label dbp3_robust = "V3 DBP - Robust";

	run;


****6) Perform data QC checks;

	*Look at new data;
	proc print data=bp (obs=25) label; run;

	*Check for instances where "Ignore the change" at visit 1 does not match
	original RZS values--THIS SHOULD RETURN NO OBSERVATIONS;
	proc print data=bp (obs=25) label;
		where (sbp_rzs_v1 ne sbp1_ignore) | (dbp_rzs_v1 ne dbp1_ignore);
		var subjid;
	run;

	*Check for instances where any calibration at visit 3 does not match
	original AOD values--THIS SHOULD RETURN NO OBSERVATIONS;
	proc print data=bp (obs=25) label;
		where
			(sbp3_ignore ne sbp_aod_v3) | (dbp3_ignore ne dbp_aod_v3) |
			(sbp3_ols ne sbp_aod_v3) | (dbp3_ols ne dbp_aod_v3) |
			(sbp3_avg_diff ne sbp_aod_v3) | (dbp3_avg_diff ne dbp_aod_v3) |
			(sbp3_deming ne sbp_aod_v3) | (dbp3_deming ne dbp_aod_v3) |
			(sbp3_robust ne sbp_aod_v3) | (dbp3_robust ne dbp_aod_v3);
		var subjid;
	run;


****7) Output calibration dataset;

	*SAS format;
	data project.BPcalibrated; set bp; run;

	*Stata format;
	proc export data=bp
		outfile="data\Supplementary\SSN0004-BP Calibration\1-data\Stata\BPcalibrated.dta"
		dbms=stata replace;
	run;

	*CSV format;
	proc export data=bp
		outfile="data\Supplementary\SSN0004-BP Calibration\1-data\CSV\BPcalibrated.csv"
		dbms=csv replace;
	run;


****8) Optional: Clean-up datasets;

	/*proc datasets lib=work memtype=data nolist kill; run; quit;*/
