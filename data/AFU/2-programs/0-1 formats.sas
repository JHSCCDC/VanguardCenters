proc format;

value $yn "Y"="Yes"
		  "N"="No"
		  "U"="Unknown"
		  "K"="Don't know"
		  "R"="Refused"
		  "A"="Not applicable"
		  "M"="Missing";

value yn 1="Yes"
		 2="No"
		 7="Don't know"
		 8="Refused"
		 9="Missing";

value oftenA 1="Almost never"
			 2="Seldom"
			 3="Sometimes"
			 4="Other"
			 5="Very often"
			 6="Constantly"
			 7="Don't know"
			 8="Refused"
			 9="Missing";

value oftenB 1="Never"
			 2="Sometimes"
			 3="Usually"
			 4="Always"
			 7="Don't know"
			 8="Refused"
			 9="Missing";

value $finalStatus "C"="Complete"
				   "I"="Incomplete";

value $alive "Y"="Yes"
			 "U"="Unknown";
	
value $cOptions "A"="Phone"
				"B"="Personal interview"
				"C"="Letter";

value $rOptions "D"="Relative, spouse, aquaintance"
				"E"="Employer information"
				"F"="Other";

value $dOptions "G"="Relative, spouse, aquaintance"
	   			"H"="Surveillance"
				"I"="Other (historical death index)";

value $maritalStatus "M"="Married"
					 "W"="Widowed"
					 "D"="Divorced"
					 "S"="Separated"
					 "N"="Never married";
	
value employmentStatus	1="Homemaking"
						2="Employed"
						3="Unemployed"
						4="Retired";

value employedStatus 1="Employed at job for pay, either full or part-time"
					 2="Employed, by temporarily away from work";

value unemployedStatus 1="Unemployed, looking for work"
					   2="Unemployed, not looking for work";

value retiredStatus 1="Retired from my usual occupation and not working"
					2="Retired from my usual occupation, but working for pay";

value $healthPerception	"E"="Excellent"
						"G"="Good"
						"F"="Fair"
						"P"="Poor";
	
value $cardiacProcCarotidSite "R"="Right"
							  "L"="Left"
							  "B"="Both";

value EchoECGstress 1="Routine physical"
					2="Heart failure / fluid on lungs"
					3="Follow up of heart problem (surgery / stent)"
					4="Heart murmur"
					5="Chest pain / discomfort"
					6="Heart rhythm disturbance"
					7="Other (specify)"
					77="Don't know"
					88="Refused"
					99="Missing";

value CTMRI 1="Forgetfulness / trouble thinking"
			2="Stroke"
			3="TIA or 'little' strokes"
			4="Other (specify)"
			7="Don't know"
			8="Refused"
			9="Missing";

value Cath 1="Emergency for a heart attack"
		   2="Emergency for a stroke"
		   3="Follow up after heart attack or surgery / stent"
		   4="Doctors suspected disease / blockage"
		   5="Chest pain / discomfort"
		   6="Leg pain with walking"
		   7="Other (specify)"
		   77="Don't know"
		   88="Refused"
		   99="Missing";

value healthcareDoctorNumber 1="None"
							 2="1"
							 3="2"
							 4="3"
							 5="4"
							 6="5 to 9"
							 7="10 or more"
							 77="Don't know"
							 88="Refused"
							 99="Missing";

value insuranceCoverageLapseTime 1="Less than 1 year"
								 2="1 to 2 years"
								 3="More than 3 years"
								 7="Don't know"
								 8="Refused"
		  						 9="Missing";

value costMedsAverage 1="Less than $20"
					  2="$20-$40"
					  3="$41-$75"
					  4="$76-$100"
					  5="$101-$250"
					  6="More than $250"
					  7="Don't know"
					  8="Refused"
					  9="Missing";

value costProblem 1="A big problem"
				  2="A small problem"
				  3="Not a problem"
				  7="Don't know"
				  8="Refused"
				  9="Missing";

value satisfactionQuality 1="Very satisfied"
						  2="Somewhat satisfied"
						  3="Somewhat dissatisfied"
						  4="Very dissatisfied"
						  5="Not sure"
						  7="Don't know"
						  8="Refused"
						  9="Missing";

value satisfactionConfident 1="Very confident"
							2="Somewhat confident"
							3="Not too confident"
							4="Not at all confident"
							7="Don't know"
							8="Refused"
						 	9="Missing";

value stressPastYear 1="None"
					 2="Very little"
					 3="Mild stress"
					 4="Moderate stress"
					 5="A lot of stress"
					 6="Extreme stress"
					 7="Don't know"
					 8="Refused"
					 9="Missing";

