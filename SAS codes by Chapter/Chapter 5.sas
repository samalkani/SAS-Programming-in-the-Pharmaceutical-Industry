ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics.rtf";
ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 5.pdf";
ods html file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 5.html";

**** PROGRAM 5.1;
**** INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL;
data ADSL;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)"
      SEXN    = "Sex (N)"
      RACEN   = "Race (N)"
      AGE     = "Age";
input USUBJID $ TRTPN SEXN RACEN AGE @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
run;

proc print data=ADSL;
TITLE1  j=l 'Company / Trial Name'
	    j=r 'Page 1 of 2';
TITLE2  j=c 'INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL';
RUN;
TITLE; 

**** DEFINE VARIABLE FORMATS NEEDED FOR TABLE;
proc format;
   value trtpn
      1 = "Active"
      0 = "Placebo"; 
   value sexn
      . = "Missing"
      1 = "Male"
      2 = "Female";
   value racen
      1 = "White"
      2 = "Black"
      3 = "Other*";
run;

**** CREATE SUMMARY OF DEMOGRAPHICS WITH PROC TABULATE;
options nodate nonumber missing = ' ';
ods escapechar='#';

proc tabulate
   data = adsl
   missing;

   class trtpn sexn racen;
   var age;
   table age = 'Age' * (n = 'n' * f = 8. mean = 'Mean' * f = 5.1 
   						Median = 'Median' * f = 3.
                        std = 'Standard Deviation' * f = 5.1
                        min = 'Min' * f = 3. Max = 'Max' * f = 3. 
                        Mode = 'Mode' * f = 3.)
         sexn = 'Sex' * (n = 'n' * f = 3. colpctn = '%' * f = 4.1)
         racen = 'Race' * (n = 'n' * f = 3. colpctn = '%' * f = 4.1),
		(trtpn = "  ") (all = 'Overall');

   format trtpn trtpn. racen racen. sexn sexn.;

   title1 j=l 'Company/Trial Name' 
          j=r 'Page 2 of 2';
   title2 j=c 'Table 5.1';
   title3 j=c 'Demographics and Baseline Characteristics';
   footnote1 j=l '* Other includes Asian, Native American, and other'
                 ' races.';
   footnote2 j=l "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run; 

ods rtf close;


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics1.rtf";
**** PROGRAM 5.2;
**** INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL;
data ADSL;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)"
      SEXN    = "Sex (N)"
      RACEN   = "Race (N)"
      AGE     = "Age";
input USUBJID $ TRTPN SEXN RACEN AGE @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
 

**** DEFINE VARIABLE FORMATS NEEDED FOR TABLE;
proc format;
   value trtpn
      1 = "Active"
      0 = "Placebo"; 
   value sexn
      . = "Missing"
      1 = "Male"
      2 = "Female";
   value racen
      1 = "White"
      2 = "Black"
      3 = "Other*";
run;

**** CREATE SUMMARY OF DEMOGRAPHICS WITH PROC REPORT;
options nodate nonumber missing = ' ';
ods escapechar='#';


**** CREATE SUMMARY OF DEMOGRAPHICS WITH PROC TABULATE;
proc report
   data = adsl
   nowindows
   missing 
   headline;

   column ( trtpn,
          ( ("Age" 
             age = agen age = agemean age = agestd age = agemin
             age = agemax)
             sexn,(sexn = sexnn sexnpct) 
             racen,(racen = racenn racenpct)));       
                                                             
   define trtpn    /across format = trtpn. "  ";                         
   define agen     /analysis n format = 3. 'N';
   define agemean  /analysis mean format = 5.3 'Mean';
   define agestd   /analysis std format = 5.3 'SD';
   define agemin   /analysis min format = 3. 'Min';
   define agemax   /analysis max format = 3. 'Max';

   define sexn     /across "Sex" format = sexn.;         
   define sexnn    /analysis n format = 3. 'N';                    
   define sexnpct  /computed format = percent5. '(%)';           
   define racen    /across "Race" format = racen.;                    
   define racenn   /analysis n format = 3. width = 6 'N';                    
   define racenpct /computed format = percent5. '(%)';           

   compute before;                                              
   totga = sum(_c6_,_c8_,_c10_);                                              
   totgp = sum(_c23_,_c25_,_c27_);                                              
   totra = sum(_c12_,_c14_,_c16_);                                              
   totrp = sum(_c29_,_c31_,_c33_);                                              
   endcomp;                                                     
   compute sexnpct;                                           
   _c7_ = _c6_ / totga;                                              
   _c9_ = _c8_ / totga;                                              
   _c11_ = _c10_ / totga;                                              
   _c24_ = _c23_ / totgp;                                              
   _c26_ = _c25_ / totgp;                                              
   _c28_ = _c27_ / totgp;                                              
   endcomp;                   
   compute racenpct;                                           
   _c13_ = _c12_ / totra;                                              
   _c15_ = _c14_ / totra;                                              
   _c17_ = _c16_ / totra;                                              
   _c30_ = _c29_ / totrp;                                              
   _c32_ = _c31_ / totrp;                                              
   _c34_ = _c33_ / totrp;                                              
   endcomp;        

   title1 j=l 'Company/Trial Name' 
          j=r 'Page #{thispage} of #{lastpage}';
   title2 j=c 'Table 5.1';
   title3 j=c 'Demographics and Baseline Characteristics';
   footnote1 j=l '* Other includes Asian, Native American, and other'
                 ' races.';
   footnote2 j=l "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run; 
ods rtf close;   


ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics2.rtf";
**** PROGRAM 5.3;
**** INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL;
data ADSL;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)"
      SEXN    = "Sex (N)"
      RACEN   = "Race (N)"
      AGE     = "Age";
input USUBJID $ TRTPN SEXN RACEN AGE @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
run;

proc print data=ADSL;
title 'INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL';
run;
title;
 
**** DEFINE VARIABLE FORMATS NEEDED FOR TABLE;
proc format;
   value trtpn
      1 = "Active"
      0 = "Placebo"; 
   value sexn
      . = "Missing"
      1 = "Male"
      2 = "Female";
   value racen
      1 = "White"
      2 = "Black"
      3 = "Other*";
run;

**** DUPLICATE THE INCOMING DATASET FOR OVERALL COLUMN CALCULATIONS SO
**** NOW TRT HAS VALUES 0 = PLACEBO, 1 = ACTIVE, AND 2 = OVERALL.;
data adsl1;
   set adsl;
   output;
   trtpn = 2;
   output;
run;

proc print data=adsl1;
title ' ADSL data set with TRT HAS VALUES 0 = PLACEBO, 1 = ACTIVE, AND 2 = OVERALL';
run;
title;

**** AGE STATISTICS PROGRAMMING ************************************;
**** GET P VALUE FROM NON PARAMETRIC COMPARISON OF AGE MEANS.;
proc npar1way 
   data = adsl1
   wilcoxon 
   noprint;
      where trtpn in (0,1);
      class trtpn;
      var age;
      output out=pvalue wilcoxon;
run;

proc sort 
   data=adsl1;
      by trtpn;
