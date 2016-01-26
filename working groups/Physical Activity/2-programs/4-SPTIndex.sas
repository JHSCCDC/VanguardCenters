*Build Sport Index*****************************************************************************************;

*Find unlisted activities in PACA (via LS7 method);
  data paca;
    set jhsV1.paca (keep   =  subjid paca21b paca21c paca22 paca23 
                                     paca24b paca24c paca25 paca26
                                     paca27b paca27c paca28 paca29
                    rename = (paca21b = activity1
                              paca21c = UNLISTEDact1
                              paca22  = mnthsPERyr1 
                              paca23  = hrsPERwk1

                              paca24b = activity2
                              paca24c = UNLISTEDact2
                              paca25  = mnthsPERyr2
                              paca26  = hrsPERwk2

                              paca27b = activity3
                              paca27c = UNLISTEDact3
                              paca28  = mnthsPERyr3
                              paca29  = hrsPERwk3));;
    by subjid;
    run;

*Obtain list of unlisted activities;
	proc freq data = jhsV1.paca noprint; 
	  tables paca21c /missing out = unlisted1; 
	  tables paca24c /missing out = unlisted2;
	  tables paca27c /missing out = unlisted3;
	  run;

*Keep only activity name;
	data unlisted1; set unlisted1; if missing(paca21c) then delete; rename paca21c = UNLISTEDact; drop count percent; run;
	data unlisted2; set unlisted2; if missing(paca24c) then delete; rename paca24c = UNLISTEDact; drop count percent; run;
	data unlisted3; set unlisted3; if missing(paca27c) then delete; rename paca27c = UNLISTEDact; drop count percent; run;

*Merge unlisted activities into one dataset;
	data unlisted; merge unlisted1 unlisted2 unlisted3; by UNLISTEDact; run;

