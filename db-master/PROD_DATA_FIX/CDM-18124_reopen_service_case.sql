/*
   Issue Description: CDM-18124
   Category/ Module  :  case reopen
   Root cause: user asked to reope the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE personprogramarea 
SET enddate = null, updatedby = 'CDM-18124', updatedon = now() 
WHERE personprogramid = '5968375b-2221-44b2-96a0-ac44b414c3f3';

UPDATE servicecase 
SET statustypekey = 'Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-18124',
    updatedon = now() 
WHERE servicecaseid = 'f7669aa5-7fe6-4897-9990-8cc013978b31';

UPDATE servicecasedisposition 
SET activeflag = 0, 
    updatedby = 'CDM-18124',
    updatedon = now() 
WHERE servicecasedispositionid = '5635fa68-91e0-415a-974c-e00c4032fa42';