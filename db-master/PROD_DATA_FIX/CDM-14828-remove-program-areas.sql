/*
   Issue Description: CDM-14828
   Category/ Module  :  wrong person program areas for person 
   Root cause: wrongly created case added unwanted program area
   Pull request# for code fix: 
   Reason why no related code fix: 
    One of issue, user requested removal of wrong program areas
*/
update personprogramarea 
set
activeflag = 0,
updatedby = 'CDM-14828',
updatedon = now()
where personprogramid in ('ddc4df2a-10b5-4e35-9a94-a567c7cd41cf', '96efd555-3439-4103-a418-3678ccb11f2e');