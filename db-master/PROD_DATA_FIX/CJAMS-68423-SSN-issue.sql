-- CJAMS-68423 - SSN Correct Needed for Closed Imported Record
/*
-- Issue Description: 
	user request to update person's SSN in CJAMS 
	
--Provide data fix to update the SSN (212-55-7665) to Omotara Isaac (PID: 204984629) as data fix.   
-- Category/ Module: Person Demogarphics (Case Management)
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


 
update person
set ssnno = '212557665',
    updatedby = 'CJAMS-68423',
    updatedon = now()
where cjamspid = 204984629
	and activeflag = 1 ;
	
INSERT INTO cjams.personidentifier
	(	personidentifierid, personid, personidentifiertypekey, personidentifiervalue, 
		updatedby, updatedon, insertedby, insertedon, activeflag, 
		effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '20356241-9fdc-4cde-88a6-4d073f7d7be6'::uuid, 'SSN', '212557665', 
		'CJAMS-68423', now(), 'CJAMS-68423', now(), 1, 
		now(), NULL, '204984629', NULL, NULL, NULL
	);


