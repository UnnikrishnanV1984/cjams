/*
   Issue Description: CDM-27258
   Category/ Module  : Intake screen out 
   Root cause: user wants to update supervisor decision to screenout 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- Not Required to update snapshot since the case is still pending
--select 	jsondata, activeflag, *
--from 	intakesnapshot
--WHERE 	intakenumber = 'I221010345409';
--
--UPDATE 	intakesnapshot 
--SET 	updatedby = 'CDM-27258', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
--        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
--        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
--        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
--WHERE 	intakenumber = 'I221010345409';
--

select 	status, * 
from 	intakedastaging
where 	intakenumber = 'I221010345409' and activeflag = 1;

update 	intakedastaging 
SET 	updatedby = 'CDM-27258', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I221010345409' and activeflag = 1;

--
--select 	activeflag, *
--from 	intakeservicerequest
--where 	servicerequestnumber = '221020281953';
--
--update 	intakeservicerequest set activeflag =0, updatedby = 'CDM-27258', updatedon = now() 
--where 	servicerequestnumber = '221020281953' and activeflag =1;
--
--select  activeflag, * 
--from 	personprogramarea
--where 	objectid in (select intakeserviceid::character varying
--    		from intakeservicerequest where servicerequestnumber = '221020281953')
--and 	activeflag = 1;
--
--update 	personprogramarea set activeflag = 0, updatedby = 'CDM-27258', updatedon = now()
--where 	objectid in (select intakeserviceid::character varying
--    		from intakeservicerequest where servicerequestnumber = 221020281953)
--and 	activeflag = 1;

