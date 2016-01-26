/* 
Overview:
    This program derives JHS visit 1 variables from the JHS analysis1 and/or raw JHS visit 1 datasets.
    Descriptions and rationale are in comments preceding each variable below. 

    For additional documentation, see /hcfa/JHS/VanguardCenters/data/Analysis Data/docs/dcri_derived1.doc  
            
History:
            
    Created:  Melissa Greiner 3/14/2014
    Modified: MAG, 5/15/2015, added new medication classes



*/


libname jhs '/hcfa/JHS/VanguardCenters/data/Analysis Data/data';
libname v1 '/hcfa/JHS/VanguardCenters/data/Visit 1/data'; 
                        
libname v1fmt "/hcfa/JHS/VanguardCenters/data/Visit 1/data/formats";
libname afmt "/hcfa/JHS/VanguardCenters/data/Analysis Data/data/formats";

options fmtsearch = (v1fmt afmt);
                        
%macro chgmiss(dovar, missto);
    if missing(&dovar) then &dovar = &missto;
%mend;
  
%macro framingham_score(inds, outds);

data &outds(drop=agecat msbpcat fsbpcat fantihyper_score);
set &inds;

*Create age categories per the Framingham stroke risk score;
select;
when(age<57) agecat=0;
when(age<60) agecat=1;
when(age<63) agecat=2;
when(age<66) agecat=3;
when(age<69) agecat=4;
when(age<72) agecat=5;
when(age<75) agecat=6;
when(age<78) agecat=7;
when(age<81) agecat=8;
when(age<84) agecat=9;
otherwise agecat=10;
end;

*NOTE: SBP is missing for <.5% so just impute to median value (125) for this calculation;
%chgmiss(sbp, 125);
                    
*Create a male specific SBP categories per the Framingham stroke risk score;
select;
when(sbp<106) msbpcat=0;
when(sbp<117) msbpcat=1;
when(sbp<127) msbpcat=2;
when(sbp<138) msbpcat=3;
when(sbp<149) msbpcat=4;
when(sbp<160) msbpcat=5;
when(sbp<171) msbpcat=6;
when(sbp<182) msbpcat=7;
when(sbp<192) msbpcat=8;
when(sbp<203) msbpcat=9;
otherwise msbpcat=10;
end;

*Create a female specific SBP categories per the Framingham stroke risk score;
select;
when(sbp<105) fsbpcat=0;
when(sbp<115) fsbpcat=1;
when(sbp<125) fsbpcat=2;
when(sbp<135) fsbpcat=3;
when(sbp<145) fsbpcat=4;
when(sbp<155) fsbpcat=5;
when(sbp<165) fsbpcat=6;
when(sbp<175) fsbpcat=7;
when(sbp<185) fsbpcat=8;
when(sbp<195) fsbpcat=9;
otherwise fsbpcat=10;
end;

*Define female scoring for hypertension drug therapy based on female SBP category;
*Note that for the purpose of this score we will have to assume no for missing antihypertensive therapy;
select;
when(fsbpcat=0) fantihyper_score=6;
when(fsbpcat in (1,2)) fantihyper_score=5;
when(fsbpcat=3) fantihyper_score=4;
when(fsbpcat in (4,5)) fantihyper_score=3;
when(fsbpcat=6) fantihyper_score=2;
when(fsbpcat in (7,8)) fantihyper_score=1;
otherwise fantihyper_score=0;
end;

*Calculate the sex specific Framingham risk score;
if sex="Male" then 
framingham_stroke_score = agecat + msbpcat + 2*(antihypertens=1) + 2*(diabetes=1) + 3*(currentsmoker=1) + 3*(cvdhx=1) + 4*(afib=1) + 6*(lvh_any);

else
framingham_stroke_score = agecat + fsbpcat + (antihypertens=1)*fantihyper_score + 3*(diabetes=1) + 3*(currentsmoker=1) + 2*(cvdhx=1) 
                          + 6*(afib=1) + 4*(lvh_any);


run;

%mend;

