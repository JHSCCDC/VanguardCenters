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

%macro mec(v=);
%let n=1;
%let var=%scan(&varlist, &n.);

%do %while (&var ne );

  data &var.(keep=subjid tccode tccode4 tccode6 &var.);
  set htmedsV&v.;
  if &var.=1;
  run;

  proc sort data=&var. out=&var._id nodupkey; 
  by subjid; 
  run;

  data &var.V&v.;
  merge &var._id (in=a keep=subjid &var.) msraV&v.(in=b);
  by subjid;
  if a*b;
  run;

%let n=%eval(&n+1);
%let var=%scan(&varlist,&n);

%end;

%mend mec;

%macro meds(v=);

data htmedsV&v.;
set jhsV&v..medcodes (keep=subjid tccode);
by subjid;

tccode2 = (substr(tccode, 1, 2)); *First two digits;
tccode3 = (substr(tccode, 1, 3)); *First three digits;
tccode4 = (substr(tccode, 1, 4)); *First four digits;
tccode6 = (substr(tccode, 1, 6)); *First six digits;
tccode10 = (substr(tccode, 1, 10)); *All ten digits;

htmeds_misc=0;
ace=0;
aldo=0;
arb=0;
beta=0;
ccb=0;
central=0;
diuretic=0;
diuretic_potass=0;
diuretic_thz=0;
vasod=0;
renini=0;

if (tccode4="3699" | tccode4="3660" | tccode6="360000" | tccode10="360000CLTR" | tccode10="360000UNKN") then htmeds_misc=1; *antihypertensive combinations, antihypertensives--misc;

if tccode6 in ("361000" "369915" "369985" "369918") 														then ace=1;
if tccode6 in ("362500") 																					then aldo=1;
if tccode6 in ("333000" "339990" "362020" "362010") 														then alpha=1;
if tccode6 in ("361500" "369945" "369930" "369940" "369965") 												then arb=1;
if tccode6 in ("333000" "339990" "369920" "369988" "332000" "331000") 									 	then beta=1;
if tccode6 in ("340000" "409925" "349990" "641540" "369915" "369945" "369930" "369967" "369968") 			then ccb=1;
if tccode6 in ("369950") 																					then central=1;
if tccode4 in ("3799" "3790" "3720" "3750" ) | 
   tccode6 in ("370000" "376000" "369918" "369945" "369940" "369920" "369950" "369990" "369960" "369968") | 
   tccode10="9656881150" 																					then diuretic=1;
if tccode4="3720" 																							then diuretic_loop=1;
if tccode4="3750" 																							then diuretic_potass=1;
if tccode6 in ("376000" "369918" "369945" "369940" "369950" "369990" "369960" "369968" "369920" "379900") |
   tccode10="9656881150" 																					then diuretic_thz=1;
if tccode4 in("8925" "3640") | 
   tccode6 in ("369990" "362030" "369910") 																	then vasod=1;
if tccode6 in ("361700" "369965" "369967" "369960" "369968") 												then renini=1;
if tccode10="3750002000" 																					then diuretic=0;
if tccode10="3750002000" 																					then diuretic_potass=0;
if tccode10="3750002000" 																					then aldo=1; *categorize spironolactone as aldosterone antagonist, rather than diuretic;
if tccode10="3799000220" 																					then aldo=1; *categorize spironolactone-HCTZ as aldosterone antagonist;
if tccode10="3799000230" 																					then diuretic_potass=1; *categorize triamterene-HCTZ as K-sparing diuretic (in addition to thiazide diuretic);
if tccode10="3799000210" 																					then diuretic_potass=1; *categorize amiloride-HCTZ as K-sparing diuretic (in addition to thiazide diuretic);
run;

%let varlist=htmeds_misc ace alpha arb beta ccb  diuretic diuretic_loop diuretic_potass diuretic_thz vasod renini aldo central;

%mec(v=&v.);

%mend meds;

