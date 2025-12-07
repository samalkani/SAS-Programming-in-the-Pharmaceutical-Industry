ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/cholesterol.rtf";
ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 4.pdf";

**** PROGRAM 4.1;
**** INPUT SAMPLE CHOLESTEROL DATA AS SDTM LB DOMAIN.;
data LB;
label USUBJID  = 'Unique Subject Identifier'
      LBDTC    = 'Date/Time of Specimen Collection'
      LBTESTCD = 'Lab Test or Examination Short Name'
      LBSTRESN = 'Numeric Result/Finding in Standard Units';
input USUBJID $ 1-3 LBDTC $ 5-14 LBTESTCD $ LBSTRESN; 
datalines;
101 2003-09-05 HDL  48
101 2003-09-05 LDL  188
101 2003-09-05 TRIG 108
101 2003-09-06 HDL  49
101 2003-09-06 LDL  185
101 2003-09-06 TRIG .
102 2003-10-01 HDL  54
102 2003-10-01 LDL  200
102 2003-10-01 TRIG 350
102 2003-10-02 HDL  52
102 2003-10-02 LDL  .
102 2003-10-02 TRIG 360
103 2003-11-10 HDL  .
103 2003-11-10 LDL  240
103 2003-11-10 TRIG 900
103 2003-11-11 HDL  30
103 2003-11-11 LDL  .
103 2003-11-11 TRIG 880
103 2003-11-12 HDL  32
103 2003-11-12 LDL  .
103 2003-11-12 TRIG .
103 2003-11-13 HDL  35
103 2003-11-13 LDL  289
103 2003-11-13 TRIG 930
; 
run;

proc print data=lb;
title 'INPUT SAMPLE CHOLESTEROL DATA AS SDTM LB DOMAIN';
RUN;
TITLE;


**** INPUT SAMPLE PILL DOSING DATA AS SDTM EX DOMAIN.;
data EX;
label USUBJID  = 'Unique Subject Identifier'
      EXSTDTC  = 'Start Date/Time of Treatment';
input USUBJID $ 1-3 EXSTDTC $ 5-14; 
datalines;
101 2003-09-07
102 2003-10-07
103 2003-11-13
;
run;

PROC PRINT DATA=ex;
TITLE 'INPUT SAMPLE PILL DOSING DATA AS SDTM EX DOMAIN';
RUN;
TITLE;


**** JOIN CHOLESTEROL AND DOSING DATA INTO ADLB ANALYSIS DATASET
**** AND CREATE WINDOWING VARIABLES;
proc sql;
    create table ADLB as
    select LB.USUBJID, LBDTC, LBTESTCD as PARAMCD, LBSTRESN as AVAL, 
           EXSTDTC, input(LBDTC,yymmdd10.) as ADT format=yymmdd10.,
           case
             when -5 <= (input(LBDTC,yymmdd10.) - input(EXSTDTC,yymmdd10.)) <= -1 and LBSTRESN ne . then 'YES'
             else 'NO'
           end as within5days
	from LB as LB, EX as EX
	where LB.USUBJID = EX.USUBJID
	order by USUBJID, LBTESTCD, within5days, ADT;
quit;

**** DEFINE ABLFL BASELINE FLAG;
data ADLB;
    set ADLB;
        by USUBJID PARAMCD within5days ADT;

        **** FLAG LAST RECORD WITHIN WINDOW AS BASELINE RECORD;
        if last.within5days and within5days='YES' then
            ABLFL = 'Y';

        label ABLFL    = 'Baseline Record Flag'
              PARAMCD  = 'Parameter Code'
              ADT      = 'Analysis Date'
              AVAL     = 'Analysis Value';

        drop within5days;
run;

proc sort
    data=ADLB;
        by USUBJID PARAMCD ADT;
run;


proc print data=adlb;
var usubjid paramcd aval adt exstdtc ablfl;
TITLE'ADLB data set ';
run;
title;

ods rtf close;


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Haemoglobin.rtf";
**** PROGRAM 4.3;
**** INPUT SAMPLE HEMOGLOBIN DATA AS SDTM LB DOMAIN.;
data LB;
label USUBJID  = 'Unique Subject Identifier'
      LBDTC    = 'Date/Time of Specimen Collection'
      LBTESTCD = 'Lab Test or Examination Short Name'
      LBSTRESN = 'Numeric Result/Finding in Standard Units';