proc sql;

create table allmeds as
select
subjid,
max(antidepress) as antidepress,
max(antihypertens) as antihypertens,
max(antihypertenscomb) as antihypertenscomb,
max(adrenolytic) as adrenolytic,                        
max(antihyperlipid) as antihyperlipid,
max(anticoag) as anticoag,
max(antiplat) as antiplat,
max(cox2inhib) as cox2inhib,
max(betablocker) as betablocker,
max(alphablocker) as alphablocker,
max(vasodilator) as vasodilator,
max(nitrate) as nitrate,
max(calcblocker) as calcblocker,         
max(calcblockerbroad) as calcblockerbroad, 
max(diuretic) as diuretic, 
max(beta_diuretic) as beta_diuretic, 
max(antiarrhythmic) as antiarrhythmic, 
max(statin) as statin, 
max(oraldiab) as oraldiab, 
max(insulin) as insulin, 
max(hrt) as hrt,
max(loopdiur) as loopdiur,  
max(thiazdiur) as thiazdiur,  
max(potassdiur) as potassdiur,  
max(combdiur) as combdiur,                          
max(acearb) as acearb, 
max(digoxin) as digoxin
from
(
select 
subjid, 
case when( substr(tccode,1,6) in ('580000', '580300', '581000', '581200', '581600','582000', '583000')) then 1 else 0 end as antidepress,
case when( substr(tccode,1,2) ='36') then 1 else 0 end as antihypertens,
case when( substr(tccode,1,4) ='3699') then 1 else 0 end as antihypertenscomb,    
case when( substr(tccode,1,4) ='3620') then 1 else 0 end as adrenolytic,                            
case when( substr(tccode,1,2) ='39') then 1 else 0 end as antihyperlipid,
case when( substr(tccode,1,2) ='83') then 1 else 0 end as anticoag,
case when( substr(tccode,1,4) ='8515') then 1 else 0 end as antiplat,
case when( substr(tccode,1,6)='661005') then 1 else 0 end as cox2inhib,
case when( substr(tccode,1,2) ='33') then 1 else 0 end as betablocker,    
case when( substr(tccode,1,6) ='363000') then 1 else 0 end as alphablocker,  
case when( substr(tccode,1,4) ='3640') then 1 else 0 end as vasodilator,
case when( substr(tccode,1,6) ='321000') then 1 else 0 end as nitrate, 
case when( substr(tccode,1,2) ='34') then 1 else 0 end as calcblocker,        
case when( substr(tccode,1,2) ='34' or substr(tccode,1,6)='369915' or substr(tccode,1,6)='369925') then 1 else 0 end as calcblockerbroad,
case when( substr(tccode,1,2) ='37') then 1 else 0 end as diuretic,    
case when( substr(tccode,1,6) ='369920') then 1 else 0 end as beta_diuretic,    
case when( substr(tccode,1,2) ='35') then 1 else 0 end as antiarrhythmic,
case when( substr(tccode,1,4) ='3940') then 1 else 0 end as statin,
case when( substr(tccode,1,2) ='27' and substr(tccode,3,2) ne '10') then 1 else 0 end as oraldiab, 
case when( substr(tccode,1,4) ='2710') then 1 else 0 end as insulin,
case when( substr(tccode,1,2) in ('24', '25', '26')) then 1 else 0 end as hrt, 
case when( substr(tccode,1,6)='372000') then 1 else 0 end as loopdiur,
case when( substr(tccode,1,6)='376000') then 1 else 0 end as thiazdiur,
case when( substr(tccode,1,6)='375000') then 1 else 0 end as potassdiur,
case when( substr(tccode,1,4)='3799') then 1 else 0 end as combdiur,                        
case when( substr(tccode,1,6) in ('361000', '361500')) then 1 else 0 end as acearb,
case when( substr(tccode,1,6)='312000') then 1 else 0 end as digoxin
from v1.medcodes)


group by subjid
order by subjid;

quit;



