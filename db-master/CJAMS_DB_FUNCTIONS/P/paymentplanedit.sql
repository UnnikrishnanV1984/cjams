CREATE OR REPLACE FUNCTION cjams.paymentplanedit(searchobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
   
    v_payment_plan_id int;
	v_receivable_id INT;
    v_amount_no numeric;
	v_percentage_no numeric;
	v_months_no int;
	v_plan_dt date;
	v_offset_sw character;
	v_payment_option_sw character varying;
	v_offset_option_sw character;
	v_current_receivable_amount numeric;
	v_securityusersid uuid;
	v_placementexists boolean;
	v_timestamp timestamp;
	vl_pay_plan_id int;
	v_startdate timestamp;
	v_enddate timestamp;
	
BEGIN 
v_payment_plan_id := searchobj ->> 'payment_plan_id';
v_receivable_id := searchobj ->> 'receivable_id';
v_amount_no := searchobj ->> 'amount_no';
v_percentage_no := searchobj ->> 'percentage_no';
v_months_no := searchobj ->> 'months_no';
v_plan_dt := searchobj ->> 'plan_dt';
v_offset_sw := searchobj ->> 'offset_sw';
v_payment_option_sw := searchobj ->> 'payment_option_sw';
v_offset_option_sw := searchobj ->> 'offset_option_sw';
v_current_receivable_amount := searchobj ->> 'current_receivable_amount';
raise notice 'v_current_receivable_amount%',v_current_receivable_amount;
v_securityusersid := searchobj ->> 'securityusersid';
v_placementexists := searchobj ->> 'placementexists';
v_timestamp := now()::timestamp with time zone;
v_startdate := (searchobj ->> 'start_dt')::timestamp with time zone;
v_enddate := (searchobj ->> 'end_dt')::timestamp with time zone;


raise notice 'v_payment_plan_id%',v_payment_plan_id;
update tb_payment_plan set end_dt=v_timestamp,delete_sw='Y',update_user_id=v_securityusersid,update_ts=v_timestamp where payment_plan_id=v_payment_plan_id;

IF(v_placementexists = true) THEN
v_offset_sw = 'Y';
v_payment_option_sw = null;
v_offset_option_sw = 'A';
v_amount_no = (v_current_receivable_amount * (v_percentage_no/100 ));
v_amount_no = ROUND(AVG(v_amount_no)::numeric,2);
v_months_no = v_current_receivable_amount / v_amount_no;
END IF;

IF(v_placementexists = false) THEN
v_offset_sw = null;
--v_payment_option_sw = 'A';
v_offset_option_sw = null;
END IF;

SELECT al_next_value from  sp_nextid ( 'sq_payment_plan') into vl_pay_plan_id;


INSERT INTO cjams.tb_payment_plan
(payment_plan_id, plan_dt,end_dt,start_dt, receivable_id, amount_no, percentage_no, months_no,  offset_sw, payment_option_sw, offset_option_sw, manual_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw, current_receivable_amount)
VALUES(vl_pay_plan_id, v_plan_dt,v_enddate,v_startdate, v_receivable_id, v_amount_no, v_percentage_no,v_months_no,  v_offset_sw, v_payment_option_sw,v_offset_option_sw, 'Y', v_timestamp,v_securityusersid, v_timestamp, v_securityusersid, 'N', v_current_receivable_amount);



return 'Success';

END;

$function$
;
