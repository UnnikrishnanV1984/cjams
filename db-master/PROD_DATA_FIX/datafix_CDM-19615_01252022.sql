-- CDM-19615 - DAVON HULL
/*
-- Issue Description: 
   To update the provider ifo amd the Start date on 3 GAP cases

-- Case ID: 3240855 - tiffany.palmer@maryland.gov
-- Provider ID: 5093334 (Bernadette Riddick) - Local Department Home

-- Client ID: 3314508 (CHARLIE BOWMAN-HULL) - 43d8c915-50ab-4790-9a92-562c49a7ba8d
-- GAP ID: 1005933 - Null To 2026-03-10 - 763b482f-6a7e-4010-9b86-29b2385c927f
 
-- Client ID: 4261722 (DAVON BROWN-HULL) - 0f3a84fa-8b1e-4b26-93ea-041e72520ca9
-- GAP ID: 1005930 - Null to 2033-09-30 - a095766e-1648-436b-a521-9d7c6a411b74

-- Client ID: 3680547 (Chloe Dickerson Hull) - db443b4b-f939-4571-9a36-2c48b38803c8
-- GAP ID: 1005931  - Null To 2031-09-20 - ec764418-c8a3-4161-bcc2-a566fd12b533

-- Provider Approval ID: 108791
-- 3610 (528311) Bernadette	Riddick
-- 3611 (528312) Melvin	Burks

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- 3610	Applicant - (528311) Bernadette	Riddick
-- 3611	Co-Applicant - (528312) Melvin	Burks

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    )	 
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Bernadette Riddick',
	guardianoneid = 528311, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5093334,
	primaryrelationshipkey = 'MATRNLGPRNT',
	guardiantwoname = 'Melvin Burks',
	guardiantwoid = 528312, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 5093334,
	secondaryrelationshipkey = 'MATRNLGPRNT',
	updatedby = 'CDM-19615',
	updatedon = now()
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    )	 
	and activeflag = 1 ;
	
-- Update GAP Start Date as 12/02/2021 (old value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    ) ;
--	and activeflag = 1 

update gapagreement 
set startdate = '2021-12-02 04:00:00',
	updatedby = 'CDM-19615',
	updatedon = now()
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    ) ;
--	and activeflag = 1 

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    ) ;

update gapagreementrevision
set startdate = '2021-12-02 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-19615',
	updatedon = now()
where gapid in (	'763b482f-6a7e-4010-9b86-29b2385c927f',
					'a095766e-1648-436b-a521-9d7c6a411b74',
					'ec764418-c8a3-4161-bcc2-a566fd12b533' 
			    ) ;


