/**************************************************************************************************
***************************************************************************************************
  This dataset is designed to the most recent ptcpt contact from the following sources:
      1) Death
      2) Clinic Exam
      3) Telephone calls
***************************************************************************************************
**************************************************************************************************/

**************************************************************************************************;
*Step 1) Get deaths, no hard refusals data is extracted;
**************************************************************************************************;

  /*Check: proc freq data = dat.tera; table tera3; run; */
  /* lastdate is used to generate 2012 LTFU and lastdate4 is used to generate LTFU 2014 for mortality survival data set */

  data deathHR; set dat.TERa(keep = subjid tera3 tera4a tera7);
    by subjid;
    if tera3 = 5;

    *Variable: laststatus;
    length laststatus $50.;
      if tera3  = 5 then laststatus  = "Confirmed Deceased";
      if tera3  = 8 then laststatus  = "Refused";

    *Variable: lastdate;
    lastdate = .;
      if tera3  = 5 then lastdate = tera4a;
      if tera3  = 8 then lastdate = tera7;
      format lastdate lastdate4 MMDDYY10.;

*Death/Hard Refusal Cutoff Date 12/31/2014;
	  if lastdate le mdy(12, 31, 2014);

	  lastdate4 = lastdate;

    *Variable: cod;
  *   cod  = tera4b;
  *    label cod = "Cause of Death";

    drop tera3 tera4a tera7;
    run;

****************************************************************************************;
*Step 2) Get most recent clinic exam visit data;
****************************************************************************************;

/* lastdate is used to generate LTFU 2012 and lastdate4 is used to generate LTFU 2014 for mortality survival data set */

  data visits; set cohort.cohort(keep = subjid date type);
    by subjid;
    if type in ('Clinic Exam 1' 'Clinic Exam 2' 'Clinic Exam 3');

    *Variable: laststatus;
      format laststatus $50.;
        if type = 'Clinic Exam 1' then laststatus = "Exam 1 Contact";
        if type = 'Clinic Exam 2' then laststatus = "Exam 2 Contact";
        if type = 'Clinic Exam 3' then laststatus = "Exam 3 Contact";

    *Variable: lastdate;
      rename date = lastdate;
      format lastdate4 MMDDYY10.;
	  lastdate4 = date;
	  drop type;

    run;

**************************************************************************************************;
*Step 3) Get most recent successful call data;
**************************************************************************************************;

/* Clean AFULONG before use --- remove AFU after death */

/*proc sort data = deathHR out = deathHR1 nodupkey;*/
/*by subjid lastdate;*/
/*run;*/

data temp;
merge afu.afulong (in = a) 
deathHR (keep   =  subjid lastdate 
                    rename = (lastdate = deathHRdate) );
      by subjid;
	  if a;
      if NOT missing(deathHRdate) & date > deathHRdate then flag = 1;
      drop deathHRdate;
	  if flag = 1 then delete;
	  if alive = 'Y';
run;

proc sort data = temp;
by subjid date;
run;

  data afu1; set temp(where=(year(date)<=2012) keep=subjid date); *please see afu programs folder;
           *set dat.lastafudate; *please see afu programs folder;
    by subjid date;

    *Keep the last contact date for each contact year;
    lastdate = date;
      format lastdate MMDDYY10.;
    if last.subjid;
    keep subjid lastdate;
    run;
  *add a indicator variable status1 indicating whether obs exist AFU date past the admin censoring date;

  data afu2; set temp(keep=subjid date); *please see afu programs folder;
           *set dat.lastafudate; *please see afu programs folder;
    by subjid date;

    laststatus = "AFU Contact";

    *Keep the last contact date for each contact year;
    lastdate2 = date;
      format lastdate2 MMDDYY10.;
    if last.subjid;
    if lastdate2>mdy(12,31,2012) then status1 = 1;

    keep subjid laststatus status1;
    run;

 * add a variable lastdate4 as last AFU contact time to generate mortality data set before admin cut-off value 12/31/2014;
  data afu3; set temp (where=(date le mdy(12, 31, 2014))); 
    by subjid date;
    *Keep the last contact date for each contact year;
    format lastdate4 MMDDYY10.;
    lastdate4 = date;
    if last.subjid;
    keep subjid lastdate4;
    run;

    *combine all the censoring definitions;
    data afu4; merge afu1 afu2 afu3; by subjid; run;

    *Only keep ptcpts in VC package;
      proc sort data = cohort.visitdat out = visitdat; by subjid; run;
      data afu5; merge visitdat(in = in1 keep = subjid) afu4(in = in2); by subjid; if in1 & in2; run;

  *add a indicator variable status2 indicating whether obs exist Exam date past the admin censoring date;

	  data exam3; set visits;

	if laststatus = 'Exam 3 Contact';
    *Keep the last contact date for each contact year;
    if lastdate>mdy(12,31,2012) then status2 = 1;

    keep subjid status2;
    run;

* status variable indicates that obs exist with Exam date or AFU date past the admin censoring date;

data afu6;
merge afu5 exam3;
by subjid;
if status1 = 1 or status2 = 1 then status = 1;
drop status1 status2;
run;

data sta;
set afu6;
keep subjid status;
if status = 1;
run;

