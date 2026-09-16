/*
   Issue Description: CDM-25637
   Category/ Module  : Intake screen out and delete the case
   Root cause: user wants to delete case and decision is screenout 
   Pull request# for code fix: 6517
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-25637', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010322653' AND activeflag=1;

--routingstatustypeid = 2
update routing set routingstatustypeid = 1,updatedby = 'CDM-25637', updatedon = now() where objectid = 'I221010322653' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-25637' , updatedon = now() where intakenumber = 'I221010322653' and activeflag = 1;


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-25637', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010322537' AND activeflag=1;

--routingstatustypeid = 2
update routing set routingstatustypeid = 1,updatedby = 'CDM-25637', updatedon = now() where objectid = 'I221010322537' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-25637' , updatedon = now() where intakenumber = 'I221010322537' and activeflag = 1;



UPDATE intakesnapshot 
SET 
updatedby = 'CDM-25637', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010321066' AND activeflag=1;

--routingstatustypeid = 2
update routing set routingstatustypeid = 1,updatedby = 'CDM-25637', updatedon = now() where objectid = 'I221010321066' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-25637' , updatedon = now() where intakenumber = 'I221010321066' and activeflag = 1;