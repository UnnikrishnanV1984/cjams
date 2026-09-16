CREATE OR REPLACE FUNCTION cjams.updatecommingledaccount(v_comm_trans_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

   	v_pagenumber int;
	v_pageoffset int;
	v_account_details json;
	i json;
	v_client_acc_id integer;
	v_transaction_amount_no numeric;
	comm_intrst_calc text;
BEGIN 

	--update 
	
	select json_agg(x) into v_account_details from (select  taat.client_account_id,taat.transaction_amount_no from tb_account_transaction taat  where taat.comm_acct_trans_id = v_comm_trans_id and taat.delete_sw= 'N') as x;

	update tb_account_transaction  set delete_sw='Y'  where comm_acct_trans_id = v_comm_trans_id and delete_sw= 'N';
	
	For i in Select * from json_array_elements(v_account_details)
LOOP
	raise notice 'test %' , i ->> 'client_account_id';
	raise notice 'transaction_amount_no %' , i ->> 'transaction_amount_no';
	v_client_acc_id := i ->> 'client_account_id';
	v_transaction_amount_no :=  i ->> 'transaction_amount_no';
	update tb_client_account set total_balance_no = coalesce(total_balance_no) - v_transaction_amount_no where client_account_id=v_client_acc_id;
	
END LOOP;

	update tb_account_transaction set delete_sw = 'Y' where comm_acct_trans_id=v_comm_trans_id;

   update tb_commingled_account set total_balance_no = coalesce(total_balance_no,0) -
(select interest_amount_no from tb_comm_acct_transactions where comm_acct_trans_id=v_comm_trans_id)
where comm_account_id = (select comm_account_id from tb_comm_acct_transactions where comm_acct_trans_id=v_comm_trans_id);
	
	update tb_comm_acct_transactions set interest_amount_no=mod_interest_amount_no, update_ts=now() where comm_acct_trans_id=v_comm_trans_id;
	
	select sp_commingled_interest_alloc into comm_intrst_calc from sp_commingled_interest_alloc(v_comm_trans_id);
	
return 'SUCCESS';
END;

$function$
;
