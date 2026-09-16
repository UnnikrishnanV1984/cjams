/*
   Issue Description: CDM-24480
   Category/ Module  : Prod data fix to remove the provider details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 5078162
update guardianship set guardiantwoproviderid = null, updatedby = 'CDM-24480', updatedon = now() 
where gapid = '1169d776-6584-4045-966d-50b62d02ac6f';