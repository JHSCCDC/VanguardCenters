** Program/project: JHS Cohort Data;
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
*Example 2: x 'cd C:\Users\cblackshear\Box Sync\JHSCCDC\1-StudyData\VCworking\VanguardCenters\data';
*Example 3: x 'cd C:\Users\wwang\Box Sync\JHSCCDC\1-StudyData\VCworking\VanguardCenters\data';
x 'cd C:\Users\wwang\Box Sync\JHS01-StudyData\VCworking\VanguardCenters\data';
  *Library names and program directories for Cohort data;
    libname  afu      "AFU\1-data";
    libname  analysis "Analysis Data\1-data";
    libname  cohort   "Cohort\1-data";
    libname  events   "Events\1-data";   
    libname  jhsV1    "Visit 1\1-data";               
    libname  jhsV2    "Visit 2\1-data";              
    libname  jhsV3    "Visit 3\1-data";              
    libname  splmnt   "Cohort\1-data\JHS Cohort Frozen Files";

    filename pgms     "Cohort\2-programs"; 

  *Read in formats from the JHS catalogue;
    option fmtsearch = (afu.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats analysis.formats cohort.formats);

**************************************************************************************************;
** Step 1) Create dataset;
**************************************************************************************************;

options nonotes;
  %include pgms("1-1-data-DeathLTFUCohort.sas");
  %include pgms("1-2-data-Cohort.sas");
options notes;

**************************************************************************************************;
** Step 2) Perform EDA;
**************************************************************************************************;

%include pgms("0-1-formats.sas");
%include pgms("2-1-eda-DeathLTFUCohort.sas");
%include pgms("2-2-eda-Cohort.sas");
