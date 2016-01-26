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

data afuc_aric;
set afu.afuc_aric;
format _all_;
type="ARIC";
rename afuc26c=outptHospDate
	   afuc21c=cancerFirstDate;
run;

data afuc_jhs;
set afu.afuc_jhs;

format _all_;

cancerFirstDate=catx("/", of afuc21c1 afuc21c2);
	if afuc21c1=. then cancerFirstDate=afuc21c2;
	if afuc21c2=. then cancerFirstDate="";
	
outptHospDate=catx("/", of afuc26c1 afuc26c2);
	if afuc26c1=. then outptHospDate=afuc26c2;
	if afuc26c2=. then outptHospDate="";

type="JHS";

run;

data afuc;

length afuc21b afuc48a afuc48b afuc48c afuc48d
	   afuc48e afuc48f afuc48g afuc48h afuc48i
	   afuc48j afuc48k afuc48l afuc48m afuc48n 
 	   afuc48o afuc48p afuc48q afuc48r afuc48s
	   afuc48t $60.;

set afuc_jhs afuc_aric;

rename afuc1=date
	   afuc51=maritalStatus
	   afuc2=finalStatus
	   afuc55=resultCode
	   afuc3a=cOptions
	   afuc3b=rOptions
	   afuc3c=dOptions
	   afuc21a=cancerEver
	
	   afuc24=inptHosp
	   afuc25a=outptHosp
	   afuc25b=outptHospHeart

	   afuc28a=hospReason1
	   afuc29a=hospReason2
	   afuc30a=hospReason3
	   afuc31a=hospReason4
	   afuc32a=hospReason5
	   afuc33a=hospReason6
	   afuc34a=hospReason7
	   afuc35a=hospReason8
	   afuc36a=hospReason9
	   afuc37a=hospReason10
	   afuc38a=hospReason11
	   afuc39a=hospReason12
	   	
	   afuc27a=nursingEver
	   afuc27b=nursingCurrent

	   afuc21b=cancerFirstLocation
	   	
	   afuc50=cigaretteSmoke
	   	
	   afuc6=healthPerception
	   	
	   afuc46d=HFmedsAFU
	   afuc46a=BPmedsAFU
	   afuc46c=DMmedsAFU
	   afuc46b=statinMedsAFU
	   afuc49=aspirinMedsAFU
	   	
	   afuc18a=chronicLungEver
	   afuc18b=chronicLungLastCntct
	   	
	   afuc19a=breathingWake
	   afuc19b=breathingHurrying
	   afuc19c=breathingWalking
	   afuc19d=breathingStopPace
	   afuc19e=breathingStopYards
	   afuc19f=breathingNotWalking
	   afuc19g=breathingCoughing
	
	   afuc20=asthmaEver
	   afuc20a=asthmaLastCntct
	   	
	   afuc22a=strokeLastCntct
	   afuc22b=strokeHosp
	   	
	   afuc11a=MIever
	   afuc23=MIHospLastCntct
	   afuc11b=anginaEver
	   afuc11c=anginaLastCntct
	   afuc14=HTNever
	   afuc15=DMever
	   afuc16=DVTever
	   afuc16c=DVTdate
	   afuc16d=DVThosp
	   afuc17a=PEever
	   afuc17b=PEhosp
	
	   afuc42a=cardiacSurgeryBypass
	   afuc42b=cardiacProcOther
	   afuc42b1=cardiacProcSpecify
	   afuc42c=cardiacProcCarotid
	   afuc42d=cardiacProcCarotidSite
	   afuc42e=cardiacProcRevasc
	   afuc42e1=cardiacProcRevascSpecify
	   afuc42f=cardiacSurgeryOther

	   afuc45a=cardiacAngioCoronary
	   afuc45b=cardiacAngioNeck
	   afuc45c=cardiacAngioLower

	   afuc8c=HFhosp

	   afuc9=HFlastCntct
	   afuc9c=HFlastCntctDate
	   afuc9e=HFhospLastCntct
	   afuc10=HFweakEver
	   afuc10c=HFweakDate
	   afuc10e=HFweakHosp
	
	   afuc12=atrialFib
	   	
	   afuc13a=swellingFeet
	   afuc13b=swellingGone
	   	
	   afuc20b=PADpain
	   afuc20c=PADever

	   afuc47=medsReport
	   afuc48a=meds1
	   afuc48b=meds2
	   afuc48c=meds3
	   afuc48d=meds4
	   afuc48e=meds5
	   afuc48f=meds6
	   afuc48g=meds7
	   afuc48h=meds8
	   afuc48i=meds9
	   afuc48j=meds10
	   afuc48k=meds11
	   afuc48l=meds12
	   afuc48m=meds13
	   afuc48n=meds14
	   afuc48o=meds15
	   afuc48p=meds16
	   afuc48q=meds17
	   afuc48r=meds18
	   afuc48s=meds19
	   afuc48t=meds20;

