********************************************************************;
****************** Define JHS Exam Visit 3 Formats *****************;
********************************************************************;

proc format library = jhsV3.v3formats;
  value ABBB3V
    1 = '1. Right'
    2 = '2. Left';

  value ADRB1V
    1 = '1. Yes'
    2 = '2. No'
    3 = '3. Stopped drinking more than one year ago 3'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value ADRB2BV
    1 = '1. Week'
    2 = '2. Month'
    3 = '3. Year'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value ADRB4V
    1 = '1. Beer'
    2 = '2. Wine'
    3 = '3. Liquor'
    4 = '4. No preference or can’t say'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value ADRB7V
    1 = '1. 1 or 2 times'
    2 = '2. 3-10 times'
    3 = '3. 11-99 times'
    4 = '4. 100 or more times'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value ALTB1V
    1 = '1 None'
    2 = '2 Emergent'
    3 = '3 Immediate'
    4 = '4 Urgent'
    5 = '5 Routine';

  value ALTB2V
    1 = '1 In clinic'
    2 = '2 By phone'
    3 = '3 By mail';

  value ALTB3V
    1 = '1 Phone'
    2 = '2 Mail';

  value ALTB4V
    1 = '1 Emergency room'
    2 = '2 Participant HCP'
    3 = '3 JHS private network'
    4 = '4 RWJ network'
    5 = '5 Other';

  value ASBA2V
    1 = '1 Very Comfortable'
    2 = '2 Somewhat comfortable'
    3 = '3 Somewhat uncomfortable'
    4 = '4 Very uncomfortable'
    5 = '5 Not sure'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value ASBA4V
    1 = '1 No at all'
    2 = '2 Once a month'
    3 = '3 Once a week'
    4 = '4 Once a day'
    5 = '5 More than once a day'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value BCFA11V
    1 = '1 Standard'
    2 = '2 Athletic';

  value BCFA2V
    1 = '1 Don''t drink alcohol'
    2 = '2 Yes'
    3 = '3 No';

  value BCFA4V
    1 = 'No longer menstruating'
    2 = 'Yes'
    3 = 'No'
    4 = 'Female 55/Older'
    5 = 'Male'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value BCFA5V
    1 = 'Balance beam/wall only'
    2 = 'Tanita body composition only'
    3 = 'Both'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value BCTA4V
    1 = '1 At home'
    2 = '2 In hospital'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value BCTA5V
    1 = '1 Inside'
    2 = '2 Outside'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value BCTA6V
    1 = '1 In Hospital'
    2 = '2 In Community'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value BCTA11V
    1 = '1 Female'
    2 = '2 Male'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value BCTA12V
    1 = '1 Single'
    2 = '2 Twin'
    3 = '3 Triplet'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value BCTA13V
    1 = '1 Full Term'
    2 = '2 Premature'
    8 = '8 Unable to read form'
    9 = '9 Not recorded on form';

  value CDFA1V
    1 = '1. Not Very Stressful'
    2 = '2. Moderately stressful'
    3 = '3. Very Stressful'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value CLAB1V
    1 = '1. Yes'
    2 = '2. No';

  value CLAB14V
    1 = '1. Language barrier'
    2 = '2. Physically unable to attend clinic'
    3 = '3. Doesn''t want blood drawn'
    4 = '4. Doesn''t want to take time off work'
    5 = '5. Other Refusal'
    6 = '6. Other';

  value CLAB8BV
    1 = '1. JHS Volunteer'
    2 = '2. Taxi'
    3 = '3. Other';

  value CLAC12V
    1 = '1. Set'
    2 = '2. Pending'
    8 = '8. Refused';

  value COFE1V
    1 = '1. Yes'
    2 = '2. No';

  value $CONA33V
    'C' = 'C. Participant will bring information to clinic'
    'O' = 'O. Complete physician contact information obtained'
    'P' = 'P. Participant to provide at 24-hour pick-up'
    'R' = 'R. Refusal or no health care provider';

  value $CONA35V
    'N' = 'Nurse practitioner'
    'O' = 'Other'
    'P' = 'Physician';

  value DISB1V
     1 = '1. Several times a day'
     2 = '2. Almost every day'
     3 = '3. At least once a week'
     4 = '4. A few times a month'
     5 = '5. A few times a year'
     6 = '6. Less than a few times a year'
     7 = '7. Never'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value DISB2AV
    1 = '1. Your age'
    2 = '2. Your gender'
    3 = '3. Your race'
    4 = '4. Your height or weight'
    5 = '5. Some other reason for discrimination';

  value DISB3AV
    1 = '1. A lot'
    2 = '2. Some'
    3 = '3. A Little'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value DISB4V
    1 = '1. More frequent'
    2 = '2. Less frequent'
    3 = '3. About the same'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value DISB5V
    1 = '1. Very stressful'
    2 = '2. Moderately stressful'
    3 = '3. Not stressful'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value DISB6V
    1 = '1. A lot'
    2 = '2. Some'
    3 = '3. A little'
    4 = '4. Not at all'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value DISB8V
    1 = '1. A lot better'
    2 = '2. Somewhat better'
    3 = '3. No different'
    4 = '4. Somewhat worse'
    5 = '5. A lot worse'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value DISCONV
    1 = 'End of planned course'
    2 = 'Lack of efficacy'
    3 = 'Improvement'
    4 = 'Protocol violation'
    5 = 'Subject request';

  value DISCO1V
    1 = 'End of planned course'
    2 = 'Lack of efficacy'
    3 = 'Improvement';

  value DISCO2V
    4 = 'Protocol violation'
    5 = 'Subject request';

  value FTRB3AV
    1 = '1. Today'
    2 = '2. Yesterday'
    3 = '3. Before Yesterday'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value FUPA23V
    1 = '1. All medications taken in the past 2 weeks'
    2 = '2. Some medications taken in the past 2 weeks'
    3 = '3. None of the medications taken in the past 2 weeks'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value FUPA21V
    1 = '1. Can’t find the container(s), bottle'
    2 = '2. Can’t read the label(s)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value $HCTA2AV
    'A' = 'A. Walk-in clinic'
    'B' = 'B. HMO clinic'
    'C' = 'C. Hospital clinic'
    'D' = 'D. Neighborhood health center'
    'E' = 'E. Hospital emergency room'
    'F' = 'F. Public health department clinic'
    'G' = 'G. Company or industry clinic'
    'H' = 'H. Doctor''s office'
    'I' = 'I. Other';

  value HCTA3V
    1 = '1. Very much'
    2 = '2. Somewhat'
    3 = '3. Not very much'
    4 = '4. Not at all'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HCTA4V
    1 = '1. Completely'
    2 = '2. Mostly'
    3 = '3. Somewhat'
    4 = '4. A little'
    5 = '5. Not at aLL'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HCTA5V
    1 = '1. Excellent'
    2 = '2. Good'
    3 = '3. Fair'
    4 = '4. Poor'
    5 = '5. Very Poor'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HCTA7V
    1 = '1. Strongly Agree'
    2 = '2. Agree'
    3 = '3. Neutral'
    4 = '4. Disagree'
    5 = '5. Strongly Disagree'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA1V
    1 = '1. Excellent'
    2 = '2. Good'
    3 = '3. Fair'
    4 = '4. Poor'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA2V
    1 = '1. Better'
    2 = '2. Worse'
    3 = '3. About the same'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA21V
    1 = '1. Overweight'
    2 = '2. Underweight'
    3 = '3. About right weight'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA24V
    1 = '1. Less than 1 hour per week'
    2 = '2. At least 1 hour a week but Less than 7 hours a week'
    3 = '3. At least 1 hour a day but Less than 2 hours a day'
    4 = '4. At least 2 hours a day but Less than 4 hours a day'
    5 = '5. 4 hours or more a day'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA25V
    1 = '1. Within the past year'
    2 = '2. At least 1 year, but less than 2 years ago'
    3 = '3. At least 2 years, but less than 4 years ago'
    4 = '4. 5 or more years ago'
    5 = '5. Never'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA27V
    1 = '1. Very hard'
    2 = '2. Fairly hard'
    3 = '3. Not too hard'
    4 = '4. Not hard at all'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value HHXA4BV
    1 = '1. < 6 weeks'
    2 = '2. 6 -11 weeks'
    3 = '3. 3 - 6 months'
    4 = '4. > 6 months'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value $JH_AMPV
    'A' = 'AM'
    'P' = 'PM';

  value $JH_CPV
    'C' = 'Computer'
    'P' = 'Paper';

  value $JH_DAYV
    'A' = 'A. Saturday'
    'F' = 'F. Friday'
    'H' = 'H. Thursday'
    'M' = 'M. Monday'
    'S' = 'S. Sunday'
    'T' = 'T. Tuesday'
    'W' = 'W. Wednesday';

  value $JH_HOSV
    'J01' = 'J01. CENTRAL MS MEDICAL CTR'
    'J02' = 'J02. MS BAPTIST HOSP'
    'J03' = 'J03. ST. DOMINIC''S HOSP'
    'J04' = 'J04. UNIV OF MS MEDICAL CTR'
    'J05' = 'J05. VA HOSP'
    'J06' = 'J06. MADISON COUNTY MEDICAL CTR'
    'J07' = 'J07. RANKIN GENERAL HOSP'
    'J08' = 'J08. RIVER OAKS HOSP';

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
    'D' = 'Don''t Know'
    'N' = 'No'
    'Y' = 'Yes';


  value $JH_YNUV
    'N' = 'No'
    'U' = 'Unknown'
    'Y' = 'Yes';

  value JS_CPV
    1 = '1. Computer'
    2 = '2. Paper';

  value JS_DAYV
    1 = 'Sunday'
    2 = 'Monday'
    3 = 'Tuesday'
    4 = 'Wednesday'
    5 = 'Thursday'
    6 = 'Friday'
    7 = 'Saturday';

  value JS_FTV
     1 = '1'
     2 = '2'
     3 = '3'
     4 = '4'
     5 = '5'
     6 = '6'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value JS_HRSV
     0 = '00'
     1 = '01'
     2 = '02'
     3 = '03'
     4 = '04'
     5 = '05'
     6 = '06'
     7 = '07'
     8 = '08'
     9 = '09'
    10 = '10'
    11 = '11'
    12 = '12'
    13 = '13'
    14 = '14'
    15 = '15'
    16 = '16'
    17 = '17'
    18 = '18'
    19 = '19'
    20 = '20'
    21 = '21'
    22 = '22'
    23 = '23'
    24 = '24';

  value JS_INV
     0 = '00'
     1 = '01'
     2 = '02'
     3 = '03'
     4 = '04'
     5 = '05'
     6 = '06'
     7 = '07'
     8 = '08'
     9 = '09'
    10 = '10'
    11 = '11'
    12 = '12'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value JS_MFV
    1 = '1. Male'
    2 = '2. Female';

  value JS_ISV
    1 = '1. In Clinic'
    2 = '2. Off site';

  value JS_MINV
     0 = '00'
     1 = '01'
     2 = '02'
     3 = '03'
     4 = '04'
     5 = '05'
     6 = '06'
     7 = '07'
     8 = '08'
     9 = '09'
    10 = '10'
    11 = '11'
    12 = '12'
    13 = '13'
    14 = '14'
    15 = '15'
    16 = '16'
    17 = '17'
    18 = '18'
    19 = '19'
    20 = '20'
    21 = '21'
    22 = '22'
    23 = '23'
    24 = '24'
    25 = '25'
    26 = '26'
    27 = '27'
    28 = '28'
    29 = '29'
    30 = '30'
    31 = '31'
    32 = '32'
    33 = '33'
    34 = '34'
    35 = '35'
    36 = '36'
    37 = '37'
    38 = '38'
    39 = '39'
    40 = '40'
    41 = '41'
    42 = '42'
    43 = '43'
    44 = '44'
    45 = '45'
    46 = '46'
    47 = '47'
    48 = '48'
    49 = '49'
    50 = '50'
    51 = '51'
    52 = '52'
    53 = '53'
    54 = '54'
    55 = '55'
    56 = '56'
    57 = '57'
    58 = '58'
    59 = '59';

  value JS_MTHV
     1 = 'January'
     2 = 'February'
     3 = 'March'
     4 = 'April'
     5 = 'May'
     6 = 'June'
     7 = 'July'
     8 = 'August'
     9 = 'September'
    10 = 'October'
    11 = 'November'
    12 = 'December';

  value JS_YEAV
    2000 = '2000'
    2001 = '2001'
    2002 = '2002'
    2003 = '2003'
    2004 = '2004'
    2005 = '2005'
    2006 = '2006'
    2007 = '2007'
    2008 = '2008'
    2009 = '2009'
    2010 = '2010'
    2011 = '2011'
    2012 = '2012'
    2013 = '2013';

  value JS_YNV
    1 = 'Yes'
    2 = 'No '
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value LEIB2V
    1 = '1. Normal'
    2 = '2. Minor abnormal'
    3 = '3. Major abnormal'
    4 = '4. Results not expected';

  value ACTIV
    0 = '0. No action'
    1 = '1. Trial interrupted'
    2 = '2. Trial discontinued'
    3 = '3. Concom drug changed'
    4 = '4. Hospitalization';

  value $M_CENTV
    'ANA' = 'ANA'
    'HEL' = 'HEL'
    'JUT' = 'JUT'
    'MAN' = 'MAN'
    'PAT' = 'PAT'
    'SER' = 'SER'
    'SIE' = 'SIE'
    'STE' = 'STE';

  value $M_DDV
    '01' = '01'
    '02' = '02'
    '03' = '03'
    '04' = '04'
    '05' = '05'
    '06' = '06'
    '07' = '07'
    '08' = '08'
    '09' = '09'
    '10' = '10'
    '11' = '11'
    '12' = '12'
    '13' = '13'
    '14' = '14'
    '15' = '15'
    '16' = '16'
    '17' = '17'
    '18' = '18'
    '19' = '19'
    '20' = '20'
    '21' = '21'
    '22' = '22'
    '23' = '23'
    '24' = '24'
    '25' = '25'
    '26' = '26'
    '27' = '27'
    '28' = '28'
    '29' = '29'
    '30' = '30'
    '31' = '31';

  value DISCV
    1 = '1. Adverse experience'
    2 = '2. Abnormal lab values'
    3 = '3. Drug not effective'
    4 = '4. Protocol criteria'
    5 = '5. Non-compliance'
    6 = '6. No consent'
    7 = '7. Moved'
    8 = '8. Died';

  value M_DOSEV
     1 = 'g'
     2 = 'mg'
     3 = 'mcg'
     4 = 'ng'
     5 = 'mg/mL'
     6 = 'mcg/mL'
     7 = 'mg/m(2)'
     8 = 'g/L'
     9 = 'mg/kg'
    10 = '%';

  value $M_LABSV
     '1' = 'mg/dL'
     '2' = 'mg%'
     '3' = 'mEq/L'
     '4' = 'g/dL'
     '5' = 'IU/L'
     '6' = 'mmol/L'
     '7' = '%'
     '8' = 'g/dl'
     '9' = '10(3)/mcL'
    '10' = 'thou/mcL'
    '11' = '10(6)/mcL'
    '12' = 'mill/mcL'
    '13' = 'mm/hr';

  value $M_LAB3V
    '1' = 'mg/dL'
    '2' = 'mg%'
    '3' = 'mEq/L'
    '4' = 'g/dL'
    '5' = 'IU/L'
    '6' = 'mmol/L';

  value $M_LAB4V
     '7' = '%'
     '8' = 'g/dl'
     '9' = '10(3)/mcL'
    '10' = 'thou/mcL'
    '11' = '10(6)/mcL'
    '12' = 'mill/mcL'
    '13' = 'mm/hr';

  value $M_MONV
    '01' = 'JAN'
    '02' = 'FEB'
    '03' = 'MAR'
    '04' = 'APR'
    '05' = 'MAY'
    '06' = 'JUN'
    '07' = 'JUL'
    '08' = 'AUG'
    '09' = 'SEP'
    '10' = 'OCT'
    '11' = 'NOV'
    '12' = 'DEC';

  value NORMV
    1 = '1. N'
    2 = '2. A';

  value OUTCV
    1 = '1. Recovered'
    2 = '2. Improving'
    3 = '3. Unchanged'
    4 = '4. Deteriorated'
    5 = '5. Died';

  value RAV
    1 = 'White'
    2 = 'Hispanic'
    3 = 'Black'
    4 = 'Asian'
    5 = 'Other';

  value RELAV
    0 = '0. Unrelated'
    1 = '1. Related'
    2 = '2. Uncertain';

  value SEVEV
    0 = '0. None'
    1 = '1. Minimal'
    2 = '2. Moderate'
    3 = '3. Severe';

  value SV
    1 = '1. F'
    2 = '2. M';

  value VAL_V
    0 = '0. None'
    1 = '1. Trace'
    2 = '2. Path';

  value YESV
    0 = '0. No'
    1 = '1. Yes';

  value $M_YNV
    'N' = 'No'
    'Y' = 'Yes';

  value $M_YYYYV
    '1970' = '1970'
    '1971' = '1971'
    '1972' = '1972'
    '1973' = '1973'
    '1974' = '1974'
    '1975' = '1975'
    '1976' = '1976'
    '1977' = '1977'
    '1978' = '1978'
    '1979' = '1979'
    '1980' = '1980'
    '1981' = '1981'
    '1982' = '1982'
    '1983' = '1983'
    '1984' = '1984'
    '1985' = '1985'
    '1986' = '1986'
    '1987' = '1987'
    '1988' = '1988'
    '1989' = '1989'
    '1990' = '1990'
    '1991' = '1991'
    '1992' = '1992'
    '1993' = '1993'
    '1994' = '1994'
    '1995' = '1995'
    '1996' = '1996'
    '1997' = '1997'
    '1998' = '1998'
    '1999' = '1999'
    '2000' = '2000'
    '2001' = '2001'
    '2002' = '2002'
    '2003' = '2003'
    '2004' = '2004'
    '2005' = '2005'
    '2006' = '2006'
    '2007' = '2007'
    '2008' = '2008'
    '2009' = '2009'
    '2010' = '2010'
    '2011' = '2011'
    '2012' = '2012'
    '2013' = '2013';

  value MHXB11V
    1 = '1. Stop or slow down'
    2 = '2. Carry on'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB12V
    1 = '1. Relieved'
    2 = '2. Not relieved'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB13V
    1 = '1. 10 minutes or less'
    2 = '2. More than 10 minutes'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB17V
    1 = '1. Angina'
    2 = '2. Heart attack'
    3 = '3. Other Heart Disease'
    4 = '4. Other';

  value MHXB19V
    1 = '1. 1 month'
    2 = '2. 6 months'
    3 = '3. 1 year'
    4 = '4. 2 years'
    5 = '5. Over 2 years'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB31V
    1 = '1. Heart Attack'
    2 = '2. Other disorder'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB36V
    1 = '1. Normal'
    2 = '2. Abnormal'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB39V
    1 = '1. Pain includes calf/calves'
    2 = '2. Pain does not include calf/calves'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB40V
    1 = '1. Yes'
    2 = '2. No'
    3 = '3. Never hurries or walks uphill'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB43V
    1 = '1. Stop or slow down'
    2 = '2. Carry on'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB44V
    1 = '1. Relieved'
    2 = '2. Not relieved'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB45V
    1 = '1. 10 minutes or less'
    2 = '2. More than 10 minutes'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB52V
    1 = '1. Right'
    2 = '2. Left'
    3 = '3. Both'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB53V
    1 = '1. Emergency for a heart attack'
    2 = '2. Chest pain/discomfort'
    3 = '3. Doctors suspected disease/blockage'
    4 = '4. Follow up after heart attack or procedure (surgery or stent)'
    5 = '5. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB54V
    1 = '1. Emergency for a stroke'
    2 = '2. Doctors suspected disease/blockage'
    3 = '3. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB51V
    1 = '1. Leg pain on walking short distance'
    2 = '2. Doctor suspected disease/blockage'
    5 = '5. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB57V
    1 = '1. Heart failure/fluid on lungs'
    2 = '2. Heart murmur / Valvular heart disease'
    3 = '3. High blood pressure'
    4 = '4. Follow up after heart attack or surgery'
    5 = '5. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB56V
    1 = '1. Chest pain / discomfort'
    2 = '2. Rhythm disturbance'
    3 = '3. High blood pressure'
    4 = '4. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB58V
    1 = '1. Chest pain / discomfort'
    2 = '2. Follow up after heart attack or procedure'
    3 = '3. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXB59V
    1 = '1. Passing out'
    2 = '2. Forgetfulness'
    3 = '3. TIA (little strokes)'
    4 = '4. Stroke'
    5 = '5. Blocked arteries'
    6 = '6. Other (Specify)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MHXBARV
    1 = '1. Never'
    2 = '2. Seldom'
    3 = '3. Sometimes'
    4 = '4. Often'
    5 = '5. Almost Always';

  value MHXB6V
    1 = '1. Excellent'
    2 = '2. Very good'
    3 = '3. Good'
    4 = '4. Fair'
    5 = '5. Poor';

  value MHXB9V
    1 = '1. Yes'
    2 = '2. No'
    3 = '3. Never hurries or walks uphill'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB2V
    1 = '1. Yes, all'
    2 = '2. Some of them'
    3 = '3. None (forgot/unable)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB27V
    1 = '1. Initial'
    2 = '2. Follow-Up';

  value MSRB33V
    1 = '1. Less than 300 mg (Baby)'
    2 = '2. 300 - 499 mg (Regular)'
    3 = '3. 500 mg or greater (Extra strength)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB34V
    1 = '1. Yes'
    2 = '2. No'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRC34V
    1 = '1. Participant mentioned to avoid heart attack or stroke'
    2 = '2. Participant did NOT mention to avoid heart attack or stroke';

  value MSRC35V
    1 = '1. Ibuprofen or Advil'
    2 = '2. Other'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB3AV
    1 = '1. Yes'
    2 = '2. No (don’t want a follow-up)'
    3 = '3. Insist to list by memory'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB41V
    1 = '1. Yes'
    2 = '2. No'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value MSRB42V
     1 = '1. Daily'
     2 = '2. Weekly'
     3 = '3. Several times a month'
     4 = '4. Monthly'
     5 = '5. Several times a year'
     6 = '6. Yearly'
     7 = '7. Rarely'
     8 = '8. Almost never'
     9 = '9. Never'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value MSRC43V
    1 = '1. Heart'
    2 = '2. Other'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB1V
    1 = '1. Less than 5 minutes'
    2 = '2. At least 5 but less than 15 minutes'
    3 = '3. At least 15 but less than 30 minutes'
    4 = '4. At least 30 but less than 45 minutes'
    5 = '5. At least 45 minutes'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB5V
    1 = '1. Less than 1 hr a wk'
    2 = '2. At least 1 hr a wk but less than 7 hrs a wk'
    3 = '3. At least 1 hr a day but less than 2 hrs a day'
    4 = '4. At least 2 hr a day but less than 4 hrs a day'
    5 = '5. 4 or more hrs a day'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB7V
    1 = '1. Much lighter'
    2 = '2. Lighter'
    3 = '3. The same as'
    4 = '4. Heavier'
    5 = '5. Much heavier'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACBR1V
    1 = '1. Less than one month'
    2 = '2. 1 to 3 months'
    3 = '3. 4 to 6 months'
    4 = '4. 7 to 9 months'
    5 = '5. More than 9 months'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACBR2V
    1 = '1. Less than once a month'
    2 = '2. Once a month'
    3 = '3. 2-3 times a month'
    4 = '4. Once a week'
    5 = '5. More than once a week'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACBR3V
    1 = '1. Less than 1 hr'
    2 = '2. At least 1 but less than 2 hrs'
    3 = '3. At least 2 but less than 3 hrs'
    4 = '4. At least 3 but less than 4 hrs'
    5 = '5. 4 hrs or more'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACBR8V
    1 = '1. Never'
    2 = '2. Seldom'
    3 = '3. Sometimes'
    4 = '4. Often'
    5 = '5. Always'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB10V
    1 = '1. Less than 1 hr per wk'
    2 = '2. At least 1 but less than 20 hrs per wk'
    3 = '3. More than 20 hrs per wk'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB11V
    1 = '1. Less than ½ hr per day'
    2 = '2. At least ½ hr but less than 1 hr per day'
    3 = '3. At least 1 hr but less than 1 ½ hrs per day'
    4 = '4. At least 1 ½ hrs but less than 2 hrs per day'
    5 = '5. 2 or more hrs per day'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PACB28V
    1 = '1. Much Less'
    2 = '2. Less'
    3 = '3. Same as'
    4 = '4. More'
    5 = '5. Much more'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PBSA1V
    1 = '1. No Burden'
    2 = '2. 2'
    3 = '3. 3'
    4 = '4. 4'
    5 = '5. Heavy Burden'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PBSA7V
    1 = '1. 2 hours'
    2 = '2. 3 hours'
    3 = '3. 4 hours'
    4 = '4. 4 or more hours'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PBSA8V
    1 = '1. Yes'
    2 = '2. No'
    3 = '3. It depends on the time involved'
    4 = '4. It depends on the location of the component'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value PDSA2V
    1 = '1. Working now, full-time'
    2 = '2. Working now, part-time'
    3 = '3. Employed, but temporarily laid off'
    4 = '4. Sick or on leave for health reasons'
    5 = '5. Unemployed, looking for work'
    6 = '6. Unemployed, not looking for work'
    7 = '7. Homemaker, not working outside the home'
    8 = '8. Retired, and not working'
    9 = '9. Retired, but working for pay';

  value PDSA4V
    1 = '1. One'
    2 = '2. More than one';

  value PDA8BV
    1 = '1. Regular, steady work'
    2 = '2. Seasonal'
    3 = '3. Frequent layoffs'
    4 = '4. Don’t know'
    5 = '5. Other';

  value PDSA10V
    1 = '1. Satisfied'
    2 = '2. Dissatisfied'
    3 = '3. Neither';

  value PDSA16V
    1 = '1. Very disappointed'
    2 = '2. Fairly disappointed'
    3 = '3. Slightly disappointed'
    4 = '4. Not at all disappointed';

  value PDSA20V
    1 = '1. Yes, currently'
    2 = '2. Yes, in the past'
    3 = '3. No';

  value PDSA21V
    1 = '1. Yes'
    2 = '2. No'
    3 = '3. Don’t Know' 
    4 = '4. Refused';

  value PDSA23V
    1 = '1. Pays rent'
    2 = '2. Buying (paying a mortgage)'
    3 = '3. Owns'
    4 = '4. Neither owns nor pays rent'
    5 = '5. Don’t know';

  value PDSA24V
    1 = '1. Yes, one'
    2 = '2. Yes, more than one'
    3 = '3. No';

  value PDSA25V
    1  = '1. $0 - 499'
    2  = '2. $500 - 999'
    3  = '3. $1,000 - 4,999'
    4  = '4. $5,000 - 9,999'
    5  = '5. $10,000 - 19,999'
    6  = '6. $20,000 - 49,999'
    7  = '7. $50,000 - 99,999'
    8  = '8. $100,000 - 199,999'
    9  = '9. $200,000 or more'
    10 = '10. Don’t know'
    11 = '11. Refused';

  value PDSA26V
    1 = '1. Yes'
    2 = '2. No/Don’t Know'
    3 = '3. Refused';

  value PDSA27V
    1 = '1. Less than $5,000'
    2 = '2. $5,000 - 7,999'
    3 = '3. $8,000 - 11,999'
    4 = '4. $12,000 - 15,999'
    5 = '5. $16,000 - 19,999'
    6 = '6. $20,000 - 24,999'
    7 = '7. $25,000 - 34,999'
    8 = '8. $35,000 - 49,999'
    9 = '9. $50,000 - 74,999'
    10 = '10. $75,000 - 99,999'
    11 = '11. $100,000 or more'
    12 = '12. Don’t Know'
    13 = '13. Refused';

  value PECB6V
    1 = '1. Yes'
    2 = '2. No';

  value PFHB15V
    1 = '1. Cancer'
    2 = '2. Heart attack'
    3 = '3. Stroke'
    4 = '4. Unknown'
    5 = '5. Other (Specify)';

  value PFHB20V
    1 = '1. Before first exam'
    2 = '2. Since first exam'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value $RHXB0V
    'Y' = 'Y. Yes'
    'N' = 'N. No'
    'D' = 'D. Unknown';

  value $RHXB3V
    'D' = 'D. Don''t know'
    'H' = 'H. Hormones'
    'I' = 'I. Illness'
    'N' = 'N. Natural periods'
    'O' = 'O. Other';

  value $RHXB7V
    'D' = 'D. Don''t know'
    'N' = 'N. Natural'
    'R' = 'R. Radiation'
    'S' = 'S. Surgery';

  value SBPB9V
    1 = '1. Small adult {<24 cm}'
    2 = '2. Regular Arm {24-32 cm}'
    3 = '3. Large Arm {33-41 cm}'
    4 = '4. Thigh {>41cm}';

  value SLEA3V
    1 = '1. Never'
    2 = '2. Rarely (1 to 2 nights a week)'
    3 = '3. Occasionally (3-4 nights a week)'
    4 = '4. Frequently (5 or more nights a week)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SLEA5V
    1 = '1. Never (0)'
    2 = '2. Rarely (Once per month or less)'
    3 = '3. Sometimes (2-4 times per month)'
    4 = '4. Often (5-15 times per month)'
    5 = '5. Almost Always (16-30 times per month)'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SLEA6V
    1 = '1. Excellent'
    2 = '2. Very good'
    3 = '3. Good'
    4 = '4. Fair'
    5 = '5. Poor'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SLEA7V
    1 = '1. No Change'
    2 = '2. Slight Chance'
    3 = '3. Moderate Chance'
    4 = '4. High Chance'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SMPB4V
    1 = '1. Early morning'
    2 = '2. Late morning'
    3 = '3. Early afternoon'
    4 = '4. Late afternoon';

  value SMPB8V
    1 = '1. Left'
    2 = '2. Right'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB10V
    1 = '1. Started in one part and spread to another'
    2 = '2. Stayed in one part'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB18V
    1 = '1. Started in one part and spread to another'
    2 = '2. Stayed in one part'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB19V
     1 = '1. Double vision'
     2 = '2. Vision loss in right eye only'
     3 = '3. Vision loss in left eye only'
     4 = '4. Total loss of vision in both eyes'
     5 = '5. Trouble in both eyes seeing to the right'
     6 = '6. Trouble in both eyes seeing to the left'
     7 = '7. Trouble in both eyes seeing to both sides or straight aheadSatr'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value SSFB23V
    1 = '1. Started in one part and spread to another'
    2 = '2. Stayed in one part'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB5EV
    1 = '1. Slurred speech'
    2 = '2. Wrong words came out'
    3 = '3. Words would not come out'
    4 = '4. Could not think of the right words'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB6BV
    1 = '1. The right side only'
    2 = '2. The left side only'
    3 = '3. Both sides'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB6DV
    1 = '1. The right side only'
    2 = '2. The left side only'
    3 = '3. Both'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB6JV
     1 = '1. Double vision'
     2 = '2. Vision loss in right eye only'
     3 = '3. Vision loss in left eye only'
     4 = '4. Total loss of vision in both eyes'
     5 = '5. Trouble in both eyes seeing to the right'
     6 = '6. Trouble in both eyes seeing to the left'
     7 = '7. Trouble in both eyes seeing to both sides or straight ahead'
    77 = '77. Don''t Know'
    88 = '88. Refused'
    99 = '99. Missing';

  value SSFB9AV
    1 = '1. Only the right eye'
    2 = '2. Only the left eye'
    3 = '3. Both eyes'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value SSFB9BV
    1 = '1. Trouble seeing to the right, but not the left'
    2 = '2. Trouble seeing to the left, but not the right'
    3 = '3. Trouble seeing both sides or straight ahead'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value STXB1V
    1 = '1. Almost never'
    2 = '2. Sometimes'
    3 = '3. Often'
    4 = '4. Almost always';

  value TERA3V
    1 = '1. Participant withdrew'
    2 = '2. Consent Changed'
    3 = '3. Moved'
    4 = '4. '
    5 = '5. Died'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

  value TOBB10V
    1 = '1. First of the day'
    2 = '2. Any other';

  value TOBB15V
    1 = '1. Not at all'
    2 = '2. Slightly'
    3 = '3. Moderately'
    4 = '4. Deeply';
  value TOBB9V
    1 = '1. 0-5 minutes'
    2 = '2. 6-30 minutes'
    3 = '3. 31-60 minutes'
    4 = '4. 61 minutes or more';

  value $VENB5AV
    'X' = 'X';

  value VENB7AV
    1 = '1. Yes'
    2 = '2. No '
    3 = '3. Yes, tube 1 only'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

*****************Yan Gao added formats************************;
   value TECCODEV
    101 = 'Mary Crump'       
    102 = 'Jerline Sims'      
    103 = 'Shannon Lee'   
    104 = 'Debra Douglas'
    105 = 'Pat Hayes'    
    106 = 'Cora Champion'           
    107 = 'Shirley Forbes'           
    108 = 'Celestine Moore'      
    109 = 'Gerldean Davis'       
    110 = 'Beverly Brown'          
    111 = 'Estella White'                      
    112 = 'Tammy Lewis'                  
    113 = 'Sheila Smith'      
    114 = 'Patricia Beverly'         
    115 = 'Stephanie Thompson'         
    198 = 'Michelene Brock'                
    199 = 'Chrishanda Wilson' ;                     
 
   value TEST 
     0 = 'No'
	 1 = 'CVD+'                                    
	 2 = 'All Major'                               
	 3 = 'JHS Only Consent';
 
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
 

   value $JH_YNKV
	 'K' = 'K. Don''t Know '   
	 'N' = 'N. No'                              
	 'R' = 'R. Refused'                          
	 'Y' = 'Y. Yes';

run;
