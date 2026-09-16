-- CDM-22269 - GAP not in pay
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3305527
-- Client ID: 3787441 (TURON STANSBURY) - 1fffdf57-52fe-4566-9d08-f589eebf1045
-- GAP ID: 1005979 - 2022-01-28 To 2025-02-09 - 5a80e4b9-77d7-4bf8-89a9-297285d3043b
-- gapagreementid: 3053b256-a699-45da-aa9f-cfc912635b2d
-- Provider ID: 6004975	(NIKALETTE V BRISCOE) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6004975	(NIKALETTE V BRISCOE) - Local Department Home
-- Kinship Home Approval: 109120
-- 3610	Applicant: (529285) NIKALETTE	BRISCOE
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '5a80e4b9-77d7-4bf8-89a9-297285d3043b'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'NIKALETTE BRISCOE',
	guardianoneid = 529285, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6004975,
	-- primaryrelationshipkey = NULL,
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-22269',
	updatedon = now()
where gapid = '5a80e4b9-77d7-4bf8-89a9-297285d3043b'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '3053b256-a699-45da-aa9f-cfc912635b2d' ;

update gapagreementrate
set provider_id = 6004975,
	updatedby = 'CDM-22269',
	updatedon = now()
where gapagreementid = '3053b256-a699-45da-aa9f-cfc912635b2d' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '5a80e4b9-77d7-4bf8-89a9-297285d3043b' ;

update gapratesrevision
set providerid = 6004975,
	approvaldate = now(),
	updatedby = 'CDM-22269',
	updatedon = now()
where guardiansubsidyid = '5a80e4b9-77d7-4bf8-89a9-297285d3043b' ;

-- Delete On HOLD Payments with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22269'
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22269'
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22269'
where payment_id in (3169627, 3169628, 3169629)
	and delete_sw = 'N' ;
