data AFUlong;
length cancerFirstLocation $80.
	   cancerFirstDate $200.
	   hospDate1 $200.
	   hospDate2 $200.
	   hospDate3 $200.
	   hospDate4 $200.
	   hospDate5 $200.
	   hospDate6 $200.
	   hospReason1 $80.
	   hospReason2 $80.
	   hospReason3 $80.
	   hospReason4 $80.
	   hospReason5 $80.
	   meds1 $1000.;
set afu.afua afu.afub afu.afuc afu.afud afu.afue;
format _all_;
drop afud2;
run;

proc datasets lib=work;
modify AFUlong;
attrib _all_ label=' ';
run;
quit;

data AFUlong;
retain subjid date visit vers finalStatus cOptions rOptions dOptions resultCode maritalStatus
	   inptHosp outptHosp outptHospHeart outptHospDate hospReason1 hospDate1 hospReason2
	   hospDate2 hospReason3 hospDate3 hospReason4 hospDate4 hospReason5 hospDate5 
	   hospReason6 hospDate6 hospReason7 hospDate7 hospReason8 hospDate8 hospReason9
	   hospDate9 hospReason10 hospDate10 hospReason11 hospDate11 hospReason12 hospDate12
	   nursingEver nursingCurrent cigaretteSmoke employmentStatus employedStatus 
	   unemployedStatus retiredStatus healthPerception fxHeavy fxStairs fxWalk fxWork	
	   fxWorkHeart fxWorkMiss fxWorkMissDays fxActivities fxActivitiesHeart fxActivitiesCut
	   fxActivitiesCutDays HFmedsAFU BPmedsAFU DMmedsAFU statinMedsAFU aspirinMedsAFU
	   asthmaMedsAFU lungMedsAFU rhythmMedsAFU bloodMedsAFU strokeMedsAFU TIAmedsAFU
	   claudMedsAFU depressMedsAFU painMedsAFU anginaMedsAFU heartMedsAFU heartMedsNameAFU
	   medsReport meds1 meds2 meds3 meds4 meds5 meds6 meds7 meds8 meds9 meds10 meds11 
	   meds12 meds13 meds14 meds15 meds16 meds17 meds18 meds19 meds20 chronicLungEver	
	   chronicLungLastCntct breathingWake breathingHurrying breathingWalking breathingStopPace
	   breathingStopYards breathingWalkSlow breathingNotWalking breathingCoughing
	   asthmaEver asthmaLastCntct strokeLastCntct strokeHosp MIever MIlastCntct MIHospLastCntct
	   anginaEver anginaLastCntct HTNever HTNLastCntct DMever DMlastCntct DVTever DVTlastCntct	
	   DVThosp DVTdate PEever PElastCntct PEhosp cardiacSurgeryYN cardiacSurgeryBypass cardiacProcOther
	   cardiacProcSpecify cardiacProcCarotid cardiacProcCarotidSite cardiacProcRevasc 
	   cardiacProcRevascSpecify cardiacSurgeryOther cardiacAngio cardiacAngioCoronary 
	   cardiacAngioNeck cardiacAngioLower cardiacEcho cardiacEchoReason cardiacEchoSpecify
	   cardiacECG cardiacECGReason cardiacECGSpecify cardiacStress cardiacStressReason
	   cardiacStressSpecify cardiacCTMRI cardiacCTMRIReason cardiacCTMRISpecify cardiacCath
	   cardiacCathNeck cardiacCathNeckReason cardiacCathNeckSpecify cardiacCathHeart 
	   cardiacCathHeartReason cardiacCathHeartSpecify cardiacCathKidneys cardiacCathKidneysReason
	   cardiacCathKidneysOther cardiacCathLegs cardiacCathLegsReason cardiacCathLegsSpecify
	   HFever HFhosp HFhospEver HFlastCntct HFlastCntctDate HFhospLastCntct HFweakEver 
	   HFweakDate HFweakHosp HFweakLastCntct HFcough HFpillows HFdoctor atrialFib
	   swellingFeet swellingGone PADpain PADever cancerEver cancerLastCntct cancerFirstLocation	
	   cancerFirstDate cancerSecond cancerSecondLocation cancerSecondDate hormoneFirstYN
	   hormoneFirstName hormoneSecondYN hormoneSecondName healthcareDentist healthcareDoctor
	   healthcareChiro healthcareAcupunct healthcareFaith healthcareRoots healthcareAstrology
  	   healthcareTea healthcareDoctorNumber insuranceCoverage insuranceCoverageLapseTime
	   insurancePrivate insuranceMedicaid insuranceMedicare insuranceVeteran insuranceOther
	   insuranceCoverageLapseYN insuranceMeds insuranceMedsNoLimits insuranceMedsCut 
	   insuranceMedsNumber insuranceMedsFillLimit insuranceMedsTimeLimit insuranceMedsCostLimit
	   insuranceMedsLimitAmt insuranceMedsNumberLimit insuranceMedsOtherLimits insuranceMedsLimits
   	   costIncreasePremiums costIncreaseShare costMedsAverage costMedsCopay costSacrificeHealthcare
	   costSacrificeMeds costSacrificeSpecialist costSacrificeTreatment costSacrificeDoctor
 	   costSacrificeOther costProblem satisfactionListen satisfactionExplain satisfactionRespect 
	   satisfactionTime satisfactionQuality satisfactionConfident stressPastYear depressedPastYear
	   nervousPastYear discriminationPastYear stressCopePastYear supportPastYear famHistoryChange
 	   famRelationship1 famCOD1 famCODSpecify1 famAge1 famRelationship2 famCOD2 famCODSpecify2 
 	   famAge2 famRelationship3 famCOD3 famCODSpecify3 famAge3 famRelationship4 famCOD4 
	   famCODSpecify4 famAge4 famNewDiagYN famNewDiagRelationship1 famNewDiagDX1 famNewDiagAge1 
	   famNewDiagDXSpecify1 famNewDiagRelationship2 famNewDiagDX2 famNewDiagAge2 famNewDiagDXSpecify2 
	   famNewDiagRelationship3 famNewDiagDX3 famNewDiagAge3 famNewDiagDXSpecify3 famNewDiagRelationship4 
	   famNewDiagDX4 famNewDiagAge4 famNewDiagDXSpecify4;

