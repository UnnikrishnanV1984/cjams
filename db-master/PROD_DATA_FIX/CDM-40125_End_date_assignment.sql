/*
   Issue Description: CDM-40125
   Category/ Module  :Assignments
   Root cause:  End date family assignment.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update caseassignment
set enddate='2024-06-26 04:00:00.000',updatedby='CDM-40125', updatedon=now()
where caseassignmentid='5f5fe920-5b9d-4990-8237-0e889f04bdd4' and activeflag=1;