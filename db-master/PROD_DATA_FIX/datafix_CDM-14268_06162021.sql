-- CDM-14268 - Authorization Log
/*
-- Issue Description: 
   Approved Purchase Authorization with Pending routing records 

-- Case ID: 3214448
-- Client ID: 1073220 (ANGEL CRIPPEN) - 15b63135-b02e-47da-ab00-2bf8cdfca3f1
-- Srevice Log ID: 2002185 Date: 06/10/2021 - Transportation assistance (Paid)  
-- Authorization ID: 1781077
-- Provider ID: 5002753 (Snow Hill Food Rite)
-- Payment ID: 3048392 Date: 06/14/2021 
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 40	Forwarded to Funding Approval
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = '8c429215-6773-4e64-970f-69486a1f556e'
	and objectid = '1781077'
	and activeflag = 1 ;

delete from routing   
where routingid = '8c429215-6773-4e64-970f-69486a1f556e'
	and objectid = '1781077'
	and activeflag = 1 ;
	
-- 43 Purchase Authorization Payment Approvel
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'abc7b09a-e05f-4cb3-a603-66371ab1baf6'
	and objectid = '1781077'
	and activeflag  = 1 ;
	
delete from routing   
where routingid = 'abc7b09a-e05f-4cb3-a603-66371ab1baf6'
	and objectid = '1781077'
	and activeflag  = 1 ;


