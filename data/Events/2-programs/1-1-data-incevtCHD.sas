footnote1;
title1;

* Part I: Generate CHD Incident Event Data Set;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in incident event dataset;
data incevtraw; 
set CHD.jhs_inc_by12; 
/*if id not in ('J500324', 'J519778', 'J543043', 'J553528', 'J558277');*/
run;
  /*Checks;
  proc contents data = incevtraw; run;
  proc print    data = incevtraw(obs = 10); run;
  */

*Rename ID vars;
data incevt0; set incevtraw(rename = (id = subjid)); run;
  /*How many different types of events are there?;
  proc freq data = incevt; 
    tables IN_by11P*SOURCIP /missing;
    run;
  */

*Define necessary event information: 
  1) Event indicator 
  2) Time-to-event;
data incevt1; set incevt0(keep   =  subjid IN_BY12P ENDDATEP SourcIP
                        rename = (ENDDATEP = eventDate));
  EventYear = year(eventDate);
  CHD = IN_BY12P; *Fatal CHD / MI / Cardiac Proc;
  drop IN_BY12P;
  run;
  /*Checks;
  proc print    data = incevt(obs = 10); run;
  proc contents data = incevt; run;
  */

**************************************************************************************************;
** Step 2) Combine with JHS censoring (LTFU) data;
**************************************************************************************************;

*proc print data = LTFU  (obs = 10); run;
*proc print data = incevt(obs = 10); run;
proc sort data = LTFU;                           by subjid; run;
proc sort data = incevt1;                         by subjid; run;
proc sort data = cohort.visitdat out = visitdat; by subjid; run; 
data incevt2; merge LTFU incevt1 visitdat(keep = subjid V1date); by subjid; run;
*proc print data = incevt(obs = 10); run;

*Only keep incident events ocurring inside the JHS study time period;
*proc print data = incevt(where = (eventDate < V1date & CHD = 1)); run;
data incevt3; set incevt2;
  CHDhistory = (CHD = 1 & (V1date > eventDate));
  if CHDhistory = 1 then do; *Set CHD to missing if history of CHD;
    CHD  = .; 
    date = .; 
    year = .;
    type = "Previous CHD";
    end;
  run;
  /*Check;
  proc freq data = incevt; 
    tables CHD*SourcIP /missing;
    run;
  */

**************************************************************************************************;
** Step 3) Set survival analysis variables;
**************************************************************************************************;

data incevt4; format CHDtype contactType $21.; set incevt3;
  *CHD indicators;
  MI          = (SourcIP = "MI")    *CHD;
  FatalCHD    = (SourcIP = "FATCHD")*CHD;
  CardiacProc = (SourcIP = "PROC")  *CHD;

  *CHD classification variable;
  if CardiacProc then CHDtype = "CHD - Cardiac Proc";
  if FatalCHD    then CHDtype = "CHD - Fatal";
  if MI          then CHDtype = "CHD - MI";

  *Contact type variable;
  contactType = laststatus;

  *Overall event indicator and dates;

    *NON-Events;
    if chd = 0 then do;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *date = lastDate;   *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *date = lastDate2; *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      date = lastDate3; *For non-deceased participants: Uses admin censoring date;
      year = year(date);
      contactType = "Censored";
      end;

    *Events;
    if chd = 1 then do; 
      date        = EventDate;
      year        = EventYear;
      contactType = CHDtype;
      end;

    *Previous Events (via ARIC surveillance);
    if chd = . then do; 
      date        = .;
      year        = .;
      contactType = "Previous CHD";
      end;

	*Incident Events that happened after hard refusal are re-coded;
    if laststatus = 'Refused' and chd = 1 and eventdate gt lastdate3 then do;
	  chd = 0;
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
  merge incevt4   (in = in1) 
        analysis1(keep = subjid CHDhx);  
  by subjid; 
  if CHDhx = 1 & ^missing(CHD) then do; *Set CHD to missing if history of CHD;
    CHD         = .; 
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Previous CHD Hx";
    end; 
  run;

  /*Check;
  proc freq data = incevt; 
    tables CHDtype*ContactType*CHDhx*CHD /list missing;
    run;
  */

