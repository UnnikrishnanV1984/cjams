/*
   Issue Description: CDM-16043
   Category/ Module  :  Reopening Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Closed, Closed	
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16043',updatedon = now() WHERE servicecaseid = 'a083a12f-f2af-435c-bc54-f19b68cbe853';

update servicecasedisposition set activeflag =0, updatedby = 'CDM-16043',updatedon = now() where servicecasedispositionid in ('d25b8584-ae91-48ab-8d48-88641e9293c3');