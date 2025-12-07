ods pdf file="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/chapter 6.pdf";

**** PROGRAM 6.1;
**** INPUT SAMPLE HEMATOCRIT LAB DATA AS ADLB.;
data ADLB;
label USUBJID = "Unique Subject Identifier"
      PARAMCD = "Parameter Code"
      BASE    = "Baseline Value"
      AVAL    = "Analysis Value"
      TRTP    = "Planned Treatment";
input USUBJID $ PARAMCD $ AVAL BASE TRTP $ @@;
datalines;
101 HCT 35.0 31.0 a    102 HCT 40.2 30.0 a 
103 HCT 42.0 42.4 b    104 HCT 41.2 41.4 b 
105 HCT 35.0 33.3 a    106 HCT 34.3 34.3 a 
107 HCT 30.3 44.0 b    108 HCT 34.2 42.0 b 
109 HCT 40.0 41.1 b    110 HCT 41.0 42.1 b 
111 HCT 33.3 33.8 a    112 HCT 34.0 31.0 a 
113 HCT 34.0 41.0 b    114 HCT 34.0 40.0 b 
115 HCT 37.2 35.2 a    116 HCT 39.3 36.2 a 
117 HCT 36.3 38.3 b    118 HCT 37.4 37.3 b 
119 HCT 44.2 34.3 a    120 HCT 42.2 36.5 a 
;
run;

proc print data=adlb (firstobs=1 obs=10) label;
title'INPUT SAMPLE HEMATOCRIT LAB DATA AS ADLB';
run;
title;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods _all_ close;

**** MODIFY THE STYLE TEMPLATE TO GET DESIRED SYMBOLS;
ods path sashelp.tmplmst(read) work.templat;


proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / markersymbol='circle'
                     contrastcolor=black;
  class GraphData2 / markersymbol='plus'
                     contrastcolor=black;

 end;
run;


**** CREATE THE PLOT DESIRED WITH PROC SGPLOT;
ods html 
 path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"            
 file="figure6.1.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_1" outputfmt=png;



**** CREATE SCATTER PLOT;
proc sgplot
  data=adlb;
  scatter x = aval
          y = base / group=trtp;
  xaxis values = (30 35 40 45) minorcount=4;
  yaxis values = (30 35 40 45) minorcount=4;
  lineparm x=30 y=30 slope=1;
title1 "Hematocrit (%) Scatter Plot";
title2 "At Visit 3";
run;


ods graphics off;

ods html close;

**** PROGRAM 6.2;
**** INPUT SAMPLE MEAN CLINICAL RESPONSE VALUES AS ADEFF.;
data ADEFF;
label AVAL    = "Analysis Value"
      AVISITN = "Analysis Visit (N)"
      TRTPN   = "Planned Treatment (N)";
input TRTPN AVISITN AVAL @@;
datalines;
1  0 9.40    2  0 9.55
1  1 9.35    2  1 9.45
1  2 8.22    2  2 8.78
1  3 6.33    2  3 8.23
1  4 4.00    2  4 7.77
1  5 2.22    2  5 4.46
1  6 1.44    2  6 2.00
1  7 1.13    2  7 1.86
1  8 0.55    2  8 1.44
1  9 0.67    2  9 1.33
1 10 0.45    2 10 1.01
;
run;

proc print data=ADEFF (firstobs=1 obs=10) label;
title'INPUT SAMPLE MEAN CLINICAL RESPONSE VALUES AS ADEFF';
run;
title;
 
**** CREATE FORMATS TO BE USED IN PLOT.;
proc format;
   value avisitn
      0 = "Baseline"
      1 = "Day 1"
      2 = "Day 2"
      3 = "Day 3"
      4 = "Day 4"
      5 = "Day 5"
      6 = "Day 6"
      7 = "Day 7"
      8 = "Day 8"
      9 = "Day 9"
      10 = "Day 10";
   value trtpn
      1 = "Super Drug"
      2 = "Old Drug";
run;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods _all_ close;


**** MODIFY THE STYLE TEMPLATE TO GET DESIRED SYMBOLS/LINES;
ods path sashelp.tmplmst(read) work.templat;

proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / markersymbol='circlefilled'
                     linestyle=1
                     contrastcolor=black;
  class GraphData2 / markersymbol='circle'
                     linestyle=2
                     contrastcolor=black;
 end;
run;


**** CREATE LINE PLOT USING PROC SGPLOT;
ods html 
path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"         file="figure6.2.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_2" outputfmt=png;

**** PRODUCE LINE PLOT;
proc sgplot 
  data=adeff;
                                         
   series x=avisitn y=aval / group=trtpn markers 
          name="customlegend" legendlabel="Treatment";
                                                                                
   refline 1 / axis=x;                                                                                                               
   yaxis values=(0 to 10 by 1)  
         display=(noticks)
         label='Mean Clinical Response';     
                                                           
   xaxis values=(0 to 10 by 1) 
         label='Visit';               

   keylegend "customlegend" / location=inside position=topright;                                

   format avisitn avisitn.
          trtpn trtpn.;

   title1 "Mean Clinical Response by Visit";                                         
run;    

ods html close;


**** PROGRAM 6.4;
**** INPUT SAMPLE PAIN SCALE DATA AS CDISC ADAM ADSEIZ DATA;
data ADSEIZ;
label AVAL    = 'Analysis Value' 
      /* where AVAL = "Seizures per Hour" */
      AVISITN = 'Analysis Visit (N)'
      TRTPN   = 'Planned Treatment (N)';
input TRTPN AVISITN AVAL @@;
datalines;
1 2 1.5    2 1 3      2 2 1.8
2 1 2.6    2 2 2      2 3 2
1 1 2.8    2 3 2.6    1 1 3
1 2 2.2    1 1 2.4    2 1 3.2
2 1 3.2    1 2 1.4    1 1 2.6
2 2 2.1    1 3 1.8    1 2 1.2
1 1 2.6    2 1 3      1 3 1.8
2 1 2.2    1 1 3.6    2 1 2.1
2 2 3.2    1 2 2      2 2 1
1 1 2.6    1 3 3.6    2 3 1.8
1 2 2.2    2 1 3.6    1 1 2.6
1 3 2.2    2 2 2.6    2 1 4
2 1 2.8    2 3 2      2 3 3.6
2 2 2.6    1 1 2.8    1 1 3.4
2 3 2.6    1 2 1.8    1 2 3
1 1 2.0    1 3 1.6    2 1 3.4
1 2 2.4    2 1 3.8    2 2 2
2 1 2.1    2 2 3      1 1 2.6
2 2 1.2    2 3 3.4    1 3 1.8
2 3 1      1 1 4      2 1 2.0
1 1 2.9    1 3 3.4    1 1 2.8
1 2 1.6    2 1 2.8    2 1 2.4
1 3 1.2    2 2 1.2    1 1 3.6
2 1 2.8    2 3 1.2    2 1 3.2
2 2 2.6    1 1 1.8    2 2 2.2
2 3 3.2    1 2 2      2 3 3.2
1 1 2.8    1 3 2.2    1 1 4
1 2 1.4    2 1 3      2 1 3.2
1 3 2      2 2 1.4    1 1 2.4
2 1 1.6    2 3 1.4    2 1 4
1 1 2.8    1 1 3.6    2 2 2.2
1 2 1.4    1 2 1.4    1 1 4
1 3 1.2    2 1 2.2
;
run;

proc print data=adseiz (firstobs=1 obs=10) label;
title'INPUT SAMPLE PAIN SCALE DATA AS CDISC ADAM ADSEIZ DATA';
run;
title;


**** FORMATS FOR THE PLOT;
proc format;
  value trtpn
     1 = "Active"
     2 = "Placebo";
  value avisitn
     1 = 'Baseline'
     2 = '6 Months'
     3 = '9 Months';
run;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods _all_ close;

**** MODIFY THE STYLE TEMPLATE TO GET DESIRED SYMBOLS AND LINES;
ods path sashelp.tmplmst(read) work.templat;

proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / markersymbol='EarthFilled'
                     contrastcolor=black
                     linestyle=2;
  class GraphData2 / markersymbol='EarthFilled'
                     contrastcolor=black
                     linestyle=1;
 end;
run;

ods html 
 path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"
 file="figure6.4.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_4" outputfmt=png;


