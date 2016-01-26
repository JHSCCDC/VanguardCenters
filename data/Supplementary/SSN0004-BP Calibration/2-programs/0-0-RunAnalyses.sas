***************************************************************************
***************************************************************************
Original authors:	Jonathan Tingle, Samantha Seals, and Mike Griswold,
					UMMC Center of Biostatistics & Bioinformatics
Program/project:	JHS Blood Pressure Comparability Study (BPCS)
Last updated: 		July 6, 2015
Purpose:			Calibrate JHS blood pressures at visit 1 and visit 2
					to reflect change in clinic blood pressure
					measurement devices
Inputs:				JHS blood pressure measurements at visits 1, 2, & 3
Outputs:			Calibrated and uncalibrated blood pressure
					measurements at visits 1, 2, & 3
***************************************************************************
***************************************************************************;

*Change directory and assign libnames;

*x "cd C:\ ... \VanguardCenters"; *** YOU MUST CHANGE THIS PATH ***;

libname analysis "data\Analysis Data\1-data";
libname v1 "data\Visit 1\1-data";
libname v2 "data\Visit 2\1-data";
libname v3 "data\Visit 3\1-data";
options fmtsearch=(analysis.formats v1.v1formats v2.v2formats v3.v3formats);

libname info "data\Supplementary\SSN0004-BP Calibration\0-info";
libname project "data\Supplementary\SSN0004-BP Calibration\1-data";
filename programs "data\Supplementary\SSN0004-BP Calibration\2-programs";
libname results "data\Supplementary\SSN0004-BP Calibration\3-results";

*Run programs;

	*Load Deming Regression Macro;
	%include programs("0-1-Deming macro.sas");

	*Calibrate data;
	%include programs("1-data-calibration.sas");

	*Look at EDA;
	ods pdf file="data\Supplementary\SSN0004-BP Calibration\3-results\BPCS EDA.pdf";
	ods graphics / loessmaxobs=5500;
	%include programs("2-EDA.sas");
	ods pdf close;
