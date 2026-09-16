-- CDM-21758 - GAP payment not showing
/*
-- Issue Description: 
   The provider number does not show up on the GAP case. The rate has been approved.
   
-- Case ID: 3220849
-- Client ID: 3989797 (PHOENIX URIAH FONS) - 7d8070c8-3d84-4445-aa4d-2c2f6c0cf2b6
-- GAP ID: 1005990 - 2022-02-23 TO 2034-08-26 - fb43e947-45d9-4dd7-88f3-3f7f7a6e3408
-- AGR: af1395c8-26ff-44df-9dea-89b9bfcd93b0

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6003155 (Brenda Brendel-Reckline) - Local Department Home
-- Kinship Home Approval: 109555
-- 3610	Applicant: (530755) Brenda	Brendel-Reckline
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'fb43e947-45d9-4dd7-88f3-3f7f7a6e3408'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Brenda Brendel-Reckline',
	guardianoneid = 530755, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6003155,
	-- primaryrelationshipkey = NULL,
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21758',
	updatedon = now()
where gapid = 'fb43e947-45d9-4dd7-88f3-3f7f7a6e3408'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'af1395c8-26ff-44df-9dea-89b9bfcd93b0' ;

update gapagreementrate
set provider_id = 6003155,
	updatedby = 'CDM-21758',
	updatedon = now()
where gapagreementid = 'af1395c8-26ff-44df-9dea-89b9bfcd93b0' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = 'fb43e947-45d9-4dd7-88f3-3f7f7a6e3408' ;

update gapratesrevision
set providerid = 6003155,
	approvaldate = now(),
	updatedby = 'CDM-21758',
	updatedon = now()
where guardiansubsidyid = 'fb43e947-45d9-4dd7-88f3-3f7f7a6e3408' ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3158047
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21758'
where payment_id = 3158047
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3158047
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21758'
where payment_id = 3158047
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3158047
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21758'
where payment_id = 3158047
	and delete_sw = 'N' ;
