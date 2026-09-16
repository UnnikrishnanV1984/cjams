/*
   Issue Description: CIDM-65826
   Category/ Module  : Prod data fix to update SSN information
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update person 
set ssnno = null, updatedby = 'CIDM-65826', updatedon = now()
where cjamspid ='204196028' and activeflag = 1;


update personidentifier 
set activeflag = 0, updatedby='CIDM-65826', updatedon=now()
where personid = 'dc12cca0-caf1-4c99-be99-e09b54b14ecd' and personidentifiertypekey='SSN' and activeflag=1;
