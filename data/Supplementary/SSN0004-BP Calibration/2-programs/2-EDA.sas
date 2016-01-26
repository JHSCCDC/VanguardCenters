***************************************************************************
***************************************************************************
BPCS program file: 2-EDA
Overview:
	0) Bring in raw BPcalibrated data
	1) Look at Bland-Altman Plots for AOD-vs-RZS
	2) Compare "Robust"-calibrated approach to "Ignore the Change" approach
***************************************************************************
***************************************************************************;

****0) Load BPcalibrated data;

	data bp; set project.BPcalibrated; run;


****1) Look at Bland-Altman Plots for AOD-vs-RZS;

	*For systolic blood pressure;
	proc sgplot data=bp;
		title2 "SBP Bland-Altman Plot: (AOD-RZS) vs RZS";
		reg y=sbp_diff x=sbp_rzs_v2 /
			lineattrs=(thickness=4 color=blue)
			markerattrs=(symbol=circlefilled color=gray30 size=5);
		loess y=sbp_diff x=sbp_rzs_v2 /
			lineattrs=(thickness=4 color=red)
			nomarkers;
		refline 0 /
			lineattrs=(color=black thickness=1) axis=y;
	run;

	*For diastolic blood pressure;
	proc sgplot data=bp;
		title2 "DBP Bland-Altman Plot: (AOD-RZS) vs RZS";
		reg y=dbp_diff x=dbp_rzs_v2 /
			lineattrs=(thickness=4 color=blue)
			markerattrs=(symbol=circlefilled color=gray30 size=5);
		loess y=dbp_diff x=dbp_rzs_v2 /
			lineattrs=(thickness=4 color=red)
			nomarkers;
		refline 0 /
			lineattrs=(color=black thickness=2) axis=y;
	run;


****2) Compare "Robust"-calibrated approach to "Ignore the Change" approach

	*Visit 1: "Calibrated vs. Ignored" should appear as a single line, because there is a 1:1 match
	at visit 1 between original blood pressure values and calibrated blood pressure values. All
	original values were taken as RZS, so all calibrated values will be a function of those	values;
	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- SBP at V1";
		scatter y=sbp1_robust x=sbp1_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;

	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- DBP at V1";
		scatter y=dbp1_robust x=dbp1_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;

	*Visit 2: "Calibrated vs. Ignored" should appear as two lines, because there is a 1:2 match
	at visit 2 between original blood pressure values and calibrated blood pressure values. Some
	original values were taken as AOD, and the calibration will not affect these values. Other
	original values were taken as RZS, and the calibrated values will be a function of those values;
	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- SBP at V2";
		scatter y=sbp2_robust x=sbp2_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;

	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- DBP at V2";
		scatter y=dbp2_robust x=dbp2_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;

	*At visit 3, "Calibrated vs. Ignored" plots should appear as a single line, because blood
	pressure values at visit 3 were only taken as AOD;
	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- SBP at V3";
		scatter y=sbp3_robust x=sbp3_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;

	proc sgplot data=bp;
		title2 "Calibrated vs. Ignored -- DBP at V3";
		scatter y=dbp3_robust x=dbp3_ignore / markerattrs=(symbol=circlefilled color=gray30 size=5);
		lineparm y=0 x=0 slope=1 / clip legendlabel="Identity line (y=x)";
	run;
