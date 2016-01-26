/**************************************************
* Step 1: Bring Simple 7 metrics into one dataset *
*                                                 * 
*      1) Non-Smoking status                      *
*      2) BMI                                     *
*      3) Physical Activity                       *
*      4) Healthy Diet (Not available at Visit 3) *
*      5) Total Cholesterol                       *
*      6) Blood Pressure                          *
*      7) Fasting Plasma Glucose                  *
*                                                 *
**************************************************/

  *Instantiate simple 7 dataset;
  data simple7;
    set cohort.visitdat(  keep = subjid V3date
                        rename = (V3date = visitDate));
    by subjid;
    if ^missing(visitDate);

    visit = 3;
    format visit visit.;

    label visitDate = "Clinic Exam Visit Date";
    run;

  *Include date of death for participants that have died;
  data deaths;
    set cohort.deathltfucohort(keep = subjid lastdate laststatus);
    by subjid;
    if laststatus = "Dead";
    run;

  data simple7;
    merge simple7(in = in1)
          deaths;
    by subjid;
    if in1;
    run;


  *1) Non-Smoking status**************************************************************************;    
  /*Check;
    proc freq data = jhsV3.tobb;               table tobb5 tobb6a tobb6b tobb5*tobb6b /missing; run;
    proc freq data = jhsV3.tobb; format _all_; table                     tobb5*tobb6b /missing; run;
  */

  /*Form has too much missingness to calculate properly;
    proc means data = jhsV3.tobb nmiss; run; 
  */

  /*
  data simple7;
    merge simple7      (in     = in1)
          dat.simple7V1(keep   = subjid SMK3cat
                        rename = (SMK3cat = SMK3catV1))
          jhsV3.tobb   (keep = subjid tobb5 tobb6a tobb6b);    
    by subjid;
    if in1;

    *Derive AHA smoking status variable;
    currentSmoker = .;
    if  tobb30 = 0                     then currentSmoker = 0; *Not currently a smoker;
    if (tobb30 > 0 & ^missing(tobb30)) then currentSmoker = 1; *Currently a smoker;
    if (SMK3catV1 = 2 & tobb2 = 2)     then currentSmoker = 2; *Never a smoker (not at visit 1 or 3);

    yearsQuit = tobb6b + (tobb6a/12);

    SMK3cat = .;
    if currentSmoker = 1                  & ^missing(currentSmoker)                       then SMK3cat = 0; *Poor Health (Current Smoker);
    if currentSmoker = 0 & yearsQuit <  1 & ^missing(currentSmoker) & ^missing(yearsQuit) then SMK3cat = 1; *Intermediate Health (Former Smoker: quit < 12 months ago);
    if currentSmoker = 0 & yearsQuit >= 1 & ^missing(currentSmoker) & ^missing(yearsQuit) then SMK3cat = 2; *Ideal Health (Never smoked or quit >= 12 months ago);
    
    label  SMK3cat = "AHA Smoking Categorization";
    format SMK3cat LSS3cat.;

    *Create Smoking Ideal Health Indicator Variable;
    idealHealthSMK = .;
      if SMK3cat in (0 1) then idealHealthSMK = 0;
      if SMK3cat in (2)   then idealHealthSMK = 1;
    
    format idealHealthSMK YNfmt.;
    label  idealHealthSMK = "Indicator for Ideal Health via Smoking Status";
    run;

    /*Check;
      proc freq data = simple7; table SMK3cat; run;
    */
    */


  *2) BMI*****************************************************************************************;       
  data simple7;
    merge simple7           (in   = in1)
          analysis.analysis3(keep = subjid BMI);
    by subjid;
    if in1;

    *Derive AHA BMI variable;
    BMI3cat = .;
      if 30 <= BMI            & ^missing(BMI) then BMI3cat = 0; *Poor Health (Obese: >= 30 kg/m^2);
      if 25 <= BMI & BMI < 30 & ^missing(BMI) then BMI3cat = 1; *Intermediate Health (Overweight: 25-29.9 kg/m^2);
      if             BMI < 25 & ^missing(BMI) then BMI3cat = 2; *Ideal Health (Ideal: < 25 kg/m^2);
      
      label  BMI3cat = "AHA BMI Categorization";
      format BMI3cat LSS3cat.;

    *Create BMI Ideal Health Indicator Variable;
    idealHealthBMI = .;
      if BMI3cat in (0 1) then idealHealthBMI = 0;
      if BMI3cat in (2)   then idealHealthBMI = 1;
    
      format idealHealthBMI YNfmt.;
      label  idealHealthBMI = "Indicator for Ideal Health via BMI";
    run;

 
  *3) Physical Activity***************************************************************************;  
  %include pgms("1-0-3-data-jhs activities.sas");
  %include pgms("1-0-0-data-cdc.sas");

    *Clean up the SAS activity dataset;
    data activity;
      retain subjid lowActTime modActTime vigActTime vigModActTime PA3cat idealHealthPA;
      set CDCactivity(keep = subjid lowActTime modActTime vigActTime vigModActTime PA3cat idealHealthPA);
      by subjid;
      run;

  data simple7; merge simple7(in = in1) activity; by subjid; if in1; run;

 
  *5) Total Cholesterol***************************************************************************; 
  data simple7;
    merge simple7           (in = in1)
          analysis.analysis3(keep = subjid medAcct statinMeds FastHours totChol)
          jhsV3.cenc        (keep = subjid chr);
    by subjid;
    if in1;

    *Derive statin medication variable;
    if medAcct in (1 2) & missing(statinMeds) then statinMeds = 0;

    *Derive AHA total cholesterol status variable;
    totChol3cat = .;
      if 240 <= totChol                        & ^missing(totChol)                        then totChol3cat = 0; *Poor Health (>= 240 mg/dL);
      if 200 <= totChol < 240                  & ^missing(totChol)                        then totChol3cat = 1; *Intermediate Health (200-239 mg/dL if untreated);
      if        totChol < 200 & statinMeds = 1 & ^missing(totChol) & ^missing(statinMeds) then totChol3cat = 1; *Intermediate Health (200 mg/dL if treated);
      if        totChol < 200 & statinMeds = 0 & ^missing(totChol) & ^missing(statinMeds) then totChol3cat = 2; *Ideal Health (< 200 mg/dL if untreated);
      
      label  totChol3cat = "AHA Total Cholesterol Categorization";
      format totChol3cat LSS3cat.;
    
    *Create Total Cholesterol Ideal Health Indicator Variable;
    idealHealthCHOL = .;
      if totChol3cat in (0 1) then idealHealthCHOL = 0;
      if totChol3cat in (2)   then idealHealthCHOL = 1;
    
      format idealHealthCHOL YNfmt.;
      label  idealHealthCHOL = "Indicator for Ideal Health via Total Cholesterol";
    run;

 
  *6) Blood Pressure******************************************************************************;    
  data simple7;
    merge simple7           (in   = in1)
          analysis.analysis3(keep = subjid medAcct BPmeds SBP DBP);
    by subjid;
    if in1;

    *Derive statin medication variable;
    if medAcct in (1 2) & missing(BPmeds) then BPmeds = 0;

    *Derive AHA blood pressure status variable;
    BP3cat = .;
      if (  140 <= SBP              |  90 <= DBP             )              & ^missing(SBP) & ^missing(DBP)                    then BP3cat = 0; *Poor Health (SBP >= 140 mmHg OR DBP >= 90 mmHg);
      if ( (120 <= SBP & SBP < 140) | (80 <= DBP & DBP < 90) )              & ^missing(SBP) & ^missing(DBP)                    then BP3cat = 1; *Intermediate Health (SBP 120-139 mmHg OR DBP 80-89 mmHg);
      if (               SBP < 120  &              DBP < 80  ) & BPmeds = 1 & ^missing(SBP) & ^missing(DBP) & ^missing(BPmeds) then BP3cat = 1; *Intermediate Health (treated to goal);
      if (               SBP < 120  &              DBP < 80  ) & BPmeds = 0 & ^missing(SBP) & ^missing(DBP) & ^missing(BPmeds) then BP3cat = 2; *Ideal Health (SBP < 120 mmHg OR DBP < 80 mmHg);

      label  BP3cat = "AHA Blood Pressure Categorization";
      format BP3cat LSS3cat.;

    *Create Blood Pressure Ideal Health Indicator Variable;
    idealHealthBP = .;
      if BP3cat in (0 1) then idealHealthBP = 0;
      if BP3cat in (2)   then idealHealthBP = 1;
    
      format idealHealthBP YNfmt.;
      label  idealHealthBP = "Indicator for Ideal Health via Blood Pressure";
    run;

 
  *7) Glucose*************************************************************************************;
  data simple7;
    merge simple7           (in   = in1)
          analysis.analysis3(keep = subjid DMmeds HbA1c HbA1c3cat FastHours FPG FPG3cat diab3cat)
          jhsV3.cenc        (keep = subjid glyhb glur);
    by subjid;
    if in1;

    /* diab3cat definition:
      Non-diabetic defined as:                                                                                                    
           (1) HbA1c < 5.7%; 
           (2) fasting plasma glucose < 100 mg/dL; and                                                                       
           (3) no report of taking diabetes medications.

      Pre-diabetic or at risk of diabetes defined as:                                                                         
           (1) 5.7% <= HbA1c < 6.5% ; or 
           (2)  100 mg/dL = Fasting Glucose < 126 mg/dL; and (3) no report of taking diabetes medications.

      Diabetic defined as:                                                                                                               
           (1) fasting glucose = 126 mg/dL; or (2) HbA1c = 6.5%; or (3) report of taking diabetes medications.

    NOTE: this coding needs to be reversed to be consistent with the AHA guidelines
    */

    *Derive AHA glucose status variable;
    if diab3cat = 2 then glucose3cat = 0; *Poor Health;
    if diab3cat = 1 then glucose3cat = 1; *Intermediate Health;
    if diab3cat = 0 then glucose3cat = 2; *Ideal Health;

    label  glucose3cat = "AHA Glucose Categorization";
    format glucose3cat LSS3cat.;

    *Create Glucose Ideal Health Indicator Variable;
    idealHealthDM = .;
      if glucose3cat in (0 1) then idealHealthDM = 0;
      if glucose3cat in (2)   then idealHealthDM = 1;
    
      format idealHealthDM YNfmt.;
      label  idealHealthDM = "Indicator for Ideal Health via Glucose";
    run;
