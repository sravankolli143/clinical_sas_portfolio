data patients;
input USUBJID $ AGE SEX $ TRTGRP $;
datalines;
SUBJ001 24 F Placebo
SUBJ002 35 M Active
SUBJ003 42 F Active
SUBJ004 29 M Placebo
SUBJ005 51 F Active
SUBJ006 38 M Placebo
SUBJ007 46 F Active
SUBJ008 31 M Placebo
run;
proc print data=patients;
run;

/* Summarize age */
proc means data=patients mean min max;
    var AGE;
run;

/* Count participants by treatment */
proc freq data=patients;
    tables TRTGRP SEX;
run;