* Assign JHS activity numbers to all unlisted activities;
data unlisted;
  set unlisted;

  *Manually code all unlisted activities;
  activity = .;
    if UNLISTEDact = "013"                                     then activity = 13; *circuit training;
    if UNLISTEDact = "AB EXERCISE MACHINE"                     then activity = 58; *ab machine (slider);
    if UNLISTEDact = "AB MACHINE"                              then activity = 58; *ab machine (slider);
    if UNLISTEDact = "AB ROLLER"                               then activity = 58; *ab machine (slider);
    if UNLISTEDact = "AB SLIDER"                               then activity = 58; *ab machine (slider);
    if UNLISTEDact = "AEROBIC EXERC"                           then activity = 68; *low impact aerobics;
    if UNLISTEDact = "AQUATICS"                                then activity = 42; *water aerobics;
    if UNLISTEDact = "ARM AND LEG EXERCISE"                    then activity = 69; *arm &/or leg exercise;
    if UNLISTEDact = "ARM EXERCISE"                            then activity = 69; *arm &/or leg exercise;
    if UNLISTEDact = "AROUND THE HOUSE STRETCHING"             then activity = 47; *stretching around house;
    if UNLISTEDact = "BASEBALL"                                then activity = 48; *baseball;
    if UNLISTEDact = "BASKETBALL/FOOTBALL GAME OFFICIAL"       then activity = 43; *officiating sports;
    if UNLISTEDact = "CARDIO GUILD"                            then activity = 63; *cardio training;
    if UNLISTEDact = "CARDIO TRAINING"                         then activity = 63; *cardio training;      
    if UNLISTEDact = "CHAIR CLASSES SITTING"                   then activity = 44; *sit to be fit & chair class;
    if UNLISTEDact = "CHRONIC FATIGUE & FIBROMYALGIA GROUP"    then activity = 53; *physical therapy;
    if UNLISTEDact = "CLIMB BLEACHERS"                         then activity = 55; *climb bleachers;
    if UNLISTEDact = "COACHING FOOTBALL/SOFTBALL"              then activity = 54; *coaching sports;
    if UNLISTEDact = "CRUNCHES"                                then activity = 50; *sit ups;
    if UNLISTEDact = "CRUNCHES-ABDOMINAL EXERCISES"            then activity = 50; *sit ups;
    if UNLISTEDact = "DRUMMING"                                then activity = 71; *drumming;
    if UNLISTEDact = "ELEPITCAL"                               then activity = 59; *Gazell elliptical machine;
    if UNLISTEDact = "EXTENSIVE YARD WORK"                     then activity =  .; *not a sport or leisure activity;
    if UNLISTEDact = "FISHING"                                 then activity = 51; *fishing;
    if UNLISTEDact = "FLAG FOOTBALL"                           then activity = 70; *flag football;
    if UNLISTEDact = "FOOTBALL"                                then activity = 62; *football;
    if UNLISTEDact = "GARDENING"                               then activity =  .; *not a sport or leisure activity;
    if UNLISTEDact = "GAZELL MACHINE"                          then activity = 59; *Gazell elliptical machine;
    if UNLISTEDact = "GLIDER"                                  then activity = 66; *glider;
    if UNLISTEDact = "GLINDER"                                 then activity = 66; *glider;
    if UNLISTEDact = "H20 AEROBIC"                             then activity = 42; *water aerobics;
    if UNLISTEDact = "H2O AEROBICS"                            then activity = 42; *water aerobics;
    if UNLISTEDact = "HOT AIR BALLOON"                         then activity = 57; *hot air ballooning;
    if UNLISTEDact = "HUNTING"                                 then activity = 46; *hunting;
    if UNLISTEDact = "KICK BOXING"                             then activity = 61; *kick boxing;
    if UNLISTEDact = "LEG PRESSOR"                             then activity = 64; *leg pressor;
    if UNLISTEDact = "LOW IMPACT EXERCISE"                     then activity = 68; *low impact aerobics;
    if UNLISTEDact = "MASSAGE MACHINE"                         then activity = 53; *physical therapy; 
    if UNLISTEDact = "OFFICIATING SPORTS"                      then activity = 43; *officiating sports;
    if UNLISTEDact = "PHYSICAL THERAPY"                        then activity = 53; *physical therapy;
    if UNLISTEDact = "PHYSICAL THERAPY/RANGE OF MOTION EXER."  then activity = 53; *physical therapy;
    if UNLISTEDact = "PILATES"                                 then activity = 72; *pilates;
    if UNLISTEDact = "PING PONG"                               then activity = 49; *ping pong (table tennis);
    if UNLISTEDact = "PUSH UPS"                                then activity = 56; *push ups;
    if UNLISTEDact = "REHAD EXERCISES"                         then activity = 53; *physical therapy;
    if UNLISTEDact = "RIGOROUS WALKING"                        then activity = 11; *vigorous walking;
    if UNLISTEDact = "ROLLER SKATING"                          then activity = 39; *skating, ice;
    if UNLISTEDact = "SIT AND BE FIT"                          then activity = 44; *sit to be fit & chair class;
    if UNLISTEDact = "SIT UPS"                                 then activity = 50; *sit ups;
    if UNLISTEDact = "SIT-UPS AND KNEE BENDS LEG-LIFT"         then activity = 50; *sit ups;
    if UNLISTEDact = "SITTING AEROBICS"                        then activity = 44; *sit to be fit & chair class;
    if UNLISTEDact = "SPINNING"                                then activity = 65; *spinning;
    if UNLISTEDact = "SKI MACHINE"                             then activity =  4; *cross country skiing, ski machine;
    if UNLISTEDact = "SOFTBALL, BASEBALL & BASKETBALL REFEREE" then activity = 43; *officiating sports;
    if UNLISTEDact = "STEP"                                    then activity = 67; *step aerobics;
    if UNLISTEDact = "STEP CLASSES"                            then activity = 67; *step aerobics;
    if UNLISTEDact = "STEPPER"                                 then activity =  7; *stairclimber;
    if UNLISTEDact = "STRENGTHING EXERCISE"                    then activity = 16; *weight lifting;
    if UNLISTEDact = "TABOE"                                   then activity = 52; *taebo;
    if UNLISTEDact = "TAEBO"                                   then activity = 52; *taebo;
    if UNLISTEDact = "TIMEWORKS FX FULL BODY AEROBICS MACHINE" then activity = 45; *home aerobic machine;
    if UNLISTEDact = "TOTAL GYM"                               then activity = 60; *total gym;
    if UNLISTEDact = "UMPIRE FOR BASEBALL GAME"                then activity = 43; *officiating sports;
    if UNLISTEDact = "WALKING"                                 then activity = 41; *walking;
    if UNLISTEDact = "WALKING (NOT VIGOROUS)"                  then activity = 41; *walking;
    if UNLISTEDact = "WATE AEROBICS"                           then activity = 42; *water aerobics;
    if UNLISTEDact = "WATER AAROBICS"                          then activity = 42; *water aerobics;
    if UNLISTEDact = "WATER AEROBIC"                           then activity = 42; *water aerobics;
    if UNLISTEDact = "WATER AEROBIC DANCE"                     then activity = 42; *water aerobics;
    if UNLISTEDact = "WATER AEROBICS"                          then activity = 42; *water aerobics;
    if UNLISTEDact = "WATER AERPBOC"                           then activity = 42; *water aerobics;
    if UNLISTEDact = "WEIGHT LIFTING"                          then activity = 16; *weight lifting;
    if UNLISTEDact = "WORK OUT FROM AEROBICS"                  then activity = 68; *low impact aerobics;
    if UNLISTEDact = "WORKOUT TAPE"                            then activity = 68; *low impact aerobics;

  UNLISTEDact1 = UNLISTEDact;
  UNLISTEDact2 = UNLISTEDact;
  UNLISTEDact3 = UNLISTEDact;
  run;

  
