-- CDM-31868 - Case Closure Error
/*
-- Issue Description: 
   Service case is still appearing with an error in the Weekly Caseworker visitation report.

-- Case ID: 3185335 - 549efdf6-4728-4c5d-83a7-7ae27cd71e48

-- Category/ Module: Placement (Case Management) 
-- Root cause: Active Case having closed on date as 05/18/2023 in the Service Case table (TBD) 
-- Fix Provided: Datafix has been promoted to nullify the closed-on date.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To nullify the Case closed-on date (CDM-31868)
select statustypekey, enddate, dispositioncode, updatedon, updatedby
from servicecase
where servicecasenumber = '3185335' 
	and activeflag = 1 ;

update servicecase
set statustypekey = 'ASSGN', -- 'Closed'
	enddate = NULL,  -- '2023-05-18 03:43:22'
	dispositioncode	= NULL, -- 'Closed'
	updatedby = 'CDM-31868', 
	updatedon = now()
where servicecasenumber = '3185335' 
	and activeflag = 1 ;
