footnote1;
title1;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in incident event dataset;
data incevtraw; 
set STROKE.jhs_inc_by12; 
/*if id not in ('J500324', 'J519778', 'J543043', 'J553528', 'J558277');*/
run;
  /*Checks;
  proc contents data = incevtraw; run;
  proc print    data = incevtraw(obs = 10); run;
  */

*Rename ID vars;
data incevt0; set incevtraw(rename = (id = subjid)); run;
  /*How many different types of events are there?;
  proc freq data = incevtraw; 
    tables IN12DP*IN12HEM*IN12ISC /list missing;
    run;
  */

*Define necessary event information: 
  1) Event indicator 
  2) Time-to-event;
data incevt1; set incevt0(keep   =  subjid ED12DP IN12DP IN12ISC IN12HEM
                        rename = (ED12DP = eventDate));
  EventYear = year(eventDate);
  stroke    = IN12DP; *Ischemic Stroke / Hemm. Stroke;
  drop IN12DP;
  run;
  /*Checks;
  proc print    data = incevt(obs = 10); run;
  proc contents data = incevt; run;
  */

**************************************************************************************************;
** Step 2) Combine with JHS censoring (LTFU) data;
**************************************************************************************************;

*proc print data = ltfu  (obs = 10); run;
*proc print data = incevt(obs = 10); run;
proc sort data = LTFU;                           by subjid; run;
proc sort data = incevt1;                         by subjid; run;
proc sort data = cohort.visitdat out = visitdat; by subjid; run; 
data incevt2; merge LTFU incevt1 visitdat(keep = subjid V1date); by subjid; run;
*proc print data = incevt(obs = 10); run;

*Only keep incident events ocurring inside the JHS study time period;
*proc print data = incevt(where = (eventDate < V1date & stroke = 1)); run;
data incevt3; set incevt2;
  strokeHistory = (stroke = 1 & (V1date > eventDate));
  if strokeHistory = 1 then do; *Set stroke to missing if history of stroke;
    stroke = .; 
    date   = .; 
    year   = .;
    type   = "Previous Stroke";
    end;
  run;
  /*Check;
  proc freq data = incevt;
    tables stroke*IN12HEM*IN12ISC /list missing;
    run;
  */

**************************************************************************************************;
** Step 3) Set survival analysis variables;
**************************************************************************************************;

data incevt4; format strokeType contactType $21.; set incevt3;

  *Stroke indicators;
  isc  = IN12ISC*stroke;
  hemm = IN12HEM*stroke;

  *Stroke classification variable;
  if isc  then strokeType = "Ischemic Stroke";
  if hemm then strokeType = "Hemorrhagic Stroke";

  *Contact type variable;
  contactType = laststatus;

  *overall event indicator and dates;

    *NON-Events;
    if stroke = 0 then do;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *date = lastDate;   *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *date = lastDate2; *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      date = lastDate3; *For non-deceased participants: Uses admin censoring date;
      year = year(date);
      contactType = "Censored";
      end;

    *Events;
    if stroke = 1 then do; 
      date        = eventDate;
      year        = eventYear;
      contactType = strokeType;
      end;

    *Previous Events (via ARIC surveillance);
    if stroke = . then do; 
      date        = .;
      year        = .;
      contactType = "Previous Stroke";
      end;

 	*Incident Events that happened after hard refusal are re-coded;
	if laststatus = 'Refused' and stroke = 1 and eventdate gt lastdate3 then do;
	  stroke = 0;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *date = lastDate;   *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *date = lastDate2; *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      date = lastDate3; *For non-deceased participants: Uses admin censoring date;
      year = year(date);
      contactType = "Censored";
      end;

  *Time vars;
  days  = date - V1date;
  years = days/365.25;
  run;
  /*Checks;
  proc print      data = incevt(obs = 10); run;
  proc means      data = incevt(keep = days years) n nmiss min max; run;
  proc univariate data = incevt(keep = years) plots; run;
  */

**************************************************************************************************;
** Step 4) Merge with JHS V1 data: previous events self-report;
**************************************************************************************************;

proc sort data = incevt4;                             by subjid; run;
proc sort data = analysis.analysis1 out = analysis1; by subjid; run;

data incevt5; 
  merge incevt4   (in   = in1) 
        analysis1(keep = subjid strokeHx);  
  by subjid; 
  if strokeHx = 1 & ^missing(stroke) then do; *Set stroke to missing if history of stroke;
    stroke      = .; 
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Previous Stroke Hx";
    end; 
  run;
  /*Check;
  proc freq data = incevt; 
    tables strokeType*contactType*stroke /list missing;
    run;
  */

*Keep final vars;
data incevt6(keep = subjid stroke V1date date year days years contactType); 
  retain subjid stroke V1date date year days years contactType; 
  set incevt5;

  format year      4.0;
  format days      4.0;
  format date mmddyy10.;
  format V1date mmddyy10.;
  label  V1date = ' ';
  run;
  /*Checks;
  proc print data = incevt1(obs = 10); run;
  proc freq  data = incevt1; 
    tables stroke*contactType /missing;
    run;
  */

