
dm  'log;clear;out;clear;';

OPTIONS ls=85  ps=57 NOCENTER DATE PAGENO=1 nofmterr; 

proc import datafile = 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\data\
Creatinine Calibration for conversion Import Nov 21 2013.xls' out = yy1 replace; mixed = yes;
run;

proc means data = yy1 n nmiss;
var roche;
run;

/*ods graphics on;*/
/*ods html; */

ods listing;

libname te 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\data\Creatine';

data y1;
set te.creatinine;
*if cr ne creatinine;
run;

data check1;
set yy1;
keep labid i;
i = 1;
run;

data check2;
set y1;
keep labid j;
j = 1;
run;

proc sort data = check1;
by labid;
run;

proc sort data = check2;
by labid;
run;

data check3;
merge check1 check2;
by labid;
if i = . or j = .;
run;

%let cut = 2;

data y2;
set y1;
if labid ne 51293;
beckman_cx3 = creatinine;
beckman_sq = Beckman_CX3 ** 2;
beckman3 = Beckman_CX3 ** 3;
beckman4 = Beckman_CX3 ** 4;
beckman5 = Beckman_CX3 ** 5;
if beckman_cx3 gt &cut then int = beckman_cx3 - &cut;
else if beckman_cx3 ne . then int = 0;
run;

proc means data = y2 n nmiss min max mean std;
var creatinine roche;
run;

proc means data = yy1 n nmiss min max mean std;
var roche;
run;

data ff1;
set y2;
drop int comment ccf -- diff;
id = 0;
subjectid = _n_;
run;

DATA begin;
INPUT ID;
datalines;
0
;
RUN;

data ff91;
set ff1;
diff = roche - creatinine;
run;

proc means data = ff91;
var diff;
output out = ff92 mean(diff) = mean_diff std(diff) = std_diff;
run;

data ff93;
set ff92;
j = 1;
run;

data ff94;
set ff91;
j = 1;
run;

data ff95 ff96;
merge ff94 ff93;
by j;
drop _type_ _Freq_ j;
if abs(diff - mean_diff) ge 3 * std_diff then output ff95;
else output ff96;
run;

proc sort data = ff96 out = ff97;
by roche;
run;

data ff1;
set ff96;
run;

ods listing close;

%macro dat(fold);

DATA FINAL1;
set begin;
RUN;

DATA FINAL2;
set begin;
RUN;

data ff2;
call streaminit(123);
set ff1;
id1 = rand("UNIFORM");
run;

proc sort data = ff2;
by id1;
run;

/* Split to get Testing Data Set Traing : Validating : Testing = 50% : 25% : 25%*/

data testing ff20;
set ff2;
if _n_ le 50 then output testing;
else output ff20;
run;

/* Holdout method data: Training : Validating = 50% : 25% */

data ff3;
set ff20;
if  _n_ le 100 then id2 = 1;
else id2 = 2;
run;

%DO J = 1 %TO 150;

data ff41;
set ff20;
if _n_ = %eval(&J) then id2 = 2;
else id2 = 1;
id = &J;
run;

data final1;
set final1 ff41;
run;

%end;

/* Leave-One-Out Cross validation */

data ff4;
set final1;
if id ne 0;
run;

proc sort data = ff4;
by id id2 id1;
run;

%DO J = 1 %TO &fold;

data ff51;
set ff20;
if _n_ gt (&J - 1) * int(150/&fold) and _n_ le &J *  int(150/&fold)  then id2 = 2;
else id2 = 1;
id = &J;
run;

data final2;
set final2 ff51;
run;

%end;

/* 10-fold Cross validation */

data ff5;
set final2;
if id ne 0;
run;

proc sort data = ff5;
by id id2 id1;
run;

%mend dat;

%dat(10);

data ff8;
set ff3 (in = a) ff3 (in = b);
if a then id2 = 1;
if b then id2 = 2;
run;

%macro med();

/* Simple Linear Regression */

%macro m1(ff, final);

ods output ParameterEstimates  = b1;
proc nlmixed data = &ff; 

  parms b0=0 b1=0 sigma = 0.5;

  eta_norm = b0 + b1*beckman_cx3;
  p = pdf ('normal', roche, eta_norm, sigma);
  loglike = log(p);
  model roche ~ general(loglike);