data dcri_derived1(keep=subjid chronic_lung asthma_any lvh_qual lvh_any orig_lvh_any lvm2d lvm2d_index coronaryByp coronaryAngio anychd angina hfhx pacemaker 
                        antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
                        betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
                        oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin
                        education_recode activity activehrswk 
                        alc_prioryr alcday alcwk                         
                        hfhx hfhxdate hfhxyr gothenburg_score
                        self_angina self_chestpain swollen_leg nocturnal_dyspnea cough_phlegm_wheeze cardiac pulmonary hftherapy
                        diabetes currentsmoker chdhx afib cvdhx age sbp sex hfmed);
merge 
    jhs.analysis1(in=ina1 keep=subjid lvh medAcct alcd alcw miecg chdhx afib diabetes currentsmoker cvdhx age sbp sex height visitdate) 
    v1.ecga_adj(keep=subjid ecga15 ecga23)  
    allmeds
    v1.pfha(keep=subjid pfha4a pfha9a pfha10a)
    v1.rpaa(keep=subjid rpaa1 rpaa6 rpaa8 rpaa9 rpaa13 rpaa14)
    v1.mhxa(keep=subjid  mhxa8 mhxa9 mhxa10 mhxa11 mhxa12 mhxa13 mhxa16 mhxa17 mhxa30 mhxa31 mhxa32 
            mhxa48 mhxa49 mhxa50 mhxa52a mhxa54a)
    v1.msra(keep=subjid msra30e)
    v1.pdsa(keep=subjid pdsa18a pdsa18b)
    v1.paca(keep=subjid paca19 paca23)
    v1.echa(keep=subjid echa21 echa58 rename=(echa58=lvm2d)) 
    v1.adra(keep=subjid adra1 adra2a adra2b adra3)
    
; by subjid;

if ina1;


*Dichotomous medical history variables imputed to no when missing (missing/unknown <5%);

*Has a doctor said you had chronic lung disease?;
chronic_lung = (PFHa9A='Y');

*Has doctor said you have asthma? OR Ever had asthma? and Confirmed by doctor?;
asthma_any = (PFHa10A='Y' or (rpaa13='Y' and rpaa14='Y'));


*NOTE: The JHS derived Left ventricular hypertrophy is 34% missing due to high missing of quantitative LV Mindex from echo;
*We will derive using their quantitative variable when available (lvh);
*Otherwise, qualitative echo LVH assessment variable echa21 (0=None 1= Mild 2=Mod 3=Severe 9=Cannot Assess) to lower missing;

*Qualitative LVH;
lvh_qual = (echa21 in ('1','2','3')); 
  
*Saving lvh_any based on the original algorthm;

*UPDATED algorithm 2/3/2015 per Rob and Arun;
*A reviewer for our QRS manuscript pointed out that there is a 2-D LV mass variable that is only 5% missing;
*We will derive LVH from quantitative 2-D LV mass when available, then from quantitative M-Mode and 
*finally based on qualitative evidence;
    
*First save lvh from original algorithm;
if not missing(lvh) then orig_lvh_any=lvh;
else orig_lvh_any=lvh_qual;
    
if not missing(lvm2d) and not missing(height) then do;
    lvm2d_index = lvm2d/((height/100)**2.7);
    lvh_any=(lvm2d_index>51);
end;
else if not missing(lvh) then lvh_any=lvh;
else lvh_any=lvh_qual;

   
*Pacemaker implanted based on atrioventricular conduction Minnesota code; 
pacemaker = (ecga23=8);
               
*Our medication interpretation differs slightly from varibles derived by JHS;
*****If there was evidence of the medication in the files, set to yes (1)
*****If there was no evidence of the medicaiton in the medication file:
********a) If the JHS medAcct variable indicates participant brought all meds or does not take any meds, we will set to no (0);
********b) Otherwise (incomplete or no meds brought to exam), we will set to missing category (2);
        
array meds antidepress antihypertens antihypertenscomb adrenolytic antihyperlipid anticoag antiplat cox2inhib
           betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
           oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin;

