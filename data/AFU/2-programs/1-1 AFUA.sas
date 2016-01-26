option nofmterr;

%macro sort1(d);
proc sort data=&d; 
by subjid; 
run;
%mend sort1;

%macro sort2(d);
proc sort data=&d; 
by subjid date; 
run;
%mend sort2;

data cohort;
set cohort.visitdat;
_aric=substr(subjid, 2, 1)+0;
if _aric<5 then aric=1;
else aric=0;
keep subjid v1date aric;
run;

data afua_aric;
set afu.afua_aric;
run;

%sort1(d=cohort);
%sort1(d=afua_aric);

data afua_aric;
merge afua_aric(in=a) cohort;
by subjid;
if a;
days=afua1-v1date;
if days<180 then delete; * Take out any with AFU happening less than 6 months after JHS V1;
type="ARIC";

hormoneFirstName=catt(AFUA19C) || catt(AFUA19D);
hormoneSecondName=catt(AFUA21A) || catt(AFUA21B);

drop AFUA19C AFUA19D AFUA21A AFUA21B;

run;

data afua_jhs;
set afu.afua_jhs;
type="JHS";

hormoneFirstName=AFUA19C;
hormoneSecondName=AFUA21A;

drop AFUA19C AFUA21A;

run;

data afua;
length AFUA7J AFUA7M $20. hormoneFirstName hormoneSecondName $500.;
set afua_jhs afua_aric;

rename afua1=date
	   afua31=maritalStatus
	   afua10=inptHosp
	   afua11a=nursingEver
	   afua11b=nursingCurrent
	   afua30=cigaretteSmoke
	   afua32a=employmentStatus
	   afua32b=employedStatus
	   afua32c=unemployedStatus
	   afua32d=retiredStatus
	   afua6=healthPerception
	   afua23=fxHeavy
	   afua24=fxStairs
	   afua25=fxWalk
	   afua26a=fxWork
	   afua26b=fxWorkHeart
	   afua27a=fxWorkMiss
	   afua27b=fxWorkMissDays
	   afua28a=fxActivities
	   afua28b=fxActivitiesHeart
	   afua29a=fxActivitiesCut
	   afua29b=fxActivitiesCutDays
	   afua16a=BPmedsAFU
	   afua16c=DMmedsAFU
	   afua16b=statinMedsAFU
	   afua17=aspirinMedsAFU
	   afua7g=chronicLungEver
	   afua7h=asthmaEver
	   afua8=strokeLastCntct
	   afua7a=MIever
	   afua9=MIHospLastCntct
	   afua7c=HTNever
	   afua7d=DMever
	   afua7e=DVTever
	   afua7f=PEever
	   afua13a=cardiacSurgeryBypass
	   afua13b=cardiacProcOther
	   afua13c=cardiacProcCarotid
	   afua13d=cardiacProcCarotidSite
	   afua13e=cardiacProcRevasc
	   afua13f=cardiacSurgeryOther
	   afua15a=cardiacAngioCoronary
	   afua15b=cardiacAngioNeck
	   afua15c=cardiacAngioLower
	   afua7b=HFever
	   afua7i=cancerEver
	   afua7j=cancerFirstLocation
	   afua7k=cancerFirstDate
	   afua7l=cancerSecond
	   afua7m=cancerSecondLocation
	   afua7n=cancerSecondDate
	   afua21=hormoneSecondYN
	   afua2=finalStatus
	   afua36=resultCode
	   afua3a=cOptions
	   afua3b=rOptions
	   afua3c=dOptions
	   afua37a=hospReason1
	   afua37b=hospReason2
	   afua37c=hospReason3
	   afua37d=hospReason4
	   afua37e=hospReason5
	   afua37f=hospReason6
	   afua39a=hospDate1
	   afua39b=hospDate2
	   afua39c=hospDate3
	   afua39d=hospDate4
	   afua39e=hospDate5
	   afua39f=hospDate6
	   ;

