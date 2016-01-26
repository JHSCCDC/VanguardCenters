/**************************************************************************************************
***************************************************************************************************
* The purpose of this program is to obtain a clean dataset of the JHS Exam Visit 3 activity       *
* codes, activity names and CDC/ACSM activity level categorizations                               *
***************************************************************************************************
**************************************************************************************************/


**************************************************************************************************;
*Step 1: Read in J-PAC data;
**************************************************************************************************;

  data pacb;
    set jhsV3.pacb (  keep =  subjid pacb19b pacb19c pacb20 pacb21 
                                     pacb22b pacb22c pacb23 pacb24
                                     pacb25b pacb25c pacb26 pacb27
                    rename = (pacb19b = activity1
                              pacb19c = UNLISTEDact1
                              pacb20  = mnthsPERyr1 
                              pacb21  = hrsPERwk1

                              pacb22b = activity2
                              pacb22c = UNLISTEDact2
                              pacb23  = mnthsPERyr2
                              pacb24  = hrsPERwk2

                              pacb25b = activity3
                              pacb25c = UNLISTEDact3
                              pacb26  = mnthsPERyr3
                              pacb27  = hrsPERwk3));;
    by subjid;
    run;


**************************************************************************************************;
*Step 2: Get listing of all unlisted activities in the J-PAC data;
**************************************************************************************************;

*Obtain list of unlisted activities;
proc freq data = jhsV3.pacb noprint; 
  tables pacb19c /missing out = unlisted1; 
  tables pacb22c /missing out = unlisted2;
  tables pacb25c /missing out = unlisted3;
  run;

*Keep only activity name;
data unlisted1; set unlisted1; if missing(pacb19c) then delete; rename pacb19c = UNLISTEDact; drop count percent; run;
data unlisted2; set unlisted2; if missing(pacb22c) then delete; rename pacb22c = UNLISTEDact; drop count percent; run;
data unlisted3; set unlisted3; if missing(pacb25c) then delete; rename pacb25c = UNLISTEDact; drop count percent; run;

*Merge unlisted activities into one dataset;
data unlisted; merge unlisted1 unlisted2 unlisted3; by UNLISTEDact; run;


**************************************************************************************************;
*Step 3: Assign JHS activity numbers to all unlisted activities;
**************************************************************************************************;

