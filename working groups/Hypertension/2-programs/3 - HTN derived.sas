x 'cd C:\...\VanguardCenters'; *Change This!;

libname analysis "data\Analysis Data\1-data"; 
libname cohort	 "data\Cohort\1-data"; 
libname htn		 "data\Working Groups\Hypertension\1-data";
libname jhsV1    "data\Visit 1\1-data";                   *"Raw" Exam 1 data; 
libname jhsV2    "data\Visit 2\1-data";                   *"Raw" Exam 2 data; 
libname jhsV3    "data\Visit 3\1-data";                   *"Raw" Exam 3 data; 

filename ADpgms "data\Analysis Data\2-programs"; 

options nonotes;
  %include ADpgms("0-1-0-formats.sas"); *Read in Analysis Datasets format statements;
  %include ADpgms("0-1-1-formats.sas"); *Read in formats from the JHS visit 1 catalogue;
  %include ADpgms("0-1-2-formats.sas"); *Read in formats from the JHS visit 2 catalogue;
  %include ADpgms("0-1-3-formats.sas"); *Read in formats from the JHS visit 3 catalogue;
options notes;

options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats);

%macro sort(d);
proc sort data=&d;
by subjid;
run;
%mend sort;

data one;
set analysis.analysiswide;
keep subjid bpmedsselfV1 bpmedsselfV2 bpmedsselfV3 sbpV1 sbpV2 sbpV3 dbpV1 dbpV2 dbpV3 htnV1 htnV2 htnV3;
run;

data one;
set one;
rename htnv1=HTNoldV1
	   htnv2=HTNoldV2
	   htnv3=HTNoldV3;
run;

proc format;
value YN 1="Yes"
		 0="No";
run;

data one;
set one;

* Define HTN-V1;
HTNV1=.;
if (sbpV1>=140 or dbpV1>=90 or bpmedsselfV1=1) then HTNV1=1;
if (sbpV1<140 and dbpV1<90 and bpmedsselfV1=0) then HTNV1=0;

format HTNV1 YN.;

* Define HTN-V2;
HTNV2=.;
if (sbpV2>=140 or dbpV2>=90 or bpmedsselfV2=1) then HTNV2=1;
if (sbpV2<140 and dbpV2<90 and bpmedsselfV2=0) then HTNV2=0;

format htnV2 YN.;

* Define HTN-V3;
HTNV3=.;
if (sbpV3>=140 or dbpV3>=90 or bpmedsselfV3=1) then HTNV3=1;
if (sbpV3<140 and dbpV3<90 and bpmedsselfV3=0) then HTNV3=0;

format htnV3 YN.;

run;

* Reclassification tables;
/*
proc freq data=one;
tables htnV1*htn2V1 htnV2*htn2V2 htnV3*htn2V3;
run;
*/

data one;
set one;
keep subjid HTNV1 HTNV2 HTNV3 HTNoldV1 HTNoldV2 HTNoldV3;
run;

data one;
set one;

label HTNV1="Hypertension (self-report) at V1" 
	  HTNV2="Hypertension (self-report) at V2"
	  HTNV3="Hypertension (self-report) at V3"
	  HTNoldV1="Hypertension (medication codes) at V1"
	  HTNoldV2="Hypertension (medication codes) at V2"
	  HTNoldV3="Hypertension (medication codes) at V3";
run;

data pfha;
set jhsV1.pfha;
keep subjid pfha2a pfha2b;
run;

data hhxa;
set jhsV2.hhxa;
keep subjid hhxa8a hhxa8b;
run;

data pfhb;
set jhsV3.pfhb;
keep subjid pfhb2a pfhb2b;
run;

%sort(d=one);
%sort(d=pfha);
%sort(d=hhxa);
%sort(d=pfhb);

data two;
merge one pfha hhxa pfhb;
by subjid;
if hhxa8b=777 then hhxa8b=.;
if pfhb2b=777 then pfhb2b=.;
run;

data two;
set two;

ageDx=.;

* Visit 1 awareness;
if htnV1=1 then do;
	if pfha2a="Y" then HTNawareV1=1;
	if pfha2a="N" then HTNawareV1=0;
	ageDx=pfha2b;
end;

format HTNawareV1 yn.;

if HTNoldV1=1 then do;
	if pfha2a="Y" then HTNawareOldV1=1;
	if pfha2a="N" then HTNawareOldV1=0;
	ageDx=pfha2b;
end;

format HTNawareOldV1 yn.;

* Visit 2 awareness;
if htnV2=1 then do;
	if hhxa8a=2 then HTNawareV2=0;
	if (hhxa8a=1 or pfha2a="Y") then HTNawareV2=1;
	if missing(pfha2b) then ageDx=hhxa8b;
end;

format HTNawareV2 yn.;

if htnoldV2=1 then do;
	if hhxa8a=2 then HTNawareOldV2=0;
	if (hhxa8a=1 or pfha2a="Y") then HTNawareOldV2=1;
	if missing(pfha2b) then ageDx=hhxa8b;
end;

format HTNawareOldV2 yn.;

* Visit 3 awareness;
if htnV3=1 then do;
	if pfhb2a=2 then HTNawareV3=0;
	if (pfhb2a=1 or hhxa8a=1 or pfha2a="Y") then HTNawareV3=1;
	if (missing(pfha2b) and missing(hhxa8b)) then ageDx=pfhb2b;
end;

format HTNawareV3 yn.;

if htnOldV3=1 then do;
	if pfhb2a=2 then HTNawareOldV3=0;
	if (pfhb2a=1 or hhxa8a=1 or pfha2a="Y") then HTNawareOldV3=1;
	if (missing(pfha2b) and missing(hhxa8b)) then ageDx=pfhb2b;
end;

format HTNawareOldV3 yn.;

run;

data two;
set two;

drop hhxa8a hhxa8b pfha2a pfha2b pfhb2a pfhb2b;

label ageDx="Age of HTN diagnosis"
	  HTNawareV1="V1 HTN (self-report) awareness"
	  HTNawareOldV1="V1 HTN (medication codes) awareness"
	  HTNawareV2="V2 HTN (self-report) awareness"
	  HTNawareOldV2="V2 HTN (medication codes) awareness"
	  HTNawareV3="V3 HTN (self-report) awareness"
	  HTNawareOldV3="V3 HTN (medication codes) awareness";

* Hard code mistakes in data;

if subjid="J105052" then ageDx=56; * originally 6;
if subjid="J507518" then ageDx=50; * originally 5;

run;

/*
proc freq data=two;
table ageDx;
run;

proc print data=two;
where .<ageDx<11;
var subjid;
run;

data test;
set two;
where .<ageDx<11;
run;
*/

data htn.HTNderived;
set two;
run;
