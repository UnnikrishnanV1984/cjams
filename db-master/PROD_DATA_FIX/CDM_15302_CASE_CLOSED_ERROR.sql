/*
   Issue Description: CDM-15376
   Category/ Module  :  Case removal from decission tab  and reopend the service case
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15302',updatedon = now() 
WHERE servicecaseid = 'e07639c9-0add-48d2-b111-6e592b6441ab';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-15302',updatedon = now() 
where servicecasedispositionid = 'fc71b526-b15e-409e-9e9d-eed592cb6e74';