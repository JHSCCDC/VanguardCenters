/* 
Overview:
    This program derives JHS visit 3 variables from the JHS analysis1 and/or raw JHS visit 3 datasets.
    Descriptions and rationale are in comments preceding each variable below. 

    For additional documentation, see /hcfa/JHS/VanguardCenters/data/Analysis Data/docs/dcri_derived1.doc 

    Specific documentation for dcri_derived3 is still underway. Here is a summary of differences from V1:
    
    1) As specified in the comments below, many of the V3 questions are phrased "Since your last exam, have you...?"
       Therefore, for the purpose of deriving the HF history/prevalence variable at visit 3, we rely on both current
       questions and visit 2 and 3 derived variables.
    2) The variable and dataset names are not always consistent across visits.
    3) There were no questions about coughing, phlegm or wheezing at exams 2 or 3 so we will rely on the exam 1 response. 
            
History:
            
    Created:  Melissa Greiner 4/08/2014
    Modifed:  MAG, 2/12/2015 - Prevalent HF at Visit 1 or Visit 2 will imply prevalent HF at visit 3



*/


libname jhs '/hcfa/JHS/VanguardCenters/data/Analysis Data/data';
libname v3 '/hcfa/JHS/VanguardCenters/data/Visit 3/data'; 
                        
libname v3fmt "/hcfa/JHS/VanguardCenters/data/Visit 3/formats";  
libname afmt "/hcfa/JHS/VanguardCenters/data/Analysis Data/data/formats";

options fmtsearch = (v3fmt afmt);
                        
%macro chgmiss(dovar, missto);
    if missing(&dovar) then &dovar = &missto;
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
from v3.medcodes)


group by subjid
order by subjid;

quit;

**NOTE: There are 253 people in the analysis3 dataset that were not in the analysis 2 dataset but were in the original analysis1;
**Therefore we must use the cummulative variables from both the derived1 and derived2 datasets below;

data dcri_derived3(keep=subjid chronic_lung asthma_any cough_phlegm_wheeze coronaryByp coronaryAngio angina pacemaker 
                        antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
                        betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
                        oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin
                        education_recode 
                        alc_prioryr alcday alcwk                         
                        hfhx hfhxdate hfhxyr gothenburg_score
                        self_angina self_chestpain swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy hftherapy_ever
                        cvdhx afib cvdhx pacemaker);
merge 
    jhs.analysis3(in=ina3 keep=subjid medAcct alcd alcw miecg chdhx afib cvdhx visitdate) 
    jhs.dcri_derived1(keep=subjid coronaryByp coronaryAngio anychd chronic_lung asthma_any angina swollen_leg 
                      nocturnal_dyspnea cough_phlegm_wheeze hfhx gothenburg_score
                      rename=(coronaryByp=coronaryBypv1 coronaryAngio=coronaryAngiov1 anychd=anychdv1 chronic_lung=chronic_lungv1 
                      asthma_any=asthma_anyv1 angina=anginav1 swollen_leg=swollen_legv1 nocturnal_dyspnea=nocturnal_dypneav1
                      cough_phlegm_wheeze=cough_phlegm_wheezev1 hfhx=hfhxv1 gothenburg_score=gothenburg_scorev1))
    jhs.dcri_derived2(keep=subjid coronaryByp coronaryAngio anychd chronic_lung asthma_any angina swollen_leg 
                      nocturnal_dyspnea hfhx gothenburg_score
                      rename=(coronaryByp=coronaryBypv2 coronaryAngio=coronaryAngiov2 anychd=anychdv2 chronic_lung=chronic_lungv2 
                      asthma_any=asthma_anyv2 angina=anginav2 swollen_leg=swollen_legv2 nocturnal_dyspnea=nocturnal_dypneav2
                      hfhx=hfhxv2 gothenburg_score=gothenburg_scorev2))
    v3.ecgb(keep=subjid ecgb22)  
    allmeds
    v3.pfhb(keep=subjid pfhb9a pfhb10a)            
    v3.mhxc(keep=subjid mhxc1 mhxc2 mhxc3 mhxc4 mhxc5 mhxc6 mhxc9 mhxc10 mhxc41 mhxc42 mhxc43 mhxc45a mhxc47a mhxc10 mhxc24 mhxc25)
    v3.msrc(keep=subjid msrc29e)
    v3.pdsb(keep=subjid pdsb17a pdsb17b)
    v3.adrb(keep=subjid adrb1 adrb2a adrb2b adrb3)
    
