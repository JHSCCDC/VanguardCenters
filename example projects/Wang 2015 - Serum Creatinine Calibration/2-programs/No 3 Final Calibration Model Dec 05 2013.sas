
dm  'log;clear;out;clear;';

OPTIONS ls=85  ps=57 NOCENTER DATE PAGENO=1 nofmterr; 

libname te1 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results';

data aa1;
set te1.training1;
j = 1;
run;

data aa2;
set te1.training2;
j = 1;
run;

/* Correlation Coefficient of Complete for Simple Linear Regression */

ods output ParameterEstimates  = b1;
proc nlmixed data = aa1; 

  parms b0=0 b1=0 sigma = 0.5;

  eta_norm = b0 + b1*beckman_cx3;
  p = pdf ('normal', roche, eta_norm, sigma);
  loglike = log(p);
  model roche ~ general(loglike);
run;

proc transpose data = b1 out = c52;
id parameter;
var estimate;
run;

proc means data = aa1;
var beckman_cx3;
output out = c53 mean(beckman_cx3) = meany;
run;

data c54;
merge c52 c53;
j = 1;
drop _type_ _freq_ _name_;
run;

data c55;
merge aa1 c54;
by j;
b0 = 0.01864;
b1 = 0.92019;
y1  = (roche - (b0 + b1 * beckman_cx3))**2;
y2 = (roche - meany)**2;
run;

proc means data = c55;
var y1;
output out = c56 sum(y1) = y1 sum(y2) = y2;
run;

data c58;
set c55;
by j;
if first.j;
keep b0 b1 sigma;
run;

data c57;
merge c56 c58;
cd = 1 - y1/y2;
drop _type_ _freq_;
run;

proc reg data = aa1;
model roche = beckman_cx3;
quit;
run;

proc reg data = aa2;
model roche = beckman_cx3;
quit;
run;

   proc nlp data=aa1 cov=1 sigsq=1 pstderr phes pcov pshort clparm = ward;
      min dist;
      parms b1=1, b0=1;
      dist=(roche - (b0 + b1*beckman_cx3))**2 / (1 + b1*b1);
      run;

/* Correlation Coefficient of Complete for Deming Regression */

data c55;
merge aa1 c54;
by j;
b0 = 0.017421;
b1 = 0.921215;
y1  = (roche - (b0 + b1 * beckman_cx3))**2;
y2 = (roche - meany)**2;
run;

proc means data = c55;
var y1;
output out = c56 sum(y1) = y1 sum(y2) = y2;
run;

data c58;
set c55;
by j;
if first.j;
keep b0 b1 sigma;
run;

data c59;
merge c56 c58;
cd = 1 - y1/y2;
drop _type_ _freq_;
run;

	     proc nlp data=aa2 cov=1 sigsq=1 pstderr phes pcov pshort clparm = ward;
      min dist;
      parms b1=1, b0=1;
      dist=(roche - (b0 + b1*beckman_cx3))**2 / (1 + b1*b1);
      run;

proc means data = aa2;
var beckman_cx3;
output out = c53 mean(beckman_cx3) = meany;
run;

data c54;
merge c52 c53;
j = 1;
drop _type_ _freq_ _name_;
run;

data c55;
merge aa2 c54;
by j;
b0 = -0.024778;
b1 = 0.968113;
y1  = (roche - (b0 + b1 * beckman_cx3))**2;
y2 = (roche - meany)**2;
run;

proc means data = c55;
var y1;
output out = c56 sum(y1) = y1 sum(y2) = y2;
run;

data c58;
set c55;
by j;
if first.j;
keep b0 b1 sigma;
run;

data c59;
merge c56 c58;
cd = 1 - y1/y2;
drop _type_ _freq_;
run;

data c55;
merge aa2 c54;
by j;
b0 = -0.00230;
b1 = 0.94491;
y1  = (roche - (b0 + b1 * beckman_cx3))**2;
y2 = (roche - meany)**2;
run;

proc means data = c55;
var y1;
output out = c56 sum(y1) = y1 sum(y2) = y2;
run;

data c58;
set c55;
by j;
if first.j;
keep b0 b1 sigma;
run;

