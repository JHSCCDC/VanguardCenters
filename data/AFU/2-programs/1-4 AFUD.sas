options nofmterr;

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

data afud_aric;
set afu.afud_aric;
format _all_;
*rename AFU31=AFUD32
	   AFU64=AFUD65;
type="ARIC";
rename afud0a=date;
run;

data afud_jhs;
set afu.afud_jhs;
format _all_;
drop date;
type="JHS";
run;

data afud_jhs;
set afud_jhs;
rename AFUD0A=date;
run;

data afud;

set afud_jhs afud_aric;

rename afud71=maritalStatus
	   afud1=finalStatus
	   afud72=resultCode
	
	   afud52=inptHosp
	   afud58=outptHosp
	   afud59=outptHospHeart

	   afud53a=hospReason1
	   afud54a=hospReason2
	   afud55a=hospReason3
	   afud56a=hospReason4
	   afud57a=hospReason5
	   	
	   afud61=nursingEver
	   afud62=nursingCurrent
	   	
	   afud70=cigaretteSmoke
	   	
	   afud17=healthPerception
	   	
	   afud66d=HFmedsAFU
	   afud66a=BPmedsAFU
	   afud66c=DMmedsAFU
	   afud66b=statinMedsAFU
	   afud67=aspirinMedsAFU

	   afud68=medsReport
	   afud69=meds1
	   	
	   afud20=chronicLungLastCntct
	   	
	   afud21a=breathingWake
	   afud21b=breathingHurrying
	   afud21c=breathingWalking
	   afud21d=breathingStopPace
	   afud21e=breathingStopYards
	   afud22=breathingNotWalking
	   afud23=breathingCoughing
	
	   afud24=asthmaLastCntct
	   	
	   afud49=strokeLastCntct
	   afud50=strokeHosp
	   	
	   afud37=MIlastCntct
	   afud38=MIHospLastCntct
	   afud41=anginaLastCntct
	   afud18=HTNLastCntct
	   afud19=DMlastCntct
	   afud43=DVTlastCntct
	   afud44=DVThosp
	   afud46=PElastCntct
	   afud47=PEhosp

	   afud63=cardiacSurgeryYN
	   afud64a=cardiacSurgeryBypass
	   afud64b=cardiacProcOther
	   afud64c=cardiacProcCarotid
	   afud64d=cardiacProcCarotidSite
	   afud64e=cardiacProcRevasc
	   afud64f=cardiacSurgeryOther
	   afud65=cardiacAngio
	   afud65a=cardiacAngioCoronary
	   afud65b=cardiacAngioNeck
	   afud65c=cardiacAngioLower

	   afud31=HFlastCntct
	   afud34=HFhospLastCntct
	   afud32=HFweakLastCntct

	   afud42=atrialFib
	   	
	   afud27=swellingFeet
	   afud27a=swellingGone
	   	
	   afud26=PADpain
	   afud25=PADever

	   afud28=cancerEver
	   afud28a=cancerFirstLocation;

hospDate1=catx("/", of afud53c1 afud53c2);
	if afud53c1=. then hospDate1=afud53c2;
	if afud53c2=. then hospDate1="";

hospDate2=catx("/", of afud54c1 afud54c2);
	if afud54c1=. then hospDate2=afud54c2;
	if afud54c2=. then hospDate2="";

hospDate3=catx("/", of afud55c1 afud55c2);
	if afud55c1=. then hospDate3=afud55c2;
	if afud55c2=. then hospDate3="";

hospDate4=catx("/", of afud56c1 afud56c2);
	if afud56c1=. then hospDate4=afud56c2;
	if afud56c2=. then hospDate4="";

hospDate5=catx("/", of afud57c1 afud57c2);
	if afud57c1=. then hospDate5=afud57c2;
	if afud57c2=. then hospDate5="";


