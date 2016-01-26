********************************************************************;
****************** Define JHS Exam Visit 1 Formats *****************;
********************************************************************;

proc format library = jhsV1.v1formats;
value $JH_CPV
    'C' = 'Computer'
    'P' = 'Paper'; 

value $JH_YNV
    'N' = 'N. No'
    'Y' = 'Y. Yes';

value $JH_YNKV
    'K' = 'K. Don''t Know'
    'N' = 'N. No'
    'R' = 'R. Refused'
    'Y' = 'Y. Yes';

value $ABBA3AV
    'L' = 'Left'
    'R' = 'Right';

  value $ABPA5V
    'A' = 'A. Very comfortable'
    'B' = 'B. Somewhat comfortable'
    'C' = 'C. Somewhat uncomfortable'
    'D' = 'D. Very uncomfortable'
    'E' = 'E. Not sure';

  value $ADRA1V
    'N' = 'No'
    'S' = 'Stopped drinking more than one year ago'
    'Y' = 'Yes';

  value $ADRA2V
    'M' = 'Month'
    'W' = 'Week'
    'Y' = 'Year';

  value $ADRA4V
    'B' = 'Beer'
    'L' = 'Liquor'
    'N' = 'No preference or can''t say'
    'W' = 'Wine';

  value $ADRA7V
    'A' = 'A. 1 or 2 times'
    'B' = 'B. 3-10 times'
    'C' = 'C. 11-99 times'
    'D' = 'D. 100 or more times';

  value $ARCARCV
    'A' = 'A.AFU letter sent'
    'B' = 'B.No action taken'
    'C' = 'C.No answer'
    'D' = 'D.Busy signal'
    'E' = 'E.Answering machine'
    'F' = 'F.Privacy blcok'
    'G' = 'G.Disconnected/Non-working number'
    'H' = 'H.Recording/#change'
    'I' = 'I.Participant does not live here/unknown'
    'J' = 'J.Participant lived here,but moved permanently'
    'K' = 'K.Tracing'
    'L' = 'L.Physically/mentally incompetent'
    'M' = 'M.Language barrier'
    'N' = 'N.Contacted,interview complete'
    'O' = 'O.Contacted,interview partially complete or rescheduled'
    'P' = 'P.Contacted,interview refused'
    'Q' = 'Q.Reported alive, will continue to attempt to contact this year'
    'R' = 'R.Reported alive,contact not possible this year'
    'S' = 'S.Reported deceased'
    'T' = 'T.Unknown'
    'U' = 'U.Does not want furthur contact'
    'V' = 'V.Other'
    'W' = 'W.ARIC AFU';

  value $BAPA17V
    'A' = 'A. Dialysis graft'
    'B' = 'B. Mastectomy on nondominant side'
    'C' = 'C. Infection'
    'D' = 'D. Other (specify)';

  value $BAPA19V
    'A' = 'A. Exceeded maximum cuff size'
    'B' = 'B. Known atrial fibrillation'
    'C' = 'C. Unable to correlate'
    'D' = 'D. Refusal (specify)'
    'E' = 'E. Other (specify)';

  value $BAPA22V
    'C' = 'Clinic pick-up'
    'P' = 'Participant delivery';

  value $BAPA7V
    'A' = 'A. Small adult (17-26cm)'
    'B' = 'B. Standard adult (24-32cm)'
    'C' = 'C. Large adult (32-42cm)'
    'D' = 'D. Extra large adult (38-50cm)';

  value $BAPAR9V
    'A' = 'Accept'
    'R' = 'Reject';

  value CESAR1V
    1 = '1. Rarely or None of the time (Less than 1 day)'
    2 = '2. Some or Little of the time (1-2 days)'
    3 = '3. Occasionally or a Moderate Amount of the Time (3-4 days)'
    4 = '4. Most or All of the Time (5-7 days)';

  value $CHOAR1V
    'F' = 'False'
    'T' = 'True';

  value $CLAA12V
    'P' = 'Pending'
    'R' = 'Refused'
    'S' = 'Set';

  value $CLAA14V
    'A' = 'A. Language barrier'
    'B' = 'B. Physically unable to attend clinic'
    'C' = 'C. Doesn''t want blood drawn'
    'D' = 'D. Doesn''t want to take time off work'
    'E' = 'E. Other refusal'
    'F' = 'F. Other';

  value $CLAA8V
    'A' = 'A. JHS Volunteer'
    'B' = 'B. Taxi'
    'C' = 'C. Other';

  value $CONA33V
    'C' = 'C. Participant will bring information to clinic'
    'O' = 'O. Complete physician contact information obtained'
    'P' = 'P. Participant to provide at 24-hour pick-up'
    'R' = 'R. Refusal or no health care provider';

  value $CONA35V
    'N' = 'Nurse practitioner'
    'O' = 'Other'
    'P' = 'Physician';

  value CSIA1RV
    1 = '1. Never'
    2 = '2. Seldom'
    3 = '3. Sometimes'
    4 = '4. Often'
    5 = '5. Almost Always';

  value $CTAUDTV
           'ENTRY' = 'ENTRY'
           'MERGE' = 'MERGE'
      'VALIDATION' = 'VALIDATION'
        'VALIDITY' = 'VALIDITY'
    'VERIFICATION' = 'VERIFICATION';

  value CTBOOLV
    0 = 'No'
    1 = 'Yes';

  value $CTLLOCV
      'DATA' = 'DATA'
    'UPDATE' = 'UPDATE';

  value CTPGRPV
    -1 = 'Obsolete'
    -4 = 'Oracle'
     0 = 'Internal'
     1 = 'Admin'
     2 = 'Manage'
     5 = 'Enter'
     6 = 'Design'
     7 = 'Retrieve'
     8 = 'Lab Loader';

  value CTQTV
    1 = 'QBF'
    2 = 'Ad Hoc Query'
    4 = 'SQL';

  value $CTQSRCV
       'ALL' = 'ALL'
      'DATA' = 'DATA'
    'UPDATE' = 'UPDATE';

  value $CTTHSTV
    'CONTAINS' = 'Contains'
       'EXACT' = 'Exact'
      'FILTER' = 'Filter';

  value $CTTHVWV
    'STOPWORDS' = 'STOPWORDS'
     'SYNONYMS' = 'SYNONYMS'
        'TERMS' = 'TERMS';

  value $CTSAUDV
    ;

  value $CTSRCMV
    'Unspecified' = 'Unspecified';

  value $DISA15V
    'A' = 'A. More frequent'
    'B' = 'B. Less frequent'
    'C' = 'C. About the same';

  value $DISA16V
    'A' = 'A. Very stressful'
    'B' = 'B. Moderately stressful'
    'C' = 'C. Not stressful';

  value $DISA3AV
    'A' = 'A. Speak up'
    'B' = 'B. Accept it'
    'C' = 'C. Ignore it'
    'D' = 'D. Try to change it'
    'E' = 'E. Keep it to yourself'
    'F' = 'F. Work harder to prove them wrong'
    'G' = 'G. Pray'
    'H' = 'H. Avoid it'
    'I' = 'I. Get violent'
    'J' = 'J. Forget it'
    'K' = 'K. Blame yourself'
    'L' = 'L. Other';

  value $DISA6AV
    'N' = 'N. No'
    'W' = 'W. Never worked'
    'Y' = 'Y. Yes';

  value $DISAR1V
    'A' = 'A. Several times a day'
    'B' = 'B. Almost every day'
    'C' = 'C. At least once a week'
    'D' = 'D. A few times a month'
    'E' = 'E. A few times a year'
    'F' = 'F. Less than a few times a year'
    'G' = 'G. Never';

  value $DISARAV
    'A' = 'A. A lot'
    'B' = 'B. Some'
    'C' = 'C. A little';

  value $DISARBV
    'A' = 'A. A lot'
    'B' = 'B. Some'
    'C' = 'C. A little'
    'D' = 'D. Not at all';

  value $DISARCV
    'A' = 'A. A lot better'
    'B' = 'B. Somewhat better'
    'C' = 'C. No different'
    'D' = 'D. Somewhat worse'
    'E' = 'E. A lot worse';

  value $DISAR2V
    'A' = 'A. Your age'
    'B' = 'B. Your gender'
    'C' = 'C. Your race'
    'D' = 'D. Your height or weight'
    'E' = 'E. Some other reason for discrimination';

  value $ELGA29V
    'A' = 'A. Saturday'
    'F' = 'F. Friday'
    'H' = 'H. Thursday'
    'M' = 'M. Monday'
    'N' = 'N. Not indicated'
    'S' = 'S. Sunday'
    'T' = 'T. Tuesday'
    'W' = 'W. Wednesday';

  value $ELGARAV
    'M' = 'Moderately Important'
    'N' = 'Not Important'
    'V' = 'Very Important';

  value $FLKA2V
    'I' = 'Index'
    'S' = 'Secondary';

  value $FTRA4V
    'B' = 'Before Yesterday'
    'T' = 'Today'
    'Y' = 'Yesterday';

  value $HCAA11V
    'A' = 'A. Very satisfied'
    'B' = 'B. Somewhat satisfied'
    'C' = 'C. Somewhat dissatisfied'
    'D' = 'D. Very dissatisfied'
    'E' = 'E. Not sure';

  value $HCAA2AV
    'A' = 'A. Walk-in clinic'
    'B' = 'B. HMO clinic'
    'C' = 'C. Hospital clinic'
    'D' = 'D. Neighbourhood health center'
    'E' = 'E. Hospital emergency room'
    'F' = 'F. Public health department clinic'
    'G' = 'G. Company or industry clinic'
    'H' = 'H. Doctor''s office'
    'I' = 'I. Other';

  value $HCAA3V
    'A' = 'A. Very much'
    'B' = 'B. Somewhat'
    'C' = 'C. Not very much'
    'D' = 'D. Not at all';

  value $HCAA5V
    'A' = 'A. Within the past year'
    'B' = 'B. Atleast 1 year but less than 2 years ago'
    'C' = 'C. At least 2 years but less than 4 years ago'
    'D' = 'D. 5 or more years ago'
    'E' = 'E. Never';

  value $HCAA6V
    'A' = 'A. Very hard'
    'B' = 'B. Fairly hard'
    'C' = 'C. Not too hard'
    'D' = 'D. Not hard at all';

  value $HEFARAV
    'Y' = 'Yes';

  value $HEFARBV
    'D' = 'Divorced'
    'M' = 'Married'
    'N' = 'Never Married'
    'S' = 'Separated'
    'W' = 'Widowed';

  value $HERARFV
     'A' = 'A. Community mobilization effort initiated'
    'AA' = 'AA.Telephone-no answer'
     'B' = 'B. Introduction letter sent'
    'BB' = 'BB.Busy signal'
     'C' = 'C. No one home'
    'CC' = 'CC.Answering machine/left message'
     'D' = 'D. No eligible respondent home'
    'DD' = 'DD.Privacy block'
     'E' = 'E. Refusal'
    'EE' = 'EE.Disconnected/non-working number'
     'F' = 'F. Language barrier'
    'FF' = 'FF.Recording/number change'
     'G' = 'G. Physically/mentally incompetent'
     'H' = 'H. Vacant'
     'I' = 'I. Demolished/merged/not a housing unit'
     'J' = 'J. Vacation/Second home'
     'K' = 'K. Temporarily away'
     'L' = 'L. HEF partially complete'
     'M' = 'M. Tracing required'
     'N' = 'N. Moved from study area'
     'O' = 'O. Deceased'
     'P' = 'P. HEF appointment pending'
     'Q' = 'Q. HEF appointment broken'
     'R' = 'R. Other(Specify in notes, above)'
     'S' = 'S. Age/race ineligible'
     'T' = 'T. Terminated'
     'U' = 'U. HEF Appointment deferred; recontact'
     'V' = 'V. Unable to locate/contact'
     'Z' = 'Z. HEF complete';

  value $ICTA1V
  'F' = 'Full'
  'P' = 'Partial'
  ;
  value $ICTA4BV
  'F' = 'Full restriction (release no results)'
  'P' = 'Partial restriction'
  ;
  value $ICTARAV
  'A' = 'A. Jackson Heart Study only'
  'C' = 'C. CVD research'
  'N' = 'N. No use/storage of DNA'
  'O' = 'O. Other'
  ;
  value $ICTARBV
  'A' = 'A. Jackson Heart Study only'
  'C' = 'C. CVD research'
  'O' = 'O. Other'
  ;
  value $ICTARCV
  'N' = 'No'
  'P' = 'Partial'
  'Y' = 'Yes'
  ;
  value $IRCARFV
     'A' = 'A. Community mobilization effort initiated'
    'AA' = 'AA.Telephone-no answer'
     'B' = 'B. Introduction letter sent'
    'BB' = 'BB.Busy signal'
     'C' = 'C. No one home'
    'CC' = 'CC.Answering machine/left message'
     'D' = 'D. No eligible respondent home'
    'DD' = 'DD.Privacy block'
     'E' = 'E. Refusal'
    'EE' = 'EE.Disconnected/non-working number'
     'F' = 'F. Language barrier'
    'FF' = 'FF.Recording/number change'
     'G' = 'G. Physically/mentally incompetent'
     'H' = 'H. Vacant'
     'I' = 'I. Sick or hospitalized'
     'J' = 'J. On vacation'
     'K' = 'K. Temporarily away'
     'L' = 'L. IRC partially complete'
     'M' = 'M. Tracing required'
     'N' = 'N. Moved from study area'
     'O' = 'O. Deceased'
     'P' = 'P. IRC appointment pending'
     'Q' = 'Q. IRC appointment broken'
     'R' = 'R. Other (Specify in notes, above)'
     'S' = 'S. Age/race ineligible'
     'T' = 'T. Terminated'
     'U' = 'U. HEF appointment deferred;recontact'
     'V' = 'V. Unable to locate/contact'
     'Z' = 'Z. Home Induction complete';

  value ISLAR1V
    1 = '1. Definitely True'
    2 = '2. Probably True'
    3 = '3. Probably False'
    4 = '4. Definitely False';

  value $JH_AMPV
    'A' = 'AM'
    'P' = 'PM';

  value $JH_CPV
    'C' = 'Computer'
    'P' = 'Paper';

  value $JH_CUFV
    'L' = 'Large (33-41 cm)'
    'R' = 'Regular (24-32 cm)'
    'S' = 'Small adult (<24 cm)'
    'T' = 'Thigh (>41 cm)';

  value $JH_DAYV
    'A' = 'A. Saturday'
    'F' = 'F. Friday'
    'H' = 'H. Thursday'
    'M' = 'M. Monday'
    'S' = 'S. Sunday'
    'T' = 'T. Tuesday'
    'W' = 'W. Wednesday';

  value $JH_LRV
    'L' = 'Left'
    'R' = 'Right';

  value $JH_MFV
    'F' = 'F. Female'
    'M' = 'M. Male';

  value $JH_STAV
    'AK' = 'AK. Alaska'
    'AL' = 'AL. Alabama'
    'AR' = 'AR. Arkansas'
    'AZ' = 'AZ. Arizona'
    'CA' = 'CA. California'
    'CN' = 'CN. Canada'
    'CO' = 'CO. Colorado'
    'CT' = 'CT. Connecticut'
    'CU' = 'CU. Cuba'
    'DC' = 'DC. Washington, DC'
    'DE' = 'DE. Delaware'
    'FL' = 'FL. Florida'
    'GA' = 'GA. Georgia'
    'GU' = 'GU. Guam'
    'HI' = 'HI. Hawaii'
    'IA' = 'IA. Iowa'
    'ID' = 'ID. Idaho'
    'IL' = 'IL. Illinois'
    'IN' = 'IN. Indiana'
    'KS' = 'KS. Kansas'
    'KY' = 'KY. Kentucky'
    'LA' = 'LA. Louisiana'
    'MA' = 'MA. Massachusetts'
    'MD' = 'MD. Maryland'
    'ME' = 'ME. Maine'
    'MI' = 'MI. Michigan'
    'MN' = 'MN. Minnesota'
    'MO' = 'MO. Missouri'
    'MS' = 'MS. Mississippi'
    'MT' = 'MT. Montana'
    'MX' = 'MX. Mexico'
    'NC' = 'NC. North Carolina'
    'ND' = 'ND. North Dakota'
    'NE' = 'NE. Nebraska'
    'NH' = 'NH. New Hampshire'
    'NJ' = 'NJ. New Jersey'
    'NM' = 'NM. New Mexico'
    'NV' = 'NV. Nevada'
    'NY' = 'NY. New York'
    'OH' = 'OH. Ohio'
    'OK' = 'OK. Oklahoma'
    'OR' = 'OR. Oregon'
    'PA' = 'PA. Pennsylvania'
    'PR' = 'PR. Puerto Rico'
    'RI' = 'RI. Rhode Island'
    'RW' = 'RW. Remainder of World'
    'SC' = 'SC. South Carolina'
    'SD' = 'SD. South Dakota'
    'TN' = 'TN. Tennessee'
    'TX' = 'TX. Texas'
    'UT' = 'UT. Utah'
    'VA' = 'VA. Virginia'
    'VI' = 'VI. Virgin Islands'
    'VT' = 'VT. Vermont'
    'WA' = 'WA. Washington'
    'WI' = 'WI. Wisconsin'
    'WV' = 'WV. West Virginia'
    'WY' = 'WY. Wyoming';

  value $JH_YNV
    'N' = 'No'
    'Y' = 'Yes';

  value $JH_YNDV
    'D' = 'Dont know'
    'N' = 'No'
    'Y' = 'Yes';

  value $JH_YNUV
    N = 'No'
    U = 'Unknown'
    Y = 'Yes';

  value $LEIA3AV
    'A' = 'A. Normal'
    'B' = 'B. Abnormal'
    'X' = 'X. Results not expected';

  value $LEIAR2V
    'A' = 'A. Normal'
    'B' = 'B. Minor abnormal'
    'C' = 'C. Major abnormal'
    'X' = 'X. Results not expected';

  value $MHXA17V
    'A' = 'A. Angina'
    'D' = 'D. Other Heart Disease'
    'H' = 'H. Heart attack'
    'O' = 'O. Other';

  value $MHXA19V
    'A' = 'A. 1 month'
    'B' = 'B. 6 months'
    'C' = 'C. 1 year'
    'D' = 'D. 2 years'
    'E' = 'E. Over 2 years';

  value $MHXA31V
    'H' = 'Heart Attack'
    'O' = 'Other disorder';

  value $MHXA36V
    'A' = 'Abnormal'
    'D' = 'Dont know'
    'N' = 'Normal';

  value $MHXA39V
    'C' = 'C. Pain includes calf/calves'
    'N' = 'N. Pain does not include calf/calves';

  value $MHXA52V
    'B' = 'Both'
    'L' = 'Left'
    'R' = 'Right';

  value $MHXA6V
    'E' = 'Excellent'
    'F' = 'Fair'
    'G' = 'Good'
    'P' = 'Poor'
    'V' = 'Very good';

  value $MHXAR1V
    'A' = 'A. Never'
    'B' = 'B. Seldom'
    'C' = 'C. Sometimes'
    'D' = 'D. Often'
    'E' = 'E. Almost Always';

  value $MHXARAV
    'C' = 'Carry on'
    'S' = 'Stop or slow down';

  value $MHXARBV
    'N' = 'Not relieved'
    'R' = 'Relieved';

  value $MHXARCV
    'L' = 'L. 10 minutes or less'
    'M' = 'M. More than 10 minutes';

  value $MHXAR9V
    'H' = 'H. Never hurries or walks uphill'
    'N' = 'N. No'
    'Y' = 'Y. Yes';

  value $MSRA1V
    'N' = 'No'
    'S' = 'Some of them'
    'Y' = 'Yes, all';

  value $MSRA2V
    'F' = 'Forgot or was unable to bring medications'
    'T' = 'Took no medications';

  value $MSRAAV
    'A' = 'A. Less than 300 mg (Baby)'
    'B' = 'B. 300 - 499 mg (Regular)'
    'C' = 'C. 500 mg or greater (Extra strength)'
    'D' = 'D. Don''t know';

  value $MSRABV
    'H' = 'H. Participant mentioned to avoid heart attack or stroke'
    'O' = 'O. Participant did NOT mention to avoid heart or attack or stroke';

  value $MSRA35V
    'I' = 'Ibuprofen or Advil'
    'O' = 'Other';

  value $MSRA3AV
    'N' = 'No or not applicable'
    'Y' = 'Yes';

  value $MSRACV
    'H' = 'Heart'
    'O' = 'Other';

  value $MSRADV
    'A' = 'A. Almost never'
    'D' = 'D. Daily'
    'M' = 'M. Monthly'
    'N' = 'N. Never'
    'R' = 'R. Rarely'
    'S' = 'S. Several times a month'
    'T' = 'T. Several times a year'
    'W' = 'W. Weekly'
    'Y' = 'Y. Yearly';

  value $MSRAR3V
    'D' = 'D. Don''t Know'
    'N' = 'N. Not a Reason'
    'Y' = 'Y. Reason Indicated';

  value $OBSA1V
    'F' = 'Fair'
    'G' = 'Good'
    'P' = 'Poor'
    'V' = 'Very good';

  value $OBSA11V
    'A' = 'A. A great deal'
    'B' = 'B. A lot'
    'C' = 'C. Not too much'
    'D' = 'D. Not at all';

  value $OBSA7V
    'F' = 'Fair quality'
    'G' = 'Good quality'
    'H' = 'High Quality'
    'P' = 'Poor quality';

  value $PACA1V
    'A' = 'A. Less than 5 minutes'
    'B' = 'B. At least 5 but less than 15 minutes'
    'C' = 'C. At least 15 but less than 30 minutes'
    'D' = 'D.At least 30 but less than 45 minutes'
    'E' = 'E. At least 45 minutes';

  value $PACA12V
    'A' = 'A. Less than 1 hour per week'
    'B' = 'B. At least 1 but less than 20 hours per week'
    'C' = 'C. More than 20 hours per week';

  value $PACA13V
    'A' = 'A. Less than 1/2 hour per day'
    'B' = 'B. At least 1/2 hour but less than 1 hour per day'
    'C' = 'C. At least 1 hour but less than 1 1/2 hours per day'
    'D' = 'D. At least 1 1/2 hours but less than 2 hours per day'
    'E' = 'E. 2 or more hours per day';

  value $PACA2V
    'A' = 'A. Less than 5 blocks'
    'B' = 'B. At least 5 but less than 10 blocks'
    'C' = 'C. At least 10  but less than 15 blocks'
    'D' = 'D. At least 15 but less than 20 blocks'
    'E' = 'E. More than 20 blocks';

  value $PACA20V
    'A' = 'A. Never or less than once a month'
    'B' = 'B. Once a month'
    'C' = 'C. 2-3 times a month'
    'D' = 'D. Once a week'
    'E' = 'E. More than once a week';

  value $PACA30V
    'A' = 'A. Much less'
    'B' = 'B. Less'
    'C' = 'C. Same as'
    'D' = 'D. More'
    'E' = 'E. Much more';

  value $PACA6V
    'A' = 'A. Less than 1 hour a week'
    'B' = 'B. At least 1 hour a week but less than 7 hours a week'
    'C' = 'C. At least 1 hour a day but less than 2 hours a day'
    'D' = 'D. At least 2 hours a day but less than 4 hours a day'
    'E' = 'E.4 or more hours a day';

  value $PACA9V
    'A' = 'A. Much lighter'
    'B' = 'B. Lighter'
    'C' = 'C. The same as'
    'D' = 'D. Heavier'
    'E' = 'E. Much heavier';

  value $PACARAV
    'A' = 'A. Less than one month'
    'B' = 'B. 1 to 3 months'
    'C' = 'C. 4 to 6 months'
    'D' = 'D. 7 to 9 months'
    'E' = 'E. More than 9 months';

  value $PACARBV
    'A' = 'A. Less than 1 hour'
    'B' = 'B. At least 1 but less than 2 hours'
    'C' = 'C. At least 2 but less than 3 hours'
    'D' = 'D. At least 3 but less than 4 hours'
    'E' = 'E. 4 or more hours';

  value $PACAR3V
    'A' = 'A. Less than once a month'
    'B' = 'B. Once a month'
    'C' = 'C. 2-3 times a month'
    'D' = 'D. Once a week'
    'E' = 'E. More than once a week';

  value $PACAR6V
    'A' = 'A. Never'
    'B' = 'B. Seldom'
    'C' = 'C. Sometimes'
    'D' = 'D. Often'
    'E' = 'E. Always';

  value $PDSA11V
    'D' = 'Dissatisfied'
    'N' = 'Neither'
    'S' = 'Satisfied';

  value $PDSA17V
    'F' = 'Fairly disappointed'
    'N' = 'Not at all disappointed'
    'S' = 'Slightly disappointed'
    'V' = 'Very disappointed';

  value $PDSA21V
    'N' = 'N. No'
    'P' = 'P. Yes, in the past'
    'Y' = 'Y. Yes, currently';

  value $PDSA24V
    'B' = 'Buying (paying a mortgage)'
    'D' = 'Don''t know'
    'N' = 'Neither owns nor pays rent'
    'O' = 'Owns'
    'P' = 'Pays rent';

  value $PDSA25V
    'M' = 'M. Yes, more than one'
    'N' = 'N. No'
    'O' = 'O. Yes, one';

  value $PDSA26V
    'A' = 'A. $0 - 499'
    'B' = 'B. $500 - 999'
    'C' = 'C. $1,000 - 4,999'
    'D' = 'D. $5,000 - 9,999'
    'E' = 'E. $10,000 - 19,999'
    'F' = 'F. $20,000 - 49,999'
    'G' = 'G. $50,000 - 99,999'
    'H' = 'H. $100,000 - 199,999'
    'I' = 'I. $200,000 or more'
    'J' = 'J. Don''t know'
    'K' = 'K. Refused';

  value $PDSA28V
    'A' = 'A. Less than $5,000'
    'B' = 'B. $5,000 - 7,999'
    'C' = 'C. $8,000 - 11,999'
    'D' = 'D. $12,000 - 15,999'
    'E' = 'E. $16,000 - 19,999'
    'F' = 'F. $20,000 - 24,999'
    'G' = 'G. $25,000 - 34,999'
    'H' = 'H. $35,000 - 49,999'
    'I' = 'I. $50,000 - 74,999'
    'J' = 'J. $75,000 - 99,999'
    'K' = 'K. $100,000 or more'
    'L' = 'L. Don''t Know'
    'M' = 'M. Refused';

  value $PDSA3V
    'A' = 'A. Working now, full-time'
    'B' = 'B. Working now, part-time'
    'C' = 'C. Employed, but temporarily laid off'
    'D' = 'D. Sick or on leave for health reasons'
    'E' = 'E. Unemployed, looking for work'
    'F' = 'F. Unemployed, not looking for work'
    'G' = 'G. Homemaker, not working outside the home'
    'H' = 'H. Retired from my usual job and not working'
    'I' = 'I. Retired from my usual job but working for pay';

  value $PDSA5V
    'M' = 'More than one'
    'O' = 'One';

  value $PDSA9BV
    'D' = 'Don''t Know'
    'F' = 'Frequent layoffs'
    'O' = 'Other'
    'R' = 'Regular, steady work'
    'S' = 'Seasonal';

  value $PDSARAV
    'N' = 'NO/DK'
    'R' = 'Refused'
    'Y' = 'Yes';

  value $PDSARBV
    'D' = 'Don''t Know'
    'N' = 'No'
    'R' = 'Refused'
    'Y' = 'Yes';

  value $PFHA1V
    'E' = 'E. Excellent'
    'F' = 'F. Fair'
    'G' = 'G. Good'
    'P' = 'P. Poor';

  value $PFHARAV
    'A' = 'A. Heart attack'
    'C' = 'C. Cancer'
    'O' = 'O. Other (Specify)'
    'S' = 'S. Stroke'
    'U' = 'U. Unknown';

  value $PPAA7V
    'A' = 'A. Very comfortable'
    'B' = 'B. Somewhat comfortable'
    'C' = 'C. Somewhat uncomfortable'
    'D' = 'D. Very uncomfortable'
    'E' = 'E. Not sure';

  value $RCPA1V
    'A' = 'A. Nearly every day'
    'B' = 'B. At least once a week'
    'C' = 'C. A few times a month'
    'D' = 'D. A few times a year'
    'E' = 'E. Less than once a year'
    'F' = 'F. Not at all';

  value $RCPA2V
    'A' = 'A. More than once a day'
    'B' = 'B. Once a day'
    'C' = 'C. A few times a week'
    'D' = 'D. Once a week'
    'E' = 'E. A few times a month'
    'F' = 'F. Once a month'
    'G' = 'G. Less than once a month'
    'H' = 'H. Never';

  value $RCPA3V
    'A' = 'A. Never'
    'B' = 'B. Once in a while'
    'C' = 'C. Some days'
    'D' = 'D. Most days'
    'E' = 'E. Every day'
    'F' = 'F. Many times a day';

  value $RCPA4V
    'A' = 'A. Very involved'
    'B' = 'B. Somewhat involved'
    'C' = 'C. Not very involved'
    'D' = 'D. Not involved at all';

  value $RCPA5V
    'A' = 'A. Strongly Agree'
    'B' = 'B. Agree Somewhat'
    'C' = 'C. Disagree Somewhat'
    'D' = 'D. Strongly Disagree';

  value $RHXA10V
    'D' = 'Don''t know'
    'N' = 'Natural'
    'R' = 'Radiation'
    'S' = 'Surgery';

  value $RHXA33V
    'B' = 'B. Yes, both'
    'D' = 'D. Don''t know'
    'N' = 'N. No'
    'O' = 'O. Yes, one';

  value $RHXA6V
    'D' = 'Don''t know'
    'H' = 'Hormones'
    'I' = 'Illness'
    'N' = 'Natural period'
    'O' = 'Other';

  value $SBPE7V
    'L' = 'Large arm {33-41cm}'
    'R' = 'Regular arm {24-32 cm}'
    'S' = 'Small adult {<24 cm}'
    'T' = 'Thigh {>41 cm}';

  value $SOCA1AV
    'D' = 'Divorced'
    'M' = 'Married'
    'N' = 'Never been married'
    'S' = 'Separated'
    'W' = 'Widowed';

  value $SOCAR3V
    'A' = 'A. A great deal'
    'B' = 'B. Quite a bit'
    'C' = 'C. Some'
    'D' = 'D. A little'
    'E' = 'E. Not at all';

  value $SOCAR5V
    'A' = 'A. None'
    'B' = 'B. 1 or 2'
    'C' = 'C. 3 to 5'
    'D' = 'D. 6 to 9'
    'E' = 'E. 10 or more';

  value $SSFA5EV
    'A' = 'A. Slurred speech'
    'B' = 'B. Wrong words came out'
    'C' = 'C. Words would not come out'
    'D' = 'D. Could not think of the right words';

  value $SSFA9AV
    'B' = 'B. Both eyes'
    'L' = 'L. Only the left eye'
    'R' = 'R. Only the right eye';

  value $SSFA9BV
    'B' = 'B. Trouble seeing both sides or straight ahead'
    'L' = 'L. Trouble seeing to the left, but not to right'
    'R' = 'R. Trouble seeing to the right, but not to left';

  value $SSFARCV
    'D' = 'D. Don''t Know'
    'O' = 'O. Stayed in one part'
    'S' = 'S. Started in one part and spread to another';

  value $SSFARAV
    'B' = 'B. Both sides'
    'L' = 'L. The left side only'
    'R' = 'R. The right side only';

  value $SSFARBV
    'A' = 'A. Double vision'
    'B' = 'B. Vision loss in right eye only'
    'C' = 'C. Vision loss in left eye only'
    'D' = 'D. Total loss of vision in both eyes'
    'E' = 'E. Trouble in both eyes seeing to the right'
    'F' = 'F. Trouble in both eyes seeing to the left'
    'G' = 'G. Trouble in both eyes seeing to both sides or straight ahead';

  value $STSA1RV
    'A' = 'A. Not Stressful'
    'B' = 'B. Mildly Stressful'
    'C' = 'C. Moderately Stressful'
    'D' = 'D. Very Stressful';

  value STXAR1V
    1 = '1. Almost Never'
    2 = '2. Sometimes'
    3 = '3. Often'
    4 = '4. Almost Always';

  value $TOBA13V
    'D' = 'Deeply'
    'M' = 'Moderately'
    'N' = 'Not at all'
    'S' = 'Slightly';

  value $TOBA7V
    'A' = 'A. 0-5 minutes'
    'B' = 'B. 6-30 minutes'
    'C' = 'C. 31-60 minutes'
    'D' = 'D. 61 minutes or more';

  value $TOBA8V
    'A' = 'Any other'
    'F' = 'First of the day';

  value $URNA9V
    'C' = 'Clinic pick-up'
    'P' = 'Participant delivery';

  value $URNAR4V
    'B' = 'B. Both'
    'F' = 'F. Second 24-hour urine collection'
    'N' = 'N. Neither'
    'T' = 'T. 24-hour urine collection';

  value $URRAR5V
    'A' = 'A. Refrigerator'
    'B' = 'B. At work; not refrigerated'
    'C' = 'C. At home; not refrigerated'
    'D' = 'D. In a cooler'
    'E' = 'E. In the car';

  value $URRAR7V
    'A' = 'A. Very convenient'
    'B' = 'B. Somewhat convenient'
    'C' = 'C. Somewhat inconvenient'
    'D' = 'D. Very inconvenient'
    'E' = 'E. Not sure';

  value $VENA19V
    'B' = 'B. Yes, both'
    'N' = 'N. No'
    'O' = 'O. Yes, tube 7 only';

  value $VENA20V
    'B' = 'B. Yes, both'
    'N' = 'N. No'
    'O' = 'O. Yes, tube 9 only';

  value $VENA7AV
    'B' = 'B. Yes, both'
    'N' = 'N. No'
    'O' = 'O. Yes, tube 1 only';

  value $VENA8AV
    'B' = 'B. Yes, both'
    'N' = 'N. No'
    'O' = 'O. Yes, tube 3 only';

  value $VENA9AV
    'B' = 'B. Yes, both'
    'N' = 'N. No'
    'O' = 'O. Yes, tube 5 only';

  value $VENAR5V
    'X' = 'X';

  value WSIAR1V
    0 = '0. Did Not Happen'
    1 = '1. Not Stressful'
    2 = '2. Slightly Stressful'
    3 = '3. Mildly Stressful'
    4 = '4. Moderately Stressful'
    5 = '5. Stressful'
    6 = '6. Very Stressful'
    7 = '7. Extremely Stressful';

