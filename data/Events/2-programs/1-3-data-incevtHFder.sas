OPTIONS nofmterr;

/* Part I: Without including AFU identified HF, HF incident start from 01/01/2005 */

data one; 
set analysis.analysis1;
keep subjid visitdate aric;
run;

data temp0;
merge afu.afulong one (in = a);
by subjid;
if a and alive = 'Y';
* HF related question variable only exists in original form ('A', 'B', 'C', 'D' etc. and not other form);
if substr(vers, 1, 1) ne 'O';
/* All unknown answers were assumed missing */
if hfever = 'U' then hfever = '';
if hflastcntct = 'U' then hflastcntct = '';
/* When both hfever and hflastcntct are nonmissing, use information hfever */
if hfever ne '' and hflastcntct ne '' then hflastcntct = '';
keep subjid date vers hfever hflastcntct;
run;

proc sort data = temp0;
by subjid date;
run;

data temp1;
set temp0;
by subjid date;
retain visit;
if first.subjid then visit = 1;
visit = visit + 1;
run;

proc freq data = temp1;
tables vers hfever * hflastcntct vers*hfever * hflastcntct/list missing;
run;

data three;
set temp1;
run;

proc sort data=three;
by subjid;
run;

data three3;
set three;
format ref MMDDYY10.;
ref = mdy(1, 1, 2005);
run;

/* three5: total population for incidence analysis, consent yes and alive on 01/01/2005 for HF adjudication, N = 5042*/

data bb30;
set ltfu;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *lastDate:  *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *lastDate2: *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      *lastDate3: *For non-deceased participants: Uses admin censoring date;
* lastdate = lastdate2;
  lastdate = lastdate3;
keep subjid lastdate laststatus;
run;

data bb32;
set events.allevthf;
*if eventdate lt mdy(1,1,2005);
run;

data three5;
set bb30;
if lastdate le mdy(1, 1, 2005) then delete;
keep subjid;
run;

data three52;
set bb30;
if lastdate le mdy(1, 1, 2005);
*keep subjid;
run;

proc freq data = three52;
tables laststatus;
run;

/*data three52;*/
/*set bb32;*/
/*keep subjid;*/
/*run;*/
/**/
/*data three53;*/
/*set three51 three52;*/
/*run;*/
/**/
/*proc sort data = three53 out = three5 nodupkey;*/
/*by subjid;*/
/*run;*/

proc means data = three3 n nmiss;
var date;
run;

proc freq data = bb30;
tables lastdate/list missing;
run;

data bb33;
merge bb30 three5 (in = a);
by subjid;
if a;
run;

/* AFU time after 01/01/2005 go to data set aa2, otherwise go to aa1 */

data aa1 aa2;
set three3;
if date ge ref then output aa2;
else if date ne . then output aa1;
run;

proc freq data = aa1;
tables hflastcntct;
run;

proc transpose data=aa1 out=five_a;
by subjid;
id visit;
var hfever;
run;

proc transpose data=aa1 out=five_b;
by subjid;
id visit;
var hfever date;
run;

data aa3;
merge five_a three5 (in = a);
by subjid;
if a;
run;

/* 
aa31: Individuals missing HF question answer for all AFUs before 01/01/2005 N = 1148
aa32: Individuals that do not report HF at any AFU before 01/01/2005 N = 3713
aa33: Individuals that report HF at any AFU before 01/01/2005 N = 181
*/
/*
*eight subjects have _6, _7 and _8 variables (the 6th, 7th and 8th AFU visit before 01/01/2005), but no new information will be achieved from these three variables 
---- see check 5 data sets, HF status answer 'No' for all visits; 
data check5;
set five_b;
if _6 ne '' or _7 ne '' or _8 ne '';
run;
*/

data aa31 aa32 aa33;
set aa3;
if _5 = '' and _2 = '' and _3 = '' and _4 =  '' then output aa31;
else if not ((index(_5, 'Y') ne 0) or (index(_2, 'Y') ne 0) or (index(_3, 'Y') ne 0) or (index(_4, 'Y') ne 0))
then output aa32;
else output aa33;
run;

