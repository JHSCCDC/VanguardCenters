  proc freq data = events.DeathLTFUEvents;
    tables laststatus*lastyear /missing norow nocol;
    title 'JHS Participant Mortality Information through 12-31-2012';
    footnote;
    run;