***************Yan Gao added formats on 3/20/2014**************;

  value ADA00CL
    0 = 'Hypoglycemia'                                   
    1 = 'Normal'                                                                 
    2 = 'Impaired Fasting Glucose (IFG)'                                       
    3 = 'Diabetes';

  value ADA04CL
    1 = 'Normal '
    2 = 'Impaired Fasting Glucose (IFG)'
    3 = 'Diabetes';

  value AFOB31V 
     1 = 'A big problem'                           
	 2 = 'A small problem'                         
	 3 = 'Not a problem'                           
	 7 = 'Don''t Know ' 
     8 = 'Refused'
     9 = 'Missing' ;

  value AGEGROUP
     1 = '21-39'                                  
     2 = '40-59'                                   
     3 = '60+'  ;

  value AGEGRPV  
   	 1 = '21 - 34'                                 
     2 = '35 - 44'                                 
     3 = '45 - 64'                                 
     4 = '65 plus';  

  value ALC1C 
     0 = 'Abstainer or < 1 drink/week '           
     1 = '1-7 drinks per week '                    
     2 = '8-14 drinks per week '                   
     3 = '> 14 drinks/week '    ;                   
  
  value ALC2C
     0 = 'Virtual non-drinker (Abstainer or 0 drinks per day'  
     1 = '<=2 drinks for men and <=1 drinks for women and elderly'  
     2 = '> 2 drinks for men and > 1 for women and elderly';

  value AWARE
     0 = 'Unaware'
     1 = 'Aware'
     99= 'Unknown'  ;

  value BMIGRPV
     0 = '< 25'                                    
     1 = '25 - 30'                               
     2 = '>=30'  ;

  value BPMED
     0 = 'Untreated '
     1 = 'Treated'
     99= 'Unknown'  ;


 value COFE1V
 	 1 = 'Yes'
     2 = 'No';

