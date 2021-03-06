********************************************************************;
****************** Section 3: Anthropometrics **********************;
********************************************************************;

title1 "Section 03: Anthropometrics";

*Produce basic statistics*******************************************;

*Variable List;

  *Continuous;                    
  %let contvar = weight height BMI waist hip bsa;

  *Categorical;                   
  %let catvar  = BMI3cat;

*Simple Data Listing & Summary Stats;
%simple;

*Cross-tabs and other validations***********************************;

title2 "Summaries by BMI 3-level categories";
proc means data = validation maxdec = 2 fw = 6; 
  class bmi3cat;
  var bmi height weight waist bsa;
  run;

title2 "BMI: Check Outliers (max is > 90)";
proc univariate data = validation ; 
 var bmi ; 
 run;
 
*Mark the outliers of BMI;
 data validation;
  set validation;
  if BMI>90 then do;
    outlier=1;*indicator for outlier status;
    outlier_text_hw=cats("Outlier:",subjid);
  end; 
run;

proc gplot data = validation;
title2 "Height vs Weight by BMI Categorization";
symbol1 value=dot interpol=none pointlabel=("#outlier_text_hw" c=red h=1 );
  plot height*weight = bmi3cat/vaxis = axis1
                               vref  = 150 to 190 by 10 
                               href  = 60  to 160 by 20;
		
  *Note: "150cm to 190cm by 10cm" = "4ft 11in to 6ft 3in by 4in";
  *Note: "60kg  to 160kg by 20kg" = "130lbs   to 350lbs  by 40lbs";
  run; quit;

title2 "Hip vs Weight by BMI Categorization";
proc gplot data = validation;
symbol1 value=dot interpol=none pointlabel=none ;
  plot hip*weight = bmi3cat /vaxis = axis1; 
  run; quit;

*Mark the outliers;
data validation;
  set validation;
  if weight>190 and waist<110 then do;
    outlier=1;*indicator for outlier status;
    outlier_text_ww=cats("Outlier:",subjid);
  end; 
run;

title2 "Waist vs Weight by BMI Categorization";
proc gplot data = validation;
symbol1 value=dot interpol=none pointlabel=("#outlier_text_ww" c=red h=1 );
  plot waist*weight = bmi3cat /vaxis = axis1; 
  run; quit;
  
   title2 "Waist vs Hip by BMI Categorization";
proc gplot data = validation;
symbol1 value=dot interpol=none pointlabel=none;
  plot waist*hip= bmi3cat /vaxis = axis1; 
  run; quit;

*Compare BMI and BSA;
title2 "Body Surface Area vs Body Mass Index for Males";
proc sgplot data = validation;
  where male = 1;
	reg x=bmi y=bsa / markerattrs=(symbol=trianglefilled size=3);
	loess x=bmi y=bsa / nomarkers;
run;

title2 "Body Surface Area vs Body Mass Index for Females";
proc sgplot data = validation;
  where male = 0;
	reg x=bmi y=bsa / markerattrs=(symbol=trianglefilled size=3);
	loess x=bmi y=bsa / nomarkers;
run;


%put Section 03 Complete;
