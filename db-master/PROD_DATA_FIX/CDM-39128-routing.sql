/* 
  Issue Description: CDM-39128
  Category/ Module  :Finance 
  Root cause: Routing updated 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

UPDATE cjams.routing
SET  activeflag=1, updatedby='CDM-39128', updatedon=now()
WHERE routingid='c11c0561-34b3-476e-837d-da837b459b45' and objectid='3198127';
