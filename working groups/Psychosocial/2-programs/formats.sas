
 *Scoring of the discrimination instrument;
proc format library= psychsoc;

	value yn	0='No' 
				1='Yes' ;

	value dis01ea	0="Non-racial" 
					1="Racial" ;

	value lifeRank	0="No experiences" 	
					1="1-2 experiences" 
					2="3+ experiences" ;

	value edu2a 1=" < high school " 
				2=" High school grauate " 
				3=" Some college " 
				4=" Bachelor's degree or higher " ;

	value agecat 1= "20-29 years"
				 2= "30-39 years"
				 3= "40-49 years"
				 4= "50-59 years"
				 5= "60-69 years"
				 6= "70-79 years"
				 7="80 and over" ;

   value dis01ecA 1="Emotion-focused"
			   	  2="Problem-focused" ;

   value dis01ecB	1="Passive coping"
   			  	 	2="Active coping"
			  	 	3="External coping" ;
run;
