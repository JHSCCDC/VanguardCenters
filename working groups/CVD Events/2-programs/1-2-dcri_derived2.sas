/* 
Overview:
    This program derives JHS visit 2 variables from the JHS analysis1 and/or raw JHS visit 2 datasets.
    Descriptions and rationale are in comments preceding each variable below. 

    For additional documentation, see /hcfa/JHS/VanguardCenters/data/Analysis Data/docs/dcri_derived1.doc  

    Specific documentation for dcri_derived3 is still underway. Here is a summary of differences from V1:
    
    1) As specified in the comments below, many of the V2 questions are phrased "Since your last exam, have you...?"
       Therefore, for the purpose of deriving the HF history/prevalence variable at visit 2, we rely on both current
       questions and visit 1 derived variables.
    2) The variable and dataset names are not always consistent across visits.
    3) There were no questions about coughing, phlegm or wheezing at exams 2 or 3 so we will rely on the exam 1 responses. 
    4) ECG was not performed at exam 2 so the chdhx variable was not derived in the JHS analysis2 dataset (MIecg, MI scar
       from ECG, is not available). We have derived an alternate variable, chdhx_alt, derived from the other available 
       exam 2 variables and chdhx from exam 1.
    5) Lack of ECG also means that atrial fibrillation was not assessed at exam 2. We use afib from exam 1 and current
       use of antiarrhythmic medications.
       
            
History:
            
    Created:  Melissa Greiner 4/09/2014
    Modifed:  MAG, 2/12/2015 - Prevalent HF at Visit 1 will imply prevalent HF at visit 2
    Modified: MAG, 5/15/2015 - Added new medication classes



*/


libname jhs '/hcfa/JHS/VanguardCenters/data/Analysis Data/data';
libname v2 '/hcfa/JHS/VanguardCenters/data/Visit 2/data'; 
                        
libname v2fmt "/hcfa/JHS/VanguardCenters/data/Visit 2/formats";  
libname v1fmt "/hcfa/JHS/VanguardCenters/data/Visit 1/formats";      
libname afmt "/hcfa/JHS/VanguardCenters/data/Analysis Data/data/formats";

options fmtsearch = (v2fmt v1fmt afmt);
                        
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
from v2.medcodes)


group by subjid
order by subjid;

quit;



data dcri_derived2(keep=subjid chronic_lung asthma_any coronaryByp coronaryAngio anychd angina cough_phlegm_wheeze
                        antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
                        betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
                        oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin
                        education_recode                      
                        chdhx_alt hfhx hfhxdate hfhxyr gothenburg_score
                        self_angina self_chestpain swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy
                        afibv1 afib_alt);
merge 
    jhs.analysis2(in=ina2 keep=subjid medAcct visitdate) 
    jhs.analysis1(keep=subjid afib chdhx rename=(afib=afibv1 chdhx=chdhxv1))
    jhs.dcri_derived1(keep=subjid education_recode coronaryByp coronaryAngio anychd chronic_lung asthma_any angina swollen_leg 
                      nocturnal_dyspnea cough_phlegm_wheeze hfhx gothenburg_score
                      rename=(coronaryByp=coronaryBypv1 coronaryAngio=coronaryAngiov1 anychd=anychdv1 chronic_lung=chronic_lungv1 
                      asthma_any=asthma_anyv1 angina=anginav1 swollen_leg=swollen_legv1 nocturnal_dyspnea=nocturnal_dypneav1
                      cough_phlegm_wheeze=cough_phlegm_wheezev1 hfhx=hfhxv1 gothenburg_score=gothenburg_scorev1))
    allmeds
    v2.hhxa(keep=subjid hhxa10a hhxa15a hhxa16a)            
    v2.mhxb(keep=subjid mhxb8 mhxb9 mhxb10 mhxb11 mhxb12 mhxb13 mhxb16 mhxb17 mhxb30 mhxb31 mhxb32 mhxb48 mhxb49 mhxb50 mhxb52a mhxb54a)
    v2.msrb(keep=subjid msrb29e)
    
; by subjid;

if ina2;


*Dichotomous medical history variables imputed to no when missing (missing/unknown <5%);

*Has a doctor said you had chronic lung disease?
*NOTE: Question asked as has doctor told you since last JHS exam so we need to include visit 1 variable;
chronic_lung = (hhxa15a=1 or chronic_lungv1);

*Has doctor said you have asthma? or asthma from exam 1;
asthma_any = (hhxa16a=1 or asthma_anyv1);

*NOTE: Coughing/phlegm/wheeze questions are not available for visist 2 so can only use from visit 1;       
cough_phlegm_wheeze = cough_phlegm_wheezev1;
           
*ECG and hence atrioventricular conduction Minnesota code for pacemaker not available; 

            
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
hfmed = (msrb29e=1);
            
            
*ARIC modified Gotheburg to derive history of heart failure;
 
******Note: These questions are since your last JHS visit so this needs to be cumulative over time; 
******We will also include the prior variables so variables capture surgery ever;  
    coronaryByp = (mhxb52a=1 or coronaryBypv1);
    coronaryAngio = (mhxb54a=1 or coronaryAngiov1);

