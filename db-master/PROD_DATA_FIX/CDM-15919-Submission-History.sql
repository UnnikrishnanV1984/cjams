
/*
   Issue Description: CDM-15919
   Category/ Module  : INtake
   Root cause: user requested  to 
     Referral is approved and case is created but the Submission History is not displaying the Correct status.
We need to fix the Submission History to Display each change in Status.
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


INSERT INTO cjams.routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('XXXX', '13fb9d32-08cd-4106-82bf-ccc82326db67', 'cd18ddce-1a82-4984-b7f0-4370a7d60bac', 'ee40a757-5378-409f-a7c6-118368415a99'::uuid, 'CWSP', 'CWCW', 'I202100313987', 1, 1, 'CDM-26499', now(), 'CDM-26499', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update routing set routingstatustypeid =16  where objectid ='I202100313987';