**************************************************************************************************;
*Step 5) Generate report;
**************************************************************************************************;

  ods rtf file = "Cohort\3-results\2-eda-ltfu Dec 31 2014.rtf";

  *Contact Type by year;
    proc freq data = cohort.DeathLTFUCohort;
      tables laststatus*lastyear /missing norow nocol;
      title 'JHS Participant Mortality Information through 12-31-2014';
      footnote;
      run;

  *Number of participants lost to follow-up;
    proc freq data = cohort.DeathLTFUCohort;
      tables laststatus*ltfuIND /missing norow nocol;
      title 'JHS Participant Last Contact Status through 12-31-2014';
      footnote 'Note: Lost to Follow-up is defined as no contact in > 2 years';
      run;

  ods rtf close;
