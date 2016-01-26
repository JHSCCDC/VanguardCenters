*Version 1****************************************************************************************;
  %let ARICvers = 2;
  %let JHSvers  = e;

  /*Check;
  ods rtf file = "0-admin\3-results\AFU&ARICvers._jhs.rtf";
    proc contents data = AFU&ARICvers._JHS; run;
  ods rtf close;
  */

  *Keep all variables asked on questionnaire;
  %let keepVars = ID 
                  AFU0a
                  AFU1
                  AFU2
                  AFU6   AFU6a
                  AFU7
                  AFU10
                  AFU14
                  AFU15
                  AFU17
                  AFU18
                  AFU19
                  AFU20
                  AFU21a AFU21b AFU21c AFU21d AFU21e AFU21f
                  AFU22
                  AFU23
                  AFU24
                  AFU25
                  AFU26
                  AFU27  AFU27a
                  AFU28  AFU28a AFU28c6 AFU28d
                  AFU29  AFU29a
                  AFU30
                  AFU31
                  AFU33
                  AFU35
                  AFU36
                  AFU37
                  AFU40
                  AFU41
                  AFU42
                  AFU43
                  AFU45
                  AFU46
                  AFU48
                  AFU49
                  AFU51
                  AFU57
                  AFU58
                  AFU60
                  AFU61
                  AFU62
                  AFU63a AFU63b AFU63c AFU63d AFU63e AFU63f
                  AFU64  AFU64a AFU64b AFU64c AFU64d AFU64e AFU64f
                  AFU65  AFU65a AFU65b AFU65c AFU65d AFU65e AFU65f AFU65g AFU65h AFU65i AFU65j AFU65k AFU65l AFU65m
                  AFU66  AFU66a
                  AFU67
                  AFU68
                  AFU69
                  AFU70;

  *Re-build AFU dataset;
  data AFU&ARICvers; set AFU&ARICvers._JHS(keep = &keepVars);
    retain &keepVars; 
    rename ID = subjid;
    run;

  *Rename variables to use JHS version-specific prefixes;
  %let questions = 0a
                   1
                   2
                   6 6a
                   7
                   10
                   14
                   15
                   17
                   18
                   19
                   20
                   21a 21b 21c 21d 21e 21f
                   22
                   23
                   24
                   25
                   26
                   27 27a
                   28 28a 28c6 28d
                   29 29a
                   30
                   31
                   33
                   35
                   36
                   37
                   40
                   41
                   42
                   43
                   45
                   46
                   48
                   49
                   51
                   57
                   58
                   60
                   61
                   62
                   63a 63b 63c 63d 63e 63f
                   64 64a 64b 64c
                   65 65a 65b 65c 65d 65e 65f 65g 65h 65i 65j 65k 65l 65m
                   66 66a
                   67
                   68
                   69
                   70;

  %rename2();


*Compile finalized JHS-formatted AFU datasets*****************************************************;
  proc sort data = AFU&ARICvers; by subjid; run;

  data AFU&JHSvers._aric; retain subjid VERS; set AFU&ARICvers; by subjid; VERS = 'E'; run;
