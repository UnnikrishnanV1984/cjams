/*
-- CDM-26530 - 

-- Issue Description: 
 We need a Data Fix to Override ScreenOut this Intake I221010336289 and delete the CPS AR Case 221020272930.
Also need to make sure the Program Assignment related to the CPS AR case 221020272930 need to be deleted from the person program Assignment.
  
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--- Override ScreenOut this Intake I221010336289
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-14022', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I221010336289') AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-26530', updatedon = now() where intakenumber ='I221010336289';


-- DELETE CPS AR CASE
update intakeservicerequest set activeflag =0, updatedby = 'CDM-26530', updatedon = now() 
where servicerequestnumber = '221020272930' and activeflag =1;


--deleted from the person program Assignment.

update cjams.personprogramarea  
set updatedby = 'CDM-26530' , updatedon = now()
where personprogramid = '4f2b39b6-b970-46f7-80d5-70dd7c1f4ad7' and personid = 'e7ab6ffe-d571-465e-a1b9-a3f498952a81';

update cjams.personprogramarea  
set updatedby = 'CDM-26530' , updatedon = now()
where personprogramid = '623e0d32-e2c3-4ef3-ba58-b1f2b340d61d' and personid = '9e786f11-f9f9-4ef7-932b-17f5ca0bc7fd';

update cjams.personprogramarea 
set updatedby = 'CDM-26530' , updatedon = now()
where personprogramid = '600c5919-ecae-4cf4-b16d-24000b4ff3d9' and personid = '90e4d05b-304a-42f2-8dd5-a505f2eb5dea';
