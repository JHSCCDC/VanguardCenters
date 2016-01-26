*Version L****************************************************************************************;
  %let ARICvers = l;
  %let JHSvers  = c;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = ARIC.AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID
  				  CONTYR
                  AFUL1
                  AFUL2
                  AFUL3
                  AFUL6
                  AFUL7A  AFUL7B
                  AFUL8   AFUL8C  AFUL8D  AFUL8E  AFUL8F  AFUL8G
                  AFUL9   AFUL9C  AFUL9D  AFUL9E  AFUL9F
                  AFUL10  AFUL10C AFUL10D AFUL10E AFUL10F
                  AFUL11A AFUL11B AFUL11C
                  AFUL12
                  AFUL13A AFUL13B
                  AFUL14
                  AFUL15
                  AFUL16  AFUL16C AFUL16D 
                  AFUL17A AFUL17B 
                  AFUL18A AFUL18B
                  AFUL19A AFUL19B AFUL19C AFUL19D AFUL19E AFUL19F AFUL19G
                  AFUL20  AFUL20A AFUL20B AFUL20C 
                  AFUL21A AFUL21B AFUL21C
                  AFUL22A AFUL22B
                  AFUL23
                  AFUL24
                  AFUL25A AFUL25B 
                  AFUL26C
                  AFUL27A AFUL27B 
                  AFUL40
                  AFUL41A AFUL41B 
                  AFUL42A AFUL42B AFUL42C AFUL42D AFUL42E AFUL42F
                  AFUL44A AFUL44B 
                  AFUL45A AFUL45B AFUL45C
                  AFUL46A AFUL46B AFUL46C AFUL46D
                  AFUL47
                  AFUL48A AFUL48A1 
                  AFUL48B AFUL48B1 
                  AFUL48C AFUL48C1 
                  AFUL48D AFUL48D1 
                  AFUL48E AFUL48E1 
                  AFUL48F AFUL48F1 
                  AFUL48G AFUL48G1 
                  AFUL48H AFUL48H1 
                  AFUL48I AFUL48I1 
                  AFUL48J AFUL48J1 
                  AFUL48K AFUL48K1 
                  AFUL48L AFUL48L1 
                  AFUL48M AFUL48M1 
                  AFUL48N AFUL48N1 
                  AFUL48O AFUL48O1 
                  AFUL48P AFUL48P1 
                  AFUL48Q AFUL48Q1 
                  AFUL48R AFUL48R1 
                  AFUL48S AFUL48S1 
                  AFUL48T AFUL48T1
                  AFUL49
                  AFUL50
                  AFUL51;

  *Re-build AFU dataset;
  data AFU&ARICvers; set ARIC.AFU&ARICvers._JHS(keep = &keepVars);
    retain &keepVars; 
    rename ID = subjid
		   CONTYR = visit;
    run;

  *Rename variables to use JHS version-specific prefixes;
  %let questions = 1
                   2
                   3
                   6
                   7A  7B
                   8   8C  8D  8E  8F  8G
                   9   9C  9D  9E  9F
                   10  10C 10D 10E 10F
                   11A 11B 11C
                   12
                   13A 13B
                   14
                   15
                   16  16C 16D 
                   17A 17B 
                   18A 18B
                   19A 19B 19C 19D 19E 19F 19G
                   20  20A 20B 20C 
                   21A 21B 21C
                   22A 22B
                   23
                   24
                   25A 25B 
                   26C
                   27A 27B 
                   40
                   41A 41B 
                   42A 42B 42C 42D 42E 42F
                   44A 44B 
                   45A 45B 45C
                   46A 46B 46C 46D
                   47
                   48A 48A1 
                   48B 48B1 
                   48C 48C1 
                   48D 48D1 
                   48E 48E1 
                   48F 48F1 
                   48G 48G1 
                   48H 48H1 
                   48I 48I1 
                   48J 48J1 
                   48K 48K1 
                   48L 48L1 
                   48M 48M1 
                   48N 48N1 
                   48O 48O1 
                   48P 48P1 
                   48Q 48Q1 
                   48R 48R1 
                   48S 48S1 
                   48T 48T1
                   49
                   50
                   51;

  %rename();



