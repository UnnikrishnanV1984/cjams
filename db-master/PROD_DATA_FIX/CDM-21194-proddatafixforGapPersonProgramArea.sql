
/*
   Issue Description: CDM-21194
   Category/ Module  : Removing person program area for Gap case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2022-03-07 15:12:59
update personprogramarea set enddate = null, updatedby = 'CDM-21194', updatedon = now() where personprogramid = '6c362f75-039a-46fd-91c0-79e5f9a90f2b';
