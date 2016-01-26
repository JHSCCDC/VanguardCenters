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

data afub_aric;
set afu.afub_aric;
run;

data afub_aric;
set afub_aric;
rename afub8a=afub8;
format _all_;
type="ARIC";
run;

data afub_jhs;
set afu.afub_jhs;
format _all_;
type="JHS";
run;

data afub;
length AFUB7J AFUB7M $20.;
set afub_jhs afub_aric;

rename afub1=date
	   afub31=maritalStatus
	   afub10=inptHosp
	   afub11a=nursingEver
	   afub11b=nursingCurrent
	   afub30=cigaretteSmoke
	   afub6=healthPerception
	   afub23=fxHeavy
	   afub24=fxStairs
	   afub25=fxWalk
	   afub26a=fxWork
	   afub26b=fxWorkHeart
	   afub27a=fxWorkMiss
	   afub27b=fxWorkMissDays
	   afub28a=fxActivities
	   afub28b=fxActivitiesHeart
	   afub29a=fxActivitiesCut
	   afub29b=fxActivitiesCutDays
	   afub16a=BPmedsAFU
	   afub16c=DMmedsAFU
	   afub16b=statinMedsAFU
	   afub17=aspirinMedsAFU
	   afub7g=chronicLungEver
	   afub7h=asthmaEver
	   afub8=strokeLastCntct
	   afub8b=strokeHosp
	   afub7a=MIever
	   afub9=MIHospLastCntct
	   afub7c=HTNever
	   afub7d=DMever

	   afub7e=DVTever
	   afub32a=employmentStatus
	   afub32b=employedStatus
	   afub32c=unemployedStatus
	   afub32d=retiredStatus
	   afub7f=PEever
	   afub13a=cardiacSurgeryBypass
	   afub13b=cardiacProcOther
	   afub13c=cardiacProcCarotid
	   afub13d=cardiacProcCarotidSite
	   afub13e=cardiacProcRevasc
	   afub13f=cardiacSurgeryOther
	   afub15a=cardiacAngioCoronary
	   afub15b=cardiacAngioNeck
	   afub15c=cardiacAngioLower
	   afub7b=HFever
	   afub7i=cancerEver
	   afub7j=cancerFirstLocation
	   afub7k=cancerFirstDate
	   afub7l=cancerSecond
	   afub7m=cancerSecondLocation
	   afub7n=cancerSecondDate
	   afub2=finalStatus
	   afub36=resultCode
	   afub3a=cOptions
	   afub3b=rOptions
	   afub3c=dOptions
	   afub37a=hospReason1
	   afub37b=hospReason2
	   afub37c=hospReason3
	   afub37d=hospReason4
	   afub37e=hospReason5
	   afub37f=hospReason6
	   afub39a=hospDate1
	   afub39b=hospDate2
	   afub39c=hospDate3
	   afub39d=hospDate4
	   afub39e=hospDate5
	   afub39f=hospDate6;

if afub12="Y" then cardiacSurgeryYN=afub12a;
if afub12="N" then cardiacSurgeryYN=afub12b;

if afub14="Y" then cardiacAngio=afub14a;
if afub14="N" then cardiacAngio=afub14b;

drop afub38A afub38B afub38C afub38D afub38E afub38F afub5A afub5B afub4 
	 afub40A afub40B afub40C afub40D afub40E afub40F afub12 afub12a 
	 afub12b afub14 afub14a afub14b afub18 afub19a afub19b afub19c afub19d
	 afub20 afub21 afub21a afub21b afub22 afub33 afub34 afub35 afub41 afub3 
	 pilot afub19;

run;

data afob;

length vers $2.;

set afo.afob;

vers="OB";

if ^missing(AFOB30) & ^missing(AFOB31) & ^missing(AFOB32) then finalStatus="C";