data msraV1;
set jhsV1.msra;
format _all_;
run;

data msraV2;
set jhsV2.msrb;
format _all_;
run;

data msraV3;
set jhsV3.msrc;
format _all_;
run;

%meds(v=1);
%meds(v=2);
%meds(v=3);

%macro sort(t=);
proc sort data=t&t.; 
by subjid; 
run;
%mend sort;

%macro dt(v=);
data t1;
set aceV&v.;
keep subjid ace;
run;

data t2; 
set aldoV&v.;
keep subjid aldo;
run;

data t3;
set alphaV&v.;
keep subjid alpha;
run;

data t4;
set arbV&v.;
keep subjid arb;
run;

data t5;
set betaV&v.;
keep subjid beta;
run;

data t6;
set ccbV&v.;
keep subjid ccb;
run;

data t7;
set centralV&v.;
keep subjid central;
run;

data t8;
set diureticV&v.;
keep subjid diuretic;
run;

data t9;
set diuretic_loopV&v.;
keep subjid diuretic_loop;
run;

data t10;
set diuretic_potassV&v.;
keep subjid diuretic_potass;
run;

data t11;
set diuretic_thzV&v.;
keep subjid diuretic_thz;
run;

* No participants took renin at V1 and V2;

%if &v=1 %then %do;
data t12;
subjid="0";
run;
%end;

%if &v=2 %then %do;
data t12;
subjid="0";
run;
%end;

%if &v=3 %then %do;
data t12;
set reniniV&v.;
keep subjid renini;
run;
%end;

data t13;
set vasodV&v.;
keep subjid vasod;
run;

data t14;
set htmeds_miscV&v.;
keep subjid htmeds_misc;
run;

%sort(t=1);
%sort(t=2);
%sort(t=3);
%sort(t=4);
%sort(t=5);
%sort(t=6);
%sort(t=7);
%sort(t=8);
%sort(t=9);
%sort(t=10);
%sort(t=11);
%sort(t=12);
%sort(t=13);
%sort(t=14);

data t15;
merge t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14;
by subjid;
keep subjid ace aldo alpha arb beta ccb central diuretic diuretic_loop diuretic_potass diuretic_thz htmeds_misc renini vasod;
run;

/*recode . to 0 for each class and code number of antihypertensive medication classes*/
data t16;
set t15;
if ace=. then ace=0;
if aldo=. then aldo=0;
if alpha=. then alpha=0;
if arb=. then arb=0;
if beta=. then beta=0;
if ccb=. then ccb=0;
if central=. then central=0;
if diuretic=. then diuretic=0;
if diuretic_loop=. then diuretic_loop=0;
if diuretic_potass=. then diuretic_potass=0;
if diuretic_thz=. then diuretic_thz=0;
if renini=. then renini=0;
if vasod=. then vasod=0;
if htmeds_misc=. then htmeds_misc=0;
num_classes=sum(of ace aldo alpha arb beta ccb central diuretic renini vasod); 
if ace=0 and aldo=0 and alpha=0 and arb=0 and beta=0 and ccb=0 and central=0 and diuretic=0 and diuretic_loop=0 and diuretic_potass=0 and diuretic_thz=0 and renini=0 and vasod=0 
and htmeds_misc=1 then num_classes=1;
run;

data htmedsV&v.;
set t16;
keep subjid ace aldo alpha arb beta ccb central diuretic diuretic_loop diuretic_potass diuretic_thz htmeds_misc renini vasod;
run;

%mend dt;

%dt(v=1);
%dt(v=2);
%dt(v=3);

data one;
set htmedsV1;
rename ace=aceV1
	   aldo=aldoV1
	   alpha=alphaV1
	   arb=arbV1
	   beta=betaV1
	   ccb=ccbV1
	   central=centralV1
	   diuretic=diureticV1
	   diuretic_loop=diuretic_loopV1
	   diuretic_potass=diuretic_potassV1
	   diuretic_thz=diuretic_thzV1
	   htmeds_misc=htmeds_miscV1
	   renini=reniniV1
	   vasod=vasodV1;
