/*
   Issue Description: CDM-18285
   Category/ Module  : case reopened 
   Root cause: user requeseted to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-18285',updatedon = now() 
WHERE servicecaseid = '62ccc7ef-a04f-47eb-a2b8-3131c03ebe8d';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-18285',updatedon = now() 
where servicecasedispositionid = '1046e4fa-2974-4d5a-b8fd-ff97792be174';

update personprogramarea set enddate = null, updatedby = 'CDM-18285', updatedon = now() 
where personprogramid = '20839db1-89b2-437e-b02a-9d9cdd09672a';