value COMMERCE
 	 1 = 'Yes'
     2 = 'No';

value  CONTROL
 	 1 = 'Uncontrolled'
     2 = 'Controlled ';

value DIABF
     0 = 'Normal'    
     1 = 'Pre-diabetes or impaired fasting glucose' 
     2 = 'Diabetes';

  value DIFHC
     0 = 'No, if not too hard or not hard at all to get services'
     1 = 'Yes, if fairly or very hard to get services needed';

  value DNA
     0 = 'No'   
     1 = 'DNA only'                                 
     2 = 'DNA and cryoperservation'  ;

value DNT
     0 = 'No'   
     1 = 'Yes'   ;                              

  value DROHC 
     0 = 'No,otherwise'   
     1 = 'Yes,if usual place of care is doctors office'   ;                              

  value ED1L
 	 1 = 'Less than High school'                   
     2 = 'High school/GED'                         
     3 = 'Some or completed vocational school or some college'
     4 = 'Associate degree'                       
     5 = 'Bachelor degree'                         
     6 = 'Post-college';                            

  value ED2L
 	 1 = 'Less than High school'                   
     2 = 'High school/GED'      
     3 = '> HS but < Bachelor degree'
     4 = 'Bachelor degree or higher';

  value ED3L
 	 1 = 'Less than High school'                   
     2 = 'High school/GED or Some College'         
     3 = 'College/associate  degree or higher ';    

  value EDU 
 	 1 = 'Less than High school'                   
     2 = 'High school or some College'            
     3 = 'College degree or higher';      

  value EDUCF
 	 1 = 'Grade School or 0 years education'       
     2 = 'High School, but no degree'
     3 = 'High School graduate'                    
     4 = 'Vocational School'                       
     5 = 'College ' 
     6 = 'Graduate School or Professional School';  

  value EDUGRPV
     0 = '< HS'                                    
   	 1 = 'HS GRAD-Some College'
     2 = 'College or Better'   ;                    

  value EPITEST
     0 = 'Missing consent (exlcude all data)'      
     1 = 'No testing for diseases '                
     2 = 'LAB data cannot be used  '               
     3 = 'CVD+ analyses only '                       
     4 = 'LAB data can be used for CVD+ analyses ONLY'
     5 = 'No restrictions ';

  value GENDERV 
     0 = 'Female'  
     1 = 'Male'; 
 
  value GENETICS
 	 0 = 'No'
     1 = 'Genotyped and studied only by JHS researches for CVD+ only'
     2 = 'Genotyped & cryopreserved and studied only by JHS researches for CVD+ only'
     3 = 'Genotyped and studied by JHS and other researches for CVD+ only'
     4 = 'Genotyped & cryopreserved and studied by JHS and other researches for CVD+ only'
     5 = 'Genotyped and studied only by JHS researches for any diseases'
     6 = 'Genotyped & cryopreserved and studied only by JHS researches for any diseases'
     7 = 'Genotyped and studied by JHS and other researches for any diseases'
     8 = 'Genotyped/cryopreserved and studied by JHS and other researches for any diseases';

  value GENSTAT
 	 0 = 'Absent'  
 	 1 = 'Absent per Self-Report'                  
     2 = 'Present per Self-Report '                
     3 = 'Present ';

  value GIC  
  	 0 = 'No' 
     1 = 'Genotyped and studied only by JHS researches for CVD+ only'
     2 = 'Genotyped and studied by JHS and other researches for CVD+ only'
     3 = 'Genotyped and studied by JHS researchers, other researchers, and for profit entities for CVD+ only'
     4 = 'Genotyped and studied only by JHS researches for any diseases'
     5 = 'Genotyped and studied by JHS and other researches for any diseases'
     6 = 'Genotyped and studied by JHS researchers, and for profit entities for any diseases';

  value HCAA  
 	 1 = 'Not hard at all'                         
     2 = 'Not too hard '                           
     3 = 'Fairly hard '                            
     4 = 'Very hard ';                              

 
  value HCL
  	 0 = 'Absent' 
     1 = 'Present';

  value HDL3CL   
 	 1 = 'Low'
     2 = 'Normal '
     3 = 'High';

  value HHYN  
  	 0 = 'No' 
     1 = 'Yes';

  value HSTGP
  	 0 = 'Poor' 
     1 = 'Good';

  value HTN      
  	 0 = 'Normotensive' 
     1 = 'Hypertensive';

  value HTNF
  	 0 = 'Non Hypertensive'                        
     1 = 'Hypertensive';

  value INC
 	 1 = 'Poor'
     2 = 'Lower-middle'                            
     3 = 'Upper-middle'                            
     4 = 'Affluent';

  value INCOME
 	 1 = 'Low '
     2 = 'Medium'
     3 = 'High'
     99 = 'Unknown';

  value INCOMV
     0 = 'Low' 
     1 = 'Middle '
     2 = 'High';

  value INCV 
 	 1 = 'Low'
     2 = 'Lower-Middle'                            
     3 = 'Upper-Middle'                            
     4 = 'Affluent'  ;

  value INS
  	 0 = 'No,otherwise ' 
     1 = 'Yes,if has any kind of insurance ';

  value INS1TP 
   	 1 = 'Private'                                 
     2 = 'VA/CHAMPUS'                             
     3 = 'Medicare'
     4 = 'Medicaid'
     5 = 'Uninsured';

  value INS2TP
 	 1 = 'Combination(any two or more types) '
     2 = 'Private '
     3 = 'VA/CHAMPUS '                             
     4 = 'Medicare '
     5 = 'Medicaid '
     6 = 'No insurance ';

  value INS3TP 
 	 1 = 'Both private and public '                
     2 = 'Private '
     3 = 'Public '
     4 = 'No insurance '     ;                      


  value INS4CAT
  	 0 = 'No,otherwise'                            
     1 = 'Yes,if has any type of public insurance ';

  value INS5CAT
 	 1 = 'Private '
     2 = 'Public'
     3 = 'Uninsured ';

  value JH_COHTV 
  	 0 = 'Eligible for Analysis '                  
  	 1 = 'Ineligible Due to Age '                 
     2 = 'Ineligible Due Family Study ';            

  value JNC6CL 
     0 = 'Optimal'
     1 = 'Normal'
     2 = 'High-Normal'                             
     3 = 'Hypertension Stage I'                    
     4 = 'Hypertension Stage II'                   
     5 = 'Hypertension Stage III';                  

  value JNC7CL
  	 0 = 'Normal' 
  	 1 = 'Pre-Hypertension '
     2 = 'Hypertension Stage I '
     3 = 'Hypertension Stage II ';

  value LDL3CL
  	 1 = 'Optimal '
     2 = 'Near/Above Optimal'
     3 = 'Borderline High'
     4 = 'High'
     5 = 'Very High';                               

  value LPFAST
  	 0 = 'Non-fasted'                              
     1 = 'Fasted (8 or more hours)';

  value MED
     0 = 'Untreated' 
     1 = 'Treated';

  value MEDCT
  	 0 = 'No medication data ' 
  	 1 = 'There are listed medications and the information appears reliable'
     2 = 'Participant reported that no medication had been taken in 2 weeks preceeding the '
     99 = 'Medication accountability is incomplete /unreliable ';

  value MEDTYPE
     0 = 'Oral Only '
  	 1 = 'Insulin Only'                            
     2 = 'Insulin and Oral';                        

  value MISSMI
  	 1 = 'No PFHA'                                 
     2 = ' ';

  value OCCV
  	 1 = 'Management'
     2 = 'Service  '
     3 = 'Sales '
     4 = 'Farming '
     5 = 'Construction '
     6 = 'Production '
     7 = 'Military'
  	 8 = 'Employed Temporarily'                    
  	 9 = 'Sick '
     10 = 'Unemployed '
     11 = 'Homemaker'
     12 = 'Retired '
     13 = 'Student ';

  value PGRADEV
  	 0 = 'Negative, no fluorescence(NEG)'          
  	 1 = '1+, definite, but dim fluorescence(POS) '
     2 = '2+, moderate to intense fluorescence(POS)'
     3 = '3+, moderate to intense fluorescence(POS)'
     4 = '4+, moderate to intense fluorescence(POS)';

  value PRVHC
  	 0 = 'No,if went at least 1 year ago or never ' 
     1 = 'Yes,if went for physical or general  check-up within the past year ';

  value RPFHAV
  	 0 = 'Fair_Poor'                              
     1 = 'Excellent_Good ';

  value SATHC  
  	 1 = 'Yes,if very or somewhat satisfied'
     2 = 'No,if somewhat or very dissatisfied ';

  value SEX
     0 = 'Male' 
     1 = 'Female';

  value SMKCATF
  	 0 = 'Non Smoker'                               
  	 1 = 'Previous Smoker'                         
     2 = 'Current Smoker';                          

  value SMKV     
  	 0 = 'Never Smoked'                             
  	 1 = 'Former Smoker'                           
     2 = 'Current Smoker';                          

  value SMPLV 
  	 0 = 'Chemistry' 
  	 1 = 'Urine'
     2 = '24 Hour Urine'                           
     3 = 'Spot Urine';                              

  value STATUS
  	 0 = 'Absent ' 
     1 = 'Present ';

  value STUDY
  	 0 = 'No' 
  	 1 = 'JHS investigators only '
     2 = 'JHS and other investigators ';

  value TCL3CL 
  	 1 = 'Desirable (normal)'                    
     2 = 'Borderline High'                         
     3 = 'High';

  value TEST
  	 0 = 'No' 
  	 1 = 'CVD+'                                    
     2 = 'All Major';                              

  value TRG3CL
  	 1 = 'Normal'
     2 = 'Borderline High'                        
     3 = 'High'
     4 = 'Very High'   ;                            

  value  TRSPR 
  	 0 = 'No,if not very much or not at all'       
     1 = 'Yes,if trusts somewhat or very much ';

  value URGHC
  	 0 = 'No,otherwise '                           
     1 = 'Yes,if usual place of care is hospital emergency room ';

  value URSMPLV
  	 0 = 'Spot Urine'                              
     1 = '24 Hour Urine'   ;

  value USMPLV 
  	 0 = 'Urine' 
     1 = 'Chemistry';

  value YN 
  	 0 = 'No' 
     1 = 'Yes ';
 
  value $AGE1GRPV 
  	 '0' = '21-34'                                   
  	 '1' = '35-44'                                  
     '2' = '45-54'                                   
     '3' = '55-64'                                   
     '4' = '65-74'                                   
     '5' = '75-84'                                   
     '6' = '85+ '  ;                                  

  value $AGEGRPV 
     '0' = '21-34'                                   
  	 '1' = '35-44'                                  
     '2' = '45-54'                                   
     '3' = '55-64'                                   
     '4' = '65-74'                                   
     '5' = '75-84'                                   
     '6' = 'over 85'
     '7' = 'under 21'  ; 

                  

  value $DATE1F
  	 '.1' = 'Sep 00'                                 
     '.2' = 'Oct 00'                                  
     '.3' = 'Nov 00'                                  
     '.4' = 'Dec 00'                                  
     '.5' = 'Jan 01'                                  
     '.6' = 'Feb 01'                                  
     '.7' = 'Mar 01'                                 
     '.8' = 'Apr 01'                                  
     '.9' = 'May 01'                                  
	 '10' = 'Jun 01'                                  
	 '11' = 'Jul 01'                                  
     '12' = 'Aug 01'                                  
     '13' = 'Sep 01'                                  
     '14' = 'Oct 01'                                  
     '15' = 'Nov 01'                                  
     '16' = 'Dec 01'                                  
     '17' = 'Jan 02'                                   
     '18' = 'Feb 02'                                   
     '19' = 'Mar 02'                                  
     '20' = 'Apr 02'                                   
	 '21' = 'May 02'                          
     '22' = 'Jun 02'                                  
     '23' = 'Jul 02'                                  
     '24' = 'Aug 02'                                  
     '25' = 'Sep 02'                                  
     '26' = 'Oct 02'                                  
     '27' = 'Nov 02'                                  
     '28' = 'Dec 02'                                  
     '29' = 'Jan 03'                                  
     '30' = 'Feb 03'                                  
	 '31' = 'Mar 03'      
     '32' = 'Apr 03'                                  
     '33' = 'May 03'                                  
     '34' = 'Jun 03'                                  
     '35' = 'Jul 03'                                  
     '36' = 'Aug 03'                                  
     '37' = 'Sep 03'                                  
     '38' = 'Oct 03'                                  
     '39' = 'Nov 03'                                  
     '40' = 'Dec 03'                                                                   
	 '41' = 'Jan 04'                                      
     '42' = 'Feb 04'                                  
     '43' = 'Mar 04'                                  
     '44' = 'Total ';

