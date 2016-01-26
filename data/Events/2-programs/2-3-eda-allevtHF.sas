** 2) Exploratory Data Analyses (EDA);

title font=times j=c H=4 "JHS Events Data 2005-2012";
title2 font=times j=c H=4 "Heart Failure (brief report)";
 *read in dataset;
data allevt; set events.allevtHF; run;

 *  title2 "Decompensated Heart Failure";
 proc means data=allevt(where=(CHFDiagnosis="Definite/Probable Decompensated HF")) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
data ids;
set ids;
 if numEvts>=5 then EvtTab="5+";
 else EvtTab=numEvts;
 run;

 proc freq data=ids noprint;
 table EvtTab/out=ids1 outcum;
 run; 
*create formatted table;
data ids1;
set ids1;
HF=1;
run;
 /*proc freq data=ids;
 table EvtTab;
  run;*/

  *title2 "Chronic Stable Heart Failure";
  proc means data=allevt(where=(CHFDiagnosis="Chronic Stable HF")) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
data ids;
set ids;
 if numEvts>=5 then EvtTab="5+";
 else EvtTab=numEvts;
 run;
 proc freq data=ids noprint;
 table EvtTab/out=ids2 outcum;
 run; 
*create formatted table;
data ids2;
set ids2;
HF=2;
run;
/*proc freq data=ids;
 table EvtTab;
 run;*/
*Combine two types of HF;
Title3 "Event counts per participant:Heart Failure Type";
proc format;
	value hffmt 1="Decompensated Heart Failure"
	            2="Chronic Stable Heart Failure"
				;
data ids;
retain hf EvtTab count percent CUM_FREQ CUM_pct;
set ids1 ids2;
format percent 5.1;
format CUM_pct 5.1;
label EvtTab="# of Event";
label HF="Heart Failure Type";
format hf hffmt.;
run;
data ids;
set ids;
by hf;
if first. hf=0 then hf=.;
run;
proc print data=ids noobs label;run;
FOOTNOTE1;
/*FOOTNOTE J=L font=times H=2 'U:\JHS\ADDVT\data\Events\programs\2011events\2-3-eda-HF-occ.sas'*/;
