-- CDM-32310 - Guardianship Subsidy
/*
-- Issue Description: 
	Duplicate GAP Suspension preventing payments 

-- Case ID: 3268120
-- Client ID: 3965677 (RYAN BRAVE MAMBOCK) - a1a9512b-3fad-4c38-bce3-d5a3497e6ada
-- GAP ID: 5199 - 2019-02-25 To 2029-09-23 - 2279a0fe-1acb-4fe3-8e21-7081fdc9c561
-- Provider ID: 5088802	(Serge Mambock) 
-- GAP Suspension: 271dac81-6483-4d2b-88bc-8ea21407d3f1 - 2023-04-20 To Current
-- Closed GAP Suspension: c7c2d39e-0a43-4385-b55f-71a4267203b4 - 2023-04-20 To 2023-04-20
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Duplicate GAP suspension is preventing GAP payments 
-- Note: This suspension is not visible on the screen as routing record 16 is missing.
-- Fix provided: Datafix has been promoted to delete the duplicate GAP suspension.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete duplicate active GAP suspensions
-- End Date and make in-active
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '271dac81-6483-4d2b-88bc-8ea21407d3f1' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-32310',
	updatedon = now()	
where gapsuspensionid  = '271dac81-6483-4d2b-88bc-8ea21407d3f1' 
	and activeflag = 1 ;

-- End Date and make in-active
select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where suspensionid  = '271dac81-6483-4d2b-88bc-8ea21407d3f1' ;
	
update gapsuspensionrevision
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-32310',
	updatedon = now()	
where suspensionid  = '271dac81-6483-4d2b-88bc-8ea21407d3f1' ;

select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing r  
where objectid = '271dac81-6483-4d2b-88bc-8ea21407d3f1'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32310',
	updatedon = now()	
where objectid = '271dac81-6483-4d2b-88bc-8ea21407d3f1'
	and activeflag = 1 ;

-- To Trigger Under/Over
-- Other Closed GAP Suspension
select suspensionid, approvaldate, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where suspensionid = 'c7c2d39e-0a43-4385-b55f-71a4267203b4'
	and activeflag = 1 ;

update gapsuspensionrevision
set approvaldate = now(),
	updatedby = 'CDM-32310',
	updatedon = now()
where suspensionid = 'c7c2d39e-0a43-4385-b55f-71a4267203b4'
	and activeflag = 1 ;
