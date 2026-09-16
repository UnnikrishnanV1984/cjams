/*
   Issue Description: CDM-25491
   Category/ Module  : case assignment
   Root cause: user wants to re-assign case 
   Pull request# for code fix: 6593
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update caseassignment 
set toworkeridno = '22417e18-7b17-4bce-aa0a-e6c68eae7426',
    updatedby = 'CDM-25468',
    updatedon = now()
where caseassignmentid = '6134fbd7-f096-4fd2-9154-02ede43bf7df';