*Keep final vars;
data incevt6(keep = subjid CHD V1date date year years days contactType);  
  retain subjid CHD V1date date year years days contactType;
  set incevt5;

  format year      4.0;
  format days      4.0;
  format date      mmddyy10.;
  format V1date mmddyy10.;
  label  V1date = ' ';
  run;
  /*Checks;
  proc print data = incevt1(obs = 10); run;
  proc freq  data = incevt1; 
    tables CHD*ContactType /missing;
    run;
  */

*Remove all incident adjudicated events after Deceased Date;

data incevt61;
merge incevt6 (in = a) 
lostfu (keep   =  subjid lastdate);
      by subjid;
	  if a;
* 5 days are used here due to the fact that some death date is specified one day earlier than event date;
       if NOT missing(lastdate) & (date - lastdate) gt 5 & chd = 1 then do;
	   chd = 0;
	   date = lastdate;
	   year = year(date);
       days  = date - V1date;
       years = days/365.25;
	   contactType = 'Censored';
	   flag = 1;
	   end;
     drop lastdate flag;
*if flag = 1;
run;

proc freq data = incevt61;
tables chd * contacttype/list missing;
where date = v1date;
run;

data incevt7;
set incevt61;
if date = v1date then do;
    chd         = .;
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Refused";
*	output;
end;
run;

*Delete unused data sets;

proc datasets lib = work;
save lostfu lostfu1 ltfu incevt7;
run;

* Part II: Generate Hard CHD Incident Event Data Set;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in incident event dataset;
data hardraw; 
set CHD.jhs_inc_by12; 
/*if id not in ('J500324', 'J519778', 'J543043', 'J553528', 'J558277');*/
run;
 /*Checks;
  proc contents data = hardraw; run;
  proc print    data = hardraw(obs = 10); run;
 */

*Rename ID vars;
data hard0; set hardraw(rename = (id = subjid)); run;
  /*How many different types of events are there?;
  proc freq data = hard; 
    tables INC_by11*SOURCINC /missing;
    run;*/


*Define necessary event information: 
  1) Event indicator 
  2) Time-to-event;
data hard1; set hard0(keep   =  subjid INC_by12 ENDDATE SOURCINC
                    rename = (ENDDATE = eventDate));
  EventYear = year(eventDate);
  HardCHD = INC_by12; *hard CHD;
  drop INC_by12;
  run;
 /*Checks;
  proc print    data = hard(obs = 10); run;
  proc contents data = hard; run;*/

**************************************************************************************************;
** Step 2) Combine with JHS censoring (LTFU) data;
**************************************************************************************************;

/*proc print data = LTFU  (obs = 10); run;
*proc print data = hard  (obs = 10); run;*/
proc sort data = LTFU;                           by subjid; run;
proc sort data = hard1;                           by subjid; run;
proc sort data = cohort.visitdat out = visitdat; by subjid; run; 
data hard2; merge LTFU hard1 visitdat(keep = subjid V1date); by subjid; run;
*proc print data = hard(obs = 10); run;

/*Only keep incident events ocurring inside the JHS study time period;
proc print data = hard(where = (eventDate < V1date & hardCHD = 1)); run;*/

data hard3; set hard2;
  HardCHDhistory = (hardCHD = 1 & (V1date > eventDate));
  if hardCHDhistory = 1 then do; *Set CHD to missing if history of CHD;
    hardCHD  = .; 
    date = .; 
    year = .;
    type = "Previous hardCHD";
    end;
  run;

  /*Check;
  proc freq data = hard; 
    tables hardCHD*SOURCINC /missing;
    run;
  */

**************************************************************************************************;
** Step 3) Set survival analysis variables;
**************************************************************************************************;