run;

proc print data=adsl1;
title 'Sorted ADSL1 data set';
run;
title;
 
***** GET AGE DESCRIPTIVE STATISTICS N, MEAN, STD, MIN, AND MAX.;
proc univariate 
   data = adsl1 noprint;
      by trtpn;

      var age;
      output out = age 
             n = _n mean = _mean std = _std min = _min max = _max;
run;

**** FORMAT AGE DESCRIPTIVE STATISTICS FOR THE TABLE.;
data age;
   set age;

   format n mean std min max $14.;
   drop _n _mean _std _min _max;

   n = put(_n,5.);
   mean = put(_mean,7.1);
   std = put(_std,8.2);
   min = put(_min,7.1);
   max = put(_max,7.1);
run;

proc print data=age;
title ' Age data set';
run;
title;

**** TRANSPOSE AGE DESCRIPTIVE STATISTICS INTO COLUMNS.;
proc transpose 
   data = age 
   out = age1 
   prefix = col;
      var n mean std min max;
      id trtpn;
run; 

proc print data=age1;
title' Denormalized (transposed) age data set';
run;
title;
 
**** CREATE AGE FIRST ROW FOR THE TABLE.;
data label;
   set pvalue(keep = p2_wil rename = (p2_wil = pvalue));
   length label $ 85;
   label = "#S={font_weight=bold} Age (years)";
run;
 
**** APPEND AGE DESCRIPTIVE STATISTICS TO AGE P VALUE ROW AND 
**** CREATE AGE DESCRIPTIVE STATISTIC ROW LABELS.; 
data age1;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label age1;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
      select;
         when(_NAME_ = 'n')    label = "#{nbspace 6}N";
         when(_NAME_ = 'mean') label = "#{nbspace 6}Mean";
         when(_NAME_ = 'std')  label = "#{nbspace 6}Standard Deviation";
         when(_NAME_ = 'min')  label = "#{nbspace 6}Minimum";
         when(_NAME_ = 'max')  label = "#{nbspace 6}Maximum";
         otherwise;
      end;
run;
**** END OF AGE STATISTICS PROGRAMMING *****************************;

 
**** SEX STATISTICS PROGRAMMING ************************************;
**** GET SIMPLE FREQUENCY COUNTS FOR SEX.;
proc freq 
   data = adsl1 
   noprint;
      where trtpn ne .; 
      tables trtpn * sexn / missing outpct out = sexn;
run;
 
**** FORMAT SEX N(%) AS DESIRED.;
data sexn;
   set sexn;
      where sexn ne .;
      length value $25;
      value = put(count,4.) || ' (' || put(pct_row,5.1)||'%)';
run;

proc sort
   data = sexn;
      by sexn;
run;

proc print data=sexn;
title'Sexn data set';
run;
title;
 
**** TRANSPOSE THE SEX SUMMARY STATISTICS.;
proc transpose 
   data = sexn 
   out = sexn1(drop = _name_) 
   prefix = col;
      by sexn;
      var value;
      id trtpn;
run;

proc print data=sexn1;
title 'Sexn1 data set (de-normalized) or transposed data set';
run;
title;
 
**** PERFORM A CHI-SQUARE TEST ON SEX COMPARING ACTIVE VS PLACEBO.;
proc freq 
   data = adsl1 
   noprint;
      where sexn ne . and trtpn not in (.,2);
      table sexn * trtpn / chisq;
      output out = pvalue pchi;
run;

**** CREATE SEX FIRST ROW FOR THE TABLE.;
data label;
	set pvalue(keep = p_pchi rename = (p_pchi = pvalue));
	length label $ 85;
	label = "#S={font_weight=bold} Sex";
run;

**** APPEND SEX DESCRIPTIVE STATISTICS TO SEX P VALUE ROW AND 
**** CREATE SEX DESCRIPTIVE STATISTIC ROW LABELS.; 
data sexn2;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label sexn1;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
        label= "#{nbspace 6}" || put(sexn,sexn.);
run;

proc print data=sexn2;
title ' Sex statistics';
run;
title;

**** END OF SEX STATISTICS PROGRAMMING *****************************;

 
**** RACE STATISTICS PROGRAMMING ***********************************;
**** GET SIMPLE FREQUENCY COUNTS FOR RACE;
proc freq 
   data = adsl1 
   noprint;
      where trtpn ne .; 
      tables trtpn * racen / missing outpct out = racen;
run;
 
**** FORMAT RACE N(%) AS DESIRED;
data racen;
   set racen;
      where racen ne .;
      length value $25;
      value = put(count,4.) || ' (' || put(pct_row,5.1)||'%)';
run;

proc sort
   data = racen;
      by racen;
run;

proc print data=racen;
title'Sorted Racen data set';
run;
title;
 
**** TRANSPOSE THE RACE SUMMARY STATISTICS;
proc transpose 
   data = racen 
   out = racen(drop = _name_) 
   prefix=col;
      by racen;
      var value;
      id trtpn;
run;

proc print data=racen;
title'Transposed Racen data set';
run;
title;

 
**** PERFORM A FISHER'S EXACT TEST ON RACE COMPARING ACTIVE VS PLACEBO.;
proc freq 
   data = adsl1 
   noprint;
      where racen ne . and trtpn not in (.,2);
      table racen * trtpn / exact;
      output out = pvalue exact;
run;
 
**** CREATE RACE FIRST ROW FOR THE TABLE.;
data label;
	set pvalue(keep = xp2_fish rename = (xp2_fish = pvalue));
	length label $ 85;
	label = "#S={font_weight=bold} Race";
run;

**** APPEND RACE DESCRIPTIVE STATISTICS TO RACE P VALUE ROW AND 
**** CREATE RACE DESCRIPTIVE STATISTIC ROW LABELS.; 
data racen;
   length label $ 85 col0 col1 col2 $ 25 ;
   set label racen;

   keep label col0 col1 col2 pvalue ;
   if _n_ > 1 then 
        label= "#{nbspace 6}" || put(racen,racen.);
run;

proc print data=racen;
title 'Racen statistics data set';
run;
title;

**** END OF RACE STATISTICS PROGRAMMING *******************************;


**** CONCATENATE AGE, SEX, AND RACE STATISTICS AND CREATE GROUPING
**** GROUP VARIABLE FOR LINE SKIPPING IN PROC REPORT.;
data forreport;
   set age1(in = in1)
       sexn2(in = in2)
       racen(in = in3);

       group = sum(in1 * 1, in2 * 2, in3 * 3);
run;


**** DEFINE THREE MACRO VARIABLES &N0, &N1, AND &NT THAT ARE USED IN 
**** THE COLUMN HEADERS FOR "PLACEBO," "ACTIVE" AND "OVERALL" THERAPY 
**** GROUPS.;
data _null_;
   set adsl end=eof;

   **** CREATE COUNTER FOR N0 = PLACEBO, N1 = ACTIVE.;
   if trtpn = 0 then
      n0 + 1;
   else if trtpn = 1 then
      n1 + 1;

   **** CREATE OVERALL COUNTER NT.; 
   nt + 1;
  
   **** CREATE MACRO VARIABLES &N0, &N1, AND &NT.;
   if eof then
      do;     
         call symput("n0",compress('(N='||put(n0,4.) || ')'));
         call symput("n1",compress('(N='||put(n1,4.) || ')'));
         call symput("nt",compress('(N='||put(nt,4.) || ')'));
      end;
