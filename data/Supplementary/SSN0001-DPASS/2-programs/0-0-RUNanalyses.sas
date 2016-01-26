** Program/project: JHS Diet and Physical Activity Sub-Study;
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
*Example 2; x 'cd C:\Users\cblackshear\Box Sync\JHS\CC\JHS01-StudyData\VCworking\VanguardCenters';

*Primary project data & program directory;
libname  analysis "data\Analysis Data\1-data";
libname  dat      "data\Supplementary\SSN0001-DPASS\1-data";
filename pgms     "data\Supplementary\SSN0001-DPASS\2-programs"; 

options nonotes;

  *Read in format statements;
  %include pgms("0-1-formats.sas"); *Read in formats;

  *Perform exploratory data analysis;
  ods graphics on /antialiasmax = 5200;
  *ods html style = harvest; *harvest, education, BarrettsBlue, Journal;

  x 'cd data\Supplementary\SSN0001-DPASS\3-results'; *save results in correct folder;

  ods results off;
  ods rtf file = "2-eda.rtf";
    %include pgms("2-eda.sas"); 
  ods rtf close;
  ods results on;

options notes;
