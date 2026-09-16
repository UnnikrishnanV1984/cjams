
/*
   Issue Description: CDM-18085
   Category/ Module  :Removing person program end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-10-05 00:00:00
update personprogramarea p set enddate = null, updatedby = 'CDM-18085', updatedon = now() where personprogramid = 'cef11ac3-d423-4c51-8456-f403cc2c6fd2';