*Remove all incident adjudicated events after Deceased Date;

data incevt61;
merge incevt6 (in = a) 
lostfu (keep   =  subjid lastdate);
      by subjid;
	  if a;
* 5 days are used here due to the fact that some death date is specified one day earlier than event date;
       if NOT missing(lastdate) & (date - lastdate) gt 5 & stroke = 1 then do;
	   stroke = 0;
	   date = lastdate;
	   year = year(date);
       days  = date - V1date;
       years = days/365.25;
	   contactType = 'Censored';
	   flag = 1;
	   end;
*	   if flag = 1;
     drop lastdate flag;
run;

proc freq data = incevt61;
tables stroke * contacttype/list missing;
where date = v1date;
run;

data incevt7;
set incevt61;
if date = v1date then do;
    stroke      = .;
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Refused";
*	output;
end;
*Data correction - add one missed adjudicated stroke event for J597818. 
                   verified from ARIC CSCC at Sep 2015;
if subjid = 'J597818' then do;
	   stroke = 1;
	   date = mdy(7, 13, 2005);
	   year = year(date);
       days  = date - V1date;
       years = days/365.25;
	   contactType = 'Ischemic Stroke';
end;
run;

/* Correct Stroke Type based on all stroke event data set information */;

data incevt71 incevt72 (rename = (date = eventdate));
set incevt7;
if stroke in (0, .) then output incevt71;
else output incevt72;
run;

data incevt73;
merge incevt72(in = a) events.allevtstroke (in = b keep = subjid eventdate eib tib iph sah);
by subjid eventdate;
if a = b;
run;

data incevt74;
set incevt73;
if eib | tib then contactType = 'Ischemic Stroke';
if iph then contactType = 'Hemorrhagic Stroke';
if sah then contactType = 'SAH';
rename eventdate = date;
run;

proc freq data = incevt74;
tables eib * tib * iph * sah * contacttype/list missing;
run;

data incevt75;
set incevt71 incevt74 (drop = eib tib iph sah);
run;

proc sort data = incevt75;
by subjid;
run;

/*
*According to instructions from Dr. Adolfo Correa, SAH is not real stroke, so it should be removed from all stroke data sets, and it will also affect one INCEVTSTROKE with
subjid 'J536127', incident stroke 1 changed to 0 ----After discussion within CCDC, still keep SAS in all stroke events data set at this stage;

data ltfutemp;
set ltfu;
if subjid = 'J536127';
keep subjid lastdate lastdate2 lastdate3;
run;

data incevt3;
merge incevt2 ltfutemp (in = a);
by subjid;
if a then do;
	   stroke = 0;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      date = lastDate;   *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *date = lastDate2; *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      *date = lastDate3; *For non-deceased participants: Uses admin censoring date;
	   year = year(date);
       days  = date - V1date;
       years = days/365.25;
	   contactType = 'Censored';
end;
drop lastdate lastdate2 lastdate3;
run;
*/
data incevt8;
retain subjid stroke V1date date year years days contactType;
set incevt75;
*set incevt3;
          label stroke = "Incidence Stroke";
          label V1date = "V1DATE: Date of Exam 1 Clinic Visit";
          label date = "Event or Censoring Date";
          label year = "Event or Censoring Year";
          label days = "Follow-up Days";
          label years = "Follow-up Years";
          label contactType = "Last Contact Type";
run;

**************************************************************************************************;
** Step 5) Save SAS/Stata dataset;
**************************************************************************************************;

*Save SAS dataset;
data events.incevtSTROKE; 
set incevt8; 
          format stroke ynfmt.;
run;

/**Data correction - For J597818 and J563637, both patients may have stroke events before 12/31/2011, still in the verification process from UNC, at this stage, set as missing;*/
/**/
/*data events.incevtSTROKE;*/
/*retain subjid stroke v1date date year days years contacttype;*/
/*format contacttype $30.;*/
/*set events.incevtSTROKE;*/
/*if subjid in ('J597818', 'J563637') then do;*/
/*    stroke      = .; */
/*    date        = .; */
/*    year        = .; */
/*    days        = .; */
/*    years       = .;*/
/*    contactType = "Uncertain Final Stroke Status";*/
/*end;*/
/*          format Stroke ynfmt.;*/
/*run;*/

proc datasets lib = work;
save lostfu lostfu1 ltfu;
run;

/*
*Data correction - For J255078, the originally specified incidence stroke event on 08/31/2011 (event id 3725286) is SAH, according to instructions from Dr. Adolfo Correa, SAH is not real stroke
this subject has another real stroke event on 11/22/2011 (event id 3631317), so we hard code the incidence event date and correct it 
----After discussion within CCDC, still keep SAS in all stroke events data set at this stage;

data events.incevtSTROKE;
set events.incevtSTROKE;
if subjid in ('J255078') then do;
    stroke      = 1; 
    date        = mdy(11, 22, 2011); 
    year        = year(date); 
    days  = date - V1date;
    years = days/365.25;
end;
run;

*Delete unused data sets;
*/
