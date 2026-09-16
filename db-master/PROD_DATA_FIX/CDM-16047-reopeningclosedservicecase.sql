/*
   Issue Description: CDM-16047
   Category/ Module  :  Reopening Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Closed, Closed	
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16047',updatedon = now() WHERE servicecaseid = 'e4cf9fda-b06f-4432-937c-face07f7eab7';

update servicecasedisposition set activeflag =0, updatedby = 'CDM-16047',updatedon = now() where servicecasedispositionid in ('f626c8f8-b6cc-454d-8427-c81e6beaee35');