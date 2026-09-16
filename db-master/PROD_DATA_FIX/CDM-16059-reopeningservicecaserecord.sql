
/*
   Issue Description: CDM-16059
   Category/ Module  :  Reopening Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Closed, Closed	
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16059',updatedon = now() WHERE servicecaseid = '0940b891-15cc-4bde-9a4f-ad5dbf77ac96';

update servicecasedisposition set activeflag =0, updatedby = 'CDM-16059',updatedon = now() where servicecasedispositionid in ('1f0cf806-4f74-4de6-a184-80b7f1259920');