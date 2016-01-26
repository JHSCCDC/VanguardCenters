x 'cd C:\...\VanguardCenters'; *Change This!;

libname analysis "data\Analysis Data\1-data"; 
libname cohort	 "data\Cohort\1-data"; 
libname htn		 "data\Working Groups\Hypertension\1-data";
libname jhsV1    "data\Visit 1\1-data";                   *"Raw" Exam 1 data; 
libname jhsV2    "data\Visit 2\1-data";                   *"Raw" Exam 2 data; 
libname jhsV3    "data\Visit 3\1-data";                   *"Raw" Exam 3 data; 

filename ADpgms "data\Analysis Data\2-programs"; 

options nonotes;
  %include ADpgms("0-1-0-formats.sas"); *Read in Analysis Datasets format statements;
  %include ADpgms("0-1-1-formats.sas"); *Read in formats from the JHS visit 1 catalogue;
  %include ADpgms("0-1-2-formats.sas"); *Read in formats from the JHS visit 2 catalogue;
  %include ADpgms("0-1-3-formats.sas"); *Read in formats from the JHS visit 3 catalogue;
options notes;

options fmtsearch = (analysis.formats jhsV1.v1formats jhsV2.v2formats jhsV3.v3formats);

* Identify subjects who have at least 1 obs in the dataset. All records should be "Y";
data abda;
set jhsV1.abda;
abpm_obs="Y";
label abpm_obs="Have at least 1 obs in the dataset";
run;

proc sort data=abda out=abda_id nodupkey; 
by subjid; 
run; *1148 subjects;

*Delete duplicated records;
proc sort data=abda out=abda_nodup noduplicates;
by subjid abda4 abda6 abda8 abda9; 
run;

proc sort data=abda_nodup out=abda_nodup_id nodupkey; 
by subjid; 
run; *1148;

* Valid measure;
data valid_m (rename=(a4=sbp a6=dbp a8=H_Rea a9=M_Rea A5=pulse_pres A7=heartR));
set abda_nodup;
length a3-a9 8.;
array a (7) abda3-abda9;
array b (7) a3-a9; *convert character to numeric;
do i=1 to 7;
	b(i)=a(i);
end;
if a4<60 or a6<30 or abda10 ^in (' ' 'BEGINNING OF TEST' 'CONCLUSION OF TEST') then delete; *a6<30 instead of 40: 12/31/2013;
ABPM_obs="Y";
Order=input(trim(left(abda3)), 5.0); *convert line number to numeric value;
format Time_M time5.;
Time_M=hms(abda8, abda9, 00); *Time for measurments;
run;

proc sort data=valid_m out=valid_m_id nodupkey; 
by subjid; 
run; *N=1146;

/*Delete duplicated records;
proc sort data=valid_m out=valid_m_re noduplicates; 
by subjid abda4 abda6 abda8 abda9; 
run;

proc sort data=valid_m_re out=valid_m_re_id nodupkey; 
by subjid; 
run; *N=1146;*/

* Create variable ABPM_1valid;
data subid_vm;
merge abda_nodup_id (in=a Keep=subjid abpm_obs) valid_m_id (in=b keep=subjid);
by subjid;
if a;
ABPM_1valid="N";
if b then ABPM_1valid="Y";
label ABPM_1valid="At least 1 valid measurement";
run;

/*
proc freq data=subid_vm; 
tables ABPM_obs ABPM_1valid; 
run;
*/

* Sort measurements by line_number;
proc sort data=valid_m out=valid_m_o; 
by subjid order; 
run;

* Number of valid measurement;
data valid_m_m;
set valid_m_o;
by subjid;
count+1;
if first.subjid then count=1; *set up the order for valid measures which start with 1;
label count="Number or order of valid measurement";
run;

* Get the number of valid measurements for each subject;
data m_count; 
set valid_m_m;
by subjid;
if last.subjid;
run;

/*
proc freq data=m_count;
tables count; 
run;
*/

* Create variable for number of valid measures;
data subid_count;
merge subid_vm (in=a) m_count(in=b keep=subjid count);
by subjid;
if a;
M_count=0;
if b then M_count=count;
label M_count="Number of valid measurement"; *Number for non-valid measure were set up as 0;
run;

