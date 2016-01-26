**************************************************************************************************;
***************************   Section 1: Discrimination   ****************************************;
**************************************************************************************************;


*Everyday Discrimination (visit 1) ***************************************************************;

data discrm1;
	 set jhsv1.disa ;

	array ED 		(*) disa1a disa1b disa1c disa1d disa1e disa1f disa1g disa1h disa1i;
	array ed_fREQ   (*) Q1A Q1B Q1C Q1D Q1E Q1F Q1G Q1H Q1I ;

*Create everyday discrimination: occurrence variable;
	 NEVERresp = countc(catt(of disa1a disa1b disa1c disa1d disa1e disa1f disa1g disa1h disa1i),'G'); 
	 dis01eo = 9 - NEVERresp ;

*Create everyday discrimination: Frequency;
	*recode response to numeric values; 
		do  i=1 to dim(ED);
			if ED(i)='A' then ed_FREQ(i)= 7; else
			if ED(i)='B' then ed_FREQ(i)= 6; else
			if ED(i)='C' then ed_FREQ(i)= 5; else
			if ED(i)='D' then ed_FREQ(i)= 4; else
			if ED(i)='E' then ed_FREQ(i)= 3; else
			if ED(i)='F' then ed_FREQ(i)= 2; else
			if ED(i)='G' then ed_FREQ(i)= 1; 
			else ed_FREQ(i) = . ;
		end;
	*The discrimination frequecy score is the mean of the responses;
		dis01ed = (Q1A+Q1B+Q1C+Q1D+Q1E+Q1F+Q1G+Q1H+Q1I)/9 ;

*Coping and attribution missing if no everyday discrimination events occurred;
	if dis01ed gt 1 then do;
		*Create everyday discrimination: Attribution;
			if not missing(disa2a) then do;
				if disa2a = 'C'  then dis01ea=1 ; 
				else dis01ea=0 ;
			end;
			if missing(disa2a) then dis01ea=. ;
		*Create everyday discrimination:Coping;
			*Everyday: emotion-focused/problem-focused;
				if disa3a in ('B','C','E','G', 'H', 'J', 'K') 
						THEN dis01ec2=1; else /*emotion focused*/
				if disa3a in ('A','D','F','I') 
						THEN dis01ec2=2;  /*problem focused*/
				else dis01ec2 = . ;
	end;
		if missing(disa2a) and dis01ed le 1 then dis01ea=.;
		if dis01ed le 1 then dis01ec1=.;
		if dis01ed le 1 then dis01ec2=.;

label 	dis01eo = "everyday experiences: occurrence "
		dis01ed = "everyday experiences: score "
		dis01ea = "everyday experiences: attribution  "
		dis01ec1 = "everyday experiences: coping (p/a/e)"
		dis01ec2 = "everyday experiences: coping (ef/pf) "
	;
format  dis01eo  8.2 
		dis01ea  dis01ea.
		dis01ec1 dis01ecB. 
		dis01ec2 dis01ecA. 
		dis01ed  8.2 
	;
keep subjid dis01eo dis01ed dis01ea dis01ec2 
	;
run;

*Lifetime Discrimination **************************************************************************;
data discrm2;
	set jhsv1.disa;
	
	array LifeCopeA (*) disa14a disa14d disa14f disa14i disa14b disa14c disa14e disa14g disa14h disa14j disa14k; 
	array LifeCopeB (*) cope14a cope14d cope14f cope14i cope14b cope14c cope14e cope14g cope14h cope14j cope14k;  

*Create major life events score: frequency ;
	 LENGTH OCCUR $ 9 ;
	 OCCUR=catt(of DISA4A DISA5A DISA6A DISA7A DISA8A DISA9A  DISA10A  DISA11A  DISA12A);
	 LENG=LENGTH(OCCUR);
 *If dissa4a-disa12a are not missing, then calculate lifetime discrimination score;
	 IF LENG=9 THEN dis01lt = countc(OCCUR,'Y'); ELSE 
		IF LENG < 9 THEN dis01lt = . ;

*Create major life events: occurrence ;
	 if dis01lt ge 1 then dis01lo= 1 ; else dis01lo= 0;

*Coping and attribution missing if no lifetime discrimination events occurred;
	if dis01lo = 1 then do ;
		*Create major life events: attribution;
			if not missing(DISA13A) then do;
				if DISA13A = 'C'  
					then dis01la = 1 ;
				else dis01la = 0 ;
			end;
		*Create major life events: Coping Responses;
			*Lifetime: emotion-focused/problem-focused;
				do i=1 to dim(LifeCopeA);
					if LifeCopeA(i)= "Y" then LifeCopeB(i)=1 ; else
					if LifeCopeA(i)= "N" then LifeCopeB(i)=0 ; else
					   LifeCopeB(i)= . ;
				end;
			*Create major life event coping [mean] scores ;
				COPE=COUNTC(CATT(OF cope14a cope14d cope14f cope14i cope14b cope14c cope14e cope14g cope14h cope14j cope14k),'.');
				IF COPE = 0 THEN DO  ; 
						dis01lc2a=(cope14b+cope14c+cope14e+cope14g+cope14h+cope14j+cope14k)/7;
						dis01lc2b=(cope14a+cope14d+cope14f+cope14i)/4;
				END ;

				IF COPE NE 0 THEN dis01lc2a=. ;
				IF COPE NE 0 THEN dis01lc2b=. ;

	end;

*Create major life events: burden of major events discrimination;
		*Recode variables ;

			if disa16='A' then Q16=4  ; else
			if disa16='B' then Q16=2.5; else
			if disa16='C' then Q16=1  ; 
				else Q16= . ;

			if disa17='A' then Q17=4 ; else
			if disa17='B' then Q17=3 ; else
			if disa17='C' then Q17=2 ; else
			if disa17='D' then Q17=1 ;
				else Q17= . ;

			if disa18='A' then Q18=4 ; else
			if disa18='B' then Q18=3 ; else
			if disa18='C' then Q18=2 ; else
			if disa18='D' then Q18=1 ;
				else Q18= . ;
	*Calculate the burden of discrimnation score ONLY if ANY lifetime discrimination has occurred;
	if 	dis01lo=1 then	dis01bd = ((q16+q17+q18)/3); else
		if dis01lo=0 then dis01bd=. ;


label	dis01lo = "major life events: occurrence "
		dis01lt = "major life events: score (0-9)"
		dis01la = "major life events: atribution (racial/non-racial)"
		dis01lc2a = "major life events: coping (emotion-focused) "
		dis01lc2b = "major life events: coping (problem-focused) "
		dis01bd = "major life events: burden score (0-4) "
	;
format 	dis01lo yn. 
		dis01la dis01ea. 
		dis01lt  dis01lc2a dis01lc2b 8.2
	;
keep subjid dis01lo dis01lt dis01la 
	 dis01lc2a dis01lc2b dis01bd 
	;

run;

*Sort and merge to create discrimination dataset******************************************************;
	proc sort data=discrm1; by subjid; run;
	proc sort data=discrm2; by subjid; run;


