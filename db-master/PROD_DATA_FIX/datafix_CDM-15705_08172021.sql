-- CDM-15705 - REOPEN case
/*
-- Issue Description: 
	Closed Service Case with active Removal.
	Datafix to re-open the Service Case so that user can close the removal.
   
	Case ID: 3195262 - c3bdb45f-77ee-4326-9b51-7d86f3239546
	Client ID: 3283058 (MYONNA K	TORRES) - 65d0ff17-dede-4b52-bd1d-fdf984931d5b
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, case was closed prior to Removal Closure.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Re-open the Service case
select servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon
	from servicecase
where servicecasenumber = 3195262
	and activeflag  = 1 ;
	
update  servicecase 
set statustypekey = 'Open', 
	dispositioncode = 'Open', 
	enddate = NULL, 
	updatedby = 'CDM-15705',
	updatedon = now() 
where servicecasenumber = 3195262 
	and activeflag  = 1 ;

select activeflag, dispositioncode, statusdate, updatedby, updatedon 
	from servicecasedisposition 
where servicecasedispositionid 
	in ( 	'c57aa151-a626-4806-bbda-42cca8c53329', 
			'd673f31c-05d7-4955-9db4-72345c6bf91d' 
		)
	and activeflag  = 1 ;


update servicecasedisposition 
set activeflag = 0, 
	updatedby = 'CDM-15705',
	updatedon = now() 
where servicecasedispositionid 
	in ( 	'c57aa151-a626-4806-bbda-42cca8c53329', 
			'd673f31c-05d7-4955-9db4-72345c6bf91d' 
		)
	and activeflag  = 1 ;
