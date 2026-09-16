/*
   Issue Description: CJAMS-59086
   Category/ Module  : Prod data fix to update with the intakeservicerequestactorid
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


   update placement set intakeservicerequestactorid = 'bf1dbb90-77ca-4d7e-bb75-a353a7976724', updatedby = 'CJAMS-59086', updatedon =  now() where placementid  = '8daa6b32-64ec-4738-ba40-c5013d3db626' 
   and intakeservicerequestactorid = 'b3aa5105-a24f-4828-9f5f-5e707991dd63';
   