if afua12="Y" then cardiacSurgeryYN=afua12a;
if afua12="N" then cardiacSurgeryYN=afua12b;

if afua14="Y" then cardiacAngio=afua14a;
if afua14="N" then cardiacAngio=afua14b;

if afua19="Y" then hormoneFirstYN=afua19a;
if afua19="N" then hormoneFirstYN=afua19b;

drop AFUA38A AFUA38B AFUA38C AFUA38D AFUA38E AFUA38F AFUA5A AFUA5B AFUA4 
	 AFUA40A AFUA40B AFUA40C AFUA40D AFUA40E AFUA40F AFUA12 AFUA12a 
	 AFUA12b AFUA14 AFUA14a AFUA14b AFUA19 AFUA19a AFUA19b AFUA18 AFUA20
	 AFUA22 AFUA33 AFUA34 AFUA35 AFUA41 AFUA3 v1date days pilot;
run;

data afoa;

length vers $2.;

format _all_;

set afo.afoa;

if ^missing(AFOA10) & ^missing(AFOA12) then finalStatus="C";
if ^missing(AFOA11) & ^missing(AFOA12) then finalStatus="C";
if ^missing(AFOA10) & ^missing(AFOA11) then finalStatus="C";

vers="OA";

rename afoa1a=anginaMedsAFU
	   afoa1b=heartMedsAFU
	   afoa2a=cardiacEcho
	   afoa2b=cardiacECG
	   afoa2c=cardiacStress
	   afoa2d=cardiacCTMRI
	   afoa3a=healthcareDentist
	   afoa3b=healthcareDoctor
	   afoa3c=healthcareChiro
	   afoa3d=healthcareAcupunct
	   afoa3e=healthcareFaith
	   afoa3f=healthcareRoots
	   afoa3g=healthcareAstrology
	   afoa3h=healthcareTea
	   afoa4=stressPastYear
	   afoa5=depressedPastYear
	   afoa6=nervousPastYear
	   afoa7=discriminationPastYear
	   afoa8=stressCopePastYear
	   afoa9=supportPastYear
	   afoa10=date;

drop afoa11 afoa12;

run;

data afua;
length vers $2.;
set afua afoa;
format _all_;
run;

%sort2(d=afua);

data afua;
set afua;

* Convert character to numeric for variables that change type over time;

if employmentStatus="A" then employmentStatus2=1;
else if employmentStatus="B" then employmentStatus2=2;
else if employmentStatus="C" then employmentStatus2=3;
else if employmentStatus="D" then employmentStatus2=4;

if employedStatus="A" then employedStatus2=1;
else if employedStatus="B" then employedStatus2=2;

if unemployedStatus="A" then unemployedStatus2=1;
else if unemployedStatus="A" then unemployedStatus2=2;

if retiredStatus="A" then retiredStatus2=1;
else if retiredStatus="B" then retiredStatus2=2;

if fxHeavy="Y" then fxHeavy2=1;
else if fxHeavy="N" then fxHeavy2=2;

if fxStairs="Y" then fxStairs2=1;
else if fxStairs="N" then fxStairs2=2;

if fxWalk="Y" then fxWalk2=1;
else if fxWalk="N" then fxWalk2=2;

if fxWork="Y" then fxWork2=1;
else if fxWork="N" then fxWork2=2;
else if fxWork="A" then fxWork2=9;

if fxWorkHeart="Y" then fxWorkHeart2=1;
else if fxWorkHeart="N" then fxWorkHeart2=2;
else if fxWorkHeart="U" then fxWorkHeart2=7;

if fxWorkMiss="Y" then fxWorkMiss2=1;
else if fxWorkMiss="N" then fxWorkMiss2=2;

if fxActivities="Y" then fxActivities2=1;
else if fxActivities="N" then fxActivities2=2;

if fxActivitiesHeart="Y" then fxActivitiesHeart2=1;
else if fxActivitiesHeart="N" then fxActivitiesHeart2=2;
else if fxActivitiesHeart="U" then fxActivitiesHeart2=7;

