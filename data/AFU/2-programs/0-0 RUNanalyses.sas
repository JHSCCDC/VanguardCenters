** Program/project: JHS AFU Data;
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
*Example 2: x "cd C:\Users\sseals\Desktop\VC Packages\2013-12-20\VanguardCenters\data";

libname  afu      "AFU\1-data\JHS AFU Frozen Files\AFU"; 			 * Directory containing AFU;
libname  afo      "AFU\1-data\JHS AFU Frozen Files\AFO"; 			 * Directory containing AFO;
libname  af       "AFU\1-data\JHS AFU Frozen Files\AF";				 * Directory containing AF;
libname  out      "AFU\1-data"; 	 			  					 * Directory to deposit final AFUlong into;
libname  cohort   "data\Cohort\1-data"; 							 * Directory for dataset with visit dates;
libname  tera     "data\Supplementary\1-data";						 * Directory for death and hard refusal info;

filename afup     "AFU\2-programs"; 		  						 * Directory containing programs;

x "cd C:\Users\sseals\Desktop\AFU";

options nonotes;
	%include afup("0-1 formats.sas"); 	 * Define formats;

	* Build AFU long;

	%include afup("1-1 AFUA.sas");		 * Build AFUA;
	%include afup("1-2 AFUB.sas");		 * Build AFUB;
	%include afup("1-3 AFUC.sas");		 * Build AFUC;
	%include afup("1-4 AFUD.sas");		 * Build AFUD;
	%include afup("1-5 AFUE.sas");		 * Build AFUE;
	%include afup("1-6 AFUlong.sas");	 * Build AFUlong;

	* Build AF1, AF2, AF3;

	%include afup("2-1 AF1.sas");		 * Build AF1;
	%include afup("2-2 AF2.sas");		 * Build AF1;
	%include afup("2-3 AF3.sas");		 * Build AF1;

options notes;
