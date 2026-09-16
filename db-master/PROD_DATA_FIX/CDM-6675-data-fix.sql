INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, 
tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, 
responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, 
toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, 
entityopendate, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '101026f4-7611-49e4-9b87-032a9e78374c', NULL, 
'3d44f9c5-5902-4b11-9857-77e3438e4d9a', '6007428', NULL, '3943c9e9-a0ac-440a-b39a-95c8ae8651bd', '6007016', 
NULL, NULL, NULL, NULL, NULL, NULL, 'CW2731753', NULL, NULL, 'JLA601530', 'JLA601530', '2011-11-16 14:10:26.000', 
'2011-11-16 14:10:26.000', 'servicerequest', '101026f4-7611-49e4-9b87-032a9e78374c', 'family', 1, '2016-11-16 00:00:00.000', 
null, '0b9d1ce0-198f-4cf2-b678-e2017669c119', '402ef84a-47dd-4028-a88c-4ae7dc2d441e', NULL, NULL, 
'7665ca54-5374-4174-be07-a687b811a82c', '7665ca54-5374-4174-be07-a687b811a82c', 'W', '2803872', NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, '2020-06-20');

update ServiceRequestTypeConfigDispositionCode set description = 'Completed', dispositioncode = 'Completed' where 
ServiceRequestTypeConfigIdDispostionId = 'd69ef21e-dce1-4cd4-bda3-76255fc92db3';

update investigationfinding set investigationfindingtypekey = 'RO' where investigationfindingid = 'fc54f438-7c55-4d0a-b82b-7b3b5186ee0b';

update intakeservicerequest set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8' where servicerequestnumber = 'CW2731753';