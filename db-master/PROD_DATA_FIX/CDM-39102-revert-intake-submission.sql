/*
  Issue Description:CDM-39102 Service Case did not open. :I241012352827 was approved as screened in ROA but 
                    no service case was generated; unable to do override to create a service case. 
                    Also the intake cannot be found when searching the father by name or CJAMS PID;
                    only able to loctae the intake by searching other people listed in the case
  Category/ Module : Intake Decision
  Root cause: The intake submission need to be reverted, so that the intake worker can submit the intake again for supervisor approval.
  Fix Provided: Data fix has been provided to revert intake submitted
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('e0da030f-1500-4d5f-aea4-5ee0b945e43c'::uuid, 'INTR', '3fbb22ae-712a-4ea1-9739-3500d8351251', '87b3376e-99f0-4472-8b26-8fc0b0096781', '7cc38f64-153a-46e5-9230-bff302e8e606'::uuid, 'CWIW', 'CWSP', 'I241012352827', 2, 0, '87b3376e-99f0-4472-8b26-8fc0b0096781', '2024-05-17 16:05:09.868', '87b3376e-99f0-4472-8b26-8fc0b0096781', '2024-05-20 09:57:36.004', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'scrnin', 'scrnin', '2024-05-17 16:05:09.868');


update routing 
set routingstatustypeid = 1,
    activeflag = 1,
    supervisordecision = null,
    updatedon = now()
where routingid = 'e0da030f-1500-4d5f-aea4-5ee0b945e43c'
and objectid = 'I241012352827';



update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-39102'
where intakenumber = 'I241012352827';


update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-39102'
where intakenumber = 'I241012352827';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-39102', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I241012352827' AND activeflag=1;
