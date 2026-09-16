/*
-- Issue Description: Service log
    Client ID: 3796794 (JOHNATHAN BARNES)
    Provider ID: 5083795 (Residence Inn Marriott)
    Auth ID: 1892093
    Auth Start & End Date: 10/28/2022 - 10/28/2022
    Auth amount: $239.00
    Payment ID: 3297344
   Payment Date: 01/17/2023
   Check #: 653224
    Root cause:  requested to change the purchase authorization status as approved and removed the record which is pending 
	Fix Provided: Datafix has been promoted to  modify the status of the purchase authorization .
    Is code fix required: N 
	Reason why no related code fix:

*/


/*
INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(1, 40, 'Forwarded to Funding Approval', '43730a9a-3f74-4d0d-ba7d-312a8fca2ead'::uuid, 'PCAUTHR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'CWSP', 'FNSFS', '1892093', 40, 1, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2023-03-02 13:49:43.678', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2023-03-02 13:49:43.678', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3117999', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

---To modify purchase authorixation status and to delete pending routing record
DELETE FROM cjams.routing
WHERE routingid='43730a9a-3f74-4d0d-ba7d-312a8fca2ead'::uuid;


update routing 
set activeflag =1,
updatedby ='CJAMS-67518',updatedon =now()
where routingid ='ac2c6cdd-aecf-46b5-9a6c-72187db17688' and eventcode ='PCAUTHR';

update tb_service_log
set end_dt ='2022-10-28',
    update_user_id ='CJAMS-67518', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2097953') and delete_sw='N';