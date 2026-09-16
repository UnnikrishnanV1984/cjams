/*
   Issue Description: CDM-15281
   Category/ Module  :  Case worker  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval
set updatedby = 'CDM-15281', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '33b2e7ee-2934-4b0e-aa34-11ecd5a1aa37';
