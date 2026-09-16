/*
  Issue Description:  CDM-43702
   Category/ Module  :  Approval
   Root cause:User request to do a data fix  to update the status and supervisor decision 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

UPDATE intakedastaging
SET updatedby = 'CDM-43702', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013205964' AND activeflag=1;

update cjams.routing 
set routingstatustypeid = 8
where routingid ='681777c5-e372-43fa-af70-466df713f129' and objectid = 'I251013205964' and activeflag = 1;
