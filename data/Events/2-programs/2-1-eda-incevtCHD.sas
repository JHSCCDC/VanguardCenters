** 2) Exploratory Data Analyses (EDA);

*read in dataset;
data incevt; set events.incevtCHD; run;
  *proc print data=incevt(obs=10); run;

  title "CHD";
  title2 "Event Types";
  proc freq data=incevt;
    table ContactType*CHD / nopercent norow nocol missing;
    run;

  title2 "Example Cox PHM";
  *get predictor variables (from analysis-ready V1 dataset);
  data preds; set analysis.analysis1(keep=subjid sex age bmi); run;
  *merge data;
  proc sort data = incevt; by subjid; run;
  proc sort data = preds;  by subjid; run;
  data phm; merge incevt preds; by subjid; run;
  *run simple PHM;
  proc phreg data=phm;
  class sex;
        model years*chd(0) =sex age bmi;
    run;
  title;
