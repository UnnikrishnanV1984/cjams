/*
   Issue Description: CDM-25769
   Category/ Module  : program area
   Root cause: user wants to remove the record which is created wrongly
   Pull request# for code fix: 6644
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/

UPDATE personprogramarea 
SET activeflag = 0, updatedby = 'CDM-25769', updatedon = now()
WHERE personprogramid = 'e84e7538-b31f-490e-8d62-c04fc75824a8';