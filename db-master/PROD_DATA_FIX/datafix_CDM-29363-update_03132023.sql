/*
   Issue Description: CDM-29363 - service logs
   Category/ Module  : Approval Inbox - case pending approval
   Dashboard:worker sent service log for approval and the approval request came three times. 
   Approved the log, but two other approvals are stuck in my approval screen. Please delete them.
   Root cause: user wants to delete the record form pending approval tab
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

-- Delete 
--39	Forwarded to Case Supervisor	0fb1ede2-3c67-412c-aa12-642cd1d1cc63
--39	Forwarded to Case Supervisor	aeabc2fa-eadb-4e51-b950-68f5b5e5879e

-- inspect the page u will get object id from that you will get routing id
-- "objectid": "2022524"
select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '2022524'
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc;
	
delete from routing   
where routingid in ('0fb1ede2-3c67-412c-aa12-642cd1d1cc63','aeabc2fa-eadb-4e51-b950-68f5b5e5879e')
	and objectid = '2022524'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' );

/*
-- To Revert the data if needed

select * from routing where routingid = '0fb1ede2-3c67-412c-aa12-642cd1d1cc63';
select * from routing where routingid = 'aeabc2fa-eadb-4e51-b950-68f5b5e5879e';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0fb1ede2-3c67-412c-aa12-642cd1d1cc63', 'PCAUTH', '00b6c98a-472c-481e-ae79-ccdd318ded4f', 'fa484839-8478-4808-9412-261477e894e7', '5c0dcfd4-59bc-4280-8bc2-fd2f724389b7', 'CWCW', 'CWSP', '2022524', 39, 0, '00b6c98a-472c-481e-ae79-ccdd318ded4f', '2023-03-08 11:16:09.892', 'CDM-29363', '2023-03-10 15:24:41.467', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3285651', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('aeabc2fa-eadb-4e51-b950-68f5b5e5879e', 'PCAUTH', '00b6c98a-472c-481e-ae79-ccdd318ded4f', 'fa484839-8478-4808-9412-261477e894e7', '5c0dcfd4-59bc-4280-8bc2-fd2f724389b7', 'CWCW', 'CWSP', '2022524', 39, 0, '00b6c98a-472c-481e-ae79-ccdd318ded4f', '2023-03-08 11:16:09.890', 'CDM-29363', '2023-03-10 15:24:41.467', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3285651', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	