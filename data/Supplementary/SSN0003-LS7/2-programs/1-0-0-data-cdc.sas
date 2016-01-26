*NOTE: Missingness is handled using a similar method as the Bell paper;

**************************************************************************************************;
*Step 1) Define Activity Levels (Low, Mod, Vig) for JHS data;
**************************************************************************************************;
  
  *Assign activity levels to activities from J-PAC form;
  data JHSacts;
    set JHSacts;

    actLevel1 = .;
    if CDC_ACSM_Category = 'Low' then actLevel1 = 1;
    if CDC_ACSM_Category = 'Mod' then actLevel1 = 2;
    if CDC_ACSM_Category = 'Vig' then actLevel1 = 3;

    actLevel2 = .;
    if CDC_ACSM_Category = 'Low' then actLevel2 = 1;
    if CDC_ACSM_Category = 'Mod' then actLevel2 = 2;
    if CDC_ACSM_Category = 'Vig' then actLevel2 = 3;

    actLevel3 = .;
    if CDC_ACSM_Category = 'Low' then actLevel3 = 1;
    if CDC_ACSM_Category = 'Mod' then actLevel3 = 2;
    if CDC_ACSM_Category = 'Vig' then actLevel3 = 3;
    run;

  *Merge in JHS activity level data;

  data CDCactivity; set activity; run;

    *Activity 1;
    proc sort data = CDCactivity; by activity1; run;
    proc sort data = JHSacts;     by activity1; run;
    
    data CDCactivity;
      merge CDCactivity
            JHSacts (keep = activity1 act1NAME actLevel1);
      by activity1;

      if missing(subjid) then delete;
      run;

    *Activity 2;
    proc sort data = CDCactivity; by activity2; run;
    proc sort data = JHSacts;     by activity2; run;

    data CDCactivity;
      merge CDCactivity
            JHSacts (keep = activity2 act2NAME actLevel2);
      by activity2;

      if missing(subjid) then delete;
      run;

    *Activity 3;
    proc sort data = CDCactivity; by activity3; run;
    proc sort data = JHSacts;     by activity3; run;

    data CDCactivity;
      merge CDCactivity
            JHSacts (keep = activity3 act3NAME actLevel3);
      by activity3;

      if missing(subjid) then delete;
      run;