; by subjid;

if ina3;


*Dichotomous medical history variables imputed to no when missing (missing/unknown <5%);

*Has a doctor said you had chronic lung disease since your last exam? Include prior variables;
chronic_lung = (PFHb9A=1 or chronic_lungv1 or chronic_lungv2);

*Has doctor said you have asthma since your last exam? Include prior variables;
asthma_any = (PFHb10A=1 or asthma_anyv1 or asthma_anyv2);

*NOTE: Coughing/phlegm/wheeze questions are not available for visits 2 or 3 so can only use from visit 1; 
      
cough_phlegm_wheeze = cough_phlegm_wheezev1;
       
*Pacemaker implanted based on atrioventricular conduction Minnesota code; 
pacemaker = (ecgb22=8);
            
*Our medication interpretation differs slightly from varibles derived by JHS;
*****If there was evidence of the medication in the files, set to yes (1)
*****If there was no evidence of the medicaiton in the medication file:
********a) If the JHS medAcct variable indicates participant brought all meds or does not take any meds, we will set to no (0);
********b) Otherwise (incomplete or no meds brought to exam), we will set to missing category (2);
        
array meds  antidepress antihypertens antihypertenscomb adrenolytic antihyperlipid anticoag antiplat cox2inhib
           betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
           oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin;

do over meds;

    if (meds ne 1) then do;
        if medAcct>0 then meds=0;
        else meds=2;
    end;
end;
            
*Self-reported HF medication;   
hfmed = (msrc29e=1);
            
            
*ARIC modified Gotheburg to derive history of heart failure;
 
******Note: These questions are since your last JHS visit so this needs to be cumulative over time; 
******We will also include the prior variables so variables capture surgery ever;  
    coronaryByp = (mhxc45a=1 or coronaryBypv1 or  coronaryBypv2);
    coronaryAngio = (mhxc47a=1 or coronaryAngiov1 or coronaryAngiov2);

*NOTE: I checked all of the ARIC questions below and matches exactly to the JHS derived variable chdhx;
*chdhx_alt = (pfhb4a=1 or mhxc10=2 or mhxc24=1 or mhxc25=1 or miecg=1); 
         
*Including anychd from visists 1 or 2 since visist 3 questions are since last exam;

    anychd = (chdhx or coronaryByp or coronaryAngio or anychdv1 or anychdv2);

*Flag these from current exam;    
    self_angina = (mhxc9=1 and mhxc10=1);
    self_chestpain = (mhxc1=1 and (mhxc2=1 or mhxc3=1) and mhxc4=1 and mhxc5=1 and mhxc6=1);

*Questions phrased as since last exam so also include prior angina from visits 1 or 2;    
    angina = (self_angina or self_chestpain or anginav1 or anginav2);
            
*Swelling of feet or ankles, AND it comes down overnight;
    swollen_leg = ((mhxc42=1 and mhxc43=1) or swollen_legv1 or swollen_legv2);
            
*Nocturnal dyspea;
    nocturnal_dyspnea = (mhxc41=1 or nocturnal_dypneav1 or nocturnal_dypneav2);
 
*NOTE: Coughing/phlegm/wheeze questions are not available for visists 2 or 3 so can only use from visit 1;                

    cardiac = sum(anychd, angina, swollen_leg, nocturnal_dyspnea, afib);
    pulmonary = sum(chronic_lung, asthma_any, cough_phlegm_wheeze);
    hftherapy = sum((digoxin=1), (diuretic=1));

     *Most Gothenburg visit 2 assessment is necessarily cumulative from visit 1 given nature of questions;
    *However, there are some cases where HF medication status changes;
    *Discussed with Arun, and we agree it is best to have any prior found prevalent HF carry forward;
    
    hfhx = ((cardiac>0) and (pulmonary>0) and (hftherapy>0)) or hfhxv1 or hfhxv2;
   
    gothenburg_score = max(sum(cardiac, pulmonary, hftherapy_ever), gothenburg_scorev1, gothenburg_scorev2);

    
    *For convenience, retain the current visit date and year;
    hfhxdate = visitdate;
    
    hfhxyr = year(visitdate);
    
    format hfhxdate date9.;