data c57;
merge c56 c58;
cd = 1 - y1/y2;
drop _type_ _freq_;
run;

data bb2;
set te1.testing2;
b0 = -0.024778;
b1 = 0.968113;
pred  = b0 + b1 * beckman_cx3;
diff = roche - (b0 + b1 * beckman_cx3);
per = diff/roche * 100;
avg = (roche + pred)/2;
run;

proc means data = bb2;
var beckman_cx3 roche pred diff per;
run;

proc ttest data = bb2 h0 = 0;
var diff per;
run;

data bb3;
set bb2;
keep subjid beckman_cx3 roche avg diff pred;
run;

data aa3;
set aa2;
keep subjectid beckman_cx3 roche;
run;

proc export data = aa3 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
Training Prediction Dec 07 2013.xls' dbms = excel replace;
run;

proc export data = bb3 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
Testing Dec 07 2013.xls' dbms = excel replace;
run;

proc nlmixed data = aa3; 

  parms b0=0 b1=0 b2 = 0 sigma = 0.5 m0 = 1;

  eta_norm1 = b0 + b1*beckman_cx3;
  eta_norm2 = b0 - m0 * b2 + (b1+ b2)*beckman_cx3;

  p1 = pdf ('normal', roche, eta_norm1, sigma);
  p2 = pdf ('normal', roche, eta_norm2, sigma);
  if beckman_cx3 le m0 then loglike = log(p1);
else loglike = log(p2);

  model roche ~ general(loglike);
by id;
where id2 = 1;
run;

data x;
do i = 1 to 100;
scr = i * 0.1;
scr1 = scr - 0.06;
scr2 = scr + 0.06;
k1 = 0.7;
k2 = 0.9;
alpha1 = -0.329;
alpha2 = -0.411;
y01 = 141 * (min(scr1/k1, 1))**alpha1 * (max(scr1/k1, 1))**(-1.209)*0.993**40*1.018*1.159;
y02 = 141 * (min(scr/k1, 1))**alpha1 * (max(scr/k1, 1))**(-1.209)*0.993**40*1.018*1.159;
y03 = 141 * (min(scr2/k1, 1))**alpha1 * (max(scr2/k1, 1))**(-1.209)*0.993**40*1.018*1.159;

y04 = 141 * (min(scr1/k1, 1))**alpha1 * (max(scr1/k1, 1))**(-1.209)*0.993**70*1.018*1.159;
y05 = 141 * (min(scr/k1, 1))**alpha1 * (max(scr/k1, 1))**(-1.209)*0.993**70*1.018*1.159;
y06 = 141 * (min(scr2/k1, 1))**alpha1 * (max(scr2/k1, 1))**(-1.209)*0.993**70*1.018*1.159;

z01 = 141 * (min(scr1/k2, 1))**alpha2 * (max(scr1/k2, 1))**(-1.209)*0.993**40*1.159;
z02 = 141 * (min(scr/k2, 1))**alpha2 * (max(scr/k2, 1))**(-1.209)*0.993**40*1.159;
z03 = 141 * (min(scr2/k2, 1))**alpha2 * (max(scr2/k2, 1))**(-1.209)*0.993**40*1.159;

z04 = 141 * (min(scr1/k2, 1))**alpha2 * (max(scr1/k2, 1))**(-1.209)*0.993**70*1.159;
z05 = 141 * (min(scr/k2, 1))**alpha2 * (max(scr/k2, 1))**(-1.209)*0.993**70*1.159;
z06 = 141 * (min(scr2/k2, 1))**alpha2 * (max(scr2/k2, 1))**(-1.209)*0.993**70*1.159;
output;
end;
run;

proc export data = x outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
Pred GFR Jan 08 2014.xls' dbms = excel replace;
run;

/* CCC Calculation */