proc freq data = aa33;
tables _2 * _3 * _4 * _5/list missing;
run;

data aa34 aa35;
set aa33;
if _2 in ('Y', '') and _3 in ('Y', '') and _4 in ('Y', '') and _5 in ('Y', '') then output aa34;
else output aa35;
run;

/* 
aa37: “Yes” at one AFU and at least one “No” answer afterward    n = 47 (cat = 2)
aa38: “Yes” at one AFU and no “No” answer afterward    n = 134 (cat = 1)
*/

data aa36 aa37;
set aa35;
if (_2 = 'N' and _3 = 'Y' and _4 in ('Y', '') and _5 in ('Y', ''))
or (_2 = 'N' and _3 = 'N' and _4 = 'Y' and _5 in ('Y', ''))
or (_2 = 'N' and _3 = 'N' and _4 = 'N' and _5 in ('Y')) then output aa36;
else output aa37;
run;

data aa38;
set aa34 aa36;
run;

data bb1;
set aa32;
keep subjid;
run;

data bb2;
set aa31;
keep subjid;
run;

proc means data = aa2 n nmiss;
var date;
run;

data aa41;
set aa2;
if hfever ne '' or hflastcntct ne '';
run;

proc sort data = aa41;
by subjid date;
run;

/* aa42: HF status question answer at First AFU after 2005/01/01 */ 

data aa42;
set aa41;
by subjid date;
if first.subjid;
keep subjid Visit date hfever hflastcntct; 
run;

proc freq data = aa42;
tables hfever hflastcntct/missing list;
run;

data aa43;
merge aa42 bb2 (in = a);
by subjid;
if a;
drop visit;
run;

/* aa46: Individuals missing HF question answer for all AFUs before 01/01/2005 and “No” at the first AFU after 01/01/2005 N = 1051
aa47: Individuals missing HF question answer for all AFUs before 01/01/2005 and “Yes” at the  first AFU after 01/01/2005 N = 25 (cat = 10)
aa48: Individuals missing HF question answer for all AFUs before 01/01/2005 and Missing at all the AFUs after 01/01/2005 N = 72 (cat = 11)*/

data aa46 aa47 aa48;
set aa43;
if hfever = 'N' or hflastcntct = 'N' then output aa46;
else if hfever = 'Y' or hflastcntct = 'Y' then output aa47; 
else if hfever = '' and hflastcntct = '' then output aa48;
run;

data aa56;
merge aa42 bb1 (in = a);
by subjid;
if a;
drop visit;
run;

/* 
aa57: Individuals that do not report HF at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005  N = 3543
aa58: Individuals that do not report HF at any AFU before 01/01/2005 and “Yes” at the first AFU after 01/01/2005  N = 66 (cat = 5)
aa59: Individuals that do not report HF at any AFU before 01/01/2005 and Missing at all AFU after 01/01/2005  N = 104 (cat = 6)
*/

data aa57 aa58 aa59;
set aa56;
if hfever = 'N' OR hflastcntct = 'N' then output aa57;
if hfever = 'Y' OR hflastcntct = 'Y' then output aa58;
if hfever = '' AND hflastcntct = '' then output aa59;
run;

data bb31;
set aa57;
*drop hfever;
run;

*Check population from aa57:
Although they reported non-HF event on first AFU after 01/01/2005, to check wheher adjudicated AFU event detected or not between 01/01/2005 and First AFU after 01/01/2005; 

data check1;
merge bb31 (in = a) bb32 (in = b);
by subjid;
if a = b;
if date gt EventDate;
run;

proc sort data = check1 out = check2 nodupkey;
by subjid;
run;

* bb36: subjects do not report HF at any AFU before 01/01/2005 and “No” at the  first AFU after 01/01/2005, 
however Adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005 --- Inconsistent AFU N = 13 (cat = 3)
bb37: subjects do not report HF at any AFU before 01/01/2005 and “No” at the  first AFU after 01/01/2005, 
and no adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005: N = 3530 (cat = 4);
 
data bb36;
set check2;
keep subjid;
run;

