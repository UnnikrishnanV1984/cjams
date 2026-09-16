/*
 * CDM-39688 - SSA Approval
 * Customer Email ID:nia.edmundson@maryland.gov
 * Description - 241022007383:Case needs SSA approval (241022007383) RONEKA GENIVA STREATER 
 * complete the case# 241022007383 with the following details,
 * REQUESTED DATE - 6/18/2024 10:00 AM
 * STATUS - Completed
 * RECOMMENDATION - Recommend for closure
 * USER - Nia Edmundson 
 * ROLE - Case Worker
 * APPROVED BY - Mia Dabney
 * APPROVED ON -  6/18/2024 10:00 AM
 * 
 */

-- select * from v_userprofile where email = 'nia.edmundson@maryland.gov'; -- 1e72fd87-c3f0-4c21-a67f-39099dea4843
-- select * from v_userprofile where fullname ='Mia Dabney'; -- 256457bc-cd36-40ed-9716-c76835b9b8cc
-- select intakeserreqstatustypeid, * 
-- 	from intakeservicerequest 
-- 	where servicerequestnumber='241022007383';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-39688',
updatedon = now()
WHERE servicerequestnumber='241022007383';

-- select intakeservicerequestdispositioncodeid, * 
-- 	from intakeservicerequestdispositioncode 
-- 	where intakeserviceid='26e3b7e2-13ae-4439-a2ee-496fad414f37' 
-- 		and intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
	
-- select * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid = 'c277ed97-7797-409f-b0cb-f6423326016e';

delete from intakeservicerequestdispositioncode where updatedby='CDM-39688';

-- select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'; 

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), '26e3b7e2-13ae-4439-a2ee-496fad414f37', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-06-18 10:00:00.000', 
'CDM-39688', now(), '2024-06-18 10:00:00.000', 'Completed', '2024-06-18 10:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'Recommend for closure', '');

-- select * from routing where servicerequestnumber='241022007383' and activeflag = 1 and eventcode in ('INDR', 'INVT');

DELETE FROM routing where servicerequestnumber='241022007383' and updatedby='CDM-39688' and activeflag = 1 and eventcode in ('INDR', 'INVT');

-- select * from routing where objectid= '26e3b7e2-13ae-4439-a2ee-496fad414f37';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '1e72fd87-c3f0-4c21-a67f-39099dea4843', 
'256457bc-cd36-40ed-9716-c76835b9b8cc', '862ff553-6c2c-4f28-89a2-69136865992a', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '26e3b7e2-13ae-4439-a2ee-496fad414f37' 
				and updatedby = 'CDM-39688'),
15, 0, '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-06-18 10:00:00.000', 'CDM-39688', now(), true, '',
'', '241022007383');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '256457bc-cd36-40ed-9716-c76835b9b8cc', 
'1e72fd87-c3f0-4c21-a67f-39099dea4843', '862ff553-6c2c-4f28-89a2-69136865992a', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '26e3b7e2-13ae-4439-a2ee-496fad414f37' 
				and updatedby = 'CDM-39688'), 
16, 1, '256457bc-cd36-40ed-9716-c76835b9b8cc', '2024-06-18 10:00:00.000', 'CDM-39688', now(), true, '', 
'', '241022007383');

-- select * from caseassignment 
-- 	where objectid = '26e3b7e2-13ae-4439-a2ee-496fad414f37'
-- 		and enddate is null;
	
UPDATE cjams.caseassignment
SET enddate = '2024-06-18 10:00:00.000',
updatedby = 'CDM-39688',
updatedon = now()
WHERE caseassignmentid='5ee5eea1-d719-419b-ad8d-a084eb0510ca';

-- select * from personprogramarea where entityid='241022007383' and activeflag = 1 and enddate is null;

UPDATE cjams.personprogramarea
SET enddate = '2024-06-18 10:00:00.000',
updatedby = 'CDM-39688',
updatedon = now() 
WHERE entityid='241022007383' and activeflag = 1 and enddate is null;
