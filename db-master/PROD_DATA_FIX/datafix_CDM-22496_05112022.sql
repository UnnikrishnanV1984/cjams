-- CDM-22496 - GAP subsidy payment not generating
/*
-- Issue Description: 
   The provider's ID number is not connecting to the GAP subsidy which is causing the payment to not generate. 
   
-- Case ID: 3276042
-- Client ID: 3389102 (JUSTINE DEE WILLIAMS) - f9e219ea-37db-4981-8503-ea5f0d53b9c1
-- GAP ID: 1006017 - 2021-12-29 To 2030-05-18 - 52aa9313-f2ad-4af3-889d-a287e67660d4
-- gapagreementid: c9b8174a-5a66-43b1-b6a7-b35bf39bbeb1

-- Client ID: 4077381 (JUSTICE WILLIAMS) - 5a724874-1dd2-4c72-a054-c5100db465a7
-- GAP ID: 1006011 - 2021-12-29 To 2035-04-04 - abc0f3a3-f971-4d9c-93e0-6f4f4c7c3d25
-- gapagreementid: 059b7b7e-6676-4bbf-9a55-9894c5cec30c

-- Category/ Module: GAP (Case Management) 
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 5094254 (Ali Johnson) - Local Department Home
-- Guardianship Home Approval: 109027
-- 3610	Applicant: (529007) Ali	Johnson
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in ( '52aa9313-f2ad-4af3-889d-a287e67660d4', 'abc0f3a3-f971-4d9c-93e0-6f4f4c7c3d25' )
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Ali Johnson',
	guardianoneid = 529007, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5094254,
	-- primaryrelationshipkey = NULL, -- MATNLUE
	-- guardiantwoname = NULL,
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-22496',
	updatedon = now()
where gapid in ( '52aa9313-f2ad-4af3-889d-a287e67660d4', 'abc0f3a3-f971-4d9c-93e0-6f4f4c7c3d25' )
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid in ( 'c9b8174a-5a66-43b1-b6a7-b35bf39bbeb1', '059b7b7e-6676-4bbf-9a55-9894c5cec30c' ) ;

update gapagreementrate
set provider_id = 5094254,
	updatedby = 'CDM-22496',
	updatedon = now()
where gapagreementid in ( 'c9b8174a-5a66-43b1-b6a7-b35bf39bbeb1', '059b7b7e-6676-4bbf-9a55-9894c5cec30c' ) ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid in ( '52aa9313-f2ad-4af3-889d-a287e67660d4', 'abc0f3a3-f971-4d9c-93e0-6f4f4c7c3d25' ) ;

update gapratesrevision
set providerid = 5094254,
	approvaldate = now(),
	updatedby = 'CDM-22496',
	updatedon = now()
where guardiansubsidyid in ( '52aa9313-f2ad-4af3-889d-a287e67660d4', 'abc0f3a3-f971-4d9c-93e0-6f4f4c7c3d25' ) ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22496'
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22496'
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-22496'
where payment_id in (3160377, 3160378, 3160379, 3160930, 3160931, 3160932)
	and delete_sw = 'N' ;