rename af0b1a=anginaMedsAFU
	   afob1b=heartMedsAFU
	   afob1c=heartMedsNameAFU

	   afob2b=HFcough
	   afob2c=HFpillows
	   afob2e=swellingFeet

	   afob3a=cardiacEcho
	   afob3b=cardiacECG
	   afob3c=cardiacStress
	   afob3d=cardiacCTMRI

	   afob4a=healthcareDentist
	   afob4b=healthcareDoctor
	   afob4c=healthcareChiro
	   afob4d=healthcareAcupunct
	   afob4e=healthcareFaith
	   afob4f=healthcareRoots
	   afob4g=healthcareAstrology
	   afob4h=healthcareTea
	   afob20=healthcareDoctorNumber

	   afob11=insuranceCoverage
	   afob12=insuranceCoverageLapseTime
	   afob13a=insurancePrivate
	   afob13b=insuranceMedicaid
	   afob13c=insuranceMedicare
	   afob13d=insuranceVeteran
	   afob13e=insuranceOther
	   afob15=insuranceCoverageLapseYN
	   afob17=insuranceMeds
	   afob19a=insuranceMedsNoLimits
	   afob14b=insuranceMedsCut
	   afob19e=insuranceMedsNumber
	   afob19f=insuranceMedsFillLimit
	   afob19g=insuranceMedsTimeLimit
	   afob19b=insuranceMedsCostLimit
	   afob19c=insuranceMedsLimitAmt
	   afob19d=insuranceMedsNumberLimit
	   afob19h=insuranceMedsOtherLimits
	   afob19i=insuranceMedsLimits

	   afob14a=costIncreasePremiums
	   afob14c=costIncreaseShare
	   afob16=costMedsAverage
	   afob18=costMedsCopay
	   afob27=costSacrificeHealthcare
	   afob28a=costSacrificeMeds
	   afob28b=costSacrificeSpecialist
	   afob28c=costSacrificeTreatment
	   afob28d=costSacrificeDoctor
	   afob28e=costSacrificeOther
	   afob26=costProblem

	   afob21=satisfactionListen
	   afob22=satisfactionExplain
	   afob23=satisfactionRespect
	   afob24=satisfactionTime
	   afob25=satisfactionQuality
	   afob29=satisfactionConfident

	   afob5=stressPastYear
	   afob6=depressedPastYear
	   afob7=nervousPastYear
	   afob8=discriminationPastYear
	   afob9=stressCopePastYear
	   afob10=supportPastYear

	   afob30=date

	   afob2a=breathingNotWalking
	   afob2d=breathingWake
	   afob2f=HFdoctor;

drop afob31 afob32;

run;

data afub;
length vers $2.;
set afub afob;

if anginaMedsAFU="Y" then anginaMedsAFU2=1;
else if anginaMedsAFU="N" then anginaMedsAFU2=2;
else if anginaMedsAFU="K" then anginaMedsAFU2=7;
else if anginaMedsAFU="R" then anginaMedsAFU2=8;

if heartMedsAFU="Y" then heartMedsAFU2=1;
else if heartMedsAFU="N" then heartMedsAFU2=2;
else if heartMedsAFU="K" then heartMedsAFU2=7;
else if heartMedsAFU="R" then heartMedsAFU2=8;

if cardiacEcho="Y" then cardiacEcho2=1;
else if cardiacEcho="N" then cardiacEcho2=2;
else if cardiacEcho="K" then cardiacEcho2=7;
else if cardiacEcho="R" then cardiacEcho2=8;

if cardiacECG="Y" then cardiacECG2=1;
else if cardiacECG="N" then cardiacECG2=2;
else if cardiacECG="K" then cardiacECG2=7;
else if cardiacECG="R" then cardiacECG2=8;

if cardiacStress="Y" then cardiacStress2=1;
else if cardiacStress="N" then cardiacStress2=2;
else if cardiacStress="K" then cardiacStress2=7;
else if cardiacStress="R" then cardiacStress2=8;

if cardiacCTMRI="Y" then cardiacCTMRI2=1;
else if cardiacCTMRI="N" then cardiacCTMRI2=2;
else if cardiacCTMRI="K" then cardiacCTMRI2=7;
else if cardiacCTMRI="R" then cardiacCTMRI2=8;

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

if HFcough="Y" then HFcough2=1;
else if HFcough="N" then HFcough2=2;
else if HFcough="K" then HFcough2=7;
else if HFcough="R" then HFcough2=8;

if HFpillows="Y" then HFpillows2=1;
else if HFpillows="N" then HFpillows2=2;
else if HFpillows="K" then HFpillows2=7;
else if HFpillows="R" then HFpillows2=8;

if HFdoctor="Y" then HFdoctor2=1;
else if HFdoctor="N" then HFdoctor2=2;
else if HFdoctor="K" then HFdoctor2=7;
else if HFdoctor="R" then HFdoctor2=8;

