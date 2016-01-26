/**$START$*********************************************************************************************************/
/*                                       J A C K S O N  H E A R T  S T U D Y                                      */
/*                                      C O O R D I N A T I N G   C E N T E R                                     */
/* ---------------------------------------------------------------------------------------------------------------*/
/*      REQUEST:  JHWR00                                                                                          */
/*        TITLE:  JHS Recruitment Report                                                                          */
/*                                                                                                                */
/*  DESCRIPTION:  Sandra Williams-Dunn -- Coping and BP measures                                                                    */
/*                                                                                                                */
/*    REQUESTOR:  S. W@illiams-Dunn                                                                                */
/*                                                                                                                */
/*      PROGRAM:  jhwr0001.sas                                                                                    */
/*    DIRECTORY:                                                                                                  */
/*   PROGRAMMER:  Sarpong                                                             */
/* DATE CREATED:  05/24/2010                             MODIFIED:  11/14/2011                                    */
/* ---------------------------------------------------------------------------------------------------------------*/
/*   JOB NUMBER:  JHWR0001                                                                                        */
/*      PURPOSE:                                                                                                  */
/*     LANGUAGE:  SAS V9.2                                                                                          */
/*                                                                                                                */
/*      HISTORY:                                                                                                  */
/*      RELATED:                                                                                                  */
/*  --------------------------------------------------------------------------------------------------------------*/
/*        INPUT:  S:\jhsdata\v1\weekly\*.*                                                                        */
/*                                                                                                                */
/*       OUTPUT:  tables and listings                                                                             */
/*                                                                                                                */
/* Copyright © 2001, Jackson Heart Study, Jackson State University, Research and Stategic Initiatives             */
/* All Rights Reserved.                                                                                           */
/**$STOP$**********************************************************************************************************/
%let program = jhwr0001.sas ;
%let inits = DFS ;
%let request = jhWR00 ;

x "cd C:\...\VanguardCenters\example projects\Williams 2010 - Coping and Blood Pressure\";

libname data "1-data" ;

TITLE1 ;

x "cd 3-results";

options nofmterr;

proc sort data=data.jh125901 out=jh125901;
by subjid;
run;

*************** Analysis 9-27-2011  **************;
proc means data=jh125901 n mean std;
var age01 bmi01 pat01;
run;

ODS RTF File='EDTable1.rtf';
proc ttest data=jh125901;
class gender;
var age01 bmi01 pat01;
run; 

proc freq data=jh125901;
tables gender*(age01g1 bmi01g1 edu01l3 inc01 alc01 smk01)/chisq;
run;
ods RTF close;

ODS RTF File='EDTable2.rtf';
proc means data=jh125901 mean std;
var sbpa19 sbpa20 pfd01 pfe01 efd01 efe01 totdengf totengf ;
run; 

proc ttest data=jh125901;
class gender;
var sbpa19 sbpa20 pfd01 pfe01 efd01 efe01 totdengf totengf ;
run; 

proc freq data=jh125901;
tables gender*bp701/chisq;
run;

proc freq data=jh125901;
tables gender*htn017/chisq;
where (bpm01=1) ;
run;

proc freq data=jh125901;
tables gender*htn017/chisq;
where (bpm01=0) ;
run;

proc freq data=jh125901;
tables gender*htn017/chisq;
run;
ods RTF close;

proc freq data=jh125901;
tables bpm01*htn017;
run;

ODS RTF File='d:\SWilliams-Dunn\Table2.rtf';
proc glm data=jh125901;
class gender;
model totengf totdengf pfe01 pfd01 efe01 efd01=age01 gender;
lsmeans gender/stderr;
run;

proc glm data=jh125901;
class gender;
model totengf totdengf pfe01 pfd01 efe01 efd01=age01 alc01 gender ;
lsmeans gender/stderr;
run;