set AFUlong;

label date="Interview Date"
	  maritalStatus="Which of the following describes your current marital status?"
	  inptHosp="Have you stayed overnight as a patient in a hospital for any other reason since our last contact?"
	  outptHosp="Were you admitted to an emergency room or a medical facility for outpatient treatment since our last contact?"
	  outptHospHeart="Was this related to a heart problem or difficulty breathing?"
	  outptHospDate="What was the approximate date?"
	  hospReason1="Reason for first hospitilization?"
	  hospDate1="Month and year of first hospitilization?"
	  hospReason2="Reason for second hospitilization?"
	  hospDate2="Month and year of second hospitilization?"
	  hospReason3="Reason for third hospitilization?"
	  hospDate3="Month and year of third hospitilization?"
	  hospReason4="Reason for fourth hospitilization?"
	  hospDate4="Month and year of fourth hospitilization?"
	  hospReason5="Reason for fifth hospitilization?"
	  hospDate5="Month and year of fifth hospitilization?"
	  hospReason6="Reason for sixth hospitilization?"
	  hospDate6="Month and year of sixth hospitilization?"
	  hospReason7="Reason for seventh hospitilization?"
	  hospDate7="Month and year of seventh hospitilization?"
	  hospReason8="Reason for eighth hospitilization?"
	  hospDate8="Month and year of eighth hospitilization?"
	  hospReason9="Reason for ninth hospitilization?"
	  hospDate9="Month and year of ninth hospitilization?"
	  hospReason10="Reason for tenth hospitilization?"
	  hospDate10="Month and year of tenth hospitilization?"
	  hospReason11="Reason for eleventh hospitilization?"
	  hospDate11="Month and year of eleventh hospitilization?"
	  hospReason12="Reason for twelveth hospitilization?"
	  hospDate12="Month and year of twelveth hospitilization?"
	  nursingEver="Since our last contact, have you stayed overnight as a patient in a nursing home?"
	  nursingCurrent="Are you currently staying in a nursing home?"
	  cigaretteSmoke="Do you now smoke cigarettes?"
	  employmentStatus="Which of the following best describes your employment status?"
	  employedStatus="Which of these two categories best describes your 'employed' status?"
	  unemployedStatus="Which of these two categories best describes your 'unemployed' status?"
	  retiredStatus="Which of these two categories best describes your 'retired' status?"
	  healthPerception="Over the past year, compared to other people your age, would you say your health has been excellent, good, fair, or poor?"
	  fxHeavy="Are you able to do heavy work around the house, like shoveling snow or washing windows, walls, or floors without help?"
	  fxStairs="Are you able to walk up and down stairs without help?"
	  fxWalk="Are you able to walk half a mile without help?"
	  fxWork="Are you ABLE to go to work?"
	  fxWorkHeart="Is a heart problem the main cause of your not being able to work?"
	  fxWorkMiss="During the past 4 weeks, have you missed work for at least half a day because of your health?"
	  fxWorkMissDays="On how many days has this happened?"
	  fxActivities="Are you able to do your usual activities, such at work around the house or recreation?"
	  fxActivitiesHeart="Is a heart problem the main cause of your being unable to do these activities?"
	  fxActivitiesCut="During the past 4 weeks, have you had to cut down on your usual activities, such as work around the house or recreation, for half a day or more because of your health?"
	  fxActivitiesCutDays="On how many days has this happened?"
	  HFmedsAFU="Did you take any medication for heart failure in the past two weeks?"
	  BPmedsAFU="Did you take any medication for high blood pressure in the past two weeks?"
	  DMmedsAFU="Did you take any medication for diabetes or high blood surgar in the past two weeks?"
	  statinMedsAFU="Did you take any medication for high blood cholesterol in the past two weeks?"
	  aspirinMedsAFU="Are you now taking aspirin or a medicine containing aspirin on a regular basis? This does not include Tylenol nor Advil."
	  asthmaMedsAFU="Did you take any medication for asthma in the past two weeks?"
	  lungMedsAFU="Did you take any medication for chronic bronchitis or emphysema in the past two weeks?"
	  rhythmMedsAFU="Did you take any medication for abnormal heart rhythm in the past two weeks?"
	  bloodMedsAFU="Did you take any medication for blood thinning in the past two weeks?"
	  strokeMedsAFU="Did you take any medication for stroke in the past two weeks?"
	  TIAmedsAFU="Did you take any medication for mini-stroke or TIA in the past two weeks?"
	  claudMedsAFU="Did you take any medication for leg pain while walking or claudication in the past two weeks?"
	  depressMedsAFU="Did you take any medication for depression in the past two weeks?"
	  painMedsAFU="Do you regularly take medicine for pain or inflammation that does NOT contain aspirin?"
	  anginaMedsAFU="Did you take any medication for chest pain or angina in the past two weeks?"
	  heartMedsAFU="Did you take any medication for other heart conditions in the past two weeks?"
	  heartMedsNameAFU="What medication did you take for your heart condition?"
	  medsReport="Does the participant have medications to report?"
	  meds1="Medication Name (1)"
	  meds2="Medication Name (2)"
	  meds3="Medication Name (3)"
	  meds4="Medication Name (4)"
	  meds5="Medication Name (5)"
	  meds6="Medication Name (6)"
	  meds7="Medication Name (7)"
	  meds8="Medication Name (8)"
	  meds9="Medication Name (9)"
	  meds10="Medication Name (10)"
	  meds11="Medication Name (11)"
	  meds12="Medication Name (12)"
	  meds13="Medication Name (13)"
	  meds14="Medication Name (14)"
	  meds15="Medication Name (15)"
	  meds16="Medication Name (16)"
	  meds17="Medication Name (17)"
	  meds18="Medication Name (18)"
	  meds19="Medication Name (19)"
	  meds20="Medication Name (20)"
	  chronicLungEver="Has a doctor said that you have chronic lung disease such as bronchitis or emphysema?"
	  chronicLungLastCntct="Since our last contact, has a doctor said that you have chronic lung disease such as bronchitis or emphysema?"
	  breathingWake="Are there times when you wake up at night because of difficulty breathing?"
	  breathingHurrying="Do you have trouble breathing or shortness of breath when hurrying on the level?"
	  breathingWalking="Do you have trouble breathing or shortness of breath when walking at ordinary pace on a level surface?"
	  breathingStopPace="Do you stop for breath when walking at your own pace?"
	  breathingStopYards="Do you stop for breath after walking 100 yards on the level?"
	  breathingWalkSlow="Do you have to walk slower than people of your own age on a level surface because of shortness of breath?"
	  breathingNotWalking="Do you have difficulty breathing when you are not walking or active?"
	  breathingCoughing="Do you usually have some coughing or wheezing?"
	  asthmaEver="Has a doctor said that you have asthma?"
	  asthmaLastCntct="Since our last contact, has a doctor said that you have asthma?"
	  strokeLastCntct="Since our last contact, have you been told by a physician that you had a stroke, slight stroke, transient ischemic attack, or TIA?"
	  strokeHosp="Were you hospitalized for this stroke, slight stroke, transient ischemic attack, or TIA?"
	  MIever="Has a doctor said that you have had a heart attack?"
	  MIlastCntct="Since our last contact, has a doctor said you had a heart attack?"
	  MIHospLastCntct="Were you hopsitalized for a heart attack since our last contact?"
	  anginaEver="Has a doctor ever said that you had angina, angina pectoris, or chest pain due to heart disease?"
	  anginaLastCntct="Since our last contact, has a doctor said that you had angina, angina pectoris, or chest pain due to heart disease?"
	  HTNever="Has a doctor said that you have high blood pressure?"
	  HTNLastCntct="Since our last contact, has a doctor said you have high blood pressure?"
	  DMever="Has a doctor said that you have diabetes or sugar in the blood?"
	  DMlastCntct="Since our last contact, has a doctor said you have diabetes or sugar in the blood?"
	  DVTever="Has a doctor said that you have a blood clot in a leg or deep vein thrombosis?"
	  DVTlastCntct="Since our last contact, has a doctor said that you have a blood clot in a leg or deep vein thrombosis?"
	  DVThosp="Were you hospitalized for a blood clot in a leg or deep vein thrombosis at that time?"
	  PEever="Has a doctor said that you have a blood clot in your lungs or pulmonary embolus?"
	  PElastCntct="Since our last contact, has a doctor said that you have a blood clot in your lungs or a pulmonary embolus?"
	  PEhosp="Were you hospitalized for a blood clot in your lungs or a pulmonary embolus at that time?"
	  cardiacSurgeryYN="Since our last contact, have you had surgery on your heart or the arteries of your neck or legs, excluding surgery for varicose veins?"
	  cardiacSurgeryBypass="Did you have coronary bypass?"
	  cardiacProcOther="Did you have other heart procedures?"
	  cardiacProcSpecify="Specify heart procedures"
	  cardiacProcCarotid="Did you have a carotid endarterectomy?"
	  cardiacProcCarotidSite="Site of carotid endarterectomy"
	  cardiacProcRevasc="Did you have other arterial revascularization?"
	  cardiacProcRevascSpecify="Specify arterial revascularization procedures"
	  cardiacSurgeryOther="Did you have any other type of surgery on your heart or the arteries in your neck or legs?"
	  cardiacAngio="Since our last contact, have you had a baloon angioplasty on the artieres of your heart, neck, or legs?"
	  cardiacAngioCoronary="Did you have angioplasty of the coronary arteries?"
	  cardiacAngioNeck="Did you have angioplasty in the artieres of your neck?"
	  cardiacAngioLower="Did you have angioplasty of your lower extremity arteries?"
	  cardiacEcho="Did you have an echocardiogram in the past year?"
	  cardiacEchoReason="If yes, why? (Codes)"
	  cardiacEchoSpecify="If 'other', please specify"
	  cardiacECG="Did you have an ECG in the past year?"
	  cardiacECGReason="If yes, why? (Codes)"
	  cardiacECGSpecify="If 'other', please specify"
	  cardiacStress="Did you have an exercise stress test in the past year?"
	  cardiacStressReason="If yes, why? (Codes)"
	  cardiacStressSpecify="If 'other', please specify"
	  cardiacCTMRI="Did you have a CT or MRI of the head in the past year?"
	  cardiacCTMRIReason="If yes, why? (Codes)"
	  cardiacCTMRISpecify="If 'other', please specify"
	  cardiacCath="Did you have catheterization or an angiogram in the past year?"
	  cardiacCathNeck="Was it to look at the blood vessels in your neck?"
	  cardiacCathNeckReason="What was the reason?"
	  cardiacCathNeckSpecify="If 'other', please specify"
	  cardiacCathHeart="Was it to look at the blood vessels in your heart?"
	  cardiacCathHeartReason="What was the reason?"
	  cardiacCathHeartSpecify="If 'other', please specify"
	  cardiacCathKidneys="Was it to look at the blood vessels in your kidneys?"
	  cardiacCathKidneysReason="What was the reason?"
	  cardiacCathKidneysOther="If 'other', please specify"
	  cardiacCathLegs="Was it to look at the blood vessels in yoru legs?"
	  cardiacCathLegsReason="What was the reason?"
	  cardiacCathLegsSpecify="If 'other', please specify"
	  HFever="Has a doctor said that you have heart failure or congestive heart failure?"
	  HFhosp="What was the approximate date?"
	  HFhospEver="Have you been hospitalized for heart failure?"
	  HFlastCntct="Since our last contact, has a doctor said that you had heart failure or congestive heart failure?"
	  HFlastCntctDate="What was the approximate date?"
	  HFhospLastCntct="Were you hospitalized for heart failure at that time?"
	  HFweakEver="Has a doctor ever said that your heart is weak, does not pump as strongly as it should, or that you had fluid on the lungs?"
	  HFweakDate="What was the approximate date?"
	  HFweakHosp="Were you hospitalized for the weak heart muscle at that time?"
	  HFweakLastCntct="Since our last contact, has a doctor said that your heart is weak, does not pump as strongly as it should, or that you had fluid on the lungs?"
	  HFcough="Do you frequently cough at night (in the absence of a cold or 'flu')?"
	  HFpillows="Do you sleep on 2 or more pillows to improve your breathing?"
	  HFdoctor="Have you seen a doctor or health care professonal for any of these symptoms in the past year?"
	  atrialFib="Has a doctor ever said that you had an irregular heart beat called atrial fibrillation or atrial fibrillation on a heart scan or electrocardiogram tracing?"
	  swellingFeet="Do you often have swelling in your feet or ankles at the end of the day?"
	  swellingGone="Is the swelling in your feet or ankles gone in the morning?"
	  PADpain="Do you have pain in your legs caused by a blockage of the arteries?"
	  PADever="Has a doctor ever said that you have peripheral vascular disease or intermittent claudication?"
	  cancerEver="Has a doctor said that you have cancer?"
	  cancerLastCntct="Since we last contacted you, has a doctor said you have cancer?"
	  cancerFirstLocation="Where was that cancer?"
	  cancerFirstDate="What date was the most recently diagnosed cancer diagnosed?"
	  cancerSecond="Have you had another cancer?"
	  cancerSecondLocation="Where was that cancer located?"
	  cancerSecondDate="When was it diagnosed?"
	  hormoneFirstYN="Since our last contact, have you taken or used any female hormone pills, skin patches, shots, or implants?"
	  hormoneFirstName="Name of first hormone"
	  hormoneSecondYN="Have you also used a second female hormone since we last contacted you?"
	  hormoneSecondName="Name of second hormone"
	  healthcareDentist="In the past year, have you seen a dentist?"
	  healthcareDoctor="In the past year, have you seen a doctor or health professional for routine physical exam or general check-up?"
	  healthcareChiro="In the past year, have you seen a chiropractor?"
	  healthcareAcupunct="In the past year, have you seen a person who uses acupuncture?"
	  healthcareFaith="In the past year, have you seen a faith healer?"
	  healthcareRoots="In the past year, have you seen a person who deals with roots or herbs?"
	  healthcareAstrology="In the past year, have you seen a person who practices astrology or reads zodiac signs?"
	  healthcareTea="In the past year, have you seen a person who reads tea leaves, roots, or palms?"
	  healthcareDoctorNumber="How many times in the past year did you go to a doctor's or nurse practitioner's office to get care for yourself?"
	  insuranceCoverage="Are you currently covered by one or more health insurance programs that pays most or all of your health care expenses?"
	  insuranceCoverageLapseTime="How long has it been since you had health insurance coverage?"
	  insurancePrivate="Are you currently covered by a private health insurance?"
	  insuranceMedicaid="Are you currently covered by Medicaid or public aid?"
	  insuranceMedicare="Are you currently covered by Medicare?"
	  insuranceVeteran="Are you currently covered by the Veterans Administration, CHAMPUS, or TRICARE?"
	  insuranceOther="Are you currently covered by another means of insurance?"
	  insuranceCoverageLapseYN="Has there been a time in the past year when you did not have health insurance coverage?"
	  insuranceMeds="Do you have health insurance that helps you pay for your medications?"
	  insuranceMedsNoLimits="My medication insurance has no limits on my medication coverage"
	  insuranceMedsCut="Since our last contact, have you experienced a cut in benefits?"
	  insuranceMedsNumber="How many medications can you obtain?"
	  insuranceMedsFillLimit="My medication insurance limits how often I can fill my prescriptions"
	  insuranceMedsTimeLimit="What is the time limit for filling your prescriptions?"
	  insuranceMedsCostLimit="My medication insurance has a dollar limit per month"
	  insuranceMedsLimitAmt="How much is the dollar limit?"
	  insuranceMedsNumberLimit="My medication insurance limits the number of medications it will pay for per month or quarter"
	  insuranceMedsOtherLimits="Are there other limits to your medication insurance plan?"
	  insuranceMedsLimits="What are the limits?"
	  costIncreasePremiums="Since our last contact, have you experienced an increase in the price of premiums?"
	  costIncreaseShare="Since our last contact, have you experienced an increase in your share of the medical costs?"
	  costMedsAverage="On average, how much do you pay each month for your medication?"
	  costMedsCopay="Do you pay a co-payment when you fill your medication?"
	  costSacrificeHealthcare="Has there been a time in the past year when you went without needed health care because of costs?"
	  costSacrificeMeds="I did not fill a prescription due to cost"
	  costSacrificeSpecialist="I did not see a specialist when needed due to cost"
	  costSacrificeTreatment="I skipped a medical test, treatment, or follow-up due to cost"
	  costSacrificeDoctor="I had medical problems, but did not see a doctor or nurse practitioner due to cost"
	  costSacrificeOther="Other healthcare gone without due to cost?"
	  costProblem="In the past year, how much of a problem has it been to get the health care, medical tests, or treatment that you or your doctor believed necessary?"
  	  satisfactionListen="How often did your doctor or other health care providers listen carefully to you?"
	  satisfactionExplain="How often did your doctor or other health providers explain things in a way you could understand?"
	  satisfactionRespect="How often did your doctor or other health care providers show respect for what you had to say?"
	  satisfactionTime="How often did your doctor or other health care providers spend enough time with you?"
	  satisfactionQuality="Overall, how satisfied have you been with the quality of health care you have received in the past year?"
	  satisfactionConfident="How confident are you that you can get high quality health care when you need it?"
	  stressPastYear="How much stress have you experienced over the past year?"
 	  depressedPastYear="How often have you felt sad or depressed over the past year?"
	  nervousPastYear="How often have you felt nervous or tense over the past year?"
	  discriminationPastYear="How often have you felt you were treated unfairly or discriminated against over the past year?"
	  stressCopePastYear="How well have you handled or coped with stressors you experienced over the past year?"
	  supportPastYear="How satisfied are you with the help or support that you've received from others over the past year?"
	  famHistoryChange="Since your last JHS contact, have your natural parents, any of your full brothers or sisters, or your natural children died?"
	  famRelationship1="What was the relationship?"
	  famCOD1="What was the cause of death?"
	  famCODSpecify1="If 'other', please specify"
	  famAge1="What was the age at death?"
	  famRelationship2="What was the relationship?"
	  famCOD2="What was the cause of death?"
	  famCODSpecify2="If 'other', please specify"
	  famAge2="What was the age at death?"
	  famRelationship3="What was the relationship?"
	  famCOD3="What was the cause of death?"
	  famCODSpecify3="If 'other', please specify"
	  famAge3="What was the age at death?"
	  famRelationship4="What was the relationship?"
	  famCOD4="What was the cause of death?"
	  famCODSpecify4="If 'other', please specify"
	  famAge4="What was the age at death?"
	  famNewDiagYN="In the past year, have any members of your family been newly diagnosed with high blood pressure, heart disease, stroke, diabetes, or cancer?"
	  famNewDiagRelationship1="What is the relationship?"
	  famNewDiagDX1="What is the diagnosis?"
	  famNewDiagAge1="Age at diagnosis?"
	  famNewDiagDXSpecify1="If 'other', please specify"
	  famNewDiagRelationship2="What is the relationship?"
	  famNewDiagDX2="What is the diagnosis?"
	  famNewDiagAge2="Age at diagnosis?"
	  famNewDiagDXSpecify2="If 'other', please specify"
	  famNewDiagRelationship3="What is the relationship?"
	  famNewDiagDX3="What is the diagnosis?"
	  famNewDiagAge3="Age at diagnosis?"
	  famNewDiagDXSpecify3="If 'other', please specify"
	  famNewDiagRelationship4="What is the relationship?"
	  famNewDiagDX4="What is the diagnosis?"
	  famNewDiagAge4="Age at diagnosis?"
	  famNewDiagDXSpecify4="If 'other', please specify";

