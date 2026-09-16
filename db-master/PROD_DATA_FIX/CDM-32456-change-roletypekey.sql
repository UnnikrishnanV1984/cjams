/*
  Issue Description:  CDM-32456(DAM-10191) Team assignment issue
   Category/ Module  :  Services/YTP
   Root cause: Unable to select supervisor to submit YTP
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
-- email: nailah.dawkins@maryland.gov

update teammember set roletypekey ='CWCW', updatedby='CDM-32456',updatedon = now() where teammemberid ='202b5eae-3e0d-4e61-a433-a9e3d326d026';