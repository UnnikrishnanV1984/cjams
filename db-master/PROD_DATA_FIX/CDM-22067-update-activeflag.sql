/*
-- CDM-22067- 

-- Issue Description: 
 Unable to remove the items struck in approval inbox
  
-- Customer Email ID:tawanna.tilghman@maryland.gov

-- Root cause: Data fix to remove the items struck in approval inbox
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
remarks, old_id, routeddescription, servicerequestnumber)
VALUES('CPLAN2', '517e02e8-540d-40cc-9a15-41db2ab8f83f', '967e1d70-c77b-43fa-b4e5-78136189b1b0', '19c37080-818c-4a16-8e62-db0e4f8d8e69', 'CWCW', 'CWSP', 'e5c7eec5-2e80-4a62-be02-7c53ecdaf3f4', 16, 1, 'CDM-22067', now(), 'CDM-22067', now(), false, 
'', '', '', '2020028203468');

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
remarks, old_id, routeddescription, servicerequestnumber)
VALUES('CPLAN2', '517e02e8-540d-40cc-9a15-41db2ab8f83f', '967e1d70-c77b-43fa-b4e5-78136189b1b0', '19c37080-818c-4a16-8e62-db0e4f8d8e69', 'CWCW', 'CWSP', '0e2b7d41-cea2-42a9-8820-6acd8a3ca054', 16, 1, 'CDM-22067', now(), 'CDM-22067', now(), false, 
'', '', '', '2020028203468');

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
remarks, old_id, routeddescription, servicerequestnumber)
VALUES('CPLAN2', '313699a7-1fad-4da4-9948-fcfb60da5ce3', '967e1d70-c77b-43fa-b4e5-78136189b1b0', '19c37080-818c-4a16-8e62-db0e4f8d8e69', 'CWCW', 'CWSP', 'a628f387-d906-4deb-8fca-efa19ab7ff82', 16, 1, 'CDM-22067', now(), 'CDM-22067', now(), false, 
'', '', '', '3299085');

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
remarks, old_id, routeddescription, servicerequestnumber)
VALUES('CPLAN2', '313699a7-1fad-4da4-9948-fcfb60da5ce3', '967e1d70-c77b-43fa-b4e5-78136189b1b0', '19c37080-818c-4a16-8e62-db0e4f8d8e69', 'CWCW', 'CWSP', '4628385b-39d7-464d-a7c8-68498af0d159', 16, 1, 'CDM-22067', now(), 'CDM-22067', now(), false, 
'', '', '', '3299085');


update routing set 
activeflag = 0, 
updatedon = now(), 
updatedby = 'CDM-22067' where routingid in ('305b81d3-c246-4e24-acb4-7842dd1c413b','6a01a467-52ed-433f-9992-d14fc7297546','f39842e4-a51d-4f82-84a1-240f2deff205','329ec081-865c-447a-997c-d6bafce4cf49','68f85a9d-d32b-4a3b-8760-543697754d98','6852d6a7-a048-438e-b69e-d3768ddf76e4');