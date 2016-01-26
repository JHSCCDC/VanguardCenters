*Version A****************************************************************************************;
data AF2a;
	set AF.AF2a;

	format AF2a1-AF2a6   	   								AF2aR1V.
				 AF2a7        								AF2a7V. 
				 AF2a8 AF2a18 AF2a19a AF2a19b AF2a20 AF2a22 JH_YNV.
				 AF2a9         								AF2a9V.
				 AF2a10        								AF2a10V. 
				 AF2a11        								AF2a11V.
				 AF2a12        								AF2a12V. 
				 AF2a13-AF2a17 								AF2aRaV.
				 AF2a19c       								AF2a19V.
				 AF2a21        								AF2a21V.
				 AF2a23        								AF2a23V.
				 AF2a25        								JH_CPV.;

	rename AF2a1-AF2a18  = AF2v1-AF2v18 
      	   AF2a19a       = AF2v19a 
           AF2a19b       = AF2v19b 
           AF2a19c       = AF2v19c 
      	   AF2a20-AF2a26 = AF2v20-AF2v26;	
  run;

*Version B****************************************************************************************;
data AF2b;
	set AF.AF2b;
  format AF2b1-AF2b6   											 AF2bR1V.
  			 AF2b7         										 AF2b7V. 
  			 AF2b9         										 AF2b9V.
  			 AF2b10        										 AF2b10V. 
  			 AF2b11        										 AF2b11V.
  			 AF2b12        										 AF2b12V. 
  			 AF2b13-AF2b17 										 AF2bR2V.
  			 AF2b8 AF2b18 AF2b19a  AF2b19b AF2b19c AF2b20 AF2b22 JH_YNKV.
  			 AF2b21        										 AF2b21V.
  			 AF2b23        										 AF2b23V.
  			 AF2b25        										 JH_CPV.;

	*Set values to missing;
	array setone{25} AF2b1-AF2b18 AF2b19a AF2b19b AF2b19c AF2b20-AF2b23;

	do i = 1 to 25;
		if setone{i} in ('K','R') then setone{i} = " ";
	  end;

	drop i;
	
  *Rename Version B variables for main dataset;
	rename AF2b1-AF2b18  = AF2v1-AF2v18 
      	   AF2b19a       = AF2v19a 
           AF2b19b       = AF2v19b 
           AF2b19c       = AF2v19c 
      	   AF2b20-AF2b26 = AF2v20-AF2v26;	
	run;

proc sort data = AF2a; by subjid; run;
proc sort data = AF2b; by subjid; run;

*Create complete AFU datasets*********************************************************************;
data AF2;
	set AF2a AF2b;
	by subjid;
	if first.subjid;
	run;

proc sort data = AF2; by subjid; run;

data out.af2;
set af2;
run;

  /*Check;
  	proc contents data = AF2;          run;
  	proc print    data = AF2(obs = 5); run;
  */

  /*Duplicate ID check;
    proc freq data = AF2 noprint;
      table subjID /out = AF2_Dub(keep = subjID count where = (count > 1)) ;
      run;

    proc print data = AF2_Dub; run;
  */
