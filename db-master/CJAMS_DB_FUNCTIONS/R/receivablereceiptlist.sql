DROP FUNCTION IF EXISTS cjams.receivablereceiptlist(integer, integer, bigint, bigint);

CREATE OR REPLACE FUNCTION cjams.receivablereceiptlist(	v_paymentdetailid integer, 
														v_providerid integer, 
														v_lipagesize bigint, 
														v_lipagenumber bigint
													  )
 RETURNS TABLE(totalcount bigint, type character varying, receipt_id bigint, receipt_dt date, receipttype character varying, payment_amount_no numeric, receipt_status text, collected_amount_no numeric, referencenumber character varying, receivable_id bigint, receivable_detail_id integer, notes_tx character varying, enteredat timestamp without time zone, enteredby character varying, payment_method_cd character varying, payment_type_cd character varying, payee_cd character varying, isreversal boolean, reversal_reason_tx character varying, reversal_amount_no numeric, tosecurityusersid character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/25/2023 Vineet Tirodkar - To exclude the soft deleted records (CDM-33044)
------------------------------------------------------------------------------------------------------------
DECLARE 
   	v_pagenumber int;
	v_pageoffset int;

	
BEGIN 
	IF COALESCE(v_liPageSize, 0) < 1 THEN                     
		v_liPageSize := 10;
	END IF;

	IF COALESCE(v_liPageNumber, 0) < 1 
	THEN
		v_liPageNumber := 1;	
	end if;

	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;

	return query

	select count(1) over(),receipts.* from
		(

			(select 'Offset' as type,
				tro.offset_id as receipt_id,
				tro.offset_dt as receipt_dt,
				null::character varying as receipttype,
				tro.offset_amount_no 
				as payment_amount_no,
				(select r.remarks 
					from routing r 
				where r.objectid = trl.receipt_id::character varying 
					and r.activeflag = 1 
					and r.eventcode = 'RVRSL' 
				limit 1) as receipt_status,
				trl.collected_amount_no,
				tro.payment_id::character varying as referencenumber,
				trd.receivable_id::bigint,
				trd.receivable_detail_id,
				null::character varying as notes_tx,
				tro.create_ts as enteredat,
				up.fullname as enteredby,
				null::character varying as payment_method_cd,
				null::character varying as payment_type_cd,
				null::character varying as payee_cd,
				trd.isreversal,
				trl.reversal_reason_tx,
				trd.reversal_amount_no,
				r.tosecurityusersid 
			from tb_payment_header tph
				join tb_payment_detail tpd on tpd.payment_id= tph.payment_id
					and tpd.delete_sw = 'N'
				join tb_receivable_detail trd on trd.payment_detail_id = tpd.payment_detail_id
					and trd.delete_sw = 'N'
				join tb_RECEIVABLE_LIQUIDATION trl on trl.receivable_detail_id = trd.receivable_detail_id 
					and trl.offset_id is not null
					and trl.delete_sw = 'N'
				join tb_RECEIVABLE_OFFSET tro on tro.offset_id = trl.offset_id
					and tro.delete_sw = 'N'
				left join routing r on r.objectid::int = trd.receivable_detail_id 
					and r.eventcode = 'RVRSL' 
					and r.activeflag = 1
				left join userprofile up on up.securityusersid = tro.create_user_id
			where (v_paymentdetailid is null or tpd.payment_detail_id = v_paymentdetailid)
				and tph.provider_id = v_providerid
				and tph.delete_sw = 'N' 
			)

			union all

			(select 'Recovery'::character varying as type,
				tpr.receipt_id,
				tpr.receipt_dt,
				(select value_tx 
					from tb_picklist_values 
				where PICKLIST_type_id = 5 
					AND delete_sw='N'
					AND active_sw='Y' 
					AND  TRIM(PICKLIST_VALUE_CD)=TRIM(tpr.payment_method_cd)
				) as receipttype,
				tpr.payment_amount_no,
				(select r.remarks 
					from routing r 
				where r.objectid=trl.receipt_id::character varying 
					and r.activeflag=1  
					and r.eventcode='RVRSL' 
				limit 1) as receipt_status,
				trl.collected_amount_no,
				tpr.payment_no_tx as referencenumber,
				trd.receivable_id::bigint,
				trd.receivable_detail_id,
				tpr.notes_tx,
				tpr.create_ts as enteredat,
				up.fullname as enteredby,
				tpr.payment_method_cd,
				tpr.payment_type_cd,
				tpr.payee_cd,
				trd.isreversal,
				trl.reversal_reason_tx as reversal_reason_tx,
				trd.reversal_amount_no as reversal_amount_no,
				r.tosecurityusersid 
			from tb_payment_detail tpd
				join tb_payment_header tph on tpd.payment_id= tph.payment_id
					and tph.delete_sw = 'N' 
				join tb_receivable_detail trd on trd.payment_detail_id = tpd.payment_detail_id
					and trd.delete_sw = 'N' 
				join tb_RECEIVABLE_LIQUIDATION trl on trd.receivable_detail_id = trl.receivable_detail_id 
					and trl.receipt_id is not null
					and trl.delete_sw = 'N' 
				join tb_payment_receipt tpr on tpr.receipt_id = trl.receipt_id
					and tpr.delete_sw = 'N' 
				left join routing r on r.objectid::int = tpr.receipt_id 
					and r.eventcode = 'RVRSL' 
					and r.activeflag = 1
				left join userprofile up on up.securityusersid = tpr.create_user_id
			where (v_paymentdetailid is null or tpd.payment_detail_id = v_paymentdetailid)
				and tph.provider_id=v_providerid
				and tpd.delete_sw = 'N' 
			)
		)
		as receipts
	group by receipts.type,receipts.receipt_id,receipts.receipt_dt,receipts.receipttype,
		receipts.payment_amount_no,receipts.collected_amount_no,receipts.referencenumber,receipts.receivable_id,
		receipts.receivable_detail_id,receipts.notes_tx,receipts.enteredat,receipts.enteredby,receipts.payment_method_cd,
		receipts.payment_type_cd,receipts.payee_cd,receipts.isreversal,receipts.reversal_reason_tx,
		receipts.reversal_amount_no,receipts.receipt_status,receipts.tosecurityusersid
	order by receipts.receipt_id desc
	LIMIT v_liPageSize OFFSET v_pageoffset; 

END;

$function$
