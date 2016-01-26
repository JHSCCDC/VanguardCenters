/**************************************************************************************************
** This dataset comes from four data sources:
**
** 1) Clinic Data:
**    - Baseline age
**    - Date of Birth (All days set to 15th)
**    - Date of Contact
**    - Type of Contact
**    - time #
**
** 2) AFU (Long Form):
**    - Date of Contact
**    - AFU Contact Year
**    - AFU Form Version
**    - AFU Status
**    - Type of Contact
**
** 3) Death / Hard Refusal Data:
**    - Indication of Refusal
**************************************************************************************************/

** 1) Clinic Data ********************************************************************************;
  data V1dates; set analysis.validation1(keep = subjid V1date rename = (V1date = date)); by subjid; if ^missing(date);

    *Variable: type;
    length type $18;
      type  = "Clinic Exam 1";

    *Variable: visit;
    visit = 1;

    run;
    *Check: proc print data = V1dates(obs = 10); run;


  data V2dates; set analysis.validation2(keep = subjid V2date rename = (V2date = date)); by subjid; if ^missing(date);

    *Variable: type;
    length type $18;
      type  = "Clinic Exam 2";

    *Variable: visit;
    visit = 2;

    run;
    *Check: proc print data = V2dates(obs = 10); run;


  data V3dates; set analysis.validation3(keep = subjid V3date rename = (V3date = date)); by subjid; if ^missing(date);

    *Variable: type;
    length type $18;
      type  = "Clinic Exam 3";

    *Variable: visit;
    visit = 3;

    run;
    *Check: proc print data = V3dates(obs = 10); run;


** 2) AFU (Long Form) ****************************************************************************;
  data AFU; set AFU.afulong(keep =  subjid VERS date complete); by subjid;

    *Variable: type;
    length type $18;
      if VERS = 'A'  then type = "AFU Version A";
      if VERS = 'OA' then type = "AFO Version A";
      if VERS = 'B'  then type = "AFU Version B";
      if VERS = 'OB' then type = "AFO Version B";
      if VERS = 'C'  then type = "AFU Version C";
      if VERS = 'OC' then type = "AFO Version C";
      if VERS = 'D'  then type = "AFU Version D";
      if VERS = 'OD' then type = "AFO Version D";
      if VERS = 'E'  then type = "AFU Version E";

    drop VERS;
    run;
/*    *Check: proc print data = AFU(obs = 10); *run;*/

** 3) Death / Hard Refusal Data ******************************************************************;
    data deathHR; set cohort.deathltfucohort(keep = subjid lastdate laststatus rename = (lastdate = date)); by subjid; if laststatus in ("Confirmed Deceased" "Refused");

      *Variable type;
      length type $18;
        type = laststatus;

      run;
      *Check: proc print data = deathHR(obs = 10); run;

/**************************************************************************************************
** Combine data to create new cohort file
**************************************************************************************************/
  data cohort1; set V1dates V2dates V3dates AFU deathHR; by subjid; run;

  data cohort2; merge cohort1 analysis.validation1(keep = subjid V1date age dob); by subjid;

    *Variable: age;
    age = round((date - dob) / 365.25, 0.1);
      label YearsFromV1 = "Age (years)";
 
    *Variable: date;
    label date = "Date";

      *Subvariable: year;
      year = year(date);
      label year = "Year";

    *Variable: dob;
    label dob = "Date of Birth (MM/15/YYYY)";

    *Variable: complete;
    label complete = "AFU Final Status";

    /*Variable: refusal;
    refusal = 0;
      if laststatus = "Refused" then refusal = 1;

      label  refusal = "Participant has dropped out of study";
      format refusal 1.;
    */

    *Variable: type;
    label type = "Type of Contact";

    *Variable: visit;
    label visit = "Clinic Exam Visit Number";

    *Variable: YearsFromV1;
    YearsFromV1 = round((date - V1date) / 365.25, 0.1);
      label YearsFromV1 = "Years from Exam Visit 1";

    drop dob V1date laststatus visit;
    run;

  *Save dataset;
  proc sort data = cohort2; by subjid date; run;
  data cohort.cohort;
    retain subjid date year type age YearsFromV1 complete /*refusal*/;
    set cohort2;
    by subjid date;
    run;

proc datasets lib = work kill memtype=data;
run;
