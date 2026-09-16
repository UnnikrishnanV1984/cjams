/*
   Issue Description: CDM-18302
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen service case
   Pull request# for code fix: CDM-18302-REOPEN-SERVICE-CASE.sql
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

	INSERT INTO servicecasedisposition
		( servicecasedispositionid , servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
		VALUES('3dd76678-d571-44eb-b92f-8ba1a75d5d3c', '1e69544a-8e67-4870-88da-6becaeff9811', Now(), 'Open', 'Inprogress','In Progress', 
		now(), 1, 'CDM-18302',now(),'CDM-18302',now())on conflict do nothing;

	INSERT INTO routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
	VALUES ('SCDR', '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', 'CWSP', 'CWSP', 'aea26369-04d8-420e-8f11-1e6aa61201ca', 16, 1, 'CDM-18302',now(),'CDM-18302', now())on conflict do nothing;
