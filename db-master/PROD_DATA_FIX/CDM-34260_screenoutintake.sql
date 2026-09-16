/*
   Issue Description: CDM-34260
   Category/ Module  : Dashboard
   Root cause: User wants to remove CPS-IR case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Screenout I231011106532 and 231021009651
UPDATE intakesnapshot
SET
updatedby = 'CDM-34260', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011106532' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-34260', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011106532' AND activeflag=1;

update routing
set routingstatustypeid = 8
where routingid = '8823fa8e-b723-438a-9e45-2a45695ca650' and objectid = 'I231011106532';

UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CDM-34260', updatedon = now() 
WHERE servicerequestnumber = '231021009651' AND intakeserviceid = '852f5a99-de79-4589-8dd2-27fd65f0cd32' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-34260'
WHERE objectid = '852f5a99-de79-4589-8dd2-27fd65f0cd32' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-34260', updatedon = now() 
where objectid = '852f5a99-de79-4589-8dd2-27fd65f0cd32';

update routing
set activeflag = 0, updatedby = 'CDM-34260', updatedon = now() 
where objectid = '852f5a99-de79-4589-8dd2-27fd65f0cd32' and activeflag = 1;
