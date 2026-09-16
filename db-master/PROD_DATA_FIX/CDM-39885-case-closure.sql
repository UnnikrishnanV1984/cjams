-- CDM-39885 - Case Closure Error
/*
-- Issue Description: 
   Service case is still appearing with an error in the Weekly Caseworker visitation report.

-- Case ID: 3191386

-- Category/ Module: Placement (Case Management) 
-- Root cause: Active Case having closed on date as 04/16/2024 in the Service Case table (TBD) 
-- Fix Provided: Datafix has been promoted to nullify the closed-on date.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To nullify the Case closed-on date (CDM-39885)

update servicecase
set statustypekey = 'ASSGN', -- 'Closed'
	enddate = NULL,  -- '2024-04-16 17:30:51.326'
	dispositioncode	= NULL, -- 'Closed'
	updatedby = 'CDM-39885', 
	updatedon = now()
where servicecasenumber = '3191386' 
	and activeflag = 1 ;