input USUBJID $ 1-3 LBTESTCD $ 5-7 LBDTC $ 9-18 LBSTRESN; 
datalines;
101 HGB 2013-06-15 1.0
101 HGB 2013-06-16 1.1
101 HGB 2013-07-15 1.2
101 HGB 2013-07-21 1.3
101 HGB 2013-08-14 1.4
101 HGB 2013-08-16 1.5
101 HGB 2014-06-01 1.6
101 HGB 2014-06-25 1.7
101 HGB 2015-06-10 1.8
101 HGB 2015-06-15 1.9
;
run;

proc print data=LB;
title 'Unsorted LB data set';
run;
title;

**** INPUT SAMPLE DOSING DATA AS SDTM EX DOMAIN.;
data EX;
label USUBJID  = 'Unique Subject Identifier'
      EXSTDTC  = 'Start Date/Time of Treatment';
input USUBJID $ 1-3 EXSTDTC $ 5-14; 
datalines;
101 2013-06-17
;
run;

proc print data=EX;
title ' EX data set';
run;
title;

**** SORT LAB DATA FOR MERGE WITH DOSING;
proc sort
  data=lb;
    by usubjid;
run;

**** SORT DOSING DATA FOR MERGE WITH LABS.;
proc sort
  data=ex;
    by usubjid;
run;

**** FORMATS FOR DEFINING AWVISIT AND AWRANGE;
proc format;
  value avisit
    -1 = 'Baseline'
    30 = 'Month 1'
    60 = 'Month 2'
    365 = 'Year 1'
    730 = 'Year 2';
  value awrange
    -1  = 'Up to ADY -1     '
    30  = '25 <= ADY <= 35  '
    60  = '55 <= ADY <= 65  '
    365 = '350 <= ADY <= 380'
    730 = '715 <= ADY <= 745';
run; 

**** MERGE LAB DATA WITH DOSING DATE. CALCULATE STUDY DAY AND
**** DEFINE VISIT WINDOWS BASED ON STUDY DAY.;
data ADLB;
  merge lb(in = inlab)  
        ex(keep = usubjid exstdtc);
    by usubjid;
run;

proc print data=adlb;
title 'Merged EX and LB data sets to make ADLB data set';
run;
title;

data ADLB;    
    merge lb(in = inlab)  
        ex(keep = usubjid exstdtc);
    by usubjid;
**** KEEP RECORD IF IN LAB AND RESULT IS NOT MISSING.;
    if inlab and lbstresn ne .;      
    ADT = input(lbdtc,yymmdd10.);
    format ADT yymmdd10.;
    PARAMCD = lbtestcd;
    AVAL = lbstresn;

    **** CALCULATE STUDY DAY.;
    if adt < input(exstdtc,yymmdd10.) then
      ADY = adt - input(exstdtc,yymmdd10.);
    else if adt >= input(exstdtc,yymmdd10.) then
      ADY = adt - input(exstdtc,yymmdd10.) + 1;

    **** SET VISIT WINDOWS AND TARGET DAY AS THE MIDDLE OF THE 
         WINDOW.;
    if . < ady < 0 then
      AWTARGET = -1;
    else if 25 <= ady <= 35 then
      AWTARGET = 30;
    else if 55 <= ady <= 65 then
      AWTARGET = 60;
    else if 350 <= ady <= 380 then
      AWTARGET = 365;
    else if 715 <= ady <= 745 then
      AWTARGET = 730;

	  AWRANGE = left(put(awtarget,awrange.));
	  AVISIT = left(put(awtarget,avisit.));

    **** CALCULATE OBSERVATION DISTANCE FROM TARGET AND
    **** ABSOLUTE VALUE OF THAT DIFFERENCE.;
    AWTDIFF = abs(ady - awtarget);      
run;
title;

**** SORT DATA BY DECREASING ABSOLUTE DIFFERENCE AND ACTUAL 
**** DIFFERENCE WITHIN A VISIT WINDOW.;
proc sort
  data=ADLB;
    by USUBJID LBTESTCD AWTARGET AWTDIFF ADY;
run;

