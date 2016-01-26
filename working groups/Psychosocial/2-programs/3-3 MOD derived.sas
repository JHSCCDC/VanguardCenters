**************************************************************************************************;
******************************           Section 3: Moods         ********************************;
**************************************************************************************************;


* Anger Expression Scale from Spielberger State-Trait Anger Inventory **************;

data anger (label="Anger Expression Inventory"  ) ;
	set jhsv3.stxb (drop=STXB19 );

*Anger expression: anger in;
	angerIn = stxb2 + stxb3 + stxb4 + stxb7 + stxb9 + stxb11 + stxb12 + stxb14 ;

*Anger expression: anger out;
	angerOut = stxb1 + stxb5 + stxb6 + stxb8 + stxb10 + stxb13 + stxb15 + stxb16 ;

*Minimum score is 8. Set particpant to missing if score is less than 8 (i.e. participant any has missing responses);
	if angerIn < 8 then angerIn=. ;
	if angerOut < 8 then angerOut=. ;

	rename 	angerIn  = ang03in
			angerOut = ang03out 
	;
	
run;


data anger (label="Anger Expression Inventory"  ) ;
	set work.anger ;	

	label ang03in  = "Anger expression: Anger In"
		  ang03out = "Anger expression: Anger Out" ;
run;

*sort  ***************************************************;
proc sort data=work.anger;   	by subjid;  run;




