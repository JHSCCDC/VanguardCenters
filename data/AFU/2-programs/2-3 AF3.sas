*Version A****************************************************************************************;
data AF3a;
	set AF.AF3a;

	*Set values to missing;
	array setthree{5} AF3a19-AF3a23;

	do i = 1 to 5;
		if setthree{i} in ('D') then setthree{i} = " ";
	  end;

	drop i;

	rename AF3a1-AF3a32 = AF3v1-AF3v32;
	run;

*Version B****************************************************************************************;
data AF3b;
	set AF.AF3b;

	format AF3b1-AF3b12  AF3br1v.
		   AF3b13-AF3b18 AF3br2v.
		   AF3b19-AF3b23 AF3br3v.
		   AF3b24-AF3b29 AF3br4v. 
		   AF3b31        JH_CPV.;

	*Set values to missing;
	array setfour{29} AF3b1-AF3b18 AF3b19-AF3b23 AF3b24-AF3b29 ;
	
	do i=1 to dim(setfour);
		if setfour{i} in: ('K','R') then setfour{i}= " ";
  	end;

	drop i;

	rename AF3b1-AF3b32 = AF3v1-AF3v32;
  run;

*Use proc sort by id first-for both*;
proc sort data = AF3a; by subjid; run;
proc sort data = AF3b; by subjid; run;

*Create complete AFU datasets*********************************************************************;
data AF3;
	set AF3a AF3b;
	by subjid;
	if first.subjid;

	*Reset v19-v23 to form A format where R=Rarely;
  array setfive {5} AF3v19-AF3v23;

  do i=1 to dim(setfive);
 		if setfive{i}='L' then setfive{i}='R'; 
  	end; 

  drop i;
	run;

proc sort data = AF3; by subjid; run;

data out.af3;
set af3;
run;

  /*Check;
  	proc contents data = AF3;          run;
  	proc print    data = AF3(obs = 5); run;
  */

  /*Duplicate ID check;
    proc freq data = AF3 noprint;
      table subjID /out = AF3_Dub(keep = subjID count where = (count > 1)) ;
      run;

    proc print data = AF3_Dub; run;
  */