/*
proc freq data=subid_count; 
tables ABPM_obs ABPM_1valid M_count; 
run;
*/

* Define IDACO daytime and nightime;
data a; *find the time boundary;
input H M S;
T=hms(H, M, s);
*format t time.;
datalines;
10 00 00
20 00 00
00 00 00
06 00 00
;
run;

/*
proc print data=a; 
run;
*/

data time_reading;
set valid_m_m;
format Time_M time.;
Time_M=hms(H_rea, M_Rea, 00);
if 36000<=Time_M<=72000 then IDACO_Day="Y";
if 0<=Time_M<=21600 then IDACO_Night="Y";
run;

data daytime;
set time_reading;
if IDACO_Day="Y";
run;

proc sort data=daytime; 
by subjid count; 
run;

data daytime_2;
set daytime;
by subjid;
IDA_day_m+1;
if first.subjid then IDA_day_m=1; *count the number of daytime measure;
if last.subjid;
run; *1145;

data daytime_3;
set daytime_2;
if IDA_day_m>=10; *find the subjects who have >=10 daytime measure;
run;

data nighttime;
set time_reading;
if IDACO_Night="Y";
run;

proc sort data=nighttime; 
by subjid count; 
run;

data nighttime_2;
set nighttime;
by subjid;
IDA_night_m+1;
if first.subjid then IDA_night_m=1;
if last.subjid;
run; *1074;

data nighttime_3;
set nighttime_2;
if IDA_night_m>=5;
run; 

* Find the subjects who meet the IDACO criteria;
data IDACO_id; 
merge daytime_3(in=a keep=subjid IDA_day_m) nighttime_3(in=b keep=subjid IDA_night_m);
by subjid;
if a*b;
run; *1046, this number should be same with the freqency of IDACO using the codes below;

data subid_IDACO;
merge subid_count(in=a) daytime_2(in=a keep=subjid IDA_day_m) nighttime_2(in=b keep=subjid IDA_night_m);
by subjid;
if a;
IDACO="N";
if IDA_night_m>=5 and IDA_day_m>=10 then IDACO="Y";
label IDA_night_m="number of nighttime valid measurement under IDACO"
      IDA_day_m="number of daytime valid measurement under IDACO";
run;
*Note: Missing values were attributed to the subjects who have no day and night time measurments;

/*
proc freq data=subid_IDACO; 
tables ABPM_obs ABPM_1valid M_count IDACO IDA_day_m  IDA_night_m / missing; 
run; *IDACO=1046;
*/

* Define JHS daytime and nighttime;
* Find the id who has sbp and dbp in each hour;
data hour_m;
set time_reading (keep=subjid H_Rea Time_M);
run;

proc sort data=hour_m out=hour_m_each nodupkey; 
by subjid H_rea; 
run; *measurement without duplicated Hour of reading;

* Caculate the numbers of reading and keep the subjects who has 24 readings, which means they have at least 1 measurement per hour;
data hour1_m_id; 
set hour_m_each;
by subjid;
slot_count+1;
if first.subjid then slot_count=1;
if last.subjid;
if slot_count=24;
run;

* Find the subjects who have >=54 measurements;
data jhs_count;
set m_count;
if count>=54;
run;

* Subjects meet the JHS criteria: at least 1 measurment per hour and >=54 neasurements;
data jhs_id; 
merge hour1_m_id(in=a keep=subjid) Jhs_count(in=b keep=subjid);
by subjid;
if a*b;
run;

data subid_jhs (drop=count);
merge subid_IDACO (in=a) jhs_id(in=b keep=subjid);
by subjid;
if a;
JHS='N'; IDACO_JHS='N';
if b then JHS='Y';
if IDACO='Y' and JHS='Y' then IDACO_JHS='Y';
label JHS='Valid by JHS cretria';
label IDACO='Valid by IDACO cretria';
label IDACO_JHS='Valid by both IDACO and JHS';
run;

