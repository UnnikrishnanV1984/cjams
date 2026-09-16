/*
   Issue Description: CDM-31791
   Category/ Module  :Intake 
   Root cause: Intake # I231010627437 is not available in Prod environment.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update intakedastatus set intakeuser='96c95c04-2bc7-4d70-a923-262b748b275f',updatedby='CDM-31791',updatedon=now() 
where intakedastatusid='252fcc4a-e816-4240-aae2-a0dc2b6dd402';
