*Set system options like do not center or put a date on output, etc.;
options nocenter nodate nonumber ps = 150 linesize = 100 nofmterr;

*Clear work directory;
proc datasets lib = work kill memtype = data; run; quit;

*Assign root directory ;
**************************************************************************************************;
* YOU MUST CHANGE THIS TO YOUR DIRECTORY STRUCTURE!:
**************************************************************************************************;
 *-YG; x 'cd C:\Users\ygao\Desktop\UMMC biostatistics\VC 2014-12Dec\VanguardCenters\data\Environmental';  *Change This!;
  libname  dat      "1-data";                                                                             *Environmental data;
  filename pgms     "2-programs\validation";                                                              *Environmental programs directory;


*Run validation programs**************************************************************************;
%include pgms("2-0-validation.sas");
%include pgms("2-1-validation.sas");


 
