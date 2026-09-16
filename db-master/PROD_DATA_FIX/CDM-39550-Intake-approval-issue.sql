/*
   Issue Description: CDM-39550
   Category/ Module : Intake
   Root cause: Intake was not able to approve by supervisor
   Fix Provided: Did data fix to delete the already approved wrong record

*/
--Insert query for the deleted record
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('072a7dfd-6a6f-4f32-b47a-48b73f36b96d', 'INTR', 'cff1b846-b73d-4244-bac7-467159b6c095', 'cff1b846-b73d-4244-bac7-467159b6c095', '7cc38f64-153a-46e5-9230-bff302e8e606', 'CWIW', 'CWSP', 'I241012533303', 2, 1, 'cff1b846-b73d-4244-bac7-467159b6c095', '2024-06-10 18:25:55.192', 'cff1b846-b73d-4244-bac7-467159b6c095', '2024-06-10 18:25:55.192', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'scrnin', NULL, '2024-06-10 18:25:55.192');

delete from routing where routingid ='072a7dfd-6a6f-4f32-b47a-48b73f36b96d' and objectid = 'I241012533303';



update intakedastaging
set status ='pending', ispreintake ='false', updatedby ='CDM-39550', updatedon =now()
where intakenumber ='I241012533303' and activeflag =1;

update intakedastatus
set status = 1, ispreintake ='false', updatedby ='CDM-39550', updatedon =now()
where intakenumber ='I241012533303' and activeflag =1;

update intakesnapshot set activeflag =0 , updatedby ='CDM-39550', updatedon =now()
where intakenumber ='I241012533303' and activeflag =1;