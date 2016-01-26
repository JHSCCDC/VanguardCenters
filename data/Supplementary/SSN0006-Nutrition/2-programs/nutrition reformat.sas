** Original Author: VIO/JHS DCC;
** Purpose: Format 'new' nutritional data to JHS visit format including
	changing variable names
	anonymizing dates
	Renaming dataset name and labeling dataset
**************************************************************************************************;

*Set system options like do not center or put a date on output, etc.;
options nocenter nodate nonumber ps = 150 linesize = 100 nofmterr;

*Assign root directory (VanguardCenters);
x 'cd Z:\Jackson Heart Study\VC Packages\VanguardCenters'; *Change This!;

 *Primary VC data archetypes;
  libname analysis "data\Analysis Data\1-data ";  					 *Analysis-Ready Datasets; 
  libname jhsV1    "data\Visit 1\1-data ";      					 *"Raw" Exam 1 data; 
  libname ssn0006  "data\Supplementary\1-data\SSN0006- Nutrition  " ;

  *Set programs directory(s);
  filename pgmsV1 "data\Visit 1\2-programs"; 
  filename ADpgms "data\Analysis Data\2-programs"; 
  *Read in format statements;
  options nonotes;
    %include ADpgms("0-1-formats.sas"); *Read in Analysis Datasets format statements;
    %include pgmsV1("0-1-formats.sas"); *Read in formats from the JHS visit 1 catalogue;
  options notes;

 options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats);
**************************************************************************************************;

*Standardize variable names data for JHS use*******************************************************;

*Merge grain data with food group data;
	proc sql;
	create table servings as 
	select * from
	(select * from ssn0006.foodgrps ) as b 
		full outer join 
	(select id, G_NWHL,G_SWHL, G_WHL from ssn0006.grains ) as a
		on a.id=b.id ;
	quit;

*Rename new dataset ;
	data DFGA (label="Daily Food Group of JHS FFQ (short)" drop=bkid1 date mon year );
		retain subjid FFQdate;
		length subjid $7.;
		set servings (rename=(id=subjid));

			mon=month(date);
			year=year(date);
			FFQdate=mdy(mon,1,year);

		label subjid="PARTICIPANT ID"
			  FFQdate= "Date"  ;
		format FFQdate MONYY5. ;
	run;

	proc contents data=dfga position; run;
	*N=172 including ID# ;

*Check JIDs;
	data test; merge analysis.analysis1 (in=a) dfga(in=b); by subjid;
	if a=0 and b=1;
	run;
/*No unusal JIDs*/ 
 
data test (drop= subjid);
	retain FFQdate;
	set dfga;
run;

proc sql ;
	*select name,varnum  
	from dictionary.columns
	where libname = 'WORK' and memname = 'DFGA';

	select cats(name,'=','DFGA',varnum)
	into :newnames
	separated by ' '
	from  dictionary.columns
	where libname = 'WORK' and memname = 'TEST';
quit;

/*Use PROC DATASETS to do the rename using the macro variable you have created.            */
/*Modify the libref and data set name for your data set.                                   */

proc datasets library = work ;
	modify dfga;
	rename &newnames;
quit;

data dfga;
	retain subjid; 
	set dfga ;
	format dfga2-dfga172 8.4  ;
run;

*create permanent datasets;
data ssn0006.dfga;
	set dfga;
run;
