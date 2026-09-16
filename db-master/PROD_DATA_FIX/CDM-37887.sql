-- CDM-37887 Initial face to face contact
/* Issue Description: User unable to close the case #241021907441

-- Case Number: 241021907441
-- Intake Service Id: d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3

-- Category/ Module: Decision 

-- Root cause: User unable to close the case #241021907441 due to initial face to face contact with the child
-- Fix Provided: Datafix has been provided to close the case #241021907441
-- Pull request# N/A

*/

select intakeserreqstatustypeid, * 
	from intakeservicerequest 
	where servicerequestnumber='241021907441';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-37887',
updatedon = now()
WHERE servicerequestnumber='241021907441';

select intakeservicerequestdispositioncodeid, * 
	from intakeservicerequestdispositioncode 
	where intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' 
		and intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
	
select description,* from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid = '7336924e-9207-4ce5-b228-5c3d1431936f';

select description,* from intakeservicerequestdispositioncode where intakeserviceid = 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3';

update intakeservicerequestdispositioncode 
set activeflag=0, updatedon=now()
where activeflag=1 and intakeservicerequestdispositioncodeid = '7336924e-9207-4ce5-b228-5c3d1431936f';

delete from intakeservicerequestdispositioncode where updatedby='CDM-37887';

select * from intakeserreqstatustype;

select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'; 

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3', '780b2012-4a49-4e6d-9471-d1b2e4026c75', '2024-03-21 14:03:16.079', 
'CDM-37887', now(), '2024-03-21 14:03:16.079', 'Completed', '2024-03-21 14:03:16.079', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'Only child in the home is deceased and F2F contact could not be made.', '');

select * from servicerequesttypeconfigdispositioncode where servicerequesttypeconfigiddispostionid='d90db0d3-f665-49db-b3ad-0edb468bc02d';

select * from intakeservicerequestdispositioncode where servicerequesttypeconfigiddispostionid='9a333c30-8043-4732-9f9a-622b8d8038da' and intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3';

--update intakeservicerequestdispositioncode
--set intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', servicerequesttypeconfigiddispostionid='d90db0d3-f665-49db-b3ad-0edb468bc02d', updatedby=now()
--where intakeservicerequestdispositioncodeid='718a4676-de97-4666-9768-5efabc8fc09d' and intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' and activeflag=1;
--
--update intakeservicerequestdispositioncode
--set insertedon='2024-03-21 14:03:16.079', statusdate='2024-03-21 14:03:16.079', effectivedate='2024-03-21 14:03:16.079'
--where intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' and servicerequesttypeconfigiddispostionid='d90db0d3-f665-49db-b3ad-0edb468bc02d';

--select * from userprofile where securityusersid='780b2012-4a49-4e6d-9471-d1b2e4026c75';

select objectid ,* from routing where servicerequestnumber='241021907441' and activeflag = 1 and eventcode in ('INDR', 'INVT');

DELETE FROM routing where servicerequestnumber='241021907441' and updatedby='CDM-37887' and activeflag = 1 and eventcode in ('INDR', 'INVT');

select teamid,* from routing where objectid= 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '760bbede-3181-44a0-9d99-36a9b86d777d', 
'780b2012-4a49-4e6d-9471-d1b2e4026c75', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' 
				and updatedby = 'CDM-37887'),
15, 0, '760bbede-3181-44a0-9d99-36a9b86d777d', '2024-03-21 14:00:16.079', 'CDM-37887', now(), true, '',
'', '241021907441');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '780b2012-4a49-4e6d-9471-d1b2e4026c75', 
'760bbede-3181-44a0-9d99-36a9b86d777d', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' 
				and updatedby = 'CDM-37887'), 
16, 1, '780b2012-4a49-4e6d-9471-d1b2e4026c75', '2024-03-21 15:09:16.079', 'CDM-37887', now(), true, '', 
'', '241021907441');

select * from caseassignment 
	where objectid = 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3'
		and enddate is null;
	
UPDATE cjams.caseassignment
SET enddate = '2024-03-21 15:09:16.079',
updatedby = 'CDM-37887',
updatedon = now()
WHERE caseassignmentid='2041b3f5-eaa2-4822-b65d-81ace919caa1';

select activeflag ,* from personprogramarea where entityid='241021907441' and activeflag = 1 and enddate is null;

UPDATE cjams.personprogramarea
SET enddate = '2024-03-21 15:09:16.079',
updatedby = 'CDM-37887',
updatedon = now() 
WHERE entityid='241021907441' and activeflag = 1 and enddate is null;

-- select * from legislative where intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3';

-- DELETE FROM legislative where  intakeserviceid='d7b59a64-0ae5-4807-af3d-d3b24f4bf3b3' and updatedby='CDM-37887' and activeflag=1;

-- INSERT INTO cjams.legislative
-- (legislativeid, intakeserviceid, isapprovedsafec, activeflag, 
-- updatedby, updatedon, insertedby, insertedon, 
-- isinitialfacetoface, isapprovedmfira, isapprovecansf, 
-- isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
-- VALUES(gen_random_uuid(), 'd7b59a64-0ae5-4807-af3d-d3b24f4bf3b3', true, 1, 
-- 'CDM-37887', now(), '780b2012-4a49-4e6d-9471-d1b2e4026c75', now(), 
-- false, true, false, 
-- true, true, NULL, '', '', '', '', NULL);