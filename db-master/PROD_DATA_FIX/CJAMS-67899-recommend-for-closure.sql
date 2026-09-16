-- CJAMS-67899
/* Issue Description: Case closure
-- Case Number: 261023634863
-- Intake Service Id: ca43741f-b0d4-4bc6-a5e8-d9f3757df455
-- Category/ Module: Decision 
-- Root cause: Missing case closure record in decision tab for #261023634863 
-- Fix Provided: Datafix has been provided by inserting the missing case closure in decision tab for case #261023634863
-- Pull request# N/A
*/

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, 
updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid, 
servicerequesttypeconfigiddispostionid, 
reviewcomments, reasonfordelay)
VALUES(gen_random_uuid(), 'ca43741f-b0d4-4bc6-a5e8-d9f3757df455', 'ac079312-deb1-4e10-8af3-b9f8381cf005', '2026-04-10 10:03:16.079', 
'CJAMS-67899', now(), '2026-04-10 10:03:16.079', 'Completed', '2026-04-10 10:03:16.079', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
'Support Ticket - S20260139074056', '');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
tosecurityusersid, teamid, fromroleid, toroleid, 
objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
routeddescription, servicerequestnumber)
VALUES(gen_random_uuid(), 'INDR', '7414c353-30fb-40ce-a0e6-1a74dc43e118', 
'ac079312-deb1-4e10-8af3-b9f8381cf005', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e', 'CWSP', 'CWCW', 
(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = 'ca43741f-b0d4-4bc6-a5e8-d9f3757df455' 
				and updatedby = 'CJAMS-67899' and activeflag=1), 
16, 1, '7414c353-30fb-40ce-a0e6-1a74dc43e118', '2026-04-10 13:42:35.664', 'CJAMS-67899', now(), true, '', 
'', '261023634863');