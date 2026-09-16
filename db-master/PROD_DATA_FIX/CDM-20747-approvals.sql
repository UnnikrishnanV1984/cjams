/*
   Issue Description: CDM-20747
   Category/ Module  :  Approvals
   Root cause: user have a pending approval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-20747',
    updatedon = now()
where
    routingid IN (
        'cf0b5c63-6a39-4b48-ae7c-08a64e278dbf',
        '3d6e1b83-19d3-49d4-846a-cd6025fd60ea'
    );