** Program/project: JHS ASN0042 Data;
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

  *Primary VC data archetypes & program directory;
  libname  asn0042 "data\Ancillary Studies\ASN0042Liu-CT\1-data"; *Datasets from Liver CT study; 
  filename pgms    "data\Ancillary Studies\ASN0042Liu-CT\2-programs"; 

  *Read in format statements;
  options nonotes;
    %include pgms("0-1-formats.sas"); *Read in formats;
  options notes;
