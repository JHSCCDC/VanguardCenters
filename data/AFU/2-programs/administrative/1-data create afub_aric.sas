*Version K****************************************************************************************;
  %let ARICvers = k;
  %let JHSvers  = b;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = ARIC.AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID
  	  			  CONTYR
                  AFUK1
                  AFUK2
                  AFUK3
                  AFUK6
                         AFUK7A  AFUK7B  AFUK7C  AFUK7D  AFUK7E  AFUK7F  AFUK7G  AFUK7H  AFUK7I  AFUK7J  AFUK7K  AFUK7L  AFUK7M  AFUK7N
                         AFUK8A  AFUK8B
                  AFUK9
                  AFUK10
                         AFUK11A AFUK11B
                  AFUK12 AFUK12A AFUK12B
                         AFUK13A AFUK13B AFUK13C AFUK13D AFUK13E AFUK13F
                         AFUK14A AFUK14B
                         AFUK15A AFUK15B AFUK15C 
                         AFUK16A AFUK16B AFUK16C
                  AFUK17
                  AFUK18
                         AFUK19A AFUK19B AFUK19C AFUK19D
                  AFUK20
                  AFUK21 AFUK21A AFUK21B
                  AFUK22
                  AFUK23
                  AFUK24
                  AFUK25
                         AFUK26A AFUK26B
                         AFUK27A AFUK27B
                         AFUK28A AFUK28B
                         AFUK29A AFUK29B
                  AFUK30
                  AFUK31
                         AFUK32A AFUK32B AFUK32C AFUK32D;


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
                      8A  8B
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
  proc sort data = AFU&ARICvers; by subjid; run;

  data AFU&JHSvers._aric; retain subjid VERS; set AFU&ARICvers; by subjid; VERS = 'B'; run;
