/*
   Issue Description: CDM-18247
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase 
set statustypekey ='Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-18247',
    updatedon = now() 
where servicecaseid = 'a127239b-eb4f-4756-98a5-3e8d5a6c29f1';

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CDM-18247',
    updatedon = now() 
where servicecasedispositionid = '81e229ad-8bf7-48a5-a7a2-2c5328736027';


