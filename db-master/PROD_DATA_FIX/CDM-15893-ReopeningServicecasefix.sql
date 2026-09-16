
/*
   Issue Description: CDM-15893
   Category/ Module  :  Reopening service case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Closed, Closed	
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15893',updatedon = now() WHERE servicecaseid = '8ee873d6-2ab9-4bfe-a542-2016e48182f5';

update servicecasedisposition set activeflag =0, updatedby = 'CDM-15683',updatedon = now() where servicecasedispositionid in ('69fdf8de-a31d-4184-92bb-e7b2124e861b');