data bb37;
merge bb31 bb36 (in = a);
by subjid;
if a then delete;
run;

* In the 3530 subjects from data set bb37 (subjects do not report HF at any AFU before 01/01/2005 and “No” at the  first AFU after 01/01/2005, 
and no adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005), 467 answers ‘N’ from Form C Question 9
3063 answers ‘N’ from Form A/B Question 7b, Both answers can be used;
 
proc freq data = bb37;
tables hfever * hflastcntct/LIST MISSING;
run;

*specify cat = 4 incidence data set start time point - 01/01/2005;
data bb38;
set bb37;
drop date hfever hflastcntct;
format examdate mmddyy10.; 
examdate = mdy(1, 1, 2005);
run;

*Check population from aa46:
Although they reported non-HF event on first AFU after 01/01/2005, to check wheher adjudicated AFU event detected or not between 01/01/2005 and First AFU after 01/01/2005; 

data aa71;
set aa46;
*drop hfever;
run;

data aa72;
merge aa71 (in = a) bb32 (in = b);
by subjid;
if a = b;
if date gt EventDate;
run;

proc sort data = aa72 out = aa73 nodupkey;
by subjid;
run;

/* 
aa74: subjects do not report HF status at any AFU before 01/01/2005 and “No” at the  first AFU after 01/01/2005, 
however adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005 --- Inconsistent AFU N = 1 (cat = 7) 
aa75: subjects do not report HF status at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005 with Form A Question 7b (can be used to generate incidence data set), 
and no adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005: N = 932 (cat = 8)
aa76: subjects do not report HF status at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005 with Form C Question 9 (can not be used to generate incidence data set), 
and no adjudicated HF Event detected between 01/01/2005 and First AFU after 01/01/2005: N = 118 (cat = 9)
*/
 
data aa74;
set aa73;
keep subjid;
run;

data aa75 (drop = hfever hflastcntct) aa76 (drop = hfever hflastcntct);
merge aa71 aa74 (in = a);
by subjid;
if a then delete;
if hfever = 'N' then output aa75;
if hflastcntct = 'N' then output aa76;
run;

*specify cat = 8 incidence data set start time point - first AFU time with 'N' answer after 01/01/2005;

data bb42;
set aa75;
rename date = examdate;
run;

* Total population that can be used for HF incidence data set  N = ;

data bb43;
set bb38 bb42;
run;

* specify first HF event;

data bb44;
set bb32;
by subjid eventdate;
if first.subjid;
run;

proc sort data = bb43;
by subjid;
run;

data bb45;
merge bb30 bb43 (in = a);
by subjid;
if a;
run;

data bb46;
merge bb44 (in = b) bb45 (in = a);
by subjid;
if a;
if b then hf = 1;
else hf = 0;
*if CHFDiagnosis = . then CHFDIAG3 = 0;
run;

data bb47;
merge bb46 bb30;
by subjid;
run;

proc freq data = bb47;
tables CHFDiagnosis hf/missing;
run;

* Specify first AFU HF status after 01/01/2005;

data dd11 (drop = _6 _7 _8) dd12 (drop = _6 _7 _8 rename = (_2 = Time_2 _3 = Time_3 _4 = Time_4 _5 = Time_5));
set five_b;
if _name_ = 'HFever' then output dd11;
if _name_ = 'date' then output dd12;
drop _name_ _label_;
run;

proc freq data = aa42;
tables hfever * hflastcntct/list missing;
run;

data dd13;
retain hfever date visit;
set aa42;
if hfever ne '' then after_cat = 1;
else after_cat = 2;
if hfever = '' then hfever = hflastcntct;
rename date = after_time;
rename hfever = after_status;
rename visit = after_visit;
drop hflastcntct;
run;

proc freq data = dd13;
tables after_status/list missing;
run;

data check1;
set aa38;
keep subjid;
run;

proc sort data = check1;
by subjid;
run;

data check2;
set aa37;
keep subjid;
run;

data check3;
set bb36;
keep subjid;
run;

data check4;
set bb37;
keep subjid;
run;

data check5;
set aa58;
keep subjid;
run;