run;


**** USE PROC REPORT TO WRITE THE DEMOGRAPHICS TABLE TO FILE.; 
options nodate nonumber missing = ' ';
ods escapechar='#';


proc report
   data=forreport
   nowindows
   spacing=1
   headline
   headskip
   split = "|";

   columns (group label col1 col0 col2 pvalue);

   define group   /order order = internal noprint;
   define label   /display " ";
   define col0    /display style(column)=[asis=on] "Placebo|&n0";
   define col1    /display style(column)=[asis=on] "Active|&n1";
   define col2    /display style(column)=[asis=on] "Overall|&nt";
   define pvalue  /display center " |P-value**" f = pvalue6.4;

   compute after group;
      line '#{newline}';
   endcomp;

   title1 j=l 'Company/Trial Name' 
          j=r 'Page #{thispage} of #{lastpage}';
   title2 j=c 'Table 5.3';
   title3 j=c 'Demographics and Baseline Characteristics';

   footnote1 j=l '* Other includes Asian, Native American, and other'
                 ' races.';
   footnote2 j=l "** P-values:  Age = Wilcoxon rank-sum, Sex = Pearson's"  
                 " chi-square, Race = Fisher's exact test.";
   footnote3 j=l "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run; 
ods pdf close;   




ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics3.rtf";
**** PROGRAM 5.4;
**** INPUT TREATMENT CODE DATA AS ADAM ADSL DATA.;
data ADSL;
length USUBJID $ 3;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)";
input USUBJID $ TRTPN @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 0  110 1
111 0  112 0  113 0  114 1  115 0  116 1  117 0  118 1  119 1  120 1
121 1  122 0  123 1  124 0  125 1  126 1  127 0  128 1  129 1  130 1
131 1  132 0  133 1  134 0  135 1  136 1  137 0  138 1  139 1  140 1
141 1  142 0  143 1  144 0  145 1  146 1  147 0  148 1  149 1  150 1
151 1  152 0  153 1  154 0  155 1  156 1  157 0  158 1  159 1  160 1
161 1  162 0  163 1  164 0  165 1  166 1  167 0  168 1  169 1  170 1
;
run;

proc print data=ADSL (firstobs=1 obs=10);
title 'Input Treatment code data as ADAM ADSL data';
run;
title;

**** INPUT ADVERSE EVENT DATA AS SDTM AE DOMAIN.;
data AE;
label USUBJID     = "Unique Subject Identifier"
      AEBODSYS    = "Body System or Organ Class"
      AEDECOD     = "Dictionary-Derived Term"
      AEREL       = "Causality"
	  AESEV       = "Severity/Intensity";    
input USUBJID $ 1-3 AEBODSYS $ 5-30 AEDECOD $ 34-50 
      AEREL $ 52-67 AESEV $ 70-77;
datalines;
101 Cardiac disorders            Atrial flutter    NOT RELATED       MILD
101 Gastrointestinal disorders   Constipation      POSSIBLY RELATED  MILD
102 Cardiac disorders            Cardiac failure   POSSIBLY RELATED  MODERATE
102 Psychiatric disorders        Delirium          NOT RELATED       MILD
103 Cardiac disorders            Palpitations      NOT RELATED       MILD
103 Cardiac disorders            Palpitations      NOT RELATED       MODERATE
103 Cardiac disorders            Tachycardia       POSSIBLY RELATED  MODERATE
115 Gastrointestinal disorders   Abdominal pain    RELATED           MODERATE
115 Gastrointestinal disorders   Anal ulcer        RELATED           MILD
116 Gastrointestinal disorders   Constipation      POSSIBLY RELATED  MILD
117 Gastrointestinal disorders   Dyspepsia         POSSIBLY RELATED  MODERATE
118 Gastrointestinal disorders   Flatulence        RELATED           SEVERE
119 Gastrointestinal disorders   Hiatus hernia     NOT RELATED       SEVERE
130 Nervous system disorders     Convulsion        NOT RELATED       MILD
131 Nervous system disorders     Dizziness         POSSIBLY RELATED  MODERATE
132 Nervous system disorders     Essential tremor  NOT RELATED       MILD
135 Psychiatric disorders        Confusional state NOT RELATED       SEVERE
140 Psychiatric disorders        Delirium          NOT RELATED       MILD
140 Psychiatric disorders        Sleep disorder    POSSIBLY RELATED  MILD
141 Cardiac disorders            Palpitations      NOT RELATED       SEVERE
;
run;

proc print data=AE (firstobs=1 obs=10);
title'INPUT ADVERSE EVENT DATA AS SDTM AE DOMAIN';
run;
title;

**** CREATE ADAE ADAM DATASET TO MAKE HELPFUL COUNTING FLAGS FOR SUMMARIZATION.
**** THIS WOULD TYPICALLY BE DONE AS A SEPARATE PROGRAM OUTSIDE OF AN AE SUMMARY.;
data adae;
  merge ae(in=inae) adsl;
    by usubjid;

	if inae;

    select (aesev);
      when('MILD') aesevn = 1;
      when('MODERATE') aesevn = 2;
      when('SEVERE') aesevn = 3;
      otherwise;
    end;
    label aesevn = "Severity/Intensity (N)";
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Transforming variable aesev from character to numeric';
run;
title;

proc sort
  data=adae;
    by usubjid aesevn;
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Sorted by usubjid and aesevn';
run;
title;

data adae;
  set adae;
    by usubjid aesevn;

    if last.usubjid then
      aoccifl = 'Y';

    label aoccifl = "1st Max Sev./Int. Occurrence Flag";
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Flagging variable, aoccifl, indicating maximum severity of AE per subject';
run;
title;

proc sort
  data=adae;
    by usubjid aebodsys aesevn;
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Sorted by usubjid aebodsys aesevn';
run;
title;

data adae;
  set adae;
    by usubjid aebodsys aesevn;

    if last.aebodsys then
      aoccsifl = 'Y';

    label aoccsifl = "1st Max Sev./Int. Occur Within SOC Flag";
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Flagging variable, aoccsifl, indicating maximun severity of AE per subject & body system';
run;
title;

proc sort
  data=adae;
    by usubjid aedecod aesevn;
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Sorted by usubjid aedecod aesevn';
run;
title;

data adae;
  set adae;
    by usubjid aedecod aesevn;

    if last.aedecod then
      aoccpifl = 'Y';

    label aoccpifl = "1st Max Sev./Int. Occur Within PT Flag";
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : Flagging variable, aoccpifl, indicating maximun severity of AE per subject & dictionary derived term';
run;
title;


**** END OF ADAM ADAE ADAM DATASET DERIVATIONS;**************************************************************
*************************************************************************************************************

