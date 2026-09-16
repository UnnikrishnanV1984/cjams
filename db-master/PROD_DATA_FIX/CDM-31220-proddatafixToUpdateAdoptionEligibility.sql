/*
   Issue Description: CDM-31220
   Category/ Module  : Prod data fix to update adoption eligibility
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioninitialeligibilityinfo set activeflag = 0, updatedby = 'CDM-31220', updatedon = now()
where clientid = '3712180' and activeflag = 1;