proc sort data = jhsV2.medcodes; by subjid; run;

*MEDCODES;
data include1; *MEDCODES;
  set jhsV2.medcodes(keep = subjid tccode);
  by subjid;

  if tccode = 'CONJUGATED 0' then tccode = .;
  if tccode = 'PORCINE 0' then tccode = .;

  tccode2 = (substr(tccode, 1, 2) + 0); *First two digits;
  tccode3 = (substr(tccode, 1, 3) + 0); *First three digits;
  tccode4 = (substr(tccode, 1, 4) + 0); *First four digits;
  tccode6 = (substr(tccode, 1, 6) + 0); *First six digits;

  BPmedsAcct        = (33 <= tccode2 <= 37) * 1;                                *BP meds indicator;
  DMmedsOralAcct    = (tccode2 = 27 & tccode3 ^= 271) * 1;                      *Diabetic oral meds indicator;
  DMmedsInsAcct     = (tccode3 = 271)* 1;                                       *Diabetic insulin meds indicator;
  DMmedsAcct        = (tccode2 = 27) * 1;                                       *Diabetic meds indicator;
  statinMedsAcct    = (tccode4 = 3940) * 1;                                     *Statin meds indicator;
  hrtMedsAcct       = (24 <= tccode2 <= 26) * 1;                                *Hormone replacement therapy meds indicator;
  betaBlkMedsAcct   = (tccode2 = 33) * 1;                                       *Beta blocker meds indicator;
  calBlkMedsAcct    = (tccode2 = 34 | tccode6 = 369915 | tccode6 = 369925) * 1; *Calcium channel blocker meds indicator;
  diureticMedsAcct  = (tccode2 = 37 | tccode6 = 369918
                                    | tccode6 = 369920
                                    | tccode6 = 369940
                                    | tccode6 = 369950
                                    | tccode6 = 369955
                                    | tccode6 = 369970
                                    | tccode6 = 369980
                                    | tccode6 = 369990) * 1;                    *Diuretic meds indicator;
  antiArythMedsAcct = (tccode2 = 35) * 1;                                        *Anti-Arrhythmic meds indicator;

  *Remove individual meds per Harman HTN paper;
  if   tccode2 =  35          then BPmedsAcct = 0; *Delete Antiarrhythmics;
  if   tccode3 =  363         then BPmedsAcct = 0; *Delete pheochromocytoma agents;
  if   tccode  = '3640002000' then BPmedsAcct = 0; *Delete minoxidil;
  if   tccode3 =  371         then BPmedsAcct = 0; *Delete carbonic anhydrase inhibitors;
  if   tccode  = '3799200410' then BPmedsAcct = 0; *Delete herbal;
  run;
  *proc print data = include2(obs = 30); run;
    *Obtain single row per ptcpt of # of BPmedsAcct;
    proc means data = include1 noprint; *Obtain single row per ptcpt of # of meds;
      class subjid;
      var BPmedsAcct DMmedsOralAcct DMmedsInsAcct DMmedsAcct statinMedsAcct hrtMedsAcct betaBlkMedsAcct calBlkMedsAcct diureticMedsAcct antiArythMedsAcct;
      ways 1;
      output out = include1(drop = _TYPE_  _FREQ_) 
             sum = numBPmedsAcct numDMmedsOralAcct numDMmedsInsAcctAcct numDMmedsAcct numstatinMedsAcct numhrtMedsAcct numbetaBlkMedsAcct numcalBlkMedsAcct numdiureticMedsAcct numantiArythMedsAcct;
      run;
      *proc print data = include1(obs = 30); run;
    data include1; *Obtain single row per ptcpt of 0/1 = No/Yes, on a med;
      set include1;
      if NOT missing(numBPmedsAcct)         then BPmedsAcct         = numBPmedsAcct         > 0;
      if NOT missing(numDMmedsOralAcct)     then DMmedsOralAcct     = numDMmedsOralAcct > 0;
      if NOT missing(numDMmedsInsAcctAcct)  then DMmedsInsAcct      = numDMmedsInsAcctAcct  > 0;
      if NOT missing(numDMmedsAcct)         then DMmedsAcct         = numDMmedsAcct         > 0;
      if NOT missing(numstatinMedsAcct)     then statinMedsAcct     = numstatinMedsAcct     > 0;
      if NOT missing(numhrtMedsAcct)        then hrtMedsAcct        = numhrtMedsAcct        > 0;
      if NOT missing(numbetaBlkMedsAcct)    then betaBlkMedsAcct    = numbetaBlkMedsAcct    > 0;
      if NOT missing(numcalBlkMedsAcct)     then calBlkMedsAcct     = numcalBlkMedsAcct     > 0;
      if NOT missing(numdiureticMedsAcct)   then diureticMedsAcct   = numdiureticMedsAcct   > 0;
      if NOT missing(numantiArythMedsAcct)  then antiArythMedsAcct  = numantiArythMedsAcct  > 0;
      run;

