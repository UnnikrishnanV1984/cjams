/*
  Issue Description:  CDM-40756
   Category/ Module  :  Application
   Root cause:  Need to disable IV-E case closure review when the service case id is different.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
updatedby = 'CDM-40756',
updatedon = now() 
WHERE objectid='0288c520-2907-4f2a-825e-576238592c0d'
and activeflag = 1;


UPDATE cjams.routing
SET   activeflag = 0,
updatedby = 'CDM-40756',
updatedon = now() 
WHERE routingid='62d412a1-90eb-4bf2-926c-5970840a3833'
and activeflag = 1;