proc glm data=jh125901;
class gender;
model totengf totdengf pfe01 pfd01 efe01 efd01=age01 pat01 gender ;
lsmeans gender/stderr;
run;

proc glm data=jh125901;
class gender;
model totengf totdengf pfe01 pfd01 efe01 efd01=age01 smk01 pat01 alc01 gender ;
lsmeans gender/stderr;
run;
ODS RTF close;

ODS RTF File='Table2a.rtf';
proc glm data=data.jh125901;
class gender;
model totengf totdengf pfe01 pfd01 efe01 efd01=age01 smk01 gender ;
lsmeans gender/stderr;
run;
ODS RTF close;

ODS RTF File='EDTable3.rtf';
proc sort data=jh125901;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=bmi01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=edu01l3;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=inc01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=smk01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=alc01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=pat01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=htn017;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=bpm01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=pfe01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=pfd01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=efe01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=efd01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=totengf;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=totdengf;
by gender;
run;
ODS RTF close;

ODS RTF File='EDTable3a.rtf';
proc sort data=jh125901;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01/ dist=poisson link=log;
estimate 'RR age' age01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=bmi01/ dist=poisson link=log;
estimate 'RR BMI' bmi01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=edu01l3/ dist=poisson link=log;
estimate 'RR edu01l3' edu01l3 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=inc01/ dist=poisson link=log;
estimate 'RR inc01' inc01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=smk01/ dist=poisson link=log;
estimate 'RR smoke' smk01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=alc01/ dist=poisson link=log;
estimate 'RR alc01' alc01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=pat01/ dist=poisson link=log;
estimate 'RR pat01' pat01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=bpm01/ dist=poisson link=log;
estimate 'RR bpm01' bpm01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=pfe01/ dist=poisson link=log;
estimate 'RR pfe01' pfe01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=pfd01/ dist=poisson link=log;
estimate 'RR pfd01' pfd01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=efe01/ dist=poisson link=log;
estimate 'RR efe' efe01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=efd01/ dist=poisson link=log;
estimate 'RR efd' efd01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=totengf/ dist=poisson link=log;
estimate 'RR total eng' totengf 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=totdengf/ dist=poisson link=log;
estimate 'RR total diseng' totdengf 1/exp;
by gender;
run;
ODS RTF close;

ODS RTF File='EDTable4.rtf';
proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 pfe01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 pfd01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 efe01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 efd01;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 totengf;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 totdengf;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 totengf totdengf;
by gender;
run;

proc reg data=jh125901;
model sbpa19 sbpa20=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 htn017 bpm01 pfe01 pfd01 efe01 efd01;
by gender;
run;
ODS RTF close;

ODS RTF File='EDTable5.rtf';
proc sort data=jh125901;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 pfe01/ dist=poisson link=log;
estimate 'RR pfe01' pfe01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 pfd01/ dist=poisson link=log;
estimate 'RR pfd01' pfd01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 efe01/ dist=poisson link=log;
estimate 'RR efe' efe01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 efd01/ dist=poisson link=log;
estimate 'RR efd' efd01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 totengf/ dist=poisson link=log;
estimate 'RR total eng' totengf 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 totdengf/ dist=poisson link=log;
estimate 'RR total diseng' totdengf 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 pfe01 pfd01 efe01 efd01/ 
      dist=poisson link=log;
estimate 'RR efd' pfe01 1/exp;
estimate 'RR efd' pfd01 1/exp;
estimate 'RR efd' efe01 1/exp;
estimate 'RR efd' efd01 1/exp;
by gender;
run;

proc genmod data=jh125901;
model htn017=age01 bmi01 edu01l3 inc01 smk01 alc01 pat01 bpm01 totengf totdengf/ dist=poisson link=log;
estimate 'RR total diseng' totdengf 1/exp;
estimate 'RR total eng' totengf 1/exp;
by gender;
run;
ODS RTF close;

proc copy in=work out=data;
select jh125901;
run;