data check6;
set aa59;
keep subjid;
run;

data check7;
set aa74;
keep subjid;
run;

data check8;
set aa75;
keep subjid;
run;

data check81;
set aa76;
keep subjid;
run;

data check9;
set aa47;
keep subjid;
run;

data check10;
set aa48;
keep subjid;
run;

data check11;
set three52;
keep subjid;
run;

/* Check the category classification is exclusive for 12 categories*/

data check12;
set check1 (in = a) check2 (in = b) check3 (in = c) check4 (in = d) check5 (in = e) check6 (in = f) check7 (in = g) check8 (in = h) check81 (in = k) check9 (in = i)
check10 (in = j) check11;
run;

proc sort data = check12 nodupkey;
by subjid;
run;

data bb48;
merge bb47 dd12 dd11 dd13 check1 (in = a) check2 (in = b) check3 (in = c) check4 (in = d) check5 (in = e) check6 (in = f) check7 (in = g) check8 (in = h) check81 (in = i) check9 (in = j)
check10 (in = k) check11 (in = l);
by subjid;
if a then cat = 1;
if b then cat = 2;
if c then cat = 3;
if d then cat = 4;
if e then cat = 5;
if f then cat = 6;
if g then cat = 7;
if h then cat = 8;
if i then cat = 9;
if j then cat = 10;
if k then cat = 11;
if l then cat = 12;
drop event_id;
run;

proc freq data = bb48;
tables cat;
run;

ods html;
proc freq data = bb48;
tables hf cat cat * hf after_cat * cat hf * examdate/list missing;
run;
ods html close;

data bb49;
set bb48;
drop time_2 -- after_cat;
run;

proc datasets lib = work;
*save bb49 ltfu lostfu;
save bb49 ltfu lostfu lostfu1;
run;

/* Part II: Including AFU identified HF, HF incident start from V1 */

data one; 
set analysis.analysis1;
keep subjid visitdate aric;
run;

data temp00;
merge afu.afulong one (in = a);
by subjid;
if a and alive = 'Y';
* HF related question variable only exists in original form ('A', 'B', 'C', 'D' etc. and not other form);
if substr(vers, 1, 1) ne 'O';
/* All unknown answers were assumed missing */
if hfever = 'U' then hfever = '';
if hflastcntct = 'U' then hflastcntct = '';
/* When both hfever and hflastcntct are nonmissing, use information hfever */
if hfever ne '' and hflastcntct ne '' then hflastcntct = '';
keep subjid date vers hfever hflastcntct;
run;

proc sort data = temp00;
by subjid date;
run;

proc means data = temp00 n nmiss;
var date;
run;

data temp11 temp12;
set temp00;
if date lt mdy(1, 1, 2005) and hfever ne '' then output temp11;
if date ge mdy(1, 1, 2005) and (hfever ne '' or hflastcntct ne '') then output temp12;
run;

data temp13;
set temp12;
by subjid date;
if first.subjid;
keep subjid date hfever hflastcntct; 
run;

data temp14;
set temp11;
by subjid date;
retain visit;
if first.subjid then visit = 0;
visit = visit + 1;
run;

/* All AFU before 01/01/2005 has hflastcntct variable as missing */

proc freq data = temp14;
tables hfever * hflastcntct/missing list;
run;

/*Subjects with AFU before 2005/01/01 thus have HF ever status question answer*/

/* aa1 data set saves AFU HF ever status before 2005/01/01*/

proc transpose data = temp14 out = aa1;
var hfever;
by subjid;
id visit;
run;

/* aa2 data set saves AFU date before 2005/01/01*/

proc transpose data = temp14 out = aa2;
var date;
by subjid;
id visit;
run;

/* aa3 data set saves AFU HF ever status and date before 2005/01/01*/

data aa3;
merge aa1 (keep = subjid _1 -- _7) aa2 (keep = subjid _1 -- _7 rename = (_1 = _d1 _2 = _d2 _3 = _d3 _4 = _d4 _5 = _d5 _6 = _d6 _7 = _d7));
by subjid;
run;

/* _0 save first answered HFever variable */

