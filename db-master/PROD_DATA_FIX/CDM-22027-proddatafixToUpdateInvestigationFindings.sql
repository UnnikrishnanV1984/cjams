/*
   Issue Description: CDM-22027
   Category/ Module  : Prod data fix to update Investigation Findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- UD
update investigationfinding 
set investigationfindingtypekey = 'ID', updatedby = 'CDM-22027', updatedon = now()
where investigationfindingid = '1176c07c-834e-473b-b208-c0781a12f5af';