-- CDM-13615 - Service log funding approval
/*
-- Issue Description: 
   Approved Purchase Authorization approval issue due to Pending routing records 
   
-- Case ID: 3047091
-- Client ID: 1315512 (BRYSON TYLER	BRILL)
-- Srevice Log ID: 1999323 Date: 05/21/2021 - Social Participation (Paid) 
-- Authorization ID: 1777590
-- Provider ID: 5093995	(Department of Natural Resources)
-- Payment ID: 3037562 Date: 05/25/2021  
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 40 Purchase Authorization Fiscal Supervisor 
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = '2c7aff82-05ab-4aa7-b83b-f50d9bc0601d'
	and objectid = '1777590'
	and activeflag = 1 ;

delete from routing   
where routingid = '2c7aff82-05ab-4aa7-b83b-f50d9bc0601d'
	and objectid = '1777590'
	and activeflag = 1 ;
	
-- 43 Purchase Authorization Payment Approvel
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'e6643a0c-cbc2-48ae-9187-c970ff8d13d9'
	and objectid = '1777590'
	and activeflag  = 1 ;
	
delete from routing   
where routingid = 'e6643a0c-cbc2-48ae-9187-c970ff8d13d9'
	and objectid = '1777590'
	and activeflag  = 1 ;


