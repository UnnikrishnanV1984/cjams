/*
   Issue Description: CDM-16991
   Category/ Module  :  
   Root cause: Reopening Service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-09-20 15:10:16	Closed	Closed
update servicecase 
set enddate = null, statustypekey = 'pending', dispositioncode = 'open', updatedon = now(), updatedby = 'CDM-16991'
where servicecaseid = '3a9637f8-b7ae-4d9a-9cd6-db2a4002a27f';

update servicecasedisposition
set activeflag = 0, updatedon = now(), updatedby = 'CDM-16991'
where servicecasedispositionid = 'e7c72d49-24b0-4ed4-a5e4-06248912766e';
