-- CDM-18628 Purchase Auth "stuck"
/*
-- Issue Description: 
   Approved purchase auth ID 1801757 but it is still showing up in my approval inbox.

-- Case ID: 3266207
-- Client ID: 3469418 (JOYCE-LYN PERLINA ARCHIE) - 9cdf35a5-4f3d-40ad-a85b-3f7a8e8e98d5  
-- Service Log ID: 2017342 - 10/13/2021 To Open - Youth at Risk (Paid)  
-- Provider ID: 5006130	(DHS/Carroll County Dept. Of Social Serv. Acct # 3)
-- Authorization ID: 1801757
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update   
-- 1	40	Forwarded to Funding Approval	20090b61-deaa-46dd-8397-7ff5f58cbd9f	PCAUTHR
-- 1	39	Forwarded to Case Supervisor	16ba6946-b915-44b7-b3a7-2a28096a0f51	PCAUTH

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '16ba6946-b915-44b7-b3a7-2a28096a0f51'
	and objectid = '1801757'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-18628',
	updatedon = now()
where routingid = '16ba6946-b915-44b7-b3a7-2a28096a0f51'
	and objectid = '1801757'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	