data ccc;
input x y;
datalines;
1.3	1.18
1.1	1.07
1.1	1.04
0.9	0.92
1.1	1.12
0.9	0.75
0.9	0.87
0.9	0.84
1.4	1.29
1.0	1.05
1.4	1.32
1.1	1.06
0.8	0.74
1.3	1.25
1.1	1.12
1.0	0.98
1.1	1.03
0.8	0.68
0.8	0.74
1.0	0.81
0.9	0.82
0.8	0.72
1.0	0.98
0.7	0.61
0.8	0.72
0.8	0.72
1.3	1.21
0.7	0.70
1.1	1.05
0.8	0.79
1.0	0.85
1.0	0.86
0.9	0.87
0.8	0.69
1.2	1.15
0.8	0.73
2.2	1.92
1.2	1.16
0.9	0.82
1.1	0.99
0.9	0.92
1.2	1.08
0.5	0.55
0.8	0.70
1.2	1.25
1.1	1.05
1.1	0.99
0.7	0.61
1.1	0.94
0.8	0.73
;
run;

%inc 'C:\Users\wwang\Desktop\Temp\SAS Code and Materials\SAS MACRO\Concordance Correlation Coefficient\ccc macro v9.sas';

%ccc(analysis = 1, dataset1 = ccc, raters1 = x y, alpha = 0.05, out = outdata1);

/* Prevalence of CKD */

OPTIONS nofmterr;

libname ana1 'U:\Study\Consulting\Jackson Heart Study\VanguardCenters\data\Analysis Data\1-data';

libname ana2 'U:\Study\Consulting\Jackson Heart Study\VanguardCenters\data\Analysis Data\1-data\frozen data';

libname raw 'U:\Study\Consulting\Jackson Heart Study\VanguardCenters\data\Visit 1';


data aa1;
set ana1.analysis1;
keep subjid male SCr;
run;

proc freq data = ana1.analysis1;
tables visitdate;
run;

proc means data = aa1 n nmiss;
var scr;
run;

data aa2;
set ana2.analysis1;
keep subjid age;
*rename age = age1;
run;

data aa4;
set raw.loca;
keep subjid creatinine;
run;

libname te 'C:\Users\wwang\Desktop\Creatine';

data y1;
set te.creatinine;
*if cr ne creatinine;
run;

data y2;
merge aa1 aa2 y1 (in = a);
by subjid;
if a;
run;

proc freq data = y2;
tables male;
run;

proc means data = y2;
var age;
run;

proc means data = aa1 n nmiss;
var male;
run;

proc means data = aa4 n nmiss;
var creatinine;
run;

data aa3;
merge aa1 aa2 aa4;
by subjid;
/*if age ne age1;*/
/*diff = age - age1;*/
if creatinine ne .;
run;

proc means data = aa3 n nmiss;
var creatinine male age;
run;

data aa5;
set aa3;
b0 = -0.024778;
b1 = 0.968113;
pred  = b0 + b1 * creatinine;
k1 = 0.7;
k2 = 0.9;
alpha1 = -0.329;
alpha2 = -0.411;
if male = 0 then do;
k = k1;
alpha = alpha1;
epi = 141 * (min(pred/k, 1))** alpha * (max(pred/k, 1))**(-1.209)*0.993**age*1.018*1.159;
mdrd = 175 * pred ** (-1.154) * age ** (-0.203) * 1.212 * 0.742;
epi1 = 141 * (min(creatinine/k, 1))** alpha * (max(creatinine/k, 1))**(-1.209)*0.993**age*1.018*1.159;
end;
if male = 1 then do;
k = k2;
alpha = alpha2;
epi = 141 * (min(pred/k, 1))** alpha * (max(pred/k, 1))**(-1.209)*0.993**age*1.159;
mdrd = 175 * pred ** (-1.154) * age ** (-0.203) * 1.212;
epi1 = 141 * (min(creatinine/k, 1))** alpha * (max(creatinine/k, 1))**(-1.209)*0.993**age*1.159;
end;
drop b0 b1 k1 k2 k alpha1 alpha2 alpha;
run;

data x;
age = 79;
sc = 1.04;
epi = 141 * (1.04/0.7) ** (-1.209) * 0.993 ** age * 1.018 * 1.159;
mdrd = 175 * 1.04 ** (-1.154)* age ** (-0.203)* 1.212 * 0.742;
run; 

