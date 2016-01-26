

*Minor stressors: weekly stress inventory   ***************************************************;

	data WSI (keep=subjid STS01WSE STS01WSI);
	set jhsv1.wsia;

	*Weekly Stress Inventory-Events;
		*Number of missing responses;
			NoResponse =  countc(catt(of wsia1-wsia87),'.') ;
		*#event did not occur;
			response =  countc(catt(of wsia1-wsia87),'0') ;
		*Total number of events that occurred;
			events = 87 - response ;
		*Missing if any questions unanwered;
			if NoResponse > 0 then STS01WSE=. ; else
			if NoResponse = 0 then STS01WSE=events;

	*Weekly Stress Inventory-Impact;
		*Sum all responses for weekly stress impact score;
		 	STS01WSI = wsia1 + wsia2 + wsia3 + wsia4 + wsia5 + wsia6 + wsia7 + wsia8 + wsia9 + wsia10 
			   	   + wsia11 + wsia12 + wsia13 + wsia14 + wsia15 + wsia16 + wsia17 + wsia18 + wsia19 
			       + wsia20 + wsia21 + wsia22 + wsia23 + wsia24 + wsia25 + wsia26 + wsia27 + wsia28 + wsia29 
			       + wsia30 + wsia31 + wsia32 + wsia33 + wsia34 + wsia35 + wsia36 + wsia37 + wsia38 + wsia39 
			       + wsia40 + wsia41 + wsia42 + wsia43 + wsia44 + wsia45 + wsia46 + wsia47 + wsia48 + wsia49 
			       + wsia50 + wsia51 + wsia52 + wsia53 + wsia54 + wsia55 + wsia56 + wsia57 + wsia58 + wsia59 
			       + wsia60 + wsia61 + wsia62 + wsia63 + wsia64 + wsia65 + wsia66 + wsia67 + wsia68 + wsia69
			       + wsia70 + wsia71 + wsia72 + wsia73 + wsia74 + wsia75 + wsia76 + wsia77 + wsia78 + wsia79
			       + wsia80 + wsia81 + wsia82 + wsia83 + wsia84 + wsia85 + wsia86 + wsia87;

	*labels and formats;
		label 	STS01WSE='Weekly Stress Inventory (WSI) event  score' 
				STS01WSI='Weekly Stress Inventory (WSI) impact  score' 
			;
		format STS01WSE STS01WSI 8.2 ;
	run;


*Chronic stressors: global perceived stress   ***************************************************;

	data GPSS (keep=subjid STS01TG STS01AG); ;
	set jhsv1.Stsa ;

	*Recode participant responses ;
		array gpss(*)   STSA1 - STSA8;       
		array cgpss(*)   cSTSA1 - cSTSA8;       
		  	do i = 1 to dim(gpss);                 
			    if      gpss(i) = "A"  then cgpss(i)= 0;  *A.not stressful;
			    else if gpss(i) = "B"  then cgpss(i)= 1;  *B.Mildly Stressful ;
			    else if gpss(i) = "C"  then cgpss(i)= 2;  *C.Stressful;
			    else if gpss(i) = "D"  then cgpss(i)= 3;  *D.Very Stressful;	   
		  	end; 
		drop i;

	*Calculate globabl perceived stress scores;
		STS01TG = cSTSA1 + cSTSA2+ cSTSA3+ cSTSA4 + cSTSA5 + cSTSA6+ cSTSA7 + cSTSA8; 
		STS01AG = STS01TG/8 ;

	*labels and formats;
		label STS01TG = "total global stress score "
			  STS01AG = "average global stress score"
			;
		format STS01TG STS01AG 8.2 
			;
	run; 
 

*Major Life Events    ****************************************************************************;

	data MLE (keep=subjid sts01mle);
	set afu.af1 ;

	*Recode participant responses ;
		array mle(*)    af1v1 - af1v11;       
		array cmle(*)   caf1v1 - caf1v11;       
		  	do i = 1 to dim(mle);                 
			    if      mle(i) = "N"  then cmle(i)= 0;  *N:No;
			    else if mle(i) = "Y"  then cmle(i)= 1;  *Y:Yes ;
		  	end; 
		drop i;

	*calculate major life events;
		sts01mle  = caf1v1 + caf1v2+ caf1v3+ caf1v4 + caf1v5 + caf1v6+ caf1v7 + caf1v8 + caf1v9 + caf1v10 + caf1v11 ; 

	*labels and formats;
		label sts01mle = "major life events "
			;
		format sts01mle 8.2 
			;
	run; 

*Sort  ***************************************************;

proc sort data=wsi ; by subjid; run;
proc sort data=gpss ; by subjid; run;
proc sort data=mle ; by subjid; run;
