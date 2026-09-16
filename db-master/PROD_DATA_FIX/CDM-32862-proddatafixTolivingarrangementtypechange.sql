/*
   Issue Description: CDM-32862
   Category/ Module  : Prod data fix to update living arrangment details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- FCH
update livingarrangement set livingarrangementtypekey = 'RFKH', updatedby = 'CDM-32862', updatedon= now()
where placementid = '8fad4a33-4b56-4e5f-9190-d24265f80f86';
