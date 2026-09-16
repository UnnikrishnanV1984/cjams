/*
   Issue Description: CDM-37241
   Category/ Module  : Assessments
   Root cause: User cannot see all assessments as role is not correct in teammember table.
   Customer Email: stephanie.cooke1@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- stephanie.cooke1@maryland.gov has CWSP & LDSSSP roles. Team member record is mapped to LDSSSP which is causing the issue.
update teammember
set roletypekey ='CWSP',
updatedby ='CDM-37241',
updatedon =now() 
where teammemberid ='8215acae-977e-42e9-8443-6e638a4b3d11';