format date MMDDYYS10.;
run;

* Remove backdating in Version C;

data AFUlong;
set AFUlong;
if vers="C" & year(date)<2005 then delete;
run;

proc sort data=AFUlong;
by subjid date visit;
run;

data AFUlong;
set AFUlong;
if missing(date) then delete;

format maritalStatus	$maritalstatus.
	   inptHosp			$yn.
	   outptHosp		$yn.
	   outptHospHeart	$yn.	
	   nursingEver		$yn.
	   nursingCurrent	$yn.
	   cigaretteSmoke	$yn.
	   employmentStatus	employmentstatus.
	   employedStatus	employedstatus.
	   unemployedStatus	unemployedstatus.
	   retiredStatus	retiredstatus.
	   healthPerception	$healthperception.
	   fxHeavy			yn.
	   fxStairs			yn.
	   fxWalk			yn.
	   fxWork			yn.
	   fxWorkHeart		yn.
	   fxWorkMiss		yn.
	   fxActivities		yn.
	   fxActivitiesHeart yn.
	   fxActivitiesCut	yn.
	   HFmedsAFU		$yn.
	   BPmedsAFU		$yn.
	   DMmedsAFU		$yn.
	   statinMedsAFU	$yn.
	   aspirinMedsAFU	$yn.
	   asthmaMedsAFU	$yn.
	   lungMedsAFU		$yn.
	   rhythmMedsAFU	$yn.
	   bloodMedsAFU		$yn.
	   strokeMedsAFU	$yn.
	   TIAmedsAFU		$yn.
	   claudMedsAFU		$yn.
	   depressMedsAFU	$yn.
	   painMedsAFU		$yn.
	   anginaMedsAFU	yn.
	   heartMedsAFU		yn.
	   heartMedsNameAFU	yn.
	   medsReport		$yn.
	   chronicLungEver	$yn.
	   chronicLungLastCntct	$yn.
	   breathingWake	$yn.
	   breathingHurrying	$yn.
	   breathingWalking	$yn.
	   breathingStopPace	$yn.
	   breathingStopYards	$yn.
	   breathingWalkSlow	$yn.
	   breathingNotWalking	$yn.
	   breathingCoughing	$yn.
	   asthmaEver	$yn.
	   asthmaLastCntct	$yn.
	   strokeLastCntct	$yn.
	   strokeHosp	$yn.
	   MIever	$yn.
	   MIlastCntct	$yn.
	   MIHospLastCntct	$yn.
	   anginaEver	$yn.
	   anginaLastCntct	$yn.
	   HTNever	$yn.
	   HTNLastCntct	$yn.
	   DMever	$yn.
	   DMlastCntct	$yn.
	   DVTever	$yn.
	   DVTlastCntct	$yn.
	   DVThosp	$yn.
	   PEever	$yn.
	   PElastCntct	$yn.
	   PEhosp	$yn.
	   cardiacSurgeryYN	$yn.
	   cardiacSurgeryBypass	$yn.
	   cardiacProcOther	$yn.
	   cardiacProcCarotid	$yn.
	   cardiacProcCarotidSite	$cardiacproccarotidsite.
	   cardiacProcRevasc	$yn.
	   cardiacSurgeryOther	$yn.
	   cardiacAngio	$yn.
	   cardiacAngioCoronary	$yn.
	   cardiacAngioNeck	$yn.
	   cardiacAngioLower	$yn.
	   cardiacEcho	yn.
	   cardiacEchoReason	echoecgstress.
	   cardiacECG	yn.
	   cardiacECGReason	echoecgstress.
	   cardiacStress	yn.
	   cardiacStressReason	echoecgstress.
	   cardiacCTMRI	yn.
	   cardiacCTMRIReason	ctmri.
	   cardiacCath	yn.
	   cardiacCathNeck	cath.
	   cardiacCathHeart	yn.
	   cardiacCathHeartReason	cath.
	   cardiacCathKidneys	yn.
	   cardiacCathKidneysReason	cath.
	   cardiacCathLegs	yn.
	   cardiacCathLegsReason	cath.
	   HFever	$yn.
	   HFhospEver	$yn.
	   HFlastCntct	$yn.
	   HFweakEver	$yn.
	   HFweakHosp	$yn.
	   HFweakLastCntct	$yn.
	   HFcough	yn.
	   HFpillows	yn.
	   HFdoctor	yn.
	   atrialFib	$yn.
	   swellingFeet	$yn.
	   swellingGone	$yn.
	   PADpain	$yn.
	   PADever	$yn.
	   cancerEver	$yn.
	   cancerLastCntct	$yn.
	   cancerSecond	$yn.
	   hormoneFirstYN	$yn.
	   hormoneSecondYN	yn.
	   healthcareDentist	yn.
	   healthcareDoctor	yn.
	   healthcareChiro	yn.
	   healthcareAcupunct	yn.
	   healthcareFaith	yn.
	   healthcareRoots	yn.
	   healthcareAstrology	yn.
	   healthcareTea	yn.
	   healthcareDoctorNumber	healthcaredoctornumber.
	   insuranceCoverage	yn.
	   insuranceCoverageLapseTime	insurancecoveragelapsetime.
	   insurancePrivate	yn.
	   insuranceMedicaid	yn.
	   insuranceMedicare	yn.
	   insuranceVeteran	yn.
	   insuranceOther	yn.
	   insuranceCoverageLapseYN	yn.
	   insuranceMeds	yn.
	   insuranceMedsNoLimits	yn.
	   insuranceMedsCut	yn.
	   insuranceMedsFillLimit	yn.
	   insuranceMedsCostLimit	yn.
	   insuranceMedsNumberLimit	yn.
	   insuranceMedsOtherLimits	yn.
	   costIncreasePremiums	yn.
	   costIncreaseShare	yn.
	   costMedsAverage	costmedsaverage.
	   costMedsCopay	yn.
	   costSacrificeHealthcare	yn.
	   costSacrificeMeds	yn.
	   costSacrificeSpecialist	yn.
	   costSacrificeTreatment	yn.
	   costSacrificeDoctor	yn.
	   costSacrificeOther	yn.
	   costProblem	costproblem.
	   satisfactionListen	oftenB.
	   satisfactionExplain	oftenB.
	   satisfactionRespect	oftenB.
	   satisfactionTime	oftenB.
	   satisfactionQuality	satisfactionquality.
	   satisfactionConfident	satisfactionconfident.
	   stressPastYear	stresspastyear.
	   depressedPastYear	oftenA.
	   nervousPastYear	oftenA.
	   discriminationPastYear	oftenA.
	   stressCopePastYear	stresscopepastyear.
	   supportPastYear	supportpastyear.
	   famHistoryChange	yn.
	   famRelationship1	relationship.
	   famCOD1	cod.
	   famRelationship2	relationship.
	   famCOD2	cod.
	   famRelationship3	relationship.
	   famCOD3	cod.
	   famRelationship4	relationship.
	   famCOD4	cod.
	   famNewDiagYN	yn.
	   famNewDiagRelationship1	relationship.
	   famNewDiagDX1	dx.
	   famNewDiagRelationship2	relationship.
	   famNewDiagDX2	dx.
	   famNewDiagRelationship3	relationship.
	   famNewDiagDX3	dx.
	   famNewDiagRelationship4	relationship.
	   famNewDiagDX4	dx.;
