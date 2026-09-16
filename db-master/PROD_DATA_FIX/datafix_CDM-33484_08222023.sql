-- CDM-33484 - END DATING SUSPENSION OF AMELIA ANCELL
/*
-- Issue Description: 
	Duplicate GAP Suspension preventing payments 

-- Case ID: 3260057 - sandy.snow@maryland.gov
-- Client ID: 3848233 (AMELIA ANCELL) - 0e454f2a-0d8a-404d-8e0d-d4541b01948e
-- GAP ID: 5391 - 2019-12-16 To 2033-08-31 - 0b5fcc6b-d6f1-46dd-b372-b2b0c7c80118
-- Proider ID: 6062329 (JOHN SHIPE)
-- GAP Suspension: ed35f825-89c8-4197-b14b-0b5a25666fc0	- 2023-06-25 To current
-- Closed GAP Suspension: 12356246-b1bb-43bc-9732-ad26e2881160 - 2023-06-25 04:00:00.000 To 2023-07-25 04:00:00.000
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Duplicate GAP suspension is preventing GAP payments. 
-- Fix provided: Datafix has been promoted to delete the duplicate GAP suspension.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the duplicate GAP suspension (CDM-33484)
-- GAP Suspension: ed35f825-89c8-4197-b14b-0b5a25666fc0	- 2023-06-25 To current
-- End Date and make in-active
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = 'ed35f825-89c8-4197-b14b-0b5a25666fc0' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-33484',
	updatedon = now()	
where gapsuspensionid  = 'ed35f825-89c8-4197-b14b-0b5a25666fc0' 
	and activeflag = 1 ;

-- End Date and make in-active
select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where suspensionid = 'ed35f825-89c8-4197-b14b-0b5a25666fc0' ;
	
update gapsuspensionrevision
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-33484',
	updatedon = now()	
where suspensionid  = 'ed35f825-89c8-4197-b14b-0b5a25666fc0' ;

select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing r  
where objectid = 'ed35f825-89c8-4197-b14b-0b5a25666fc0'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-33484',
	updatedon = now()	
where objectid = 'ed35f825-89c8-4197-b14b-0b5a25666fc0'
	and activeflag = 1 ;

-- To Trigger Under/Over
-- Closed GAP Suspension: 12356246-b1bb-43bc-9732-ad26e2881160 - 2023-06-25 04:00:00.000 To 2023-07-25 04:00:00.000
select gapsuspensionid, startdate, enddate, otherreason, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;
	
update gapsuspension
set otherreason = 'DEATH OF GLORIA SHIPE',
	enddate = '2023-07-25 04:00:00.000',
	updatedby = 'CDM-33484',
	updatedon = now()	
where gapsuspensionid  = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;

select suspensionid, approvalstatustypekey, approvaldate, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where suspensionid = '12356246-b1bb-43bc-9732-ad26e2881160'
	and activeflag = 1 ;

update gapsuspensionrevision
set approvalstatustypekey = '3047', 
	approvaldate = now(),
	updatedby = 'CDM-33484',
	updatedon = now()
where suspensionid = '12356246-b1bb-43bc-9732-ad26e2881160'
	and activeflag = 1 ;
