********************************************************************;
**********  Analytic Dataset of JHS Neighborhood Variables *********;
********************************************************************;

title "Analytic Dataset of JHS Neighborhood Variables: Neighborhood Census";

**********************Produce basic statistics**********************;

*Variable List;

  *selected continuous variables: if there are three variables for the same info, like COMMAREA0,COMMAREA1,and COMMAREA14, only COMMAREA1 was chosen ;                    
   %let contvar =race_hisp  race_whiteNH	race_blackNH  race_asianNH 	race_otherNH 	ownerocc_hh 	birth_foreign 	samehouse 	Educ_minHS
	Educ_minBA	unemployed	NotInLaborForce	Occup_I	inc_HHge50k	inc_medHH	inc_IntDivRent	inc_pubass	pov	crowd_gt1_ppr	phone_none	vehicle_none
	HUcost_medownval	HU_sampleocc	F1_PC2	F2_PC2	F3_PC2	F4_PC2	F1_PC2_BT	F2_PC2_BT	factor_ana	popden_tot	 ;

   *Categorical;                   
   %let catvar  = exam ;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries";
proc means data = validation maxdec = 2 fw = 6; 
 class exam;
 var race_hisp  race_whiteNH	race_blackNH  race_asianNH 	race_otherNH 	ownerocc_hh 	birth_foreign 	samehouse 	Educ_minHS
	Educ_minBA	unemployed	NotInLaborForce	Occup_I	inc_HHge50k	inc_medHH	inc_IntDivRent	inc_pubass	pov	crowd_gt1_ppr	phone_none	vehicle_none
	HUcost_medownval	HU_sampleocc	F1_PC2	F2_PC2	F3_PC2	F4_PC2	F1_PC2_BT	F2_PC2_BT	factor_ana	popden_tot	 ;
 run;


proc sort data= validation;
by exam;
 run;
*******************graphs********************************;
 *1. JHS Neighborhood Census Data;
title1 " JHS Neighborhood Census Data ";
title2 "% 25+ with minimum bachelor degree vs. a high school education";
proc sgscatter  data= validation; plot Educ_minHS*Educ_minBA/group=exam ;  run;

title2 "% Household w/income >= $50,000 vs. Median Household income";
proc sgscatter  data= validation; plot inc_HHge50k*inc_medHH/group=exam ;  run;

title2 "% with public assistance vs. % below poverty";
proc sgscatter  data= validation; plot inc_pubass*pov/group=exam;          run;  

title2 "Median owner Household cost vs. % below poverty"; 
proc sgscatter  data= validation; plot HUcost_medownval*pov/group=exam;    run;

title2 "% below poverty vs. % Household with crowding > 1 person/room";
proc sgscatter  data= validation; plot pov*crowd_gt1_ppr/group=exam ;      run;

title2 "% below poverty vs. % Household with interest, dividend, rental income";
proc sgscatter  data= validation; plot pov*inc_IntDivRent/group=exam ;      run;

title2 "% in same house vs. % Household with crowding > 1 person/room";
proc sgscatter  data= validation; plot samehouse*crowd_gt1_ppr/group=exam; run;

title2 "% Household w/no telephone vs. % Household w/no vehicle";
proc sgscatter  data= validation; plot phone_none*vehicle_none/group=exam; run;

title2 "% managerial occupation vs. unemployed";
proc sgscatter  data= validation; plot Occup_I*unemployed/group=exam;run;

title2 "% managerial occupation vs. Median owner Household cost";
proc sgscatter  data= validation; plot Occup_I*HUcost_medownval/group=exam;run;

title2 "% Hispanic vs. % other non-hispanic";
proc sgscatter  data= validation; plot race_hisp*race_otherNH/group=exam;  run;

title2 "% black non-hispanic vs. % white non-hispanic";
proc sgscatter  data= validation; plot race_blackNH*race_whiteNH /group=exam;  run;

title2 "% black non-hispanic vs. % asian non-hispanic";
proc sgscatter  data= validation; plot race_blackNH*race_asianNH /group=exam;  run;

title2 "SES (PC2) Weighted Factor1 score vs. Factor score based on Ana Diez-Roux 1990 PC factor analysis";
proc sgscatter  data= validation; plot F1_PC2*factor_ana/group=exam;       run;
 

%put Section 01 Complete;
