*Version I****************************************************************************************;
  %let ARICvers = i;
  %let JHSvers  = a;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = ARIC.AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID 
  				  CONTYR
                  AFUI1  
                  AFUI2  
                  AFUI3  
                  AFUI6
                         AFUI7A  AFUI7B  AFUI7C  AFUI7D  AFUI7E  AFUI7F  AFUI7G  AFUI7H  AFUI7I  AFUI7J  AFUI7K  AFUI7L  AFUI7M  AFUI7N
                  AFUI8  
                  AFUI9  
                  AFUI10 
                         AFUI11A AFUI11B
                  AFUI12 AFUI12A AFUI12B 
                         AFUI13A AFUI13B AFUI13C AFUI13D AFUI13E AFUI13F 
                         AFUI14A AFUI14B 
                         AFUI15A AFUI15B AFUI15C 
                         AFUI16A AFUI16B AFUI16C
                  AFUI17
                  AFUI18 
                         AFUI19A AFUI19B AFUI19C AFUI19D
                  AFUI20 
                  AFUI21 AFUI21A AFUI21B
                  AFUI22 
                  AFUI23
                  AFUI24 
                  AFUI25 
                         AFUI26A AFUI26B 
                         AFUI27A AFUI27B
                         AFUI28A AFUI28B
                         AFUI29A AFUI29B
                  AFUI30 
                  AFUI31 
                         AFUI32A AFUI32B AFUI32C AFUI32D;

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
                      7A  7B  7C  7D  7E  7F  7G  7H  7I  7J  7K  7L  7M  7N
                   8 
                   9  
                   10 
                      11A 11B
                   12 12A 12B 
                      13A 13B 13C 13D 13E 13F 
                      14A 14B 
                      15A 15B 15C 
                      16A 16B 16C
                   17
                   18 
                      19A 19B 19C 19D
                   20 
                   21 21A 21B
                   22 
                   23
                   24 
                   25 
                      26A 26B 
                      27A 27B
                      28A 28B
                      29A 29B
                   30 
                   31 
                      32A 32B 32C 32D;    

  %rename();


*Version J****************************************************************************************;
  %let ARICvers = j;
  %let JHSvers  = a;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = ARIC.AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID 
  				  CONTYR
                  AFUJ1  
                  AFUJ2  
                  AFUJ3  
                  AFUJ6
                         AFUJ7A  AFUJ7B  AFUJ7C  AFUJ7D  AFUJ7E  AFUJ7F  AFUJ7G  AFUJ7H  AFUJ7I  AFUJ7J  AFUJ7K  AFUJ7L  AFUJ7M  AFUJ7N
                  AFUJ8  
                  AFUJ9  
                  AFUJ10 
                         AFUJ11A AFUJ11B
                  AFUJ12 AFUJ12A AFUJ12B 
                         AFUJ13A AFUJ13B AFUJ13C AFUJ13D AFUJ13E AFUJ13F 
                         AFUJ14A AFUJ14B 
                         AFUJ15A AFUJ15B AFUJ15C 
                         AFUJ16A AFUJ16B AFUJ16C
                  AFUJ17
                  AFUJ18 
                         AFUJ19A AFUJ19B AFUJ19C AFUJ19D
                  AFUJ20 
                  AFUJ21 AFUJ21A AFUJ21B
                  AFUJ22 
                  AFUJ23
                  AFUJ24 
                  AFUJ25 
                         AFUJ26A AFUJ26B 
                         AFUJ27A AFUJ27B
                         AFUJ28A AFUJ28B
                         AFUJ29A AFUJ29B
                  AFUJ30 
                  AFUJ31 
                         AFUJ32A AFUJ32B AFUJ32C AFUJ32D;

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
                      7A  7B  7C  7D  7E  7F  7G  7H  7I  7J  7K  7L  7M  7N
                   8 
                   9  
                   10 
                      11A 11B
                   12 12A 12B 
                      13A 13B 13C 13D 13E 13F 
                      14A 14B 
                      15A 15B 15C 
                      16A 16B 16C
                   17
                   18 
                      19A 19B 19C 19D
                   20 
                   21 21A 21B
                   22 
                   23
                   24 
                   25 
                      26A 26B 
                      27A 27B
                      28A 28B
                      29A 29B
                   30 
                   31 
                      32A 32B 32C 32D;    

  %rename();


*Compile finalized JHS-formatted AFU datasets*****************************************************;
  proc sort data = AFUi; by subjid; run;
  proc sort data = AFUj; by subjid; run;

  data AFU&jhsVers._aric; retain subjid VERS; set AFUi AFUj; by subjid; VERS = 'A'; run;
