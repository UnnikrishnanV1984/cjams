/*
  Issue Description:  CDM-40925
   Category/ Module  :  Application
   Root cause:  Reverted the IV-E Case closure review request sent
    to IV-E Supervisors through code fix and data fix is done to remove from Total cases
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


UPDATE cjams.routing
SET   activeflag = 0,
updatedby = 'CDM-40925',
updatedon = now() 
WHERE routingid='47ccba33-5a9e-4c16-856f-52edb16b86c5'
and activeflag = 1;

UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
updatedby = 'CDM-40925',
updatedon = now() 
WHERE objectid='e78fd8a4-e22d-4469-8115-c6bf7e6d157a'
and activeflag = 1;