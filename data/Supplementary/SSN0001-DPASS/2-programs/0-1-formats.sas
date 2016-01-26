********************************************************************;
****************** Define JHS Exam Visit 1 Formats *****************;
********************************************************************;

proc format library = dat;

value $JH_CPV
    'C' = 'Computer'
    'P' = 'Paper'; 

value $JH_YNV
    'N' = 'N. No'
    'Y' = 'Y. Yes';

  value $PPAA7V
    'A' = 'A. Very comfortable'
    'B' = 'B. Somewhat comfortable'
    'C' = 'C. Somewhat uncomfortable'
    'D' = 'D. Very uncomfortable'
    'E' = 'E. Not sure';
 
  run ;
