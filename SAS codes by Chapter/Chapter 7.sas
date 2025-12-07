%let path=/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code; 
libname Pharma "&path";

ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 7.pdf";

/* Descriptive (Summary) statistics */

proc print data=pharma.dm;
title'dm data set';
run;
title;

proc sort data=pharma.dm;
by armcd;
run;

proc print data=pharma.dm;
title'sorted dm data set';
run;
title;


proc freq data=pharma.dm;
		by armcd;
		tables sex*race / out=pharma.freqs outpct;
run;

proc print data=pharma.freqs;
title'freqs data set';
run;
title;

ods output CrossTabFreqs = pharma.freqs1;
proc freq data=pharma.dm;
		by armcd;
		tables sex*race  ;
run;
ods output close;

proc print data=pharma.freqs1;
title'freqs1 data set';
run;
title;

PROC UNIVARIATE DATA = PHARMA.DM ;
		BY ARMCD;
		VAR AGE;
		OUTPUT OUT= PHARMA.SUMSTAT MEAN=AGEMEAN MEDIAN=AGEMEDIAN KURTOSIS=AGEKURTOSIS 
					SKEWNESS=AGESKEWNESS MIN=AGEMIN MAX=AGEMAX;
RUN;

/* One sample t-test comparing observed mean with hypothesized mean */

PROC PRINT DATA=PHARMA.SUMSTAT;
TITLE 'PHARMA.SUMSTAT DATA SET';
RUN;
TITLE;

data pharma.time;
   input time @@;
   datalines;
 43  90  84  87  116   95  86   99   93  92
121  71  66  98   79  102  60  112  105  98
;

ods output TTests = pharma.time;
proc ttest h0=189.85 ;
   var time;
run;
ods output close;

proc contents data=pharma.time;
run;

ods output TestsForLocation = pharma.time;
Proc univariate mu0 = 80;
	var time;
Run;
ods output close;

libname statdata "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"; 
libname library "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code";

proc print data=statdata.german;
title'German data set';
run;
title;

/* Two-Sample paired t-test without change from baseline variable*/

ods output TTests = pvalue;

proc ttest data=statdata.german;
	paired pre * retain;
run;

ods output close;

proc print data=pvalue;
title'Two-sample paired t-test without change from baseline variable';
run;
title;

/* Two-sample paired t-test with change from baseline variable included*/

ods output Equality = statdata.variancetest;
ods output TTests = statdata.pvalue;
proc ttest data=statdata.german;
class Group;
   var Change;
   title 'German Training, Comparing Treatment to Control';   
   title2 'One-Sided two-sample t-Test';
run;
title;
ods output close;

******CHECK VARIANCE AND SELECT PROPER P-VALUE;

data pvalue;
	if _n_ = 1 then
		set statdata.variancetest(keep = probf);
	set statdata.pvalue(keep = variances probt);
	keep probt;
	if (probf <= 0.05 and variances = 'Unequal') or
	    (probf > 0.05 and variances = 'equal');
run;

proc print data=statdata.pvalue;
title 'pvalue data set';
run;
title;


proc print data=statdata.variancetest;
title'Test of equal mean variances';
run;
title;

proc print data=statdata.pvalue;
title'Test for unequal variances';
run;
title;

proc npar1way data=statdata.german
		wilcoxon;
		class Group;
		var Change;
		output out = pvalue wilcoxon;
run;

proc print data=pvalue;
title'pvalue data set';
run;
title;

libname statdata "/home/ajay_malkani0/EST142/data"; 
libname library "/home/ajay_malkani0/EST142/data";

/* One-Way ANOVA using proc glm */

proc glm data=statdata.german plots(only)=diagnostics(unpack);
   class Group;
   model Change=Group;
   means Group / hovtest;
   title 'Testing for Equality of Treatment Group on Change using PROC GLM';
run;
quit;
title;

/* One-Way ANOVA */
proc glm data = statdata.german
		outstat = pvalue;
		class Group;
		model Change=Group;
run;
quit;

proc print data=pvalue;
title'pvalue data set - One-Way ANOVA';
run;
title;

/* Kruskal-Wallis test */
proc npar1way data=statdata.german
		wilcoxon;
		class Group;
		var Change;
		output out = pvalue1 wilcoxon;
run;

proc print data=pvalue1;
title'pvalue1 data set - non-normal distribution of errors, use of Kruskal-Wallis test P_KW';
run;
title;

/* Two-Way ANOVA using proc glm */

proc glm data=statdata.german plots(only)=diagnostics(unpack);
   class Group Gender;
   model Change=Group Gender;
   lsmeans Gender / pdiff=all adjust=tukey;
   title1 'Testing for Equality of Treatment group against Gender on Change using PROC GLM';
   title2 'Two Way ANOVA';
run;
quit;
title;

/* Two-Way ANOVA */
proc glm data = statdata.german
		outstat = pvalue;
		class Group Gender;
		model Change=Group Gender;
run;
quit;

proc print data=pvalue;
title'pvalue data set - Two-Way ANOVA';
run;
title;

/* Kruskal-Wallis test */
proc npar1way data=statdata.german
		wilcoxon;
		class Gender;
		var Change;
		output out = pvalue1 wilcoxon;
run;

proc print data=pvalue1;
title1'pvalue1 data set - non-normal distribution of errors, use of Kruskal-Wallis test P_KW';
title2'Two-Way ANOVA';
run;
title;

ods pdf close;


