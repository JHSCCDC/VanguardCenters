**************************************************************************************************;
***************************   Section 1: Discrimination   ****************************************;
**************************************************************************************************;

*Everyday Discrimination (visit 3) **************************************************************************;

data discrm1 ;
	 set jhsv3.disb ;

	array ED 		(*) disb1a disb1b disb1c disb1d disb1e disb1f disb1g disb1h disb1i;
	array ed_fREQ   (*) Q1A Q1B Q1C Q1D Q1E Q1F Q1G Q1H Q1I ;

*Create everyday discrimination: Frequency;
	*recode response to numeric values and Don't know/Refused/Missing to . ; 
		do  i=1 to dim(ED);
			if ED(i)=1 then ed_FREQ(i)= 7; else
			if ED(i)=2 then ed_FREQ(i)= 6; else
			if ED(i)=3 then ed_FREQ(i)= 5; else
			if ED(i)=4 then ed_FREQ(i)= 4; else
			if ED(i)=5 then ed_FREQ(i)= 3; else
			if ED(i)=6 then ed_FREQ(i)= 2; else
			if ED(i)=7 then ed_FREQ(i)= 1; 
			else ed_FREQ(i) = . ;
		end;
	*The discrimination frequecy score is the mean of the responses;
		dis03ed = (Q1A+Q1B+Q1C+Q1D+Q1E+Q1F+Q1G+Q1H+Q1I)/9 ;


*Create everyday discrimination: occurrence variable;
	 NEVERresp = countc(catt(of Q1A,Q1B,Q1C,Q1D,Q1E,Q1F,Q1G,Q1H,Q1I), '1'); 
	 dis03eo = 9 - NEVERresp ;

*Attribution missing if no everyday discrimination events occurred;
	if dis03ed gt 1 then do;
		*Create everyday discrimination: Attribution;
			if not missing(disb2a) then do;
				if disb2a = 3  then dis03ea=1 ; 
				else dis03ea=0 ;
			end;
			if ( missing(disb2a) | disb2a=6 ) then dis03ea=. ;
	end;
		if missing(disb2a) and dis03ed le 1 then dis03ea=.;

label 	dis03eo = "everyday experiences: occurrence "
		dis03ed = "everyday experiences: score "
		dis03ea = "everyday experiences: attribution  "
	;
format  dis03eo  8.2 
		dis03ea  dis01ea.
		dis03ed  8.2 
	;
keep subjid dis03eo dis03ed dis03ea   
	;
run;


*Sort and merge to create discrimination dataset******************************************************;
	proc sort data=discrm1; by subjid; run;