if fxActivitiesCut="Y" then fxActivitiesCut2=1;
else if fxActivitiesCut="N" then fxActivitiesCut2=2;

if anginaMedsAFU="Y" then anginaMedsAFU2=1;
else if anginaMedsAFU="N" then anginaMedsAFU2=2;

if anginaMedsAFU="Y" then anginaMedsAFU2=1;
else if anginaMedsAFU="N" then anginaMedsAFU2=2;

if heartMedsAFU="Y" then heartMedsAFU2=1;
else if heartMedsAFU="N" then heartMedsAFU2=2;

if cardiacEcho="Y" then cardiacEcho2=1;
else if cardiacEcho="N" then cardiacEcho2=2;

if cardiacECG="Y" then cardiacECG2=1;
else if cardiacECG="N" then cardiacECG2=2;

if cardiacStress="Y" then cardiacStress2=1;
else if cardiacStress="N" then cardiacStress2=2;

if cardiacCTMRI="Y" then cardiacCTMRI2=1;
else if cardiacCTMRI="N" then cardiacCTMRI2=2;

if cardiacCTMRI="Y" then cardiacCTMRI2=1;
else if cardiacCTMRI="N" then cardiacCTMRI2=2;

if hormoneSecondYN="Y" then hormoneSecondYN2=1;
else if hormoneSecondYN="N" then hormoneSecondYN2=2;

if healthcareDentist="Y" then healthcareDentist2=1;
else if healthcareDentist="N" then healthcareDentist2=2;

if healthcareDoctor="Y" then healthcareDoctor2=1;
else if healthcareDoctor="N" then healthcareDoctor2=2;

if healthcareChiro="Y" then healthcareChiro2=1;
else if healthcareChiro="N" then healthcareChiro2=2;

if healthcareAcupunct="Y" then healthcareAcupunct2=1;
else if healthcareAcupunct="N" then healthcareAcupunct2=2;

if healthcareFaith="Y" then healthcareFaith2=1;
else if healthcareFaith="N" then healthcareFaith2=2;

if healthcareRoots="Y" then healthcareRoots2=1;
else if healthcareRoots="N" then healthcareRoots2=2;

if healthcareAstrology="Y" then healthcareAstrology2=1;
else if healthcareAstrology="N" then healthcareAstrology2=2;

if healthcareTea="Y" then healthcareTea2=1;
else if healthcareTea="N" then healthcareTea2=2;

if stressPastYear="A" then stressPastYear2=1;
else if stressPastYear="B" then stressPastYear2=2;
else if stressPastYear="C" then stressPastYear2=3;
else if stressPastYear="D" then stressPastYear2=4;
else if stressPastYear="E" then stressPastYear2=5;
else if stressPastYear="F" then stressPastYear2=6;

if depressedPastYear="A" then depressedPastYear2=1;
else if depressedPastYear="B" then depressedPastYear2=2;
else if depressedPastYear="C" then depressedPastYear2=3;
else if depressedPastYear="D" then depressedPastYear2=4;
else if depressedPastYear="E" then depressedPastYear2=5;
else if depressedPastYear="F" then depressedPastYear2=6;

if nervousPastYear="A" then nervousPastYear2=1;
else if nervousPastYear="B" then nervousPastYear2=2;
else if nervousPastYear="C" then nervousPastYear2=3;
else if nervousPastYear="D" then nervousPastYear2=4;
else if nervousPastYear="E" then nervousPastYear2=5;
else if nervousPastYear="F" then nervousPastYear2=6;

if discriminationPastYear="A" then discriminationPastYear2=1;
else if discriminationPastYear="B" then discriminationPastYear2=2;
else if discriminationPastYear="C" then discriminationPastYear2=3;
else if discriminationPastYear="D" then discriminationPastYear2=4;
else if discriminationPastYear="E" then discriminationPastYear2=5;
else if discriminationPastYear="F" then discriminationPastYear2=6;