value stressCopePastYear 1="Very poorly"
						 2="Poorly"
						 3="Fair"
						 4="Pretty well"
						 5="Well"
						 6="Very well"
						 7="Don't know"
					 	 8="Refused"
					 	 9="Missing";

value supportPastYear 1="Very dissatisfied"
					  2="Somewhat satisfied"
					  3="A little dissatisfied"
					  4="A little satisfied"
					  5="Somewhat satisfied"
					  6="Very satisfied"
					  7="Don't know"
					  8="Refused"
					  9="Missing";

value relationship 1="Mother"
				   2="Father"
				   3="Sibling"
				   4="Child";

value COD 1="Cancer"
		  2="Heart attack"
		  3="Stroke"
		  4="Other (specify)"
		  7="Unknown";

value DX 1="High blood pressure"
		 2="Stroke"
		 3="Heart disease"
		 4="Diabetes"
		 5="Cancer"
		 7="Other (specify)";

* FOR AF;

		   *Overall****************************************************************************************;
  value $JH_CPV
    'C' = 'Computer'
    'P' = 'Paper'; 

  value $JH_YNV
    'N' = 'N. No'
    'Y' = 'Y. Yes';

  value $JH_YNKV
    'K' = 'K. Don''t Know'
    'N' = 'N. No'
    'R' = 'R. Refused'
    'Y' = 'Y. Yes';


  ************************************************************************************************;
  *AF1********************************************************************************************;
  ************************************************************************************************;

    *Version A************************************************************************************;
    value $AF1A13V
      'A' = 'A. Parents died'
      'B' = 'B. Parents divorced or separated'
      'C' = 'C. Other reason'
      'D' = 'D. Don''t know'
      'R' = 'R. Refused';

    value $AF1A14V
      'D' = 'Does not know'
      'N' = 'No'
      'T' = 'There was no father/male caretaker in household'
      'Y' = 'Yes';

    value $AF1A16V
      'D' = 'Does not know'
      'N' = 'No'
      'T' = 'There was no mother/female caretaker in household'
      'Y' = 'Yes';

    value $AF1A18V
      'B' = 'B. Own or buying'
      'O' = 'O. Some other living arrangement'
      'R' = 'R. Pay rent'
      'U' = 'U. Unsure';

    *Version B************************************************************************************;
    value $AF1B13V
      'A' = 'A.Parents died'
      'B' = 'B.Parents divorced or separated'
      'C' = 'C.Other reason'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF1B14V
      'K' = 'K.Don''t Know'
      'N' = 'N.No'
      'R' = 'R.Refused'
      'T' = 'T.There was no father/male caretaker in household'
      'Y' = 'Y.Yes';

    value $AF1B16V
      'K' = 'K.Don''t know'
      'N' = 'N.No'
      'R' = 'R.Refused'
      'T' = 'T.There was no mother/female caretaker in household'
      'Y' = 'Y.Yes';

    value $AF1B18V
      'B' = 'B.Own or buying'
      'O' = 'O.Some other living arrangement'
      'P' = 'P.Pay rent'
      'R' = 'R.Refused'
      'U' = 'U.Unsure';


  ************************************************************************************************;
  *AF2********************************************************************************************;
  ************************************************************************************************;

    *Version A************************************************************************************;
    value $AF2AR1V
      'A' = 'A. A lot like me'
      'B' = 'B. Somewhat like me'
      'C' = 'C. A little like me'
      'D' = 'D. Not at all like me';

    value $AF2A7V
      'A' = 'A. Homemaking'
      'B' = 'B. Employed'
      'C' = 'C. Unemployed'
      'D' = 'D. Retired';

    value $AF2A9V
      'A' = 'A. Satisfied'
      'B' = 'B. Dissatisfied'
      'C' = 'C. Neither';

    value $AF2A10V
      'A' = 'A. Actually laid off'
      'B' = 'B. Constantly faced with job loss or lay off'
      'C' = 'C. Faced this possibility more than once'
      'D' = 'D. Faced this possibility once'
      'E' = 'E. Never faced with job loss or lay off';

    value $AF2A11V
      'A' = 'A. Very likely'
      'B' = 'B. Somewhat likely'
      'C' = 'C. Not too likely'
      'D' = 'D. Not at all likely'
      'E' = 'E. You don''t care to keep your job';

    value $AF2A12V
      'A' = 'A. Very good'
      'B' = 'B. Good'
      'C' = 'C. Fair'
      'D' = 'D. Poor';

    value $AF2ARAV
      'A' = 'A. Strongly Agree'
      'B' = 'B. Somewhat Agree'
      'C' = 'C. Somewhat Disagree'
      'D' = 'D. Strongly Disagree';

    value $AF2A19V
      'A' = 'A. Top'
      'B' = 'B. Upper'
      'C' = 'C. Middle'
      'D' = 'D. Lower';

    value $AF2A21V
      'B' = 'B. Black'
      'O' = 'O. Another ethnicity or race'
      'W' = 'W. White';

    value $AF2A23V
      'A' = 'A. All Black'
      'B' = 'B. Mostly Black'
      'C' = 'C. About half Black and half White'
      'D' = 'D. Mostly White'
      'E' = 'E. All White'
      'F' = 'F. Other';

    *Version B************************************************************************************;
    value $AF2BR1V
      'A' = 'A.A lot like me'
      'B' = 'B.Somewhat like me'
      'C' = 'C.A little like me'
      'D' = 'D.Not at all like me'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B7V
      'A' = 'A.Homemaking'
      'B' = 'B.Employed'
      'C' = 'C.Unemployed'
      'D' = 'D.Retired'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B9V
      'A' = 'A.Satisfied'
      'B' = 'B.Dissatisfied'
      'C' = 'C.Neither'
      'K' = 'K.Don''t Know'
      'R' = 'R.Refused';

    value $AF2B10V
      'A' = 'A.Actually laid off'
      'B' = 'B.Constantly faces with job loss or lay off'
      'C' = 'C.Faced this possibility more than once'
      'D' = 'D.Faced this possibility once'
      'E' = 'E.Never faced with job loss or lay off'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B11V
      'A' = 'A.Very likely'
      'B' = 'B.Somewhat likely'
      'C' = 'C.Not too likely'
      'D' = 'D.Not at all likely'
      'E' = 'E.You don''t care to keep your job'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B12V
      'A' = 'A.Very good'
      'B' = 'B.Good'
      'C' = 'C.Fair'
      'D' = 'D.Poor'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2BR2V
      'A' = 'A.Strongly Agree'
      'B' = 'B.Somewhat agree'
      'C' = 'C.Somewhat disagree'
      'D' = 'D.Strongly disagree'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B19V
      'A' = 'A.Top'
      'B' = 'B.Upper'
      'C' = 'C.Middle'
      'D' = 'D.Lower'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF2B21V
      'B' = 'B.Black'
      'K' = "K.Don't know"
      'O' = 'O.Another ethnicity or race'
      'R' = 'R.Refused'
      'W' = 'W.White';

    value $AF2B23V
      'A' = 'A.All Black'
      'B' = 'B.Mostly Black'
      'C' = 'C.About half black and half white'
      'D' = 'D.Mostly White'
      'E' = 'E.All White'
      'F' = 'F.Other'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';


  ************************************************************************************************;
  *AF3********************************************************************************************;
  ************************************************************************************************;

    *Version A************************************************************************************;
    value $AF3AR1V
      'A' = 'A. Completely True'
      'B' = 'B. Somewhat True'
      'C' = 'C. Somewhat False'
      'D' = 'D. Completely False';

    value $AF3ARAV
      'A' = 'A. Strongly Agree'
      'B' = 'B. Agree'
      'C' = 'C. Disagree'
      'D' = 'D. Strongly Disagree';

    value $AF3ARBV
      'D' = 'D. Don''t Know'
      'N' = 'N. Never'
      'O' = 'O. Often'
      'R' = 'R. Rarely'
      'S' = 'S. Sometimes';

    value $AF3ARCV
      'M' = 'M. Minor Problem'
      'N' = 'N. Not Really a Problem'
      'S' = 'S. Somewhat Serious Problem'
      'V' = 'V. Very Serious Problem';

    *Version B************************************************************************************;
    value $AF3BR1V
      'A' = 'A.Completely True'
      'B' = 'B.Somewhat true'
      'C' = 'C.Somewhat False'
      'D' = 'D.Completely false'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF3BR2V
      'A' = 'A.Strongly Agree'
      'B' = 'B.Agree'
      'C' = 'C.Disagree'
      'D' = 'D.Strongly Disagree'
      'K' = 'K.Don''t know'
      'R' = 'R.Refused';

    value $AF3BR3V
      'K' = 'K.Don''t know'
      'L' = 'L.Rarely'
      'N' = 'N.Never'
      'O' = 'O.Often'
      'R' = 'R.Refused'
      'S' = 'S.Sometimes';

    value $AF3BR4V
      'K' = 'K.Don''t Know'
      'M' = 'M.Minor Problem'
      'N' = 'N.Not Really a Problem'
      'R' = 'R.Refused'
      'S' = 'S.Somewhat Serious Problem'
      'V' = 'V.Very Serious Problem';

run;
