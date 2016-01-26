footnote1;
title1;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in event date;
/*data dates;*/
/*  set stroke1.Jhs_inc_by12(keep   = ID EVENT_ID ED12DP*/
/*                        rename = (ED12DP   = eventDate*/
/*                                  ID       = CHRT_ID*/
/*                                  EVENT_ID = ID));*/
/*  if ^missing(ID) & ^missing(eventDate);*/
/*  format eventDate MMDDYY10.;*/
/*  label  eventDate = "Event Date";*/
/*  run;*/
/**/
/**Pre-merge sort;*/
/*proc sort data = stroke.C12derv1 out = C12derv1; by ID; run;*/
/*proc sort data = dates;                          by ID; run;*/

*Read in derived events data;
data allevtraw; 
  set stroke.C12derv1; 
/*  by ID; */
/*  if in1;*/
/*  if FINAL_DX = "NO_STR" then eventDate = .; *Drop date if no event;*/
/**/
/*  eventYear = year(eventDate); */
/*    if eventYear ^= year then eventDate = .; *Drop date if the years do not match;*/
/*    drop eventYear;*/
  run;

  proc sort data = allevtraw; by CHRT_ID; run;

  /* Checks;
  proc print data = allevtraw(obs = 10); run;
  proc freq  data = allevtraw; tables final_dx*comp_dx /missing; run;
  */

*Rename ID vars;
data allevt0; set allevtraw(rename = (CHRT_ID = subjid ID = EVENT_ID)); run;

proc freq data = allevt0;
tables FINAL_DX;
run;

*Only keep those with an probable or definite stroke:
  1) FINAL_DX: DEF_EIB or DEF_IPH or DEF_SAH or DEF_TIB or EXCOND or NO_STR or POSS_STR or PROB_EIB or PROB_TIB
  2) CMIDX: DEFMI or PROBMI;
data allevt1; set allevt0( 
  where = (FINAL_DX in ('DEF_EIB' 'DEF_IPH' 'DEF_SAH' 'DEF_TIB' 'PROB_EIB' 'PROB_SAH' 'PROB_TIB')));
  run;
  *proc print data = allevt(obs = 25); run;

*Ensure only 1 event ID per event (i.e. no duplicates);
proc freq data = allevt1; 
  tables event_id /noprint out = keylist;
  run;

proc print data = keylist; where count ge 2; run; 

*Format dataset;
data allevt2; set allevt1(keep   =  EVENT_ID subjid YEAR FINAL_DX
                        rename = (YEAR = eventYear));

  *Note, no EventDate var was provided from UNC in this dataset;
  Stroke = 1;
    label Stroke = "Definite/Probable Stroke";

  EIB = (FINAL_DX = "DEF_EIB" | FINAL_DX =  "PROB_EIB"); 
    label EIB = "Definite/Probable Brain Infarction, Non-carotid Embolic (EIB)";

  TIB = (FINAL_DX = "DEF_TIB" | FINAL_DX = "PROB_TIB");
    label TIB = "Definite/Probable Brain Infarction, Thrombotic (TIB)";

  IPH = (FINAL_DX = "DEF_IPH" | FINAL_DX = "PROB_IPH");
    label IPH = "Definite/Probable Brain Hemorrhage (IPH)";

  SAH = (FINAL_DX = "DEF_SAH" | FINAL_DX = "PROB_SAH");
    label SAH = "Definite/Probable Subarachnoid Hemorrhage (SAH)";

  OHDStroke = (FINAL_DX = "OHD_STR");
    label OHDStroke = "Out of Hospital Deaths with Stroke Codes";   
  run;
  *proc print    data = allevt; *run;
  *proc contents data = allevt; *run;

*According to instructions from Dr. Adolfo Correa, SAH is not real stroke, so it should be removed from all stroke data sets
----After discussion within CCDC, still keep SAS in all stroke events data set at this stage;

data allevt3;
set allevt2;
/*if sah = 1 then delete;*/
run;

/* Merge to Stroke CELB file to get the event date */

data temp2;
set stroke.c12strc1;
keep id strc12 strc14;
rename id = event_id;
/*If hospital arrival date is not available, use discharge or death date instead, since two dates are pretty close. n = 2 missing arrival date but discharge or death date available for all stroke events */
if strc12 = . and strc14 ne . then strc12 = strc14;
run;

proc sort data = allevt3;
by event_id;
run;

data temp3;
merge allevt3(in = a) temp2 (in = b);
by event_id;
if a = b;
run;

data temp4;
set temp3;
format eventdate MMDDYY10.;
*if eventdate ne . and eventdate ne strc12;
eventdate = strc12;
*if year(eventdate)  ne eventyear;
drop strc12 strc14;
run;

proc means data = temp4 n nmiss;
var eventdate;
run;

proc sort data = temp4;
by subjid eventdate;
run;

*Remove all adjudicated events after Deceased Date if exist;

data temp5;
merge temp4 (in = a)
lostfu (keep   =  subjid lastdate);
      by subjid;
	  if a;
*check deceased date vs. events date;
	        if NOT missing(lastdate) & (eventdate - lastdate) gt 5 then flag = 1;
if flag = 1 then delete;
     drop lastdate flag;
run;

*Remove all adjudicated events after Refused Date;

data temp6;
merge temp5 (in = a)
lostfu1;
      by subjid;
	  if a;
      if NOT missing(lastdate) & (eventdate - lastdate) gt 0 then flag = 1;
if flag = 1 then delete;
     drop lastdate flag;
run;

*Data correction - add one missed adjudicated stroke event for J597818. 
                   verified from ARIC CSCC at Sep 2015;

data temp7;
set temp6;
if event_id = '2576514';
subjid = 'J597818';
event_id = '2629450';
eventdate = mdy(7, 13, 2005);
eventyear = 2005;
;
run;

data temp8;
set temp6 temp7;
run;

proc sort data = temp8;
by subjid;
run;

data events.allevtstroke;
retain subjid EVENT_ID eventdate eventYear; 
set temp8;
          format Stroke EIB TIB IPH SAH OHDStroke ynfmt.;
run;

  *Delete unused data sets;

proc datasets lib = work;
save lostfu lostfu1 ltfu;
run;