**** SELECT THE RECORD CLOSEST TO THE TARGET AS THE RECORD OF 
**** CHOICE TIES ON BOTH SIDES OF THE TARGET GO TO THE EARLIER 
**** OF THE TWO OBSERVATIONS.;
data adlb;
  set ADLB;
    by USUBJID LBTESTCD AWTARGET AWTDIFF ADY;

    if first.awtarget and awtarget ne . then
        ANL01FL = 'Y';          

    if avisit = 'DAY 0' and anl01fl = 'Y' then
        ABLFL = 'Y';

    keep USUBJID PARAMCD ADT EXSTDTC ADY AVISIT AWTARGET ADY
         AWTDIFF AWRANGE ANL01FL; 

    label ABLFL    = 'Baseline Record Flag'
          PARAMCD  = 'Parameter Code'
          ADT      = 'Analysis Date'
          AVAL     = 'Analysis Value'
          AWTARGET = 'Analysis Window Target'
          AWRANGE  = 'Analysis Window Valid Relative Range'
          AVISIT   = 'Analysis Visit'
          ADY      = 'Analysis Relative Day'
          AWTDIFF  = 'Analysis Window Diff from Target'
          ANL01FL  = 'Analysis Record Flag 01';
run;

proc sort
  data=ADLB;
    by USUBJID PARAMCD ADY;
run;





proc print data=adlb;
var usubjid paramcd adt exstdtc ady avisit awtarget ady awtdiff awrange anl01fl;
title1 'Modified ADLB dataset with the following variables';
title2 'ABLFL    = Baseline Record Flag; PARAMCD  = Parameter Code';
title3 'ADT      = Analysis Date; AVAL     = Analysis Value';
title4 'AWTARGET = Analysis Window Target';
title5 'AWRANGE  = Analysis Window Valid Relative Range';
title6 'AVISIT   = Analysis Visit';
title7 'ADY      = Analysis Relative Day';
title8'AWTDIFF  = Analysis Window Diff from Target';
title9'ANL01FL  = Analysis Record Flag 01'; 
run;
title;

ods rtf close;

**** PROGRAM 4.4;
**** INPUT SAMPLE SYSTOLIC BLOOD PRESSURE VALUES AS SDTM VS 
     DOMAIN.;
data VS;
label USUBJID  = 'Unique Subject Identifier'
      VSTESTCD = 'Vitals Signs Test Short Name'
      VISITNUM = 'Visit Number'
      VSSTRESN = 'Numeric Result/Finding in Standard Units';
input USUBJID $ 1-3 VSTESTCD $ 5-7 VISITNUM VSSTRESN; 
datalines;
101 SBP 1 160
101 SBP 2 150
101 SBP 3 140
101 SBP 4 130
101 SBP 5 120
202 SBP 1 141
202 SBP 2 151
202 SBP 3 161
202 SBP 4 171
202 SBP 5 181
;
run;

proc print data=vs;
title 'Input sample systolic blood pressure (SBP) values as SDTM VS domain';
run;
title;

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE;
proc transpose
  data=vs
  out=sbpflat
  prefix=VISIT;
    by usubjid;
	id visitnum;
    var vsstresn;
run;

proc print data=sbpflat;
title 'De-normalize, Normalized SBP values to a flat structure for statistical modelling ';
run;
title;

**** PROGRAM 4.5;
**** INPUT SAMPLE SYSTOLIC BLOOD PRESSURE VALUES AS SDTM VS 
     DOMAIN.;
data VS1;
label USUBJID  = 'Unique Subject Identifier'
      VSTESTCD = 'Vitals Signs Test Short Name'
      VISITNUM = 'Visit Number'
      VSSTRESN = 'Numeric Result/Finding in Standard Units';
input USUBJID $ 1-3 VSTESTCD $ 5-7 VISITNUM VSSTRESN; 
datalines;
101 SBP 1 160
101 SBP 3 140
101 SBP 4 130
101 SBP 5 120
202 SBP 1 141
202 SBP 2 151
202 SBP 3 161
202 SBP 4 171
202 SBP 5 181
;
run;

proc print data=vs1;
title 'Input sample systolic blood pressure (SBP) values as SDTM VS domain & missing values';
run;
title;


**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE;
proc transpose
  data=vs1
  out=sbpflat
  prefix=VISIT;
    by usubjid;
    var vsstresn;
run;

proc print data=sbpflat;
title 'De-normalize, Normalized SBP values to a flat structure for statistical modelling without ID statement';
run;
title;

**** TRANSPOSE THE NORMALIZED SBP VALUES TO A FLAT STRUCTURE;
proc transpose
  data=vs1
  out=sbpflat
  prefix=VISIT;
    by usubjid;
    id visitnum;
    var vsstresn;
run;

