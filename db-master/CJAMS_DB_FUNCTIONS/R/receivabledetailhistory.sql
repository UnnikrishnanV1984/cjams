drop function if exists cjams.receivabledetailhistory(v_receivable_detail_id integer);
CREATE OR REPLACE FUNCTION cjams.receivabledetailhistory(v_receivable_detail_id integer, v_userid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_fiscal_category_cd character;
    
	
BEGIN 
	
	INSERT INTO cjams.tb_receivable_detail_history
	(--receivable_detail_history_id,
	receivable_detail_id, 
	payment_detail_id, 
	receivable_id, 
	amount_no, 
	receivable_balance_no,
	written_off_amount_no, 
	receivable_ts, 
	receivable_status_cd, 
	receivable_status_dt, 
	comments_tx, 
	start_dt,
	end_dt, 
	unit_no, 
	manual_sw,
	county_cd, 
	notes_tx, 
	approval_status_cd, 
	action_dt, 
	approve_staff_id, 
	create_ts, 
	create_user_id, 
	update_ts, 
	update_user_id, 
	delete_sw, 
	receivable_type, 
	write_off_approval_status,
	write_off_action_date, 
	approved_by, 
	write_off_request_user_id, 
	write_off_request_date, 
	written_off_request_amount_no, 
	isreversal,
	activeflag)
--VALUES(gen_random_uuid(), 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', 0, '', '', '', '', '', 0, '', '', '', '', 'N'::bpchar, '', '', '', '', '', '', 0, false, 1);
                                                                                                                     
   
   SELECT 
	   receivable_detail_id, 
	   payment_detail_id, 
	   receivable_id, 
	   amount_no,
	   receivable_balance_no,
   	   written_off_amount_no, 
   	   receivable_ts, 
   	   receivable_status_cd, 
   	   receivable_status_dt, 
   	   comments_tx, 
   	   start_dt, 
   	   end_dt, 
 	   unit_no, 
 	   manual_sw, 
 	   county_cd, 
 	   notes_tx, 
 	   approval_status_cd, 
 	   action_dt, 
 	   approve_staff_id, 
       create_ts, 
       create_user_id, 
       update_ts, 
       update_user_id, 
       delete_sw, 
       receivable_type, 
   	   write_off_approval_status, 
   	   write_off_action_date, 
   	   v_userid, 
   	   write_off_request_user_id, 
       write_off_request_date, 
       written_off_request_amount_no, 
       isreversal,1
	FROM cjams.tb_receivable_detail 

   where receivable_detail_id =v_receivable_detail_id ;  
  
  if((select write_off_approval_status FROM cjams.tb_receivable_detail where receivable_detail_id =v_receivable_detail_id) = '3047')
   then
    update tb_payment_plan set current_receivable_amount = 
     coalesce(current_receivable_amount,0)
     -
  	 coalesce((select written_off_request_amount_no FROM cjams.tb_receivable_detail where receivable_detail_id =v_receivable_detail_id),0) 
  	 where  receivable_id in
  	 (select receivable_id FROM cjams.tb_receivable_detail where receivable_detail_id =v_receivable_detail_id);
	end if;
return 'Success';

END;

$function$
;
