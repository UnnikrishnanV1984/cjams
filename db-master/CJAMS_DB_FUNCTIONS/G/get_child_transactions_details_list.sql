CREATE OR REPLACE FUNCTION cjams.get_child_transactions_details_list(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, transaction_id bigint, client_account_id bigint, transaction_type_cd character varying, transaction_type character varying, transaction_source_cd character varying, transaction_source character varying, benefit_start_dt date, benefit_end_dt date, transaction_amount_no numeric, transaction_dt date, credit_debit_sw character, notes_tx character varying, create_ts timestamp without time zone, frequency_cd character varying, create_user_id character varying, entered_by character varying, adjustment_approval_status_cd character varying, reference_transaction_id integer, payment_detail_id integer, authorization_id integer, status_type integer, reason_tx character varying, error_correction_amt numeric)
 LANGUAGE plpgsql
AS $function$

DECLARE  

	v_client_account_id bigint;
	v_pagenumber int;
	v_pageoffset int;
	sortorder varchar ;
	sortcolumn varchar ;
	
BEGIN 
v_client_account_id := searchobj ->> 'client_account_id';
sortorder := lower(searchobj ->> 'sortorder');
sortcolumn := lower(searchobj ->> 'sortcolumn');

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

	return query
		
	select COUNT(1) OVER() totalcount,
	ACTR.transaction_id,
	ACTR.client_account_id
	,ACTR.transaction_type_cd
	,(SELECT value_tx FROM tb_picklist_values where picklist_type_id=39 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_type_cd::text) as transaction_type
	,ACTR.transaction_source_cd
	,((SELECT value_tx FROM tb_picklist_values where picklist_type_id=38 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_source_cd::text)) as transaction_source
	,ACTR.benefit_start_dt,
	ACTR.benefit_end_dt,
	ACTR.transaction_amount_no,
	ACTR.transaction_dt,
	ACTR.credit_debit_sw,
	ACTR.notes_tx,
	ACTR.create_ts,
	ACTR.frequency_cd
	,ACTR.create_user_id
	,UP.displayname as entered_by
	,ACTR.adjustment_approval_status_cd,
	ACTR.reference_transaction_id,
	ACTR.payment_detail_id,
	ACTR.authorization_id,
	(select r.routingstatustypeid from routing r where  r.eventcode = 'CACCTRANS' and r.activeflag =1 and r.objectid = ACTR.transaction_id :: character varying and ACTR.delete_sw = 'N' order by r.insertedon desc limit 1 ),
	(select r.routeddescription from routing r where  r.eventcode = 'CACCTRANS' and r.activeflag =1 and r.objectid = ACTR.transaction_id :: character varying and ACTR.delete_sw = 'N' order by r.insertedon desc limit 1 )::varchar as reason_tx,
	(select tat1.transaction_amount_no +
((select coalesce(sum(tat2.transaction_amount_no),0) from tb_account_transaction tat2 
where tat2.reference_transaction_id = tat1.transaction_id and tat2.credit_debit_sw = 'C' and tat2.delete_sw = 'N' and
(tat2.adjustment_approval_status_cd != '3281' or tat2.adjustment_approval_status_cd is null or tat2.adjustment_approval_status_cd ='3047' ))
-
(select coalesce(sum(tat3.transaction_amount_no),0) from tb_account_transaction tat3
where tat3.reference_transaction_id = tat1.transaction_id and tat3.credit_debit_sw = 'D' and tat3.delete_sw = 'N' and
(tat3.adjustment_approval_status_cd != '3281' or tat3.adjustment_approval_status_cd is null or tat3.adjustment_approval_status_cd ='3047' ))
)
from tb_account_transaction tat1 where tat1.transaction_id = ACTR.transaction_id and tat1.delete_sw = 'N' and ACTR.delete_sw = 'N') :: numeric(10,2) as error_correction_amt
	from TB_ACCOUNT_TRANSACTION AS ACTR
	LEFT JOIN userprofile UP on UP.securityusersid=ACTR.create_user_id
	where ACTR.client_account_id=v_client_account_id
	and ACTR.delete_sw = 'N'
	order by (case sortorder when 'asc' then 
									case sortcolumn when 'transaction_id' then cast(ACTR.transaction_id as character varying) 
													when 'reference_transaction_id' then cast(ACTR.reference_transaction_id as character varying) 
													when 'transaction_dt' then cast(ACTR.transaction_dt as character varying)
													when 'transaction_type' then cast((SELECT value_tx FROM tb_picklist_values where picklist_type_id=39 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_type_cd::text) as character varying)
													when 'credit_debit_sw' then cast(ACTR.credit_debit_sw as character varying)
													when 'transaction_source' then cast(((SELECT value_tx FROM tb_picklist_values where picklist_type_id=38 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_source_cd::text)) as character varying)
									else cast(ACTR.benefit_start_dt as character varying) 
									end
				END) ASC NULLS LAST,
				(case sortorder when 'desc' then 
									case sortcolumn when 'transaction_id' then cast(ACTR.transaction_id as character varying)
													when 'reference_transaction_id' then cast(ACTR.reference_transaction_id as character varying)
													when 'transaction_dt' then cast(ACTR.transaction_dt as character varying)
													when 'transaction_type' then cast((SELECT value_tx FROM tb_picklist_values where picklist_type_id=39 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_type_cd::text) as character varying)
													when 'credit_debit_sw' then cast(ACTR.credit_debit_sw as character varying)
													when 'transaction_source' then cast(((SELECT value_tx FROM tb_picklist_values where picklist_type_id=38 and delete_sw='N' and TRIM(picklist_value_cd)=ACTR.transaction_source_cd::text)) as character varying)
									else cast(ACTR.benefit_start_dt as character varying) 
									end
				END) DESC NULLS LAST
	
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$
;
