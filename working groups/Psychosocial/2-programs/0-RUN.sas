*Assign root directory (VanguardCenters);
 *VO;  x 'cd Z:\Jackson Heart Study\VC Packages\VanguardCenters';

 *Required VC data libraries;
  libname analysis "data\Analysis Data\1-data";               *Analysis-Ready Datasets; 
  libname psychsoc "C:\Users\vokhomina\Box Sync\Working Groups\CIAHD\Derived\1-data" ; *Derived variables for E-P WG;
  libname jhsV1    "data\Visit 1\1-data";                     *"Raw" Exam 1 data; 
  libname jhsV2    "data\Visit 2\1-data";                     *"Raw" Exam 2 data; 
  libname jhsV3    "data\Visit 3\1-data";                     *"Raw" Exam 3 data; 
  libname afu	   "data\AFU\1-data";						  *"Annual followup data; 
* libname psychsoc "working groups\PsychoSocial\2-programs" ; *Derived variables for Enviro/Psycho WG;


  *Set programs directory(s);
  filename pgmsV1 "data\Visit 1\2-programs"; 
  filename pgmsV2 "data\Visit 2\2-programs"; 
  filename pgmsV3 "data\Visit 3\2-programs"; 
  filename ADpgms "data\Analysis Data\2-programs"; 
  filename PSpgm  "C:\Users\vokhomina\Box Sync\Working Groups\CIAHD\Derived\2-programs" ;	*Pyschosocial programs;
* filename PSpgm  "working groups\PsychoSocial\2-programs" ;	*Pyschosocial programs;

  *Read in format statements;
  options nonotes;
    %include ADpgms("0-1-formats.sas"); *Read in Analysis Datasets format statements;
    %include pgmsV1("0-1-formats.sas"); *Read in formats from the JHS visit 1 catalogue;
	%include pgmsV2("0-1-formats.sas"); *Read in formats from the JHS visit 2 catalogue;
    %include pgmsV3("0-1-formats.sas"); *Read in formats from the JHS visit 3 catalogue;
	%include PSpgm ("formats.sas")    ; *Read in formats for psychosocal variables ;
   options notes;

 options fmtsearch = ( psychsoc.formats analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats );
**************************************************************************************************;
***************************        Visit 1 Measures       ****************************************;
**************************************************************************************************;

*	Section 1: Discrimination   ******************************************************************;
%include PSpgm("1-1 DIS derived.sas");

data psychsoc.derivedDIS01 (label="Derived Discrimination Variables-Visit 1") ;
	retain 	subjid dis01eo
		   	dis01ed dis01ea dis01ec2
			dis01lo dis01lt dis01la 
			dis01lc2a dis01lc2b dis01bd 
		;
		merge discrm1 discrm2;
		by subjid;
	run;


*	Section 2: Stress   ********************************************************************;
%include PSpgm("1-2 STR derived.sas");


data psychsoc.derivedSTS01 (label="Derived Stress Variables-Visit 1") ;

retain subjid sts01tg sts01ag 
	   STS01WSE STS01WSI  sts01mle 
	;

merge wsi(in=a) gpss(in=b) mle(in=c);
by subjid ;

run;
 
*	Section 3: Moods         *************************************************************;
%include PSpgm("1-3 MOD derived.sas"); 

data psychsoc.derivedMOOD01 (label="Derived Mood Measures-Visit 1") ;

	retain subjid DPS01 ang01in ang01out;

	merge work.cesd
		  work.anger 
		  work.hostility ;
	by subjid ; 

	keep subjid DPS01 ang01in ang01out hst01cyn hst01aft hst01resp ;

run;
********************   Combine all sections for visit 1 derived dataset  *************************;
data psychsoc.psychosoc01 (label="Derived PsychoSocal Variables-Visit 1");
	merge 	analysis.analysis1(in=a keep=subjid)
			psychsoc.derivedDIS01 
			psychsoc.derivedSTS01
			psychsoc.derivedMOOD01 ;
	if a=1 ;
run;

 /* proc freq data=psychsoc.psychosoc01 ; run; */

proc datasets lib=work kill nolist; quit;


**************************************************************************************************;
***************************        Visit 3 Measures       ****************************************;
**************************************************************************************************;

*	Section 1: Discrimination   ******************************************************************;
%include PSpgm("3-1 DIS derived.sas");

data psychsoc.derivedDIS03 (label="Derived Discrimination Variables-Visit 3") ;
	retain 	subjid dis03eo
		   	dis03ed dis03ea ;
		
		set work.discrm1 ;
		by subjid;
	run;


*	Section 3: Moods         *************************************************************;
%include PSpgm("3-3 MOD derived.sas"); 

data psychsoc.derivedMOOD03 (label="Derived Mood Measures-Visit 3") ;

	retain subjid ang03in ang03out;

	set	work.anger  ;
	by subjid ;

 	keep subjid ang03in ang03out  ;

run;

********************   Combine all sections for visit 3 derived dataset  *************************;
data psychsoc.psychosoc03 (label="Derived PsychoSocal Variables-Visit 3");
	merge 	analysis.analysis3(in=a keep=subjid)
			psychsoc.derivedDIS03
			psychsoc.derivedMOOD03 ;
	if a=1 ;
run;

/* proc freq data=psychsoc.psychosoc03 ; run; */





**************************************************************************************************;
********************   Combine all visits for overall derived dataset  *************************;
**************************************************************************************************;
data psychsoc.PSYCHOSOCderived (label="Derived PsychoSocal Variables-All visits");
	merge 	analysis.analysis1(in=a keep=subjid)
			psychsoc.psychosoc01
			psychsoc.psychosoc03;
	if a=1 ;
run;

 /*  proc freq data=psychsoc.PSYCHOSOCderived ; run; */

