-- CDM-22663 - GAP not in pay
/*
-- Issue Description: 
   All GAP benchmarks are approved but payment for April has not gone out.
   
-- Case ID: 202109707103
-- Client ID: 200650936	(Dominic Armani	Darr) - 8c0b9080-8825-44a4-94c4-a28718249911
-- GAP ID: 1005997 - 2022-03-03 To 2039-04-05 - e65009ee-4d89-4e2c-bdb6-ca3c263af05e
-- gapagreementid: 8d46205b-fec5-4fd3-9117-314bf0eb0ba5

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6003973	(Dawn Meredith Romeo) - Local Department Home
-- Guardianship Home Approval: 109494
-- 3610	Applicant: (530558) Dawn Romeo
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'e65009ee-4d89-4e2c-bdb6-ca3c263af05e'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Brenda Brendel-Reckline',
	guardianoneid = 530558, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6003973,
	-- primaryrelationshipkey = 'MTNLAT',
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-22663',
	updatedon = now()
where gapid = 'e65009ee-4d89-4e2c-bdb6-ca3c263af05e'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '8d46205b-fec5-4fd3-9117-314bf0eb0ba5' ;

update gapagreementrate
set provider_id = 6003973,
	updatedby = 'CDM-22663',
	updatedon = now()
where gapagreementid = '8d46205b-fec5-4fd3-9117-314bf0eb0ba5' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = 'e65009ee-4d89-4e2c-bdb6-ca3c263af05e' ;

update gapratesrevision
set providerid = 6003973,
	approvaldate = now(),
	updatedby = 'CDM-22663',
	updatedon = now()
where guardiansubsidyid = 'e65009ee-4d89-4e2c-bdb6-ca3c263af05e' ;

-- No On-HOLD Payment with NULL provider ID