*Create datasets of manually coded unlisted activities for each activity;
data unlisted1; set unlisted(keep = UNLISTEDact1 activity); run;
data unlisted2; set unlisted(keep = UNLISTEDact2 activity); run;
data unlisted3; set unlisted(keep = UNLISTEDact3 activity); run;

* Merge in assigned JHS activity numbers to manually coded unlisted activities;
	data activity; set paca;  
	*indicator for previously unlisted sport;
		 if not missing(UNLISTEDact1) | not missing(UNLISTEDact2) | not missing(UNLISTEDact3)
			then recode='Y'; else recode='N'; 
	run;

  *Activity 1;
    proc sort data = activity;  by UNLISTEDact1; run;
    proc sort data = unlisted1; by UNLISTEDact1; run;

    data activity;
      merge activity 
            unlisted1; 
      by UNLISTEDact1;

      if missing(subjid) then delete;

      if NOT missing(UNLISTEDact1) then activity1 = activity;
      format activity1 activity.;
      drop activity;
    run;

  *Activity 2;
    proc sort data = activity;  by UNLISTEDact2; run;
    proc sort data = unlisted2; by UNLISTEDact2; run;


    data activity;
      merge activity 
            unlisted2; 
      by UNLISTEDact2;

      if missing(subjid) then delete;

      if NOT missing(UNLISTEDact2) then activity2 = activity;
      format activity2 activity.;
      drop activity;
      run;

  *Activity 3;
    proc sort data = activity;  by UNLISTEDact3; run;
    proc sort data = unlisted3; by UNLISTEDact3; run;

    data activity;
      merge activity 
            unlisted3; 
      by UNLISTEDact3;
 
      if missing(subjid) then delete;

      if NOT missing(UNLISTEDact3) then activity3 = activity;
      format activity3 activity.;
      drop activity;
      run;

proc sort data=activity; by subjid; run;


