
**************************************************************************************************;
** Program/project: JHS Physical Activity Index Scoring;
**************************************************************************************************;
 
  *Primary VC data archetypes;
  libname analysis "data\Analysis Data\1-data";                   *Analysis-Ready Datasets; 
  libname lss      "data\Supplementary\SSN0003-LS7\1-data";       *Life's Simple 7 working group data;
  libname jhsV1    "data\Visit 1\1-data";                         *"Raw" Exam 1 data; 
  libname jhsV3    "data\Visit 3\1-data";                         *"Raw" Exam 3 data; 
  libname ssn0007  "data\Supplementary\SSN0007-Physical Activity\1-data"; *Datasets from supplementary project 0006 - Nutrition;

  *Set programs directory(s);
  filename pgmsV1  "data\Visit 1\2-programs"; 
  filename pgmsV2  "data\Visit 2\2-programs"; 
  filename pgmsV3  "data\Visit 3\2-programs"; 
  filename ADpgms  "data\Analysis Data\2-programs"; 
  filename PApgms  "working groups\Physical Activity\2-programs";

  *Read in format statements;
  options nonotes;
    %include ADpgms("0-1-formats.sas"); *Read in Analysis Datasets format statements;
    %include pgmsV1("0-1-formats.sas"); *Read in formats from the JHS visit 1 catalogue;
    %include pgmsV2("0-1-formats.sas"); *Read in formats from the JHS visit 2 catalogue;
    %include pgmsV3("0-1-formats.sas"); *Read in formats from the JHS visit 3 catalogue;
  options notes;

 options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats);
 options nofmterr;
*****************************************************************************************************

*Include program for  active living index (acl01);
  %include PApgms("1-ACLIndex.sas") ;
*Include program for  home and yard index (HFY01);
  %include PApgms("2-HYFIndex.sas") ;
*Include program for work index;
  %include PApgms("3-WrkIndx.sas") ;
*Include program for sport index calculation;
  %include PApgms("4-SPTIndex.sas") ;

*Create JPAC PA index dataset;
  data ssn0007.derivedPA (label="Derived Physical Activity Domain Measures");
  retain subjid  acl01 hfy01 spt01 wrk01a employed totpa4 totpa3 ;

      merge   ssn0007.acl 
          ssn0007.hfy 
          ssn0007.work (rename=(pa8=employed))
          ssn0007.sport ;
      by subjid;

    *Sum activity domains for total physical activity score. Must have all domains;
      TotPA4= acl01 + hfy01 + spt01 + wrk01a ; /*original total physical activity measure; complete cases only*/
      TotPA3= acl01 + hfy01 + spt01  ;     /*complete cases only*/

    label totpa4    = "4-index Total PA "
        totpa3    = "3-index Total PA " ;

    format acl01 hfy01 spt01 wrk01a totpa4 totpa3 8.2;
    format employed YNFMT. ;

    keep subjid employed acl01 hfy01 spt01 wrk01a totpa4 totpa3;
  run;

