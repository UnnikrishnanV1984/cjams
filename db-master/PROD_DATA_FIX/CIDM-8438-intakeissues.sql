-- CIDM-8438 - Intake issues
/* Issue Description:Approved intakes shows as drafts in report

-- Category/ Module:Intake

-- Root cause:
-- Fix Provided: Datafix has been updated for the intake having issue 
-- Pull request# N/A
*/
 
 --Issue 1.Intake recommendation and Supervisor decision is missing in Decision tab -intake number:I211010171206
 update intakedastaging  set activeflag  = 0,updatedon =now(),updatedby  = 'CIDM-8438' where  intakenumber = 'I211010171206' and activeflag =1;


 --Issue 2.Intake recommendation is screen out -Intake number -I221010284774
 UPDATE intakedastaging
SET
updatedby = 'CIDM-8438', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010284774' AND activeflag=1;

--Issue 3 -Approved By information is missing in submission history Intake number:I221010227575
  --root cause - Updated by was updated with CDM number-CDM-29904
  update routing set updatedby ='0ae86a6f-5365-4bb2-b079-f85eb391a2ae'  where routingid ='704fbf24-8034-4fab-83e5-7a754f89d71c';

 
  --Issue 4 -Supervisor decision is screen out but submission history is not available.Intake number -I211010194403
  -- I211010194403 - check supervisorid- need to confirm whether this   fix is required .
--     INSERT INTO cjams.routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('INTR', '64a77a00-ecd8-4a67-adad-2b75e35b601f', '7f396b01-465f-452f-b495-599215ab5998', 'd88fbd55-35e8-4dea-8b25-c032e0849de4'::uuid, 'CWIW', 'CWSP', 'I211010194403', 8, 0, 'CIDM-8438', now(), '7f396b01-465f-452f-b495-599215ab5998', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Issue 5 - Supervisor decision is screen out but submission history status is not closed and Approved on information is missing Intake number -I211010171886
update routing set eventcode ='INTR' ,routingstatustypeid  = '8',updatedon =now() where routingid ='6f293224-b313-41ea-8eff-d62dc9f7aa85';




