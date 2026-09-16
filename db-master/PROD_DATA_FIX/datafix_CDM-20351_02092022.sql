-- CDM-20351 - Provider has not received system adjustment payments for October and November 2021
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3079590
-- Client ID: 3942528 (GABRIEL A BANGS) - ccb7c852-7294-4ece-8ab1-9fbb323d3103
-- GAP ID: 1005927 - 2021-09-24 To 2034-02-19 - d2df38d2-9cd6-489a-9a90-b11a0e112f1b
-- Prvoider ID: 5061736 (Terri Bangs) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: Prvoider ID: 5061736 (Terri Bangs) - Local Department Home
-- Guardianship Home Approval ID: 54923
-- 3610	Applicant: (197100) Terri Bangs
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'd2df38d2-9cd6-489a-9a90-b11a0e112f1b'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Terri Bangs',
	guardianoneid = 197100, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5061736,
	-- primaryrelationshipkey = ??,
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = ??,
	updatedby = 'CDM-20351',
	updatedon = now()
where gapid = 'd2df38d2-9cd6-489a-9a90-b11a0e112f1b'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '0cefa91c-e6b4-4fe4-97c3-9046266366c8' ;

update gapagreementrate
set provider_id = 5061736,
	updatedby = 'CDM-20351',
	updatedon = now()
where gapagreementid = '0cefa91c-e6b4-4fe4-97c3-9046266366c8' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = 'd2df38d2-9cd6-489a-9a90-b11a0e112f1b' ;

update gapratesrevision
set providerid = 5061736,
	approvaldate = now(),
	updatedby = 'CDM-20351',
	updatedon = now()
where guardiansubsidyid = 'd2df38d2-9cd6-489a-9a90-b11a0e112f1b' ;

-- Delete On HOLD Payments with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in ( 3133212, 3133213 )
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20351'
where payment_id in ( 3133212, 3133213 )
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in ( 3133212, 3133213 )
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20351'
where payment_id in ( 3133212, 3133213 )
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in ( 3133212, 3133213 )
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20351'
where payment_id in ( 3133212, 3133213 )
	and delete_sw = 'N' ;
	