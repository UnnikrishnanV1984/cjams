-- CDM-11422 - Case Visitation Report
/*
-- Issue Description: 
   2 Rejected Removals with active 'Approved' status records in the routing table.
   
   Case ID: 2020030103857
   Client ID: 200162739 (Aniah	Jackson) - f0f3243b-ff93-446c-bc6c-7a7f7fcca939
   Removal 637e4bc1-c00d-4a67-8d6d-6202fa32850f
   Client ID: 200162743	(Jeremiah Jackson) - d995f1eb-abcf-4e17-9f86-2da0546ba9c8
   Removal 06b71139-3498-409b-8ace-3a60f09aa4b2
   
    
-- Category/ Module: Removals  (Case Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 200162739 (Aniah	Jackson) - f0f3243b-ff93-446c-bc6c-7a7f7fcca939
select objectid, routingstatustypeid, updatedby, updatedon, activeflag
	from cjams.routing 
where routingid = 'e64809a4-d426-47df-b611-7670da6a1097'
	and eventcode = 'CHRR'
	and activeflag = 1 ;
	
update cjams.routing 
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-11422'
where routingid = 'e64809a4-d426-47df-b611-7670da6a1097'
	and eventcode = 'CHRR'
	and activeflag = 1 ;


-- Client ID: 200162743	(Jeremiah Jackson) - d995f1eb-abcf-4e17-9f86-2da0546ba9c8
select objectid, routingstatustypeid, updatedby, updatedon, activeflag
	from cjams.routing 
where routingid = '3a3a455b-1b46-4e92-a42c-2e094aaa8638'
	and eventcode = 'CHRR'
	and activeflag = 1 ;

update cjams.routing 
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-11422'
where routingid = '3a3a455b-1b46-4e92-a42c-2e094aaa8638'
	and eventcode = 'CHRR'
	and activeflag = 1 ;



