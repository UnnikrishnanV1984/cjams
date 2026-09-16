-- CDM-21001 Unable to switch provider - GAP
/*
-- Issue Description: 
   User request to transfer the GAP to Successor Provider
   
-- Case ID: 3188945
-- Client ID: 3104378 (JAYDEN MICHAEL PEREGOY) - 53c8c61d-475e-45d8-905c-032ff69a69a1
-- GAP ID: 3015 - 2013-10-08 To 2028-07-15 - bc835429-bef7-42fb-9972-b2e450dacd8e
-- Successor Provider ID: 6005155 (Jeannine Lee Peregoy) - Local Department Home
-- Current Provider ID: 5061419 (William Peregoy) -	Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6005155 (Jeannine Lee Peregoy) - Local Department Home
-- Guardianship Home Approval ID: 108935
-- 3610	Applicant: (528763) Jeannine Peregoy
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'bc835429-bef7-42fb-9972-b2e450dacd8e'
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Jeannine Peregoy', -- William Peregoy
	guardianoneid = 528763, -- (approval_person_id -> tb_prov_approval_person ) -- 193145
	guardianoneproviderid = 6005155, -- 6000395
	primaryrelationshipkey = 'STPRNTLGPRNT', -- 'DACRCHLD'
	guardiantwoname = NULL, -- Jeannine Peregoy
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person ) -- 193146
	guardiantwoproviderid = NULL, -- 5061419
	secondaryrelationshipkey = NULL, -- STPRNTLGPRNT
	updatedby = 'CDM-21001',
	updatedon = now()
where gapid = 'bc835429-bef7-42fb-9972-b2e450dacd8e'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementrateid = '95e09a5f-b4b1-4c83-8be2-9d4a85d42961' ;

update gapagreementrate
set provider_id = 6005155,
	updatedby = 'CDM-21001',
	updatedon = now()
where gapagreementrateid = '95e09a5f-b4b1-4c83-8be2-9d4a85d42961' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '95e09a5f-b4b1-4c83-8be2-9d4a85d42961';

update gapratesrevision
set providerid = 6005155,
	approvaldate = now(),
	updatedby = 'CDM-21001',
	updatedon = now()
where gaprateid = '95e09a5f-b4b1-4c83-8be2-9d4a85d42961';