do over meds;

    if (meds ne 1) then do;
        if medAcct>0 then meds=0;
        else meds=2;
    end;
end;
            
*Self-reported HF medication;   
hfmed = (msra30e='Y');
            
            
*ARIC modified Gotheburg to derive history of heart failure;
    
    coronaryByp = (mhxa52a='Y');
    coronaryAngio = (mhxa54a='Y');
 
*NOTE: I checked all of the ARIC questions below and matches exactly to the JHS derived variable chdhx;
*chdhx_alt = (pfha4a='Y' or mhxa17='H' or mhxa31='H' or mhxa32='Y' or miecg=1); 
                        
    anychd = (chdhx or coronaryByp or coronaryAngio);
   
    self_angina = (mhxa16='Y' and mhxa17='A');
    self_chestpain = (mhxa8='Y' and (mhxa9='Y' or mhxa10='Y') and mhxa11='S' and mhxa12='R' and mhxa13='L');

    angina = (self_angina or self_chestpain);
          
*Swelling of feet or ankles, AND it comes down overnight;
    swollen_leg = (mhxa49='Y' and mhxa50='Y');

           
*Nocturnal dyspea;
    nocturnal_dyspnea = (MHXA48='Y');
         
    cough_phlegm_wheeze = (rpaa1='Y' or rpaa6='Y' or rpaa8='Y' or rpaa9='Y');

    cardiac = sum(anychd, angina, swollen_leg, nocturnal_dyspnea, afib);
    pulmonary = sum(chronic_lung, asthma_any, cough_phlegm_wheeze);
    hftherapy = sum((digoxin=1), (diuretic=1));

    hfhx = ((cardiac>0) and (pulmonary>0) and (hftherapy>0));
    gothenburg_score = sum(cardiac, pulmonary, hftherapy);

    *For convenience, retain the current visit date and year;
    hfhxdate = visitdate;
    
    hfhxyr = year(visitdate);
    
    format hfhxdate date9.;


/*
*   We shared a new algorithm with JHS to derive education and they recoded in the 12/2013 release.
*   However, there are still slight differences in frequency counts because they did not reverse the order of assignment
*   so that highest level of education is recorded first. 
*   For example, there are a handful who received a GED (question pdsa18b) but later got college degree.
*   We think that highest level achieved should be coded.
*   Our version still works with their format edu.;
*/
            
select;
when(pdsa18a >= 19) education_recode=9;
when(pdsa18a = 18) education_recode=8;
when(pdsa18a = 17) education_recode=7;
when(pdsa18a = 16) education_recode=6;
when(pdsa18a = 15) education_recode=5;
when(pdsa18a = 14) education_recode=4;
when(pdsa18b = "Y") education_recode=3;
when(12 <= pdsa18a <= 13) education_recode=2;
when(0<= pdsa18a <= 11) education_recode=1;
otherwise education_recode=.;
end;

*Impute missing eduction to most common category 1 (less than high school);
%chgmiss(education_recode, 1);   
                         
*Did you participate in physical activities in the last year;
            
activity = (paca19='Y');
 
/*
    Average number of activity hours/week:
        0: None (confirmed that missing aligns with no physical activity listed on question paca19)
        1: <1 hour/week
        2: 1- <2 hours/week
        3: 2- <3 hours/week
        4: 3- <4 hours/week
        5: 4+ hours/week
*/

select;
when(missing(paca23)) activehrswk=0;
when(paca23='A') activehrswk=1;
when(paca23='B') activehrswk=2;
when(paca23='C') activehrswk=3;
when(paca23='D') activehrswk=4;
when(paca23='E') activehrswk=5;
end;
    
         
  
*Derive variables for alcohol use in the past 12 months;

*Any alcohol based on question ADRA1: Ever consumed alcoholic beverages;
    
alc_prioryr = (adra1='Y');
    
*When question ADRA1 was not answered yes, the other alcohol questions should have been skipped so impute to zero;
      
if not alc_prioryr then do;
    alcwk=0;
    alcday=0;