by id;
where id2 = 1;
run;

data b11;
set &ff;
i = 1;
run;

proc transpose data = b1 out = b12;
var estimate;
id parameter;
by id;
run;

data b13;
set b12;
keep id b0 b1 i;
i = 1;
rename b1 = slope;
rename b0 = intercept;
run;

data b14;
merge b11 b13;
by id i;
run;

data b15;
set b14;
where id2 = 2;
sqr_error = (roche  - (intercept + slope * beckman_cx3))**2;
run;

proc means data = b15;
var sqr_error;
by id;
output out = b16 mean(sqr_error) = sqr_error;
run;

proc means data = b16;
var sqr_error;
output out = b17 mean(sqr_error) = sqr_error;
run;

data &final;
set b17;
run;

proc datasets lib = work nolist;
delete b1 b11 b12 b13 b14 b15 b16 b17;
quit;
run;

%mend m1;

%m1(ff3, gg11);
%m1(ff4, gg12);
%m1(ff5, gg13);

/* Quadratic Linear Regression */

%macro m2(ff, final);

ods output ParameterEstimates  = b1;
proc nlmixed data = &ff; 

  parms b0=0 b1=0 b2 = 0 sigma = 0.5;

  eta_norm = b0 + b1*beckman_cx3 + b2 * beckman_sq;
  p = pdf ('normal', roche, eta_norm, sigma);
  loglike = log(p);
  model roche ~ general(loglike);
by id;
where id2 = 1;
run;

data b11;
set &ff;
i = 1;
run;

proc transpose data = b1 out = b12;
var estimate;
id parameter;
by id;
run;

data b13;
set b12;
keep id b0 b1 b2 i;
i = 1;
rename b2 = slope2;
rename b1 = slope1;
rename b0 = intercept;
run;

data b14;
merge b11 b13;
by id i;
run;

data b15;
set b14;
where id2 = 2;
sqr_error = (roche  - (intercept + slope1 * beckman_cx3 + slope2 * beckman_sq))**2;
run;

proc means data = b15;
var sqr_error;
by id;
output out = b16 mean(sqr_error) = sqr_error;
run;

proc means data = b16;
var sqr_error;
output out = b17 mean(sqr_error) = sqr_error;
run;

data &final;
set b17;
run;

proc datasets lib = work nolist;
delete b1 b11 b12 b13 b14 b15 b16 b17;
quit;
run;

%mend m2;

%m2(ff3, gg21);
%m2(ff4, gg22);
%m2(ff5, gg23);


%macro m3(ff, final);

/* Piecewise Linear Regression with common variance*/

ods output ParameterEstimates  = b1;
proc nlmixed data = &ff; 

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

data b11;
set &ff;
i = 1;
run;

proc transpose data = b1 out = b12;
var estimate;
id parameter;
by id;
run;

data b13;
set b12;
keep id b0 b1 b2 sigma m0 i;
i = 1;
run;

data b14;
merge b11 b13;
by id i;
run;

data b15;
set b14;
where id2 = 2;
if beckman_cx3 le m0 then sqr_error = (roche  - (b0 + b1*beckman_cx3))**2;
else sqr_error = (roche  - (b0 - m0 * b2 + (b1+ b2)*beckman_cx3))**2;
run;

proc means data = b15;
var sqr_error;
by id;
output out = b16 mean(sqr_error) = sqr_error;
run;

proc means data = b16;
var sqr_error;
output out = b17 mean(sqr_error) = sqr_error;
run;

data &final;
set b17;
run;

proc datasets lib = work nolist;
delete b1 b11 b12 b13 b14 b15 b16 b17;
quit;
run;

%mend m3;

%m3(ff3, gg31);
%m3(ff4, gg32);
%m3(ff5, gg33);

/* Deming Regression*/

%macro m5(ff, final);

proc means data= &ff NOPRINT;
var roche beckman_cx3;
output out=d1 mean(roche) = y_mean mean(beckman_cx3) = x_mean;
by id;
where id2 = 1;
run;

data d2;
merge &ff d1;
by id;
u=(beckman_cx3 - x_mean);
u2=u**2;
q=(roche - y_mean);
q2=q**2;
p=u*q;
run;

