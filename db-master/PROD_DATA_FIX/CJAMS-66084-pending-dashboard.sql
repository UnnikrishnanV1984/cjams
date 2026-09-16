/*
  Issue Description: CJAMS-66084
   Category/ Module  :  intake pending dashboard
   Root cause: User request to add a pending case to the intake pending dashboard
   Fix Provided: Data fix has been done by updating the status to pending.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', 'a0b41798-e864-415d-8647-1a44cb6c5bda', 'd5abb69f-8086-4645-bb56-5ef8825d412d'::uuid, 'CWIW', 'CWSP', 'I261013941127', 1, 1, 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', now(), 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
 
update intakedastaging
set status='pending', ispreintake =false, updatedby ='CJAMS-66084', updatedon =now()
where intakenumber='I261013941127';

update intakedastatus 
set status =1, updatedby ='CJAMS-66084', updatedon =now()
where intakenumber ='I261013941127' and intakedastatusid ='dc67267f-2077-4f59-bfff-d4fd5d0e505f';