if healthcareDentist="Y" then healthcareDentist2=1;
else if healthcareDentist="N" then healthcareDentist2=2;
else if healthcareDentist="K" then healthcareDentist2=7;
else if healthcareDentist="R" then healthcareDentist2=8;

if healthcareDoctor="Y" then healthcareDoctor2=1;
else if healthcareDoctor="N" then healthcareDoctor2=2;
else if healthcareDoctor="K" then healthcareDoctor2=7;
else if healthcareDoctor="R" then healthcareDoctor2=8;

if healthcareChiro="Y" then healthcareChiro2=1;
else if healthcareChiro="N" then healthcareChiro2=2;
else if healthcareChiro="K" then healthcareChiro2=7;
else if healthcareChiro="R" then healthcareChiro2=8;

if healthcareAcupunct="Y" then healthcareAcupunct2=1;
else if healthcareAcupunct="N" then healthcareAcupunct2=2;
else if healthcareAcupunct="K" then healthcareAcupunct2=7;
else if healthcareAcupunct="R" then healthcareAcupunct2=8;

if healthcareFaith="Y" then healthcareFaith2=1;
else if healthcareFaith="N" then healthcareFaith2=2;
else if healthcareFaith="K" then healthcareFaith2=7;
else if healthcareFaith="R" then healthcareFaith2=8;

if healthcareRoots="Y" then healthcareRoots2=1;
else if healthcareRoots="N" then healthcareRoots2=2;
else if healthcareRoots="K" then healthcareRoots2=7;
else if healthcareRoots="R" then healthcareRoots2=8;

if healthcareAstrology="Y" then healthcareAstrology2=1;
else if healthcareAstrology="N" then healthcareAstrology2=2;
else if healthcareAstrology="K" then healthcareAstrology2=7;
else if healthcareAstrology="R" then healthcareAstrology2=8;

if healthcareTea="Y" then healthcareTea2=1;
else if healthcareTea="N" then healthcareTea2=2;
else if healthcareTea="K" then healthcareTea2=7;
else if healthcareTea="R" then healthcareTea2=8;

if healthcareDoctorNumber="A" then healthcareDoctorNumber2=1;
else if healthcareDoctorNumber="B" then healthcareDoctorNumber2=2;
else if healthcareDoctorNumber="C" then healthcareDoctorNumber2=3;
else if healthcareDoctorNumber="D" then healthcareDoctorNumber2=4;
else if healthcareDoctorNumber="E" then healthcareDoctorNumber2=5;
else if healthcareDoctorNumber="F" then healthcareDoctorNumber2=3;
else if healthcareDoctorNumber="G" then healthcareDoctorNumber2=7;
else if healthcareDoctorNumber="K" then healthcareDoctorNumber2=77;
else if healthcareDoctorNumber="R" then healthcareDoctorNumber2=88;

if insuranceCoverage="Y" then insuranceCoverage2=1;
else if insuranceCoverage="N" then insuranceCoverage2=2;
else if insuranceCoverage="K" then insuranceCoverage2=7;
else if insuranceCoverage="R" then insuranceCoverage2=8;

if insuranceCoverageLapseTime="A" then insuranceCoverageLapseTime2=1;
else if insuranceCoverageLapseTime="B" then insuranceCoverageLapseTime2=2;
else if insuranceCoverageLapseTime="C" then insuranceCoverageLapseTime2=3;
else if insuranceCoverageLapseTime="K" then insuranceCoverageLapseTime2=7;
else if insuranceCoverageLapseTime="R" then insuranceCoverageLapseTime2=8;

if insurancePrivate="Y" then insurancePrivate2=1;
else if insurancePrivate="N" then insurancePrivate2=2;
else if insurancePrivate="K" then insurancePrivate2=7;
else if insurancePrivate="R" then insurancePrivate2=8;

if insuranceMedicaid="Y" then insuranceMedicaid2=1;
else if insuranceMedicaid="N" then insuranceMedicaid2=2;
else if insuranceMedicaid="K" then insuranceMedicaid2=7;
else if insuranceMedicaid="R" then insuranceMedicaid2=8;

if insuranceMedicare="Y" then insuranceMedicare2=1;
else if insuranceMedicare="N" then insuranceMedicare2=2;
else if insuranceMedicare="K" then insuranceMedicare2=7;
else if insuranceMedicare="R" then insuranceMedicare2=8;

