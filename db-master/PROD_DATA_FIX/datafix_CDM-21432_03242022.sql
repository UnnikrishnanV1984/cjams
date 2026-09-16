-- CDM-21432 - GAP Payment Issue
/*
-- Issue Description: 
-- The provider ID has disappeared. This will delay payment beginning.
   
-- Case ID: 3038926 - joi.scott@maryland.gov

-- Client ID: 3899923 (ZOEY	RUBYMARIE DAVIS) - be3ead3f-fb6c-4bb2-89cc-6ba360f0bb20
-- GAP ID: 1005989 - 2022-02-24 To 2030-02-01 - 85cdb6c9-a631-4d0c-85b7-128505e445b4 
-- Provider ID: 5082713	(Patricia Nelson) - Local Department Home

-- Client ID: 4446990 (BRANDON HARRINGTON WARFIELD) - 0fbbe43a-15df-4293-b588-198c2ebf2ebc
-- GAP ID: 1005992 - 2022-02-24 To 2032-07-24 - a34f0357-0a72-46bc-9ad9-32b79b17f69a 
-- Provider ID: 6001774 (CHANELLE NICOLE ALLENJONES) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Client ID: 3899923 (ZOEY	RUBYMARIE DAVIS) - be3ead3f-fb6c-4bb2-89cc-6ba360f0bb20
-- Update GAP Provider Info
-- Provider ID: 5082713	(Patricia Nelson) - Local Department Home
-- Guardianship Home Approval ID: 109234
-- 3610	Applicant: (529663) - Patricia	Nelson
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '85cdb6c9-a631-4d0c-85b7-128505e445b4'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Patricia Nelson',
	guardianoneid = 529663, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5082713,
	-- primaryrelationshipkey = 'PRNTLGPRNT',
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21432',
	updatedon = now()
where gapid = '85cdb6c9-a631-4d0c-85b7-128505e445b4'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'f4a159d8-49b3-4488-8497-ddb1f78a2d32' ;

update gapagreementrate
set provider_id = 5082713,
	updatedby = 'CDM-21432',
	updatedon = now()
where gapagreementid = 'f4a159d8-49b3-4488-8497-ddb1f78a2d32' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '85cdb6c9-a631-4d0c-85b7-128505e445b4' ;

update gapratesrevision
set providerid = 5082713,
	approvaldate = now(),
	updatedby = 'CDM-21432',
	updatedon = now()
where guardiansubsidyid = '85cdb6c9-a631-4d0c-85b7-128505e445b4' ;


-- Client ID: 4446990 (BRANDON HARRINGTON WARFIELD) - 0fbbe43a-15df-4293-b588-198c2ebf2ebc
-- Update GAP Provider Info
-- Provider ID: 6001774 (CHANELLE NICOLE ALLENJONES) - Local Department Home
-- Guardianship Home Approval ID: 109462
-- 3610	Applicant: (530473) - CHANELLE ALLENJONES
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'a34f0357-0a72-46bc-9ad9-32b79b17f69a'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'CHANELLE ALLENJONES',
	guardianoneid = 530473, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001774,
	-- primaryrelationshipkey = 'PRNTLAT',
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21432',
	updatedon = now()
where gapid = 'a34f0357-0a72-46bc-9ad9-32b79b17f69a'
	and activeflag = 1 ;
	

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3158319
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21432'
where payment_id = 3158319
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3158319
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21432'
where payment_id = 3158319
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3158319
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21432'
where payment_id = 3158319
	and delete_sw = 'N' ;

