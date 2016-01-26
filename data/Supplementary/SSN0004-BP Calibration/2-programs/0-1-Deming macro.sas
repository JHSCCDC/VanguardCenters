***************************************************************************
***************************************************************************
BPCS program file: 0-1-Deming macro
Please see "0-info/A SAS Macro for Deming Regression" for more information
***************************************************************************
***************************************************************************;

%MACRO DEMING(dataset, id, method1, method2);

*************************Deming Regression***************************;
*****************************Linnet 1998*****************************;
data deming; set &dataset;
	keep &id &method1 &method2;
	rename &method2=x &method1=y &id=id;
run;

/*Use PROC MEANS to obtain the average measured value for each of the
two measurement methods across all measured items*/
proc means data=deming mean NOPRINT;
	var x y;
	output out=means;
run;

data _null_; set means;
	where _STAT_ IN ("MEAN");
	call symputx("x_mean",round(x,0.001));
	call symputx("y_mean",round(y,0.001));
run;

/*Calculate sum of squares using a DATA STEP to calculate the squared
deviations and PROC MEANS to sum those deviations*/
data deming1; set deming;
	u=(x-&x_mean);
	u2=u**2;
	q=(y-&y_mean);
	q2=q**2;
	p=u*q;
run;

proc means data=deming1 sum NOPRINT;
	var u2 q2 p;
	output out=means sum=u q p;
run;

data _null_; set means;
	call symputx("u",round(u,0.001));
	call symputx("q",round(q,0.001));
	call symputx("p",round(p,0.001));
run;

/*Use the sum of squares and means obtained above to calculate the
Deming regression slope and intercept estimates, based on equations
from Linnet 1998*/
data deming2;
	b=((&q - &u) + ((&u-&q)**2 + 4*(&p)**2)**0.5)/(2*&p);
	a0=&y_mean - b*&x_mean;
	dummy=1;
run;

%MEND DEMING;

/*Create %DOIT macro*/
%MACRO DOIT(dataset, id, method1, method2);

***********************************************************************;
* Step 1: DEMING REGRESSION ESTIMATES
* Obtain the Deming regression slope and intercept estimates by calling
* the %DEMING macro on the full dataset
***********************************************************************;

%DEMING(&dataset, &id, &method1, &method2)

data estimates; set deming2;
	rename
		b = b_est
		a0 = a0_est;
run;

***********************************************************************;
* Step 2: JACKKNIFE PROCEDURE
* Obtain the Deming regression slope and intercept estimates for each of
* the N datasets created by removing the ith observation from the full
* dataset and then calling the %DEMING macro on each of those N datasets
* (based on Linnet 1990)
***********************************************************************;

/*Create a variable containing the number of observations in the full
 dataset*/
proc means data=&dataset n NOPRINT;
	var &method1;
	output out=n;
run;

data _null_; set n;
	where _STAT_ IN ("N");
	call symputx("n",round(&method1,0.001));
run;

/*Number the N observations in the full dataset 1 thru N*/
data jackorig; set &dataset;
	count+1;
run;

/*Create an empty dataset that will hold the results of the jackknife
procedure*/
data jack; set _null_;
run;

/*Call the %DEMING macro N times*/
%DO i=1 %TO &n;

/*On the ith iteration, remove the ith observation from the
original dataset*/
data jack&i; set jackorig; 
	where count NE &i;
run;

/*Call the %DEMING macro on the subsetted dataset*/
%DEMING(jack&i, &id, &method1, &method2)

/*Add the Deming regression slope and intercept estimates for the
ith iteration as the ith observation in the dataset JACK and
define the variable JACK equal to the value of i*/
data jack; set jack deming2(in=a);
	if a then jack = &i;
	dummy = 1;
run;

%END;

***********************************************************************;
* Step 3: CONFIDENCE INTERVALS
* Using results from the jackknife procedure and the Deming regression
* slope and intercept estimates, calculate the standard errors of the
* Deming regression slope and intercept estimates and use those to
* produce 95% confidence intervals
***********************************************************************;

/*Calculate the jackknifed estimators of the slope and intercept using a
a DATA STEP to calculate the estimators for the ith iteration and PROC
MEANS to obtain the means of those estimators*/
data jackcalc;
	merge jack estimates;
	by dummy;
	jackb=(&n * b_est) - ((&n-1)*b); /*See Equation 3a*/
	jacka=(&n * a0_est) - ((&n-1)*a0); /*See Equation 3a*/
	call symputx("b_est", b_est);
	call symputx("a0_est", a0_est);
run;

proc means data=jackcalc mean NOPRINT;
	var jackb jacka;
	output out=jackcalc1 mean=jackbmean jackamean;
run;

data jackcalc1; set jackcalc1 (drop= _type_ _freq_);
	dummy=1;
run;

/*Calculate the variances of the Deming regression slope and intercept
estimates using a DATA STEP to calculate the variances for the ith
ith iteration and PROC MEANS to obtain the sum of those variances*/

data jackcalc2;
	merge jackcalc jackcalc1;
	by dummy;
	diff_b2=(jackb- jackbmean)**2/(&n-1);
	diff_a2=(jacka- jackamean)**2/(&n-1);
run;

proc means data=jackcalc2 sum NOPRINT;
	var diff_b2 diff_a2;
	output out=variance sum=sumb suma;
run;

/*Calculate the standard errors and 95% confidence intervals for the 6
Deming regression slope and intercept estimates*/
data variance2; set variance;
	se_b=SQRT(sumb/&n);
	se_a=SQRT(suma/&n);
	t=TINV(.975,&n-1);
	b_lower= &b_est - TINV(.975,&n-1)* se_b;
	b_upper= &b_est + TINV(.975,&n-1)* se_b;
	a_lower= &a0_est - TINV(.975,&n-1)* se_a;
	a_upper= &a0_est + TINV(.975,&n-1)* se_a;
run;

%MEND DOIT;