data unlisted;
  set unlisted;

  *Manually code all unlisted activities;
  activity = .;

  if UNLISTEDact = "2X WEEK PARTICIPANT HAD PHYSICAL THERAPY"                                         then activity = 53; *physical therapy;
  if UNLISTEDact = "AB MACHINE"                                                                       then activity = 58; *ab machine (slider);
  if UNLISTEDact = "ABD ROCKER"                                                                       then activity = 58; *ab machine (slider);
  if UNLISTEDact = "ABDOMEN ROCKER"                                                                   then activity = 58; *ab machine (slider);
  if UNLISTEDact = "AEBORIC AND STRENTHGHING"                                                         then activity = 68; *low impact aerobics;
  if UNLISTEDact = "AEBORICS"                                                                         then activity = 68; *low impact aerobics;
  if UNLISTEDact = "AEROBICS WITH SENIOR"                                                             then activity = 68; *low impact aerobics;
  if UNLISTEDact = "BALL"                                                                             then activity = 73; *therapeutic exercise ball, Fitball exercise;
  if UNLISTEDact = "BASEBALL"                                                                         then activity = 48; *baseball;
  if UNLISTEDact = "BENCH PRESSES"                                                                    then activity = 16; *weight lifting;
  if UNLISTEDact = "BICYCLING"                                                                        then activity =  2; *bicycling;
  if UNLISTEDact = "BICYLING"                                                                         then activity =  2; *bicycling;
  if UNLISTEDact = "BIKE"                                                                             then activity =  2; *bicycling;
  if UNLISTEDact = "BIYCLE OR MACHINE"                                                                then activity =  2; *bicycling;
  if UNLISTEDact = "BOXING ,TENNIS, BOWLING ON THE WII GAME"                                          then activity = 75; *activity promoting video game, moderate effort;
  if UNLISTEDact = "CARDIO GLIDE"                                                                     then activity = 63; *cardio training;
  if UNLISTEDact = "CARDIO EXECISES"                                                                  then activity = 63; *cardio training;
  if UNLISTEDact = "CHAIR EXERCISE, FLOOR EXERCISE"                                                   then activity = 44; *sit to be fit & chair class;
  if UNLISTEDact = "CHAIR EXERCISES"                                                                  then activity = 44; *sit to be fit & chair class;
  if UNLISTEDact = "CHAIR EXERCISES, MARCHING IN PLACE, ARMS AND LEGS EXERCISES"                      then activity = 44; *sit to be fit & chair class;
  if UNLISTEDact = "CLEANING, GARDENING, ORGANIZING"                                                  then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "COACHING FOOTBALL"                                                                then activity = 54; *coaching sports;
  if UNLISTEDact = "CRUNCHES"                                                                         then activity = 50; *sit ups;
  if UNLISTEDact = "CURVES"                                                                           then activity = 76; *Curves exercise routines in women;
  if UNLISTEDact = "CUTTING WOOD, CUTTING GRASS, GARDENING WORK"                                      then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "DEER HUNTING"                                                                     then activity = 46; *hunting;
  if UNLISTEDact = "DO NOT DO ANY OTHER EXERCISE."                                                    then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "DR ORDERED PHYSICAL THERAPY"                                                      then activity = 53; *physical therapy;
  if UNLISTEDact = "EXERCISE CLASS"                                                                   then activity = 77; *health club exercise, general;
  if UNLISTEDact = "FISHING"                                                                          then activity = 51; *fishing;
  if UNLISTEDact = "FISHING, WALKING, GARDENING, YARD WORK"                                           then activity = 51; *fishing;
  if UNLISTEDact = "FITNESS BALL FOR STRENGTH TRAINING"                                               then activity = 53; *physical therapy;
  if UNLISTEDact = "FOOTBALL"                                                                         then activity = 62; *football;
  if UNLISTEDact = "GARDENING"                                                                        then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING /YARD WORK"                                                             then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING AND YARD WORK"                                                          then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING WORK"                                                                   then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING WORK, ORDINARY WALKING, HOUSE CLEANING"                                 then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, FARMING, LAND SCRAPING"                                                then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, GATHERING VETAB., HOE THE FIELDS"                                      then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, HOUSE WORK"                                                            then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, YARD WORK"                                                             then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, YARD WORK, TILING SOIL FOR HARVEST"                                    then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING, YARD WORK, TILING, BAILING HAY, TAKING CARE OF FARM"                   then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENING/ YARD WORK"                                                             then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GARDENIONG"                                                                       then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "GLIDER"                                                                           then activity = 66; *glider;
  if UNLISTEDact = "HAND WEIGHTS, FLOOR EXERCISES"                                                    then activity = 69; *arm &/or leg exercise;
  if UNLISTEDact = "HIP HOP AEOBRICS"                                                                 then activity = 28; *other dance;
  if UNLISTEDact = "HORSE BACK RIDING"                                                                then activity = 37; *horseback riding;
  if UNLISTEDact = "HORSEBACK RIDING, BAILING HAY, FARM WORK"                                         then activity = 37; *horseback riding;
  if UNLISTEDact = "HUNTING"                                                                          then activity = 46; *hunting;
  if UNLISTEDact = "HUNTING RABBIT SQURILS"                                                           then activity = 46; *hunting;
  if UNLISTEDact = "JOG"                                                                              then activity =  6; *running/jogging;
  if UNLISTEDact = "JUMPING JACKS"                                                                    then activity = 12; *calisthenics;
  if UNLISTEDact = "JUMPING JACKS, PUSH UPS, SIT UPS"                                                 then activity = 12; *calisthenics;
  if UNLISTEDact = "KICK BOXING"                                                                      then activity = 61; *kick boxing;
  if UNLISTEDact = "LEISURE WALKING"                                                                  then activity = 41; *walking;
  if UNLISTEDact = "LINE DANCE"                                                                       then activity = 27; *folk or social dance;
  if UNLISTEDact = "MARTIAL ARTS"                                                                     then activity = 38; *martial arts;
  if UNLISTEDact = "MODERATE WALKING NOT BRISK"                                                       then activity = 41; *walking;
  if UNLISTEDact = "MOWING LAWN"                                                                      then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "NINTENDO WI BOWLING"                                                              then activity = 74; *activity promoting video game, light effort;
  if UNLISTEDact = "NITENDO WII"                                                                      then activity = 75; *activity promoting video game, moderate effort;
  if UNLISTEDact = "NO OTHER ACTIVITY."                                                               then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "NO OTHER EXERCISE"                                                                then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "NORMAL PACE WALKING"                                                              then activity = 41; *walking;
  if UNLISTEDact = "NORMAL WALKING"                                                                   then activity = 41; *walking;
  if UNLISTEDact = "NORMAL WALKING AT MY JOB"                                                         then activity = 41; *walking;
  if UNLISTEDact = "ORDINARY PACE"                                                                    then activity = 41; *walking;
  if UNLISTEDact = "ORDINARY PACE WALKING"                                                            then activity = 41; *walking;
  if UNLISTEDact = "ORDINARY WALKING"                                                                 then activity = 41; *walking;
  if UNLISTEDact = "ORDINARY WALKING PACE"                                                            then activity = 41; *walking;
  if UNLISTEDact = "ORIDNARY PACE"                                                                    then activity = 41; *walking;
  if UNLISTEDact = "ORIDNARY WALK"                                                                    then activity = 41; *walking;
  if UNLISTEDact = "ORINARY PACE"                                                                     then activity = 41; *walking;
  if UNLISTEDact = "ORINARY WALKING"                                                                  then activity = 41; *walking;
  if UNLISTEDact = "PALAUTI"                                                                          then activity = 72; *pilates;
  if UNLISTEDact = "PEDALLING WHILE SITTING ON A"                                                     then activity = 78; *bicycling, stationary, general;
  if UNLISTEDact = "PHYSICAL THERAPIST ASSIST WITH ARM AND LEG EXERCISES"                             then activity = 53; *physical therapy;
  if UNLISTEDact = "PHYSICAL THERAPIST WORKS WITH HIM ON WALKING/STRENGTHEN"                          then activity = 53; *physical therapy;
  if UNLISTEDact = "PHYSICAL THERAPY"                                                                 then activity = 53; *physical therapy;
  if UNLISTEDact = "PHYSICAL THERAPY 2/WK"                                                            then activity = 53; *physical therapy;
  if UNLISTEDact = "PILATES"                                                                          then activity = 72; *pilates;
  if UNLISTEDact = "PLAYING WITH GRANDKIDS"                                                           then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "PULL MACHINE"                                                                     then activity =  3; *crew/rowing machine;
  if UNLISTEDact = "PUSH UP"                                                                          then activity = 56; *push ups;
  if UNLISTEDact = "PUSH UPS"                                                                         then activity = 56; *push ups;
  if UNLISTEDact = "Plotting"                                                                         then activity = 72; *pilates;
  if UNLISTEDact = "RUNNING AROUND OUTSIDE WITH THE CHILDREN AS THEY PLAY BASKETBALL OR OTHER GAMES." then activity = 79; *basketball, non-game, general;
  if UNLISTEDact = "SHOOT BILLIARD GAME"                                                              then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "SIT UPS"                                                                          then activity = 50; *sit ups;
  if UNLISTEDact = "SKATING"                                                                          then activity = 39; *skating, ice;
  if UNLISTEDact = "SRTENGTH TRAINING/RANGE OF MOTION"                                                then activity = 16; *weight lifting;
  if UNLISTEDact = "STATES JUST WALK NOT FAST"                                                        then activity = 41; *walking;
  if UNLISTEDact = "STATES WALKING, BUT NOT BRISK OR VIGOROUS"                                        then activity = 41; *walking;
  if UNLISTEDact = "STATIONAY BIKE"                                                                   then activity =  8; *stationary bike;
  if UNLISTEDact = "STOMACH CRUNCHES"                                                                 then activity = 50; *sit ups;
  if UNLISTEDact = "TAE BO VIDEO"                                                                     then activity = 68; *low impact aerobics;
  if UNLISTEDact = "THE PARTICIPANT DOES NOT ACTIVITY"                                                then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "THE WII GAMES"                                                                    then activity = 75; *activity promoting video game, moderate effort;
  if UNLISTEDact = "TRAMPOLINE"                                                                       then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "TREADMILL/ BIKE"                                                                  then activity = 10; *treadmill;
  if UNLISTEDact = "UPPER EXTREMITIES EXERCISES"                                                      then activity = 16; *weight lifting;
  if UNLISTEDact = "UPPER/LOWER EXERCISES WITH THERAPIST."                                            then activity = 53; *physical therapy;
  if UNLISTEDact = "WALK"                                                                             then activity = 41; *walking;
  if UNLISTEDact = "WALKED AT AN ORDINARY PACE"                                                       then activity = 41; *walking;
  if UNLISTEDact = "WALKING"                                                                          then activity = 41; *walking;
  if UNLISTEDact = "WALKING AT A ORDINARY PACE"                                                       then activity = 41; *walking;
  if UNLISTEDact = "WALKING AT ORDINARY PACE"                                                         then activity = 41; *walking;
  if UNLISTEDact = "WALKING AT ORIDNARY PACE"                                                         then activity = 41; *walking;
  if UNLISTEDact = "WALKING BUT NOT BRISK"                                                            then activity = 41; *walking;
  if UNLISTEDact = "WALKING IN THE POOL WATER"                                                        then activity = 42; *water aerobics;
  if UNLISTEDact = "WALKING IN UP AND DOWN HALLS AT A NORMAL PACE"                                    then activity = 41; *walking;
  if UNLISTEDact = "WALKING--ORDINARY PACE"                                                           then activity = 41; *walking;
  if UNLISTEDact = "WATER AEOBRIC"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEOBRICS"                                                                   then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEORBICS"                                                                   then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AERBOICS"                                                                   then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEROBIC"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEROBICS"                                                                   then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEROBIS"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AEROIBC"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER ARBOIES"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBEICS"                                                                   then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBIC"                                                                     then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBIC CLASS"                                                               then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBICS"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBIES"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER AROBIS"                                                                     then activity = 42; *water aerobics;
  if UNLISTEDact = "WATER THERAPY"                                                                    then activity = 42; *water aerobics;
  if UNLISTEDact = "WII / WII FITNESS"                                                                then activity = 75; *activity promoting video game, moderate effort;
  if UNLISTEDact = "WII FITNESS"                                                                      then activity = 75; *activity promoting video game, moderate effort;
  if UNLISTEDact = "YARD WORK"                                                                        then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARD WORK AND GARDENING"                                                          then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARD WORK, ARMS & LEGS IN CHAIR EXER., HOUSE WORK."                               then activity = 44; *sit to be fit & chair class;
  if UNLISTEDact = "YARD WORK, CARING FOR HORSES, WALKING"                                            then activity = 41; *walking;
  if UNLISTEDact = "YARD WORK, CHOPPING WOOD FOR FIREPLACE, WALKING"                                  then activity = 41; *walking;
  if UNLISTEDact = "YARD WORK, HOUSE WORK, WASHING MY CAR"                                            then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARD WORK/GARDENING"                                                              then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARD, GARDENING WORK"                                                             then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARD/GARDENING WORK"                                                              then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YARDWORK, LOADING/UNLOADING TRUCK"                                                then activity =  .; *not a sport or leisure activity;
  if UNLISTEDact = "YOGA"                                                                             then activity = 15; *stretching/yoga;
  if UNLISTEDact = "ZUMBA"                                                                            then activity = 80; *zumba;

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

