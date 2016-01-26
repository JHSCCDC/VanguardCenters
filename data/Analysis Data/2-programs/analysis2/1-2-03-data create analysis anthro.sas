********************************************************************;
****************** Section 3: Anthropometrics **********************;
********************************************************************;

title "Section 3: Anthropometrics";

*BCFA;
data include1; *BCFA;
  set jhsV2.bcfa(keep = subjid bcfa5 bcfa6 bcfa8a bcfa8b bcfa9);
  by subjid;

  *Create renamed duplicates for formulas;
  weight = bcfa9 * 0.454;
  height = (12 * bcfa8a + bcfa8b) * 2.54;
  waist  = bcfa5 * 2.54;
  hip    = bcfa6 * 2.54; 
  run;

*Create variables; 
data include; *Create variables; 
  set include1; 
  by subjid;

  *Variable: weight;
  label  weight = "Weight (kg)";
  format weight 8.1;

  *Variable: height;
  label  height = "Height (cm)";
  format height 8.1;

  *Variable: BMI;
  BMI = weight / ((height / 100) ** 2); *in kg/m^2;
  label  BMI = "Body Mass Index (kg/m^2)";
  format BMI 8.2;

  *Variable: waist;
  label  waist = "Waist Circumference (cm)";
  format waist 8.2;

  *Variable: hip;
  label hip = "Hip Circumference (cm)";
  format hip 8.2;

  *Variable: neck;
  neck = .; *Not collected in Visit 2;
  label  neck = "Neck Circumference (cm)";
  format neck 8.2;

  *Variable: bsa;
  bsa = 0.007184*(height**0.725)*(weight**0.425);
  label	 bsa = "Calculated Body Surface Area (m^2)";
  format bsa 8.2;
  run;

*Add to Analysis Dataset;
data analysis; *Add to Analysis Dataset;
  merge analysis(in = in1) include;
  by subjid;
    if in1 = 1; *Only keep clean ptcpts;
  run;
  /*Checks;
  proc contents data = analysis; run;
  proc print data = analysis(obs = 5); run;
  */

%put Section 03 Complete;
