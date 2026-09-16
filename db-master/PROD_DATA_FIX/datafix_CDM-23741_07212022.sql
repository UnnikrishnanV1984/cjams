-- CDM-23741 - Child account
/*
-- Issue Description: 
   Child Account but funds remained in the account. 
   These funds need to be disbursed please reopen account.

-- Client ID: 3651583 (SAMUEL JACOB GOMES) - ff7f784f-58d2-43bb-98e6-c4340ec3f58f
-- Conserved Account ID: 11322 - Balance $961.00
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Partial Transaction (Migrated date issue)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Account and delete incomplete Final Disbursement
select client_account_id, client_account_id, status_cd, close_dt, * 
	from tb_client_account 
where client_account_id = 11322
	and delete_sw = 'N' ;

update tb_client_account
set status_cd = '592', -- Active
	close_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-23741'
where client_account_id = 11322
	and delete_sw = 'N' ;
	
-- Remove incomplete Final Disbursement	
select client_account_id, amount, delete_sw, update_ts, update_user_id
	from tb_child_account_disbursement
where disbursement_id = 5881
	and delete_sw = 'N' ;
	
update tb_child_account_disbursement
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23741'	
where disbursement_id = 5881
	and delete_sw = 'N' ;

select routingid, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where eventcode = 'FINALDIS'
	and objectid = '5881'
	and activeflag = 1 ;
	
update routing	
set activeflag = 0,
	updatedby = 'CDM-23741',
	updatedon = now()
where eventcode = 'FINALDIS'
	and objectid = '5881'
	and activeflag = 1 ;	