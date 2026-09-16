-- CDM-21403 - Subsidy Check Not Generating
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3079088
-- Client ID: 3274406 (NIYAH LUCIA AYEBOUAPOWELL) - bbb8525b-b899-47c2-874b-8b99b989465a
-- GAP ID: 1005965 - 2022-02-01 To 2026-10-28 - 498bf5a4-7daf-4f7a-b1a2-41d79e42edfb
-- Provider ID: 6000395 (Irene Dorsey) - Local Department Home
-- Guardianship Home Approval ID: 108912
-- 3610	Applicant: (528702) Irene Dorsey
-- 3611	Co-Applicant: None

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6000395 (Irene Dorsey) - Local Department Home
-- Guardianship Home Approval ID: 108912
-- 3610	Applicant: (528702) Irene Dorsey
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '498bf5a4-7daf-4f7a-b1a2-41d79e42edfb'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Irene Dorsey',
	guardianoneid = 528702, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6000395,
	-- primaryrelationshipkey = 'MATRNLGPRNT',
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21403',
	updatedon = now()
where gapid = '498bf5a4-7daf-4f7a-b1a2-41d79e42edfb'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'b1c1199b-9944-4270-abfc-47edc57eab24' ;

update gapagreementrate
set provider_id = 6000395,
	updatedby = 'CDM-21403',
	updatedon = now()
where gapagreementid = 'b1c1199b-9944-4270-abfc-47edc57eab24' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '498bf5a4-7daf-4f7a-b1a2-41d79e42edfb' ;

update gapratesrevision
set providerid = 6000395,
	approvaldate = now(),
	updatedby = 'CDM-21403',
	updatedon = now()
where guardiansubsidyid = '498bf5a4-7daf-4f7a-b1a2-41d79e42edfb' ;

-- No Payments 
-- Delete On HOLD Payment with NULL provider ID

