/*
  Issue Description: CDM-21335 Missing worker
   Category/ Module  :  user management
   Root cause: The teamid is overwritten with CW team id instead of AS team id
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 2043ef00-ecf3-43ec-be69-2d6652742bf1
*/
-- email: romondo.gordon@maryland.gov

update teammember set teamid ='8ef1f01c-c6e2-4887-ab89-b796c17a19de', updatedby='CDM-21335',updatedon = now() where teammemberid ='9beef45a-0965-425d-9f66-3d036a61e34c' and roletypekey ='ASCW';