proc print data=sbpflat;
title 'De-normalize, Normalized SBP values to a flat structure for statistical modelling with ID statement';
run;
title;


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Death_Analysis.rtf";
**** PROGRAM 4.7;
**** DEATH ANALYSIS DATASET ADDEATH;
data ADDEATH;
label USUBJID  = 'Unique Subject Identifier'
      TRTP     = 'Planned Treatment'
      PARAM    = 'Parameter'
      AVAL     = 'Analysis Value';
PARAM = 'Subject Died';
input USUBJID $ AVAL TRTP $ @@;
datalines;
101 0 a 102 0 b 103 1 a 104 0 b 105 1 a 106 0 b 107 1 a 108 0 b
109 1 a 110 1 b 111 1 a 112 1 b 113 0 a 114 0 b 115 1 a 116 0 b
117 1 a 118 0 b 119 1 a 120 1 b 121 1 a 122 1 b 123 1 a 124 1 b
125 1 a 126 0 b 127 1 a 128 0 b 129 1 a 130 0 b 131 1 a 132 1 b
133 1 a 134 1 b 135 1 a 136 1 b 137 1 a 138 1 b 139 1 a 140 1 b
201 0 b 202 1 a 203 0 b 204 0 a 205 1 b 206 0 a 207 1 b 208 1 a
209 1 b 210 1 a 211 1 b 212 1 a 213 0 b 214 1 a 215 0 b 216 0 a
217 1 b 218 0 a 219 1 b 220 1 a 221 1 b 222 1 a 223 1 b 224 1 a
225 0 b 226 1 a 227 0 b 228 0 a 229 1 b 230 0 a 231 1 b 232 1 a
233 1 b 234 1 a 235 1 b 236 1 a 237 0 b 238 1 a 239 0 b 240 0 a
;
run;


proc freq;
tables aval*trtp /norow nocol chisq;
title1'Two-Way frequency table of the variables AVAL TRTP';
title2'AVAL = analysis value 0= pt lived 1= pt died';
title3'TRTP = Planned Treatment';
run;
title;
ods rtf close;


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Death_Analysis_unk.rtf";
**** PROGRAM 4.8;
**** DEATH ANALYSIS DATASET ADDEATH;
data ADDEATH;
label USUBJID  = 'Unique Subject Identifier'
      TRTP     = 'Planned Treatment'
      PARAM    = 'Parameter'
      AVAL     = 'Analysis Value';
PARAM = 'Subject Died';
input USUBJID $ AVAL TRTP $ @@;
datalines;
101 0 a 102 . b 103 1 a 104 . b 105 1 a 106 . b 107 1 a 108 . b
109 1 a 110 1 b 111 1 a 112 1 b 113 0 a 114 0 b 115 1 a 116 0 b
117 1 a 118 0 b 119 1 a 120 1 b 121 1 a 122 1 b 123 1 a 124 1 b
125 1 a 126 0 b 127 1 a 128 0 b 129 1 a 130 0 b 131 1 a 132 1 b
133 1 a 134 1 b 135 1 a 136 1 b 137 1 a 138 1 b 139 1 a 140 1 b
201 0 b 202 1 a 203 0 b 204 0 a 205 1 b 206 0 a 207 1 b 208 1 a
209 1 b 210 1 a 211 1 b 212 1 a 213 0 b 214 1 a 215 0 b 216 0 a
217 1 b 218 0 a 219 1 b 220 1 a 221 1 b 222 1 a 223 1 b 224 1 a
225 0 b 226 1 a 227 0 b 228 0 a 229 1 b 230 0 a 231 1 b 232 1 a
233 1 b 234 1 a 235 1 b 236 1 a 237 0 b 238 1 a 239 0 b 240 0 a
;
run;


proc freq;
tables aval*trtp /norow nocol chisq;
title1'Two-Way frequency table of the variables AVAL TRTP';
title2'AVAL = analysis value unknown= pt lived 1= pt died';
title3'TRTP = Planned Treatment';
run;

ods rtf close;

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Adverse_event_med.rtf";
**** PROGRAM 4.9;
**** INPUT SAMPLE SDTM AE DOMAIN.;
data AE;
label USUBJID = 'Unique Subject Identifier'
      AESTDTC = 'Start Date/Time of Adverse Event'
      AEENDTC = 'End Date/Time of Adverse Event'
      AETERM = 'Reported Term for the Adverse Event';