end;
else do;
    if adra2b='W' then alcwk = min(adra2a, 7)*adra3;     
    else if adra2b='M' then alcwk = (min(adra2a, 30)*adra3)/4;
    else if adra2b='Y' then alcwk = (min(adra2a, 365)*adra3)/52;
       
    alcday = alcwk/7;
end;
    
*Impute the low remaining missing (n=93) to the median of 0 drinks per week;
%chgmiss(alcwk, 0);
    
*Impute the low remaining missing (n=93) to the median of 0 drinks per day;
%chgmiss(alcday, 0);    

*Similar to the JHS CC definition, defining a broad class of blood pressure medication including;
*antihypertensive, betablocker, calcium channel blocker or diuretic;

if (antihypertens=1 or betablocker=1 or calcblocker=1 or diuretic=1) then broadbpmed=1;
else broadbpmed = max(antihypertens, betablocker, calcblocker, diuretic);
    
label chronic_lung = 'DCRI Derived: Self-reported chronic lung disease';
label asthma_any = 'DCRI Derived: Any Self-reported asthma told by doctor';
label lvh_qual = 'DCRI Derived: Left ventricular hypertrophy based on qualitative echo assessment';
label lvh_any = 'DCRI Derived: Left ventricular hypertrophy based on quantitative 2-D or M-mode LV Mass if available, otherwise qualitative echo assessment';
label orig_lvh_any = 'DCRI Derived: Original algorithm Left ventricular hypertrophy based on quantitative M-mode LV Mass if available, otherwise qualitative echo assessment'; 
label lvm2d = 'DCRI Derived: 2-D Left Ventricular Mass';
label lvm2d_index = 'DCRI Derived: 2-D Left Ventricular Mass Indexed by height^2.7';     
label anychd = 'DCRI Derived: Any cornary heart disease per JHS variable (self-report or MI on ECG) or cornary bypass or angiography';
label pacemaker = 'DCRI Derived: Pacemaker implanted based on atrioventricular conduction defect Minnesota code 6-8, paced';
label education_recode = 'DCRI Derived: Highest level of education achieved'; 
label activity = 'DCRI Derived: Did you participate in physical activities in the last year?';     
label activehrswk = 'DCRI Derived: Average number of hours of physical activity per week in the last year';          
label alc_prioryr = 'DCRI Derived: Any alcohol use in the prior 12 months';
label alcday = 'DCRI Derived: Average drinks per day in the last 12 months';    
label alcwk = 'DCRI Derived: Average drinks per week in the last 12 months';
label antidepress= 'DCRI Derived: Antidepressant medication';
label antihypertens= 'DCRI Derived: Antihypertensive medicatiton';
label antihypertenscomb= 'DCRI Derived: Antihypertensive combination medicatiton';        
label adrenolytic= 'DCRI Derived: Adrenolytic Antihypertensive medicatiton';                   
label broadbpmed= 'DCRI Derived: Broad class of blood pressure medication including antihypertensive, beta-blocker, calcium channel blocker or diuretic';
label antihyperlipid= 'DCRI Derived: Antihyperlipdemic medication';
label anticoag= 'DCRI Derived: Anticoagulant medication';
label antiplat= 'DCRI Derived: Antiplatelet medication';
label cox2inhib= 'DCRI Derived: Cyclooxygenase [COX-2] inhibitor medication';
label betablocker= 'DCRI Derived: Betablocker medication';
label alphablocker= 'DCRI Derived: Alphablocker medication';
label vasodilator= 'DCRI Derived: Vasodilator medication';
label nitrate= 'DCRI Derived: Nitrate medication';        
label calcblocker= 'DCRI Derived: Calcium channel blocker medication';
label calcblockerbroad= 'DCRI Derived: Calcium channel blocker or CCB combination medication';        
label diuretic= 'DCRI Derived: Diuretic medication';
label antiarrhythmic='DCRI Derived: Antiarrhythmic medication';
label statin= 'DCRI Derived: Statin medication';
label oraldiab= 'DCRI Derived: Oral diabetic medication';
label insulin= 'DCRI Derived: Insulin medication';
label hrt= 'DCRI Derived: Hormone replacement therapy medication';
label loopdiur='DCRI Derived: Loop diuretic medication';
label thiazdiur='DCRI Derived: Thiazide diuretic medication';        
label potassdiur='DCRI Derived: Potassium-sparing diuretic medication';
label combdiur='DCRI Derived: Combination diuretic medication';   
label beta_diuretic='DCRI Derived: Beta-blocker and Diuretic Combination medication';                 
label acearb= 'DCRI Derived: ACE-inhibitor or Angiotensin II receptor antagonist medication';
label digoxin= 'DCRI Derived: Digoxin medication';
label hfmed= 'DCRI Derived: Self-reported HF medication usage';


