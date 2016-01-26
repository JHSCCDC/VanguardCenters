**************************************************
**************************************************
0-RunAnalyses: Project Map
**************************************************
**************************************************;

*Assign libnames for JHS VanguardCenters data;

	*x "cd C:\...\VanguardCenters"; ***YOU MUST CHANGE THIS;

    *Assign libnames for JHS "data" folder;
    libname analysis "data\Analysis Data\1-data";
    libname cohort "data\Cohort\1-data";
    libname events "data\Events\1-data";
    libname v1 "data\Visit 1\1-data";
    libname v2 "data\Visit 2\1-data";
    libname v3 "data\Visit 3\1-data";
	options fmtsearch=(analysis.formats v1.v1formats);

	*Assign libnames for JHS "working groups" folder;
	libname project "working groups\CKD\1-data";
	filename pgms "working groups\CKD\2-programs";
	libname results "working groups\CKD\3-results";

*Run programs;

	%include pgms("1-data.sas");
	%include pgms("2-EDA.sas");
