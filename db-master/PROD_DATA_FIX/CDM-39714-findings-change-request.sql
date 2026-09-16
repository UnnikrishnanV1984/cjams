/*
   Issue Description: CDM-39714
   Category/ Module  : Prod data fix to update Investigation Findings
   Root cause:  Wrong Finding Selected
   Pull request# for code fix: 
   Reason why no related code fix: Wrong Finding Selected so only data fix
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- RO
update investigationfinding 
set investigationfindingtypekey = 'RO', updatedby = 'CDM-39714', updatedon = now()
where investigationfindingid = 'd4841ce1-aa6b-4269-b6c2-e3dbbae09341';