data hard4; format hardCHDtype type $21.; set hard3;
  *hardCHD indicators;
  MI          = (SOURCINC = "MI")    *hardCHD;
  FatalCHD    = (SOURCINC = "FATCHD")*hardCHD;
 
  *hardCHD classification variable;
  if FatalCHD    then hardCHDtype = "CHD - Fatal";
  if MI          then hardCHDtype = "CHD - MI";

  *Contact type variable;
  contactType = laststatus;

  *Overall event indicator and dates;

    *NON-Events;
    if hardCHD = 0 then do;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *date = lastDate;   *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *date = lastDate2; *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      date = lastDate3; *For non-deceased participants: Uses admin censoring date;
      year = year(date);
      contactType = "Censored";
      end;

    *Events;
    if hardCHD = 1 then do; 
      date        = EventDate;
      year        = EventYear;
      contactType = hardCHDtype;
      end;

    *Previous Events (via ARIC surveillance);
    if hardCHD = . then do; 
      date        = .;
      year        = .;
      contactType = "Previous hardCHD";
      end;

	*Incident Events that happened after hard refusal are re-coded;
    if laststatus = 'Refused' and hardchd = 1 and eventdate gt lastdate3 then do;
	  hardchd = 0;
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
  *Checks;
  proc print      data = hard4(obs = 10); run;
  proc means      data = hard4(keep = days years) n nmiss min max; run;
  proc univariate data = hard4(keep = years) plots; run;


**************************************************************************************************;
** Step 4) Merge with JHS V1 data: previous events self-report;
**************************************************************************************************;

proc sort data = hard4;                               by subjid; run;
proc sort data = analysis.analysis1 out = analysis1; by subjid; run;

data hard5; 
  merge hard4   (in = in1) 
        analysis1(keep = subjid CHDhx);  
  by subjid; 
  if CHDhx = 1 & ^missing(hardCHD) then do; *Set CHD to missing if history of CHD;
    hardCHD     = .; 
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Previous CHD Hx";
    end; 
  run;

*Keep final vars;
data hard6(keep = subjid hardCHD V1date date year years days contactType);  
  retain subjid hardCHD V1date date year years days contactType;
  set hard5;

  format year   4.0;
  format days   4.0;
  format date   mmddyy10.;
  format V1date mmddyy10.;
  label  V1date = ' ';
  run;
  /*Checks;
  proc print data = hard1(obs = 10); run;
  proc freq  data = hard1; 
    tables hardCHD*ContactType /missing;
    run;
  */

*Remove all incident adjudicated events after Deceased Date;

data hard61;
merge hard6 (in = a) 
lostfu (keep   =  subjid lastdate);
      by subjid;
	  if a;
* 5 days are used here due to the fact that some death date is specified one day earlier than event date;
       if NOT missing(lastdate) & (date - lastdate) gt 5 & hardchd = 1 then do;
	   hardchd = 0;
	   date = lastdate;
	   year = year(date);
       days  = date - V1date;
       years = days/365.25;
	   contactType = 'Censored';
	   flag = 1;
	   end;
     drop lastdate flag;
*if flag = 1;
run;

proc freq data = hard61;
tables hardchd * contacttype/list missing;
where date = v1date;
run;

data hard7;
set hard61;
if date = v1date then do;
    hardchd     = .;
    date        = .; 
    year        = .; 
    days        = .; 
    years       = .;
    contactType = "Refused";
*	output;
end;
run;

*Merge CHD Incidence data set and Hard CHD Incidence data set. Hard CHD is defined as fatal CHD or MI but not Cardiac Procedure. After merging, 14 subjects will be HARDCHD nonmissing, but CHD missing.
All these 14 subjects are ARIC/JHS common cohort, Cardiac Procedure is identified collected from ARIC study before enrolling JHS study;

data final;
merge incevt7 hard7 (rename = (date = harddate year = hardyear years = hardyears days = harddays contactType = hardcontact));
by subjid;
run;

data final1;
set final;
          label CHD = "Incidence CHD";
          label V1date = "V1DATE: Date of Exam 1 Clinic Visit";
          label date = "CHD Event or Censoring Date";
          label year = "CHD Event or Censoring Year";
          label days = "CHD Follow-up Days";
          label years = "CHD Follow-up Years";
          label contactType = "CHD Last Contact Type";

		  label hardCHD = "Incidence hardCHD";
          label harddate = "hard CHD Event or Censoring Date";
          label hardyear = "hard CHD Event or Censoring Year";
          label harddays = "hard CHD Follow-up Days";
          label hardyears = "hard CHD Follow-up Years";
          label hardcontact = "hard CHD Last Contact Type";
run;

**************************************************************************************************;
** Step 5) Save SAS/Stata dataset;
**************************************************************************************************;

*Save SAS dataset;
data events.incevtCHD; set final1; 
          format CHD HardCHD ynfmt.;
run;

*Delete unused data sets;

proc datasets lib = work;
save lostfu lostfu1 ltfu;
run;