input USUBJID $ 1-3 AESTDTC $ 5-14 AEENDTC $ 16-25 AETERM $15.;
datalines;
101 2004-01-01 2004-01-02 Headache
101 2004-01-15 2004-02-03 Back Pain
102 2003-11-03 2003-12-10 Rash
102 2004-01-03 2004-01-10 Abdominal Pain
102 2004-04-04 2004-04-04 Constipation
;
run;

proc print data=AE;
title'Adverse event (AE) data set';
run;
title;

**** INPUT SAMPLE SDTM CM DOMAIN.;
data CM;
label USUBJID = 'Unique Subject Identifier'
      CMSTDTC = 'Start Date/Time of Medication'
      CMENDTC = 'End Date/Time of Medication'
      CMTRT   = 'Reported Name of Drug, Med, or Therapy';
input USUBJID $ 1-3 CMSTDTC $ 5-14 CMENDTC $ 16-25 CMTRT $21.;
datalines;
101 2004-01-01 2004-01-01 Acetaminophen
101 2003-10-20 2004-03-20 Tylenol w/ Codeine
101 2003-12-12 2003-12-12 Sudaphed
102 2003-12-07 2003-12-18 Hydrocortizone Cream
102 2004-01-06 2004-01-08 Simethicone
102 2004-01-09 2004-03-10 Esomeprazole
;
run;

proc print data=CM;
title'Concomitant Medication (CM) data set';
run;
title;

**** MERGE CONCOMITANT MEDICATIONS WITH ADVERSE EVENTS;
proc sql;
	create table ae_meds as
	select a.usubjid, a.aestdtc, a.aeendtc, a.aeterm,
	       c.cmstdtc, c.cmendtc, c.cmtrt from
		   ae as a  left join cm as c
	on (a.usubjid = c.usubjid) and
	   ((a.aestdtc <= c.cmstdtc <= a.aeendtc) or
	    (a.aestdtc <= c.cmendtc <= a.aeendtc) or
        ((c.cmstdtc < a.aestdtc) and (a.aeendtc < c.cmendtc)));
quit;



proc print data=ae_meds;
var usubjid aestdtc aeendtc aeterm cmstdtc cmendtc cmtrt;
title'Merged AE and CM datasets';
run;
title;

ods rtf close;
/*
**** PROGRAM 4.10;
**** SORT LOW LEVEL TERM DATA FROM MEDDRA WHERE
**** LOW_LEVEL_TERM = LOWEST LEVEL TERM, LLT_CODE = LOWEST
**** LEVEL TERM CODE, AND PT_CODE = PREFERRED TERM CODE.;
proc sort
   data = low_level_term(keep = low_level_term llt_code 
          pt_code);
      by pt_code;
run;  

**** SORT PREFERRED TERM DATA FROM MEDDRA WHERE
**** PREFERRED_TERM = PREFERRED TERM, SOC_CODE = SYSTEM
**** ORGAN CLASS CODE, AND PT_CODE = PREFERRED TERM CODE.; 
proc sort
   data = preferred_term(keep = preferred_term pt_code soc_code);
      by pt_code;
run;

**** MERGE LOW LEVEL TERMS WITH PREFERRED TERMS KEEPING ALL LOWER 
**** LEVEL TERM RECORDS.;
data llt_pt;
   merge low_level_term (in = inlow)
         preferred_term;
      by pt_code;

      if inlow;
run;

**** SORT BODY SYSTEM DATA FROM MEDDRA WHERE
**** SYSTEM_CLASS_TERM = SYSTEM ORGAN CLASS TERM AND SOC_CODE =
**** SYSTEM ORGAN CLASS CODE.; 
proc sort
   data = soc_term(keep = system_class_term soc_code);
      by soc_code;
run;

**** SORT LOWER LEVEL TERM AND PREFERRED TERMS FOR MERGE WITH
**** SYSTEM ORGAN CLASS DATA.;
proc sort
   data = llt_pt;
      by soc_code;
run;

 
**** MERGE PREFERRED TERM LEVEL WITH BODY SYSTEMS;
data meddra;
   merge llt_pt (in = in_llt_pt)
         soc_term;
      by soc_code;

      if in_llt_pt;
run;

**** PROGRAM 4.11;
/*
proc sort
   data = whodrug(keep = seq1 seq2 drug_name drugrecno
                  where = (seq1 = '01' and seq2 = '001') )
          nodupkey;/* deletes duplicate values in the BY variable 
      by drugrecno drug_name;
run;
*/

