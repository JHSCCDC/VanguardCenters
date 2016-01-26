** Program/project: JHS Meds;
** Original Author: JHS DCC;

*Set system options like do not center or put a date on output, etc.;
options nocenter nodate nonumber ps = 150 linesize = 100 nofmterr;

*Assign root directory (VanguardCenters);
**************************************************************************************************;
* YOU MUST CHANGE THIS TO YOUR DIRECTORY STRUCTURE!:
**************************************************************************************************;
*Example: x 'cd C:\JHS\VanGuardCenters';
x 'cd C:\Users\cblackshear\Box Sync\JHS\CC\JHS01-StudyData\VCworking\VanguardCenters'; *Change This!;

  *Primary VC data archetypes;
  libname analysis "data\Analysis Data\1-data"; *Analysis-Ready Datasets; 
  libname cohort   "data\Cohort\1-data";        *Ptcpt Contacts, Deaths, LTFU; 
  libname jhsV1    "data\Visit 1\1-data";       *"Raw" Exam 1 data; 
  libname jhsV2    "data\Visit 2\1-data";       *"Raw" Exam 2 data; 
  libname jhsV3    "data\Visit 3\1-data";       *"Raw" Exam 3 data; 

x 'cd data\Supplementary\SSN0002-Medications';
  libname  meds "1-data"; *Medications Datasets; 
  filename pgms "2-programs"; 

  *Read in format statements;
  %include pgms("0-1-formats.sas");

 options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats meds.formats);

*Create keep macro variable for variables to retain in Analysis dataset (vs. analysis);
%let keepmeds = medAcct       BPmeds         BPmedsSelf   DMmedsOral  DMmedsIns    DMMedType    
                DMmeds        statinMeds     hrtMeds	    hrtMedsSelf betaBlkMeds  calBlkMeds  
                diureticMeds  antiArythMeds; 


**************************************************************************************************;
** Step 1) Create datasets;
**************************************************************************************************;

  *Clear work directory & *Read in macro(s) used in data creation programs;
  %include pgms("1-0-data analysis.sas"); 

  *Create group classification analysis datasets *************************************************;

  *Instantiate cohort dataset;
  data medications; set cohort.visitdat(keep = subjid V1date V2date V3date); run;

  *Instantiate medication datasets;
  %medData(visit = V1);
  %medData(visit = V2);
  %medData(visit = V3);

  *Append Super-Groups;
  %createMeds(medName = antiInfective       , condition = (superGroup =  1)               , medClass = Anti-Infective Agents);
  %createMeds(medName = biological          , condition = (superGroup =  2)               , medClass = Biologicals);
  %createMeds(medName = antileoplastic      , condition = (superGroup =  3)               , medClass = Antineoplastic Agents);
  %createMeds(medName = endocrineMetabolic  , condition = (superGroup =  4)               , medClass = Endocrine & Metabolic Drugs);
  %createMeds(medName = cardiovascular      , condition = (superGroup =  5)               , medClass = Cardiovascular Agents);
  %createMeds(medName = respiratory         , condition = (superGroup =  6)               , medClass = Respiratory Agents);
  %createMeds(medName = gastrointestinal    , condition = (superGroup =  7)               , medClass = Gastrointestinal Agents);
  %createMeds(medName = genitourinary       , condition = (superGroup =  8)               , medClass = Genitourinary Products);
  %createMeds(medName = cns                 , condition = (superGroup =  9)               , medClass = Central Nervous System Drugs);
  %createMeds(medName = analgesicAnesthetic , condition = (superGroup = 10)               , medClass = Analgesics & Anesthetics);
  %createMeds(medName = neuromuscular       , condition = (superGroup = 11)               , medClass = Neuromuscular Drugs);
  %createMeds(medName = nutritional         , condition = (superGroup = 12)               , medClass = Nutritional Products);
  %createMeds(medName = hematological       , condition = (superGroup = 13)               , medClass = Hematological Agents);
  %createMeds(medName = topical             , condition = (superGroup = 14)               , medClass = Topical Products);
  %createMeds(medName = misc                , condition = (superGroup = 15)               , medClass = Miscellaneous Products);

  *Append Groups;
  %createMeds(medName = DMmeds              , condition = (tccode2  = 27)                  , medClass = Antidiabetic);
  %createMeds(medName = betaBlkMeds         , condition = (tccode2  = 33)                  , medClass = Beta Blockers);
  %createMeds(medName = calBlkMeds          , condition = (tccode2  = 34     | 
                                                           tccode6  = 369915 | 
                                                           tccode6  = 369925)              , medClass = Calcium Blockers);
  %createMeds(medName = antiArythMeds       , condition = (tccode2  = 35)                  , medClass = Antiarrhythmic);
  %createMeds(medName = BPmeds              , condition = (tccode2  = 36           & 
                                                           tccode3 ^= 363          &
                                                           tccode  ^= '3640002000')        , medClass = Antihypertensive);
  %createMeds(medName = diureticMeds        , condition = (tccode2  = 37     | 
                                                           tccode6  = 369918 |
                                                           tccode6  = 369920 |
                                                           tccode6  = 369940 | 
                                                           tccode6  = 369950 |
                                                           tccode6  = 369955 |
                                                           tccode6  = 369970 |
                                                           tccode6  = 369980 |
                                                           tccode6  = 369990)              , medClass = Diuretics);
  %createMeds(medName = lipidMeds           , condition = (tccode2  = 39)                  , medClass = Antihyperlipidemic);
  %createMeds(medName = hrtMeds             , condition = (24 <= tccode2 <= 26)            , medClass = Estrogens Contraceptives & Progestins);

  *Append Classes;
  %createMeds(medName = DMmedsOral          , condition = (tccode2  = 27 & tccode3 ^= 271) , medClass = Antidiabetic - Oral);
  %createMeds(medName = DMmedsIns           , condition = (tccode2  = 271)                 , medClass = Antidiabetic - Insulin);
  %createMeds(medName = ACEmeds             , condition = (tccode4  = 3610)                , medClass = Antihypertensive - ACE);
  %createMeds(medName = ARBmeds             , condition = (tccode4  = 3615)                , medClass = Antihypertensive - ARB);
  %createMeds(medName = statinMeds          , condition = (tccode4  = 3940)                , medClass = Antihyperlipidemic - HMG CoA Reductase Inhibitors (Statins));

  *Save final dataset;
  data meds.medicationsWide(label = "Medications Brought to Exam Visits by JHS Participants - Collected via 'Medication Survey (MSR) Form' "); set medications; drop V1date V2date V3date; run;
