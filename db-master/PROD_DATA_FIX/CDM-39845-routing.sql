/*
  Issue Description:  CDM-39845
   Category/ Module  :  Purchase Auth
   Root cause: Routing record is not deactivated on approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.routing
SET tosecurityusersid='753c40c4-34fd-4e88-9e2a-f974a416d51a', activeflag=0, updatedby='CDM-39845', updatedon=now()
WHERE routingid='5630bc56-f817-4f3e-888f-8ff8eca54ca5' and eventcode='PCAUTHR' and objectid='2546973';
