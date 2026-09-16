-- CDM-12553 - Approval
/*
-- Issue Description: 
   Approved Purchase Authorization ID 1771116 with hanging Funding Approval request
   
	Case ID: 202100605224 - taylor.layton1@maryland.gov
	Client ID: 200303051 (Theresa Canali	Conway) - bab17f46-19f2-4650-a3d5-3ff03fa74998
	Authorization ID: 1771116 for $174.20
	Service : Transportation assistance (Paid)- Date : 04/13/2021
	Payment ID: 3023881 - Date: 04/19/2021
  
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select objectid, routingstatustypeid, updatedby, updatedon, activeflag 
	from routing 
where objectid = '1771116'
	and eventcode = 'PCAUTHR'
	and routingstatustypeid = 40
	and activeflag = 1 ;
	
update cjams.routing 
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-12553'
where objectid = '1771116'
	and eventcode = 'PCAUTHR'
	and routingstatustypeid = 40
	and activeflag = 1 ;