label ace="ACE Inhibitor use (V1)"
	  aldo="Aldosterone Antagonist use (V1)"
	  alpha="Alpha-Blocker use (V1)"
	  arb="ARB use (V1)"
	  beta="Beta-Blocker use (V1)"
	  ccb="Calcium Channel Blocker use (V1)"
	  central="Central Acting Agend use (V1)"
	  diuretic="Diuretic use (V1)"
	  diuretic_loop="Loop Diuretic use (V1)"
	  diuretic_potass="Potassium-Sparing Diuretic use (V1)"
	  diuretic_thz="Thiazide Diuretic use (V1)"
	  renini="Renin Inhibitor use (V1)"
	  vasod="Vasodilator use (V1)"
	  htmeds_misc="Miscellaneous Anti-HTN Medication use (V1)";
run;

data two;
set htmedsV2;
rename ace=aceV2
	   aldo=aldoV2
	   alpha=alphaV2
	   arb=arbV2
	   beta=betaV2
	   ccb=ccbV2
	   central=centralV2
	   diuretic=diureticV2
	   diuretic_loop=diuretic_loopV2
	   diuretic_potass=diuretic_potassV2
	   diuretic_thz=diuretic_thzV2
	   htmeds_misc=htmeds_miscV2
	   renini=reniniV2
	   vasod=vasodV2;
label ace="ACE Inhibitor use (V2)"
	  aldo="Aldosterone Antagonist use (V2)"
	  alpha="Alpha-Blocker use (V2)"
	  arb="ARB use (V2)"
	  beta="Beta-Blocker use (V2)"
	  ccb="Calcium Channel Blocker use (V2)"
	  central="Central Acting Agend use (V2)"
	  diuretic="Diuretic use (V2)"
	  diuretic_loop="Loop Diuretic use (V2)"
	  diuretic_potass="Potassium-Sparing Diuretic use (V2)"
	  diuretic_thz="Thiazide Diuretic use (V2)"
	  renini="Renin Inhibitor use (V2)"
	  vasod="Vasodilator use (V2)"
	  htmeds_misc="Miscellaneous Anti-HTN Medication use (V2)";
run;

data three;
set htmedsV3;
rename ace=aceV3
	   aldo=aldoV3
	   alpha=alphaV3
	   arb=arbV3
	   beta=betaV3
	   ccb=ccbV3
	   central=centralV3
	   diuretic=diureticV3
	   diuretic_loop=diuretic_loopV3
	   diuretic_potass=diuretic_potassV3
	   diuretic_thz=diuretic_thzV3
	   htmeds_misc=htmeds_miscV3
	   renini=reniniV3
	   vasod=vasodV3;
label ace="ACE Inhibitor use (V3)"
	  aldo="Aldosterone Antagonist use (V3)"
	  alpha="Alpha-Blocker use (V3)"
	  arb="ARB use (V3)"
	  beta="Beta-Blocker use (V3)"
	  ccb="Calcium Channel Blocker use (V3)"
	  central="Central Acting Agend use (V3)"
	  diuretic="Diuretic use (V3)"
	  diuretic_loop="Loop Diuretic use (V3)"
	  diuretic_potass="Potassium-Sparing Diuretic use (V3)"
	  diuretic_thz="Thiazide Diuretic use (V3)"
	  renini="Renin Inhibitor use (V3)"
	  vasod="Vasodilator use (V3)"
	  htmeds_misc="Miscellaneous Anti-HTN Medication use (V3)";
run;

proc sort data=one;
by subjid;
run;

proc sort data=two;
by subjid;
run;

proc sort data=three;
by subjid;
run;

data htn.HTNmeds;
merge one two three;
by subjid;
if subjid="0" then delete;
run;
