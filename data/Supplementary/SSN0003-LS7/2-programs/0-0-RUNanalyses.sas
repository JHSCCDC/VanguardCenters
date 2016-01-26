*Set system options like do not center or put a date on output, etc.;
options nocenter nodate nonumber ps = 150 linesize = 100 nofmterr;

*Clear work directory;
proc datasets lib = work kill memtype = data; run; quit;

*Assign root directory (VanguardCenters);
**************************************************************************************************;
* YOU MUST CHANGE THIS TO YOUR DIRECTORY STRUCTURE!:
**************************************************************************************************;
*Example: x 'cd C:\JHS\VanGuardCenters';
*-CB; x 'cd C:\Users\cblackshear\Box Sync\JHS\CC\JHS01-StudyData\VCworking\VanguardCenters'; *Change This!;
  libname  analysis "data\Analysis Data\1-data";                               *Analysis-read data;
  libname  cohort   "data\Cohort\1-data";                                      *Cohort data;
  libname  jhsV1    "data\Visit 1\1-data";                                     *"Raw" Exam 1 data; 
  libname  jhsV2    "data\Visit 2\1-data";                                     *"Raw" Exam 2 data; 
  libname  jhsV3    "data\Visit 3\1-data";                                     *"Raw" Exam 3 data; 
  libname  dat      "data\Supplementary\SSN0003Griswold-LS7\1-data";           *Simple 7 data;
  libname  ntrtn    "data\Supplementary\SSN0003Griswold-LS7\1-data\nutrition"; *Simple 7 nutrition data;
  filename pgms     "data\Supplementary\SSN0003Griswold-LS7\2-programs";       *Simple 7 programs directory;

  %include pgms("0-1-formats.sas"); *Load Simple 7 formats;

*Read in formats from the JHS catalogue;
option fmtsearch = (/*jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats analysis.formats activity.formats*/ dat.formats);


*Run visit 1 data creation progams****************************************************************;
%include pgms("1-1-data.sas");

  *Save data;
    data dat.simple7V1;
      set simple7;
      by subjid;
      run;

    /*Check; 
      proc print data = simple7(obs = 10); run;
    */

*Run visit 2 data creation progams****************************************************************;
%include pgms("1-2-data.sas");

  *Save data;
    data dat.simple7V2;
      set simple7;
      by subjid;
      run;

    /*Check; 
      proc print data = simple7(obs = 10); run;
    */

*Run visit 3 data creation progams****************************************************************;
%include pgms("1-3-data.sas");

  *Save data;
    data dat.simple7V3;
      set simple7;
      by subjid;
      run;


*Stack up a long-form simple 7 dataset************************************************************;
data dat.simple7long;
  set dat.simple7V1
      dat.simple7V2
      dat.simple7V3;
  by subjid;
  run;


*Run validation programs**************************************************************************;
%include pgms("2-0-validation.sas");

options nonotes;
  ods results off;
    ods rtf file = "data\Supplementary\SSN0003Griswold-LS7\3-results\2-validation.rtf";

      title "Simple 7 Metrics - Visit 1";

        *Read in Validation Analysis Data;
        data validation; set dat.simple7long; if visit = 1; run;

        *Variable List;
          %let contvar = ;                                                                               *Continuous;
          %let catvar  = laststatus SMK3cat BMI3cat PA3cat nutrition3cat totChol3cat BP3cat glucose3cat; *Categorical;

        *Simple Data Listing & Summary Stats;
        %simple(visit = 1);

      title;

      title "Simple 7 Metrics - Visit 2";

        *Read in Validation Analysis Data;
        data validation; set dat.simple7long; if visit = 2; run;

        *Variable List;
          %let contvar = ;                                                                               *Continuous;
          %let catvar  = laststatus SMK3cat BMI3cat PA3cat nutrition3cat totChol3cat BP3cat glucose3cat; *Categorical;

        *Simple Data Listing & Summary Stats;
        %simple(visit = 2);

      title;

      title "Simple 7 Metrics - Visit 3";

        *Read in Validation Analysis Data;
        data validation; set dat.simple7long; if visit = 3; run;

        *Variable List;
          %let contvar = ;                                                                               *Continuous;
          %let catvar  = laststatus SMK3cat BMI3cat PA3cat nutrition3cat totChol3cat BP3cat glucose3cat; *Categorical;

        *Simple Data Listing & Summary Stats;
        %simple(visit = 3);

      title;

    ods rtf close; 
  ods results on;
options notes;
