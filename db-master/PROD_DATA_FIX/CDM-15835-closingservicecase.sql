/*
   Issue Description: CDM-15835
   Category/ Module  :  Closing Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Closed	Closed	2021-08-06 20:16:01
UPDATE servicecase SET statustypekey = 'Open', dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-15835',
    updatedon = now() 
WHERE servicecaseid = '9fffd601-6bbd-48c8-865c-250986e847b0';
update servicecasedisposition set activeflag = 0, updatedon=now(), updatedby='CDM-15835' where servicecasedispositionid = '823e22c3-89c6-45ba-ab6f-864feb24cb40'
