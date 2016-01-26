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

data afue_aric;
set afu.afue_aric;
type="ARIC";
rename AFUe0a=date;
run;

data afue_jhs;
set afu.afue_jhs;
drop date;
type="JHS";
run;

data afue_jhs;
set afue_jhs;
rename AFUE0A=date;
run;

data afue;

set afue_jhs afue_aric;

rename AFUE70=maritalStatus	
	   AFUE51=inptHosp
	   AFUE57=outptHosp
	   AFUE58=outptHospHeart
	   AFUE52a=hospReason1
	   AFUE53a=hospReason2
	   AFUE54a=hospReason3
	   AFUE55a=hospReason4
	   AFUE56a=hospReason5
	   AFUE60=nursingEver
	   AFUE61=nursingCurrent
	   AFUE69=cigaretteSmoke
	   AFUE17=healthPerception
	   AFUE65d=HFmedsAFU
	   AFUE65a=BPmedsAFU
	   AFUE65c=DMmedsAFU
	   AFUE65b=statinMedsAFU
	   AFUE66=aspirinMedsAFU
	   AFUE65e=asthmaMedsAFU
	   AFUE65f=lungMedsAFU
	   AFUE65h=rhythmMedsAFU
	   AFUE65i=bloodMedsAFU
	   AFUE65j=strokeMedsAFU
	   AFUE65k=TIAmedsAFU
	   AFUE65l=claudMedsAFU
	   AFUE65m=depressMedsAFU
	   AFUE66a=painMedsAFU
	   AFUE65g=anginaMedsAFU
	   AFUE21a=breathingWake
	   AFUE21b=breathingHurrying
	   AFUE21c=breathingWalking
	   AFUE21d=breathingStopPace
	   AFUE21e=breathingStopYards
	   AFUE21f=breathingWalkSlow
	   AFUE22=breathingNotWalking
	   AFUE23=breathingCoughing
	   AFUE48=strokeLastCntct
	   AFUE49=strokeHosp
	   AFUE36=MIlastCntct
	   AFUE37=MIHospLastCntct
	   AFUE40=anginaLastCntct
	   AFUE42=DVTlastCntct
	   AFUE43=DVThosp
	   AFUE45=PElastCntct
	   AFUE46=PEhosp	
	   AFUE62=cardiacSurgeryYN
	   AFUE63a=cardiacSurgeryBypass
	   AFUE63b=cardiacProcOther
	   AFUE63c=cardiacProcCarotid
	   AFUE63d=cardiacProcCarotidSite
	   AFUE63e=cardiacProcRevasc
	   AFUE63f=cardiacSurgeryOther
	   AFUE64=cardiacAngio
	   AFUE64a=cardiacAngioCoronary
	   AFUE64b=cardiacAngioNeck
	   AFUE64c=cardiacAngioLower	
	   AFUE27=swellingFeet
	   AFUE27a=swellingGone
	   AFUE26=PADpain
	   AFUE28=cancerLastCntct
	   AFUE28a=cancerFirstLocation

	   afue1=finalStatus
	   afue71=resultCode;

cancerFirstDate=catx("/", of afue28b1 afue28b2);
	if afue28b1=. then cancerFirstDate=afue28b2;
	if afue28b2=. then cancerFirstDate="";

hospDate1=catx("/", of afue52c1 afue52c2);
	if afue52c1=. then hospDate1=afue52c2;
	if afue52c2=. then hospDate1="";

hospDate1=catx("/", of afue53c1 afue53c2);
	if afue53c1=. then hospDate1=afue53c2;
	if afue53c2=. then hospDate1="";

hospDate2=catx("/", of afue54c1 afue54c2);
	if afue54c1=. then hospDate2=afue54c2;
	if afue54c2=. then hospDate2="";

hospDate3=catx("/", of afue55c1 afue55c2);
	if afue55c1=. then hospDate3=afue55c2;
	if afue55c2=. then hospDate3="";

hospDate4=catx("/", of afue56c1 afue56c2);
	if afue56c1=. then hospDate4=afue56c2;
	if afue56c2=. then hospDate4="";

drop AFUE0B AFUE3 AFUE5a AFUE5b AFUE5c
	 AFUE6 AFUE6a AFUE7 AFUE8a AFUE8a1 AFUE8b1
	 AFUE8b2 AFUE9a AFUE9a1 AFUE9b1 AFUE9b2 AFUE10
	 AFUE11a AFUE11b AFUE11b1 AFUE11c1 AFUE11c2 
	 AFUE12a AFUE12b AFUE12b1 AFUE12c1 AFUE12c2
	 AFUE13a AFUE13b AFUE13b1 AFUE13c1 AFUE13c2
	 AFUE14 AFUE15 AFUE16a1 AFUE16b1 AFUE16b2
	 AFUE29 AFUE28b1 AFUE28b2 AFUE28c1 AFUE28c2
	 AFUE28c3 AFUE28c4 AFUE28c5 AFUE28c61 AFUE28c62
	 AFUE28d AFUE39a AFUE39a1 AFUE39b1 AFUE39b2
	 AFUE44a AFUE38a1 AFUE38b1 AFUE38b2 AFUE47a
	 AFUE47a1 AFUE47b1 AFUE47b2 AFUE50a AFUE50a1
	 AFUE50b1 AFUE50b2 AFUE44a1 AFUE44b1 AFUE44b2
	 AFUE38a AFUE52b AFUE52b1 AFUE52c1 AFUE52c2
	 AFUE53b AFUE53b1 AFUE53c1 AFUE53c2
	 AFUE54b AFUE54b1 AFUE54c1 AFUE54c2
	 AFUE55b AFUE55b1 AFUE55c1 AFUE55c2
	 AFUE56b AFUE56b1 AFUE56c1 AFUE56c2 AFUE28b2
	 AFUE59a AFUE59a1 AFUE59b1 AFUE59b2 AFUE63b1
	 AFUE63e1 AFUE64d AFUE64e AFUE64f1 AFUE64f2
	 AFUE65 pilot AFUEflag AFUE4 AFUE16a AFUE29a cy;

run;

data afue;
set afue;

if anginaMedsAFU="Y" then anginaMedsAFU2=1;
else if anginaMedsAFU="N" then anginaMedsAFU2=2;

if resultCode="A" then resultCode2=3;
else if resultCode="B" then resultCode2=4;
else if resultCode="C" then resultCode2=4;

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

drop finalStatus AFUE2;

drop anginaMedsAFU resultCode finalStatus;

run;

data afue;
set afue;
rename anginaMedsAFU2=anginaMedsAFU
	   resultCode2=resultCode;
run;

proc sort data=afue; by subjid; run;
proc sort data=cohort; by subjid; run;

data afue;
merge afue(in=a) cohort(in=b);
by subjid;
if a & b;
run;

data afue;
set afue;
if type="JHS" & ARIC=1 then delete;
if type="ARI" & ARIC=0 then delete;
run;

* AFOD is still being used -- was imported with AFUD;

data afu.afue;
set afue;
drop aric type;
run;