data aa12;
merge one aa1;
by subjid;
drop aric;
run;

data aa13;
set aa12;
if _1 ne '' then _0 = _1;
else if _2 ne '' then _0 = _2;
else if _3 ne '' then _0 = _3;
else if _4 ne '' then _0 = _4;
else if _5 ne '' then _0 = _5;
else if _6 ne '' then _0 = _6;
else if _7 ne '' then _0 = _7;
run;

proc freq data = aa13;
tables _0 * _1 * _2 * _3 * _4 * _5 * _6 * _7/list missing;
run;

/* 
aa14: Individuals that had prevalent HF before first AFU, N = 126 (cat = 1), excluded from incident analysis;
bb11: Individuals that did not have prevalent HF before first AFU, but developed HF before 01/01/2005 N = 68, HF date was identified using AFU date;
cc11: Individuals that do not report HF at any AFU before 01/01/2005 N = 3872
dd11: Individuals missing HF question answer for all AFUs before 01/01/2005 N = 1240
*/

data aa14 cc11 bb11 dd11 (keep = subjid visitdate);
set aa13;
if (_1 = '' and _2 = '' and _3 = '' and _4 = '' and _5 = '' and _6 = '' and _7 = '') then output dd11 ;
else if _0 = 'Y' then output aa14;
else if not ((index(_1, 'Y') ne 0) or (index(_2, 'Y') ne 0) or (index(_3, 'Y') ne 0) or (index(_4, 'Y') ne 0)  or (index(_5, 'Y') ne 0) or (index(_6, 'Y') ne 0) or (index(_7, 'Y') ne 0))
then output cc11;
else output bb11;
run;

proc freq data = aa14;
tables _0 * _1 * _2 * _3 * _4 * _5 * _6 * _7/list missing;
run;

data aa15;
set aa14;
keep subjid;
run;

/* To get the event date for cat 2 subjects N = 68, middle point of first HF positive and previous HF negative AFU date, final data set bb13*/

proc freq data = bb11;
tables _0 * _1 * _2 * _3 * _4 * _5 * _6 * _7/list missing;
run;

data bb12;
merge bb11 (in = a keep = subjid) aa3;
by subjid;
if a;
run;

proc freq data = bb12;
tables _1;
run;

data bb13;
set bb12;
format date MMDDYY10.;
if _7 = 'Y' then date = (_d7 + _d6)/2;
if _6 = 'Y' then date = (_d6 + _d5)/2;
if _5 = 'Y' then date = (_d5 + _d4)/2;
if _4 = 'Y' then date = (_d4 + _d3)/2;
if _3 = 'Y' then date = (_d3 + _d2)/2;
if _2 = 'Y' then date = (_d2 + _d1)/2;
keep subjid date;
rename date = eventdate;
run;

/* 
bb14: first AFU "No", “Yes” at one AFU and no “No” answer afterward n = 52  (cat = 2)
bb15: first AFU "No", and “Yes” at one AFU after first AFU and at least one “No” answer afterward n = 16  (cat = 3)
*/

data bb14 bb15;
set bb11;
if (_2 = 'Y' and _3 in ('Y', '') and _4 in ('Y', '')) 
or (_2 = 'N' and _3 = 'Y' and _4 in ('Y', ''))
or (_2 = 'N' and _3 = 'N' and _4 = 'Y') then output bb14;
else output bb15;
run;

proc freq data = bb14;
tables  _1 * _2 * _3 * _4 * _5 * _6 * _7/list missing;
run;

proc freq data = bb15;
tables  _1 * _2 * _3 * _4 * _5 * _6 * _7/list missing;
run;

/* Decomposed cc11: Individuals that do not report HF at any AFU before 01/01/2005 N = 3872*/

data cc12;
merge temp13 cc11 (in = a keep = subjid visitdate);
by subjid;
if a;
run;

/* 
cc13: Individuals that do not report HF at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005  N = 3650 (cat = 4)
cc14: Individuals that do not report HF at any AFU before 01/01/2005 and “Yes” at the  first AFU after 01/01/2005  N = 68 
cc15: Individuals that do not report HF at any AFU before 01/01/2005 and Missing at all AFU after 01/01/2005  N = 154 (cat = 7), excluded from incident HF data set
*/

