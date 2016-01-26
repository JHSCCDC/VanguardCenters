  
********************************************************************;
******************** Section 2: Demographics ***********************;
********************************************************************;

title1 "Section 2: Demographics";

*Produce basic statistics*******************************************;

*Variable List;

  *Continuous;                    
   %let contvar = age brthyr;

   *Categorical;                   
   %let catvar  = brthmo sex male menopause;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;
title "summary of age by sex";
proc means data = validation;
class sex;
var age;
run;

title2 "Age vs Year of Birth";
proc gplot data = validation;
symbol1  pointlabel=none;
  plot age*brthyr /vaxis = axis1;
  run; quit;


title2 "Sex Classification vs Male Indicator";
proc freq data = validation;
  tables sex*male;
  format male;
  run;

title2 "Sex Classification vs Menopause Indicator";
proc freq data = validation;
  tables sex*menopause;
  run;


%put Section 02 Complete;
