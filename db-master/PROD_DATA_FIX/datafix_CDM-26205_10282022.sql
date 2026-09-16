-- CDM-26205 - SSN Correct Needed for Closed Imported Record
/*
-- Issue Description: 
	user request to update person's SSN in CJAMS as well as in MDM
	
-- Client ID: 200737290	(Golda Whitman) - 861d223d-2dae-4383-aebe-cd0794bd7896
   
-- Category/ Module: Person Demogarphics (Case Management)
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CJAMS PID 200737290 
-- to have the SSN no longer be in the system as 213787669, and be changed to 213787664. 
select cjamspid, ssnno, updatedby, updatedon 
	from person 
where cjamspid = 200737290
	and activeflag = 1 ;
 
update person
set ssnno = '213787664',
    updatedby = 'CDM-26205',
    updatedon = now()
where cjamspid = 200737290
	and activeflag = 1 ;
	
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personid = '861d223d-2dae-4383-aebe-cd0794bd7896'
	and personidentifiertypekey  = 'SSN' 
	and activeflag = 1 ;

update personidentifier
set activeflag = 0,
    updatedby = 'CDM-26205',
    updatedon = now()
where personid = '861d223d-2dae-4383-aebe-cd0794bd7896'
	and personidentifiertypekey  = 'SSN' 
	and activeflag = 1 ;


INSERT INTO cjams.personidentifier
	(	personidentifierid, personid, personidentifiertypekey, personidentifiervalue, 
		updatedby, updatedon, insertedby, insertedon, activeflag, 
		effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '861d223d-2dae-4383-aebe-cd0794bd7896'::uuid, 'SSN', '213787664', 
		'CDM-26205', now(), 'CDM-26205', now(), 1, 
		now(), NULL, '200737290', NULL, NULL, NULL
	);

--  SELECT json_agg(a) from sp_get_person_mdm('861d223d-2dae-4383-aebe-cd0794bd7896') a;