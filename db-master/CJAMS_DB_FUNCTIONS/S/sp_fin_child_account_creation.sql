CREATE OR REPLACE FUNCTION cjams.sp_fin_child_account_creation()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Create a FCYS account for the children
------------------------------------------------------------------------
DECLARE
 cur_child record; 
 cur_child_refcur REFCURSOR;
 v_accountCount integer;
BEGIN
 

  OPEN cur_child_refcur FOR
	select id,client_id, 
	open_dt, county_cd,
	comm_account_id, conserved_account_id, 
	amount_to_fcys_account, delete_sw, is_fcys_created, is_bal_transferred from tb_client_account_balance_transfer where delete_sw='N' and is_fcys_created='N';


	LOOP
	FETCH cur_child_refcur INTO cur_child;
										 EXIT WHEN NOT FOUND;
	
	select count(1) into v_accountCount from tb_client_account where client_id = cur_child.client_id
	and trim(account_type_cd) = '592' -- 592 -- FCYS account type
	and open_dt is not null 
	and close_dt is null 
	and status_cd = '592' -- active account
	;
	IF (v_accountCount = 0) THEN
	INSERT INTO cjams.tb_client_account
    (client_id, account_type_cd, account_exists_sw, bank_nm, account_no_tx, 
	total_balance_no, available_balance_no, open_dt, close_dt, status_cd, county_cd, create_user_id, update_user_id, delete_sw, bank_info_approval_status_cd, comm_account_id, case_id, data_valid_sw, client_merge_id, obligated_for_anc, obligated_for_coc, create_ts, update_ts, final_close_dt, etl_userid, etl_load_date)
    VALUES(cur_child.client_id, '592', 'N', '', (SELECT concat('F',floor(random()* (10000000-100000 + 1) + 100000)::int)),
	NULL, NULL, current_date, NULL, '592', cur_child.county_cd, 'finance', 'finance', 'N', NULL, cur_child.comm_account_id, NULL, NULL, NULL, NULL, NULL, now(), now(), NULL, NULL, NULL);

	update tb_client_account_balance_transfer set is_fcys_created='Y',update_ts=now() where id=cur_child.id;
	
	END IF;
END LOOP;
CLOSE cur_child_refcur;
return 1;
end;
$function$;
