/*
   Issue Description: CDM-33526
   Category/ Module  : Prod data fix to remove duplicate case assignment
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update caseassignment set activeflag = 0, updatedby = 'CDM-33526', updatedon = now()
where caseassignmentid = 'db2f3214-cb37-4c73-b225-65d3607c4363' and activeflag = 1;