if stressCopePastYear="A" then stressCopePastYear2=1;
else if stressCopePastYear="B" then stressCopePastYear2=2;
else if stressCopePastYear="C" then stressCopePastYear2=3;
else if stressCopePastYear="D" then stressCopePastYear2=4;
else if stressCopePastYear="E" then stressCopePastYear2=5;
else if stressCopePastYear="F" then stressCopePastYear2=6;

if supportPastYear="A" then supportPastYear2=1;
else if supportPastYear="B" then supportPastYear2=2;
else if supportPastYear="C" then supportPastYear2=3;
else if supportPastYear="D" then supportPastYear2=4;
else if supportPastYear="E" then supportPastYear2=5;
else if supportPastYear="F" then supportPastYear2=6;

drop employmentStatus employedStatus unemployedStatus retiredStatus
	 fxHeavy fxStairs fxWork fxWorkHeart fxWorkMiss fxActivities
	 fxActivitiesHeart fxActivitiesCut anginaMedsAFU heartMedsAFU
	 cardiacEcho cardiacECG cardiacStress cardiacCTMRI hormoneSecondYN
	 healthcareDentist healthcareDoctor healthcareChiro healthcareAcupunct
	 healthcareFaith healthcareRoots healthcareAstrology healthcareTea
	 stressPastYear depressedPastYear nervousPastYear discriminationPastYear
	 stressCopePastYear supportPastYear fxWalk;

run;

data afua;
set afua;
rename employmentstatus2=employmentStatus
	   employedStatus2=employedStatus
	   unemployedStatus2=unemployedStatus
	   retiredStatus2=retiredStatus
	   fxHeavy2=fxHeavy 
	   fxStairs2=fxStairs 
	   fxWork2=fxWork
	   fxWorkHeart2=fxWorkHeart 
	   fxWorkMiss2=fxWorkMiss 
	   fxActivities2=fxActivities
	   fxWalk2=fxWalk
	   fxActivitiesHeart2=fxActivitiesHeart 
	   fxActivitiesCut2=fxActivitiesCut 
	   anginaMedsAFU2=anginaMedsAFU 
	   heartMedsAFU2=heartMedsAFU
	   cardiacEcho2=cardiacEcho 
	   cardiacECG2=cardiacECG 
	   cardiacStress2=cardiacStress 
	   cardiacCTMRI2=cardiacCTMRI 
	   hormoneSecondYN2=hormoneSecondYN
	   healthcareDentist2=healthcareDentist 
	   healthcareDoctor2=healthcareDoctor 
	   healthcareChiro2=healthcareChiro 
	   healthcareAcupunct2=healthcareAcupunct
	   healthcareFaith2=healthcareFaith 
	   healthcareRoots2=healthcareRoots 
	   healthcareAstrology2=healthcareAstrology 
	   healthcareTea2=healthcareTea
	   stressPastYear2=stressPastYear 
	   depressedPastYear2=depressedPastYear 
	   nervousPastYear2=nervousPastYear 
	   discriminationPastYear2=discriminationPastYear
	   stressCopePastYear2=stressCopePastYear 
	   supportPastYear2=supportPastYear;
run;

proc sort data=afua; by subjid; run;
proc sort data=cohort; by subjid; run;

data afua;
merge afua(in=a) cohort(in=b);
by subjid;
if a & b;

* Relabel the final status into incomplete/complete;

if finalStatus in("C", "F") then complete="C";
if finalStatus in("D", "R", "U") then complete="I";
if finalStatus="" & subjid in("J135977" "J197117") then do;
	complete="C";
	alive="Y";
end;

* Create final status variable for events;

if finalStatus in("C" "F" "R") then alive="Y";
if finalStatus in("D" "U") then alive="U";

run;

/*
proc freq data=afua;
table type*aric;
run;
*/

* Remove ARIC participants that are appearing in JHS dataset;
* Remove JHS participants that are appearing in ARIC dataset;

data afua;
set afua;
if type="JHS" & ARIC=1 then delete;
if type="ARI" & ARIC=0 then delete;
run;

data afu.afua;
set afua;
drop aric type;
run;
