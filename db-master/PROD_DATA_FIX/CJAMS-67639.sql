/*
   Issue Description: CJAMS-67639
   Category/ Module  : data fix to revert the supervisor decision for intake#I261014016514
   Root cause: Not replicable in stage3, so requested to revert the supervisor decision for intake#I261014016514
   Fix provided: Data fix is done to revert the supervisor decision so that they can goaahead and approve the intake which
                 should allow them to create a case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


DELETE FROM cjams.routing
WHERE routingid='aa53701e-94b9-4be8-ad65-b2e5da8a8a74';

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('aa53701e-94b9-4be8-ad65-b2e5da8a8a74', 'XXXX', 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', 'fc251376-8745-4381-a750-6a617c748678', '30134929-8114-4c59-92d4-1ba8e93811e2', 'CWIW', 'CWSP', 'I261014016514', 1, 0, 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', '2026-04-28 14:27:39.631', 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', '2026-04-28 14:32:55.347', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='b540299e-170b-4917-a6f2-6dfbd36471be';

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b540299e-170b-4917-a6f2-6dfbd36471be', 'INTR', 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', 'fc251376-8745-4381-a750-6a617c748678', '30134929-8114-4c59-92d4-1ba8e93811e2', 'CWIW', 'CWSP', 'I261014016514', 1, 1, 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', '2026-04-28 14:32:55.347', 'e21f4b8b-730a-4de6-8df9-1fe5a6afe783', '2026-04-28 14:32:55.347', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

update routing
set  approveddate=null,
updatedon = now(), routingstatustypeid  = 1
 where objectid = 'I261014016514' and activeflag = 1;

update intakedastatus
set updatedby = 'CJAMS-67639', 
       updatedon = now(), status = 1
where intakenumber = 'I261014016514';

update intakedastaging
set
  updatedby = 'CJAMS-67639',
  updatedon = now(),
  status = 'pending',
  ispreintake = FALSE
where intakenumber = 'I261014016514' and activeflag = 1;

update intakesnapshot
set
  updatedby = 'CJAMS-67639', 
  updatedon = now(), 
  activeflag = 0
where intakenumber = 'I261014016514' and activeflag = 1;