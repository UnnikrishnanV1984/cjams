/*
   Issue Description: 'CDM-15372'
   Category/ Module  :  Unable to add head of household
   Root cause: there is an existing head of household flag for an existing role for the person, so use is unable to change to different person.
   Pull request# for code fix: 
   Reason why no related code fix: 
    unable to reproduce this issue
*/
update intakeservicerequestactor 
set isheadofhousehold = false,
updatedby = 'CDM-15372',
updatedon = now()
where intakeservicerequestactorid = '298d57d3-a562-4977-8cfe-f7788c373cc8';