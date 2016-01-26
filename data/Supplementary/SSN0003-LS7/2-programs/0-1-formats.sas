*Construct formats;
proc format library = dat;
  value activity
    1	 = "aerobic dance"
    2  = "bicycling"
    3	 = "crew/rowing machine"
    4	 = "cross country skiing or ski machine"
    5	 = "hiking/back packing"
    6	 = "running/jogging"
    7	 = "stairclimber"
    8	 = "stationary bike"
    9	 = "swimming"
    10 = "treadmill"
    11 = "vigorous walking"
    12 = "calisthenics"
    13 = "circuit training"
    14 = "nautilus"
    15 = "stretching/yoga"
    16 = "weight lifting"
    17 = "badminton"
    18 = "racquetball"
    19 = "tennis"
    20 = "canoeing/kayaking"
    21 = "diving"
    22 = "sailing"
    23 = "waterskiing"
    24 = "windsurfing/bodysurfing"
    25 = "African, Haitian dance"
    26 = "ballet (modern or jazz)"
    27 = "folk or social dance"
    28 = "other dance"
    29 = "basketball"
    30 = "field hockey/lacrosse"
    31 = "soccer"
    32 = "softball"
    33 = "volleyball"
    34 = "bowling"
    35 = "golf"
    36 = "gymnastics"
    37 = "horseback riding"
    38 = "martial arts"
    39 = "ice skating"
    40 = "downhill skiing"
    41 = "walking"
    42 = "water aerobics"
    43 = "officiating sports"
    44 = "sit to be fit & chair class"
    45 = "home aerobic machine"
    46 = "hunting"
    47 = "stretching around house"
    48 = "baseball"
    49 = "ping pong (table tennis)"
    50 = "sit ups"
    51 = "fishing"
    52 = "taebo"
    53 = "physical therapy"
    54 = "coaching sports"
    55 = "climb bleachers"
    56 = "push ups"
    57 = "hot air ballooning"
    58 = "ab machine (slider)"
    59 = "Gazell elliptical machine"
    60 = "total gym"
    61 = "kick boxing"
    62 = "football"
    63 = "cardio training"
    64 = "leg pressor"
    65 = "spinning"
    66 = "glider"
    67 = "step aerobics"
    68 = "low impact aerobics"
    69 = "arm and/or leg exercise"
    70 = "flag football"
    71 = "drumming"
    72 = "pilates"
    73 = "therapeutic exercise ball, Fitball exercise"
    74 = "activity promoting video game, light effort"
    75 = "activity promoting video game, moderate effort"
    76 = "Curves exercise routines in women"
    77 = "health club exercise, general"
    78 = "bicycling, stationary, general"
    79 = "basketball, non-game, general"
    80 = "zumba";

  value LSS3cat
    0 = "Poor Health"
    1 = "Intermediate Health"
    2 = "Ideal Health";

  value visit
    1 = "Exam 1"
    2 = "Exam 2"
    3 = "Exam 3";

  value YNfmt
    0 = "No"
    1 = "Yes";

  value $JH_YNV
    'N' = 'N. No'
    'Y' = 'Y. Yes';

  value $PACARAV
    'A' = 'A. Less than one month'
    'B' = 'B. 1 to 3 months'
    'C' = 'C. 4 to 6 months'
    'D' = 'D. 7 to 9 months'
    'E' = 'E. More than 9 months';

  value $PACARBV
    'A' = 'A. Less than 1 hour'
    'B' = 'B. At least 1 but less than 2 hours'
    'C' = 'C. At least 2 but less than 3 hours'
    'D' = 'D. At least 3 but less than 4 hours'
    'E' = 'E. 4 or more hours';

  value PACBR1V
    1 = '1. Less than one month'
    2 = '2. 1 to 3 months'
    3 = '3. 4 to 6 months'
    4 = '4. 7 to 9 months'
    5 = '5. More than 9 months'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACBR3V
    1 = '1. Less than 1 hr'
    2 = '2. At least 1 but less than 2 hrs'
    3 = '3. At least 2 but less than 3 hrs'
    4 = '4. At least 3 but less than 4 hrs'
    5 = '5. 4 hrs or more'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value edu
    1 = "Less than high school"
    2 = "High school graduate"
    3 = "GED"
    4 = "Some vocational or trade school, but no certificates"
    5 = "Vocational or trade certificate "
    6 = "Some college, but no degree "
    7 = "Associate degree"
    8 = "Bachelor’s degree"
    9 = "Graduate or professional schools";

  value medAcct
    0 = "Incomplete recording of participant's medication use during  two weeks preceding the clinic visit"
    1 = "Participant reported that no medication had been taken in 2 weeks preceeding the clinic visit"
    2 = "Complete recording of all participant's medication use during the two weeks preceding the clinic visit";

  value HbA1c3cat
    0 = "Normal"
    1 = "At Risk"
    2 = "Diabetic";

  value fpg3cat
    0 = "Normal"
    1 = "At Risk"
    2 = "Diabetic";

  value diab3cat 
    0 = "Non-Diabetic"
    1 = "Pre-Diabetic"
    2 = "Diabetic";

  run;
