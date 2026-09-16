-- CDM-10233 - Case closure disposition record

update intakeservicerequestdispositioncode set servicerequesttypeconfigiddispostionid = 'd69ef21e-dce1-4cd4-bda3-76255fc92db3', intakeserreqstatustypeid='642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-10233', updatedon = now() where  intakeservicerequestdispositioncodeid = '3803d5ca-e4ac-4e16-ad45-cd0783630af7';
update intakeservicerequest set intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a' where intakeserviceid = 'ed4eaab1-c605-4c0b-a419-66f20985559e';

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR', 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', '52f46641-70f6-4e8d-aefd-1dbaa11c56a0', NULL, NULL, NULL, '3803d5ca-e4ac-4e16-ad45-cd0783630af7', 16, 1, 'CDM-10233', '2020-08-26 00:00:00', 'CDM-10233', '2020-08-26 00:00:00', false, 'Disposition Approved', NULL, 'Disposition Approved', 20200203025354, 'servicerequest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
