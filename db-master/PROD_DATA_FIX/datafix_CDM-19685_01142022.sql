-- CDM-19685 - Provider # not showing on rate page
/*
-- Issue Description: 
   The provider number, 6004080 does not show up on the rate page. 
   The rate has been approved.
   
-- Case ID: 3285347
-- Client ID: 4041767 (TYTIANNA MAE DAVIS) - b5eff904-e47f-447e-a507-dd8a657a5376
-- GAP ID: 1005950 - 2021-12-17 To 2026-09-17 - 1c1f4e49-45e1-45c7-84a3-29f0d4a970b7

-- Client ID: 4041769 (GERALD DAVIS) - 6d2f726b-9253-467b-9110-39489dbc7326
-- GAP ID: 1005951 - 2021-12-17 To 2028-05-12 - 37bc5817-648e-4aac-a47e-9e4d31c0dc66

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6004080 (PAMELA D ANDERSON) - Local Department Home
-- 3610	Applicant 
-- 528425 PAMELA ANDERSON
-- 3611	Co-Applicant
-- 528424 KENNETH JACOBS

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in ( '1c1f4e49-45e1-45c7-84a3-29f0d4a970b7', '37bc5817-648e-4aac-a47e-9e4d31c0dc66' )
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'PAMELA ANDERSON',
	guardianoneid = 528425, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6004080,
	-- primaryrelationshipkey = ??,
	-- guardiantwoname = 'KENNETH JACOBS',
	guardiantwoid = 528424, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 6004080,
	-- secondaryrelationshipkey = ??,
	updatedby = 'CDM-19685',
	updatedon = now()
where gapid in ( '1c1f4e49-45e1-45c7-84a3-29f0d4a970b7', '37bc5817-648e-4aac-a47e-9e4d31c0dc66' )
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid 
	in ( '264199a3-74be-4ac0-8023-4f5efe4aec24', '2b88b3ff-4fc5-4b08-a0aa-77a766d723a0' ) ;

update gapagreementrate
set provider_id = 6004080,
	updatedby = 'CDM-19685',
	updatedon = now()
where gapagreementid 
	in ( '264199a3-74be-4ac0-8023-4f5efe4aec24', '2b88b3ff-4fc5-4b08-a0aa-77a766d723a0' ) ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid
	in ( '1c1f4e49-45e1-45c7-84a3-29f0d4a970b7',  '37bc5817-648e-4aac-a47e-9e4d31c0dc66' ) ;

update gapratesrevision
set providerid = 6004080,
	approvaldate = now(),
	updatedby = 'CDM-19685',
	updatedon = now()
where guardiansubsidyid
	in ( '1c1f4e49-45e1-45c7-84a3-29f0d4a970b7',  '37bc5817-648e-4aac-a47e-9e4d31c0dc66' ) ;

-- Delete On HOLD Payments with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in ( 3133249, 3133250 )
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19685'
where payment_id in ( 3133249, 3133250 )
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in ( 3133249, 3133250 )
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19685'
where payment_id in ( 3133249, 3133250 )
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in ( 3133249, 3133250 )
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19685'
where payment_id in ( 3133249, 3133250 )	
	and delete_sw = 'N' ;
	