********************************************************************;
****************** Define JHS Exam Visit 2 Formats *****************;
********************************************************************;

proc format library = jhsV2.v2formats;
  value $PLKA1V
    'A' = 'ARIC'
    'F' = 'Family'
    'H' = 'ARIC Household'
    'N' = 'Not Coded'
    'R' = 'Random'
    'V' = 'Volunteer';

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
    'W' = 'W.ARIC AFU'
    'X' = 'X.Exam scheduled'
    'Y' = 'Y.Clinic exam not scheduled, pending'
    'Z' = 'Z.Cinic exam not scheduled,refused';

  value ASBA2V
    1 = '1 Very Comfortable'
    2 = '2 Somewhat comfortable'
    3 = '3 Somewhat uncomfortable'
    4 = '4 Very uncomfortable'
    5 = '5 Not sure'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value ASBA4V
    1 = '1 No at all'
    2 = '2 Once a month'
    3 = '3 Once a week'
    4 = '4 Once a day'
    5 = '5 More than once a day'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

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
    5 = 'Male';

  value BCFA5V
    1 = 'Balance beam/wall only'
    2 = 'Tanita body composition only'
    3 = 'Both'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

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

  value CLAB1V
    1 = 'Yes'
    2 = 'No';

  value CLAB12V
    1 = 'Set'
    2 = 'Pending'
    3 = 'Refused';

  value CLAB14V
    1 = 'Language barrier'
    2 = 'Physically unable to attend clinic'
    3 = 'Doesn''t want blood drawn'
    4 = 'Doesn''t want to take time off work'
    5 = 'Refusal';

  value CLAB8BV
    1 = '1 JHS volunteer'
    2 = '2 Taxi'
    3 = '3 Other';

  value COFE1V
    1 = 'Yes'
    2 = 'No';

  value $CONA33V
    'C' = 'C. Participant will bring information to clinic'
    'O' = 'O. Complete physician contact information obtained'
    'P' = 'P. Participant to provide at 24-hour pick-up'
    'R' = 'R. Refusal or no health care provider';

  value $CONA35V
    'N' = 'Nurse practitioner'
    'O' = 'Other'
    'P' = 'Physician';

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
    1 = 'Today'
    2 = 'Yesterday'
    3 = 'Before yesterday'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB27V
    1 = 'Inital Visit'
    2 = 'Follow-Up';

  value MSRB27GV
    1 = 'All meds taken in past 2 weeks'
    2 = 'Some meds taken in past 2 weeks'
    3 = 'No meds taken in psat 2 weeks'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB27HV
    1 = 'Can''t find container(s), bottle'
    2 = 'Can''t read label(s)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA1V
    1 = 'Excellent'
    2 = 'Good'
    3 = 'Fair'
    4 = 'Poor'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA2V
    1 = 'Better'
    2 = 'Worse'
    3 = 'About the same'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA21V
    1 = 'Overweight'
    2 = 'Underweight'
    3 = 'About right weight'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA24V
    1 = 'Less than 1 hour per week'
    2 = 'At least 1 hour a week but less than 7 hours a week'
    3 = 'At least 1 hour a day but less than 2 hours a day'
    4 = 'At least 2 hours a day but less than 4 hours a day'
    5 = '4 hours or more a day'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA25V
    1 = 'Within the past year'
    2 = 'At least 1 year, but less than 2 years ago'
    3 = 'At least 2 years but less than 4 years ago'
    4 = '5 or more years ago'
    5 = 'Never'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA27V
    1 = 'Very hard'
    2 = 'Fairly hard'
    3 = 'Not too hard'
    4 = 'Not hard at all'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value HHXA4BV
    1 = 'Less than 6 weeks'
    2 = '6-11 weeks'
    3 = '3-6 months'
    4 = 'Greater than 6 months'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value ICTB2V
    1 = 'CVD research'
    2 = 'Jackson Heart Study only'
    3 = 'No use/storage of DNA'
    4 = 'Other';

  value ICTB2AV
    1 = 'Yes'
    2 = 'No';

  value ICTB3AV
    1 = 'Yes'
    2 = 'No';

  value ICTB3BV
    1 = 'CVD research'
    2 = 'Jackson Heart Study only'
    3 = 'Other';

  value ICTB4AV
    1 = 'Yes'
    2 = 'No'
    3 = 'Partial';

  value $JH_AMPV
    'A' = 'AM'
    'P' = 'PM';



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

  value $JH_YNV
    'Y' = 'Yes'
    'N' = 'No';

  value $JH_YNDV
    'Y' = 'Yes'
    'N' = 'No'
    'D' = 'Don''t know';

  value $JH_YNKV
    'Y' = 'Y. Yes'
    'N' = 'N. No'
    'K' = 'K. Don''t Know'
    'R' = 'R. Refused';

  value $JH_YNUV
    'Y' = 'Yes'
    'N' = 'No'
    'U' = 'Unknown';

  value JS_AMPV
    1 = '1. AM'
    2 = '2. PM';

  value JS_CPV
    1 = '1. Computer'
    2 = '2. Paper   ';

  value JS_DATV
     1 = '1'
     2 = '2'
     3 = '3'
     4 = '4'
     5 = '5'
     6 = '6'
     7 = '7'
     8 = '8'
     9 = '9'
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
    31 = '31';

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
    6 = '6';

  value JS_HRSV
    00 = '00'
    01 = '01'
    02 = '02'
    03 = '03'
    04 = '04'
    05 = '05'
    06 = '06'
    07 = '07'
    08 = '08'
    09 = '09'
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
     0 = '0'
     1 = '1'
     2 = '2'
     3 = '3'
     4 = '4'
     5 = '5'
     6 = '6'
     7 = '7'
     8 = '8'
     9 = '9'
    10 = '10'
    11 = '11'
    12 = '12';

  value JS_ISV
    1 = '1'
    2 = '2';

  value JS_MFV
    1 = '1. Male'
    2 = '2. Female';

  value JS_MINV
    00 = '00'
    01 = '01'
    02 = '02'
    03 = '03'
    04 = '04'
    05 = '05'
    06 = '06'
    07 = '07'
    08 = '08'
    09 = '09'
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
    2009 = '2009';

  value JS_YNV
    1 = 'Yes'
    2 = 'No '
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value CodeRV
    1 = 'Complete'
    2 = 'Incomplete'
    3 = 'Rescheduled'
    8 = 'Refused'
    9 = 'Missing';

  value ACTIV
    0 = 'No action'
    1 = 'Trial interrupted'
    2 = 'Trial discontinued'
    3 = 'Concom drug changed'
    4 = 'Hospitalization';

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
    1 = 'Adverse experience'
    2 = 'Abnormal lab values'
    3 = 'Drug not effective'
    4 = 'Protocol criteria'
    5 = 'Non-compliance'
    6 = 'No consent'
    7 = 'Moved'
    8 = 'Died';

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
    1 = 'Recovered'
    2 = 'Improving'
    3 = 'Unchanged'
    4 = 'Deteriorated'
    5 = 'Died';

  value RELAV
    0 = 'Unrelated'
    1 = 'Related'
    2 = 'Uncertain';

  value SEVEV
    0 = 'None'
    1 = 'Minimal'
    2 = 'Moderate'
    3 = 'Severe';

  value SV
    1 = 'F'
    2 = 'M';

  value VAL_V
    0 = 'None'
    1 = 'Trace'
    2 = 'Path';

  value YESV
    0 = 'No'
    1 = 'Yes';

  value $M_YNV
    'N' = 'No'
    'Y' = 'Yes';

  value MHXBARV
    1 = 'Never'
    2 = 'Seldom'
    3 = 'Sometimes'
    4 = 'Often'
    5 = 'Almost Always';

  value MHXB6V
    1 = 'Excellent'
    2 = 'Very good'
    3 = 'Good'
    4 = 'Fair'
    5 = 'Poor';

  value MHXB9V
    1 = 'Yes'
    2 = 'No'
    3 = 'Never hurries or walks uphill'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB11V
    1 = 'Stop or slow down'
    2 = 'Carry on'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB12V
    1 = 'Relieved'
    2 = 'Not relieved'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB13V
    1 = '10 minutes or less'
    2 = 'More than 10 minutes'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB17V
    1 = 'Angina'
    2 = 'Heart Attack'
    3 = 'Other Heart Disease'
    4 = 'Other';

  value MHXB19V
    1 = '1 month'
    2 = '6 month'
    3 = '1 year'
    4 = '2 years'
    5 = 'Over 2 years'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB31V
    1 = 'Heart Attack'
    2 = 'Other disorder'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB36V
    1 = 'Normal'
    2 = 'Abnormal'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB39V
    1 = 'Pain includes calf/calves'
    2 = 'Pain does not include calf/calves'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB40V
    1 = 'Yes'
    2 = 'No'
    3 = 'Never hurries or walks uphill'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB43V
    1 = 'Stop or slow down'
    2 = 'Carry on'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB44V
    1 = 'Relieved'
    2 = 'Not relieved'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB45V
    1 = '10 minutes or less'
    2 = 'More than 10 minutes'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB51V
    1 = 'Yes'
    2 = 'No'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB52V
    1 = 'Right'
    2 = 'Left'
    3 = 'Both'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB53V
    1 = 'Yes'
    2 = 'No'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB54V
    1 = 'Yes'
    2 = 'No'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB55AV
    1 = 'Emergency for a heart attack'
    2 = 'Chest pain/discomfort'
    3 = 'Doctors suspected disease/blockage'
    4 = 'Followup after heart attack or procedure (surgery/stent)'
    5 = 'Other (specify)'
    7 = 'Don''t know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB55BV
    1 = 'Emergency for a Stroke'
    2 = 'Doctors suspected disease/blockage'
    3 = 'Other (specify)'
    7 = 'Don''t know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB55CV
    1 = 'Leg pain on walking short distance'
    2 = 'Doctors suspected disease/blockage'
    3 = 'Other (specify)'
    7 = 'Don''t know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB56AV
    1 = 'Heart faliure/fluid on lungs'
    2 = 'Heart murmur/Valvular heart disease'
    3 = 'High blood pressure'
    4 = 'Follow up after heart attack or surgery'
    5 = 'Other (Specify)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB56BV
    1 = 'Chest pain/discomfort'
    2 = 'Rhythm disturbance'
    3 = 'High blood pressure'
    4 = 'Other (Specify)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB56CV
    1 = 'Chest pain/discomfort'
    2 = 'Followup after heart attack or procedure'
    3 = 'Other (Specify)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MHXB56DV
    1 = 'Passing Out'
    2 = 'Forgetfulness'
    3 = 'TIA (little stroke)'
    4 = 'Stroke'
    5 = 'Blocked arteries'
    6 = 'Other (specify)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB2V
    1 = 'Yes, all'
    2 = 'Some of them'
    3 = 'None (forgot/unable)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB33V
    1 = 'Less than 300mg (Baby)'
    2 = '300-499mg (Regular)'
    3 = '500mg or greater (Extra Strength)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB34V
    1 = 'Yes'
    2 = 'No'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB3AV
    1 = 'Yes'
    2 = 'No (don''t want follow-up)'
    3 = 'Insist to list by memory'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB42V
     1 = 'Daily'
     2 = 'Weekly'
     3 = 'Several times a month'
     4 = 'Monthly'
     5 = 'Several times a year'
     6 = 'Yearly'
     7 = 'Rarely'
     8 = 'Almost never'
     9 = 'Never'
    77 = 'Don''t Know'
    88 = 'Refused'
    99 = 'Missing';

  value MSRB41V
    1 = 'Yes'
    2 = 'No'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value MSRB4BV
    1 = '1.mg'
    2 = '2.g'
    3 = '3.ml'
    4 = '4.tsp'
    5 = '5.ng'
    6 = '6.ug'
    7 = '7.cc'
    8 = '8.meq';

  value PECB6V
    1 = 'Yes'
    2 = 'No';

  value PITB1AV
    1 = '1. Initial'
    2 = '2. Rescheduled';

  value PITB4V
    1 = '1. Yes'
    2 = '2. No '
    3 = '3. Rescheduled'
    8 = '8. Refused'
    9 = '9. Missing';

  value PNPB1V
    1 = '1. A qualtiy control (QC) phantom participant'
    2 = '2. A non-participant';

  value SBPB12V
    1 = 'Random Zero only'
    2 = 'Omron Only'
    3 = 'Both';

  value SBPB9V
    1 = 'Small Adult (<24cm)'
    2 = 'Regular Arm (24-32cm)'
    3 = 'Large Arm (33-41cm)'
    4 = 'Thigh (>41cm)';

  value SMPB10V
    1 = 'Dialysis graft'
    2 = 'Mastectomy on nondominant side'
    3 = 'Infection'
    4 = 'Other (Specify)'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

  value SMPB12V
    1 = 'Exceeded maximum cuff size'
    2 = 'Other'
    7 = 'Don''t Know'
    8 = 'Refused'
    9 = 'Missing';

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

  value $VENB5AV
    'X' = 'X';

  value VENB7AV
    1 = '1. Yes'
    2 = '2. No '
    3 = '3. Yes, tube 1 only'
    7 = '7. Don''t Know'
    8 = '8. Refused'
    9 = '9. Missing';

	***********************Yan Gao added formats****************************;
  value ADA00CL
    0 = 'Hypoglycemia'
    1 = 'Normal'     
    2 = 'Impaired Fasting Glucose (IFG)'          
    3 = 'Diabetes' ;

  value ADA04CL 
    1 = 'Normal'
    2 = 'Impaired Fasting Glucose (IFG)'                   
    3 = 'Diabetes'   ;

  value AWARE
    0 = 'Unaware'
    1 = 'Aware' ;    

  value CATONE
    0 = 'Normal '
    1 = 'Overweight' ;    

  value CATTWO
    0 = 'Normal'
    1 = 'Overweight'     
    2 = 'Obese';        

  value COMMERCE
    0 = 'No'
    1 = 'Yes'    ;

  value CONTROL
    0 = 'Uncontrolled'
    1 = 'Controlled'    ;

  value CTBOOLV
    0 = 'No'
    1 = 'Yes'    ;

  value CTPGRPV 
   -4 = 'Oracle' 
   -1 = 'Obsolete'      
   0 = 'Internal' 
   1 = 'Admin' 
   2 = 'Manage'     
   5 = 'Enter'                                   
   6 = 'Design'
   7 = 'Retrieve'
   8 = 'Lab Loader'   ;

  value DNA
    0 = 'No'
    1 = 'DNA only'                                   
    2 = 'DNA and cryoperservation' ;        

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


  value  HTN 
    0 = 'Normotensive'
    1 = 'Hypertensive '     ;                              

  value JNC6CL
    0 = 'Optimal'
    1 = 'Normal'       
    2 = 'High-Normal'                                 
    3 = 'Hypertension Stage I'                    
    4 = 'Hypertension Stage II'                   
    5 = 'Hypertension Stage III'  ;
 
  value JNC7CL
    0 = 'Normal'  
    1 = 'Pre-Hypertension' 
    2 = 'Hypertension Stage I'                      
    3 = 'Hypertension Stage II'  ;                    
 
  value JS_FV    
    1 = 'Yes'    
    2 = 'No'                       
    7 = 'Don''t Know'                                
    8 = 'Refused'                                
    9 = 'Missing'   ;

  value MED
    0 = 'Untreated' 
    1 = 'Treated'     ;                              

 value MEDCT
  	 0 = 'No medication data ' 
  	 1 = 'There are listed medications and the information appears reliable'
     2 = 'Participant reported that no medication had been taken in 2 weeks preceeding the '
     99 = 'Medication accountability is incomplete /unreliable ';

  value MEDTYPE
    0 = 'Oral Only'                                  
    1 = 'Insulin Only'                             
    2 = 'Insulin and Oral'  ;                                             

  value MHXB55V
    1 = 'Emergency for a heart attack'            
    2 = 'Chest pain/discomfort'                   
    3 = 'Doctors suspected disease/blockage'     
    4 = 'Followup after heart attack or procedure'
    5 = 'Other (specify)'                         
    7 = 'Don''t know '
    8 = 'Refused' 
    9 = 'Missing' ;

  value MHXB56V
    1 = 'Passing Out '          
    2 = 'Forgetfulness '                   
    3 = 'TIA (little stroke)'                      
    4 = 'Stroke'  
    5 = 'Blocked arteries'                         
    6 = 'Other (specify)'                         
    7 = 'Don''t know '
    8 = 'Refused' 
    9 = 'Missing' ;

  value MHXB57V
    1 = '1'        
    2 = '2'             
    3 = '3'   
    4 = '4' 
    5 = '5'
    7 = 'Don''t know '
    8 = 'Refused'   
    9 = 'Missing' ;

   value MHXB58V
    1 = '1'        
    2 = '2'             
    3 = '3'   
    7 = 'Don''t know '
    8 = 'Refused' 
    9 = 'Missing' ;

   value MHXB59V
    1 = '1'        
    2 = '2'             
    3 = '3'   
    4 = '4' 
    5 = '5'
    6 = '6' 
    7 = '7'
    8 = '8' 
    9 = '9' ;

  value PINB6V 
    1 = 'Social Work Exit Interview/Satisfication'        
    2 = 'Tech Code';                                            

  value SRMED
    . = 'Unknown'   
    1 = 'Yes'                                             
    2 = 'No';              

 value STATUS  
    0 = 'Absent'
    1 = 'Absent per Self-Report'    
    2 = 'Present per Self-Report'
    3 = 'Present' ;

 value STUDY
    0 = 'No'
    1 = 'JHS investigators only'    
    2 = 'JHS and other investigators';             

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
    199 = 'Chrishanda Wilson'   ;

   value TREAT
    0 = 'Untreated'
    1 = 'Treated'    ;

   value WHO
    1 = 'Underweight'    
    2 = 'Normal'
    3 = 'Pre-obese'                                   
    4 = 'Obese class I'                            
    5 = 'Obese class II '                          
    6 = 'Obese class III ';                         

   value YN
    0 = 'No'
    1 = 'Yes' ;

    value $AGE2GRPV 
    '0' = '25 - 34'    
    '1' = '35 - 44'                                
    '2' = '45 - 54'                              
    '3' = '55 - 64'                                 
    '4' = '65 - 74'                                
    '5' = '75 - 84'                                
    '6' = '85 & Older';      

    value $INVCODE
   '201' = 'M Bennet' 
   '202' = 'C Moore ' 
   '203' = 'L Frith'                                 
   '204' = 'K Cousin'                                
   '205' = 'P Hayes'                                 
   '206' = 'D Bliss'                                 
   '207' = 'M Latiker'                               
   '208' = 'R Sababu'                                
   '209' = 'C Funches'                               
   '210' = 'Z Johnson'                               
   '211' = 'K Jones'                                 
   '212' = 'S Fuqua'                                 
   '213' = 'S Barker'                                
   '214' = 'V McNair'                                
   '215' = 'J Sims'                                  
   '216' = 'L Blackmon'                              
   '217' = ' Morgan'                                
   '218' = 'T Craft'                                 
   '219' = 'K Samdarshi'                            
   '220' = 'R Jenkins'                              
   '221' = 'K Walker'                               
   '222' = 'L Thigpen'                               
   '223' = 'I Berry'                                
   '224' = 'J Burwell'                               
   '225' = 'V Carter'                                
   '226' = 'K Fairley'                               
   '227' = 'T Harris'                                
   '228' = 'T Y Johnson'                             
   '229' = 'C McFarland'                             
   '230' = 'P Miller'                               
   '231' = 'D Spires'                                
   '232' = 'M Taylor'                                
   '233' = 'T Woods'                                 
   '234' = 'Summer Intern'                           
   '235' = 'T Carpenter'                             
   '236' = 'T Harding'                               
   '237' = 'A Johnson'                               
   '238' = 'C Champion'                              
   '239' = 'M Bradley'                              
   '240' = 'S Wyatt(Dr)'                            
   '241' = 'D Douglas'                               
   '242' = 'M Rowser'                                
   '243' = 'O Rahaim'                                
   '244' = 'Teresa'                                 
   '245' = 'PRN'                                    
   '246' = 'H Ahmed'                                 
   '247' = 'A Walker'                                
   '248' = 'J Wilson(Dr)'                            
   '249' = 'R Wilhite'                               
   '250' = 'V Gess'                                  
   '251' = 'F Anderson'                              
   '252' = 'R Johnson'                               
   '253' = 'M Crump'                                 
   '254' = 'M Hawkins'                             
   '255' = 'V McKinney'                            
   '256' = 'P Bailey'                               
   '257' = 'K Ellis'                                
   '258' = 'B Stringfellow'                         
   '259' = 'C Wilson'                              
   '260' = 'G Daniels'                              
   '261' = 'C Butts'                               
   '262' = 'B Johnson'                             
   '263' = 'M Brock'                               
   '264' = 'C Graves'                           
   '265' = 'P Anugu'                                
   '266' = 'L Young'                               
   '267' = 'T Brown' ;                      

 value $JH_CPV  
   'C' = 'Computer'                                
   'P' = 'Paper';                                   

 value $JH_STAV 
   'AK' = 'AK. Alaska '    
   'AL' = 'AL. Alabama '                           
   'AR' = 'AR. Arkansas '                           
   'AZ' = 'AZ. Arizona'                             
   'CA' = 'CA. California'                         
   'CN' = 'CN. Canada '                           
   'CO' = 'CO. Colorado'                           
   'CT' = 'CT. Connecticut'                         
   'CU' = 'CU. Cuba '                               
   'DC' = 'DC. Washington, DC '                     
   'DE' = 'DE. Delaware'                            
   'FL' = 'FL. Florida '                            
   'GA' = 'GA. Georgia '                            
   'GU' = 'GU. Guam'                               
   'HI' = 'HI. Hawaii '                             
   'IA' = 'IA. Iowa'                                
   'ID' = 'ID. Idaho'                              
   'IL' = 'IL. Illinois'                           
   'IN' = 'IN. Indiana'                             
   'KS' = 'KS. Kansas '                             
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
   'NH' = 'NH. New Hampshire '                     
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
   'WY' = 'WY. Wyoming'   ;

 value $SBPE7V  
   'L' = 'Large Arm {33-41cm}'              
   'R' = 'Regular Arm {24-32cm}'          
   'S' = 'Small Adult {<24cm}'           
   'T' = 'Thigh {>41 cm}';

run;


 