/*
proc freq data=subid_Jhs; 
tables ABPM_obs ABPM_1valid M_count IDACO IDA_day_m  IDA_night_m JHS IDACO_JHS / missing; 
run;
*/

/*
proc contents data=jhsV1.abpa; 
run;
*/

* Link to self report daytime and nighttime;
data abpa ;
set jhsV1.abpa (keep=subjid abpat9 abpat10) ;
run;

proc sort data=abpa out=abpa_id nodupkey; 
by subjid; 
run; *0 duplicate;

* Find the subjects in both files;
data time; 
merge subid_Jhs (in=a) abpa(in=b);
by subjid;
if a*b;
run;

data subid_tim (drop=abpat9 abpat10);
merge subid_Jhs (in=a) time(in=b keep=subjid abpat9 abpat10);
by subjid;
format self_report_wake self_report_sleep time.;
if a;
if b then do; self_report_wake=abpat9; self_report_sleep=abpat10; end;
label self_report_wake="Self-reported wake up time";
label self_report_sleep="Self-reported sleep time";
run;

* Some subjects can not find the self-report records;

/*
data jhsV1.Abpm_measurment_12042013; 
set subid_tim; 
run;
*/

data abpm_measurment_12312013; 
set subid_tim; 
run;

/*
proc freq data=R.Abpm_measurment_12312013; 
tables  ABPM_obs ABPM_1valid M_count IDA_day_m IDA_night_m JHS IDACO IDACO_JHS; 
run;

data test; 
merge jhs_id(in=a) time (in=b);
by subjid;
if a*b;
run;

data a;
set analysis.analysis1;
format _all_;
run;

proc contents data=a; 
run;

proc sort data=a out=a_id nodupkey; 
by subjid; 
run;
*/







































ods output summary=summary_D;
proc means data=daytime mean std; 
by subjid; 
var sbp dbp; 
run;
ods output close;

ods output summary=summary_N;
proc means data=nighttime mean std; 
by subjid; 
var sbp dbp; 
run;
ods output close;

*24-hour sbp dbp : 12/31/2013;
ods output summary=summary_24;
proc means data=time_reading mean std; 
by subjid; 
var sbp dbp; 
run;
ods output close;

* Morning sbp 6-8am;
data morning_time_reading;
set valid_m_m;
if 21600<Time_M<=28800 then do morning_T="Y"; output; end;
run;

ods output summary=summary_M;
proc means data=morning_time_reading mean; 
by subjid; 
var sbp; 
run;
ods output close;

*Night trough sbp;
proc sort data=nighttime out=nighttime_sbp_re; 
by subjid sbp; 
run; *to find the lowest sbp;

data nighttime_lowest_reading; *keep the lowest sbp;
set nighttime_sbp_re;
by subjid;
if first.subjid;
run;

data nighttime_sbp_through_3; *link to valid measures and find the measure immediately before or after the lowest reading;
merge valid_m_m(in=a keep=subjid sbp Time_M count) nighttime_lowest_reading(in=b keep=subjid sbp count rename=(sbp=lowest_sbp count=lowest_sbp_count));
by subjid;
if lowest_sbp_count-1<=count<=lowest_sbp_count+1;
run;

/*
proc print data=nighttime_sbp_through_3(obs=50); 
var subjid sbp Time_M count; 
run;
*/

ods output summary=n_thr_sbp;
proc means data=nighttime_sbp_through_3 mean; 
by subjid; 
var sbp; 
run;
ods output close;

*Link to previous datasets: R.Abpm_measurment_12112013;
data variable_1_12; *Variable 1 to 12;
merge abpm_measurment_12312013(in=a) 
      summary_d(in=b drop=VName_sbp VName_dbp rename=(sbp_Mean=awake_sbp sbp_StdDev=day_SD_of_SBP dbp_Mean=awake_dbp dbp_StdDev=day_SD_of_dBP))
	  summary_n(in=c drop=VName_sbp VName_dbp rename=(sbp_Mean=asleep_sbp sbp_StdDev=night_SD_of_SBP dbp_Mean=asleep_dbp dbp_StdDev=night_SD_of_dBP))
	  summary_m(in=d rename=(sbp_Mean=morning_sbp))
	  n_thr_sbp (in=e rename=(sbp_Mean=nighttime_trough_sbp))
	  summary_24(in=f keep=subjid sbp_Mean dbp_Mean  rename=(sbp_Mean=sbp_all dbp_Mean=dbp_all));

