%let path=/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code; 
libname pharma "&path";

Libname sdtm "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/";
Libname dm xport "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/dm.xpt";

**********PROC COPY METHOD TO CREATE A TRANSPORT FILE.;
proc copy
	in = sdtm
	out = dm;
		select dm;
run;

**** PROGRAM 8.2;
***** THIS SAS MACRO CREATES A SERIES OF SAS XPORT FILES.;
***** PARAMETERS:  libname = raw data libref;
*****              dset    = name of data set;
%macro makexpt(libname=, dset=);
    
libname &dset xport "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/time.xpt";

   proc copy
      in = &libname
      out = &dset;
         select &dset;
   run;

%mend makexpt;

**** MAKEXPT CALLS;
%makexpt(libname = pharma, dset = DM)
%makexpt(libname = pharma, dset = time)


libname library "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/";
filename tranfile "/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code/Pharma.xpt";

*********COPY ALL SAS DATA SETS AND PERMANENT FORMATS FROM LIBRARY
*********INTO MYTRIAL.XPT;

proc cport
	Library = library
	File = tranfile;
	Exclude sasmacr;
run;

%let path =/home/ajay_malkani0/SAS Programming in the Pharmaceutical Industry/Data Sets and SAS code;
libname pharma "&path";

proc export data=pharma.time
			outfile="C/Users/Ajay_/Downloads/time.csv"
			dbms=csv replace; 
			putnames=yes;
run;


