/*
   Issue Description: CDM-16591
   Category/ Module  : Approval inbox 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  removed from approval inbox as its already approved 
   
*/

--2020-10-28 00:00:00
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-16591' where personprogramid = '35c95e62-a19f-4334-918a-c32db25503b6';


