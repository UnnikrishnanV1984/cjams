/*
   Issue Description: CDM-26673
   Category/ Module  : Assignments
   Unit Name being incorrectly identified for Assignments
   Root cause: user wants to change the Unit name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Unit name should be changed, Need to do data fix.
*/

update
    caseassignment
set
    toteamid = '72083324-dd09-4aa8-afa3-b4d24aa63148',
    updatedby = 'CDM-26673',
    updatedon = now()
where
    caseassignmentid  = '56eea58f-4463-4faf-945e-d37f29de2a42';