*Calculate simple sport score;
	data SSSCore; 
		merge jhsv1.paca (in=a drop=PAGREPEAT PACA32) activity (in=b);
		by subjid;
		if a=1 ;
		*set merge jhsv1.paca (drop=PAGREPEAT PACA32) ;
			array codes (*)  activity1 activity2 activity3 ;
			array level (*)  CL1 CL2 CL3 ;
			array prp_yr(*)  mnthsPERyr1 mnthsPERyr2 mnthsPERyr3 ;
			array YR	(*)  PY1 PY2 PY3 ;
			array hours (*)  hrsPERwk1 hrsPERwk2 hrsPERwk3 ;
			array times	(*)  HR1 HR2 HR3 ;
		*Assign intensity codes for sports and exercise codes;
			do i=1 to dim(codes);
				if codes(i) in (12,14,15,16,20,21,22,24,33,34,41,44,45,47,51,69) then level(i)= 0.76 ;/*Low intensity*/
				else if codes(i) in (2,5,8,9,11,17,23,25,26,27,28,29,32,35,36,37,42,43,46,48,49,54,58,60,63,64,68) then level(i)= 1.26 ;/*Medium intensity*/
				else if codes(i) in (1,3,4,6,7,10,13,18,19,30,31,38,39,40,50,52,55,56,59,61,62,65,66,67,70) then level(i)= 1.76 ;/*High intensity*/
			end;
		*Recode proportion of year values;
			do j=1 to dim(prp_yr);
				if prp_yr(j)='A' then YR(j)= 0.5 ;
				else if prp_yr(j)='B' then YR(j)= 1.3 ; 
				else if prp_yr(j)='C' then YR(j)= 2.5 ; 
				else if prp_yr(j)='D' then YR(j)= 3.5 ; 
				else if prp_yr(j)='E' then YR(j)= 4.5 ; 
			end;
		*Recode time per week values;
			do k=1 to dim(hours);
				if hours(k)='A' then times(k)= 0.04 ;
				else if hours(k)='B' then times(k)= 0.17 ; 
				else if hours(k)='C' then times(k)= 0.42 ; 
				else if hours(k)='D' then times(k)= 0.67 ; 
				else if hours(k)='E' then times(k)= 0.92 ; 
			end;

			drop i j k ;
	run;

	data ssscore;*calculate simple sport core;**(intensity)*(time)*(proportion of year);
	 set ssscore;
			
		SSS01_A = CL1*HR1*PY1;
			if (missing(PACA21a) & missing(PACA21b)) then SSS01_A=0;
				else if PACA19='N' then SSS01_A=0	;
				else if CL1=. | HR1=. | PY1 =. then SSS01_A= . ;
				else if cl1=hr1=py1=. then sss01_a= . ;
		SSS01_B = CL2*HR2*PY2 ;
			if missing(PACA24a)& missing(PACA24b) then SSS01_B=0 ;
				else if (PACA19='N') then SSS01_B=0	;
				else if CL2=. | HR2=. | PY2 =. then SSS01_b= . ;
				else if cl2=hr2=py2=. then sss01_b= . ;
		SSS01_C = CL3*HR3*PY3 ;
			if  missing(PACA27a)& missing(PACA27b) then SSS01_C=0 ;
				else if ( PACA19='N') then SSS01_C=0 ;
				else if CL3=. | HR3=. | PY3 =. then SSS01_c= . ;
				else if cl3=hr3=py3=. then sss01_c= . ;

		*No simple sport score if PACA19 not answered;
		SSS01_S = . ;
		if SSS01_A= SSS01_B= SSS01_C = . then SSS01_S=. ;
			else  SSS01_S = sum(SSS01_A ,SSS01_B, SSS01_C) ;

		if nmiss(of cl1,hr1,py1) ge 1  & ( PACA19 ^='N') then sss01_a=. ;
		if nmiss(of cl2,hr2,py2) ge 1  & ( PACA19 ^='N') then sss01_b=. ;
		if nmiss(of cl3,hr3,py3) ge 1  & ( PACA19 ^='N') then sss01_c=. ;

		*Recode simple sport core;
			if SSS01_S = 0 
					then SSS01= 1 ;
		 	else if SSS01_S gt 0.01 & SSS01_S lt 4  
					then SSS01= 2 ; 
			else if SSS01_S ge 4 & SSS01_S lt 8 
					then SSS01= 3 ; 
			else if SSS01_S ge 8 & SSS01_S lt 12 
					then SSS01= 4 ; 
			else if SSS01_S gt 12 then SSS01= 5 ; 

		if nmiss(of  sss01_a, sss01_b, sss01_c)= 3 then sss01=. ;
	run;
	 
	*Sort simple sport score;
		proc sort data=ssscore; by subjid; run;


*Create sport index;
	data pa.sport (keep=subjid  i4 i19 i20  SSS01	SPT01 recode activity1 activity2 activity3) ;
		merge ssscore(in=a) jhsv1.paca(in=b );
		by subjid;

		array old   (*)  PACA5 PACA20 PACA30 ; 
		array new   (*)  i4 i19 i20 ; 
	*Recode ; 
			do i=1 to dim(old);
			 	if old(i) = 'A' then new(i)=1 ;else 
				if old(i) = 'B' then new(i)=2 ;else   
				if old(i) = 'C' then new(i)=3 ;else   
				if old(i) = 'D' then new(i)=4 ;else    
				if old(i) = 'E' then new(i)=5 ;else  
				new(i) = . ; 
			end;
   *Sport index missing if PACA19 = no and one of the above scores is missing;
			SPT01=  (i4 + i19 + SSS01 + i20)/4 ;
   *Sport index = 1 if PACA19=No;
			if PACA19='N' then	SPT01= 1;

		label  i4        = "Frequency of sweating from exertion during leisure time"  
			   i19       = "Frequency of playing sports/exercise in the past year"
			   i20       = "Recreational activity versus peers"  
			   SSS01     = "Simple sport score"
			   SPT01     = "Sport Index"  
			   recode    = "Previously unlisted activity-recoded"
			   activity1 = "Sport/Exercise #1" 
			   activity2 = "Sport/Exercise #2" 
			   activity3 = "Sport/Exercise #3" ;
	run;
