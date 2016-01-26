footnote1;
title1;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in derived events data;
data allevtraw; set CHD.C12evt1; run;
  /* Checks;
  proc print data = allevtraw(obs = 10); run;
  proc freq  data = allevtraw; tables CFATALDX*CMIDX /missing; run;
  */

*Rename ID vars;
data allevt0; set allevtraw(rename = (CHRT_ID = subjid ID = EVENT_ID)); run;

*Only keep those with an MI or Fatal CHD event:
  1) CFATALDX: DEFFATCHD or DEFFATMI OR
  2) CMIDX: DEFMI or PROBMI;
data allevt1; set allevt0( 
  where = (CFATALDX in ('DEFFATCHD' 'DEFFATMI') OR
           CMIDX    in ('DEFMI'     'PROBMI'  )));
  run;
  *proc print data = allevt(obs = 25); *run;

*Ensure only 1 event ID per event (i.e. no duplicates);
proc freq data = allevt1; 
  tables event_id /noprint out = keylist;
  run;

proc print data = keylist; where count ge 2; run; 

*Format dataset;
data allevt2; set allevt1(keep   =  EVENT_ID subjid CEVTDAT3 CFATALDX CMIDX
                        rename = (CEVTDAT3 = eventDate));

  EventYear = year(eventDate);
  FatalCHD  = (CFATALDX = "DEFFATCHD" or CFATALDX = "DEFFATMI");
  MI        = (CMIDX    = "DEFMI"      or CMIDX    = "PROBMI"); 
  run;
  /*Checks;
    proc print    data = allevt; run;
    proc contents data = allevt; run;
    proc freq data = allevt; 
      tables CFATALDX*CMIDX;
      tables FatalCHD*MI /norow nocol;
      run;
  */

*Data correction - set incorrect adjudicated fatal status to ‘NONFAT’-Non fatal hospitalization. 
                   verified from ARIC CSCC at Sep 2015
                   ptcpt has AFU contact in 2013
                   definite MI status (CMIDX) has been verified via JHS abstractor;
  data allevt3;
    set allevt2;
    if subjid = 'J516715' & EVENT_ID = '3392924' then CFATALDX = "NONFAT";
    run;

*Save all events;
proc sort data = allevt3; by subjid eventDate; run;

*Remove all adjudicated events after Deceased Date;

data allevt4;
merge allevt3 (in = a)
lostfu (keep   =  subjid lastdate);
      by subjid;
	  if a;
* 5 days are used here due to the fact that some death date is specified one day earlier than event date;
      if NOT missing(lastdate) & (eventdate - lastdate) gt 5 then flag = 1;
*      if NOT missing(lastdate) & eventdate > lastdate then flag = 1;
     drop lastdate flag;
	 if flag = 1 then delete;
*if flag = 1;
run;

*Remove all adjudicated events after Refused Date;

data allevt5;
merge allevt4 (in = a)
lostfu1;
      by subjid;
	  if a;
      if NOT missing(lastdate) & eventdate > lastdate then flag = 1;
     drop lastdate flag;
	 if flag = 1 then delete;
*if flag = 1;
run;

data events.allevtCHD; set allevt5; 
          format FatalCHD MI ynfmt.;
run;

*Delete unused data sets;

proc datasets lib = work;
save lostfu lostfu1 ltfu;
run;
