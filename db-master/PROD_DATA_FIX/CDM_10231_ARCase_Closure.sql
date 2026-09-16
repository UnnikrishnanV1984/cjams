-- CDM-10231 - Close AR case

update intakeservicerequestdispositioncode set servicerequesttypeconfigiddispostionid = 'd69ef21e-dce1-4cd4-bda3-76255fc92db3', intakeserreqstatustypeid='642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-10231', updatedon = now() where  intakeservicerequestdispositioncodeid = '5c0bbc54-328b-4562-8aad-2b4b43b98754';

update intakeservicerequest set intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-10231', updatedon = now() where intakeserviceid = 'b80e6e73-2458-4949-984d-3563ce842613';

update investigation set activeflag=0, updatedby = 'CDM-10231', updatedon = now() where intakeserviceid = 'b80e6e73-2458-4949-984d-3563ce842613';

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR', 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', '1984d7a6-a978-44fc-adc8-cf5d5dcf26ba', NULL, NULL, NULL, '5c0bbc54-328b-4562-8aad-2b4b43b98754', 16, 1, 'CDM-10231', '2020-06-03 00:00:00', 'CDM-10231', '2020-06-03 00:00:00', false, 'Disposition Approved', NULL, 'Disposition Approved', 20200154020076, 'servicerequest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
