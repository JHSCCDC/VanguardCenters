** 2) Exploratory Data Analyses (EDA);

  title "JHS Events Data 2000-2012";
  title2 "CHD (brief report)";

  *@@@@@@@@@@@ Yan added @@@@@@@@@@@@@@;

*read in dataset;
data allevt0; set events.allevtCHD; run;


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



 /*  proc means data=allevt(where=(FatalCHD=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
 proc freq data=ids;
    table numEvts;
    run;
  *should only be 1 per person: Death;*/


  title3 "Event counts per participant: Myocardial Infarction (MI)";
  proc means data=allevt(where=(MI=1)) noprint;
    class subjid;
    var eventyear;
    output out=ids n=numEvts;
    ways 1;
    run;
  /*proc freq data=ids;
    table numEvts;
    run;*/
data ids; set ids; 
      if numEvts>=5 then EvtTab="5+";
    else EvtTab=numEvts;
    run;  
*create formatted table;
  proc freq data=ids;
  table EvtTab;
  label EvtTab="# of Event";
run;
	proc format;
	value ynfmt 1="Yes"
	            0="No"
				;

proc format;
picture pctfmt (round) other='009.9%';
run;
proc template;
define crosstabs Base.Freq.CrossTabFreqs;
define header tableof;
text "Table of " _row_name_ " by " _col_name_;
end;
define header rowsheader;
text _row_label_ / _row_label_ ^= ' ';
text _row_name_;
end;
define header colsheader;
text _col_label_ / _col_label_ ^= ' ';
text _col_name_;
end;
cols_header=colsheader;
rows_header=rowsheader;
header tableof;

define cellvalue frequency;
format=8.;
header='Count';
end;
define  cellvalue percent;
format=pctfmt.;
header='Overall %';
end;
end;
run;
*Two-way table of FatalCHD by MI*;
title2 "Fatal CHD by Myocardial Infarction";
proc freq data=allevt;
tables FatalCHD*MI/norow nocol;
format FatalCHD ynfmt. MI ynfmt.;
run; 

FOOTNOTE1;