data activity; set pacb; run;

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

      if hrsPERwk1 = 1 then hrsPERwk1COPY = 'A';  
      if hrsPERwk1 = 2 then hrsPERwk1COPY = 'B';
      if hrsPERwk1 = 3 then hrsPERwk1COPY = 'C';  
      if hrsPERwk1 = 4 then hrsPERwk1COPY = 'D';
      if hrsPERwk1 = 5 then hrsPERwk1COPY = 'E';
      drop hrsPERwk1;
      rename hrsPERwk1COPY = hrsPERwk1;

      if mnthsPERyr1 = 1 then mnthsPERyr1COPY = 'A';  
      if mnthsPERyr1 = 2 then mnthsPERyr1COPY = 'B';
      if mnthsPERyr1 = 3 then mnthsPERyr1COPY = 'C';  
      if mnthsPERyr1 = 4 then mnthsPERyr1COPY = 'D';
      if mnthsPERyr1 = 5 then mnthsPERyr1COPY = 'E';
      drop mnthsPERyr1;
      rename mnthsPERyr1COPY = mnthsPERyr1;
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

      if hrsPERwk2 = 1 then hrsPERwk2COPY = 'A';  
      if hrsPERwk2 = 2 then hrsPERwk2COPY = 'B';
      if hrsPERwk2 = 3 then hrsPERwk2COPY = 'C';  
      if hrsPERwk2 = 4 then hrsPERwk2COPY = 'D';
      if hrsPERwk2 = 5 then hrsPERwk2COPY = 'E';
      drop hrsPERwk2;
      rename hrsPERwk2COPY = hrsPERwk2;

      if mnthsPERyr2 = 1 then mnthsPERyr2COPY = 'A';  
      if mnthsPERyr2 = 2 then mnthsPERyr2COPY = 'B';
      if mnthsPERyr2 = 3 then mnthsPERyr2COPY = 'C';  
      if mnthsPERyr2 = 4 then mnthsPERyr2COPY = 'D';
      if mnthsPERyr2 = 5 then mnthsPERyr2COPY = 'E';
      drop mnthsPERyr2;
      rename mnthsPERyr2COPY = mnthsPERyr2;
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

      if hrsPERwk3 = 1 then hrsPERwk3COPY = 'A';  
      if hrsPERwk3 = 2 then hrsPERwk3COPY = 'B';
      if hrsPERwk3 = 3 then hrsPERwk3COPY = 'C';  
      if hrsPERwk3 = 4 then hrsPERwk3COPY = 'D';
      if hrsPERwk3 = 5 then hrsPERwk3COPY = 'E';
      drop hrsPERwk3;
      rename hrsPERwk3COPY = hrsPERwk3;

      if mnthsPERyr3 = 1 then mnthsPERyr3COPY = 'A';  
      if mnthsPERyr3 = 2 then mnthsPERyr3COPY = 'B';
      if mnthsPERyr3 = 3 then mnthsPERyr3COPY = 'C';  
      if mnthsPERyr3 = 4 then mnthsPERyr3COPY = 'D';
      if mnthsPERyr3 = 5 then mnthsPERyr3COPY = 'E';
      drop mnthsPERyr3;
      rename mnthsPERyr3COPY = mnthsPERyr3;
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

