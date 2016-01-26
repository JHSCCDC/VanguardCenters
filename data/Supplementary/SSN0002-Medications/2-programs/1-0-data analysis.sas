*Clear work directory*****************************************************************************;
options nonotes;
ods results off;
  proc datasets lib = work kill memtype = data; run; quit;
ods results on;
options notes;
%put -Ignore warning if work library is empty-;


*Read in macros***********************************************************************************;
%macro reshape();
  options nonotes;
  ods results off;

  data medicationsWide;
    set cohort.visitdat(keep = subjid); * initialize dataset, use just subject ID;
    run;

  data medicationsLong;
    set medicationsLong;
    if visit = 1 then visitTag = "V1"; *reformat the visitTag variable for id statement in proc transpose;
    if visit = 2 then visitTag = "V2";
    if visit = 3 then visitTag = "V3";
    run;

  %let i = 1; * start the counter at 1;
  %let var = %scan(&variables, &i); * picks off the i^th variable out of the list &variables;

  %do %while(&var ne ); * do loop ends when we are out of variables;

    proc transpose data = medicationsLong out = &var prefix = &var; * reshape from long to wide - prefix keeps name of variable;
      id visitTag; * what SAS appends to the end of the prefix;
      by subjid; * one observation per subjid;
      var &var; * what variable to transpose;
      run;

    data &var;
      set &var;
      drop _NAME_ _LABEL_; * drop the name and label for ease in merging;
      run;

    data medicationsWide;
      merge medicationsWide
            &var; * append new dataset onto the wide dataset;
      by subjid; * merge by subjid;
      run;

    proc datasets library = work memtype = data;    
      delete &var; * housekeeping - delete vars wide dataset since we have already appended it to the overall wide dataset;
      run;

    %let i   = %eval(&i + 1); * increase counter;
    %let var = %scan(&variables, &i); * pick off next variable for reshaping;

    %end;

  ods results on;
  options notes;
%mend reshape;

**************************************************************************************************;

%macro medData(visit = );

data meds&visit; set jhs&visit..medcodes(keep = subjid tccode tcname medconc); by subjid;

  *Variable: group;
  tccode2  = (substr(tccode, 1,  2) + 0); *First two digits;
    format tccode2 group.;

  *Variable: tccode3;
  tccode3  = (substr(tccode, 1,  3) + 0); *First three digits;

  *Variable: class;
  tccode4  = (substr(tccode, 1,  4) + 0); *First four digits;
    format tccode4 class.;

  *Variable: subClass;
  tccode6  = (substr(tccode, 1,  6) + 0); *First six digits;
    format tccode6 subClass.;

  *Variable: superGroup;
  if  0 < tccode2 <= 16 then do; superGroup =  1; end;
  if 16 < tccode2 <= 20 then do; superGroup =  2; end;
  if 20 < tccode2 <= 21 then do; superGroup =  3; end;
  if 21 < tccode2 <= 30 then do; superGroup =  4; end;
  if 30 < tccode2 <= 40 then do; superGroup =  5; end;
  if 40 < tccode2 <= 45 then do; superGroup =  6; end;
  if 45 < tccode2 <= 52 then do; superGroup =  7; end;
  if 52 < tccode2 <= 56 then do; superGroup =  8; end;
  if 56 < tccode2 <= 63 then do; superGroup =  9; end;
  if 63 < tccode2 <= 71 then do; superGroup = 10; end;
  if 71 < tccode2 <= 76 then do; superGroup = 11; end;
  if 76 < tccode2 <= 81 then do; superGroup = 12; end;
  if 81 < tccode2 <= 85 then do; superGroup = 13; end;
  if 85 < tccode2 <= 91 then do; superGroup = 14; end;
  if 91 < tccode2 <= 99 then do; superGroup = 15; end;

  format superGroup superGroup.;

  run;

%mend medData;

**************************************************************************************************;