*MSRB;
data include2; *MSRB;
  set jhsV2.msrb(keep = subjid msrb1 msrb2 msrb29a); 
  by subjid;

  *Create renamed duplicates for formulas;
  BPmedsSelfRep = msrb29a;

  *Create renamed duplicates for formulas;
  broughtMeds = "NotAllMeds";
    if msrb2 = 1      then broughtMeds = "AllMeds";
    if missing(msrb2) then broughtMeds = "";

  whyNOmeds = "Other    ";
    if msrb1 = 2      then whyNOmeds = "NoneTaken";
    if missing(msrb1) then whyNOmeds = "";
  run;

*Combine datasets and merge checking variables;
data include; *Combine datasets and merge checking variables;
  merge include1(in = in1)
        include2(in = in2);
  by subjid; 
    inc1 = in1;
    inc2 = in2; 
    if first.subjid then chkobs = 0;
    chkobs + 1;
  run;
  /*Checks;
  proc freq data=include; tables inc1*inc2; run;
  proc print data=include(where=(chkobs>1)); run;
  */
  data include; *Drop temporary variables;
    set include;
    drop inc1 inc2 chkobs;
    run;

*Create Variables;
data include; *Create Variables;
  set include;

  *Variable: medAcct;
  medAcct = 0;
  if whyNOmeds   = "NoneTaken"                 then medAcct = 1;
  if broughtMeds = "AllMeds"                   then medAcct = 2; 
  if missing(broughtMeds) & missing(whyNOmeds) then medAcct = .;
  label medAcct = "Medication Accountability";
  format medAcct medAcct.;
 
  *Variable: BPmeds;
  if missing(medAcct)              then BPmeds = .;
  if medAcct = 0                   then BPmeds = .;
  if medAcct = 1                   then BPmeds = 0;
  if medAcct = 2 & missing(BPmeds) then BPmeds = 0; 
  label  BPmeds = "Blood Pressure Medication Status (Y/N)";
  format BPmeds ynfmt.;

  *Variable: BPmedsSelf;
  if      BPmedsSelfRep = 2 | whyNOmeds = "NoneTaken" then BPmedsSelf = 0;
  else if BPmedsSelfRep = 1                           then BPmedsSelf = 1;
  else                                                     BPmedsSelf = .;
  label   BPmedsSelf = "Self-Reported BP Medication Status (Y/N)";
  format  BPmedsSelf ynfmt.;

  *Variable: DMmedsOral;
  if missing(medAcct)                  then DMmedsOral = .;
  if medAcct = 0                       then DMmedsOral = .;
  if medAcct = 1                       then DMmedsOral = 0;
  if medAcct = 2 & missing(DMmedsOral) then DMmedsOral = 0; 
  label  DMmedsOral = "Diabetic Oral Medication Status (Y/N)";
  format DMmedsOral ynfmt.;

  *Variable: DMmedsIns;
  if missing(medAcct)                 then DMmedsIns = .;
  if medAcct = 0                      then DMmedsIns = .;
  if medAcct = 1                      then DMmedsIns = 0;
  if medAcct = 2 & missing(DMmedsIns) then DMmedsIns = 0; 
  label  DMmedsIns = "Diabetic Insulin Medication Status (Y/N)";
  format DMmedsIns ynfmt.;

  *Variable: DMMedType;
  if (DMmedsOral = 0 & DMmedsIns = 0) then DMMedType = 0; else
  if (DMmedsOral = 1 & DMmedsIns = 0) then DMMedType = 1; else
  if (DMmedsOral = 0 & DMmedsIns = 1) then DMMedType = 2; else
  if (DMmedsOral = 1 & DMmedsIns = 1) then DMMedType = 3; 
  label  DMMedType= "Type of Diabetic Medication";
  format DMMedType DMMedType.;

  *Variable: DMmeds;
  if missing(medAcct)              then DMmeds = .;
  if medAcct = 0                   then DMmeds = .;
  if medAcct = 1                   then DMmeds = 0;
  if medAcct = 2 & missing(DMmeds) then DMmeds = 0; 
  label  DMmeds = "Diabetic Medication Status (Y/N)";
  format DMmeds ynfmt.;

  *Variable: statinMeds;
  if missing(medAcct)                  then statinMeds = .;
  if medAcct = 0                       then statinMeds = .;
  if medAcct = 1                       then statinMeds = 0;
  if medAcct = 2 & missing(statinMeds) then statinMeds = 0; 
  label  statinMeds = "Statin Medication Status (Y/N)";
  format statinMeds ynfmt.;

  *Variable: hrtMeds;
  if missing(medAcct)               then hrtMeds = .;
  if medAcct = 0                    then hrtMeds = .;
  if medAcct = 1                    then hrtMeds = 0;
  if medAcct = 2 & missing(hrtMeds) then hrtMeds = 0; 
  label  hrtMeds = "Hormone Replacement Therapy Medication Status (Y/N)";
  format hrtMeds ynfmt.;

  *Variable: hrtMedsSelfEver;
  hrtMedsSelfEver = .; *Not collected in Visit 2;
  label hrtMedsSelfEver = "Self Reported HRT Medication Status (Y/N)";
  format hrtMedsSelfEver ynfmt.;

  *Variable: hrtMedsSelf;
  hrtMedsSelf = .;     *Not collected in Visit 2;
  label hrtMedsSelf = "Self Reported Current HRT Medication Status (Y/N)";
  format hrtMedsSelf ynfmt.;

  *Variable: betaBlkMeds;
  if missing(medAcct)                   then betaBlkMeds = .;
  if medAcct = 0                        then betaBlkMeds = .;
  if medAcct = 1                        then betaBlkMeds = 0;
  if medAcct = 2 & missing(betaBlkMeds) then betaBlkMeds = 0; 
  label  betaBlkMeds = "Beta Blocker Medication Status (Y/N)";
  format betaBlkMeds ynfmt.;

  *Variable: calBlkMeds;
  if missing(medAcct)                  then calBlkMeds = .;
  if medAcct = 0                       then calBlkMeds = .;
  if medAcct = 1                       then calBlkMeds = 0;
  if medAcct = 2 & missing(calBlkMeds) then calBlkMeds = 0; 
  label  calBlkMeds = "Calcium Channel Blocker Medication Status (Y/N)";
  format calBlkMeds ynfmt.;

  *Variable: diureticMeds;
  if missing(medAcct)                    then diureticMeds = .;
  if medAcct = 0                         then diureticMeds = .;
  if medAcct = 1                         then diureticMeds = 0;
  if medAcct = 2 & missing(diureticMeds) then diureticMeds = 0; 
  label  diureticMeds = "Diuretic Medication Status (Y/N)";
  format diureticMeds ynfmt.;

  *Variable: antiArythMeds;
  if missing(medAcct)                     then antiArythMeds = .;
  if medAcct = 0                          then antiArythMeds = .;
  if medAcct = 1                          then antiArythMeds = 0;
  if medAcct = 2 & missing(antiArythMeds) then antiArythMeds = 0; 
  label  antiArythMeds = "Antiarrhythmic Medication Status (Y/N)";
  format antiArythMeds ynfmt.;
  run;
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
