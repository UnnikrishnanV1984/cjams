/*
-- Issue Description: 
- CJAMS-68798 - SSN Fix needed
--Need to provide data fix to Update SSN to 215-59-7215 (*Incorrect SSN: *215-59-7216)

CJAMS PID: 204200531
MDT-156120561
First Name: Emma
Last Name: Charles
DOB: 11/03/2000
-- Category/ Module: Person
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update 	person
set	ssnno = '215597215', updatedby = 'CJAMS-68798', updatedon = now()
where	cjamspid = 204200531 and activeflag = 1;


update 	personidentifier
set 	activeflag = 0, updatedby = 'CJAMS-68798', updatedon = now()
where 	personid = 'ff60a15c-c8c6-45b2-9727-ee295e07162f' and personidentifiertypekey  = 'SSN' and activeflag = 1 ;


INSERT INTO cjams.personidentifier
	(	personidentifierid, personid, personidentifiertypekey, personidentifiervalue, 
		updatedby, updatedon, insertedby, insertedon, activeflag, 
		effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ff60a15c-c8c6-45b2-9727-ee295e07162f'::uuid, 'SSN', '215597215', 
		'CJAMS-68798', now(), 'CJAMS-68798', now(), 1, 
		now(), NULL, '204200531', NULL, NULL, NULL
	);
