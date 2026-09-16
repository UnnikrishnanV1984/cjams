/*
   Issue Description: CDM-34968
   Category/ Module  : Prod data fix to update Investigation Findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- RO
update investigationfinding 
set investigationfindingtypekey = 'ID', updatedby = 'CDM-34968', updatedon = now()
where investigationfindingid = '4e98e8fd-358e-49f2-b567-c3fd53ac1f3b';