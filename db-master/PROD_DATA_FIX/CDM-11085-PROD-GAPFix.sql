update intakeservicerequestactor 
set activeflag=1, updatedon =now(), updatedby ='CDM-11085'
where intakeservicerequestactorid='42371faa-41a8-42b9-b54c-1509965e4992';

update gapagreementrevision 
set approvalstatustypekey ='3047', activeflag =1, updatedon =now(), updatedby ='CDM-11085'
where gapagreementid ='f2987c38-7636-4220-a0c8-bee47709af8b';

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('GAAR', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '183e0ad9-ecf2-4081-9c9b-53511f8a0773', '091dfa7d-f371-40b6-8394-55984c940ad2'::uuid, 'CWSP', 'CWCW', 'f2987c38-7636-4220-a0c8-bee47709af8b', 16, 1, 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', now(), 'CDM-11085', now(), true, 'Guardianship Agreement Approved', NULL, 'Guardianship Agreement Approved', '3151682', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update gapratesrevision 
set approvaldate =now(), updatedon =now(), updatedby ='CDM-11085'
where gaprateid ='b0d4bb44-6d6d-4e21-96d1-67f2f1d3370c';