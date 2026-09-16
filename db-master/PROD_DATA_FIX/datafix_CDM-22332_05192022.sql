-- CDM-22332 - GAP Provider ID not populating
/*
-- Issue Description: 
   Provider ID not populating on subsidy rate for 
   London Giddins and Malaysia Blue resulting in nonpayment of subsidies

-- Case ID: 3290576
-- Client ID: 3960426 (LONDYNN GIDDINS) - 136cdbff-bf67-42ad-bde8-19800318f4f7
-- GAP ID: 1006022 - 2022-03-10 To 2034-06-05 - 7a7f746f-2e76-4469-b961-ee9a74cd28f2
-- gapagreementid: 3a6f4dee-619c-463a-8c03-0a2dce7e4b61

-- Client ID: 4374883 (MALAYSIA BLUE) - ed46bdde-5beb-44ae-8d05-db7e03185f82
-- GAP ID: 1006019 - 2022-03-10 To 2037-04-27 - a03d2bc9-6731-47e3-894f-2eb84c5ecf88
-- gapagreementid: 8ce5cc1d-3a4a-42c9-9700-0271ed34f494

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 5064084 (Ada Giddins) - Local Department Home
-- Guardianship Home Approval: 106846
-- 3610	Applicant: (521870) Ada	Giddins
-- 3611	Co-Applicant: None


select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in ( '7a7f746f-2e76-4469-b961-ee9a74cd28f2', 'a03d2bc9-6731-47e3-894f-2eb84c5ecf88')
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Brenda Brendel-Reckline',
	guardianoneid = 521870, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5064084,
	-- primaryrelationshipkey = NULL,
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-22332',
	updatedon = now()
where gapid in ( '7a7f746f-2e76-4469-b961-ee9a74cd28f2', 'a03d2bc9-6731-47e3-894f-2eb84c5ecf88')
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid in ( '3a6f4dee-619c-463a-8c03-0a2dce7e4b61', '8ce5cc1d-3a4a-42c9-9700-0271ed34f494' ) ;

update gapagreementrate
set provider_id = 5064084,
	updatedby = 'CDM-22332',
	updatedon = now()
where gapagreementid in ( '3a6f4dee-619c-463a-8c03-0a2dce7e4b61', '8ce5cc1d-3a4a-42c9-9700-0271ed34f494' ) ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid in ( '7a7f746f-2e76-4469-b961-ee9a74cd28f2', 'a03d2bc9-6731-47e3-894f-2eb84c5ecf88') ;

update gapratesrevision
set providerid = 5064084,
	approvaldate = now(),
	updatedby = 'CDM-22332',
	updatedon = now()
where guardiansubsidyid in ( '7a7f746f-2e76-4469-b961-ee9a74cd28f2', 'a03d2bc9-6731-47e3-894f-2eb84c5ecf88') ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3168156, 3168939)
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22332'
where payment_id in (3168156, 3168939)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3168156, 3168939)
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22332'
where payment_id in (3168156, 3168939)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3168156, 3168939)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22332'
where payment_id in (3168156, 3168939)
	and delete_sw = 'N' ;
