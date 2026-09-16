-- CDM-26362 - SSN Fix needed
/*
-- Issue Description: 
	1. User requested to update SSN for CJAMS PID 200725658 

-- Category/ Module: Person
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select ssnno, ssnverified, * from person where cjamspid = 200725658;

update 	person
set		ssnno = '214940941',
		updatedby = 'CDM-26362',
		updatedon = now()
where	cjamspid = 200725658;

select 	personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
from 	personidentifier 
where 	personid = 'd3f76dbf-d682-463a-a5a3-0ba784fb186a'
		and personidentifiertypekey  = 'SSN' 
		and activeflag = 1 ;

update 	personidentifier
set 	activeflag = 0,
    	updatedby = 'CDM-26362',
    	updatedon = now()
where 	personid = 'd3f76dbf-d682-463a-a5a3-0ba784fb186a'
		and personidentifiertypekey  = 'SSN' 
	and activeflag = 1 ;


INSERT INTO cjams.personidentifier
	(	personidentifierid, personid, personidentifiertypekey, personidentifiervalue, 
		updatedby, updatedon, insertedby, insertedon, activeflag, 
		effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'd3f76dbf-d682-463a-a5a3-0ba784fb186a'::uuid, 'SSN', '214940941', 
		'CDM-26362', now(), 'CDM-26362', now(), 1, 
		now(), NULL, '200725658', NULL, NULL, NULL
	);

--  SELECT json_agg(a) from sp_get_person_mdm('d3f76dbf-d682-463a-a5a3-0ba784fb186a') a;