**** CREATE BOX PLOT;
proc sgplot
  data=adseiz;

  vbox aval /category=avisitn group=trtpn 
             nofill capshape=line connect=median 
             grouporder=ascending extreme nooutliers;

  xaxis label='Visit';
  yaxis values = (1 to 4 by 1) minorcount=3 label='Seizures per Hour';        

  format trtpn trtpn. avisitn avisitn.;
  label trtpn = "Treatment";

  title1 "Seizures Per Hour by Treatment";  
  footnote1 j=l "Box extends to 25th and 75th percentile. Whiskers extend to"
                " minimum and maximum values. Mean values are represented by"
                " a dot while medians are connected by the line.";   
run;    


ods html close;



**** PROGRAM 6.5;
**** INPUT SAMPLE PAIN DATA AS CDISC ADAM ADPAIN DATASET.;
data ADPAIN;
label AVAL  = "Analysis*Value" /* theraputic success */
      TRTPN = "Planned*Treatment (N)"
      SEXN   = "Male"
      RACEN  = "Race (N)"
      BASEPAIN = "Baseline Pain*Score";
input AVAL TRTPN SEXN RACEN BASEPAIN @@;
datalines;
1 0 1 3 20   1 0 1 1 31   1 0 1 2 40   1 0 1 1 50   1 1 2 1 60   
1 1 2 1 22   0 0 1 2 23   1 1 2 1 20   0 0 2 2 20   0 0 2 1 23   
1 0 2 2 20   1 1 1 1 25   1 1 1 1 20   1 1 2 1 20   1 1 2 2 20   
1 1 1 1 10   1 0 2 1 25   0 0 1 3 40   1 0 1 1 20   1 0 1 1 20   
0 0 1 3 24   1 1 1 1 30   0 1 1 2 20   0 1 2 1 21   0 1 1 2 34   
0 0 2 1 20   1 0 1 2 20   1 0 1 1 20   1 0 1 2 20   1 1 2 1 55   
1 1 1 3 22   1 1 1 1 34   1 1 1 2 40   1 1 1 1 50   1 1 1 1 60   
0 0 2 1 20   0 0 2 2 20   0 0 2 1 20   0 0 2 2 20   0 0 1 1 20   
1 1 1 2 25   1 1 1 1 23   1 0 2 1 20   1 1 2 1 20   1 0 1 2 22   
1 0 1 1 11   1 0 1 1 33   0 0 2 3 40   1 0 1 1 20   0 1 1 1 21   
1 1 2 3 24   1 0 2 1 30   1 1 1 2 20   1 1 2 1 21   0 1 1 2 33   
0 0 2 1 20   1 1 1 2 22   1 1 2 1 20   1 1 1 2 20   1 0 1 1 50   
0 0 1 1 55   0 0 1 2 12   0 1 1 1 20   1 1 1 2 22   1 1 1 1 12   
;
run;

proc print data=ADPAIN (firstobs=1 obs=10) label split='*';
title'INPUT SAMPLE PAIN DATA AS CDISC ADAM ADPAIN DATASET';
run;
title;

 
 
**** GET ADJUSTED ODDS RATIOS FROM PROC LOGISTIC AND PLACE
**** THEM IN DATA SET WALD.; 
ods output CLoddsWald=odds;
proc logistic
   data = adpain;

   model aval(event='1') = basepain sexn racen trtpn / clodds = wald; 
run; 
ods output close;

***** RECATEGORIZE EFFECT FOR Y AXIS FORMATING PURPOSES.; 
data odds;
   set odds;

   select(effect);
      when("BASEPAIN") y = 1;
      when("SEXN")     y = 2;
      when("RACEN")    y = 3;
      when("TRTPN")    y = 4;
      otherwise;
   end;
run;

ods listing;


**** FORMAT FOR EFFECT ON Y AXIS;
proc format;
   value effect
      1 = "Baseline Pain (continuous)"
      2 = "Male vs. Female"
      3 = "White vs. Black"
      4 = "Active Therapy vs. Placebo";
run;



**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods _all_ close;

ods html 
path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"         file="figure6.5.html" image_dpi=300 style=htmlblue;

ods graphics on / reset imagename="figure6_5" outputfmt=png;