data cc13 (keep = subjid) cc14 cc15 (keep = subjid);
set cc12;
if hfever = 'N' OR hflastcntct = 'N' then output cc13 ;
if hfever = 'Y' OR hflastcntct = 'Y' then output cc14;
if hfever = '' AND hflastcntct = '' then output cc15 ;
run;

data cc16;
set events.allevthf;
by subjid;
if first.subjid;
run;

/* 
Further Decomposed cc14: 
cc17: adjudicated events identified between 01/01/2005 and first AFU after 01/01/2005, event time specified as first adjudicated event time after 01/01/2005 N = 8 cat = 5
cc20: adjudicated events not identified between 01/01/2005 and first AFU after 01/01/2005, event time specified as middle point of last AFU before 01/01/2005 and 01/01/2005 N = 60 cat = 6
*/

data cc17;
merge cc14 (in = a) cc16 (in = b);
by subjid;
if a = b;
if date ge EventDate;
keep subjid eventdate;
run;

data cc18;
merge cc17 (in = a) cc14;
by subjid;
if a then delete;
keep subjid;
run;

data cc19;
merge cc18 (in = a) aa3;
by subjid;
if a;
run;

data cc20;
set cc19;
format eventdate MMDDYY10.;
if _d7 ne '' then eventdate = (_d7 + mdy(1, 1, 2005))/2;
else if _d6 ne '' then eventdate = (_d6 + mdy(1, 1, 2005))/2;
else if _d5 ne '' then eventdate = (_d5 + mdy(1, 1, 2005))/2;
else if _d4 ne '' then eventdate = (_d4 + mdy(1, 1, 2005))/2;
else if _d3 ne '' then eventdate = (_d3 + mdy(1, 1, 2005))/2;
else if _d2 ne '' then eventdate = (_d2 + mdy(1, 1, 2005))/2;
else if _d1 ne '' then eventdate = (_d1 + mdy(1, 1, 2005))/2;
keep subjid eventdate;
run;

/* Decomposed dd11: Individuals missing HF question answer for all AFUs before 01/01/2005 N = 1240*/

data dd12;
merge temp13 dd11 (in = a keep = subjid visitdate);
by subjid;
if a;
run;

/* 
dd13: Individuals missing HF question answer for all AFUs before 01/01/2005 and “No” at the first AFU after 01/01/2005 N = 1109
dd14: Individuals missing HF question answer for all AFUs before 01/01/2005 and “Yes” at the  first AFU after 01/01/2005 N = 25 (cat = 10)
dd15: Individuals missing HF question answer for all AFUs before 01/01/2005 and Missing at all the AFUs after 01/01/2005 N = 106 (cat = 11)
*/

data dd13 dd14 (keep = subjid) dd15 (keep = subjid);
set dd12;
if hfever = 'N' OR hflastcntct = 'N' then output dd13 ;
if hfever = 'Y' OR hflastcntct = 'Y' then output dd14;
if hfever = '' AND hflastcntct = '' then output dd15 ;
run;

*Decomposed dd13: participants misisng HF question answer from all AFUs before 01/01/2005, but reported non-HF event on first AFU after  01/01/2005;

/* 
dd16: subjects do not report HF status at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005 with Form A Question 7b (can be used to generate incidence data set): N = 984 (cat = 8)
dd17: subjects do not report HF status at any AFU before 01/01/2005 and “No” at the first AFU after 01/01/2005 with Form C Question 9 (can not be used to generate incidence data set): N = 125 (cat = 9)
*/
 
data dd16 (drop = hfever hflastcntct) dd17 (drop = hfever hflastcntct);
set dd13;
by subjid;
if hfever = 'N' then output dd16;
if hflastcntct = 'N' then output dd17;
run;

/*
Total population that can be used for HF incidence data set  N = 4770
128 identified HF from AFU including
N = 52 cat = 2 bb14
N = 16 cat = 3 bb15
N = 60 cat = 6 cc20
4642 negative from AFU HF
N = 3650 cat = 4 cc13
N = 8 cat = 5 cc17
N = 984 cat = 8 dd16
*/