*NOTE: JHS does not derive variable chdhx for visit 2 because ECG with MI scar check is not available;
*So we will just derive without that variable;
*NOTE: Since the question is asked whether new from last JHS exam, we will include prior CHD from visit 1;
    chdhx_alt = (hhxa10a=1 or mhxb17=2 or mhxb31=1 or mhxb32=1 or chdhxv1); 
         
*Including anychd from visist 1 since visist 2 questions are since last exam;
    
    anychd = (chdhx_alt or coronaryByp or coronaryAngio or anychdv1);
    
*Flag these from current exam;
    self_angina = (mhxb16=1 and mhxb17=1);
    self_chestpain = (mhxb8=1 and (mhxb9=1 or mhxb10=1) and mhxb11=1 and mhxb12=1 and mhxb13=1);

*Questions phrased as since last exam so also include prior angina from visit 1;    
    angina = (self_angina or self_chestpain or anginav1);
            
*Swelling of feet or ankles, AND it comes down overnight;
    swollen_leg = ((mhxb49=1 and mhxb50=1) or swollen_legv1);
            
*Nocturnal dyspea;
    nocturnal_dyspnea = (mhxb48=1 or nocturnal_dypneav1);
    
*No ECG at exam 2 so we will use afib from exam 1 or current use of antiarrhymic medications;
    afib_alt = ((antiarrhythmic=1) or afibv1);
 
*NOTE: Coughing/phlegm/wheeze questions are not available for visist 2 so can only use from visit 1;       
    
    cardiac = sum(anychd, angina, swollen_leg, nocturnal_dyspnea, afib_alt);
    pulmonary = sum(chronic_lung, asthma_any, cough_phlegm_wheeze);
    hftherapy = sum((digoxin=1), (diuretic=1));

    *Most Gothenburg visit 2 assessment is necessarily cumulative from visit 1 given nature of questions;
    *However, there are some cases where HF medication status changes;
    *Discussed with Arun, and we agree it is best to have any prior found prevalent HF carry forward;
    
    hfhx = ((cardiac>0) and (pulmonary>0) and (hftherapy>0)) or hfhxv1;
    gothenburg_score = max(sum(cardiac, pulmonary, hftherapy_ever), gothenburg_scorev1);

    *For convenience, retain the current visit date and year;
    hfhxdate = visitdate;
    
    hfhxyr = year(visitdate);
    
    format hfhxdate date9.;

if (antihypertens=1 or betablocker=1 or calcblocker=1 or diuretic=1) then broadbpmed=1;
else broadbpmed = max(antihypertens, betablocker, calcblocker, diuretic);

***NOTE: Education was not collected at visit 2 so we will use our derived visit 1 variable;
    
****NOTE: ALL of the physical activity questions missing at visit 2;
    
****NOTE: ALL of the alcohol questions missing at visit 2;
    
label chronic_lung = 'DCRI Derived: Self-reported chronic lung disease';
label asthma_any = 'DCRI Derived: Self-reported asthma';
label education_recode = 'DCRI Derived: Highest level of education achieved as recorded at exam 1';   
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
label hfhx = 'DCRI Derived: History of Heart Failure based on ARIC modified Gothenburg criteria at exam 2';
label hfhxdate = 'DCRI Derived: Visit date for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 2';    
label hfhxyr = 'DCRI Derived: Visit year for ascertainment of Heart Failure based on ARIC modified Gothenburg criteria at exam 2';  
label chdhx_alt = 'DCRI Derived: History of Coronary Heart Disease based based on self-reported history and no ECG at exam 2';    
label afib_alt = 'DCRI Derived: History of Atrial Fibrillation based based on ECG at exam 1 or current antiarrhymic medication use';        
label gothenburg_score = 'DCRI Derived: ARIC Modified Gothenburg HF score';
label cough_phlegm_wheeze = 'DCRI Derived: Self-reported chronic coughing, phlegm or wheezing from exam 1 (missing exam 2)';                    
label nocturnal_dyspnea = 'DCRI Derived: Self-reported nocturnal dyspnea';
label swollen_leg = 'DCRI Derived: Self-reported swollen legs at end of day';
label anychd = 'DCRI Derived: Any cornary heart disease per JHS variable (self-report or MI on ECG) or cornary bypass or angiography';
run;

                        
proc freq data=dcri_derived2;
tables chronic_lung asthma_any cough_phlegm_wheeze coronaryByp coronaryAngio anychd angina chdhx_alt afib_alt  afibv1*afib_alt 
       antidepress antihypertens antihypertenscomb adrenolytic broadbpmed antihyperlipid anticoag antiplat cox2inhib
       betablocker alphablocker vasodilator nitrate calcblocker calcblockerbroad diuretic beta_diuretic antiarrhythmic statin 
       oraldiab insulin hrt loopdiur thiazdiur potassdiur combdiur acearb digoxin 
       education_recode 
       self_angina*self_chestpain angina swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy 
       hfhx gothenburg_score self_angina self_chestpain swollen_leg nocturnal_dyspnea cardiac pulmonary hftherapy
   
       / missing;


run;

*Final cleanup, delete temporary variables;
data jhs.dcri_derived2;
set dcri_derived2(drop=self_angina self_chestpain cardiac pulmonary hftherapy
                      afibv1);                        
                        
run;
                        
proc contents varnum data=jhs.dcri_derived2; run;

TITLE 'Print a few observations';                   
proc print data=jhs.dcri_derived2(obs=100); run;                      
