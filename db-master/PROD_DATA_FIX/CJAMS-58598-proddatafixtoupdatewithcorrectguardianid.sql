/*
   Issue Description: CJAMS-58598
   Category/ Module  : Prod data fix to update with the correct guardian id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update gapeligibilityinfo set activeflag = 0, updatedby = 'CJAMS-58598', updatedon = now()
where client_id = '3916158' and activeflag = 1 and guardian_subsidy_id = '1005532'; 