data ee11;
set cc13 cc17 dd16;
keep subjid;
run;

/* AFU reported HF */

data ee21;
set bb13 cc20;
format CHFDiagnosis $40.;
CHFDiagnosis = 'AFU Reported HF';
hf = 1;
run;

proc sort data = ee21;
by subjid;
run;

data ee12;
set ltfu;
	  *specify three different censoring times lastDate, lastDate2, lastDate3 from LTFU;
      *lastDate:  *For non-deceased participants: Uses last known contact time prior to admin censoring date;
      *lastDate2: *For non-deceased participants: Uses last known contact time prior to admin censoring date if contacts past admin censoring date does not exist or admin censoring date if contacts past admin censoring date;
      *lastDate3: *For non-deceased participants: Uses admin censoring date;
* lastdate = lastdate2;
 lastdate = lastdate3;
keep subjid lastdate laststatus;
run;

* specify first HF event;

proc sort data = ee11;
by subjid;
run;

data ee13;
merge ee12 ee11 (in = a);
by subjid;
if a;
run;

data ee14;
merge cc16 (in = b) ee13 (in = a);
by subjid;
if a;
if b then hf = 1;
else hf = 0;
*if CHFDiagnosis = . then CHFDIAG3 = 0;
run;

proc freq data = ee14;
tables CHFDiagnosis hf/list missing;
run;

data ee15;
merge ee14 ee12;
by subjid;
run;

data ee16;
merge ee15 ee21;
by subjid;
run;

proc freq data = ee16;
tables CHFDiagnosis hf/list missing;
run;

/* Specify the category */

data check1;
set aa15;
keep subjid;
run;

proc sort data = check1;
by subjid;
run;

data check2;
set bb14;
keep subjid;
run;

data check3;
set bb15;
keep subjid;
run;

data check4;
set cc13;
keep subjid;
run;

data check5;
set cc17;
keep subjid;
run;

data check6;
set cc20;
keep subjid;
run;

data check7;
set cc15;
keep subjid;
run;

data check8;
set dd16;
keep subjid;
run;

data check81;
set dd17;
keep subjid;
run;

data check9;
set dd14;
keep subjid;
run;

data check10;
set dd15;
keep subjid;
run;

data check11;
set check1 (in = a) check2 (in = b) check3 (in = c) check4 (in = d) check5 (in = e) check6 (in = f) check7 (in = g) check8 (in = h) check81 (in = k) check9 (in = i)
check10 (in = j);
run;

proc sort data = check11 nodupkey;
by subjid;
run;

data ee17;
merge ee16 check1 (in = a) check2 (in = b) check3 (in = c) check4 (in = d) check5 (in = e) check6 (in = f) check7 (in = g) check8 (in = h) check81 (in = i) check9 (in = j)
check10 (in = k);
by subjid;
if a then cat = 1;
if b then cat = 2;
if c then cat = 3;
if d then cat = 4;
if e then cat = 5;
if f then cat = 6;
if g then cat = 7;
if h then cat = 8;
if i then cat = 9;
if j then cat = 10;
if k then cat = 11;
drop event_id;
run;

proc freq data = ee17;
tables cat;
run;

ods html;
proc freq data = ee17;
tables hf cat cat * hf/list missing;
run;
ods html close;

data ee18;
merge ee17 one (drop = ARIC);
by subjid;
run;

data final1;
set bb49;
format date mmddyy10. contacttype $40.;
if eventdate ne . then date = eventdate;
else date = lastdate;
if hf = . then do;
date = .;
contacttype = 'Previous or Uncertain HF';
end;
else if hf = 0 then contacttype = 'Censored';
else if hf = 1 then contacttype = CHFDiagnosis;
year = year(date);
days  = date - examdate;
years = days/365.25;
drop eventdate -- laststatus;
run;

data final2;
retain subjid hf examdate date year years days contacttype;
set final1;
run;