*Version M****************************************************************************************;
  %let ARICvers = m;
  %let JHSvers  = c;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = ARIC.AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID
  			  	      CONTYR
                  AFUM1
                  AFUM2
                  AFUM3
                  AFUM6
                  AFUM7A  AFUM7B
                  AFUM8   AFUM8C  AFUM8D  AFUM8E  AFUM8F  AFUM8G
                  AFUM9   AFUM9C  AFUM9D  AFUM9E  AFUM9F
                  AFUM10  AFUM10C AFUM10E AFUM10F
                  AFUM11A AFUM11C
                  AFUM12
                  AFUM13A AFUM13B
                  AFUM14
                  AFUM15
                  AFUM16  AFUM16C AFUM16D 
                  AFUM17A AFUM17B 
                  AFUM18B
                  AFUM19A AFUM19B AFUM19C AFUM19D AFUM19E AFUM19F AFUM19G
                  AFUM20A AFUM20B AFUM20C 
                  AFUM21A AFUM21B AFUM21C
                  AFUM22A AFUM22B
                  AFUM23
                  AFUM24
                  AFUM25A AFUM25B 
                  AFUM26C
                  AFUM27A AFUM27B 
                  AFUM40
                  AFUM41A AFUM41B 
                  AFUM42A AFUM42B AFUM42C AFUM42D AFUM42E AFUM42F
                  AFUM44A AFUM44B 
                  AFUM45A AFUM45B AFUM45C
                  AFUM46A AFUM46B AFUM46C AFUM46D
                  AFUM47
                  AFUM48A AFUM48A1 
                  AFUM48B AFUM48B1 
                  AFUM48C AFUM48C1 
                  AFUM48D AFUM48D1 
                  AFUM48E AFUM48E1 
                  AFUM48F AFUM48F1 
                  AFUM48G AFUM48G1 
                  AFUM48H AFUM48H1 
                  AFUM48I AFUM48I1 
                  AFUM48J AFUM48J1 
                  AFUM48K AFUM48K1 
                  AFUM48L AFUM48L1 
                  AFUM48M AFUM48M1 
                  AFUM48N AFUM48N1 
                  AFUM48O AFUM48O1 
                  AFUM48P AFUM48P1 
                  AFUM48Q AFUM48Q1 
                  AFUM48R AFUM48R1 
                  AFUM48S AFUM48S1 
                  AFUM48T AFUM48T1
                  AFUM49
                  AFUM50
                  AFUM51;
                  
  *Re-build AFU dataset;
  data AFU&ARICvers; set ARIC.AFU&ARICvers._JHS(keep = &keepVars);
    retain &keepVars; 
    rename ID = subjid
		   CONTYR = visit;
    run;

  *Rename variables to use JHS version-specific prefixes;
  %let questions = 1
                   2
                   3
                   6
                   7A  7B
                   8   8C  8D  8E  8F  8G
                   9   9C  9D  9E  9F
                   10  10C 10E 10F
                   11A 11C
                   12
                   13A 13B
                   14
                   15
                   16  16C 16D 
                   17A 17B 
                   18B
                   19A 19B 19C 19D 19E 19F 19G
                   20A 20B 20C 
                   21A 21B 21C
                   22A 22B
                   23
                   24
                   25A 25B 
                   26C
                   27A 27B 
                   40
                   41A 41B 
                   42A 42B 42C 42D 42E 42F
                   44A 44B 
                   45A 45B 45C
                   46A 46B 46C 46D
                   47
                   48A 48A1 
                   48B 48B1 
                   48C 48C1 
                   48D 48D1 
                   48E 48E1 
                   48F 48F1 
                   48G 48G1 
                   48H 48H1 
                   48I 48I1 
                   48J 48J1 
                   48K 48K1 
                   48L 48L1 
                   48M 48M1 
                   48N 48N1 
                   48O 48O1 
                   48P 48P1 
                   48Q 48Q1 
                   48R 48R1 
                   48S 48S1 
                   48T 48T1
                   49
                   50
                   51;

  %rename();



*Compile finalized JHS-formatted AFU datasets*****************************************************;
  proc sort data = AFUl; by subjid; run;
  proc sort data = AFUm; by subjid; run;

  data AFU&jhsVers._aric; retain subjid VERS; set AFUl AFUm; by subjid; VERS = 'C'; run;