value $DATEF
  	 '.0' = ' ' 
  	 '.1' = 'Jan 00'                                                             
     '.2' = 'Feb 00'                                                                  
     '.3' = 'Mar 00'                                                                
     '.4' = 'Apr 00'                                                              
     '.5' = 'May 00'                                                              
     '.6' = 'Jun 00'                                                                  
     '.7' = 'Jul 00'                                                                
     '.8' = 'Aug 00'                                                                 
     '.9' = 'Sep 00'                                                                 
	 '10' = 'Oct 00'                                                                  
	 '11' = 'Nov 00'                                                                 
     '12' = 'Dec 00'                                                                  
     '13' = '00 Total'                                                              
     '14' = 'Jan 01'                                                              
     '15' = 'Feb 01'                                                                 
     '16' = 'Mar 01'                                                                 
     '17' = 'Apr 01'                                                                  
     '18' = 'May 01'                                                                   
     '19' = 'Jun 01'                                                              
     '20' = 'Jul 01'                                                                  
	 '21' = 'Aug 01'                                                         
     '22' = 'Sep 01'                                                             
     '23' = 'Oct 01'                                                               
     '24' = 'Nov 01'                                                                   
     '25' = 'Dec 01'                                                             
     '26' = '01 Total'                                                             
     '27' = 'Jan 02'                                                                  
     '28' = 'Feb 02'                                                              
     '29' = 'Mar 02'                                                                 
     '30' = 'Apr 02'                                                                
	 '31' = 'May 02'                                    
     '32' = 'Jun 02'                                                                   
     '33' = 'Jul 02'                                                                    
     '34' = 'Aug 02'                                                                  
     '35' = 'Sep 02'                                                                 
     '36' = 'Oct 02'                                                                   
     '37' = 'Nov 02'                                                                   
     '38' = 'Dec 02'                                                                    
     '39' = '02 Total'                                                               
     '40' = 'Jan 03'                                                                                                   
	 '41' = 'Feb 03'                                                                      
     '42' = 'Mar 03'                                                                 
     '43' = 'Apr 03'                                                                 
     '44' = 'May 03'                                   
	 '45' = 'Jun 03'                                   
	 '46' = 'Jul 03'                                   
	 '47' = 'Aug 03'                                   
	 '48' = 'Sep 03'                                   
	 '49' = 'Oct 03'                                   
	 '50' = 'Nov 03'                                   
	 '51' = 'Dec 03'                                   
	 '52' = '03 Total'                                 
	 '53' = 'Jan 04'                                   
	 '54' = 'Feb 04'                                   
	 '55' = 'Mar 04'                                   
	 '56' = '04 Total'                                 
	 '57' = 'Total'   
