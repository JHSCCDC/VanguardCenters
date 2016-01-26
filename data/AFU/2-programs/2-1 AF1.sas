*Version A****************************************************************************************;
data AF1a; set AF.AF1a;

  format  AF1a1-AF1a12  AF1a15b AF1a17b AF1a19a AF1a19b AF1a20a AF1a20b AF1a20c AF1a20d AF1a20e JH_YNV. 
		  AF1a13a AF1a13v. 
          AF1a14a AF1a14v. 
          AF1a16a AF1a16v. 
          AF1a18  AF1a18v.  
          AF1a23  JH_CPV.;

	if AF1a18 = 'R' then AF1a18 = 'P';
	if AF1a18 = 'U' then AF1a18 = " ";

	rename AF1a1-AF1a12  = AF1v1-AF1v12 
     	   AF1a13a       = AF1v13a 
           AF1a13b       = AF1v13b 
      	   AF1a14a       = AF1v14a 
           AF1a14b       = AF1v14b 
      	   AF1a14c       = AF1v14c 
           AF1a14d       = AF1v14d 
      	   AF1a15a       = AF1v15a 
           AF1a15b       = AF1v15b 
      	   AF1a16a       = AF1v16a 
           AF1a16b       = AF1v16b 
      	   AF1a16c       = AF1v16c  
           AF1a16d       = AF1v16d 
      	   AF1a17a       = AF1v17a  
           AF1a17b       = AF1v17b 
      	   AF1a18        = AF1v18 
           AF1a19a       = AF1v19a 
      	   AF1a19b       = AF1v19b 
           AF1a19c       = AF1v19c 
      	   AF1a20a       = AF1v20a 
           AF1a20b       = AF1v20b 
      	   AF1a20c       = AF1v20c 
           AF1a20d       = AF1v20d 
      	   AF1a20e       = AF1v20e 
           AF1a21-AF1a24 = AF1v21-AF1v24;
  run;

*Version B****************************************************************************************;
data AF1b; set AF.AF1b;

  *Set any none YES/NO values to missing;
	array firstsetc{24} AF1b1-AF1b12 AF1b13A AF1b14A AF1b15B AF1b16A AF1b17B AF1b19A AF1b19B AF1b20A AF1b20B AF1b20C AF1b20D AF1b20E;
  do i = 1 to 24;
	  if firstsetc{i} in: ('D','K','R') then firstsetc{i}= " ";
		end;

	if AF1b18 in ('U' 'R') then AF1b18 = " ";

	drop i;

	*Format responses;
	format AF1b1-AF1b12  AF1b15b AF1b17b AF1b19a AF1b19b AF1b20a AF1b20b AF1b20c AF1b20d AF1b20e JH_YNKV. 
		   AF1b13a AF1a13v.
           AF1b14a AF1b14v. 
           AF1b16a AF1b16v. 
           AF1b18  AF1b18v. 
           AF1b23  JH_CPV.;

	*Rename Version B variables;
	rename AF1b1-AF1b12  = AF1v1-AF1v12
      	   AF1b13a       = AF1v13a 
           AF1b13b       = AF1v13b 
      	   AF1b14a       = AF1v14a 
           AF1b14b       = AF1v14b 
           AF1b14c       = AF1v14c 
           AF1b14d       = AF1v14d 
      	   AF1b15a       = AF1v15a 
           AF1b15b       = AF1v15b 
      	   AF1b16a       = AF1v16a  
           AF1b16b       = AF1v16b 
           AF1b16c       = AF1v16c 
           AF1b16d       = AF1v16d 
      	   AF1b17a       = AF1v17a 
           AF1b17b       = AF1v17b 
      	   AF1b18        = AF1v18 
      	   AF1b19a       = AF1v19a  
           AF1b19b       = AF1v19b 
           AF1b19c       = AF1v19c 
      	   AF1b20a       = AF1v20a 
           AF1b20b       = AF1v20b 
           AF1b20c       = AF1v20c 
           AF1b20d       = AF1v20d 
           AF1b20e       = AF1v20e 
      	   AF1b21-AF1b24 = AF1v21-AF1v24; 
  run;

proc sort data = AF1a; by subjid; run;
proc sort data = AF1b; by subjid; run;

*Create complete AFU datasets*********************************************************************;
data AF1;
	set AF1a AF1b;
	by subjid;
	if first.subjid;
	format AF1v18 AF1b18v.;
	run;

proc sort data = AF1; by subjid; run;

data out.af1;
set af1;
run;

  /*Check;
  	proc contents data = AF1;          run;
  	proc print    data = AF1(obs = 5); run;
  */

  /*Duplicate ID check;
    proc freq data = AF1 noprint;
      table subjID /out = AF1_Dub(keep = subjID count where = (count > 1)) ;
      run;

    proc print data = AF1_Dub; run;
  */
