x "cd C:\Users\sseals\Desktop\VC Packages\2013-12-20\VanguardCenters\data";

libname afu "AFU\1-data\AFU"; 			 * Directory containing AFU;
libname afo "AFU\1-data\AFO"; 			 * Directory containing AFO;
libname af  "AFU\1-data\AF";			 * Directory containing AF;
libname out "AFU\1-data"; 	 			 * Directory to deposit final AFUlong into;
libname analysis "Analysis Data\1-data"; * Directory for dataset with visit dates;

filename afup "AFU\2-programs"; 		 * Directory containing programs;

x "cd AFU\3-results";

options nonotes;
	%include afup("0-1 formats.sas"); 	 * Define formats;

	* Build AFU long;

	%include afup("1-1 AFUA.sas");		 * Build AFUA;
	%include afup("1-2 AFUB.sas");		 * Build AFUB;
	%include afup("1-3 AFUC.sas");		 * Build AFUC;
	%include afup("1-4 AFUD.sas");		 * Build AFUD;
	%include afup("1-5 AFUE.sas");		 * Build AFUE;
	%include afup("1-6 AFUlong.sas");	 * Build AFUlong;

	* Build AF1, AF2, AF3;

	%include afup("2-1 AF1.sas");		 * Build AF1;
	%include afup("2-2 AF2.sas");		 * Build AF1;
	%include afup("2-3 AF3.sas");		 * Build AF1;
options notes;
