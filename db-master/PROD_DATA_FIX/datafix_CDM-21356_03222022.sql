-- CDM-21356 - Subsidy checks not generating
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3276696
-- Client ID: 3995741 (KIMANI M BUTLER) - d4068543-0390-476d-a6e0-3958429c89bc
-- GAP ID: 1005940 - 2021-12-27 To 2024-07-27 - 4582233b-9b34-4ff7-9006-ae9604311f3e
-- Provider ID: 5087732	(Margaret Cooper) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 5087732	(Margaret Cooper) - Local Department Home
-- Guardianship Home Approval ID: 108326
-- 3610	Applicant: (526680) Margaret Cooper
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '4582233b-9b34-4ff7-9006-ae9604311f3e'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Margaret Cooper',
	guardianoneid = 526680, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5087732,
	-- primaryrelationshipkey = 'MTNLGAT',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = ??,
	updatedby = 'CDM-21356',
	updatedon = now()
where gapid = '4582233b-9b34-4ff7-9006-ae9604311f3e'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'cf4951f7-8b8e-4602-bc61-a48f376c2f31' ;

update gapagreementrate
set provider_id = 5087732,
	updatedby = 'CDM-21356',
	updatedon = now()
where gapagreementid = 'cf4951f7-8b8e-4602-bc61-a48f376c2f31' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '4582233b-9b34-4ff7-9006-ae9604311f3e' ;

update gapratesrevision
set providerid = 5087732,
	approvaldate = now(),
	updatedby = 'CDM-21356',
	updatedon = now()
where guardiansubsidyid = '4582233b-9b34-4ff7-9006-ae9604311f3e' ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3131971
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21356'
where payment_id = 3131971
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3131971
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21356'
where payment_id = 3131971
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3131971
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21356'
where payment_id = 3131971
	and delete_sw = 'N' ;
