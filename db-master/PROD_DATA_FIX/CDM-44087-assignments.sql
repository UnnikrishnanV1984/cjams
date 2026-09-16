/*
   Issue Description: CDM-44087 
   Category/ Module  :Assignments
   Root cause:  End date assignment for the mentioned case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- 3284221
update caseassignment set enddate = '2025-01-22 16:31:12.963', updatedby = 'CDM-44087', updatedon = now() where caseassignmentid = '883671ff-a4e4-437c-9f31-038d68c4eb2f' and activeflag = 1 and enddate is null;
