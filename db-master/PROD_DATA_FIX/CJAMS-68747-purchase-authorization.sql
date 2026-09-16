/*
Issue: Service log could not be closed because an old purchase authorization (ID 1778380) was stuck in “Forwarded to Payment Approval” status.
Root Cause: Authorization was approved, but its payment status wasn’t updated in the database, causing the system to treat it as pending.
Fix Provided (Data Fix Only):Data fix was done by updated routing table.
Data/Code fix ticket#:CJAMS-68747
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

DELETE FROM cjams.routing
WHERE routingid='3e2af2cd-05dd-494f-94fd-6c6b7fcba806'::uuid;

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
--VALUES('3e2af2cd-05dd-494f-94fd-6c6b7fcba806'::uuid, 'PCAUTHR', '0b016507-3b60-44ed-b7a3-2c58ac25d333', NULL, '2546af4b-b0f4-4b5f-a21f-5d27602a7c9d'::uuid, 'CWSP', 'FNSFS', '1778380', 40, 1, '0b016507-3b60-44ed-b7a3-2c58ac25d333', '2021-12-03 09:28:49.525', '0b016507-3b60-44ed-b7a3-2c58ac25d333', '2021-12-03 09:28:49.525', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3221964', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update routing
set activeflag =1, updatedby ='CJAMS-68747', updatedon =now()
where routingid = 'ca2a3fc8-65db-47d1-a1bf-85bc4428e7d3' and activeflag =0;
