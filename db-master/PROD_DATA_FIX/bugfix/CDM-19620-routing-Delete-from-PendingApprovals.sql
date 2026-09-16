-- CDM-19620 - pending approval box
/*
-- Issue Description: 
    two assignments/assessments with the case number '20200216027059', '20200241031734' are waiting in the pending approval box
    even though they were approved.
    Customer Email ID:jason.sammons@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the servicerequestnumbers ('20200216027059', '20200241031734')

-- Case ID: 20200216027059', '20200241031734' 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update routing set activeflag =0, updatedby = 'CDM-19620', updatedon = now() where routingid in ('40214146-68cf-42a2-bbb5-6ab1a39d04ad', '3a94f335-c8a1-47d1-9953-441cb443ddd1') and objectid in ('2fd0a788-7d44-4b43-bf91-18ed0d8c6ecc', 'f1787926-5aa8-4235-b390-1a8f4876265e')and servicerequestnumber in ('20200216027059', '20200241031734');