if afuc40="Y" then cardiacSurgeryYN=afuc41a;
if afuc40="N" then cardiacSurgeryYN=afuc41b;

if afuc8="Y" then HFever="Y";
if afuc8="N" then HFever=afuc9;
if afuc8e="U" | afuc8f="U" then HFhospEver="U";
if afuc8e="Y" | afuc8f="Y" then HFhospEver="Y";
if afuc8e="N" & afuc8f="N" then HFhospEver="N";

if afuc43="Y" then cardiacAngio=afuc44a;
if afuc43="N" then cardiacAngio=afuc44b;

hospDate1=catx("/", of afuc28c1 afuc28c2);
	if afuc28c1=. then hospDate1=afuc28c2;
	if afuc28c2=. then hospDate1="";

hospDate2=catx("/", of afuc29c1 afuc29c2);
	if afuc29c1=. then hospDate2=afuc29c2;
	if afuc29c2=. then hospDate2="";

hospDate3=catx("/", of afuc30c1 afuc30c2);
	if afuc30c1=. then hospDate3=afuc30c2;
	if afuc30c2=. then hospDate3="";

hospDate4=catx("/", of afuc31c1 afuc31c2);
	if afuc31c1=. then hospDate4=afuc31c2;
	if afuc31c2=. then hospDate4="";

hospDate5=catx("/", of afuc32c1 afuc32c2);
	if afuc32c1=. then hospDate5=afuc32c2;
	if afuc32c2=. then hospDate5="";

hospDate6=catx("/", of afuc33c1 afuc33c2);
	if afuc33c1=. then hospDate6=afuc33c2;
	if afuc33c2=. then hospDate6="";

hospDate7=catx("/", of afuc34c1 afuc34c2);
	if afuc34c1=. then hospDate7=afuc34c2;
	if afuc34c2=. then hospDate7="";

hospDate8=catx("/", of afuc35c1 afuc35c2);
	if afuc35c1=. then hospDate8=afuc35c2;
	if afuc35c2=. then hospDate8="";

hospDate9=catx("/", of afuc36c1 afuc36c2);
	if afuc36c1=. then hospDate9=afuc36c2;
	if afuc36c2=. then hospDate9="";

hospDate10=catx("/", of afuc37c1 afuc37c2);
	if afuc37c1=. then hospDate10=afuc37c2;
	if afuc37c2=. then hospDate10="";

hospDate11=catx("/", of afuc38c1 afuc38c2);
	if afuc38c1=. then hospDate11=afuc38c2;
	if afuc38c2=. then hospDate11="";

hospDate12=catx("/", of afuc39c1 afuc39c2);
	if afuc39c1=. then hospDate12=afuc39c2;
	if afuc39c2=. then hospDate12="";



