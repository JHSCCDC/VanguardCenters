*********************************************************************;
************** Section 14: Non-adjudicated Stroke *******************;
*********************************************************************;

title "Section 14: Non-Adjudicated Stroke";

*SSFA;
data include1; *SSFA;
  set jhsV1.ssfa(keep = subjid ssfa1   ssfa25 ssfa20 
                           ssfa14 ssfa11a ssfa7  ssfa3);
  by subjid;

  *Create renamed duplicates for formulas;
  spchlossV1  = ssfa3; 
  vislossV1   = ssfa7;
  dblvisV1    = ssfa11a;
  numbV1      = ssfa14;
  paraV1      = ssfa20;
  dizzyV1     = ssfa25;
  strokeHxAv1 = ssfa1;  
  run;

*PFHA;
data include2; *PFHA;
  set jhsV1.pfha(keep = subjid pfha5a);
  by subjid;

  *Create renamed duplicates for formulas;
  strokeHxBv1 = pfha5a; 
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
  proc freq data = include; tables inc1*inc2 /missing; run;
  proc print data = include(where = (chkobs > 1)); run;
  */
  data include; *Drop temporary variables;
    set include; 
    drop inc1 inc2 chkobs; 
    run;

*Create variables;
data include; *Create variables;
  set include; 
  by subjid;

  *Variable: speechLossEver;
  spchlossV2 = ' ';
  spchlossV3 = ' ';

  spchloss = 'N';
  if (spchlossV1 = 'Y'    | spchlossV2 = 1      | spchlossV3 = 2)     then spchloss = 'Y';
  if  missing(spchlossV1) & missing(spchlossV2) & missing(spchlossV3) then spchloss = .;

  if spchloss = 'N' then speechLossEver = 0; else 
  if spchloss = 'Y' then speechLossEver = 1; else 
  speechLossEver = .;
  label   speechLossEver = "History of Speech Loss"; 
  format  speechLossEver ynfmt.;

  *Variable: visionLossEver;
  vislossV2 = ' ';
  vislossV3 = ' ';

  visloss = 'N';
  if (vislossV1 = 'Y'    | vislossV2 = 1      | vislossV3 = 1)     then visloss = 'Y';
  if  missing(vislossV1) & missing(vislossV2) & missing(vislossV3) then visloss = .;

  if visloss = 'N' then visionLossEver = 0; else
  if visloss = 'Y' then visionLossEver = 1; else
  visionLossEver = .;
  label   visionLossEver = "History of Sudden Loss of Vision"; 
  format  visionLossEver ynfmt.;

  *Variable: doubleVisionEver;
  dblvisV2 = ' ';
  dblvisV3 = ' ';

  dblvis = 'N';
  if (dblvisV1 = 'Y'    | dblvisV2 = 1      | dblvisV3 = 1)     then dblvis = 'Y';
  if  missing(dblvisV1) & missing(dblvisV2) & missing(dblvisV3) then dblvis = .;

  if dblvis = 'N' then doubleVisionEver = 0; else
  if dblvis = 'Y' then doubleVisionEver = 1; else
  doubleVisionEver = .;
  label   doubleVisionEver = "History of Double Vision"; 
  format  doubleVisionEver ynfmt.;

  *Variable: numbnessEver;
  numbV2 = ' ';
  numbV3 = ' ';

  numb = 'N';
  if (numbV1 = 'Y'    | numbV2 = 1      | numbV3 = 1)     then numb = 'Y';
  if  missing(numbV1) & missing(numbV2) & missing(numbV3) then numb = .;

  if numb = 'N' then numbnessEver = 0; else
  if numb = 'Y' then numbnessEver = 1; else
  numbnessEver = .;
  label   numbnessEver = "History of Numbness"; 
  format  numbnessEver ynfmt.;

  *Variable: paralysisEver;
  paraV2 = ' ';
  paraV3 = ' ';

  para = 'N';
  if (paraV1 = 'Y'    | paraV2 = 1      | paraV3 = 1)     then para = 'Y';
  if  missing(paraV1) & missing(paraV2) & missing(paraV3) then para = .;

  if para = 'N' then paralysisEver = 0; else
  if para = 'Y' then paralysisEver = 1; else
  paralysisEver = .;
  label   paralysisEver = "History of Paralysis"; 
  format  paralysisEver ynfmt.;

  *Variable: dizzynessEver;
  dizzyV2 = ' ';
  dizzyV3 = ' ';

  dizzy = 'N';
  if (dizzyV1 = 'Y'    | dizzyV2 = 1      | dizzyV3 = 1)     then dizzy = 'Y';
  if  missing(dizzyV1) & missing(dizzyV2) & missing(dizzyV3) then dizzy = .;

  if dizzy = 'N' then dizzynessEver = 0; else
  if dizzy = 'Y' then dizzynessEver = 1; else
  dizzynessEver = .;
  label   dizzynessEver = "History of Dizziness"; 
  format  dizzynessEver ynfmt.;

  *Variable: strokeHx;

    *Subvariable: strokeHxA;
    strokeHxAv2 = .;
    strokeHxAv3 = ' ';

    strokeHxA = 0;
    if (strokeHxAv1 = 'Y'    | strokeHxAv2 = 1      | strokeHxAv3 = 1)     then strokeHxA = 1;
    if  missing(strokeHxAv1) & missing(strokeHxAv2) & missing(strokeHxAv3) then strokeHxA = .;
    format strokeHxA ynfmt.;

    *Subvariable: strokeHxB;
    strokeHxBv2 = .;
    strokeHxBv3 = ' ';

    strokeHxB = 0;
    if (strokeHxBv1 = 'Y'    | strokeHxBv2 = 1      | strokeHxBv3 = 1)     then strokeHxB = 1;
    if  missing(strokeHxBv1) & missing(strokeHxBv2) & missing(strokeHxBv3) then strokeHxB = .;
    format strokeHxB ynfmt.;


  strokeHx = 0;
  if strokeHxA  = 1     | strokeHxB  = 1     then strokeHx = 1;
  if missing(strokeHxA) & missing(strokeHxB) then strokeHx = .;
  label strokeHx = "History of Stroke";
  format strokeHx ynfmt.;
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

*Create keep macro variable for variables to retain in Analysis dataset (vs. analysis);
%let keep14stroke = speechLossEver  visionLossEver  doubleVisionEver  numbnessEver  paralysisEver  
                     dizzynessEver   strokeHx;

%put Section 14 Complete;
