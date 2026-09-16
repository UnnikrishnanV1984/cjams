

/*
   Issue Description: CDM-31201
   Category/ Module  :  Approval inbox 
   Root cause: Approval records  
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/

update cjams.routing set activeflag= 0, updatedby ='CDM-31201', updatedon = now()
where routingid ='f286f659-6268-4a3b-9e1b-030cef1e2de6';



INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('PPLR', '75bb17ca-2dad-4eea-be18-3035df2d57ff', '278c00c8-8f5b-4750-8f7b-78fdd22db7b6', '0af3203c-5254-407f-a333-36c0acc53457', 'CWSP', 'CWCW', 'd59e364e-ba65-4b08-9628-b12543d511f2', 16, 1, 'CDM-31201', now(), 'CDM-31201', now(), true, 'Permanency Plan Approved', NULL, 'Permanency Plan Approved', '221030015110', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

