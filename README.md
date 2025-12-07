# SAS-Programming-in-the-Pharmaceutical-Industry

Using SAS programming to import and massage data into (Clinical Data Interchange Standards Consortium (CDISC)) analysis data sets  (Study Data Tabulation Model (SDTM) and Analysis Data Model (ADaM)) and use these datasets to produce clinical trial output and to export data

## Organisation of the repository

1. SAS Codes by Chapter
2. Individual chapters
   
   * SAS Output from SAS code
   * CDISC datasets - either STDM or ADaM datasets
   * SAS datasets - Non-CDISC datasets

## Chapter Contents

1. __Chapter 1__ - Subsetting dataset for patients with adverse events (AE), Use of SAS Macros
2. __Chapter 2__ - Categorizing numeric data, Summarizing Adverse event data (free text and coded)
3. __Chapter 3__ - Using SAS code to import Lab Normal Data, Using LIBNAME to import Microsoft (MS) Excel data and MS Access Data. Use of PROC IMPORT to read an MS Excel file. SQL Pass-Thorough Facility to read MS Excel and Access data. Use of XML LIBNAME Engine to Read XML Data. Use of PROC COPY to read SAS Transport File.
4. __Chapter 4__ - Deriving Last Observation Carried Forward (LOCF) Variables, Calutating Study Day. Deriving Analysis Visit based on Visit Windowing. Transposing data using PROC TRANSPOSE. Summary of Analysis Data where unknown equals Zero or Missing. Performing Many-to-Many join with PROC SQL. Bringing MEDRA Dictionary Tables together. Pulling preferred terms out of WHO Drug. Implicit or Explicit Centuries with dates. Properly defining a variable within a DATA step. Using the ROUND function with floating-point comparisons. Blood Pressure Change-from-Baseline data set. Creating Time-toEvent data set for seizures.
5.  __Chapter 5__ - Using PROC TABULATE and PROC REPORT to create summary of Demographics. Creating summary of Demographics, Adverse Events by Maximum Severity and Concomitant Medications. Creating Laboratory Shift Table, Kaplan-Meier (KM) Survival Estimates Table. Listing of Demographic Data using PROC REPORT.
6.  __Chapter 6__ Creating Laboratory Data Scatter Plot and Clinical Response Line Plot using PROC SGPLOT. Creating Clinical Response Bar Chart Using PROC SGPANEL. Creating a Box Plot and a Forest Plot using PROC SGPLOT. Creating a Forest Plot using PROC LOGISTIC. Creating KM Survival Estimates and KM Failure Estimates Plots using PROC SGPLOT. Creating KM Survival Estimates Plot with patients remaining at risk using PROC SGPLOT. Creating KM Survival Estimates Plot using LIFETEST.
7.  __Chapter 7__ Using PROC FREQ and PROC UNIVARIATE to export descriptive statistics. Creating inferential statistics from Categorical Data Analysis by performing; 2*2, N*P, Stratified N*P test for association and logistic regression. Creating inferential statistics from Continuous Data Analysis by performing; One sample test of the mean, two sample test and N-sample test of the Means. Time-to-Event Analysis statistics. Correlation Co-efficients, and also a general approach to obtaining statistics.
8. __Chapter 8__ Exporting Data to the FDA; SAS XPORT Transport Format, creating ODM XML and define.xml. Exporting Data not destined for the FDA; PROC CPORT, ASCII Text, MS Office files and other proprietary data formats. 
