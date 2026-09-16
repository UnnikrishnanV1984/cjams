/*
-- CDM-23898- 

-- Issue Description: 
 supervisor decision should ne changed to screenout

-- Customer Email ID: cheryl.paige@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# 5973
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-23898', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010275753' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-23898', updatedon = now()  where intakeserviceid = '134e7001-1d4b-4a07-8cbc-7eb84f29ede5' and activeflag = 1;
