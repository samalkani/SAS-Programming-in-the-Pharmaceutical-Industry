ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 1.pdf";

**** PROGRAM 2.2;
data AE;
input USUBJID $ 1-7 AETERM $ 9-41;
datalines;
100-101 HEDACHE
100-105 HEADACHE
100-110 MYOCARDIAL INFARCTION
200-004 MI
300-023 BROKEN LEG
400-010 HIVES
500-001 LIGHTHEADEDNESS/FACIAL LACERATION
;
run;

proc print data=AE;
title'Adverse event data';
run;
title;

/* Frequency Procedure */

proc freq 
   data = ae;
   tables aeterm;
   title 'Frequency of categorical variable AE-TERM';
run;
title;

**** PROGRAM 2.3;
data ae1;
label USUBJID  = "Unique Subject Identifier"
      AEPTCD   = "Preferred Term Code"
      AETERM   = "Reported Term for the Adverse Event"
      AEDECOD  = "Dictionary-Derived Term";
input USUBJID $ 1-7 AEPTCD $ 9-16  
      AETERM $ 18-38 AEDECOD $ 40-60; /* converted numeric to string (character variables) the length of each 
      									variable has taken into account the length of the previous variable */
datalines; /* recoding the Adverse event data by adding another column with the corrected term */
100-101 10019211 HEDACHE               HEADACHE 
100-105 10019211 HEADACHE              HEADACHE
100-110 10028596 MYOCARDIAL INFARCTION MYOCARDIAL INFARCTION
200-004 10028596 MI                    MYOCARDIAL INFARCTION
300-023 10061599 BROKEN LEG            LOWER LIMB FRACTURE
400-010 10046735 HIVES                 URTICARIA
500-001 10013573 LIGHTHEADEDNESS       DIZZINESS
500-001 10058818 FACIAL LACERATION     SKIN LACERATION
;
run;

proc print data=ae1 label;
title'Modified Adverse event data';
run;
title;

proc freq
   data = ae1;
   tables aedecod;
run;

ods pdf close;