run;

* Remove duplicate dates of AFU -- keep only last observation;

data AFU AFO;
set afulong;
if date=. then delete;
if substr(vers, 1, 1) ne 'O' then output AFU;
else if substr(vers, 1, 1) = 'O' then output AFO;
run;

proc sort data=AFU nodupkey;
by subjid descending date; * Deletes 249 observations;
run;

proc sort data=AFO nodupkey;
by subjid descending date; * Deletes 110 observations;
run;

* Delete contact year & create time from V1 variable;

data AFUlong;
set AFU AFO;
drop visit;
run;

proc sort data=AFUlong; by subjid; run;
proc sort data=cohort; by subjid; run;

data AFUlong;
retain subjid date visitdate;
merge cohort(in=a) AFUlong;
by subjid;
if a;
year=year(date);
if year=2015 then delete; * Observations past cut off date;
if missing(date) then delete; * Deletes completely missing observations (3);
if date=88893 then date=15845; * Change incorrect year from 2203 to 2003;
if date=30923 then date=16313; * Change incorrect year from 2044 to 2004;
time=round((date-V1date)/365.25, 0.1);
drop aric year;
run;

data AFUlong;
retain subjid date v1date time;
set AFUlong;
run;

options nofmterr;

data tera;
set tera.tera;
run;

proc sort data=afulong; by subjid; run;
proc sort data=tera; by subjid; run;

data AFUlong;
merge AFUlong(in=a) tera;
by subjid;
if a;

if TERA3=5 & .<TERA4A<date then delete; * delete AFU after death;

* THIS PARTICIPANT GAVE HARD REFUSAL (TERA3=8) TO CLINIC VISITS IN JHS;
* BUT WOULD LIKE TO CONTINUE AFU -- SEE TERA15 IN ADMINISTRATIVE TERA;
* RECHECK THIS IN 2016 -- IF PARTICIPANT IS DECEASED & TERA3 UPDATED TO 5;
* THEN REMOVE THIS;
if subjid='J573948' then TERA3=.;

if TERA3=8 & .<TERA7<date then delete; * delete AFU after hard refusal;

drop tera3 tera4a tera7;

run;

data out.AFUlong;
set afulong;
run;

/*
proc datasets library=work kill;
run;
quit;
*/