%macro createMeds(medName = , condition = , medClass = );

  ods results off;

  ods rtf file = "3-results\2-validation &medName..rtf";

    *Visit 1 Long-Form Dataset**********************************************************************;
    data &medName.V1; retain subjid tccode tcname medconc;  set medsV1; by subjid;
      rename tccode     = tccodeV1
             tcname     = tcnameV1 
             medconc    = medconcV1
             tccode2    = tccode2v1
             tccode4    = tccode4v1
             tccode6    = tccode6v1
             superGroup = superGroupV1;

      &medName.V1 = (&condition) * 1;
        if ^&medName.V1 then delete;
      run;

      *Obtain single row per ptcpt of # of meds;
      proc means data = &medName.V1 noprint; *Obtain single row per ptcpt of # of meds;
        class subjid;
        var &medName.V1;
        ways 1;
        output out = num&medName.V1(drop = _TYPE_  _FREQ_) 
               sum = num&medName.V1;
        run;

      data num&medName.V1; set num&medName.V1; *Obtain single row per ptcpt of 0/1 = No/Yes, on a med;
        if NOT missing(num&medName.V1) then &medName.V1 = num&medName.V1 > 0;

        label  &medName.V1 = "&medClass (&medName) taken at Exam 1 (Y/N)";
        format &medName.V1 ynfmt.;

        label  num&medName.V1 = "Number of &medClass (&medName) taken at Exam 1";
        format num&medName.V1 numMeds.;
        run;

      data &medName.V1; merge num&medName.V1 &medName.V1; by subjid; run;

    title    "&medClass (&medName) Frequencies from JHS Exam Exam 1 (Long-Form)";
    footnote "Note: Multiple Medications per Participant Possible";
      proc freq data = &medName.V1 order = freq; tables tccodeV1*tcnameV1 /missing list nopct; run;
    title;
    footnote;

    *Visit 2 Long-Form Dataset**********************************************************************;
    data &medName.V2; retain subjid tccode tcname medconc; set medsV2; by subjid;
      rename tccode     = tccodeV2
             tcname     = tcnameV2 
             medconc    = medconcV2
             tccode2    = tccode2v2
             tccode4    = tccode4v2
             tccode6    = tccode6v2
             superGroup = superGroupV2;

      &medName.V2 = (&condition) * 1;
        if ^&medName.V2 then delete;
      run;

      *Obtain single row per ptcpt of # of meds;
      proc means data = &medName.V2 noprint; *Obtain single row per ptcpt of # of meds;
        class subjid;
        var &medName.V2;
        ways 1;
        output out = num&medName.V2(drop = _TYPE_  _FREQ_) 
               sum = num&medName.V2;
        run;

      data num&medName.V2; set num&medName.V2; *Obtain single row per ptcpt of 0/1 = No/Yes, on a med;
        if NOT missing(num&medName.V2) then &medName.V2 = num&medName.V2 > 0;

        label  &medName.V2 = "&medClass (&medName) taken at Exam 2 (Y/N)";
        format &medName.V2 ynfmt.;

        label  num&medName.V2 = "Number of &medClass (&medName) taken at Exam 2";
        format num&medName.V2 numMeds.;
        run;

      data &medName.V2; merge num&medName.V2 &medName.V2; by subjid; run;

    title    "&medClass (&medName) Frequencies from JHS Exam Exam 2 (Long-Form)";
    footnote "Note: Multiple Medications per Participant Possible";
      proc freq data = &medName.V2 order = freq; tables tccodeV2*tcnameV2 /missing list nopct; run;
    title;
    footnote;

    *Visit 3 Long-Form Dataset**********************************************************************;
    data &medName.V3; retain subjid tccode tcname medconc; set medsV3; by subjid;
      rename tccode     = tccodeV3
             tcname     = tcnameV3 
             medconc    = medconcV3
             tccode2    = tccode2v3
             tccode4    = tccode4v3
             tccode6    = tccode6v3
             superGroup = superGroupV3;

      &medName.V3 = (&condition) * 1; 
        if ^&medName.V3 then delete;
      run;

      *Obtain single row per ptcpt of # of meds;
      proc means data = &medName.V3 noprint; *Obtain single row per ptcpt of # of meds;
        class subjid;
        var &medName.V3;
        ways 1;
        output out = num&medName.V3(drop = _TYPE_  _FREQ_) 
               sum = num&medName.V3;
        run;

      data num&medName.V3; set num&medName.V3; *Obtain single row per ptcpt of 0/1 = No/Yes, on a med;
        if NOT missing(num&medName.V3) then &medName.V3 = num&medName.V3 > 0;

        label  &medName.V3 = "&medClass (&medName) taken at Exam 3 (Y/N)";
        format &medName.V3 ynfmt.;

        label  num&medName.V3 = "Number of &medClass (&medName) taken at Exam 3";
        format num&medName.V3 numMeds.;
        run;

      data &medName.V3; merge num&medName.V3 &medName.V3; by subjid; run;

    title    "&medClass (&medName) Frequencies from JHS Exam Exam 3 (Long-Form)";
    footnote "Note: Multiple Medications per Participant Possible";
      proc freq data = &medName.V3 order = freq; tables tccodeV3*tcnameV3 /missing list nopct; run;
    title;
    footnote;

    *All Visits Wide-Form Dataset*******************************************************************;
    data &medName; merge &medName.V1 &medName.V2 &medName.V3; by subjid; 
  
      *Define number of visits that medications were taken;
      &medName = sum(&medName.V1, &medName.V2, &medName.V3);
        label  &medName = "Number of Exams that &medClass (&medName) were taken";
        format &medName numExams.;

      keep subjid &medName.V1 num&medName.V1 &medName.V2 num&medName.V2 &medName.V3 num&medName.V3 &medName;
      run;
      proc sort data = &medName nodupkey; by subjid; run; *Drop duplicates;

    *Compile dataset********************************************************************************;
    data medications; merge medications(in = in1) &medName; by subjid; if in1;
      if missing(&medName)                       then do; &medName    = 0;                     end;
      if missing(&medName.V1) & ^missing(V1date) then do; &medName.V1 = 0; num&medName.V1 = 0; end;
      if missing(&medName.V2) & ^missing(V2date) then do; &medName.V2 = 0; num&medName.V2 = 0; end;
      if missing(&medName.V3) & ^missing(V3date) then do; &medName.V3 = 0; num&medName.V3 = 0; end;
      run;

    *EDA********************************************************************************************;
    title "&medClass frequencies from JHS Exam Exam 1 (Wide-Form)";
      proc freq data = medications; where &medName; tables num&medName.V1*&medName.V1 /missing; run;
    title;

    title "&medClass frequencies from JHS Exam Exam 2 (Wide-Form)";
      proc freq data = medications; where &medName; tables num&medName.V2*&medName.V2 /missing; run;
    title;

    title "&medClass frequencies from JHS Exam Exam 3 (Wide-Form)";
      proc freq data = medications; where &medName; tables num&medName.V3*&medName.V3 /missing; run;
    title;

  ods rtf close;

  ods results on;

%mend createMeds;
