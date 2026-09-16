/*
   Issue Description: CDM-29323
   Category/ Module  : permanency plan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


 update permanencyplan
set intakeservicerequestactorid='8dffb583-8bd8-4c68-b051-5111538669fd', updatedby = 'CDM-29323', updatedon= now ()
where permanencyplanid='78b3abc8-0794-4a3c-9a5e-1b825203cf14';