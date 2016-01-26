footnote1;
title1;

**************************************************************************************************;
** Step 1) Get data;
**************************************************************************************************;

*Read in derived events data;
data allevtraw; set HF.HFC12OCC1; run;
  /* Checks;
  proc contents data = allevtraw; run;
  proc print    data = allevtraw(obs = 10); run;
  */

*Rename ID vars;
data allevt0; set allevtraw(rename = (CELB02 = subjid ID = EVENT_ID)); run;
  /*Checks;
    proc freq data = allevt; tables CHFDIAG3; run;

    *Note: 1 = Definite or Prob Decompensated HF
           2 = Chronic Stable HF
           3 = Unlikely HF / unclassifiable;
  */

*Only keep those with decompensated HF or stable HF: 
  1) Definite or Probable "Decompensated HF" OR 
  2) Chronic Stable HF;
data allevt1; set allevt0;
  if CHFDIAG3 in (1 2);

  *Variable Creation;

    *Variable: CHFDiagnosis;
    format CHFDiagnosis $40.;
    if CHFDIAG3 = 1 then CHFDiagnosis = "Definite/Probable Decompensated HF";
    if CHFDIAG3 = 2 then CHFDiagnosis = "Chronic Stable HF";
    label CHFDiagnosis = "Type of HF diagnosis";

    *Variable: HFEVTDATE;
    label HFEVTDATE = "HF event date, takes the date of admission";

  run;
  *proc print data = allevt(obs = 25); run;

*Ensure only 1 event ID per event (i.e. no duplicates);
proc freq data = allevt1; 
  tables event_id /noprint out = keylist;
  run;

proc print data = keylist; where count ge 2; run; 

*Format dataset;
data allevt2; set allevt1(keep   =  EVENT_ID subjid HFEVTDATE CHFDiagnosis
                        rename = (HFEVTDATE = eventDate));

  EventYear = year(eventDate);
  run;
  *proc print    data = allevt; run;
  *proc contents data = allevt; run;

*Save all events;
proc sort data = allevt2; by subjid eventDate; run;

*Remove all adjudicated events after Deceased Date;

data allevt3;
merge allevt2 (in = a)
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

data allevt4;
merge allevt3 (in = a)
lostfu1;
      by subjid;
	  if a;
      if NOT missing(lastdate) & eventdate > lastdate then flag = 1;
     drop lastdate flag;
	 if flag = 1 then delete;
*if flag = 1;
run;

data events.allevtHF; set allevt4; run;

*Delete unused data sets;

proc datasets lib = work;
save lostfu lostfu1 ltfu;
run;
