** Program/project: JHS Events Data;
** Original Author: JHS DCC;

/* 
Note 1: Project directories are set up as:
        Project -> 0-info     (Data Dictionary, Codebooks, Refs, General Info)
        Project -> 1-data     (datasets directory)
        Project -> 2-programs (statistical analysis programs directory)
        Project -> 3-results  (output of .rtf file & graphics file sas results)

Note 2: Additional libname statements assigned to read protected JHS dataset directories; 
*/

*Set system options like do not center or put a date on output, etc.;
options nocenter nodate nonumber ps = 150 linesize = 100 nofmterr;

*Assign root directory (VanguardCenters);
**************************************************************************************************;
* YOU MUST CHANGE THIS TO YOUR DIRECTORY STRUCTURE!:
**************************************************************************************************;
*Example 1: x 'cd C:\JHS\VanGuardCenters';
*Example 2: x 'cd C:\Users\cblackshear\Box Sync\JHSCCDC\1-StudyData\VCworking\VanguardCenters';
*Example 3: x 'cd C:\Users\wwang\Box Sync\JHSCCDC\1-StudyData\VCworking\VanguardCenters';
x 'cd C:\Users\wwang\Box Sync\JHS01-StudyData\VCworking\VanguardCenters';

    libname  afu      "data\afu\1-data";
    libname  analysis "data\Analysis Data\1-data";
    libname  cohort   "data\Cohort\1-data";
    libname  events   "data\events\1-data"; 
    libname  dat      "data\Cohort\1-data\JHS Cohort Frozen Files"; 
  	libname  jhsV1    "data\Visit 1\1-data";               
    libname  jhsV2    "data\Visit 2\1-data";              
    libname  jhsV3    "data\Visit 3\1-data";              

  filename pgms   "data\Events\2-programs"; 

  *Adjudicated but unprocessed Events data recieved from UNC;
  *CHD;    libname CHD    "data\Events\1-data\JHS CHD Frozen Files"; 
  *HF;     libname HF     "data\Events\1-data\JHS Heart Failure Frozen Files"; 
  *Stroke; libname Stroke "data\Events\1-data\JHS Stroke Frozen Files"; 

  *Read in format statements;
  options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats);

**************************************************************************************************;
** Step 1) Create datasets;
**************************************************************************************************;

*DeathLTFUEvents; %include pgms("1-0-data-DeathLTFUEvents.sas");     *Create all events dataset;

*Read in LTFU (Lost To Follow Up / Death / date of last censoring) data used in creation of survival datasets;
data LTFU; set events.deathltfuevents; run;
*Generate lostfu data set to remove all adjudicated events observations after the Deceased date;
data lostfu; set ltfu; keep subjid lastdate; if laststatus in ('Confirmed Deceased'); run;
*Generate lostfu1 data set to remove all adjudicated events observations after Refusal date;
data lostfu1; set ltfu; keep subjid lastdate; if laststatus in ('Refused'); run;

/*  proc print data=ltfu(obs=10); run;*/

  *CHD;    %include pgms("1-1-data-allevtCHD.sas");     *Create all events dataset;
  *CHD;    %include pgms("1-1-data-incevtCHD.sas");     *Create incident events dataset;
  *Stroke; %include pgms("1-2-data-allevtSTROKE.sas");  *Create all events dataset;
  *Stroke; %include pgms("1-2-data-incevtSTROKE.sas");  *Create incident events dataset;
  *HF;     %include pgms("1-3-data-allevtHF.sas");      *Create all events dataset;
  *HF;     %include pgms("1-3-data-incevtHFder.sas");      *Create incident events dataset;

**************************************************************************************************;
** Step 2) Validation (EDA on events variables);
**************************************************************************************************;

  ods results off;

  *Mortality until 12/31/2012;
  ods rtf file = "data\Events\3-results\2-0-eda-ltfu Dec 31 2012.rtf";
    %include pgms("2-0-eda-deathltfuevents.sas"); 
  ods rtf close;

  *CHD;
  ods rtf file = "data\Events\3-results\2-1-eda-chd.rtf";
    %include pgms("2-1-eda-allevtCHD.sas"); 
    %include pgms("2-1-eda-incevtCHD.sas"); 
  ods rtf close;

  *Stroke;
  ods rtf file = "data\Events\3-results\2-2-eda-stroke.rtf";
    %include pgms("2-2-eda-allevtSTROKE.sas"); 
    %include pgms("2-2-eda-incevtSTROKE.sas"); 
  ods rtf close;

  *HF;
  ods rtf file = "data\Events\3-results\2-3-eda-HF.rtf";
    %include pgms("2-3-eda-allevtHF.sas"); 
    %include pgms("2-3-eda-incevtHFder.sas"); 
  ods rtf close;

  ods results on;