drop afuc40 afuc8 afuc8e afuc8f afuc43 afuc44a afuc44b 
	 afuc52 afuc53 afuc54 afuc28c1 afuc28c2 afuc29c1 afuc29c2
	 afuc30c1 afuc30c2 afuc31c1 afuc31c2 afuc32c1 afuc32c2
	 afuc33c1 afuc33c2 afuc34c1 afuc34c2 afuc35c1 afuc35c2
	 afuc36c1 afuc36c2 afuc37c1 afuc37c2 afuc38c1 afuc38c2
	 afuc39c1 afuc39c2 afuc48a1 afuc48b1 afuc48c1 afuc48d1
	 afuc48e1 afuc48f1 afuc48g1 afuc48h1 afuc48i1 afuc48j1
	 afuc48l1 afuc48m1 afuc48n1 afuc48o1 afuc48p1 afuc48q1
	 afuc48r1 afuc48s1 afuc48t1 afuc5a afuc5b afuc7a afuc7b
	 afuc8a afuc8b afuc8c1 afuc8c2 afuc8d afuc9b afuc9a
	 afuc9c1 afuc9c2 afuc9d afuc10a afuc10b afuc10c1 afuc10c2
	 afuc10d afuc16a afuc16b afuc16c1 afuc16c2 afuc21c2
	 afuc21c1 afuc26a afuc26b afuc26c1 afuc26c2 afuc28b afuc28d
	 afuc29b afuc29d afuc30b afuc30d afuc31b afuc31d
	 afuc32b afuc32d afuc33b afuc33d afuc34b afuc34d
	 afuc35b afuc35d afuc36b afuc36d afuc37b afuc37d
	 afuc38b afuc38d afuc39b afuc39d afuc41a afuc41b pilot
	 afuc4 afuc3 afuc8g afuc9f afuc10f afuc48k1;

run;

data afoc;

length vers $2.;

set afo.afoc;

if ^missing(AFOC35) & ^missing(AFOC36) & ^missing(AFOC37) then finalStatus="C";

vers="OC";