by subjid;
if a;

format awake_sbp day_SD_of_SBP awake_dbp day_SD_of_dBP asleep_sbp night_SD_of_SBP asleep_dbp night_SD_of_dBP morning_sbp nighttime_trough_sbp SDdnSBP SDdnDBP 10.2;

SDdnSBP=((day_SD_of_SBP*10)+(night_SD_of_SBP*6))/16;
SDdnDBP=((day_SD_of_dBP*10)+(night_SD_of_dBP*6))/16;

label awake_sbp="Awake SBP"
      day_SD_of_SBP="Day SD of SBP"
      awake_dbp="Awake DBP"
      day_SD_of_dBP="Day SD of DBP"
      asleep_sbp="Asleep SBP"
      night_SD_of_SBP="Night SD of SBP"
      asleep_dbp="Asleep DBP"
      night_SD_of_dBP="Night SD of DBP"
      morning_sbp="Morning SBP"
      nighttime_trough_sbp="Nighttime trough SBP"
      sbp_all="24 hour SBP"
      Dbp_all="24 hour DBP";
run;

*ARV of SBP and DBP;
data arv_sbp;
set time_reading (keep=subjid time_M sbp dbp count);
by subjid;

length sbp_1-sbp_156 dbp_1-dbp_156 4.;
format T_1-T_156 time. ;
array a(156) sbp_1-sbp_156;
array c(156) dbp_1-dbp_156;
array b(156) T_1-T_156;
retain sbp_1-sbp_156 dbp_1-dbp_156 T_1-T_156;

if first.subjid then
do;
do i=1 to 156;
 a(i)=.;
 b(i)=.;
 c(i)=.;
end;
end;

a(count)=sbp;
c(count)=dbp;
b(count)=Time_M;

if last.subjid;
run;

/*
proc freq data=arv_sbp; 
tables count; 
run;
*/

data arv_sbp_2 (drop=sbp dbp Time_M i /*sbp_1-sbp_156 T_1-T_156 dbp_1-dbp_156*/);
set arv_sbp;

array a(155) h_1-h_155;
array b(155) sbpi_1-sbpi_155;
array b_2(155) dbpi_1-dbpi_155;
array c(156) T_1-T_156;
array e(156) sbp_1-sbp_156;
array e_2(156) dbp_1-dbp_156;


do i=1 to 155;
if c(i+1)>c(i) then do;
  a(i)=Intck('MINUTE',c(i), c(i+1));
                    end;
else if c(i+1)<c(i) then do;
  a(i)=Intck('MINUTE',c(i), c(i+1))+1440; 
                        end; *correct the time interval when the time of measure jump to 0:00, 24*60=1440;

  b(i)=abs(e(i+1)-e(i));
  b_2(i)=abs(e_2(i+1)-e_2(i));
end;

array w_sbp(155) w_sbp_1-w_sbp_155;
array w_dbp(155) w_dbp_1-w_dbp_155;
do i=1 to 155;
	w_sbp(i)=a(i)*b(i);
	w_dbp(i)=a(i)*b_2(i);
end;

sum_w_sbp=sum (of w_sbp_1-w_sbp_155);
sum_w_dbp=sum (of w_dbp_1-w_dbp_155);
Sum_w=sum(of h_1-h_155);

format ARV_sbp ARV_dbp 10.2;
ARV_sbp=sum_w_sbp/Sum_w;
ARV_dbp=sum_w_dbp/Sum_w;
run;

/*
proc print data=arv_sbp_2(obs=10); 
var subjid H_1-H_153 sum_w; 
run;

proc print data=arv_sbp_2(obs=10); 
var subjid sbp_2  sbp_3 T_2 T_3 h_2 sbpi_2  w_sbp_2; 
run; 
*/

* Link to individual level dataset;

