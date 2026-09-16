/*
   Issue Description: CDM-37334
   Category/ Module  : Assessments
   Root cause: User cannot see all assessments as role is not correct in teammember table.
   Customer Email: syreeta.williams1@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- syreeta.williams1@maryland.gov has CWSP & KINSHIPAPP roles. Team member record is mapped to KINSHIPAPP which is causing the issue.
update teammember
set roletypekey ='CWSP',
updatedby ='CDM-37334',
updatedon =now() 
where teammemberid ='2908aec9-195a-4f6d-9f8e-d3b205a83966';