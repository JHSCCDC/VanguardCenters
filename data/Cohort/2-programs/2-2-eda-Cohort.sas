*Exploratory Data Analysis (EDA);

ods rtf file = "Cohort\3-results\2-eda-cohort.rtf";

  title 'Contact Type by Contact Year';
    proc freq data = cohort.cohort; table type*year /missing; run;
  title;

  proc freq data = splmnt.TERa; table TERa3; 
  format tera3 tera.; run;

ods rtf close;
