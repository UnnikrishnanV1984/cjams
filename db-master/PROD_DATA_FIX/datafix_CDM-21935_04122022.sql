-- CDM-21935 - GAP
/*
-- Issue Description: 
-- GAP payment start date is 2/7. However, GAP payment did not go out for February.

-- Case ID: 3297196
-- Client ID: 4336820 (YAMILL REDD-FERRARI) - ea3f434b-1145-42c8-a4a6-3c1749236efe
-- GAP ID: 1005978 - 2022-02-07 To 2037-02-03 - 14ada540-d6e0-421b-9d46-1473713216b5
-- Provider ID: 5094289	(Felicia Chappelle) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 5094289	(Felicia Chappelle) - Local Department Home
-- Guardianship Home Approval ID: 109314
-- 3610	Applicant: (529958) - Felicia Chappelle
-- 3611	Co-Applicant: (529957) - LUther	Redd

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '14ada540-d6e0-421b-9d46-1473713216b5'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Felicia Chappelle',
	guardianoneid = 529958, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5094289,
	-- primaryrelationshipkey = NULL,
	-- guardiantwoname = 'LUther  Redd',
	guardiantwoid = 529957, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 5094289,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21935',
	updatedon = now()
where gapid = '14ada540-d6e0-421b-9d46-1473713216b5'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '3582ca8b-5fe0-46e0-8e99-6dc31e8fbbc8' ;

update gapagreementrate
set provider_id = 5094289,
	updatedby = 'CDM-21935',
	updatedon = now()
where gapagreementid = '3582ca8b-5fe0-46e0-8e99-6dc31e8fbbc8' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '14ada540-d6e0-421b-9d46-1473713216b5' ;

update gapratesrevision
set providerid = 5094289,
	approvaldate = now(),
	updatedby = 'CDM-21935',
	updatedon = now()
where guardiansubsidyid = '14ada540-d6e0-421b-9d46-1473713216b5' ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3155248
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21935'
where payment_id = 3155248
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3155248
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21935'
where payment_id = 3155248
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3155248
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-21935'
where payment_id = 3155248
	and delete_sw = 'N' ;