**** PRODUCE ODDS RATIO PLOT;
proc sgplot 
  data=odds
  noautolegend;
                                         
   scatter y=y x=oddsratioest / xerrorupper=uppercl xerrorlower=lowercl 
           errorbarattrs=(thickness=2.5 color=black)
           markerattrs=graphdata1(size=0);             
   scatter y=y x=oddsratioest /  
           markerattrs=graphdata1(symbol=circlefilled color=black size=8); 
                                                                                
   refline 1 / axis=x;                                                                                                               
   yaxis values=(1 to 4 by 1)  
         display=(noticks nolabel);     
                                                           
   xaxis type=log logbase=2 values=(0.125 0.25 0.5 1 2 4 8 16) 
         label='Odds Ratio and 95% Confidence Interval' ;                                               

   format y effect.;

   title1 "Odds Ratios for Clinical Success";                                         
run;    

ods html close;

proc print data=odds;
title1'Odds Ratio table for the independent variables basepain, sex, race'; 
title2'and treatment group against Clinical Success';
format y effect.;
run;
title;





**** PROGRAM 6.7;
**** INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA;
data ADDEATH;
label TRTP = "Planned Treatment"
      AVAL = "Analysis Value" /* "Days to Death" */
      CNSR = "Censor";
input TRTP $ AVAL CNSR @@;
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

proc print data=ADDEATH (firstobs=1 obs=10) label;
title'INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA';
run;
title;

proc format;
   value $trtp
      "A" = "Placebo"
      "B" = "Old Drug"
      "C" = "New Drug";
run;
  
**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES.;



proc lifetest
   data=addeath plots=(survival);
    
   time aval * cnsr(1);
   strata trtp;
run;


proc print data=survivalplot;
title'Survival estimates table';
run;
title;


**** CALCULATE MONTH FOR PLOTTING.;
data survivalplot;
   set survivalplot;

      month = (time / 30.417);  *** = 365/12;
run;


proc print data=survivalplot;
title'Survival estimates table';
run;
title;

**** MODIFY THE STYLE TEMPLATE TO GET DESIRED LINES;
ods path sashelp.tmplmst(read) work.templat;

proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / contrastcolor=black
                     linestyle=3;
  class GraphData2 / contrastcolor=black
                     linestyle=4;
  class GraphData3 / contrastcolor=black
                     linestyle=1;
 end;
run;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods exclude none;
ods _all_ close;

**** CREATE THE PLOT DESIRED WITH PROC SGPLOT;
ods html 
 path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"               
 file="figure6.7.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_7" outputfmt=png;

**** PRODUCE KAPLAN MEIER PLOT;
proc sgplot
  data=survivalplot;

  step x=month y=survival /group=stratum;
  
  xaxis values = (0 to 48 by 6) minorcount=1 label='Months from Randomization';
  yaxis values = (0 to 1 by 0.1) minorcount=1 label='Survival Probability';

label stratum = "Treatment";
format stratum $trtp.;
title1 "Kaplan-Meier Survival Estimates for Death";
run;

ods graphics off;
ods html close;



**** PROGRAM 6.8;
**** INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA;
data ADDEATH;
label TRTP = "Planned Treatment"
      AVAL = "Analysis Value" /* "Days to Death" */
      CNSR = "Censor";
input TRTP $ AVAL CNSR @@;
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

proc print data=addeath (firstobs=1 obs=10);
title'INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA';
run;
title;

proc format;
   value $trtp
      "A" = "Placebo"
      "B" = "Old Drug"
      "C" = "New Drug";
run;
  
**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES.;

ods graphics;
ods exclude all;
ods output failureplot=failureplot;
proc lifetest
   data=addeath plots=(survival(failure));
    
   time aval * cnsr(1);
   strata trtp;
run;
ods output close;

proc print data=failureplot (firstobs=1 obs=10);
title 'Failure estimates table';
run;
title;

**** CALCULATE MONTH FOR PLOTTING.;
data failureplot;
   set failureplot;

      month = (time / 30.417);  *** = 365/12;
run;

proc print data=failureplot (firstobs=1 obs=10);
title 'Failure estimates table with month variable';
run;
title;

**** MODIFY THE STYLE TEMPLATE TO GET DESIRED LINES;
ods path sashelp.tmplmst(read) work.templat;

proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / contrastcolor=black
                     linestyle=3;
  class GraphData2 / contrastcolor=black
                     linestyle=4;
  class GraphData3 / contrastcolor=black
                     linestyle=1;
 end;
run;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods exclude none;
ods _all_ close;

**** CREATE THE PLOT DESIRED WITH PROC SGPLOT;
ods html 
 path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"         
 file="figure6.8.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_8" outputfmt=png;

**** PRODUCE KAPLAN MEIER PLOT;
proc sgplot
  data=failureplot;

  step x=month y=_1_survival_ /group=stratum;
  
  xaxis values = (0 to 48 by 6) minorcount=1 label='Months from Randomization';
  yaxis values = (0 to 1 by 0.1) minorcount=1 label='Probability of Death';

label stratum = "Treatment";
format stratum $trtp.;
title1 "Kaplan-Meier Failure Estimates for Death";
run;

ods graphics off;
ods html close;



**** PROGRAM 6.9;
**** INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA;
data ADDEATH;
label TRTP = "Planned*Treatment"
      AVAL = "Analysis*Value" /* "Days to Death" */
      CNSR = "Censor";
input TRTP $ AVAL CNSR @@;
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

proc print data=addeath (firstobs=1 obs=10) label split='*';
title 'INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA';
run;
title;

proc format;
   value $trtp
      "A" = "Placebo"
      "B" = "Old Drug"
      "C" = "New Drug";

   value stratumnum
      1 = "Placebo at Risk"
      2 = "Old Drug at Risk"
      3 = "New Drug at Risk";
run;

DATA ADDEATH;
	set ADDEATH;
	month = (aval / 30.417);  *** = 365/12;
RUN;

proc print data=addeath (firstobs=1 obs=10) label split='*';
title 'INPUT SAMPLE TIME TO DEATH AS CDISC ADAM ADDEATH DATA with month variable';
run;
title;


**** PERFORM LIFETEST AND EXPORT SURVIVAL ESTIMATES.;

ods graphics;
ods exclude all;
ods output survivalplot=survivalplot;
proc lifetest
   data=addeath plots=(survival(atrisk=0 to 48 by 6));
    
   time month * cnsr(1);
   strata trtp;
run;
ods output close;

proc print data=survivalplot (firstobs=1 obs=20);
title 'Lifetest survival estimates with tAtRisk variable (number of patients still at risk at 6 month time intervals) ';
run;
title;

**** MODIFY THE STYLE TEMPLATE TO GET DESIRED LINES;
ods path sashelp.tmplmst(read) work.templat;

proc template;
  define style newblue / store=work.templat; 
  parent=styles.htmlblue;
  
  class graph / attrpriority='none'; 

  class GraphData1 / contrastcolor=black
                     linestyle=3;
  class GraphData2 / contrastcolor=black
                     linestyle=4;
  class GraphData3 / contrastcolor=black
                     linestyle=1;
 end;
run;


**** CLOSE ODS DESTINATIONS SO ONLY ONE GRAPH IS PRODUCED;
ods exclude none;
ods _all_ close;

**** CREATE THE PLOT DESIRED WITH PROC SGPLOT;
ods html 
 path="/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code"
 file="figure6.9.html" image_dpi=300 style=newblue;

ods graphics on / reset imagename="figure6_9" outputfmt=png;

**** PRODUCE SURVIVAL PLOT WITH AT RISK IN LEGEND AREA;
proc sgplot
  data=survivalplot;

  step x=time y=survival /group=stratum;
  scatter x=tatrisk y=stratumnum / markerchar=atrisk y2axis group=stratumnum;

  xaxis values = (0 to 48 by 6) minorcount=1 label='Months from Randomization';
  yaxis values = (0 to 1 by 0.1) minorcount=1 label='Survival Probability' offsetmin=0.2 min=0;
  refline 0;
  y2axis offsetmax=0.83 display=(nolabel noticks) valueattrs=(size=8) values=(1 2 3);

label stratum = "Treatment";
format stratum $trtp. stratumnum stratumnum.;
title1 "Kaplan-Meier Survival Estimates for Death";
run;

ods graphics off;
ods html close;
ods pdf close;