data final3;
set ee18;
format date mmddyy10. contacttype $40.;
if eventdate ne . then date = eventdate;
else date = lastdate;
if hf = . then do;
date = .;
contacttype = 'Previous or Uncertain HF';
end;
else if hf = 0 then contacttype = 'Censored';
else if hf = 1 then contacttype = CHFDiagnosis;
year = year(date);
days  = date - visitdate;
years = days/365.25;
rename hf = afuhf;
rename visitdate = afuexamdate;
rename date = afudate;
rename year = afuyear;
rename years = afuyears;
rename days = afudays;
rename contacttype = afucontacttype;
rename cat = afucat;
run;

/* Correct the censoring time using AFU data for consent negative patients that do not have AFU reported HF: 
if this patient gave negative consent at V1 and also do not have AFU reported HF, we will censor this patient at first AFU after 01/01/2005 instead of V1*/

data final31;
set final3;
if laststatus = 'Refused' and afuhf = 0;
keep subjid afucat;
run;

proc freq data = final31;
tables afucat;
run;

data final32;
merge final31(in = a) temp13;
by subjid;
if a;
run;

proc freq data = final32;
tables afucat * hfever * hflastcntct/list missing;
run;

data final33;
merge final3 final32 (keep = subjid date);
by subjid;
run;

data final34;
set final33;
afudate = max(afudate, date);
afuyear = year(afudate);
afudays  = afudate - afuexamdate;
afuyears = afudays/365.25;
drop eventdate -- laststatus date;
run;

proc freq data = final3;
tables afucat afuhf/list missing;
run;

proc means data = final3 n nmiss sum;
var afuyears afuhf;
run;

proc freq data = final34;
tables afucat afuhf/list missing;
run;

proc means data = final34 n nmiss sum;
var afuyears afuhf;
run;

data final4;
retain subjid afuhf afuexamdate afudate afuyear afuyears afudays afucontacttype afucat;
set final34;
run;

data final5;
merge final2 final4;
by subjid;
run;

proc freq data = final5;
tables hf cat cat * hf hf * contacttype 
afuhf afucat afucat * afuhf afuhf * afucontacttype hf * afuhf hf * afuhf * afucat/list missing;
run;

*data events.incevthfder;
data incevthfder;
set final5;
          label HF = "Incidence Heart Failure";
          label Examdate = "Incidence Assessment Start Point";
          label date = "Event or Censoring Date";
          label year = "Event or Censoring Year";
          label days = "Follow-up Days";
          label years = "Follow-up Years";
          label contactType = "Last Contact Type";
		  label cat = 'Heart Failure Status Category';

          label AFUHF = "AFU Combined Incidence Heart Failure";
          label AFUExamdate = "AFU Combined Incidence Assessment Start Point";
          label AFUdate = "AFU Combined Event or Censoring Date";
          label AFUyear = "AFU Combined Event or Censoring Year";
          label AFUdays = "AFU Combined Follow-up Days";
          label AFUyears = "AFU Combined Follow-up Years";
          label AFUcontactType = "AFU Combined Last Contact Type";
		  label AFUcat = 'AFU Combined Heart Failure Status Category';

run;

/**Data correction - For J508104, it may have HF event on 11/18/2011, still in the verification process from UNC, at this stage, set as missing;*/
/**/
/*data events.incevthfder;*/
/*set events.incevthfder;*/
/*if subjid = 'J508104' then do;*/
/*hf = .;*/
/*examDate = .;*/
/*contacttype = 'Uncertain Final HF Status';*/
/*date = .;*/
/*year = .;*/
/*years = .;*/
/*days = .;*/
/**/
/*ghf = .;*/
/*gexamDate = .;*/
/*gcontacttype = 'Uncertain Final HF Status';*/
/*gdate = .;*/
/*gyear = .;*/
/*gyears = .;*/
/*gdays = .;*/
/*end;*/
/*          format hf ghf ynfmt.;*/
/*run;*/

data events.incevthfder;
set incevthfder;
          format hf afuhf ynfmt.;
run;

proc datasets lib = work;
save ltfu lostfu lostfu1;
run;
