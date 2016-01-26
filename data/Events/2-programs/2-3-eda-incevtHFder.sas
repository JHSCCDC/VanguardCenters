* Exploratory Data Analyses (EDA);

*read in dataset;

data incevt; set events.incevtHFder; run;

  title "HF Hospitalization";
  title2 "Event Types for Main Analysis";
  proc freq data=incevt;
    table HF*ContactType / list missing;
    run;

  title2 "Event Types for Sensitivity Analysis";
  proc freq data=incevt;
    table AFUHF*AFUContactType / list missing;
    run;

  *get predictor variables (from analysis-ready V1 dataset);

data datwide; set analysis.analysiswide; run;

data dat; merge incevt datwide; by subjid; run;

title2 "Main Analysis: Cox PHM for Incident HF hospitalization from 01/01/2005 using V1 predictor ";

proc phreg data=dat;
model years*hf(0)=agev1 malev1 bmiv1 diabetesv1 sbpv1 dbpv1 bpmedsv1 /risklimits;
run;

title2 "Sensitivity Analysis: Cox PHM for Incident HF hospitalization from 01/01/2005 using V2 predictor ";

proc phreg data=dat;
model years*hf(0)=agev2 malev2 bmiv2 diabetesv2 sbpv2 dbpv2 bpmedsv2 /risklimits;
run;

title2 "Sensitivity Analysis: Cox PHM for Incident HF hospitalization from V1 using V1 predictor";

proc phreg data=dat;
model afuyears*afuhf(0)=agev1 malev1 bmiv1 diabetesv1 sbpv1 dbpv1 bpmedsv1 /risklimits;
run;

/*
title2 "Main Analysis: Cox PHM for Incident HF hospitalization from 01/01/2005 using V1 predictor ";

proc phreg data=dat;
model years*hf(0)=agev1 malev1 bmiv1 fpgv1 dmmedsv1 sbpv1 dbpv1 bpmedsv1 /risklimits;
run;

title2 "Sensitivity Analysis: Cox PHM for Incident HF hospitalization from 01/01/2005 using V2 predictor ";

proc phreg data=dat;
model years*hf(0)=agev2 malev2 bmiv2 fpgv2 dmmedsv2 sbpv2 dbpv2 bpmedsv2 /risklimits;
run;

title2 "Sensitivity Analysis: Cox PHM for Incident HF hospitalization from V1 using V1 predictor";

proc phreg data=dat;
model afuyears*afuhf(0)=agev1 malev1 bmiv1 fpgv1 dmmedsv1 sbpv1 dbpv1 bpmedsv1 /risklimits;
run;

title2 "Main Analysis: Cox PHM for Incident HF hospitalization from 01/01/2005 using V1 predictor ";

proc phreg data=dat;
model years*hf(0)=agev1 malev1 bmiv1 diabetesv1 htnv1 /risklimits;
run;

title2 "Sensitivity Analysis: Cox PHM for Incident HF hospitalization from V1 using V1 predictor";

proc phreg data=dat;
model afuyears*afuhf(0)=agev1 malev1 bmiv1 diabetesv1 htnv1 /risklimits;
run;
*/