**** PROGRAM 4.12;
proc options option=yearcutoff;
run;

**** IMPLICIT CENTURY;
data _null_;
  date = "01JAN19"d;
  put date=date9.;
  date = "01JAN20"d;
  put date=date9.;
run;

**** EXPLICIT CENTURY;
data _null_;
  date = "01JAN1919"d;
  put date=date9.;
  date = "01JAN1920"d;
  put date=date9.;
run;


**** PROGRAM 4.13;
**** INPUT SAMPLE ADVERSE EVENT DATA;
data AE;
input @1 USUBJID $3.
      @5 AETERM $15.;
datalines;
101 Headache
102 Rash
102 Fatal MI
102 Abdominal Pain
102 Constipation
;
run; 

proc print data=AE;
title 'AE data set';
run;
title;

**** INPUT SAMPLE DEATH DATA FLAG WHERE 
**** DEATHFL = 1 IF PATIENT DIED AND 0 IF NOT.;
data ADSL;
input @1 USUBJID $3. 
      @5 DEATHFL 1.;
datalines;
101 0
102 0
;
run;

proc print data=ADSL;
title'ADSL data set';
run;
title;


**** SET DEATH = 1 FOR PATIENTS WHO HAD ADVERSE EVENTS THAT
**** RESULTED IN DEATH.;
data ADDEATH;
  merge adsl ae;
    by usubjid;

    if aeterm="Fatal MI" then
      DEATHFL = 1;
run;



proc print
data=addeath;
var usubjid aeterm deathfl;
title'Addeath data set';
run;
title;

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Adverse_event_death.rtf";
**** PROGRAM 4.14;
**** INPUT SAMPLE ADVERSE EVENT DATA;
data AE;
input @1 USUBJID $3.
      @5 AETERM $15.;
datalines;
101 Headache
102 Rash
102 Fatal MI
102 Abdominal Pain
102 Constipation
;
run; 

proc print data=AE;
title 'AE data set';
run;
title;

**** INPUT SAMPLE DEATH DATA FLAG WHERE 
**** DEATHFL = 1 IF PATIENT DIED AND 0 IF NOT.;
data ADSL;
input @1 USUBJID $3. 
      @5 DEATHFL 1.;
datalines;
101 0
102 0
;
run;

proc print data=ADSL;
title 'ADSL data set';
run;
title;


**** SET DEATH = 1 FOR PATIENTS WHO HAD ADVERSE EVENTS THAT
**** RESULTED IN DEATH.;
data addeath;
  merge adsl(rename=(deathfl=_deathfl)) ae;
    by usubjid;

    drop _deathfl;

    if aeterm="Fatal MI" then
      DEATHFL = 1;
    else
      DEATHFL = _deathfl;
run;




proc print
data=addeath;
var usubjid aeterm deathfl;
title 'Addeath data set';
run;
title;
ods rtf close;


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/BP_change_from_Base.rtf";
**** PROGRAM 4.16;
**** BLOOD PRESSURE VALUES BY SUBJECT, VISIT AND TEST; 
data VS;
label USUBJID  = 'Unique Subject Identifier'
      VSTESTCD = 'Vitals Signs Test Short Name'
      VSSTRESN = 'Numeric Result/Finding in Standard Units';
input USUBJID $ VISITNUM VSTESTCD $ VSSTRESN; 
datalines;
101 0 DBP 160
101 0 SBP  90
101 1 DBP 140
101 1 SBP  87
101 2 DBP 130
101 2 SBP  85
101 3 DBP 120
101 3 SBP  80
202 0 DBP 141
202 0 SBP  75
202 1 DBP 161
202 1 SBP  80
202 2 DBP 171
202 2 SBP  85
202 3 DBP 181
202 3 SBP  90
;
run;

proc print data=VS;
title'Vital signs - Diastolic / Systolic BP data set';
run;
title;

**** SORT DATA BY SUBJECT, TEST NAME, AND VISIT; 
proc sort
  data=vs;
    by usubjid vstestcd visitnum;
run;

proc print data=VS label;
title'Sorted - Vital signs - Diastolic / Systolic BP data set';
run;
title;


