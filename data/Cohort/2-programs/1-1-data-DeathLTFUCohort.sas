/**************************************************************************************************
***************************************************************************************************
  This dataset is designed to the most recent ptcpt contact from the following sources:
      1) Death
      2) Clinic Exam
      3) Telephone calls
***************************************************************************************************
**************************************************************************************************/

**************************************************************************************************;
*Step 1) Get deaths data, no hard refusal data is extracted;
**************************************************************************************************;
OPTIONS nofmterr;

  /*Check: proc freq data = splmnt.TERa; table tera3; run; */
  /* lastdate is used to generate 2012 LTFU for events and lastdate4 is used to generate LTFU 2014 for mortality survival data set */

  data deathHR; set splmnt.TERa(keep = subjid tera3 tera4a tera7);
    by subjid;
    if tera3 in (5); *PA: TERA3 = 5 (The participant died), 8 (Hard Refusal);

    *if tera3 = 5;

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

  data V1dates;
    set cohort.visitdat(keep   =  subjid V1date
                        rename = (V1date = date));
    by subjid;

    *Variable Creation;

      *Variable: date;
      if missing(date) then delete;
      label date = "Date";

      *Variable: type;
      length type $18;
      type  = "Clinic Exam 1";
      label type = "Type of Contact";

      *Variable: visit;
      visit = 1;
      label visit = "Clinic Exam time Number";

    run;

    *Check: proc print data = V1dates(obs = 10);* run;


  data V2dates;
    set cohort.visitdat(keep   =  subjid V2date
                        rename = (V2date = date));
    by subjid;

    *Variable Creation;

      *Variable: date;
      if missing(date) then delete;
      label date = "Date";

      *Variable: type;
      length type $18;
      type  = "Clinic Exam 2";
      label type = "Type of Contact";

      *Variable: visit;
      visit = 2;
      label visit = "Clinic Exam time Number";

    run;

    *Check: proc print data = V2dates(obs = 10);* run;


  data V3dates;
    set cohort.visitdat(keep   =  subjid V3date
                        rename = (V3date = date));
    by subjid;

    *Variable Creation;

      *Variable: date;
      if missing(date) then delete;
      label date = "Date";

      *Variable: type;
      length type $18;
      type  = "Clinic Exam 3";
      label type = "Type of Contact";

      *Variable: visit;
      visit = 3;
      label visit = "Clinic Exam time Number";

    run;

    *Check: proc print data = V3dates(obs = 10);* run;

  data visits; set V1dates V2dates V3dates;
    by subjid;

    *Variable: laststatus;
      format laststatus $50.;
        if visit = 1 then laststatus = "Exam 1 Contact";
        if visit = 2 then laststatus = "Exam 2 Contact";
        if visit = 3 then laststatus = "Exam 3 Contact";

        drop visit type;

    *Variable: lastdate;
      rename date = lastdate;
      format lastdate4 MMDDYY10.;
	  lastdate4 = date;

    run;

**************************************************************************************************;
*Step 3) Get most recent successful call data;
**************************************************************************************************;

/* Clean AFULONG before use --- remove AFU after death */

data temp;
merge afu.afulong (in = a) 
deathHR (keep   =  subjid lastdate 
                    rename = (lastdate = deathHRdate) );
      by subjid;
	  if a;
      if NOT missing(deathHRdate) & date > deathHRdate then flag = 1;
      drop deathHRdate;
	  if flag = 1 then delete;
	  if alive = 'Y'; * Only use AFU observations with confirmed response; 
run;

proc sort data = temp;
by subjid date;
run;

  data afu1; set temp(where=(year(date)<=2012) keep=subjid date); 
    by subjid date;

    lastdate = date;
      format lastdate MMDDYY10.;
    if last.subjid;
    keep subjid lastdate;
    run;
  *add a indicator variable status1 indicating whether obs exist AFU date past the admin censoring date;

  data afu2; set temp(keep=subjid date); 
    by subjid date;

    laststatus = "AFU Contact";
    lastdate2 = date;
      format lastdate2 MMDDYY10.;
    if last.subjid;
    if lastdate2>mdy(12,31,2012) then status1 = 1;

    keep subjid laststatus status1;
    run;

 * add a variable lastdate4 as last AFU contact time to generate mortality data set before admin cut-off value 12/31/2014;
  data afu3; set temp (where=(date le mdy(12, 31, 2014))); 
    by subjid date;
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
*	  if flag = 1;
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
        death = (laststatus in ("Confirmed Deceased") );
          label death  = "Death Indicator";
          format death ynfmt.;

/*        HR = (laststatus in ("Refused") );*/
/*          label HR  = "Hard Refusal Indicator";*/

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

/* LTFU 12/31/2014 for mortality survival data set*/

  proc sort data = ltfu4 out = DeathLTFUCohort1; by subjid descending lastdate4; run; *Current;

    data DeathLTFUCohort2; set DeathLTFUCohort1; 
      by subjid descending lastdate4; 
      if first.subjid; *Only keep most recent obs;

      *Variable: ltfuIND;

        *Sub-Variable: ltfuYears;
          ltfuYears = (mdy(12, 31, 2014) - lastdate4) / 365.25;
          label ltfuYears = "Number of years since last contact";
          format lastdate MMDDYY10.;
          if laststatus = 'Confirmed Deceased' then lastdate = lastdate4;
		  else lastdate = mdy(12,31,2014);
          ltfuIND = (ltfuYears >= 2 & (laststatus = 'AFU Contact' or laststatus = 'Exam 3 Contact' or laststatus = 'Exam 1 Contact' or laststatus = 'Exam 2 Contact')); *KW: Loss to Follow-Up = No contact in 2 years;
          label ltfuIND = "Lost to Follow-Up"; 
          format ltfuIND ynfmt.;
		  drop status;
		  rename lastdate4 = lastcontactdate;
  		  rename exam1date = v1date;
      run;

data cohort.DeathLTFUCohort; 
retain subjid v1Date lastdate death lastcontactdate lastyear laststatus; 
set DeathLTFUCohort2;
run; 

proc datasets lib = work kill memtype=data;
run;
