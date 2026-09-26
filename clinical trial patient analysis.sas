data clinical_trial;
RETAIN SUBJID AGE SEX TRTGRP SITE WEIGHT STATUS;
length STATUS$ 20;
input SUBJID$ AGE SEX$ TRTGRP$ SITE$ WEIGHT STATUS$;
datalines;
SUBJ001 24 F Placebo S01 52.5 Complete
SUBJ002 35 M Active  S01 76.2 Complete
SUBJ003 42 F Active  S02 61.4 Complete
SUBJ004 29 M Placebo S02 82.1 Withdrawn
SUBJ005 51 F Active  S01 58.7 Complete
SUBJ006 38 M Placebo S03 79.5 Complete
SUBJ007 46 F Active  S03 64.3 Complete
SUBJ008 31 M Placebo S01 71.8 Complete
SUBJ009 27 F Active  S02 55.6 Withdrawn
SUBJ010 60 M Placebo S03 88.4 Complete
SUBJ011 33 F Active  S01 63.2 Complete
SUBJ012 45 M Placebo S02 84.7 Withdrawn
SUBJ013 39 F Active  S03 59.8 Complete
SUBJ014 22 M Placebo S01 68.3 Complete
SUBJ015 54 F Active  S02 67.1 Complete
SUBJ016 41 M Placebo S03 91.2 Complete
SUBJ017 36 F Active  S01 56.9 Withdrawn
SUBJ018 48 M Placebo S02 77.6 Complete
SUBJ019 30 F Active  S03 62.4 Complete
SUBJ020 57 M Placebo S01 85.9 Complete
run;
proc print data=clinical_trial;
run;

/* filtering*/
data clean_data;
set clinical_trial(where=(TRTGRP='Active'));
run;
proc print data=clean_data;
run;

/* condition*/
data clean_data2;
set clean_data;
if Age>=40 and TRTGRP='Active';
run;
proc print data=clean_data2;
run;

/* sorting data in descending order*/
data clean_data3;
set clinical_trial;
run;
proc sort data=clean_data3;
by descending Age;
run;
proc print data=clean_data3;
run;

/*proc freq*/
data clean_data4;
set clean_data3;
run;
proc freq data=clean_data4;
tables TRTGRP SEX STATUS;
run;
/*proc mean*/
data mean1;
set clinical_trial;
run;
proc means data=mean1 mean min max;
var AGE WEIGHT; 
run;

/* group analysis*/
data clean_data5;
set clinical_trial;
run;
proc sort data=clean_data5;
by TRTGRP;
run;
proc means data=clean_data5;
by TRTGRP;
var AGE WEIGHT;
run;

/* creating new var by if*/
data trial_data;
set clinical_trial;
if  AGE<40 THEN AGEGRP='YOUNG';
ELSE IF AGE>=40 THEN AGEGRP='OLDER';
run;
proc print data=trial_data;
run;

/* filter+sort*/
data trial_data2;
set clinical_trial(where=(TRTGRP='Placebo' and STATUS='Complete'));
run;
proc sort data=trial_data2;
by descending WEIGHT;
run;
proc print data=trial_data2;
run;

/* to cal how many patients are 
active completed
   active withdrawn and 
   palcebo completed
   placebo withdrawn we use this condition*/
data report;
set clinical_trial;
run;
proc freq data=report;
tables TRTGRP*STATUS;
RUN;
proc print data=report;
run;

