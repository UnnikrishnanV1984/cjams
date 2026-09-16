-- CDM-22312 - Service Request
/*
-- Issue Description: 
   Purchase Authorization Forwarded to Funding Approval Issue 

-- Case ID: 3285641
-- Client ID: 3939607 (DE'NASIA	M BROWN) - 8dd47b7b-d652-4379-a2c1-ccc0b548a49f
-- Provider ID: 5089546	(Psychiatric Institute of Washington)
-- Service: Hospital Overstay - Inpatient Psychiatric (Paid)
-- Authorization ID: 1810294 - 2021-03-21 To 2021-08-09 - $116798.34

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select routingstatustypeid, remarks, toroleid, teamid, updatedby, updatedon 
	from routing 
where routingid = '3f6d0dff-38bf-4747-983d-46a37008bf03'
	and objectid = '1810294'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

	
update routing   
set toroleid = 'FNSFS',
	teamid = '3d156f8e-e811-4723-af9a-c28aecc6d253',
	updatedby = 'CDM-22312',
	updatedon = now()
where routingid = '3f6d0dff-38bf-4747-983d-46a37008bf03'
	and objectid = '1810294'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- Old Values 
-- CWSP	
-- 2ba56fa3-9240-43b8-ad11-530c4b36d34f
*/	