data variable_13_19;
merge variable_1_12(in=a) arv_sbp_2(in=b keep=subjid ARV_sbp ARV_dbp);
by subjid;
if a;

format Noc_dec  M_surge 10.2 ;
Noc_dec=((awake_sbp-asleep_sbp)/awake_sbp)*100;
M_surge=morning_sbp-nighttime_trough_sbp;


if ABPM_1valid="Y" then do;

	if .<noc_dec<=10 then non_dip="Y"; 
	   if awake_sbp^=. and asleep_sbp^=. and noc_dec>10 then non_dip="N";
	     /*if awake_sbp=. or asleep_sbp=. then non_dip=" ";*/
	   
	if asleep_sbp>=120 or asleep_dbp>=70 then Noc_Hyper="Y"; 
	   if .<asleep_sbp<120 and .<asleep_dbp<70 then Noc_Hyper="N";
	     /*if asleep_sbp=. or asleep_dbp=. then Noc_Hyper=" ";*/

	if awake_sbp>=135 or awake_dbp>=85 then AAH="Y"; 
	    if .<awake_sbp<135 and .<awake_dbp<85 then AAH="N";
		  /*if awake_sbp=. or awake_dbp=. then AAH=" ";*/

	if sbp_all>=130 or dbp_all>=80 then AH_24="Y";
	   if .<sbp_all<130 and .<dbp_all<80 then AH_24="N";

end;

label ARV_sbp="ARV of SBP"
      ARV_dbp="ARV of DBP"
	  non_dip="Non-dipping pattern"
	  noc_hyper="Nocturnal hypertension"
	  Noc_dec="Nocturnal decline"
	  M_surge="Morning surge"
	  AAH="Awake ambulatory hypertension"
	  AH_24="24 hour mbulartory hypertension";

run;

/*
proc print data=variable_13_19; 
where ABPM_1valid="N"; 
run;

proc print data=variable_13_19(obs=50); 
var subjid awake_sbp awake_dbp asleep_sbp asleep_dbp Noc_dec morning_sbp nighttime_trough_sbp M_surge non_dip Noc_Hyper AAH; 
where AAH=" "; 
run;

proc freq data=variable_13_19; 
tables non_dip Noc_Hyper AAH/missing; 
run;
*/

* For variable No. 20, clinic hypertension;
* Get the clinical sbp and dbp;

data clinic_sbp_dbp;
set analysis.analysis1(Keep=subjid sbp dbp rename=(sbp=clinic_sbp dbp=clinic_dbp));
format _all_;
run;

proc sort data=clinic_sbp_dbp out=clinic_sbp_dbp_id nodupkey; 
by subjid; 
run; *0 obs, noduplicates;

proc sort data=variable_13_19; 
by subjid; 
run;

*Link to the individual level file;
data for_variable_20_27;
merge variable_13_19(in=a) clinic_sbp_dbp_id(in=b);
by subjid;
if a*b;
valid_clinic_bp=0;
if clinic_sbp^=. and clinic_dbp^=. and clinic_sbp<300 and  0<clinic_dbp<300 and clinic_dbp<clinic_sbp then valid_clinic_bp=1;
label valid_clinic_bp="With valid clinic BP";
run;

/*
proc freq data=for_variable_20_27; 
tables valid_clinic_bp; 
run;

proc print data=for_variable_20_27(obs=10); 
var subjid clinic_sbp clinic_dbp; 
where valid_clinic_bp=1; 
run;

proc print data=clinic_sbp_dbp; 
var subjid clinic_sbp clinic_dbp; 
where subjid in ("J127199" "J500008" "J503648" "J540458" "J554833"); 
run;
*/

data variable_20_27;
set for_variable_20_27;

if clinic_sbp>=140 or clinic_dbp>=90 then clinic_hyper="Y";
 if valid_clinic_bp^=0 and clinic_sbp<140 and clinic_dbp<90 then clinic_hyper="N";

