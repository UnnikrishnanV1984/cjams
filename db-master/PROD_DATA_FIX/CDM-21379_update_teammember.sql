/*
  Issue Description:  CDM-21379(DAM-10191) Team assignment issue
   Category/ Module  :  user management
   Root cause: The teamid is overwritten with AS team id instead of CW team id
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
-- email: nailah.dawkins@maryland.gov

update teammember set teamid ='60296e7e-5bb8-40b2-9bba-bb8a87a325c9', updatedby='CDM-21379',updatedon = now() where teammemberid ='ce139193-0cd1-4f34-afb2-557500f32924' and roletypekey ='CWCW';