if insuranceVeteran="Y" then insuranceVeteran2=1;
else if insuranceVeteran="N" then insuranceVeteran2=2;
else if insuranceVeteran="K" then insuranceVeteran2=7;
else if insuranceVeteran="R" then insuranceVeteran2=8;

if insuranceOther="Y" then insuranceOther2=1;
else if insuranceOther="N" then insuranceOther2=2;
else if insuranceOther="K" then insuranceOther2=7;
else if insuranceOther="R" then insuranceOther2=8;

if insuranceCoverageLapseYN="Y" then insuranceCoverageLapseYN2=1;
else if insuranceCoverageLapseYN="N" then insuranceCoverageLapseYN2=2;
else if insuranceCoverageLapseYN="K" then insuranceCoverageLapseYN2=7;
else if insuranceCoverageLapseYN="R" then insuranceCoverageLapseYN2=8;

if insuranceMeds="Y" then insuranceMeds2=1;
else if insuranceMeds="N" then insuranceMeds2=2;

if insuranceMedsNoLimits="Y" then insuranceMedsNoLimits2=1;
else if insuranceMedsNoLimits="N" then insuranceMedsNoLimits2=2;
else if insuranceMedsNoLimits="K" then insuranceMedsNoLimits2=7;
else if insuranceMedsNoLimits="R" then insuranceMedsNoLimits2=8;

if insuranceMedsCut="Y" then insuranceMedsCut2=1;
else if insuranceMedsCut="N" then insuranceMedsCut2=2;
else if insuranceMedsCut="K" then insuranceMedsCut2=7;
else if insuranceMedsCut="R" then insuranceMedsCut2=8;

if insuranceMedsFillLimit="Y" then insuranceMedsFillLimit2=1;
else if insuranceMedsFillLimit="N" then insuranceMedsFillLimit2=2;
else if insuranceMedsFillLimit="K" then insuranceMedsFillLimit2=7;
else if insuranceMedsFillLimit="R" then insuranceMedsFillLimit2=8;

if insuranceMedsCostLimit="Y" then insuranceMedsCostLimit2=1;
else if insuranceMedsCostLimit="N" then insuranceMedsCostLimit2=2;
else if insuranceMedsCostLimit="K" then insuranceMedsCostLimit2=7;
else if insuranceMedsCostLimit="R" then insuranceMedsCostLimit2=8;

if insuranceMedsNumberLimit="Y" then insuranceMedsNumberLimit2=1;
else if insuranceMedsNumberLimit="N" then insuranceMedsNumberLimit2=2;
else if insuranceMedsNumberLimit="K" then insuranceMedsNumberLimit2=7;
else if insuranceMedsNumberLimit="R" then insuranceMedsNumberLimit2=8;

if insuranceMedsOtherLimits="Y" then insuranceMedsOtherLimits2=1;
else if insuranceMedsOtherLimits="N" then insuranceMedsOtherLimits2=2;
else if insuranceMedsOtherLimits="K" then insuranceMedsOtherLimits2=7;
else if insuranceMedsOtherLimits="R" then insuranceMedsOtherLimits2=8;

if costIncreasePremiums="Y" then costIncreasePremiums2=1;
else if costIncreasePremiums="N" then costIncreasePremiums2=2;
else if costIncreasePremiums="K" then costIncreasePremiums2=7;
else if costIncreasePremiums="R" then costIncreasePremiums2=8;

if costIncreaseShare="Y" then costIncreaseShare2=1;
else if costIncreaseShare="N" then costIncreaseShare2=2;
else if costIncreaseShare="K" then costIncreaseShare2=7;
else if costIncreaseShare="R" then costIncreaseShare2=8;

if costMedsCopay="Y" then costMedsCopay2=1;
else if costMedsCopay="N" then costMedsCopay2=2;
else if costMedsCopay="K" then costMedsCopay2=7;
else if costMedsCopay="R" then costMedsCopay2=8;

if costSacrificeHealthcare="Y" then costSacrificeHealthcare2=1;
else if costSacrificeHealthcare="N" then costSacrificeHealthcare2=2;
else if costSacrificeHealthcare="K" then costSacrificeHealthcare2=7;
else if costSacrificeHealthcare="R" then costSacrificeHealthcare2=8;

if costSacrificeMeds="Y" then costSacrificeMeds2=1;
else if costSacrificeMeds="N" then costSacrificeMeds2=2;
else if costSacrificeMeds="K" then costSacrificeMeds2=7;
else if costSacrificeMeds="R" then costSacrificeMeds2=8;

