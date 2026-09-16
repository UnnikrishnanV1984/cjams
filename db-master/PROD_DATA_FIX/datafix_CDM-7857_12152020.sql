-- CDM-7857 - UREGENT!!! Need to reopen service case
/*
-- Issue Description: 
   Request to reopen Case ID: 3279927 
   	  
-- Category/ Module: Service Case Management
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3279927 - ae18946e-cb42-41b4-ade1-f9e34fab270e

-- Update Service Case
-- servicecaseid - ae18946e-cb42-41b4-ade1-f9e34fab270e
-- update statustypekey = ASSGN, dispositioncode  = NULL, enddate = NULL
-- Before 
select servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon 
	from servicecase 
where servicecaseid = 'ae18946e-cb42-41b4-ade1-f9e34fab270e'
	and activeflag = 1 ;

	
update servicecase
	set statustypekey = 'ASSGN',
		dispositioncode = NULL,
		enddate = NULL,
		updatedby = 'CDM-7857',
		updatedon = now()
where servicecaseid = 'ae18946e-cb42-41b4-ade1-f9e34fab270e'
	and activeflag = 1 ;

-- Update Case Assignment
-- caseassignmentid - 31707339-d53a-4ee1-a8d8-82cdaab8976d -- update enddate as NULL
-- Before
select objectid, startdate, enddate, responsibilitytypekey, updatedby, updatedon
	from caseassignment
where caseassignmentid = '31707339-d53a-4ee1-a8d8-82cdaab8976d'
	and activeflag = 1 ;

update caseassignment	
	set enddate = NULL,
		updatedby = 'CDM-7857',
		updatedon = now()
where caseassignmentid = '31707339-d53a-4ee1-a8d8-82cdaab8976d'
	and activeflag = 1 ;

	
-- Service Case Disposition Review
-- servicecasedispositionid - 870c3d4b-066a-4526-ad9d-44750a2586b1 -- update activeflag = 0 	
select servicecaseid, statusdate, intakeserreqstatustypekey, updatedby, updatedon, activeflag
	from servicecasedisposition
where servicecasedispositionid = '870c3d4b-066a-4526-ad9d-44750a2586b1'
	and activeflag = 1 ;


update servicecasedisposition
	set activeflag = 0,
		updatedby = 'CDM-7857',
		updatedon = now()
where servicecasedispositionid = '870c3d4b-066a-4526-ad9d-44750a2586b1'
	and activeflag = 1 ;

	
-- Update Service Case Disposition Routing
select routeddescription, eventcode, updatedby, updatedon, activeflag  
	from routing 
where objectid = '870c3d4b-066a-4526-ad9d-44750a2586b1'
	and activeflag = 1 ;

update routing
	set activeflag = 0,
		updatedby = 'CDM-7857',
		updatedon = now()
where objectid = '870c3d4b-066a-4526-ad9d-44750a2586b1'
	and activeflag = 1 ;
	
	