/*
*   We shared a new algorithm with JHS to derive education and they recoded in the 12/2013 release.
*   However, there are still slight differences in frequency counts because they did not reverse the order of assignment
*   so that highest level of education is recorded first. 
*   For example, there are a handful who received a GED (question pdsb18b) but later got college degree.
*   We think that highest level achieved should be coded.
*   Our version still works with their format edu.;
*/
            
select;
when(pdsb17a >= 19) education_recode=9;
when(pdsb17a = 18) education_recode=8;
when(pdsb17a = 17) education_recode=7;
when(pdsb17a = 16) education_recode=6;
when(pdsb17a = 15) education_recode=5;
when(pdsb17a = 14) education_recode=4;
when(pdsb17b = 1) education_recode=3;
when(12 <= pdsb17a <= 13) education_recode=2;
when(0<= pdsb17a <= 11) education_recode=1;
otherwise education_recode=.;
end;

*Impute missing eduction to most common category 1 (less than high school);
%chgmiss(education_recode, 1);   
                        
****NOTE: ALL of the physical activity questions have changed so may revisit this later;

  
*Derive variables for alcohol use in the past 12 months;

*Any alcohol based on question ADRB1: Ever consumed alcoholic beverages;
    
alc_prioryr = (adrb1=1);
  
*When question ADRB1 was not answered yes, the other alcohol questions should have been skipped so impute to zero;
      
if not alc_prioryr then do;
    alcwk=0;
    alcday=0;
end;
else do;
    if adrb2b=1 then alcwk = min(adrb2a, 7)*adrb3;     
    else if adrb2b=2 then alcwk = (min(adrb2a, 30)*adrb3)/4;
    else if adrb2b=3 then alcwk = (min(adrb2a, 365)*adrb3)/52;
       
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
label asthma_any = 'DCRI Derived: Self-reported asthma';

label pacemaker = 'DCRI Derived: Pacemaker implanted based on atrioventricular conduction defect Minnesota code 6-8, paced';
label education_recode = 'DCRI Derived: Highest level of education achieved'; 
*label activity = 'DCRI Derived: Did you participate in physical activities in the last year?';     
*label activehrswk = 'DCRI Derived: Average number of hours of physical activity per week in the last year';          
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
label hfhx = 'DCRI Derived: History of Heart Failure based on ARIC modified Gothenburg criteria at exam 3';
label hfhxdate = 'DCRI Derived: Visit date for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 3';    
label hfhxyr = 'DCRI Derived: Visit year for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 3';      
label gothenburg_score = 'DCRI Derived: ARIC Modified Gothenburg HF score';
label nocturnal_dyspnea = 'DCRI Derived: Self-reported nocturnal dyspnea';
label swollen_leg = 'DCRI Derived: Self-reported swollen legs at end of day';
label cough_phlegm_wheeze = 'DCRI Derived: Self-reported chronic coughing, phlegm or wheezing from exam 1 (missing at exam 2/3)';  
label anychd = 'DCRI Derived: Any cornary heart disease per JHS variable (self-report or MI on ECG) or cornary bypass or angiography';
run;

              
proc univariate data=dcri_derived3;
var alcday alcwk;
run;
                    
TITLE 'Drinking among those who drank';
proc univariate data=dcri_derived3;
var alcday alcwk;
where alc_prioryr=1;
run;    
                        
proc freq data=dcri_derived3;
tables chronic_lung asthma_any cough_phlegm_wheeze coronaryByp coronaryAngio angina
       antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
       betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
       oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin 
       education_recode 
       self_angina*self_chestpain angina swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy 
       hfhx gothenburg_score self_angina self_chestpain swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy hftherapy_ever
       pacemaker 
       / missing;


run;

*Final cleanup, delete temporary variables;
data jhs.dcri_derived3;
set dcri_derived3(drop=self_angina self_chestpain cardiac pulmonary hftherapy hftherapy_ever
                      cvdhx afib);                        
                        
run;
                        
proc contents varnum data=jhs.dcri_derived3; run;

TITLE 'Print a few observations';                   
proc print data=jhs.dcri_derived3(obs=100); run;                        
