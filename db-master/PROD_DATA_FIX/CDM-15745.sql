 /*
  Issue Description: CDM-15745 Worker in Wrong Unit
   Category/ Module  :  staff management
   Root cause: user asked to update the unit
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: teamid='40311c96-8b26-4585-9785-1be6f84c3c04'
*/
update teammember set teamid='d5deb313-5353-407d-928e-2be45d3d3b16', updatedby='CDM-15745',updatedon=now()  where 
teammemberid='a3c52cda-e356-4e45-b4cb-35f6eacdfe61' and teamid='40311c96-8b26-4585-9785-1be6f84c3c04';