/*
  Issue Description:CDM-38880 Case Closure as PG County leadership has approved this request to close without initial contact with at least one of the children
  Category/ Module : Decision
  Root cause: Data fix needs to provided for the CPS-IR case 241021928212 closure as SSA approval has been provided
  Fix Provided: Data fix has beem provided for the closure of CPS-IR case.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/


UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-38880',
updatedon = now()
WHERE intakeserviceid = '5d8917d7-7dc8-4190-825e-e475be3a54c9' and activeflag=1;

delete from cjams.intakeservicerequestdispositioncode where intakeserviceid = '5d8917d7-7dc8-4190-825e-e475be3a54c9' and updatedby = 'CDM-38880';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), '5d8917d7-7dc8-4190-825e-e475be3a54c9', '47d1f252-c156-479f-a7c2-414f16a85a63', '2024-05-07 10:00:00.001', 
'CDM-38880', now(), '2024-05-07 10:00:00.001', 'Completed', '2024-05-07 10:00:00.001', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'The assigned worker was unsuccessful with making  contact with all children. Efforts have been documented in CJAMS', '');


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '47d1f252-c156-479f-a7c2-414f16a85a63', 
'256457bc-cd36-40ed-9716-c76835b9b8cc', '862ff553-6c2c-4f28-89a2-69136865992a', 'CWCW', 'CWSP', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '5d8917d7-7dc8-4190-825e-e475be3a54c9'
            and updatedby = 'CDM-38880'),
15, 0, '47d1f252-c156-479f-a7c2-414f16a85a63', '2024-05-07 10:00:00.001', 'CDM-38880', now(), true, '',
'', '241021928212');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '256457bc-cd36-40ed-9716-c76835b9b8cc', 
'47d1f252-c156-479f-a7c2-414f16a85a63', '862ff553-6c2c-4f28-89a2-69136865992a', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '5d8917d7-7dc8-4190-825e-e475be3a54c9' 
				and updatedby = 'CDM-38880'), 
16, 1, '256457bc-cd36-40ed-9716-c76835b9b8cc', '2024-05-07 11:00:00.001', 'CDM-38880', now(), true, '', 
'', '241021928212');


	
UPDATE cjams.caseassignment
SET enddate = '2024-05-07 11:00:00.001',
updatedby = 'CDM-38880',
updatedon = now()
WHERE caseassignmentid='8d2f48cb-ff21-4103-bc02-d9cf8d9162f6';


UPDATE cjams.personprogramarea
SET enddate = '2024-05-07 11:00:00.001',
updatedby = 'CDM-38880',
updatedon = now() 
WHERE entityid='241021928212' and activeflag = 1 and enddate is null;

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, 
updatedby, updatedon, insertedby, insertedon, 
isinitialfacetoface, isapprovedmfira, isapprovecansf, 
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES(gen_random_uuid(), '5d8917d7-7dc8-4190-825e-e475be3a54c9', true, 1, 
'CDM-38880', now(), '47d1f252-c156-479f-a7c2-414f16a85a63', now(), 
false, true, false, 
true, true, NULL, '', '', '', '', NULL);
