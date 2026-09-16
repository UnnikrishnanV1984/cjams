/*
   Issue Description: CDM-16826
   Category/ Module  :  case reopen
   Root cause: user asked to reope the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE servicecase 
SET statustypekey = 'Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-16826',
    updatedon = now() 
WHERE servicecaseid = 'f8f5e351-de16-47a7-a874-d813b1509fab';

UPDATE servicecasedisposition 
SET activeflag = 0, 
    updatedby = 'CDM-16826',
    updatedon = now() 
WHERE servicecasedispositionid = '0632bcd4-b0e2-4317-9ee9-1ba975b470a0';