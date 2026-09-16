-- CDM-18793 - REOPEN case
/*
-- Issue Description: 
	Closed Service Case (3157348) with active Removals.
	Datafix to re-open the Service Case . 
   
-- Category/ Module: Case Decision
-- Root cause: Case was accidentally closed, with open removals.
-- Pull request# N/A
-- Reason why no related code fix: Training needed, to the conditions selected at decision.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Re-open the Service case
select servicecaseid, servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon
	from servicecase
where servicecasenumber = 3157348 and activeflag  = 1 ;
	
update  servicecase 
set statustypekey = 'Open', 
	dispositioncode = 'Open', 
	enddate = NULL, 
	updatedby = 'CDM-18793',
	updatedon = now() 
where servicecasenumber = 3157348 
	and activeflag  = 1 ;

select activeflag, dispositioncode, statusdate, updatedby, updatedon 
	from servicecasedisposition 
where servicecasedispositionid 
	in ( '1c29c5c9-ac36-4fbf-8ebb-b3c25266b993' ) and activeflag  = 1 ;


update servicecasedisposition 
set activeflag = 0, 
	intakeserreqstatustypekey = 'Open',  
	updatedby = 'CDM-18793',
	updatedon = now() 
where servicecasedispositionid 
	 in ( 	'1c29c5c9-ac36-4fbf-8ebb-b3c25266b993'  )
	and activeflag  = 1 ;