if costSacrificeSpecialist="Y" then costSacrificeSpecialist2=1;
else if costSacrificeSpecialist="N" then costSacrificeSpecialist2=2;
else if costSacrificeSpecialist="K" then costSacrificeSpecialist2=7;
else if costSacrificeSpecialist="R" then costSacrificeSpecialist2=8;

if costSacrificeTreatment="Y" then costSacrificeTreatment2=1;
else if costSacrificeTreatment="N" then costSacrificeTreatment2=2;
else if costSacrificeTreatment="K" then costSacrificeTreatment2=7;
else if costSacrificeTreatment="R" then costSacrificeTreatment2=8;

if costSacrificeDoctor="Y" then costSacrificeDoctor2=1;
else if costSacrificeDoctor="N" then costSacrificeDoctor2=2;
else if costSacrificeDoctor="K" then costSacrificeDoctor2=7;
else if costSacrificeDoctor="R" then costSacrificeDoctor2=8;

if costMedsAverage="A" then costMedsAverage2=1;
else if costMedsAverage="B" then costMedsAverage2=2;
else if costMedsAverage="C" then costMedsAverage2=3;
else if costMedsAverage="D" then costMedsAverage2=4;
else if costMedsAverage="E" then costMedsAverage2=5;
else if costMedsAverage="F" then costMedsAverage2=6;
else if costMedsAverage="K" then costMedsAverage2=7;
else if costMedsAverage="R" then costMedsAverage2=8;

if costProblem="A" then costProblem2=1;
else if costProblem="B" then costProblem2=2;
else if costProblem="C" then costProblem2=3;
else if costProblem="K" then costProblem2=7;
else if costProblem="R" then costProblem2=8;

if satisfactionListen="N" then satisfactionListen2=1;
else if satisfactionListen="S" then satisfactionListen2=2;
else if satisfactionListen="U" then satisfactionListen2=3;
else if satisfactionListen="A" then satisfactionListen2=4;
else if satisfactionListen="K" then satisfactionListen2=7;
else if satisfactionListen="R" then satisfactionListen2=8;

if satisfactionExplain="N" then satisfactionExplain2=1;
else if satisfactionExplain="S" then satisfactionExplain2=2;
else if satisfactionExplain="U" then satisfactionExplain2=3;
else if satisfactionExplain="A" then satisfactionExplain2=4;
else if satisfactionExplain="K" then satisfactionExplain2=7;
else if satisfactionExplain="R" then satisfactionExplain2=8;

if satisfactionRespect="N" then satisfactionRespect2=1;
else if satisfactionRespect="S" then satisfactionRespect2=2;
else if satisfactionRespect="U" then satisfactionRespect2=3;
else if satisfactionRespect="A" then satisfactionRespect2=4;
else if satisfactionRespect="K" then satisfactionRespect2=7;
else if satisfactionRespect="R" then satisfactionRespect2=8;

if satisfactionTime="N" then satisfactionTime2=1;
else if satisfactionTime="S" then satisfactionTime2=2;
else if satisfactionTime="U" then satisfactionTime2=3;
else if satisfactionTime="A" then satisfactionTime2=4;
else if satisfactionTime="K" then satisfactionTime2=7;
else if satisfactionTime="R" then satisfactionTime2=8;

if satisfactionQuality="N" then satisfactionQuality2=1;
else if satisfactionQuality="S" then satisfactionQuality2=2;
else if satisfactionQuality="U" then satisfactionQuality2=3;
else if satisfactionQuality="A" then satisfactionQuality2=4;
else if satisfactionQuality="K" then satisfactionQuality2=7;
else if satisfactionQuality="R" then satisfactionQuality2=8;

if satisfactionConfident="A" then satisfactionConfident2=1;
else if satisfactionConfident="B" then satisfactionConfident2=2;
else if satisfactionConfident="C" then satisfactionConfident2=3;
else if satisfactionConfident="D" then satisfactionConfident2=4;
else if satisfactionConfident="K" then satisfactionConfident2=7;
else if satisfactionConfident="R" then satisfactionConfident2=8;

