
/*
   Issue Description: CDM-15288
   Category/ Module  :  Updating the End date for person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-06-25 11:47:58
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-15288' where personprogramid = '07b165f2-0f2b-4097-b761-c2347700b6b4';