**** CALCULATE CHANGE FROM BASELINE VALUES;   
data ADVS;                           
  set vs;
    by usubjid vstestcd visitnum;

    **** COPY SDTM CONTENT INTO BDS VARIABLES;       
    AVAL = vsstresn;
    PARAMCD = vstestcd;
    AVISITN = visitnum;

    **** INITIALIZE BASELINE TO MISSING;
    retain BASE;
    if first.vstestcd then
      BASE = .;
	    
    **** DETERMINE BASELINE AND CALCULATE CHANGES; 
    if avisitn = 0 then
      do;
        ABLFL = 'Y';
        BASE = aval;
      end;
    else if avisitn > 0 then
      do;
        CHG = aval - base;
        PCHG = ((aval - base) / base) * 100;
      end;

    label AVISITN = 'Analysis Visit (N)'
          ABLFL   = 'Baseline Record Flag'
          PARAMCD = 'Parameter Code'
          AVAL    = 'Analysis Value'
          BASE    = 'Baseline Value'
          CHG     = 'Change from Baseline'
          PCHG    = 'Percent Change from Baseline';
run;



proc print
  data=advs;
  var usubjid avisitn paramcd aval ablfl base chg pchg;
  title 'ADVS dataset - Change from baseline BP (visit0) & % change from baseline';
run;
title;
ods rtf close;

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Time_to_Event.rtf";
**** PROGRAM 4.17;
**** INPUT SAMPLE SEIZURE DATA AS SDTM CLINICAL EVENTS DOMAIN;
data CE;                                                                                                                  
label USUBJID  = 'Unique Subject Identifier'
      CETERM   = 'Reported Term for the Clinical Event'
      CEPRESP  = 'Clinical Event Pre-Specified'
      CEOCCUR  = 'Clinical Event Occurrence'
      CESTDTC  = 'Start Date/Time of Clinical Event';
CETERM = 'Seizure';
CEPRESP = 'Y';
input USUBJID $ 1-3 CEOCCUR $ 5 CESTDTC $ 7-16; 
datalines;
101 Y 2004-05-05
102 N           
103             
104 Y 2004-06-07
;
run;

proc print data=CE;
title'CE data set - SDTM Clinical events domain';
run;
title;

**** INPUT SAMPLE END OF STUDY DATE AS SDTM 
**** DEMOGRAPHICS DOMAIN;
data DM;
label USUBJID = 'Unique Subject Identifier'
      RFENDTC = 'Subject Reference End Date/Time';
input USUBJID $ 1-3 RFENDTC $ 5-14; 
datalines;
101 2004-08-05
102 2004-08-10
103 2004-08-12
104 2004-08-20
;
run;

proc print data=DM;
title'DM data set - SDTM demographics Domain';
run;
title;

**** INPUT SAMPLE DOSING DATA AS SDTM EXPOSURE DOMAIN;
data EX;
label USUBJID = "Unique Subject Identifier"
      EXSTDTC = "Start Date/Time of Treatment";
input USUBJID $ 1-3 EXSTDTC $ 5-14; 
datalines;
101 2004-01-01
102 2004-01-03
103 2004-01-06
104 2004-01-09
;
run;

proc print data=EX;
title'EX data set - STDM Drug Exposure Domain';
run;
title;
 
**** CREATE TIME TO SEIZURE ANALYSIS DATASET
**** AS CDISC ADAM BASIC DATA STRUCTURE TIME TO EVENT;
data ADSEIZ;                                         
   merge dm ex ce;
      by usubjid;

      PARAM = 'Time to Seizure (days)';

      if ceterm = 'Seizure' and ceoccur = 'Y' then
        do;
          AVAL = input(cestdtc,yymmdd10.) -
                 input(exstdtc,yymmdd10.) + 1;
          CNSR =  0;
          ADT = input(cestdtc,yymmdd10.);
        end;
      else if ceterm = 'Seizure' and ceoccur = 'N' then
        do;
          AVAL = input(rfendtc,yymmdd10.) -
                 input(exstdtc,yymmdd10.) + 1;
          CNSR = 1;
	  ADT = input(rfendtc,yymmdd10.);
        end;

      label PARAM = 'Time to Seizure (days)'
            AVAL  = 'Analysis Value'
            ADT   = 'Analysis Date'
            CNSR  = 'Censor';
      format ADT date9.;
run;


proc print
  data=adseiz;
  var usubjid param aval cnsr adt rfendtc exstdtc ceterm cepresp ceoccur cestdtc;
  title'Adseiz data set - CDISC ADaM Basic Data Structure Time to Event';
run;
title;

ods rtf close;
ods pdf close;


