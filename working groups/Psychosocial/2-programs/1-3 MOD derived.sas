**************************************************************************************************;
******************************           Section 3: Moods         ********************************;
**************************************************************************************************;


*Deprssion:Center for Epidemiologic Studies Depression (CES-D) scale  score  *********************;

data cesd (label="Derived Depression Variables");
	set jhsv1.cesa (drop=PAGREPEAT CESA23 );

*for recoding variables;
	array all (*) cesa1-cesa20;
	array new (*) NCESA1 - NCESA20 ;
*reverse score questions 4,8,12,16 ;
	array rev (*) Ncesa4  Ncesa8  Ncesa12  Ncesa16  ;

*recode all responses so that 1= 0, 2= 1, 3= 2, 4= 3;
	do i= 1 to dim(all) ;
		if all(i) ne .  then do;
			new(i) = all(i)-  1 ;
		end; 
	end;

*reverse code Q4,Q8,Q12,Q16;
	do j= 1 to DIM(rev) ;
		if rev(j) ne .  then do;
			if rev(j) = 0 then rev(j) = 3 ; else
			if rev(j) = 1 then rev(j) = 2 ; else
			if rev(j) = 2 then rev(j) = 1 ; else
			if rev(j) = 3 then rev(j) = 0 ; else
			rev(j)=.;
		end;
	end;

*count the number of unanswered responses;
	no_answ= nmiss(of cesa1-cesa20) ;

*CES-D score is not calculated if more than 4 responses are missing;
	if no_answ lt 5 then do ;
		DPS01=sum(NCESA1,  NCESA2,  NCESA3,  NCESA4,  NCESA5,
				  NCESA6,  NCESA7,  NCESA8,  NCESA9,  NCESA10,
				  NCESA11, NCESA12, NCESA13, NCESA14, NCESA15,
				  NCESA16, NCESA17, NCESA18, NCESA19, NCESA20 ) ; 
	end;

*flag participants with missing scores;
	if DPS01 = . then flag='Y'; else flag='N' ;

*drop counters and original variables;
	drop i j cesa1-cesa20 ;

*label;
	label DPS01   = "Total Depressive Symptoms Score"
		  no_answ = "Number of Questions Unanswered" 
		; 
	format DPS01 8.2 
		;
 run;

* Anger Expression Scale from Spielberger State-Trait Anger Inventory **************;
data anger ;
	set jhsv1.stxa (drop=STXA19 PAGREPEAT);

*Anger expression: anger in;
	angerIn = stxa2 + stxa3 + stxa4 + stxa7 + stxa9 + stxa11 + stxa12 + stxa14 ;

*Anger expression: anger out;
	angerOut = stxa1 + stxa5 + stxa6 + stxa8 + stxa10 + stxa13 + stxa15 + stxa16 ;

*Minimum score is 8. Set particpant to missing if score is less than 8 (i.e. participant any has missing responses);
	if angerIn < 8 then angerIn=. ;
	if angerOut < 8 then angerOut=. ;

	rename 	angerIn  = ang01in
			angerOut = ang01out ;
run;

data anger (label="Anger Expression Inventory"  ) ;
	set work.anger ;	

	label ang01in  = "Anger expression: Anger In"  ;
	label ang01out = "Anger expression: Anger Out" ;
run;


*Measures of hostility derived from the  Cook-Medley Hostility Scale **************;
data hostility (label="27-Item Hostility Scale " );
	set jhsv1.choa (drop=pagrepeat choa30 );

array cynic1 (*) choa1 choa2 choa3 choa4 choa5 choa6 choa7 choa8 choa9 choa10 choa11 choa12 choa13 ;
array cynic2 (*) choa1r choa2r choa3r choa4r choa5r choa6r choa7r choa8r choa9r choa10r choa11r choa12r choa13r ;
array affect1 (*)  choa14 choa16 choa17  choa24 ;
array affect2 (*)  choa14r choa16r choa17r  choa24r ;
array response1(*) choa15 choa19 choa20 choa22 choa23 choa25 choa26 choa27 ;
array response2(*) choa15r choa19r choa20r choa22r choa23r choa25r choa26r choa27r ;
array recodes1 (*)  choa18 choa21;
array recodes2 (*)  choa18R choa21R;

*recodes (q18, q21) ;
do i=1 to dim(recodes1);
	if recodes1(i)='F' then recodes2(i)=1; else
	if recodes1(i)='T' then recodes2(i)=0; else 
	recodes2(i)= . ;
end;

* Cynicism ;
do j=1 to dim(cynic1);
	if cynic1(j)='F' then cynic2(j)=0; else
	if cynic1(j)='T' then cynic2(j)=1;  else 
	cynic2(j)= . ;
end;

hst01cyn = choa1r + choa2r + choa3r + choa4r + choa5r + choa6r + choa7r + choa8r + choa9r + choa10r + choa11r + choa12r + choa13r ;

* Hostile Affect  ;
do k=1 to dim(affect1);
	if affect1(k)='F' then affect2(k)=0; else
	if affect1(k)='T' then affect2(k)=1;  else 
	affect2(k)= . ;
end;

hst01aft = choa14r + choa16r + choa17r + choa24r + choa21R ;

* Aggressive Responding ;
do l=1 to dim(response1);
	if response1(l)='F' then response2(l)=0; else
	if response1(l)='T' then response2(l)=1; else 
	response2(l)= . ;
end;

hst01resp = choa15r + choa19r + choa20r + choa22r + choa23r + choa25r + choa26r + choa27r + choa18R ;

label 	hst01cyn =  "Hostility: Cynicism"
		hst01aft    =  "Hostility: Hostile Affect"
		hst01resp  =  "Hostility: Aggressive Responding" ;

format  hst01cyn hst01aft hst01resp 8. ;

drop i j k l 
	choa1 choa2 choa3 choa4 choa5 choa6 choa7 choa8 choa9 choa10 choa11 choa12 choa13 
	choa14 choa16 choa17  choa24 choa18 choa21
	choa15 choa19 choa20 choa22 choa23 choa25 choa26 choa27  
;

run;


*sort  ***************************************************;
proc sort data=work.cesd;    	by subjid;  run;
proc sort data=work.anger;   	by subjid;  run;
proc sort data=work.hostility;	by subjid;  run;



