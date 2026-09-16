-- CDM-30589 - GAP SUSPENSION
/*
-- Issue Description: 
	Duplicate GAP Suspension preventing payments 

-- Case ID: 3218752
-- Client ID: 2657087 (KYLEIGH HARLOW) - e423008c-9184-4fd6-bf46-addd48d704bf
-- Provider ID: 5090840	(Donna Brooks-moyd)
-- GAP ID: 4970 - 2018-08-30 To 2025-08-20 - b9789bf9-ae5b-4c8a-bd21-c839e54b1019
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Duplicate GAP suspension is preventing GAP payments 
-- Fix provided: Datafix has been promoted to delete the duplicate GAP suspension.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete duplicate active GAP suspensions
-- End Date and make in-active
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = 'dd462401-a1a7-4bc4-949d-44465ce93058' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-30589',
	updatedon = now()	
where gapsuspensionid  = 'dd462401-a1a7-4bc4-949d-44465ce93058' 
	and activeflag = 1 ;

-- End Date and make in-active
select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where suspensionid  = 'dd462401-a1a7-4bc4-949d-44465ce93058' ;
	
update gapsuspensionrevision
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-30589',
	updatedon = now()	
where suspensionid  = 'dd462401-a1a7-4bc4-949d-44465ce93058' ;


select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing r  
where objectid = 'dd462401-a1a7-4bc4-949d-44465ce93058'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-30589',
	updatedon = now()	
where objectid = 'dd462401-a1a7-4bc4-949d-44465ce93058'
	and activeflag = 1 ;

-- To Trigger Under/Over
select suspensionid, approvaldate, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where suspensionid = '0dee07db-b4c6-4771-afda-1ac549c3c884'
	and activeflag = 1 ;

update gapsuspensionrevision
set approvaldate = now(),
	updatedby = 'CDM-30589',
	updatedon = now()
where suspensionid = '0dee07db-b4c6-4771-afda-1ac549c3c884'
	and activeflag = 1 ;
