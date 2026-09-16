-- CDM-22809 - Incorrect Submission Worker
/*
-- Issue Description: 
   Adoption planning Disclosure Checklist approval is showing worker incorrectly
   
-- Category/ Module:Approval Inbox (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Adoption planning Disclosure Checklist Approval
-- Need to be updated with submitted by as case worker - 'Megan Saperstein' and the supervisor as 'Sarah Utz'.
select routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid,
	routeddescription, updatedby, updatedon 
from routing 
where routingid = '25c211f8-1050-4b65-884c-f2312f161225'
	and activeflag = 1 ;
  		
update routing 
set fromsecurityusersid = 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', -- Megan Saperstein
	tosecurityusersid = 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', -- Sarah Utz
	teamid = '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', -- Placement & Permanency unit
	updatedby = 'CDM-22809', 
	updatedon = now()
where routingid = '25c211f8-1050-4b65-884c-f2312f161225'
	and activeflag = 1 ;

-- Current Wrong Users
-- From 58d37e58-6c91-44be-afc9-d48df3d329ae priscilla.iwuanyanwu@maryland.gov
-- To d9e27467-8d44-4607-a993-287493cdac18	antwan.chambers@maryland.gov
