-- CDM-15050 - Finance
/*
-- Issue Description: 
   Approved Purchase Authorization with Pending routing records 

-- Authorization ID: 1778717 
-- Case ID: 3227216 & Client ID: 4413691
-- 4aba92e7-1016-4934-a9e5-169cb0271d73 - Forwarded to Funding Approval

-- Authorization ID: 1779997
-- Case ID: 3271440 & Client ID: 4162264
-- ffd79d93-0f8b-4d57-8f88-7636f77aa71e - Forwarded to Funding Approval
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 40	Forwarded to Funding Approval
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = '4aba92e7-1016-4934-a9e5-169cb0271d73'
	and objectid = '1778717'
	and activeflag = 1 ;

delete from routing   
where routingid = '4aba92e7-1016-4934-a9e5-169cb0271d73'
	and objectid = '1778717'
	and activeflag = 1 ;

-- 40	Forwarded to Funding Approval
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'ffd79d93-0f8b-4d57-8f88-7636f77aa71e'
	and objectid = '1779997'
	and activeflag = 1 ;

delete from routing   
where routingid = 'ffd79d93-0f8b-4d57-8f88-7636f77aa71e'
	and objectid = '1779997'
	and activeflag = 1 ;