**** PUT COUNTS OF TREATMENT POPULATIONS INTO MACRO VARIABLES;
proc sql noprint;
  select count(unique usubjid) format = 3. into :n0 from adsl where trtpn=0;
  select count(unique usubjid) format = 3. into :n1 from adsl where trtpn=1;
  select count(unique usubjid) format = 3. into :n2 from adsl;
quit;

**** OUTPUT A SUMMARY TREATMENT SET OF RECORDS. TRTPN=2;
data adae;
  set adae;
  output;
  trtpn=2;
  output;
run;

proc print data=adae (firstobs=1 obs=10);
title 'ADAE data set : with trtpn variable 0, 1, 2 (overall level)';
run;
title;

**** BY SEVERITY ONLY COUNTS;
proc sql noprint;
  create table All as
         select trtpn,               
                sum(aoccifl='Y') as frequency from adae
  group by trtpn;
quit;

proc print data=All (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment';
run;
title;

proc sql noprint;
  create table AllBySev as
         select aesev, trtpn,               
                sum(aoccifl='Y') as frequency from adae
  group by aesev, trtpn;
quit;

proc print data=AllBySev (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment & Adverse effect';
run;
title;


**** BY BODY SYSTEM AND SEVERITY COUNTS;
proc sql noprint;
  create table AllBodysys as
         select trtpn, aebodsys,               
                sum(aoccsifl='Y') as frequency from adae
  group by trtpn, aebodsys;
quit;

proc print data=AllBodysys (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment & Body system';
run;
title;

proc sql noprint;
  create table AllBodysysBysev as
         select aesev, trtpn, aebodsys,               
                sum(aoccsifl='Y') as frequency from adae
  group by aesev, trtpn, aebodsys;
quit;

proc print data=AllBodysysBysev (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment Adverse effect & Body system';
run;
title;

**** BY PREFERRED TERM AND SEVERITY COUNTS;
proc sql noprint;
  create table AllPT as
         select trtpn, aebodsys, aedecod,               
                sum(aoccpifl='Y') as frequency from adae
  group by trtpn, aebodsys, aedecod;
quit;

proc print data=AllPT (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment, Body system & Dictionary Derived term';
run;
title;

proc sql noprint;
  create table AllPTBySev as
         select aesev, trtpn, aebodsys, aedecod,               
                sum(aoccpifl='Y') as frequency from adae
  group by aesev, trtpn, aebodsys, aedecod;
quit;

proc print data=AllPTBySev (firstobs=1 obs=10);
title 'All data set : Adverse effects grouped by treatment, adverse effect, Body system & Dictionary Derived term';
run;
title;

**** PUT ALL COUNT DATA TOGETHER;
data all;
  set All(in=in1)
      AllBySev(in=in2)
      AllBodysys(in=in3)
      AllBodysysBysev(in=in4)
      AllPT(in=in5)
      AllPTBySev(in=in6);

      length description $ 40 sorter $ 200;
      if in1 then
        description = 'Any Event';
      else if in2 or in4 or in6 then
        description = '#{nbspace 6} ' || propcase(aesev);
      else if in3 then
        description = aebodsys;
      else if in5 then
        description = '#{nbspace 3}' || aedecod;

      sorter = aebodsys || aedecod || aesev;
run;

proc sort
  data=all;
  by sorter aebodsys aedecod description;
run;

proc print data=all (firstobs=1 obs=10);
title 'All count data';
run;
title;


**** TRANSPOSE THE FREQUENCY COUNTS;
proc transpose
  data=all
  out=flat
  prefix=count;
  by sorter aebodsys aedecod description;
  id trtpn;
  var frequency;
run;

proc sort
  data=flat;
  by aebodsys aedecod sorter;
run;

proc print data=flat (firstobs=1 obs=10);
title 'All count data - transposed by counts';
run;
title;

**** CREATE A SECTION BREAK VARIABLE AND FORMATTED COLUMNS;
data flat;
  set flat;
  by aebodsys aedecod sorter;

  retain section 1;

  length col0 col1 col2 $ 20;
  if count0 not in (.,0) then
    col0 = put(count0,3.) || " (" || put(count0/&n0*100,5.1) || "%)";
  if count1 not in (.,0) then
    col1 = put(count1,3.) || " (" || put(count1/&n1*100,5.1) || "%)";
  if count2 not in (.,0) then
    col2 = put(count2,3.) || " (" || put(count2/&n2*100,5.1) || "%)";
  
  if sum(count1,count2,count3)>0 then
    output;
  if last.aedecod then
    section + 1;
run;

**** USE PROC REPORT TO WRITE THE AE TABLE TO FILE.; 
options nodate nonumber missing = ' ';
ods escapechar='#';


proc report
   data=flat
   nowindows
   split = "|";

   columns section description col1 col0 col2;

   define section     /order order = internal noprint;
   define description /display style(header)=[just=left] 
   "Body System|#{nbspace 3} Preferred Term|#{nbspace 6} Severity";
   define col0        /display "Placebo|N=&n0";
   define col1        /display "Active|N=&n1";
   define col2        /display "Overall|N=&n2";

   compute after section;
      line '#{newline}';
   endcomp;

   title1 j=l 'Company/Trial Name' 
          j=r 'Page #{thispage} of #{lastpage}';
   title2 j=c 'Table 5.4';
   title3 j=c 'Adverse Events';
   title4 j=c "By Body System, Preferred Term, and Greatest Severity";
run; 
ods pdf close;   



**** PROGRAM 5.5;
**** INPUT TREATMENT CODE DATA AS ADAM ADSL DATA.;
data ADSL;
length USUBJID $ 3;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)";
input USUBJID $ TRTPN @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 0  110 1
111 0  112 0  113 0  114 1  115 0  116 1  117 0  118 1  119 1  120 1
121 1  122 0  123 1  124 0  125 1  126 1  127 0  128 1  129 1  130 1
131 1  132 0  133 1  134 0  135 1  136 1  137 0  138 1  139 1  140 1
141 1  142 0  143 1  144 0  145 1  146 1  147 0  148 1  149 1  150 1
151 1  152 0  153 1  154 0  155 1  156 1  157 0  158 1  159 1  160 1
161 1  162 0  163 1  164 0  165 1  166 1  167 0  168 1  169 1  170 1
;
run;

proc print data=ADSL (firstobs=1 obs=10);
title 'INPUT TREATMENT CODE DATA AS ADAM ADSL DATA';
run;
title;

**** INPUT SAMPLE CONCOMITANT MEDICATION DATA AS SDTM CM DOMAIN.;
data CM;
label USUBJID = "Unique Subject Identifier"
      CMDECOD = "Standardized Medication Name";
input USUBJID $ 1-3 CMDECOD $ 5-27;
datalines;
101 ACETYLSALICYLIC ACID   
101 HYDROCORTISONE         
102 VICODIN                
102 POTASSIUM              
102 IBUPROFEN              
103 MAGNESIUM SULFATE      
103 RINGER-LACTATE SOLUTION
115 LORAZEPAM              
115 SODIUM BICARBONATE     
116 POTASSIUM              
117 MULTIVITAMIN           
117 IBUPROFEN              
119 IRON                   
130 FOLIC ACID             
131 GABAPENTIN             
132 DIPHENHYDRAMINE        
135 SALMETEROL             
140 HEPARIN                
140 HEPARIN                
140 NICOTINE               
141 HYDROCORTISONE         
141 IBUPROFEN              
;
run;

proc print data=CM (firstobs=1 obs=10);
title'INPUT SAMPLE CONCOMITANT MEDICATION DATA AS SDTM CM DOMAIN';
run;
title;

**** PERFORM A SIMPLE COUNT OF EACH TREATMENT ARM AND OUTPUT RESULT;
**** AS MACRO VARIABLES.  N1 = 1ST COLUMN N FOR ACTIVE THERAPY,
**** N2 = 2ND COLUMN N FOR PLACEBO, N3 REPRESENTS THE 3RD COLUMN TOTAL N.;
proc sql noprint;

   **** PLACE THE NUMBER OF ACTIVE SUBJECTS IN &N1.;
   select count(distinct usubjid) format = 3.
      into :n1 
      from adsl
      where trtpn = 1;
   **** PLACE THE NUMBER OF PLACEBO SUBJECTS IN &N2.;
   select count(distinct usubjid) format = 3.
      into :n2 
      from adsl
      where trtpn = 0;
   **** PLACE THE TOTAL NUMBER OF SUBJECTS IN &N3.;
   select count(distinct usubjid) format = 3.
      into :n3 
      from adsl
      where trtpn ne .;
quit;



***** MERGE CCONCOMITANT MEDICATIONS AND TREATMENT DATA.
***** KEEP RECORDS FOR SUBJECTS WHO HAD CONMEDS AND TOOK STUDY THERAPY.
***** GET UNIQUE CONCOMITANT MEDICATIONS WITHIN PATIENTS.;
proc sql
   noprint;
   create table cmtosum as
      select unique(c.cmdecod) as cmdecod, c.usubjid, t.trtpn
         from cm as c, adsl as t
         where c.usubjid = t.usubjid
         order by usubjid, cmdecod;
quit;

proc print data=cmtosum (firstobs=1 obs=10);
title'data set of concomitant medications and treatment medications';
run;
title;

**** GET MEDICATION COUNTS BY TREATMENT AND PLACE IN DATASET COUNTS.;
**** TURN OFF LST OUTPUT.;
ods listing close;       
**** SEND SUMS BY TREATMENT TO COUNTS DATA SET.;
ods output CrossTabFreqs = counts; 
proc freq
   data = cmtosum;
      tables trtpn * cmdecod;
run;
ods output close;
ods listing;

proc sort
   data = counts;
      by cmdecod;
run;

proc print data=counts (firstobs=1 obs=10);
title 'counts table sorted by standardized medication name';
run;
title;

**** MERGE COUNTS DATA SET WITH ITSELF TO PUT THE THREE 
**** TREATMENT COLUMNS SIDE BY SIDE FOR EACH CONMED.  CREATE GROUP
**** VARIABLE WHICH ARE USED TO CREATE BREAK LINE IN THE REPORT. 
**** DEFINE COL1-COL3 WHICH ARE THE COUNT/% FORMATTED COLUMNS.;
data cm;
   merge counts(where = (trtpn = 1) rename = (frequency = count1))
         counts(where = (trtpn = 0) rename = (frequency = count2))
         counts(where = (trtpn = .) rename = (frequency = count3))
         end = eof;
      by cmdecod;

	  keep cmdecod rowlabel col1-col3 section;
	  length rowlabel $ 25 col1-col3 $ 10;

	  **** LABEL "ANY MEDICATION" ROW AND PUT IN FIRST GROUP.
	  **** BY MEDICATION COUNTS GO IN THE SECOND GROUP.;
	  if cmdecod = '' then
	     do;
	        rowlabel = "ANY MEDICATION";	
		    section = 1;
         end;
	  else 
	     do;
            rowlabel = cmdecod;
		    section = 2;
         end;

	  **** CALCULATE PERCENTAGES AND CREATE N/% TEXT IN COL1-COL3.;
      pct1 = (count1 / &n1) * 100;
      pct2 = (count2 / &n2) * 100;
      pct3 = (count3 / &n3) * 100;
           
      col1 = put(count1,3.) || " (" || put(pct1, 3.) || "%)";
      col2 = put(count2,3.) || " (" || put(pct2, 3.) || "%)";
      col3 = put(count3,3.) || " (" || put(pct3, 3.) || "%)";
run;

proc print data=cm (firstobs=1 obs=10);
title 'cm dataset frequency count of concomittant medications with the three levels of treatment medication';
run;
title;


**** USE PROC REPORT TO WRITE THE CONMED TABLE TO FILE.; 
options nodate nonumber missing = ' ';
ods escapechar='#';
*ods pdf style=htmlblue file='program5.5.pdf';
 
proc report
   data=cm
   nowindows
   split = "|";

   columns section rowlabel col1 col2 col3;

   define section  /order order = internal noprint;
   define rowlabel /order width=25 "Preferred Medication Term";
   define col1     /display center width=14 "Active|N=&n1";
   define col2     /display center width=14 "Placebo|N=&n2";
   define col3     /display center width=14 "Total|N=&n3";
 
   compute after section;
      line '#{newline}';
   endcomp;

   title1 j=l 'Company/Trial Name' 
          j=r 'Page #{thispage} of #{lastpage}';
   title2 j=c 'Table 5.5';
   title3 j=c 'Summary of Concomitant Medication';
run; 
   

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics4.rtf";
**** PROGRAM 5.6;
**** INPUT TREATMENT CODE DATA AS ADAM ADSL DATA.;
data ADSL;
length USUBJID $ 3;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)";
input USUBJID $ TRTPN @@;
datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 1  110 1
;
run;

proc print data=ADSL;
title 'INPUT TREATMENT CODE DATA AS ADAM ADSL DATA';
run;
title;

**** INPUT SAMPLE LABORATORY DATA AS SDTM LB DATA;
data LB;
label USUBJID     = "Unique Subject Identifier"
      VISITNUM    = "Visit Number"
      LBCAT       = "Category for Lab Test"
      LBTEST      = "Laboratory Test"
      LBSTRESU    = "Standard Units"
      LBSTRESN    = "Numeric Result/Finding in Standard Units"
      LBSTNRLO    = "Reference Range Lower Limit-Std Units"
      LBSTNRHI    = "Reference Range Upper Limit-Std Units"
      LBNRIND     = "Reference Range Indicator";

input USUBJID $ 1-3 VISITNUM 6 LBCAT $ 9-18 LBTEST $ 20-29
      LBSTRESU $ 32-35 LBSTRESN 38-41 LBSTNRLO 45-48 
      LBSTNRHI 52-55 LBNRIND $ 59;
datalines;
101  0  HEMATOLOGY HEMATOCRIT  %     31     35     49     L
101  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
101  2  HEMATOLOGY HEMATOCRIT  %     44     35     49     N
101  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   11.7   15.9   L
101  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   11.7   15.9   N
101  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
102  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  1  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
102  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   12.7   17.2   L
102  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   12.7   17.2   N
102  2  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
103  0  HEMATOLOGY HEMATOCRIT  %     50     35     49     H
103  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
103  2  HEMATOLOGY HEMATOCRIT  %     55     35     49     H
103  0  HEMATOLOGY HEMOGLOBIN  g/dL  12.5   11.7   15.9   N
103  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.2   11.7   15.9   N
103  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
104  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
104  1  HEMATOLOGY HEMATOCRIT  %     45     39     52     N
104  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
104  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
104  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.3   12.7   17.2   N
104  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.8   12.7   17.2   N
105  0  HEMATOLOGY HEMATOCRIT  %     36     35     49     N
105  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  2  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.1   11.7   15.9   N
105  1  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
105  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
106  0  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  1  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
106  2  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  0  HEMATOLOGY HEMOGLOBIN  g/dL  17.0   12.7   17.2   N
106  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.3   12.7   17.2   L
106  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.9   12.7   17.2   N
107  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
107  1  HEMATOLOGY HEMATOCRIT  %     56     39     52     H
107  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
107  0  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   N
107  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
107  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.2   12.7   17.2   H
108  0  HEMATOLOGY HEMATOCRIT  %     40     39     52     N
108  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
108  2  HEMATOLOGY HEMATOCRIT  %     54     39     52     H
108  0  HEMATOLOGY HEMOGLOBIN  g/dL  15.0   12.7   17.2   N
108  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
108  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.1   12.7   17.2   H
109  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
109  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
109  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
109  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
109  1  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
109  2  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
110  0  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
110  1  HEMATOLOGY HEMATOCRIT  %     51     39     52     N
110  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
110  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
110  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
110  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.0   12.7   17.2   H
;
run;

proc print data=LB (firstobs=1 obs=10);
title 'INPUT SAMPLE LABORATORY DATA AS SDTM LB DATA';
run;
title;
 
proc sort
   data = lb;
      by usubjid lbcat lbtest lbstresu visitnum;
run;

proc print data=LB (firstobs=1 obs=10);
title1 'INPUT SAMPLE LABORATORY DATA AS SDTM LB DATA';
title2 'Sorted by usubjid lbcat lbtest lbstresu visitnum';
run;
title;

proc sort
   data = adsl;
      by usubjid;
run;

proc print data=adsl;
title1 'INPUT TREATMENT CODE DATA AS ADAM ADSL DATA';
title2 'Sorted by usubjid';
run;
title;


**** MERGE TREATMENT INFORMATION WITH LAB DATA.;
data lb;
   merge adsl(in = inadsl) lb(in = inlb);
      by usubjid;

      if inlb and not inadsl then
	     put "WARN" "ING: Missing treatment assignment for subject "
		     usubjid=;

      if inadsl and inlb;
run;

proc print data=lb (firstobs=1 obs=10);
title1 'Merged Treatment (adsl) data set with Laboratory (lb) data set';
title2 'by usubjid, screened for missing treatment assignment ';
run;
title;

**** CARRY FORWARD BASELINE LABORATORY ABNORMAL FLAG.;
data lb;
   set lb;
      by usubjid lbcat lbtest lbstresu visitnum;

      retain baseflag " ";

      **** INITIALIZE BASELINE FLAG TO MISSING.;
      if first.lbtest then
         baseflag = " ";

      **** AT VISITNUM 0 ASSIGN BASELINE FLAG.;
      if visitnum = 0 then
         baseflag = lbnrind;
run;
  
proc sort
   data = lb;
      by lbcat lbtest lbstresu visitnum trtpn;
run;

proc print data=lb (firstobs=1 obs=10);
title1 'Laboratory (lb) data set assigning baseline flag when visit number = 0 & ref range indicator';
title2 'Subsetting the following variables: usubjid lbcat lbtest lbstresu visitnum';
run;
title;




**** GET COUNTS AND PERCENTAGES FOR SHIFT TABLE.
**** WE DO NOT WANT COUNTS FOR VISITNUM 0 SO IT IS SUPRESSED.;
ods listing close;
ods output CrossTabFreqs = freqs;
proc freq
   data=lb(where = (visitnum ne 0));
      by lbcat lbtest lbstresu visitnum trtpn;
    
      tables baseflag*lbnrind;
run;
ods output close;
ods listing;

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics5.rtf";

**** WRITE LAB SHIFT SUMMARY TO FILE USING DATA _NULL_;
options nodate nonumber;
title1 "Table 5.6";
title2 "Laboratory Shift Table";
title3 " ";
data _null_;
   set freqs end = eof;
      by lbcat lbtest lbstresu visitnum trtpn; 

      **** SUPPRESS TOTALS.;
      where baseflag ne '' and lbnrind ne '';

      **** SET OUTPUT FILE OPTIONS.;
      file print titles linesleft = ll pagesize = 50 linesize = 80;

      **** WHEN NEWPAGE = 1, A PAGE BREAK IS INSERTED.;
      retain newpage 0;
 
      **** WRITE THE HEADER OF THE TABLE TO THE PAGE.;
      if _n_ = 1 or newpage = 1 then 
         put @1 "-----------------------------------" 
                "-----------------------------------" /
             @1 lbcat ":" @39 "Baseline Value" /
             @1 lbtest 
             @17 "------------------------------------------------------" /
             @1 "(" lbstresu ")" @25 "Placebo" @55 "Active" /
             @17 "--------------------------  "
                 "--------------------------" /
             @20 "Low     Normal    High      Low     Normal    High" /
             @1 "-----------------------------------" 
                "-----------------------------------" /;
 
      **** RESET NEWPAGE TO ZERO.;
      newpage = 0;

      **** DEFINE ARRAY VALUES WHICH REPRESENTS THE 3 ROWS AND
      **** 6 COLUMNS FOR ANY GIVEN visitnum.;
      array values {3,6} $10 _temporary_;

      **** INITIALIZE ARRAY TO "0(  0%)".;
      if first.visitnum then
         do i = 1 to 3;
            do j = 1 to 6;
               values(i,j) = "0(  0%)";
	      end;
	   end;

      **** LOAD FREQUENCY/PRECENTS FROM FREQS DATA SET TO 
      **** THE PROPER PLACE IN THE VALUES ARRAY.;  
      values( sum((lbnrind = "L") * 1,(lbnrind = "N") * 2,
                  (lbnrind = "H") * 3) ,
              sum((baseflag = "L") * 1,(baseflag = "N") * 2,
                  (baseflag = "H") * 3) + (trtpn * 3)) = 
         put(frequency,2.) || "(" || put(percent,3.) || "%)";

      **** ONCE ALL DATA HAS BEEN LOADED INTO THE ARRAY FOR THE visitnum,
      **** PUT THE DATA ON THE PAGE.;
      if last.visitnum then
         do;
            put @1 "Week " visitnum
                @10 "Low"    @18 values(1,1) @27 values(1,2) 
                             @36 values(1,3) @46 values(1,4) 
                             @55 values(1,5) @64 values(1,6) /
                @10 "Normal" @18 values(2,1) @27 values(2,2) 
                             @36 values(2,3) @46 values(2,4) 
                             @55 values(2,5) @64 values(2,6) /
                @10 "High"   @18 values(3,1) @27 values(3,2) 
                             @36 values(3,3) @46 values(3,4) 
                             @55 values(3,5) @64 values(3,6) /; 

            **** IF IT IS THE END OF THE FILE, PUT A DOUBLE LINE.;
            if eof then
               put @1 "-----------------------------------" 
                   "-----------------------------------" /
                   "-----------------------------------" 
                   "-----------------------------------" //
               "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
		**** IF ONLY THE LAST VISITNUM IN A TEST, THEN PUT PAGE BREAK.;
		else if last.lbtest then
               do;
                  put @1 "-----------------------------------" 
                      "-----------------------------------" /
                      @60 "(CONTINUED)" /
                      "Created by %sysfunc(getoption(sysin)) on &sysdate9.."
                      _page_;
                  newpage = 1;
               end;
         end;    
run;


**** PROGRAM 5.7;
**** INPUT SAMPLE TREATMENT AND TIME TO DEATH DATA AS A SMALL
**** PART OF AN ADAM ADTTE ANALYSIS DATASET.;
data ADTTE;
label TRTA  = "Actual Treatment"
      AVAL   = "Analysis Value"
      CNSR   = "Censor";
input TRTA $ AVAL CNSR @@;
datalines;
A  52    0     A  825   1     C  693   1     C  981   1
B  279   0     B  826   1     B  531   1     B  15    1
C  1057  1     C  793   1     B  1048  1     A  925   1
C  470   1     A  251   0     C  830   1     B  668   0
B  350   1     B  746   1     A  122   0     B  825   1
A  163   0     C  735   1     B  699   1     B  771   0
C  889   1     C  932   1     C  773   0     C  767   1
A  155   1     A  708   1     A  547   1     A  462   0
B  114   0     B  704   1     C  1044  1     A  702   0
A  816   1     A  100   0     C  953   1     C  632   1
C  959   1     C  675   1     C  960   0     A  51    1
B  33    0     B  645   1     A  56    0     A  980   0
C  150   1     A  638   1     B  905   1     B  341   0
B  686   1     B  638   1     A  872   0     C  1347  1
A  659   1     A  133   0     C  360   1     A  907   0
C  70    1     A  592   1     B  112   1     B  882   0
A  1007  1     C  594   1     C  7     1     B  361   1
B  964   1     C  582   1     B  1024  0     A  540   0
C  962   1     B  282   1     C  873   1     C  1294  1
B  961   1     C  521   1     A  268   0     A  657   1
C  1000  1     B  9     0     A  678   1     C  989   0
A  910   1     C  1107  1     C  1071  0     A  971   1
C  89    1     A  1111  1     C  701   1     B  364   0
B  442   0     B  92    0     B  1079  1     A  93    1
B  532   0     A  1062  1     A  903   1     C  792   1
C  136   1     C  154   1     C  845   1     B  52    1
A  839   1     B  1076  1     A  834   0     A  589   1
A  815   1     A  1037  1     B  832   1     C  1120  1
C  803   1     C  16    0     A  630   1     B  546   1
A  28    0     A  1004  1     B  1020  1     A  75    1
C  1299  1     B  79    1     C  170   1     B  945   1
B  1056  1     B  947   1     A  1015  1     A  190   0
B  1026  1     C  128   0     B  940   1     C  1270  1
A  1022  0     A  915   1     A  427   0     A  177   0
C  127   1     B  745   0     C  834   1     B  752   1
A  1209  1     C  154   1     B  723   1     C  1244  1
C  5     1     A  833   1     A  705   1     B  49    1
B  954   1     B  60    0     C  705   1     A  528   1
A  952   1     C  776   1     B  680   1     C  88    1
C  23    1     B  776   1     A  667   1     C  155   1
B  946   1     A  752   1     C  1076  1     A  380   0
B  945   1     C  722   1     A  630   1     B  61    0
C  931   1     B  2     1     B  583   1     A  282   0
A  103   0     C  1036  1     C  599   1     C  17    1
C  910   1     A  760   1     B  563   1     B  347   0
B  907   1     B  896   1     A  544   1     A  404   0
A  8     0     A  895   1     C  525   1     C  740   1
C  11    1     C  446   0     C  522   1     C  254   1
A  868   1     B  774   1     A  500   1     A  27    1
B  842   1     A  268   0     B  505   1     B  505   0
; 
run;

proc print data=adtte (firstobs=1 obs=10);
title 'INPUT SAMPLE TREATMENT AND TIME TO DEATH DATA AS A SMALL PART OF AN ADAM ADTTE ANALYSIS DATASET';
run;
title;
  

**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES TO 
**** SURVEST DATA SET.;
ods listing close;
ods output ProductLimitEstimates = survivalest;
proc lifetest
   data=adtte;
    
   time aval * cnsr(1);
   strata trta;
run;
ods output close;
ods listing;

ods rtf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Demographics6.rtf";  
 
data survivalest;
   set survivalest; 
 
   **** CALCULATE VISIT WINDOW (MONTHS);
   if aval = 0 then
      visit = 0;    **** Baseline;
   else if 1 <= aval <= 91 then
      visit = 91;   **** 3 Months;
   else if 92 <= aval <= 183 then
      visit = 183;  **** 6 Months;
   else if 184 <= aval <= 365 then
      visit = 365;  **** 1 Year;
   else if 366 <= aval <= 731 then
      visit = 731;  **** 2 Years;
   else if 732 <= aval <= 1096 then
      visit = 1096; **** 3 Years;
   else if 1097 <= aval <= 1461 then
      visit = 1461; **** 4 Years;
   else 
      put "ERR" "OR: event data beyond visit mapping " 
          aval = ;
run;

proc sort
   data = survivalest;
      by trta visit aval;
run;

proc print data = survivalest (firstobs=1 obs=10);
title 'survival estimates table';
run;
title;
  
**** CREATE 95% CONFIDENCE INTERVAL AROUND THE ESTIMATE 
**** AND RETAIN PROPER SURVIVAL ESTIMATE FOR TABLE.;
data survivalest;
   set survivalest;
      by trta visit aval;

      keep trta visit count left survprob lcl ucl; 
      retain count survprob lcl ucl;

	  **** INITIALIZE VARIABLES TO MISSING FOR EACH TREATMENT.;
      if first.trta then
         do;                
            survprob = .;
            count = .;
            lcl = .;
            ucl = .;
         end;
        
      **** CARRY FORWARD OBSERVATIONS WITH AN ESTIMATE.;
      if survival ne . then
         do;
            count = failed;
            survprob = survival;           
  		    **** SUPPRESS CONFIDENCE INTERVALS AT BASELINE.;
            if visit ne 0 and stderr ne . then
               do;
                  lcl = survival - (stderr*1.96);
                  ucl = survival + (stderr*1.96);
               end;
         end;
    
      **** KEEP ONE RECORD PER VISIT WINDOW.; 
      if last.visit;
run;

proc sort
   data = survivalest;
      by visit;
run;

proc print data=survivalest (firstobs=1 obs=10);
title'Survival Estimates and Confidence intervals';
run;
title;

**** COLLAPSE TABLE BY TREATMENT.  THIS IS DONE BY MERGING THE 
**** SURVIVALEST DATA SET AGAINST ITSELF 3 TIMES.;
data table;
  merge survivalest
        (where=(trta="A")
         rename =(count=count_a left=left_a
                  survprob=survprob_a lcl=lcl_a ucl=ucl_a))
        survivalest
        (where=(trta="B")
         rename =(count=count_b left=left_b
                  survprob=survprob_b lcl=lcl_b ucl=ucl_b))
        survivalest
        (where=(trta="C")
         rename =(count=count_c left=left_c
                  survprob=survprob_c lcl=lcl_c ucl=ucl_c));
      by visit;
run;

proc print data=table;
title'Collapsed survival estimates table by treatment';
run;
title;
 
**** CREATE VISIT FORMAT USED IN TABLE.;
proc format;
   value visit
      0    = "Baseline"
      91   = "3 Months"
	  183  = "6 Months"
	  365  = "1 Year"
	  731  = "2 Years"
	  1096 = "3 Years"
	  1461 = "4 Years";
run;
		 
**** CREATE SUMMARY WITH PROC REPORT;
options nodate nonumber missing = ' ';
ods escapechar='#';
*ods pdf style=htmlblue file='program5.7.pdf';

proc report
   data = table
   nowindows
   split = "|";

   columns (visit 
           ("Placebo" count_a left_a survprob_a 
                         ("95% CIs" lcl_a ucl_a))
           ("Old Drug" count_b left_b survprob_b 
                         ("95% CIs" lcl_b ucl_b))
           ("New Drug" count_c left_c survprob_c 
                          ("95% CIs" lcl_c ucl_c)) );

    define visit      /order order = internal "Visit" left 
                       format = visit.;
    define count_a    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_a     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_a /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_a      /display "Lower" format = 5.3;
    define ucl_a      /display "Upper" format = 5.3;
    define count_b    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_b     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_b /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_b      /display "Lower" format = 5.3;
    define ucl_b      /display "Upper" format = 5.3;
    define count_c    /display "Cum. Deaths" width = 6 
                       format = 3. center;
    define left_c     /display "Remain at Risk" width = 6 
                       format = 3. center spacing = 0;
    define survprob_c /display "Surv- ival Prob." center 
                       format = pvalue5.3;
    define lcl_c      /display "Lower" format = 5.3;
    define ucl_c      /display "Upper" format = 5.3;

    break after visit / skip;
 
    title1 j=l 'Company/Trial Name' 
           j=r 'Page #{thispage} of #{lastpage}';
    title2 j=c 'Table 5.7';
    title3 j=c 'Kaplan-Meier Survival Estimates for Death Over Time';
    footnote1 "Created by %sysfunc(getoption(sysin)) on &sysdate9..";  
run;

ods rtf close;

**** PROGRAM 5.8;
**** INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL;
data ADSL;
label USUBJID = "Unique Subject Identifier"
      TRTPN   = "Planned Treatment (N)"
      SEXN    = "Sex (N)"
      RACEN   = "Race (N)"
      AGE     = "Age";
input USUBJID $ TRTPN SEXN RACEN AGE @@;
datalines;
101 0 1 3 37  301 0 1 1 70  501 0 1 2 33  601 0 1 1 50  701 1 1 1 60
102 1 2 1 65  302 0 1 2 55  502 1 2 1 44  602 0 2 2 30  702 0 1 1 28
103 1 1 2 32  303 1 1 1 65  503 1 1 1 64  603 1 2 1 33  703 1 1 2 44
104 0 2 1 23  304 0 1 1 45  504 0 1 3 56  604 0 1 1 65  704 0 2 1 66
105 1 1 3 44  305 1 1 1 36  505 1 1 2 73  605 1 2 1 57  705 1 1 2 46
106 0 2 1 49  306 0 1 2 46  506 0 1 1 46  606 0 1 2 56  706 1 1 1 75
201 1 1 3 35  401 1 2 1 44  507 1 1 2 44  607 1 1 1 67  707 1 1 1 46
202 0 2 1 50  402 0 2 2 77  508 0 2 1 53  608 0 2 2 46  708 0 2 1 55
203 1 1 2 49  403 1 1 1 45  509 0 1 1 45  609 1 2 1 72  709 0 2 2 57
204 0 2 1 60  404 1 1 1 59  510 0 1 3 65  610 0 1 1 29  710 0 1 1 63
205 1 1 3 39  405 0 2 1 49  511 1 2 2 43  611 1 2 1 65  711 1 1 2 61
206 1 2 1 67  406 1 1 2 33  512 1 1 1 39  612 1 1 2 46  712 0 . 1 49
;
run;

proc print data=adsl (firstobs=1 obs=10);
title'INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL';
run;
title;

 
proc sort
   data = adsl;
      by trtpn usubjid;
run;

***** LASTREC VARIABLE IS USED FOR CONTINUING FOOTNOTE.;
data adsl;
   set adsl end = eof;

   **** FLAG THE LAST OBSERVATION IN THE DATA SET.;
   if eof then
      lastrec = 1;
run;

proc print data=adsl;
title'Sorted - INPUT SAMPLE DEMOGRAPHICS DATA AS CDISC ADaM ADSL - Flagging last observation';
run;
title;

proc format;
   value trtpn
      1 = "Active"
      0 = "Placebo"; 
   value sexn
      . = "Missing"
      1 = "Male"
      2 = "Female";
   value racen
      1 = "White"
      2 = "Black"
      3 = "Other";
run;


**** USE PROC REPORT TO WRITE LISTING OF DEMOGRAPHICS.;
options formchar="|----|+|---+=|-/\<>*" ls=75 ps=30 
        missing = " " nodate nonumber;
proc report
   data = adsl
   split = "|"
   spacing = 3
   missing
   nowindows
   headline;

   columns ("--" lastrec trtpn usubjid sexn racen age);

   define lastrec /display noprint;
   define trtpn   /order order=internal 
                   left width = 10 "Treatment" f = trtpn.;
   define usubjid /order center width = 7  "Subject|ID";
   define sexn    /display center width = 10 "Sex" f = sexn.;
   define racen   /display center width = 10 "Race" f = racen.;
   define age     /display center width = 10 "Age" f = 3.;

   **** COMPUTE BLOCK TO PUT CONTINUING TEXT TO PAGE.;
   compute after _page_ / left;
   if not lastrec then 
      contline = "(Continued)"; 
   else 
      contline = "-----------"; 

   line @9 "------------------------------------------------" 
           contline $11.;
   endcomp;

   title1 "Listing 5.8";
   title2 "Subject Demographics";
   footnote1 "Created by %sysfunc(getoption(sysin)) on"
             " &sysdate9..";
   

run;

ods pdf close;
ods html close;
*ods output close;
*ods listing;