**************************************************************************************************;
*Step 2) Implement algorithm from Bell paper;
**************************************************************************************************;

  proc sort data = CDCactivity; by subjid; run;

  data CDCactivity;
    set CDCactivity;

    *Getting hrs/wk and weeks/yr of activities****************************************************;

      *Activity 1;
         hourweek1 = 0;
           if hrsPERwk1 = 'A' then hourweek1 = 0.5;  
           if hrsPERwk1 = 'B' then hourweek1 = 1.5;
           if hrsPERwk1 = 'C' then hourweek1 = 2.5;  
           if hrsPERwk1 = 'D' then hourweek1 = 3.5;
           if hrsPERwk1 = 'E' then hourweek1 = 4.5;

         label hourweek1 = "Hours per Week of Activity 1";

         weekyear1 = 0;
           if mnthsPERyr1 = 'A' then weekyear1 = 0.04; 
           if mnthsPERyr1 = 'B' then weekyear1 = 0.17;
           if mnthsPERyr1 = 'C' then weekyear1 = 0.42; 
           if mnthsPERyr1 = 'D' then weekyear1 = 0.67;
           if mnthsPERyr1 = 'E' then weekyear1 = 0.92;

         activeTime1 = hourweek1*weekyear1;

         label weekyear1   = "Ratio of Weeks per Year of Activity 1";
         label activeTime1 = "Adjusted Hours per Week Activity 1";


      *Activity 2;
         hourweek2 = 0;
           if hrsPERwk2 = 'A' then hourweek2 = 0.5;  
           if hrsPERwk2 = 'B' then hourweek2 = 1.5;
           if hrsPERwk2 = 'C' then hourweek2 = 2.5;  
           if hrsPERwk2 = 'D' then hourweek2 = 3.5;
           if hrsPERwk2 = 'E' then hourweek2 = 4.5;

         label hourweek2 = "Hours per Week of Activity 2";

         weekyear2 = 0;
           if mnthsPERyr2 = 'A' then weekyear2 = 0.04; 
           if mnthsPERyr2 = 'B' then weekyear2 = 0.17;
           if mnthsPERyr2 = 'C' then weekyear2 = 0.42; 
           if mnthsPERyr2 = 'D' then weekyear2 = 0.67;
           if mnthsPERyr2 = 'E' then weekyear2 = 0.92;

         activeTime2 = hourweek2*weekyear2;

         label weekyear2   = "Ratio of Weeks per Year of Activity 2";
         label activeTime2 = "Adjusted Hours per Week Activity 2"; 


      *Activity 3;
         hourweek3 = 0;
           if hrsPERwk3 = 'A' then hourweek3 = 0.5;  
           if hrsPERwk3 = 'B' then hourweek3 = 1.5;
           if hrsPERwk3 = 'C' then hourweek3 = 2.5;  
           if hrsPERwk3 = 'D' then hourweek3 = 3.5;
           if hrsPERwk3 = 'E' then hourweek3 = 4.5;

         label hourweek3 = "Hours per Week of Activity 3";

         weekyear3 = 0;
           if mnthsPERyr3 = 'A' then weekyear3 = 0.04; 
           if mnthsPERyr3 = 'B' then weekyear3 = 0.17;
           if mnthsPERyr3 = 'C' then weekyear3 = 0.42; 
           if mnthsPERyr3 = 'D' then weekyear3 = 0.67;
           if mnthsPERyr3 = 'E' then weekyear3 = 0.92;

         activeTime3 = hourweek3*weekyear3;

         label weekyear3   = "Ratio of Weeks per Year of Activity 3";
         label activeTime3 = "Adjusted Hours per Week Activity 3"; 


    *Creating vigorous and moderate activity variables********************************************;

      *Activity 1;
        vigActTime1 = 0;
        modActTime1 = 0;
        lowActTime1 = 0;
             if actLevel1 = 3 then do; vigActTime1 = activeTime1; end;
        else if actLevel1 = 2 then do; modActTime1 = activeTime1; end;
        else if actLevel1 = 1 then do; lowActTime1 = activeTime1; end;
        else                       do; vigActTime1 = 0;  
                                       modActTime1 = 0;           
                                       lowActTime1 = 0;           end;

        label vigActTime1 = "Vigorous Active Time of Activity 1";
        label modActTime1 = "Moderate Active Time of Activity 1";
        label lowActTime1 = "Low Active Time of Activity 1";


      *Activity 2;
        vigActTime2 = 0;
        modActTime2 = 0;
        lowActTime2 = 0;
             if actLevel2 = 3 then do; vigActTime2 = activeTime2; end;
        else if actLevel2 = 2 then do; modActTime2 = activeTime2; end;
        else if actLevel2 = 1 then do; lowActTime2 = activeTime2; end;
        else                       do; vigActTime2 = 0;  
                                       modActTime2 = 0;           
                                       lowActTime2 = 0;           end;

        label vigActTime2 = "Vigorous Active Time of Activity 2";
        label modActTime2 = "Moderate Active Time of Activity 2";
        label lowActTime2 = "Low Active Time of Activity 2";


      *Activity 3;
        vigActTime3 = 0;
        modActTime3 = 0;
        lowActTime3 = 0;
             if actLevel3 = 3 then do; vigActTime3 = activeTime3; end;
        else if actLevel3 = 2 then do; modActTime3 = activeTime3; end;
        else if actLevel3 = 1 then do; lowActTime3 = activeTime3; end;
        else                       do; vigActTime3 = 0;  
                                       modActTime3 = 0;           
                                       lowActTime3 = 0;           end;

        label vigActTime3 = "Vigorous Active Time of Activity 3";
        label modActTime3 = "Moderate Active Time of Activity 3";
        label lowActTime3 = "Low Active Time of Activity 3";


    *Sum of vigorous, moderate, and vig+mod*******************************************************;
    vigActTime = sum(vigActTime1, vigActTime2, vigActTime3)*60; *Convert from hours to minutes;
    label vigActTime = "Minutes per Week of Vigorous Activity";

    modActTime = sum(modActTime1, modActTime2, modActTime3)*60; *Convert from hours to minutes;
    label modActTime = "Minutes per Week of Moderate Activity";

    lowActTime = sum(lowActTime1, lowActTime2, lowActTime3)*60; *Convert from hours to minutes;
    label lowActTime = "Minutes per Week of Low Activity";

    vigModActTime = sum(vigActTime, modActTime);
    label vigModActTime = "Minutes per Week of Vigorous or Moderate Activity";


    *Create Simple 7 Physical Activity Variable**************************************************;
    PA3cat = .;
      if    vigActTime = 0 & 
            modActTime = 0 & 
         vigModActTime = 0                                   then PA3cat = 0;

      if (0 < vigActTime  & vigActTime  <  75) | 
         (0 < modActTime  & modActTime  < 150) | 
         (0 < vigModActTime & vigModActTime < 150)           then PA3cat = 1;

      if   (vigActTime  >= 75  & NOT missing(vigActTime) ) | 
           (modActTime  >= 150 & NOT missing(modActTime) ) | 
         (vigModActTime >= 150 & NOT missing(vigModActTime)) then PA3cat = 2;

    format PA3cat LSS3cat.;
    label  PA3cat = "AHA Physical Activity Categorization";

    *Create Physical Activity Ideal Health Indicator Variable**************************************************;
    idealHealthPA = .;
      if PA3cat in (0 1) then idealHealthPA = 0;
      if PA3cat in (2)   then idealHealthPA = 1;
    
    format idealHealthPA YNfmt.;
    label  idealHealthPA = "Indicator for Ideal Health via Physical Activity";
    run;