rename afoc1a=anginaMedsAFU
	   afoc1b=heartMedsAFU
	   afoc1c=heartMedsNameAFU

	   afoc2b=HFcough
	   afoc2c=HFpillows
	   afoc2f=HFdoctor

	   afoc3a=cardiacEcho
	   afoc3a1=cardiacEchoReason
	   afoc3a2=cardiacEchoSpecify
	   afoc3b=cardiacECG
	   afoc3b1=cardiacECGReason
	   afoc3b2=cardiacECGSpecify
	   afoc3c=cardiacStress
	   afoc3c1=cardiacStressReason
	   afoc3c2=cardiacStressSpecify
	   afoc3d=cardiacCTMRI
	   afoc3d1=cardiacCTMRIReason
	   afoc3d2=cardiacCTMRISpecify
	   afoc3e=cardiacCath
	   afoc3e1=cardiacCathNeck
	   afoc4a1=cardiacCathNeckReason
	   afoc4a=cardiacCathNeckSpecify
	   afoc3e2=cardiacCathHeart
	   afoc4b1=cardiacCathHeartReason
	   afoc4b=cardiacCathHeartSpecify
	   afoc3e3=cardiacCathKidneys
	   afoc4c1=cardiacCathKidneysReason
	   afoc4c=cardiacCathKidneysOther
	   afoc3e4=cardiacCathLegs
	   afoc4d1=cardiacCathLegsReason
	   afoc4d=cardiacCathLegsSpecify

	   afoc5=famHistoryChange
	   afoc61a=famRelationship1
	   afoc61b=famCOD1
	   afoc61d=famCODSpecify1
	   afoc61c=famAge1
	   afoc62a=famRelationship2
	   afoc62b=famCOD2
	   afoc62d=famCODSpecify2
	   afoc62c=famAge2
	   afoc63a=famRelationship3
	   afoc63b=famCOD3
	   afoc63d=famCODSpecify3
	   afoc63c=famAge3
	   afoc64a=famRelationship4
	   afoc64b=famCOD4
	   afoc64d=famCODSpecify4
	   afoc64c=famAge4
	   afoc7=famNewDiagYN
	   afoc81a=famNewDiagRelationship1
	   afoc81b=famNewDiagDX1
	   afoc81c=famNewDiagAge1
	   afoc81d=famNewDiagDXSpecify1
	   afoc82a=famNewDiagRelationship2
	   afoc82b=famNewDiagDX2
	   afoc82c=famNewDiagAge2
	   afoc82d=famNewDiagDXSpecify2
	   afoc83a=famNewDiagRelationship3
	   afoc83b=famNewDiagDX3
	   afoc83c=famNewDiagAge3
	   afoc83d=famNewDiagDXSpecify3
	   afoc84a=famNewDiagRelationship4
	   afoc84b=famNewDiagDX4
	   afoc84c=famNewDiagAge4
	   afoc84d=famNewDiagDXSpecify4

	   afoc9=stressPastYear
	   afoc10=depressedPastYear
	   afoc11=nervousPastYear
	   afoc12=discriminationPastYear
	   afoc13=stressCopePastYear
	   afoc14=supportPastYear

	   afoc15a=healthcareDentist
	   afoc15b=healthcareDoctor
	   afoc15c=healthcareChiro
	   afoc15d=healthcareAcupunct
	   afoc15e=healthcareFaith
	   afoc15f=healthcareRoots
	   afoc15g=healthcareAstrology
	   afoc15h=healthcareTea
	   afoc25=healthcareDoctorNumber

	   afoc16=insuranceCoverage
	   afoc17=insuranceCoverageLapseTime
	   afoc18a=insurancePrivate
	   afoc18b=insuranceMedicaid
	   afoc18c=insuranceMedicare
	   afoc18d=insuranceVeteran
	   afoc18e=insuranceOther
	   afoc20=insuranceCoverageLapseYN
	   afoc22=insuranceMeds
	   afoc24a=insuranceMedsNoLimits
	   afoc19b=insuranceMedsCut
	   afoc24e=insuranceMedsNumber
	   afoc24f=insuranceMedsFillLimit
	   afoc24g=insuranceMedsTimeLimit
	   afoc24b=insuranceMedsCostLimit
	   afoc24c=insuranceMedsLimitAmt
	   afoc24d=insuranceMedsNumberLimit
	   afoc24h=insuranceMedsOtherLimits
	   afoc24i=insuranceMedsLimits

	   afoc19a=costIncreasePremiums
	   afoc19c=costIncreaseShare
	   afoc21=costMedsAverage
	   afoc23=costMedsCopay
	   afoc32=costSacrificeHealthcare
	   afoc33a=costSacrificeMeds
	   afoc33b=costSacrificeSpecialist
	   afoc33c=costSacrificeTreatment
	   afoc33d=costSacrificeDoctor
	   afoc33e=costSacrificeOther
	   afoc31=costProblem

	   afoc26=satisfactionListen
	   afoc27=satisfactionExplain
	   afoc28=satisfactionRespect
	   afoc29=satisfactionTime
	   afoc30=satisfactionQuality
	   afoc34=satisfactionConfident

	   afoc35=date;	
	   
drop afoc2a afoc2d afoc2e afoc36 afoc37 afoc38;

run;

data afuc;
length vers $2.;
set afuc afoc;
run;

proc sort data=afuc; by subjid; run;
proc sort data=cohort; by subjid; run;

data afuc;
merge afuc(in=a) cohort(in=b);
by subjid;
if a & b;

* Relabel the final status into incomplete/complete;

if finalStatus in("C" "F") then complete="C";
if finalStatus in("D" "R" "U") then complete="I";

* Create final status variable for events;

if finalStatus in("C" "F" "R") then alive="Y";
if finalStatus in("D" "U") then alive="U";

drop finalStatus;

run;

data afuc;
set afuc;
if type="JHS" & ARIC=1 then delete;
if type="ARI" & ARIC=0 then delete;
run;

data afu.afuc;
set afuc;
drop type aric;
run;