if stressPastYear="A" then stressPastYear2=1;
else if stressPastYear="B" then stressPastYear2=2;
else if stressPastYear="C" then stressPastYear2=3;
else if stressPastYear="D" then stressPastYear2=4;
else if stressPastYear="E" then stressPastYear2=5;
else if stressPastYear="F" then stressPastYear2=6;
else if stressPastYear="K" then stressPastYear2=7;
else if stressPastYear="R" then stressPastYear2=8;

if depressedPastYear="A" then depressedPastYear2=1;
else if depressedPastYear="B" then depressedPastYear2=2;
else if depressedPastYear="C" then depressedPastYear2=3;
else if depressedPastYear="D" then depressedPastYear2=4;
else if depressedPastYear="E" then depressedPastYear2=5;
else if depressedPastYear="F" then depressedPastYear2=6;
else if depressedPastYear="K" then depressedPastYear2=7;
else if depressedPastYear="R" then depressedPastYear2=8;

if nervousPastYear="A" then nervousPastYear2=1;
else if nervousPastYear="B" then nervousPastYear2=2;
else if nervousPastYear="C" then nervousPastYear2=3;
else if nervousPastYear="D" then nervousPastYear2=4;
else if nervousPastYear="E" then nervousPastYear2=5;
else if nervousPastYear="F" then nervousPastYear2=6;
else if nervousPastYear="K" then nervousPastYear2=7;
else if nervousPastYear="R" then nervousPastYear2=8;

if discriminationPastYear="A" then discriminationPastYear2=1;
else if discriminationPastYear="B" then discriminationPastYear2=2;
else if discriminationPastYear="C" then discriminationPastYear2=3;
else if discriminationPastYear="D" then discriminationPastYear2=4;
else if discriminationPastYear="E" then discriminationPastYear2=5;
else if discriminationPastYear="F" then discriminationPastYear2=6;
else if discriminationPastYear="K" then discriminationPastYear2=7;
else if discriminationPastYear="R" then discriminationPastYear2=8;

if stressCopePastYear="A" then stressCopePastYear2=1;
else if stressCopePastYear="B" then stressCopePastYear2=2;
else if stressCopePastYear="C" then stressCopePastYear2=3;
else if stressCopePastYear="D" then stressCopePastYear2=4;
else if stressCopePastYear="E" then stressCopePastYear2=5;
else if stressCopePastYear="F" then stressCopePastYear2=6;
else if stressCopePastYear="K" then stressCopePastYear2=7;
else if stressCopePastYear="R" then stressCopePastYear2=8;

if supportPastYear="A" then supportPastYear2=1;
else if supportPastYear="B" then supportPastYear2=2;
else if supportPastYear="C" then supportPastYear2=3;
else if supportPastYear="D" then supportPastYear2=4;
else if supportPastYear="E" then supportPastYear2=5;
else if supportPastYear="F" then supportPastYear2=6;
else if supportPastYear="K" then supportPastYear2=7;
else if supportPastYear="R" then supportPastYear2=8;

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


drop anginaMedsAFU heartMedsAFU cardiacEcho cardiacECG cardiacStress
	 cardiacCTMRI HFcough HFpillows HFdoctor healthcareDentist
	 healthcareDoctor healthcareChiro healthcareAcupunct
	 healthcareFaith healthcareRoots healthcareAstrology healthcareTea
	 healthcareDoctorNumber insuranceCoverage insuranceCoverageLapseTime
	 insurancePrivate insuranceMedicaid insuranceMedicare insuranceVeteran
     insuranceOther insuranceCoverageLapseYN insuranceMeds insuranceMedsNoLimits
	 insuranceMedsCut insuranceMedsFillLimit insuranceMedsCostLimit 
	 insuranceMedsNumberLimit insuranceMedsOtherLimits costIncreasePremiums
	 costIncreaseShare costMedsCopay costSacrificeHealthcare costSacrificeMeds
	 employmentStatus employedStatus unemployedStatus retiredStatus
	 costSacrificeSpecialist costSacrificeTreatment costSacrificeDoctor
	 costMedsAverage costProblem satisfactionListen satisfactionExplain
	 satisfactionRespect satisfactionTime satisfactionQuality satisfactionConfident
	 stressPastYear depressedPastYear nervousPastYear discriminationPastYear
	 stressCopePastYear supportPastYear fxHeavy fxStairs fxWork fxWorkHeart fxWorkMiss fxActivities
	 fxActivitiesHeart fxActivitiesCut fxWalk;

run;

%sort2(d=afub);