if ABPM_1valid="Y" then do;

  if AAH="Y" and clinic_hyper="N" then Mask_Hyper="Y";
    if AAH="N" or clinic_hyper="Y" then Mask_Hyper="N";
	  if AAH=" " or clinic_hyper=" " then Mask_Hyper=" ";
    
  if clinic_hyper="Y" and AAH="N" then WCH="Y";
    if clinic_hyper="N" or AAH="Y"  then WCH="N";
	  if AAH=" " or clinic_hyper=" " then WCH=" ";

  if Noc_hyper="Y" or Mask_Hyper="Y" then Overall_M_hyper="Y";
    if Noc_hyper="N" and Mask_Hyper="N" then Overall_M_hyper="N";
	 if Noc_hyper=" " or Mask_Hyper=" " then Overall_M_hyper=" ";

  if noc_hyper="Y" and clinic_hyper="N" then Mask_noc_hyper="Y";
     if noc_hyper="N" or clinic_hyper="Y" then Mask_noc_hyper="N";
	   if noc_hyper=" " or clinic_hyper=" " then Mask_noc_hyper=" ";

  if clinic_hyper="N" and (noc_hyper="Y" and  AAH="N")  then mask_iso_noc_hyper="Y";
    if clinic_hyper="Y" or noc_hyper="N" or AAH="Y"  then mask_iso_noc_hyper="N";
	  if clinic_hyper=" " or noc_hyper=" " or AAH=" " then mask_iso_noc_hyper=" ";


  if clinic_hyper="N" and (noc_hyper="N" and AAH="Y")  then mask_iso_av_hyper="Y";
    if clinic_hyper="Y" or noc_hyper="Y" or AAH="N" then mask_iso_av_hyper="N";
	 if clinic_hyper=" " or noc_hyper=" " or AAH=" " then mask_iso_av_hyper=" ";


  if clinic_hyper="N" and (noc_hyper="Y" and  AAH="Y") then Mask_d_n_hyper="Y";
    if clinic_hyper="Y" or noc_hyper="N" or  AAH="N" then Mask_d_n_hyper="N";
      if clinic_hyper=" " or noc_hyper=" " or AAH=" " then Mask_d_n_hyper=" ";
end;

label clinic_hyper="Clinic hypertension"
      Mask_Hyper="Masked hypertension"
	  WCH="White coat hypertension"
      Overall_M_hyper="Overall masked hypertension"
      Mask_noc_hyper="Masked nocturnal hypertension"
      mask_iso_noc_hyper="Masked isolated nocturnal hypertension"
      mask_iso_av_hyper="Masked isolated awake hypertension"
      Mask_d_n_hyper="Masked day-night hypertension";

run;

/*
proc print data=variable_20_27; 
where ABPM_1valid="N"; 
run; 

proc print data=variable_20_27(obs=50); 
var subjid clinic_sbp clinic_dbp awake_sbp awake_dbp asleep_sbp asleep_dbp clinic_hyper AAH Mask_Hyper WCH  Noc_hyper Noc_dec non_dip; ; 
run;

proc print data=variable_20_27(obs=50); 
var subjid clinic_hyper AAH Mask_Hyper WCH  Noc_hyper Overall_M_hyper Mask_noc_hyper mask_iso_noc_hyper mask_iso_av_hyper Mask_d_n_hyper ; 
run;

proc print data=time_reading; 
where subjid="J124709"; 
run;
*/

data htn.ABPMderived; 
set variable_20_27; 
run;

/*
proc contents data=v.ABPM_indiv_rec_all_var_12312013; 
run;

data a;
set v.ABPM_indiv_rec_all_var_12312013;
if M_surge=. and IDACO="Y";;
run;

proc print data=a; 
var subjid morning_sbp nighttime_trough_sbp; 
run; *all morning_sbp are missing;

data miss_test;
merge a(in=a keep=subjid) morning_time_reading (in=b);
by subjid;
if a*b;
run; 

data miss_test2;
merge a(in=a keep=subjid) valid_m_m(in=b);
by subjid;
if a*b;
run; 

proc print data=miss_test2(obs=100); 
run;

proc contents data=R2.analysis1; 
run;

proc freq data=v.ABPM_indiv_rec_all_var_12312013; 
tables mask_iso_av_hyper; 
run;
*/

ods listing;
