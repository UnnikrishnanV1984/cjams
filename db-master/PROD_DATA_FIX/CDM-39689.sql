/*
 * CDM-39689 - SSA approval
 * Customer Email ID:nia.edmundson@maryland.gov
 * Description - 241021947186:Two cases below need SSA's approval for closure: 
 * Malsawmtluangi Hmar (241021947186) Bintou Traore (241021953316) 
 * complete the case# 241021947186 with the following details,
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
-- 	where servicerequestnumber='241021947186';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-39689',
updatedon = now()
WHERE servicerequestnumber='241021947186';

-- select intakeservicerequestdispositioncodeid, * 
-- 	from intakeservicerequestdispositioncode 
-- 	where intakeserviceid='a73839e6-1f29-48ef-b393-1b912e655ebc' 
-- 		and intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
	
-- select * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid = '4dafa6bc-2e8d-45c4-a87c-de85a27c0142';

delete from intakeservicerequestdispositioncode where updatedby='CDM-39689';

-- select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'; 

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), 'a73839e6-1f29-48ef-b393-1b912e655ebc', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-06-18 10:00:00.000', 
'CDM-39689', now(), '2024-06-18 10:00:00.000', 'Completed', '2024-06-18 10:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'Recommend for closure', '');

-- select * from routing where servicerequestnumber='241021947186' and activeflag = 1 and eventcode in ('INDR', 'INVT');

DELETE FROM routing where servicerequestnumber='241021947186' and updatedby='CDM-39689' and activeflag = 1 and eventcode in ('INDR', 'INVT');

-- select * from routing where objectid= 'a73839e6-1f29-48ef-b393-1b912e655ebc';

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
			where intakeserviceid = 'a73839e6-1f29-48ef-b393-1b912e655ebc' 
				and updatedby = 'CDM-39689'),
15, 0, '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-06-18 10:00:00.000', 'CDM-39689', now(), true, '',
'', '241021947186');

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
			where intakeserviceid = 'a73839e6-1f29-48ef-b393-1b912e655ebc' 
				and updatedby = 'CDM-39689'), 
16, 1, '256457bc-cd36-40ed-9716-c76835b9b8cc', '2024-06-18 10:00:00.000', 'CDM-39689', now(), true, '', 
'', '241021947186');

-- select * from caseassignment 
-- 	where objectid = 'a73839e6-1f29-48ef-b393-1b912e655ebc'
-- 		and enddate is null;
	
UPDATE cjams.caseassignment
SET enddate = '2024-06-18 10:00:00.000',
updatedby = 'CDM-39689',
updatedon = now()
WHERE caseassignmentid='5ee5eea1-d719-419b-ad8d-a084eb0510ca';

-- select * from personprogramarea where entityid='241021947186' and activeflag = 1 and enddate is null;

UPDATE cjams.personprogramarea
SET enddate = '2024-06-18 10:00:00.000',
updatedby = 'CDM-39689',
updatedon = now() 
WHERE entityid='241021947186' and activeflag = 1 and enddate is null;

-- select * from legislative where intakeserviceid='a73839e6-1f29-48ef-b393-1b912e655ebc';

DELETE FROM legislative where  intakeserviceid='a73839e6-1f29-48ef-b393-1b912e655ebc' and updatedby='CDM-39689' and activeflag=1;

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, 
updatedby, updatedon, insertedby, insertedon, 
isinitialfacetoface, isapprovedmfira, isapprovecansf, 
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES(gen_random_uuid(), 'a73839e6-1f29-48ef-b393-1b912e655ebc', true, 1, 
'CDM-39689', now(), '1e72fd87-c3f0-4c21-a67f-39099dea4843', now(), 
false, true, false, 
true, true, NULL, '', '', '', '', true);