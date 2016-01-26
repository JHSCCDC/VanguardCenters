/**************************************************************************************************
***************************************************************************************************
* The purpose of this program is to obtain a clean dataset of the JHS Exam Visit 1 activity       *
* codes, activity names and CDC/ACSM activity level categorizations                               *
***************************************************************************************************
**************************************************************************************************/


**************************************************************************************************;
*Step 1: Read in J-PAC data;
**************************************************************************************************;

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


**************************************************************************************************;
*Step 2: Get listing of all unlisted activities in the J-PAC data;
**************************************************************************************************;

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


**************************************************************************************************;
*Step 3: Assign JHS activity numbers to all unlisted activities;
**************************************************************************************************;

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


**************************************************************************************************;
*Step 4: Merge in assigned JHS activity numbers to manually coded unlisted activities;
**************************************************************************************************;

data activity; set paca; run;

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


**************************************************************************************************;
*Step 5: Read in and merge CDC/ACSM activity level categorizations;
**************************************************************************************************;

proc import replace out      = JHSacts 
                    datafile = "data\Supplementary\SSN0003Griswold-LS7\1-data\JHS METs.xlsx" 
                    dbms     = excel;
  range    = "Sheet1$"; 
  getnames = yes;
  mixed    = no;
  scantext = yes;
  usedate  = yes;
  scantime = yes;
  run;

data JHSacts;
  set JHSacts(rename = (    activity = JHSactCode
                        JHS_Activity = JHSactivity));

  label        JHSactCode = "JHS Activity Code";
  label CDC_ACSM_Category = "CDC/ACSM Activity Level Categorization";

  keep JHSactCode JHSactivity CDC_ACSM_Category;
  run;

data JHSacts;
  set JHSacts;

  if missing(JHSactCode) & missing(JHSactivity) then delete; *Drop extraneous input;

  activity1 = JHSactCode;
  activity2 = JHSactCode;
  activity3 = JHSactCode;

  act1NAME = JHSactivity;
  act2NAME = JHSactivity;
  act3NAME = JHSactivity;
  run;