**************************************************************************************************;
*Step 4) Build LTFU dataset;
**************************************************************************************************;
  proc sort data = visits;  by subjid lastdate; run;
  proc sort data = afu6;     by subjid lastdate; run;
  proc sort data = deathHR; by subjid lastdate; run;

  data ltfu0; set visits afu6 deathHR; by subjid lastdate; run;

  *Remove any information (AFU or Exam) after death - just in case;
    data ltfu1; 
      merge ltfu0 
            deathHR(keep   =  subjid lastdate 
                    rename = (lastdate = deathHRdate) );
      by subjid;

      if NOT missing(deathHRdate) & lastdate > deathHRdate then flag = 1;
      drop deathHRdate;
      run;

      *Check; 
      proc print data = ltfu1; where flag = 1; run;

      data ltfu2; set ltfu1; if flag ^= 1; drop flag; run;

  *Add Exam 1 date;
    data first; set cohort.visitdat(keep = subjid V1DATE); 
      rename V1DATE = Exam1Date;
      run;

    data ltfu3; merge ltfu2 first; by subjid; run;

  *Set final variable order;
    data ltfu4; 
            set ltfu3;

      *Variable: deathHR; 
/*        deathHR = (laststatus in ("Confirmed Deceased" "Refused") );*/
/*          label deathHR  = "Death / Hard Refusal Indicator";*/
        death = (laststatus in ("Confirmed Deceased") );
          label death  = "Death Indicator";

      *Variable: lastdate4;
        label lastdate4   = "Date of Last Contact / Death";

      *Variable: lastyear;
        lastyear = year(lastdate4);
          label lastyear = "Last Year Contacted";

      *Variable: laststatus;
        label laststatus = "Contact Type / Participant Status";
      run;

***************************************************************************************************;
*Step 4) Extract LTFU (last contact) datasets from cohort;
***************************************************************************************************;

/* LTFU 12/13/2012 for 2012 event data set*/

* remove deceased/exam after 2012/12/31;

data ltfu5;
set ltfu4;
if lastdate gt mdy(12, 31, 2012) then delete;
run;

  proc sort data = ltfu5 out = ltfu6; by subjid descending lastdate; run; *Current;

data ltfu7;
set ltfu6;
      by subjid descending lastdate; 
      if first.subjid; *Only keep most recent obs;
	  drop status lastdate4 lastyear;
run;

data ltfu8;
merge ltfu7 sta;
by subjid;
      *Variable: lastyear;
        lastyear = year(lastdate);
          label lastyear = "Last Year Contacted";
run;

data ltfu9;
retain subjid Exam1Date lastdate lastyear laststatus death;
set ltfu8;
run;

* We provide three different censoring times in the deathltfuevents data sets for non-death participants, 
*lastDate: to use last known contact prior to admin censoring date as censoring time;
*lastDate2: to use last known contact prior to admin censoring date or admin censoring date if contacts past admin censoring date as censoring time;
*lastDate3: to use admin censoring date as censoring time;

    data deathltfuevents; set ltfu9; 
      format lastdate2 lastdate3 MMDDYY10.;
	  * for non-deceased participants, lastdate2 will use 12/31/2012 as censoring time if obs exist after admin censoring time and use last contact time before 12/31/2012 as censoring time if obs do not exit after admin censoring time,
	  lastdate3 will use use 12/31/2012 as censoring time;
	  if laststatus in ('AFU Contact', 'Exam 1 Contact', 'Exam 2 Contact', 'Exam 3 Contact') then do;
	  lastdate3 = mdy(12, 31, 2012);
	  if status = 1 then lastdate2 = mdy(12, 31, 2012);
	  else lastdate2 = lastdate; 
	  end;
	  * if deceased, lastdate2 or lastdate3 will use deceased date as censoring time;
	  else do;
	  lastdate2 = lastdate;
	  lastdate3 = lastdate;
	  end;
		  drop status;
  		  rename exam1date = v1date;
	      label lastdate = "Event or Option A Censoring Date";
          label lastdate2 = "Event or Option B Censoring Date";
          label lastdate3 = "Event or Option C Censoring Date";
          format death ynfmt.;
      run;

/* Incorporate Hard Refusal Information */

data deathHR1; 
set dat.TERa(keep = subjid tera3 tera4a tera7);
    by subjid;
    if tera3 = 8 and tera7 lt mdy(12, 31, 2012);
keep subjid tera7;
run;

data deathltfuevents1; 
merge deathltfuevents (in = a) deathhr1 (in = b);
by subjid;
if a;
run; 

data deathltfuevents2; 
set deathltfuevents1; 
/*if lastdate lt tera7 or lastdate2 lt tera7 or lastdate3 lt tera7;*/
if tera7 ne . then do;
lastdate = tera7;
lastdate2 = tera7;
lastdate3 = tera7;
death = 0;
laststatus = 'Refused';
lastyear = year(lastdate);
/*output;*/
end;
drop tera7;
run;

proc freq data = deathltfuevents2;
tables laststatus;
run;

data events.deathltfuevents; 
set deathltfuevents2; 
run;

proc datasets lib = work kill memtype=data;
run;
