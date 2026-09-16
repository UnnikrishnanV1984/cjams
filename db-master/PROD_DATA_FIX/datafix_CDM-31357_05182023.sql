-- CDM-31357 - Conserved account
/*
-- Issue Description: 
   User request to re-open Conserved Account for the final disbursement

-- Client ID: 2195795 (D'ANTE MARQUIS KANE) - 18c54b51-b153-42e5-ad92-5c7871364761
-- Conserved Account ID: 11601 - bank of america
-- Disbursement ID : 5707 - $210.00

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Data Migration issue (Incomplete Final Disbursement information)  
-- Fix Provided: Datafix has been promoted to re-open the requested Conserved Account.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Account and delete incomplete Final Disbursement
select client_account_id, client_account_id, status_cd, close_dt, * 
	from tb_client_account 
where client_account_id = 11601
	and delete_sw = 'N' ;

update tb_client_account
set status_cd = '592', -- Active
	close_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-31357'
where client_account_id = 11601
	and delete_sw = 'N' ;
	
-- Remove incomplete Final Disbursement	
select client_account_id, amount, delete_sw, update_ts, update_user_id
	from tb_child_account_disbursement
where disbursement_id = 5707
	and delete_sw = 'N' ;
	
update tb_child_account_disbursement
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-31357'	
where disbursement_id = 5707
	and delete_sw = 'N' ;

select routingid, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where eventcode = 'FINALDIS'
	and objectid = '5707'
	and activeflag = 1 ;
	
update routing	
set activeflag = 0,
	updatedby = 'CDM-31357',
	updatedon = now()
where eventcode = 'FINALDIS'
	and objectid = '5707'
	and activeflag = 1 ;	