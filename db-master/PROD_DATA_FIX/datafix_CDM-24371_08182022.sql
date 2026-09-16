-- CDM-24371 - GAP subsidy not opened
/*
-- Issue Description: 
   GAP payment is not paid to provider.

-- Case ID: 3239217 - 7dbb73e1-1151-4006-8f9c-441cd7a39777
-- Client ID: 3429537 (AYDIAN HENDERSON) - 1c3f3bb3-0588-406b-8323-46c40879d443
-- GAP ID: 1006120 - 2022-04-18 To 2030-08-07 - 9c50446d-4863-4059-99d2-67da0917a181
-- Provider ID: 5089860 (Mary Daniel) - Local Department Home

-- gapagreementid: abfbced8-57f3-42c4-b9ba-c70b5a5e7826 (with Rate & Provider)
-- Duplicate gapagreementid: 4a3ff51f-05e4-4429-91e4-33ac0ebf4d5b (with NO rates)

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Duplicate gapagreementid: 4a3ff51f-05e4-4429-91e4-33ac0ebf4d5b (with NO rates)
select gapid, gapagreementid, activeflag, updatedby, updatedon
	from gapagreement 
where gapagreementid = '4a3ff51f-05e4-4429-91e4-33ac0ebf4d5b'
	and activeflag  = 1 ;
 
update gapagreement
set activeflag = 0, 
	updatedby = 'CDM-24371',
	updatedon = now()
where gapagreementid = '4a3ff51f-05e4-4429-91e4-33ac0ebf4d5b'
	and activeflag  = 1 ;

-- To Trigger Under/Over	
select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '9c50446d-4863-4059-99d2-67da0917a181'
	and gapagreementid = 'abfbced8-57f3-42c4-b9ba-c70b5a5e7826' ;

update gapagreementrevision
set approvaldate = now(),
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = '9c50446d-4863-4059-99d2-67da0917a181'
	and gapagreementid = 'abfbced8-57f3-42c4-b9ba-c70b5a5e7826' ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24371'
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24371'
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24371'
where payment_id in (3219735, 3219736, 3219737, 3219738)
	and delete_sw = 'N' ;

