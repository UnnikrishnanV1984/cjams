/*
   Issue Description: CJAMS-63039
   Category/ Module  : service log
   Root cause: As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
    In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 01/23/2023.
   Pull request# for code fix: 5028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
    Notes: additional datafix provided as user is trying to close the case but previous just asked for the service log end date.
    Client ID: 3718012
    1. Open agency provided services 
    2. Open service log
    3. Pending PA.

    client ID: 3546305
    1. Open service log

*/

update tb_service_log set end_dt = '2023-01-23', 
update_user_id = 'CJAMS-63125', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2118590'
and delete_sw = 'N';

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('93a34a27-4cdf-48ad-8968-72603feeb2f5', 'PCAUTHR', 'f0252f90-f539-4e4b-ba6f-7518d21146cf', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1807998', 40, 1, 'f0252f90-f539-4e4b-ba6f-7518d21146cf', '2022-10-25 16:00:03.024', 'f0252f90-f539-4e4b-ba6f-7518d21146cf', '2022-10-25 16:00:03.024', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3225917', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

--duplicate PA
DELETE FROM cjams.routing
WHERE routingid='93a34a27-4cdf-48ad-8968-72603feeb2f5'::uuid;

update routing 
set activeflag = 1,
	updatedby = 'CJAMS-63125',
	updatedon = now()
where routingid = '10c948fa-9dfc-49dc-8243-081475465541'
	and activeflag = 0
	and routingstatustypeid = 43;


-- open vendor service
update tb_service_log set end_dt = '2019-12-17', 
update_user_id = 'CJAMS-63125', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '962870'
and delete_sw = 'N';

-- open service log for client: 3546305
update tb_service_log set end_dt = '2024-10-29', 
update_user_id = 'CJAMS-63125', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2023557'
and delete_sw = 'N';