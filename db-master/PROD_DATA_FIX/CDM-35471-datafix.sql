/*
   Issue Description: CDM-35471
   Category/ Module  : Child Welfare
   Root cause: Delete this CPS IR case and Override screen Out the Intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 



-- Remove the CPS AR Case # 231021314533 from CJAMS

UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CDM-35471', updatedon = now() 
WHERE servicerequestnumber = '231021314533' AND intakeserviceid = 'e4f7b9b0-8dd7-4109-b3a9-6e7a8d207df2' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-35471'
WHERE objectid = 'e4f7b9b0-8dd7-4109-b3a9-6e7a8d207df2' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-35471', updatedon = now() 
where objectid = 'e4f7b9b0-8dd7-4109-b3a9-6e7a8d207df2';

update routing
set activeflag = 0, updatedby = 'CDM-35471', updatedon = now() 
where objectid = 'e4f7b9b0-8dd7-4109-b3a9-6e7a8d207df2' and activeflag = 1;

-- Delete and Override screen Out the Intake.

UPDATE intakesnapshot
SET
updatedby = 'CDM-35471', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011432259' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35471', updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011432259' AND activeflag=1;

-- submisiion status to be closed
update routing set routingstatustypeid =8 where objectid='I231011432259' and activeflag=1;