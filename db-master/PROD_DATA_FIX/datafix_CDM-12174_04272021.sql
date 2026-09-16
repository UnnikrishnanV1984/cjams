-- CDM-12174 - Error in payment approval
/*
-- Issue Description: 
   Approved Purchase Authorization approval issue due to Multiple Pending routing records 
   
	Case ID: 3262994 
	Client ID: 4414211 (TIMOTHY CORDELL) - 3e9d0efd-3e95-40e1-8744-0af6f9e1dd96
	Provider ID: 6001228 (Our Small World) 
	Auth ID: 1760343 - Service LOG ID: 1984974 - Child Care (Paid) 
	Auth ID: 1765181 - Service LOG ID: 1988864 - Child Care (Paid)
  
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Auth ID: 1760343 - Service LOG ID: 1984974 - Child Care (Paid)
-- 39	Purchase Authorization Supervisor - 1 record
-- 42	Purchase Authorization Director Approvel - 8 records
-- 44	Purchase Authorization Payment Approvel - 1 record

select eventcode, objectid, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing  
where objectid = '1760343'
	and activeflag = 1 ; 

update cjams.routing 
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-12174'
where objectid = '1760343'
	and activeflag = 1 ; 

-- 41	Purchase Authorization Fiscal Supervisor Payment - make Active
select eventcode, objectid, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing  
where objectid = '1760343'
	and activeflag = 0
	and routingstatustypeid = 41
	and routingid  = 'f9713fcc-1270-4819-844c-3ef426fd242a' ;
	
update cjams.routing 
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-12174'	
where objectid = '1760343'
	and activeflag = 0
	and routingstatustypeid = 41
	and routingid  = 'f9713fcc-1270-4819-844c-3ef426fd242a' ;	

-- Auth ID: 1765181 - Service LOG ID: 1988864 - Child Care (Paid)
-- 39	Purchase Authorization Supervisor - 1 record
select eventcode, objectid, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing  
where objectid = '1765181'
	and activeflag = 1
	and routingid  = 'e16132e7-75aa-4c9b-aa0c-f5f7147fcc40' ;
	
update cjams.routing 
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-12174'
where objectid = '1765181'
	and activeflag = 1
	and routingid  = 'e16132e7-75aa-4c9b-aa0c-f5f7147fcc40' ;

