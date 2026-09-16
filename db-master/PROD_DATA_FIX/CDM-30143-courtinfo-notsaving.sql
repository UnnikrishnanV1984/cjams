
/*
   Issue Description: CDM-30143
   Category/ Module  : Prod data fix to update intakeservreqactorid
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqcourtorder 
set intakeservicerequestactorid = 'd20f60a9-60a2-4a26-adba-1b7ffb6d925e',
updatedby ='CDM-30143',
updatedon = now()
where intakeservicerequestpetitionid = '779bcd79-22bb-49b6-b1e3-5d79cf44167e' and intakeservicerequestactorid = 'd3d0d3d5-5e53-4ca0-b674-7281408fc958';

update intakeservicerequestpetitionactor 
set intakeservicerequestactorid = 'd20f60a9-60a2-4a26-adba-1b7ffb6d925e',
updatedby ='CDM-30143',
updatedon = now()
 where  intakeservicerequestpetitionid = '779bcd79-22bb-49b6-b1e3-5d79cf44167e' and intakeservicerequestactorid = 'd3d0d3d5-5e53-4ca0-b674-7281408fc958';