** 2) Exploratory Data Analyses (EDA);

  title font=times j=c H=4 "JHS Events Data 2000-2012";
  title2 font=times j=c H=4 "Stroke (brief report)";

*read in dataset;
/*proc contents data=events.allevtSTROKE;run;*/

  *@@@@@@@@@@@ Yan added @@@@@@@@@@@@@@;
data allevt0; set events.allevtSTROKE; 
run;

*read in dataset analysis1, keep "visitdate";
data analy1; set analysis.analysis1(keep=subjid VisitDate); run;
*sort dataset allevt0 and analysis1;
 proc sort data=allevt0; by subjid; run;
 proc sort data=analy1; by subjid; run;

*merge allevt0 and analysis1 ;
data allevt;
merge allevt0(in=a) analy1;
by subjid;
if a;
if eventdate<=visitdate then delete;
run;
  *@@@@@@@@@@@ end @@@@@@@@@@@@@@;


   /*title2 "OHD Stroke";
  proc means data=allevt(where=(OHDStroke=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
  proc freq data=ids;
    table numEvts;
    run;
    *create formatted table;
  data ids; set ids; 
      if numEvts>=5 then EvtTab="5+";
    else EvtTab=numEvts;
    run;
  proc freq data=ids;
    table EvtTab;
    run;*/

  title3 "Event counts per participant: Stroke";
  proc means data=allevt(where=(Stroke=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
  /*proc freq data=ids;
    table numEvts;
    run;*/
    *create formatted table;
  data ids; set ids; 
  label EvtTab="# of Event";
      if numEvts>=5 then EvtTab="5+";
    else EvtTab=numEvts;
    run;
  proc freq data=ids;
    table EvtTab;
    run;


  title2 "Brain Infarction, Non-carotid Embolic (EIB)";
  proc means data=allevt(where=(EIB=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
  proc freq data=ids noprint;
    table numEvts/out=ids1 outcum;
    run;
data ids1;
set ids1;
strokeType=1;
run;

    *create formatted table;
  /*data ids; set ids; 
      if numEvts>=5 then EvtTab="5+";
    else EvtTab=numEvts;
    run;
  proc freq data=ids;
    table EvtTab;
    run;*/

  title2 "Brain Infarction, Thrombotic (TIB)";
  proc means data=allevt(where=(TIB=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
 
 proc freq data=ids noprint;
  table numEvts/out=ids2 outcum;
  run;
data ids2;
set ids2;
strokeType=2;
run;

  title2 "Brain Hemorrhage (IPH)";
  proc means data=allevt(where=(IPH=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
   proc freq data=ids noprint;
    table numEvts/out=ids3 outcum;
    run;
data ids3;
set ids3;
strokeType=3;
run;
   

  /*title2 "Subarachnoid Hemorrhage (SAH)"*/;
  proc means data=allevt(where=(SAH=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
  proc freq data=ids noprint;
    table numEvts/out=ids4 outcum;
    run;
data ids4;
set ids4;
strokeType=4;
run;
Title2"Event counts per participant: Stroke Subtypes";
*Combine EIB,TIB,IPH,SAH TO CREATE STROKE TYPE VARILABLE;
proc format;
 value strokefmt 1="Brain Infarction, 
Non-carotid Embolic "
              2="Brain Infarction, Thrombotic "
			  3="Brain Hemorrhage"
			  4="Subarachnoid Hemorrhage"
			  ;
			  run;
data ids;
retain strokeType numEvts count percent CUM_FREQ CUM_pct;
set ids1 ids2 ids3 ids4;
format percent 5.1;
format CUM_pct 5.1;
format strokeType strokefmt.;
label numEvts="# of Event";
run;
data ids;
set ids;
by strokeType;
if first. strokeType=0 then strokeType=.;
run;
proc print data=ids noobs label;run;
FOOTNOTE1;

  /** multiple types;
  title2 "Multiple Types";
  proc freq data=allevt;
    table EIB*TIB*IPH*SAH / list missing;
    run;

  ** by type;
  title2;
  proc freq data=allevt;
    table EIB TIB IPH SAH / missing;
    run;*/
