-- CDM-12584 - Unable to submit Agreement for approval
/*
-- Issue Description: 
   User is unable to change the GAP Agreement end date 01/26/2029 to 01/26/2028
   System is showing error message due to one migrated rate slab covering more than a year
   
   Case ID: 3143816 
   Client ID: 1781968 (KIERA S ALSTON)
   GAP ID: 414 - 2008-08-11  to 2029-01-26 - 6a897da4-ea1c-4b76-bb98-1b8678ef5867

-- Category/ Module: GAP (Case Management) 
-- Root cause: Data Issue (MD CHESSIE migrated data)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select startdate, enddate, updatedby , updatedon 
	from gapagreement 
where gapid  = '6a897da4-ea1c-4b76-bb98-1b8678ef5867'
	and activeflag  = 1 ;

update gapagreement
set enddate = '2028-01-26 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-12584'
where gapid  = '6a897da4-ea1c-4b76-bb98-1b8678ef5867'
	and activeflag  = 1 ;


