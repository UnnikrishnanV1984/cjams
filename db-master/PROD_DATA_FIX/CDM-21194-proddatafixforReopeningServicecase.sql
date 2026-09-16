
/*
   Issue Description: CDM-21194
   Category/ Module  : Reopening Closed Case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--Closed	Closed	2022-03-07 20:12:59
UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-21194',updatedon = now() 
WHERE servicecaseid = '588c03bf-1668-44aa-8391-a5f317bd57fa';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-21194',updatedon = now() 
where servicecasedispositionid = '2d308124-fbe0-4e64-bf85-6ac30472da55';