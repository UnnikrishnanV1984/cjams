/*
   Issue Description: CDM-37485
   Category/ Module  : Assessments
   Root cause: User cannot see all assessments as role is not correct in teammember table.
   Customer Email: renee.pierson2@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- renee.pierson2@maryland.gov has CWCW & LDSSSP roles. Team member record is mapped to LDSSSP which is causing the issue.
update teammember
set roletypekey ='CWCW',
updatedby ='CDM-37485',
updatedon =now() 
where teammemberid ='5724b6a1-436e-4e03-bff2-c637117695c2';