/*
   Issue Description: CDM-23627
   Category/ Module  : Intake to service case 
   Root cause: user wants records to move form intake to service case 
   Pull request# for code fix: 6036
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakesnapshot
SET
updatedby = 'CDM-23627', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010275539' AND activeflag=1;

update intakeservicerequest i 
set servicecaseid =null, updatedby = 'CDM-23627', updatedon = now() 
where intakeserviceid ='5597d77f-7ee5-4f15-a764-cde9b9b3eb3e';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-23627', updatedon = now()
where intakenumber = 'I221010275539' and activeflag = 1;

update intakeservicerequest 
set servicecaseid = 'f7eed5e3-1da9-4d49-b76e-2897630ff1bc', activeflag = 1, updatedby = 'CDM-23627', updatedon = now()
where intakeserviceid = '42294135-6412-4bd1-9d3b-b0a528b7b868';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('51968098-aa92-4b16-8e01-c11e654691d6', 'fecea2d0-09c2-4ec3-8a71-e1bfd035c8d8', now()::date, 'Closed', 'Closed', 'Case Closed', now()::date, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-23627', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, NULL, NULL, '51968098-aa92-4b16-8e01-c11e654691d6', 16, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-23627', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now()::date, updatedby = 'CDM-23627',updatedon = now() WHERE servicecaseid = 'fecea2d0-09c2-4ec3-8a71-e1bfd035c8d8' and activeflag = 1;