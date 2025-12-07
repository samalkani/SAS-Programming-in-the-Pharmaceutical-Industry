# SAS-Programming-in-the-Pharmaceutical-Industry

Using SAS programming to import and massage data into (__Clinical Data Interchange Standards Consortium (CDISC))__ analysis data sets  (__Study Data Tabulation Model (SDTM)__ and __Analysis Data Model (ADaM)__) and use these datasets to produce clinical trial output and to export data

## Organisation of the repository

1. __SAS Codes by Chapter__
2. __Individual chapters__
   
   * __SAS Output__ - from SAS code
   * __CDISC datasets__ - either STDM or ADaM datasets
   * __SAS datasets__ - Non-CDISC datasets

## Chapter Contents

1. __Chapter 1__ - __Subsetting dataset for patients with adverse events (AE)__, Use of SAS Macros
2. __Chapter 2__ - Categorizing numeric data, __Summarizing Adverse event data__ (free text and coded)
3. __Chapter 3__ - Using SAS code to __import Lab Normal Data__, Using LIBNAME to import Microsoft (MS) Excel data and MS Access Data. Use of PROC IMPORT to read an MS Excel file. SQL Pass-Thorough Facility to read MS Excel and Access data. Use of XML LIBNAME Engine to Read XML Data. Use of PROC COPY to read SAS Transport File.
4. __Chapter 4__ - Deriving __Last Observation Carried Forward (LOCF) Variables__, __Calutating Study Day__. __Deriving Analysis Visit based on Visit Windowing__. Transposing data using PROC TRANSPOSE. __Summary of Analysis Data where unknown equals Zero or Missing__. Performing Many-to-Many join with PROC SQL. __Bringing MEDRA Dictionary Tables together__. __Pulling preferred terms out of WHO Drug__. Implicit or Explicit Centuries with dates. Properly defining a variable within a DATA step. Using the ROUND function with floating-point comparisons. __Blood Pressure Change-from-Baseline data set__. Creating __Time-toEvent data set for seizures__.
5.  __Chapter 5__ - Using PROC TABULATE and PROC REPORT to create summary of Demographics. Creating __summary of Demographics, Adverse Events by Maximum Severity and Concomitant Medications__. Creating __Laboratory Shift Table, Kaplan-Meier (KM) Survival Estimates Table__. Listing of Demographic Data using PROC REPORT.
6.  __Chapter 6__ Creating __Laboratory Data Scatter Plot__ and __Clinical Response Line Plot__ using PROC SGPLOT. Creating __Clinical Response Bar Chart__ Using PROC SGPANEL. Creating a __Box Plot__ and a __Forest Plot__ using PROC SGPLOT. Creating a Forest Plot using PROC LOGISTIC. Creating __KM Survival Estimates and KM Failure Estimates Plots__ using PROC SGPLOT. Creating __KM Survival Estimates Plot with patients remaining at risk__ using PROC SGPLOT. Creating KM Survival Estimates Plot using LIFETEST.
7.  __Chapter 7__ Using PROC FREQ and PROC UNIVARIATE to export __descriptive statistics__. Creating __inferential statistics from Categorical Data Analysis__ by performing; 2 x 2, N x P, Stratified N x P test for association and logistic regression. Creating __inferential statistics from Continuous Data Analysis__ by performing; One sample test of the mean, two sample test and N-sample test of the Means. __Time-to-Event Analysis statistics__. __Correlation Co-efficients__, and also a general approach to obtaining statistics.
8. __Chapter 8__ __Exporting Data to the FDA__; SAS XPORT Transport Format, creating ODM XML and define.xml. __Exporting Data not destined for the FDA__; PROC CPORT, ASCII Text, MS Office files and other proprietary data formats. 
