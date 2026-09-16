-- CDM-20449 - GAP not populating correctly
/*
-- Issue Description: 
   Guardian's provider info and teh Start dates are missing for 3 GAPs.
   
-- Case ID: 3293217
-- Provider ID: 6001973	(PAULA ANNETTE WILLEY) 

-- Client ID: 4495087 (JACKSON NAYLOR-WILLEY) - be0bc926-b05e-44c5-952c-732cb19fc4e6
-- GAP ID: 1005944 - Null to 2038-04-22 - f80dd525-73c3-4eda-b9d9-f36338df7168
-- Update Provider and Start Date as 12/02/2021
-- No Rate Entered so far

-- Client ID: 4106238 (LORI	L NAYLOR) - e7e3e43e-a383-41f7-8691-bd9f6ef39408
-- GAP ID: 1005942 - 2021-12-02 To 2035-02-03 - 3404d334-a118-4b67-a6f4-154407345b91
-- Approved Rate need fix: 02/01/2022 To 12/01/2022
-- Update Provider and GAP Start Date and Rate Start Date as 12/02/2021

-- Client ID: 4495086 (VICTORIA	JADE NAYLOR-WILLEY) - c0cd74a0-804d-45de-8483-4d07f24c26a9
-- GAP ID: 1005943 - Null To 2036-11-07 - 7aeb995e-98a5-4bac-b738-5fc18b27a231
-- Update Provider and Start Date as 12/02/2021
-- No Rate Entered so far

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: Prvoider ID: 6001973	(PAULA ANNETTE WILLEY) - Local Department Home
-- Guardianship Home Approval ID: 108742
-- 3610	Applicant: (528133) PAULA WILLEY
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'3404d334-a118-4b67-a6f4-154407345b91',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				)	
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'PAULA WILLEY',
	guardianoneid = 528133, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001973,
	-- primaryrelationshipkey = 'RELOTHR',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-20449',
	updatedon = now()
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'3404d334-a118-4b67-a6f4-154407345b91',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				)	
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'ee91edc4-d6c3-405d-b0c6-862f00b219cd' ;


update gapagreementrate
set provider_id = 6001973,
	startdate = '2021-12-02 05:00:00',
	updatedby = 'CDM-20449',
	updatedon = now()
where gapagreementid = 'ee91edc4-d6c3-405d-b0c6-862f00b219cd' ;
	

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '3404d334-a118-4b67-a6f4-154407345b91' ;

update gapratesrevision
set providerid = 6001973,
	ratestartdate = '2021-12-02 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20449',
	updatedon = now()
where guardiansubsidyid = '3404d334-a118-4b67-a6f4-154407345b91' ;

-- Update GAP Start Date as 2022-01-20 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				)	
	and activeflag = 1 ;


update gapagreement 
set startdate = '2021-12-02 04:00:00',
	updatedby = 'CDM-20449',
	updatedon = now()
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				)	
	and activeflag = 1 ;


select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				);	

update gapagreementrevision
set startdate = '2021-12-02 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20449',
	updatedon = now()
where gapid in (	'f80dd525-73c3-4eda-b9d9-f36338df7168',
					'7aeb995e-98a5-4bac-b738-5fc18b27a231'
				);
