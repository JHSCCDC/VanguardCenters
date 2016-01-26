*********************** Jackson Heart Study ************************;
************ Validation documentation creation programs ************;

title;

********************************************************************;
****************** Create Validation documentation  ****************;
********************************************************************;

*Read in Validation Analysis Data;
data validation; set dat.jhs_nb_analytic_long; run;

options nonotes;
%put;
%put;
%put ***** Validation1 Dataset (Exam Visit 1) *****;

  ods results off;

 ods rtf file = "3-results\validation\2-1-1-validation census.rtf";
    %include pgms("2-1-1-validation census.sas"); 
  ods rtf close;

 ods rtf file = "3-results\validation\2-1-2-validation social.rtf";
    %include pgms("2-1-2-validation social.sas"); 
  ods rtf close;

 ods rtf file = "3-results\validation\2-1-3-1-validation food & activity resourcesn.rtf";
    %include pgms("2-1-3-1-validation food & activity resources.sas"); 
  ods rtf close;

   ods rtf file = "3-results\validation\2-1-3-2-validation food & activity resourcesn.rtf";
    %include pgms("2-1-3-2-validation food & activity resources.sas"); 
  ods rtf close;

 ods rtf file = "3-results\validation\2-1-4-validation built.rtf";
    %include pgms("2-1-4-validation built.sas"); 
  ods rtf close;
  ods results on;

  %put;
  %put;
options notes;

%put Visit 1 Validation Results Complete (See data\Analysis Data\results\validation1);
%put;
%put;