'**OTHER**' = 'Other';            

  value $HCAA2AN 
     'A' = 'A. Walk-in clinic'                       
     'B' = 'B. HMO clinic'                           
     'C' = 'C. Hospital clinic'                      
     'D' = 'D. Neighbourhood health center'          
     'E' = 'E. Hospital emergency room'              
     'F' = 'F. Public health department clinic'      
     'G' = 'G. Company or industry clinic'           
     'H' = 'H. Doctor''s office '                     
     'I' = 'I. Other'                                
     'R' = 'R. Research clinic'                      
     'S' = 'S. School clinic' ;                        

  value $HESARAV 
     'Y' = 'Yes ';

  value $HESARBV 
     'D' = 'Divorced'
     'M' = 'Married '
     'N' = 'Never Married '                          
     'S' = 'Separated '  
     'W' = 'Widowed ' ;

   value $HSTGP
     'G' = 'Good'
     'P' = 'Poor';

  value $JHDATE  
     'APR00' = '.4'   
     'APR01' = '17'   
     'APR02' = '30'     
     'APR03' = '43'       
     'AUG00' = '.8'    
     'AUG01' = '21'            
     'AUG02' = '34'                  
     'AUG03' = '47'          
     'BBLANK' = '.0'     
     'DEC00' = '12'     
     'DEC01' = '25'         
     'DEC02' = '38'  
     'DEC03' = '51'  
     'FEB00' = '.2'    
     'FEB01' = '15'         
     'FEB02' = '28'       
     'FEB03' = '41'     
     'FEB04' = '54'  
     'JAN00' = '.1'   
     'JAN01' = '14'   
     'JAN02' = '27'    
     'JAN03' = '40'      
     'JAN04' = '53'      
     'JUL00' = '.7'       
     'JUL01' = '20'        
     'JUL02' = '33'         
     'JUL03' = '46'      
     'JUN00' = '.6'       
     'JUN01' = '19'         
     'JUN02' = '32'             
     'JUN03' = '45'      
     'MAR00' = '.3'       
     'MAR01' = '16'            
     'MAR02' = '29'         
     'MAR03' = '42'           
     'MAR04' = '55'                                    
     'MAY00' = '.5'                                     
     'MAY01' = '18'              
     'MAY02' = '31'                           
     'MAY03' = '44'                         
     'NOV00' = '11'                          
     'NOV01' = '24'                          
     'NOV02' = '37'             
     'NOV03' = '50'                                     
     'OCT00' = '10'                           
     'OCT01' = '23'               
     'OCT02' = '36'                    
     'OCT03' = '49'                 
     'SEP00' = '.9'          
     'SEP01' = '22'          
     'SEP02' = '35'       
     'SEP03' = '48'          
     'TOTAL' = '56';

 /* value $JHDATE1  
     'APR01' = '.8'       
     'APR02' = '20'      
     'AUG01' = '12'              
     'AUG02' = '24'           
     'DEC00' = '.4'       
     'DEC01' = '16'     
     'DEC02' = '28'         
     'FEB01' = '.6'           
     'FEB02' = '18'           
     'JAN01' = '.5'        
     'JAN02' = '17'               
     'JUL01' = '11'         
     'JUL02' = '23'                  
     'JUN01' = '10'                 
     'JUN02' = '22'          
     'MAR01' = '.7'                
     'MAR02' = '19'            
     'MAY01' = '.9'                    
     'MAY02' = '21'            
     'NOV00' = '.3'                                      
     'NOV01' = '15'                                   
     'NOV02' = '27'                                    
     'OCT00' = '.2'                 
     'OCT01' = '14'           
     'OCT02' = '26'             
     'SEP00' = '.1'                 
     'SEP01' = '13'              
     'SEP02' = '25'               
     'TOTAL' = '29'; */

    value $JHDATE1F  
     'APR01 ' = '.8'       
     'APR02' = '20'          
     'APR03' = '32'  
     'AUG01' = '12'         
     'AUG02' = '24'   
     'AUG03' = '36'               
     'DEC00' = '.4'          
     'DEC01' = '16'           
     'DEC02' = '28'             
     'DEC03' = '40'              
     'FEB01' = '.6'               
     'FEB02' = '18'           
     'FEB03' = '30'      
     'FEB04' = '42'       
     'JAN01' = '.5'                   
     'JAN02' = '17'            
     'JAN03' = '29'             
     'JAN04' = '41'                    
     'JUL01' = '11'            
     'JUL02' = '23'                   
     'JUL03' = '35'                       
     'JUN01' = '10'         
     'JUN02' = '22'                   
     'JUN03' = '34' 
     'MAR01' = '.7'      
     'MAR02' = '19'           
     'MAR03' = '31'              
     'MAR04' = '43'              
     'MAY01' = '.9'                    
     'MAY02' = '21'            
     'MAY03' = '33'                        
     'NOV00' = '.3'               
     'NOV01' = '15'                   
     'NOV02' = '27'                        
     'NOV03' = '39'                                      
     'OCT00' = '.2'     
     'OCT01' = '14'          
     'OCT02' = '26'              
     'OCT03' = '38'                       
     'SEP00' = '.1'                  
     'SEP01' = '13'               
     'SEP02' = '25'       
     'SEP03' = '37'          
     'TOTAL' = '44';

  value $JHDATEF 
     'APR01' = '.8'      
     'APR02' = '20'           
     'AUG01' = '12'             
     'AUG02' = '24'                  
     'DEC00' = '.4'                          
     'DEC01' = '16'             
     'DEC02' = '28'              
     'FEB01' = '.6'                
     'FEB02' = '18'                 
     'JAN01' = '.5'                    
     'JAN02' = '17'                 
     'JUL01' = '11'          
     'JUL02' = '23'       
     'JUN01' = '10'            
     'JUN02' = '22'               
     'MAR01' = '.7'       
     'MAR02' = '19'            
     'MAY01' = '.9'             
     'MAY02' = '21'              
     'NOV00' = '.3'         
     'NOV01' = '15'   
     'NOV02' = '27'           
     'OCT00' = '.2'                 
     'OCT01' = '14'                      
     'OCT02' = '26'                           
     'SEP00' = '.1'                         
     'SEP01' = '13'                           
     'SEP02' = '25'                       
     'TOTAL' = '29';                                 

  value $NEWID
     '01' = 'ARIC'       
     '02' = 'ARIC_HOUSEHOLD'   
     '03' = 'ARIC_FAMILY'          
     '04' = 'ARIC_HOUSEHOLD_FAMILY'      
     '05' = 'RANDOM'                    
     '06' = 'RANDOM_FAMILY'            
     '07' = 'FAMILY'                     
     '08' = 'VOLUNTEER'                    
     '09' = 'VOLUNTEER_FAMILY'     
     '10' = 'UNKNOWN';

  value $NSHIFT 
     '01' = 'AM'    
     '02' = 'Early PM'                                 
     '03' = 'Late PM'                                   
     '04' = 'Weekend'  
     '05' = 'Missing';

  value  $PLKA1V   
     'A' = 'ARIC' 
     'F' = 'FAMILY'     
     'H' = 'ARIC_HOUSEHOLD'      
     'N' = 'NOT_CODED'       
     'R' = 'RANDOM'           
     'V' = 'VOLUNTEER';               

  value $SEX      
     'F' = 'Female'   
     'M' = 'Male';

  value $SHIFT   
     '01' = 'AM' 
     '02' = 'PM'                         
     '03' = 'Weekend'                           
     '04' = 'Missing'; 

  value $SRMED   
     'N' = 'No'   
     'U' = 'Unknown'  
     'Y' = 'Yes';             

  value $UPLHC
     'A' = 'Doctors office'                          
     'B' = 'Outpatient clinic'                       
     'C' = 'Hospital ER';                             

  value $V1RACE  
     '01' = 'African American'                            
     '02' = 'American Indian'                          
     '03' = 'Asian'        
     '04' = 'Hispanic'          
     '05' = 'Native Haw or Pac Islndr'                                
     '06' = 'White';
 
  run ;