data aa6;
set aa5;
if epi ge 60 then epic = 0;
else if epi ne . then epic = 1;
if mdrd ge 60 then mdrdc = 0;
else if mdrd ne . then mdrdc = 1;
if epi1 ge 60 then epi1c = 0;
else if epi1 ne . then epi1c = 1;
run;

proc freq data = aa6;
tables epic * mdrdc epic*epi1c/agree;
run;

data mm1;
set raw.cena;
keep subjid cystatinC;
if cystatinC ne .;
run;

data mm2;
merge aa6 (in = b) mm1 (in = a);
by subjid;
if a = b;
if male = 0 then gfr1 = 133 * (min(cystatinC/0.8, 1))** (-0.499) * (max(cystatinC/0.8, 1))**(-1.328)*0.996**age*0.932;
else gfr1 = 133 * (min(cystatinC/0.8, 1))** (-0.499) * (max(cystatinC/0.8, 1))**(-1.328)*0.996**age;
k1 = 0.7;
k2 = 0.9;
alpha1 = -0.248;
alpha2 = -0.207;
if male = 0 then do;
k = k1;
alpha = alpha1;
gfr2 = 135 * (min(pred/k, 1))** alpha * (max(pred/k, 1))**(-0.601)* (min(cystatinC/0.8, 1))** (-0.375) * (max(cystatinC/0.8, 1))**(-0.711)* 0.995**age*0.969*1.08;
end;
if male = 1 then do;
k = k2;
alpha = alpha2;
gfr2 = 135 * (min(pred/k, 1))** alpha * (max(pred/k, 1))**(-0.601)* (min(cystatinC/0.8, 1))** (-0.375) * (max(cystatinC/0.8, 1))**(-0.711)* 0.995**age*1.08;
end;
drop k1 k2 k alpha1 alpha2 alpha;
run;


data mm3;
set mm2;
if gfr1 ge 60 then gfr1c = 0;
else if gfr1 ne . then gfr1c = 1;
if gfr2 ge 60 then gfr2c = 0;
else if gfr2 ne . then gfr2c = 1;
run;

proc freq data = mm3;
tables epic * gfr1c epic*gfr2c/agree;
run;

proc means data = mm3;
var epi mdrd gfr1 gfr2;
run;

data temp1;
set aa5;
keep subjid epi;
rename epi = epi_egfr;
run;

/* 
data te1.epiegfr;
set temp1;
run;
*/

data aa7;
set aa6;
if epic = 1 and mdrdc = 1 then do;
epic = -1;
mdrdc = -1;
end;
run;

proc sort data = aa7;
by epic mdrdc;
run;

data aa8;
set aa7;
if epi ge 50 and epi le 70 and mdrd ge 50 and mdrd le 70;
run; 

data aa71;
set aa6;
if epic = 1 and epi1c = 1 then do;
epic = -1;
epi1c = -1;
end;
run;

proc sort data = aa71;
by epic epi1c;
run;

data aa81;
set aa71;
if epi ge 50 and epi le 70 and epi1 ge 50 and epi1 le 70;
run;

data aa72;
retain epi1 epi;
set aa71;
run;

data aa82;
retain epi1 epi;
set aa81;
run;

proc export data = aa7 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
CKD Prevalence Dec 17 2013.xls' dbms = excel replace;
run;

proc export data = aa8 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
CKD Prevalence 50 - 70 Dec 17 2013.xls' dbms = excel replace;
run;

proc export data = aa72 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
CKD Prevalence calibrated vs non calibrated Jan 17 2013.xls' dbms = excel replace;
run;

proc export data = aa82 outfile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results\
CKD Prevalence 50 - 70 calibrated vs non calibrated Jan 17 2013.xls' dbms = excel replace;
run;


proc means data = aa7;
var epi mdrd;
run;

data aa71;
set aa7;
if epi ge 60 and mdrd ge 60;
if epi ge mdrd then cat = 1;
else cat = 0;
run;

proc freq data = aa71;
tables cat/binomial;
run;

data approval;
input hus_resp $ wif_resp $ count;
datalines;
yes yes 305
yes no 12
no yes 23
no no 4870
;
proc freq order=data;
weight count;
tables hus_resp*wif_resp / agree;
run;

