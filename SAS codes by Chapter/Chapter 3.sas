%let path=/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code; 
libname Pharma "&path";

ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 3.pdf";

FILENAME REFFILE '/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/normal_ranges.txt';

PROC IMPORT DATAFILE=REFFILE replace /* replace overwites previous versions of the SAS data file */
	DBMS=DLM
	OUT=Pharma.normal_ranges;
	DELIMITER="|";
	GETNAMES=YES;
	DATAROW=2; /* Read data in the second row always with a proc import step */
RUN;

PROC CONTENTS DATA=Pharma.normal_ranges;
title 'Normal Ranges proc contents procedure';
RUN;
title;

proc print data=Pharma.normal_ranges;
title 'Normal Laboratory Ranges data set';
run;
title;

**** PROGRAM 3.5;
proc format;
	value $gender "F" = "Female"
	              "M" = "Male";
run;
 
data Pharma.labnorm;
	infile '/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/normal_ranges.txt' delimiter = '|' DSD MISSOVER firstobs=2;

    informat Lab_Test $20. /* reading the ASCII file variable Lab_test 20 characters deep */
             Units $9. 
             Gender $1. ;

	format Lab_Test $20. /* Using format statement to make the Lab_test variable column 20 characters wide */
    	   Units $9. 
           Gender $gender.; /* Adjusting the appearance of the gender format from F to Female e.t.c. */

	input  Lab_Test $ /*Listing the variables in the order they appear in the ASCII file $=Character variable*/
           Units $
           Gender $
           Low_Age
           High_Age
           Low_Normal
           High_Normal;


	label Lab_Test    = "Laboratory Test" /* Altering the variable names */
	      Units       = "Lab Units"
  	      Gender      = "Gender"
	      Low_Age     = "Lower Age Range"
	      High_Age    = "Higher Age Range"
	      Low_Normal  = "Low Normal Lab Value Range"
	      High_Normal = "High Normal Lab Value Range";
run;

proc print data=Pharma.labnorm label;
title 'Normal Laboratory Ranges data set using a data step';
run;
title;

/*
**** PROGRAM 3.6;
libname  Pharma server=pcfiles path= "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/normal_ranges.xls";

pcfiles server engine not available on this program 

proc contents 
   data = xlsfile._all_;
run;
  	
proc print 
   data = XLSFILE.'normal_ranges$'n;
run;

*/

%let path=/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code; 
libname Pharma "&path";

FILENAME REFFILE '/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/normal_ranges1.xls';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLS REPLACE
	OUT=Pharma.normal_ranges1xls;
	GETNAMES=YES;
	MIXED=NO;
RUN;


PROC CONTENTS DATA=Pharma.normal_ranges1xls VARNUM;
RUN;

proc print data=Pharma.normal_ranges1xls LABEL;
title 'Normal Laboratory Ranges Data set from MSEXCEL';
run;
title;

ods pdf close;