proc means data=d2 sum NOPRINT;
var u2 q2 p;
output out=d3 sum(u2)=u sum(q2) = q sum(p) = p;
by id;
where id2 = 1;
run;

data d4;
merge d1 d3;
by id;
b1=((q - u) + ((u - q)**2 + 4*(p)**2)**0.5)/(2*p);
b0=y_mean - b1*x_mean;
drop _type_ -- p;
j = 1;
run;

data d51;
set &ff;
if id2 = 2;
j = 1;
run;

data d52;
merge d51 d4;
by id;
sqr_error = (roche  - (b0 + b1 * beckman_cx3))**2;
run;

proc means data = d52;
var sqr_error;
by id;
output out = d53 mean(sqr_error) = sqr_error;
run;

proc means data = d53;
var sqr_error;
output out = d54 mean(sqr_error) = sqr_error;
run;

data &final;
set d54;
run;

proc datasets lib = work nolist;
delete d1 d2 d3 d4 d51 d52 d53 d54;
quit;
run;

%mend m5;

%m5(ff3, gg51);
%m5(ff4, gg52);
%m5(ff5, gg53);

%mend med;

%med();

ods listing;

data ff0;
set gg11 gg12 gg13 gg21 gg22 gg23 gg31 gg32 gg33 gg51 gg52 gg53;
run;

libname te1 'U:\Study\Consulting\Jackson Heart Study\Chronic Kidney Disease\CKD-EPI Equation versus MDRD\results';

data te1.error2;
set ff0;
run;

data te1.testing2;
set testing;
run;

data te1.training2;
set ff3;
run;

libname te3 'U:\Study\Consulting\Jackson Heart Study\VanguardCenters\data\Visit 1';

data cc1;
set te3.loca;
if creatinine ge 0 and creatinine lt 1 then cat = 1;
else if creatinine ge 1 and creatinine lt 2 then cat = 2;
else if creatinine ge 2 and creatinine lt 3 then cat = 3;
else if creatinine ge 3 and creatinine lt 4 then cat = 4;
else if creatinine ge 4 and creatinine lt 5 then cat = 5;
else if creatinine ge 5 then cat = 6;
if creatinine ge 1 and creatinine lt 1.5 then cat = 7;
if creatinine ge 1.5 and creatinine lt 2 then cat = 8;
run;

proc means data = cc1 n nmiss min max mean std;
var creatinine;
run;

proc freq data = cc1;
tables cat;
run;

data cc2;
set cc1;
if cat = .;
run;

data cc3;
set cc1;
if cat = 6;
keep subjid creatinine;
run;

data cc4;
set cc3;
b01 = -0.024778;
b11 = 0.968113;
y2  = put((b01 + b11 * creatinine), 6.2);

b0 = 0.017421;
b1 = 0.921215;
y1  =  put((b0 + b1 * creatinine), 6.2);
keep subjid creatinine y2 y1;
run;

data yy1;
set y2;
if creatinine ge 0 and creatinine lt 1 then cat = 1;
else if creatinine ge 1 and creatinine lt 2 then cat = 2;
else if creatinine ge 2 and creatinine lt 3 then cat = 3;
else if creatinine ge 3 and creatinine lt 4 then cat = 4;
else if creatinine ge 4 and creatinine lt 5 then cat = 5;
else if creatinine ge 5 then cat = 6;
if creatinine ge 1 and creatinine lt 1.5 then cat = 7;
if creatinine ge 1.5 and creatinine lt 2 then cat = 8;
run;

proc means data = yy1 n nmiss min max mean std;
var creatinine;
run;

proc freq data = yy1;
tables cat;
run;

data ff99;
set ff95;
b01 = -0.024778;
b11 = 0.968113;
per2 = (b01 + b11 * creatinine - roche)/roche * 100;
y2  = put((b01 + b11 * creatinine), 6.2);

b0 = 0.017421;
b1 = 0.921215;
y1  =  put((b0 + b1 * creatinine), 6.2);
per1 = (b0 + b1 * creatinine - roche)/roche * 100;
keep subjid creatinine roche y2 y1 per2 per1;
run;

ods html;

proc print data = ff99;
run;

proc print data = cc4;
run;

ods html close;