label angina = 'DCRI Derived: Self-reported angina based on ARIC modified Gothenburg criteria questions';
label coronaryByp = 'DCRI Derived: Self-reported history of Coronary Bypass Surgery';
label coronaryAngio = 'DCRI Derived: Self-reported history of coronary angiography';
label hfhx = 'DCRI Derived: History of Heart Failure based on ARIC modified Gothenburg criteria at exam 1';
label hfhxdate = 'DCRI Derived: Visit date for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 1';    
label hfhxyr = 'DCRI Derived: Visit year for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 1';        
label gothenburg_score = 'DCRI Derived: ARIC Modified Gothenburg HF score';
label cough_phlegm_wheeze = 'DCRI Derived: Self-reported chronic coughing, phlegm or wheezing';
label nocturnal_dyspnea = 'DCRI Derived: Self-reported nocturnal dyspnea';
label swollen_leg = 'DCRI Derived: Self-reported swollen legs at end of day';
label cardiac = 'DCRI Derived: Cardiac component score for Gothenburg algorithm';
label pulmonary = 'DCRI Derived: Pulmonary component score for Gothenburg algorithm';
label hftherapy = 'DCRI Derived: HF Therapy component score for Gothenburg algorithm';

run;

              
%framingham_score(dcri_derived1, jhs.dcri_derived1);

proc univariate data=jhs.dcri_derived1;
var alcday alcwk framingham_stroke_score;
run;
                    
proc univariate data=jhs.dcri_derived1;
var framingham_stroke_score;
class sex;
run;

TITLE 'Drinking among those who drank';
proc univariate data=jhs.dcri_derived1;
var alcday alcwk;
where alc_prioryr=1;
run;    
                        
proc freq data=jhs.dcri_derived1;
tables chronic_lung asthma_any cough_phlegm_wheeze lvh_qual lvh_any  coronaryByp coronaryAngio angina hfhx chdhx afib pacemaker 
       antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
       betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
       oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin 
       education_recode activity activehrswk alc_prioryr alcday alcwk
       self_angina*self_chestpain angina swollen_leg nocturnal_dyspnea cough_phlegm_wheeze cardiac pulmonary hftherapy 
       hfhx gothenburg_score self_angina self_chestpain swollen_leg nocturnal_dyspnea cough_phlegm_wheeze cardiac pulmonary hftherapy hfmed hfhx*hfmed
       hftherapy*hfmed lvh_any*orig_lvh_any
       / missing;

format afib chdhx;
format alcday alcwk oops.;
run;

TITLE 'Check additional HF that might be found by including self-report HF meds flag';
proc sql;
select count(*) from 
jhs.dcri_derived1
where hftherapy=0 and
      hfmed=1 and
      cardiac>0 and
      pulmonary>0;

quit;

*Final cleanup, delete temporary variables;
data jhs.dcri_derived1;
set jhs.dcri_derived1(drop=self_angina self_chestpain 
                      diabetes currentsmoker chdhx cvdhx afib age sbp sex);                        
                        
label framingham_stroke_score = 'DCRI Derived: Framingham stroke risk score';
run;
                        
proc contents varnum data=jhs.dcri_derived1; run;
                   
                        
