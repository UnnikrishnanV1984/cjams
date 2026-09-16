-- CDM-21402 - GAP Subsidy Not Generating
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3306746
-- Client ID: 4476522 (NAOMI F PONTO) - d776f70a-8dd0-479e-bc9e-4edbaeb86443
-- GAP ID: 1005968 - 2021-09-23 To 2037-10-20 - 906d5f83-e959-4c41-b5e9-534884eb8870 
-- Provider ID: 6003471 (Francis Ponto) - Local Department Home
-- The subsidy rate start date should be 2/9/2022.

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6003471 (Francis Ponto) - Local Department Home
-- Guardianship Home Approval ID: 107840
-- 3610	Applicant: (525033) Francis Ponto
-- 3611	Co-Applicant: (525034) Cynthia Ponto


select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '906d5f83-e959-4c41-b5e9-534884eb8870'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Francis Ponto',
	guardianoneid = 525033, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6003471,
	-- primaryrelationshipkey = 'MATRNLGPRNT',
	-- guardiantwoname = 'Cynthia Ponto',
	guardiantwoid = 525034, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 6003471,
	secondaryrelationshipkey = 'MATRNLGPRNT',
	updatedby = 'CDM-21402',
	updatedon = now()
where gapid = '906d5f83-e959-4c41-b5e9-534884eb8870'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '0aa3f244-9eed-4802-85fb-d3dca3da984e' ;

update gapagreementrate
set provider_id = 6003471,
	-- startdate = '2022-02-09 05:00:00', -- Not GAP Start Date 2021-09-23 08:00:00
	-- enddate = '2023-02-08 05:00:00', 
	updatedby = 'CDM-21402',
	updatedon = now()
where gapagreementid = '0aa3f244-9eed-4802-85fb-d3dca3da984e' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '906d5f83-e959-4c41-b5e9-534884eb8870' ;

update gapratesrevision
set providerid = 6003471,
	-- ratestartdate = '2022-02-09 05:00:00', -- Not GAP Start Date 2021-09-23 08:00:00
	-- rateenddate = '2023-02-08 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21402',
	updatedon = now()
where guardiansubsidyid = '906d5f83-e959-4c41-b5e9-534884eb8870' ;

-- No Payments 
-- Delete On HOLD Payment with NULL provider ID