data afub;
set afub;
rename anginaMedsAFU2=anginaMedsAFU 
	   heartMedsAFU2=heartMedsAFU 
	   cardiacEcho2=cardiacEcho 
	   cardiacECG2=cardiacECG 
	   employmentstatus2=employmentStatus
	   employedStatus2=employedStatus
	   unemployedStatus2=unemployedStatus
	   retiredStatus2=retiredStatus
	   cardiacStress2=cardiacStress
	   cardiacCTMRI2=cardiacCTMRI 
	   HFcough2=HFcough 
	   HFpillows2=HFpillows 
	   HFdoctor2=HFdoctor 
	   healthcareDentist2=healthcareDentist
	   healthcareDoctor2=healthcareDoctor 
	   healthcareChiro2=healthcareChiro 
	   healthcareAcupunct2=healthcareAcupunct
	   healthcareFaith2=healthcareFaith 
	   healthcareRoots2=healthcareRoots 
	   healthcareAstrology2=healthcareAstrology 
	   healthcareTea2=healthcareTea
	   healthcareDoctorNumber2=healthcareDoctorNumber 
	   insuranceCoverage2=insuranceCoverage 
	   insuranceCoverageLapseTime2=insuranceCoverageLapseTime
	   insurancePrivate2=insurancePrivate 
	   insuranceMedicaid2=insuranceMedicaid 
	   insuranceMedicare2=insuranceMedicare 
	   fxHeavy2=fxHeavy 
	   fxStairs2=fxStairs 
	   fxWork2=fxWork
	   fxWalk2=fxWalk
	   fxWorkHeart2=fxWorkHeart 
	   fxWorkMiss2=fxWorkMiss 
	   fxActivities2=fxActivities
	   fxActivitiesHeart2=fxActivitiesHeart 
	   fxActivitiesCut2=fxActivitiesCut 
	   insuranceVeteran2=insuranceVeteran
	   insuranceOther2=insuranceOther 
	   insuranceCoverageLapseYN2=insuranceCoverageLapseYN 
	   insuranceMeds2=insuranceMeds 
	   insuranceMedsNoLimits2=insuranceMedsNoLimits
	   insuranceMedsCut2=insuranceMedsCut 
	   insuranceMedsFillLimit2=insuranceMedsFillLimit 
	   insuranceMedsCostLimit2=insuranceMedsCostLimit 
	   insuranceMedsNumberLimit2=insuranceMedsNumberLimit 
	   insuranceMedsOtherLimits2=insuranceMedsOtherLimits 
	   costIncreasePremiums2=costIncreasePremiums
	   costIncreaseShare2=costIncreaseShare 
	   costMedsCopay2=costMedsCopay 
	   costSacrificeHealthcare2=costSacrificeHealthcare 
	   costSacrificeMeds2=costSacrificeMeds
	   costSacrificeSpecialist2=costSacrificeSpecialist 
  	   costSacrificeTreatment2=costSacrificeTreatment 
	   costSacrificeDoctor2=costSacrificeDoctor
	   costMedsAverage2=costMedsAverage 
	   costProblem2=costProblem 
	   satisfactionListen2=satisfactionListen 
	   satisfactionExplain2=satisfactionExplain
	   satisfactionRespect2=satisfactionRespect 
	   satisfactionTime2=satisfactionTime 
	   satisfactionQuality2=satisfactionQuality 
	   satisfactionConfident2=satisfactionConfident
	   stressPastYear2=stressPastYear 
	   depressedPastYear2=depressedPastYear 
	   nervousPastYear2=nervousPastYear 
	   discriminationPastYear2=discriminationPastYear
	   stressCopePastYear2=stressCopePastYear 
	   supportPastYear2=supportPastYear;
run;	 

proc sort data=afub; by subjid; run;
proc sort data=cohort; by subjid; run;

data afub;
merge afub(in=a) cohort(in=b);
by subjid;
if a & b;

* Relabel the final status into incomplete/complete;

if finalStatus in("C", "F") then complete="C";
if finalStatus in("D", "R", "U") then complete="I";

* Create final status variable for events;

if finalStatus in("C" "F" "R") then alive="Y";
if finalStatus in("D" "U") then alive="U";

drop finalStatus;

run;

data afub;
set afub;
if type="JHS" & ARIC=1 then delete;
if type="ARI" & ARIC=0 then delete;
run;

data afu.afub;
set afub;
drop aric type;
run;