drop AFUD0b AFUD3 AFUD4 AFUD5a AFUD5b AFUD5c
	 AFUD6 AFUD6a AFUD7 AFUD8a AFUD8b1 AFUD8b2
	 AFUD9a AFUD9a1 AFUD9b1 AFUD9b2 AFUD10 AFUD11a AFUD11b
	 AFUD11b1 AFUD11c1 AFUD11c2 AFUD12a AFUD12b AFUD12b1 
	 AFUD12c1 AFUD12c2 AFUD13a AFUD13b AFUD13b1 AFUD13c1
	 AFUD13c2 AFUD14 AFUD15 AFUD16a AFUD16a1 AFUD16b1 AFUD16b2
	 AFUD28b1 AFUD28b2 AFUD29 AFUD29a AFUD30 AFUD33a AFUD33b
	 AFUD33c AFUD33d AFUD33e1 AFUD33e2 AFUD35a AFUD35a1 AFUD35b1
	 AFUD35b2 AFUD36 AFUD39a AFUD39a1 AFUD39b1 AFUD39b2 AFUD40
	 AFUD40a1 AFUD40b1 AFUD40b2 AFUD45a AFUD45a1 AFUD45b1
	 AFUD45b2 AFUD48a AFUD48a1 AFUD48b1 AFUD48b2 AFUD51a AFUD51a1
	 AFUD51b1 AFUD51b2 AFUD53b AFUD53b1 AFUD54b AFUD54b1 
	 AFUD55b AFUD55b1 AFUD56b AFUD56b1
	 AFUD57b AFUD57b1 AFUD53c1 AFUD53c2 AFUD54c1 AFUD54c2
	 AFUD55c1 AFUD55c2 AFUD56c1 AFUD56c2 AFUD57c1 AFUD57c2
	 AFUD60a AFUD60a1 AFUD60b1 AFUD60b2 AFUD64E1
	 pilot AFUDflag afud8a1;

run;

data afod;
length vers $2.;
set afo.afod;
vers="OD";
drop date;

if ^missing(AFOD47) & ^missing(AFOD48) & ^missing(AFOD49) & ^missing(AFOD50) then finalStatus="A";

run;

data afod;
set afod;

rename AFOD46a=employmentStatus
	   AFOD46b=employedStatus
	   AFOD46c=unemployedStatus
	   AFOD46d=retiredStatus
	
	   AFOD39=fxHeavy
	   AFOD40=fxStairs
	   AFOD41=fxWalk
	   AFOD42a=fxWork
	   AFOD42b=fxWorkHeart
	   AFOD43a=fxWorkMiss
	   AFOD43b=fxWorkMissDays
	   AFOD44a=fxActivities
	   AFOD44b=fxActivitiesHeart
	   AFOD45a=fxActivitiesCut
	   AFOD45b=fxActivitiesCutDays
	
	   AFOD1a=cardiacEcho
	   AFOD1a1=cardiacEchoReason
	   AFOD1a2=cardiacEchoSpecify
	   AFOD1b=cardiacECG
	   AFOD1b1=cardiacECGReason
	   AFOD1b2=cardiacECGSpecify
	   AFOD1c=cardiacStress
	   AFOD1c1=cardiacStressReason
	   AFOD1c2=cardiacStressSpecify
	   AFOD1d=cardiacCTMRI
	   AFOD1d1=cardiacCTMRIReason
	   AFOD1d2=cardiacCTMRISpecify
	   AFOD1e=cardiacCath
	   AFOD1e1=cardiacCathNeck
	   AFOD2a1=cardiacCathNeckReason
	   AFOD2a=cardiacCathNeckSpecify
	   AFOD1e2=cardiacCathHeart
	   AFOD2b1=cardiacCathHeartReason
	   AFOD2b=cardiacCathHeartSpecify
	   AFOD1e3=cardiacCathKidneys
	   AFOD2c1=cardiacCathKidneysReason
	   AFOD2c=cardiacCathKidneysOther
	   AFOD1e4=cardiacCathLegs
	   AFOD2d1=cardiacCathLegsReason
	   AFOD2d=cardiacCathLegsSpecify
	
	   AFOD35c=hormoneFirstName
	   AFOD37=hormoneSecondYN
	   AFOD37a=hormoneSecondName
	
	   AFOD13a=healthcareDentist
	   AFOD13b=healthcareDoctor
	   AFOD13c=healthcareChiro
	   AFOD13d=healthcareAcupunct
	   AFOD13e=healthcareFaith
	   AFOD13f=healthcareRoots
	   AFOD13g=healthcareAstrology
	   AFOD13h=healthcareTea
	   AFOD23=healthcareDoctorNumber
	
	   AFOD14=insuranceCoverage
	   AFOD15=insuranceCoverageLapseTime
	   AFOD16a=insurancePrivate
	   AFOD16b=insuranceMedicaid
	   AFOD16c=insuranceMedicare
	   AFOD16d=insuranceVeteran
	   AFOD16e=insuranceOther
	   AFOD18=insuranceCoverageLapseYN
	   AFOD20=insuranceMeds
	   AFOD22a=insuranceMedsNoLimits
	   AFOD17b=insuranceMedsCut
	   AFOD22e=insuranceMedsNumber
	   AFOD22f=insuranceMedsFillLimit
	   AFOD22g=insuranceMedsTimeLimit
	   AFOD22b=insuranceMedsCostLimit
	   AFOD22c=insuranceMedsLimitAmt
	   AFOD22d=insuranceMedsNumberLimit
	   AFOD22h=insuranceMedsOtherLimits
	   AFOD22i=insuranceMedsLimits
	
	   AFOD17a=costIncreasePremiums
	   AFOD17c=costIncreaseShare
	   AFOD19=costMedsAverage
	   AFOD21=costMedsCopay
	   AFOD30=costSacrificeHealthcare
	   AFOD31a=costSacrificeMeds
	   AFOD31b=costSacrificeSpecialist
	   AFOD31c=costSacrificeTreatment
	   AFOD31d=costSacrificeDoctor
	   AFOD31e=costSacrificeOther
	   AFOD29=costProblem
	
	   AFOD24=satisfactionListen
	   AFOD25=satisfactionExplain
	   AFOD26=satisfactionRespect
	   AFOD27=satisfactionTime
	   AFOD28=satisfactionQuality
	   AFOD32=satisfactionConfident
	
	   AFOD7=stressPastYear
	   AFOD8=depressedPastYear
	   AFOD9=nervousPastYear
	   AFOD10=discriminationPastYear
	   AFOD11=stressCopePastYear
	   AFOD12=supportPastYear
	
	   AFOD3=famHistoryChange
	   AFOD4a1=famRelationship1
	   AFOD4a2=famCOD1 
	   AFOD4a4=famCODSpecify1
	   AFOD4a3=famAge1
	   AFOD4b1=famRelationship2
	   AFOD4b2=famCOD2
	   AFOD4b4=famCODSpecify2
	   AFOD4b3=famAge2
	   AFOD4c1=famRelationship3
	   AFOD4c2=famCOD3
	   AFOD4c4=famCODSpecify3
	   AFOD4c3=famAge3
	   AFOD4d1=famRelationship4
	   AFOD4d2=famCOD4
	   AFOD4d4=famCODSpecify4
	   AFOD4d3=famAge4
	   AFOD5=famNewDiagYN
	   AFOD6a1=famNewDiagRelationship1
	   AFOD6a2=famNewDiagDX1
	   AFOD6a3=famNewDiagAge1
	   AFOD6a4=famNewDiagDXSpecify1
	   AFOD6b1=famNewDiagRelationship2
	   AFOD6b2=famNewDiagDX2
	   AFOD6b3=famNewDiagAge2
	   AFOD6b4=famNewDiagDXSpecify2
	   AFOD6c1=famNewDiagRelationship3
	   AFOD6c2=famNewDiagDX3
	   AFOD6c3=famNewDiagAge3
	   AFOD6c4=famNewDiagDXSpecify3
	   AFOD6d1=famNewDiagRelationship4
	   AFOD6d2=famNewDiagDX4
	   AFOD6d3=famNewDiagAge4
	   AFOD6d4=famNewDiagDXSpecify4
	   AFOD47=date;

