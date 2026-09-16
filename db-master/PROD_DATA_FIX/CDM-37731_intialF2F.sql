-- CDM-37731 Initial face to face contact
/* Issue Description: User unable to close the case #241021799516

-- Case Number: 241021799516
-- Intake Service Id: 93746756-c3d4-4d76-b84f-91e702964d5e

-- Category/ Module: Decision 

-- Root cause: User unable to close the case #241021799516 due to initial face to face contact with the child
-- Fix Provided: Datafix has been provided to close the case #241021799516
-- Pull request# N/A

*/

select intakeserreqstatustypeid, * 
	from intakeservicerequest 
	where servicerequestnumber='241021799516';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-37731',
updatedon = now()
WHERE servicerequestnumber='241021799516';

select intakeservicerequestdispositioncodeid, * 
	from intakeservicerequestdispositioncode 
	where intakeserviceid='93746756-c3d4-4d76-b84f-91e702964d5e' 
		and intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
	
select * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid = '30e4049c-6fc0-4b8d-b929-cf2fc0110033';

delete from intakeservicerequestdispositioncode where updatedby='CDM-37731';

select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'; 

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), '93746756-c3d4-4d76-b84f-91e702964d5e', 'e54c1a0d-f76c-4c59-b5f1-05479b62f02d', '2024-03-11 10:00:16.079', 
'CDM-37731', now(), '2024-03-11 10:00:16.079', 'Completed', '2024-03-11 10:00:16.079', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'Worker unable to meet with the alleged victim. Alleged maltreator refused to participate in an interview. CJAMS ticket submitted to assist with case closure', '');

select * from routing where servicerequestnumber='241021799516' and activeflag = 1 and eventcode in ('INDR', 'INVT');

DELETE FROM routing where servicerequestnumber='241021799516' and updatedby='CDM-37731' and activeflag = 1 and eventcode in ('INDR', 'INVT');

select * from routing where objectid= '93746756-c3d4-4d76-b84f-91e702964d5e';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '3632178c-66dd-45a3-8a73-6d2b7b716434', 
'd803c8b4-c5f6-4e42-b945-6af888cbe1db', '3036bbf4-25b7-4392-8812-dd534908f864', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '93746756-c3d4-4d76-b84f-91e702964d5e' 
				and updatedby = 'CDM-37731'),
15, 0, '3632178c-66dd-45a3-8a73-6d2b7b716434', '2024-03-11 10:00:00.001', 'CDM-37731', now(), true, '',
'', '241021799516');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', 
'3632178c-66dd-45a3-8a73-6d2b7b716434', '3036bbf4-25b7-4392-8812-dd534908f864', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '93746756-c3d4-4d76-b84f-91e702964d5e' 
				and updatedby = 'CDM-37731'), 
16, 1, 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', '2024-03-11 11:05:29.022', 'CDM-37731', now(), true, '', 
'', '241021799516');

select * from caseassignment 
	where objectid = '93746756-c3d4-4d76-b84f-91e702964d5e'
		and enddate is null;
	
UPDATE cjams.caseassignment
SET enddate = '2024-03-11 11:05:29.022',
updatedby = 'CDM-37731',
updatedon = now()
WHERE caseassignmentid='5ee5eea1-d719-419b-ad8d-a084eb0510ca';

select * from personprogramarea where entityid='241021799516' and activeflag = 1 and enddate is null;

UPDATE cjams.personprogramarea
SET enddate = '2024-03-11 11:05:29.022',
updatedby = 'CDM-37731',
updatedon = now() 
WHERE entityid='241021799516' and activeflag = 1 and enddate is null;

select * from legislative where intakeserviceid='93746756-c3d4-4d76-b84f-91e702964d5e';

DELETE FROM legislative where  intakeserviceid='93746756-c3d4-4d76-b84f-91e702964d5e' and updatedby='CDM-37731' and activeflag=1;

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, 
updatedby, updatedon, insertedby, insertedon, 
isinitialfacetoface, isapprovedmfira, isapprovecansf, 
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES(gen_random_uuid(), '93746756-c3d4-4d76-b84f-91e702964d5e', true, 1, 
'CDM-37731', now(), 'e54c1a0d-f76c-4c59-b5f1-05479b62f02d', now(), 
false, true, false, 
true, true, NULL, '', '', '', '', NULL);