if AFOD35a=1 | AFOD35b=1 then hormoneFirstYN="Y";
if AFOD35a=2 & AFOD35b=. then hormoneFirstYN="N";
if AFOD35a=. & AFOD35b=2 then hormoneFirstYN="N";
if AFOD35a=. & AFOD35b=. then hormoneFirstYN="";

drop afod33 afod34
	 afod35a afod35b afod36 afod38 afod48 afod49 afod50 pilot afodflag;

run;

data afud;
length vers $2.;
set afud afod;

if resultCode="A" then resultCode2=3;
else if resultCode="B" then resultCode2=4;
else if resultCode="C" then resultCode2=4;

drop resultCode;

run;

data afud;
set afud;
rename resultCode2=resultCode;
run;

proc sort data=afud; by subjid; run;
proc sort data=cohort; by subjid; run;

data afud;
merge afud(in=a) cohort(in=b);
by subjid;
if a & b;

* Create complete/incomplete;

if finalStatus in("A", "B") then do;
	complete="C";
	alive="Y";
end;

if finalStatus in("C", "D") then do;
	complete="I";
	if AFUD2="Y" then alive="U"; 
	else alive="Y";
end; 

if finalstatus in("E" "F") then do;
	complete="I";
	alive="U";
end;

drop finalStatus AFUD2;

run;

data afud;
set afud;
if type="JHS" & ARIC=1 then delete;
if type="ARI" & ARIC=0 then delete;
run;

data afu.afud;
set afud;
drop type aric;
run;
