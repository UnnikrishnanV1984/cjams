CREATE OR REPLACE FUNCTION cjams.get_paymentafsfmis(v_paymentid integer, v_page integer DEFAULT NULL::integer, v_limit integer DEFAULT NULL::integer, v_fmspage integer DEFAULT NULL::integer, v_fmslimit integer DEFAULT NULL::integer)
 RETURNS TABLE(totalcount bigint, history json, providername character varying, payment_id integer, payment_dt date, payment_type_nm character varying, payment_type_cd character varying, payment_status_cd character varying, payment_status_nm character varying, check_status_cd character varying, check_status_nm character varying, gross_amount_no numeric, check_status_dt date, interface_to_nm character varying, interface_to_cd character varying, afsorfmis json, provider_id integer, notes_tx character varying, offset_amount_no numeric)
 LANGUAGE plpgsql
AS $function$


DECLARE	

v_pagenumber   int;
v_pageoffset  int;  
v_fmspagenumber   int;
v_fmspageoffset  int;  

BEGIN  
 
	v_pagenumber  :=  v_page-1;
	v_pageoffset  =  v_pagenumber  *  v_limit;

	v_fmspagenumber  :=  v_fmspage-1;
	v_fmspageoffset  =  v_fmspagenumber  *  v_fmslimit;
    

 
RETURN QUERY 
	select count(1) over() as totalcount,
		(select json_agg(x) from (
			SELECT tpv.value_tx :: character varying,
				up.fullname as entered_by,
				tph.payment_history_id, 
				tph.payment_id, 
				tph.object_id, 
				tph.object_key, 
				tph.create_ts,
				tph.create_user_id,  
				tph.delete_sw, 
				tph.effective_end_dt, 
				c.countyname as local_dept, 
				(select uppn.phonenumber 
					from userprofilephonenumber uppn 
				where uppn.securityusersid = tph.create_user_id 
					and uppn.activeflag =1 
				order by uppn.old_id desc 
				limit 1) as phone_no
		FROM cjams.tb_payment_history tph
			left join userprofile up on up.securityusersid=tph.create_user_id
			left join teammemberassignment tma on tma.securityusersid= up.securityusersid and tma.activeflag=1 
			left join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag=1 
			left join team t on t.teamid = tm.teamid and t.activeflag=1
			left join county c on t.countyid = c.countyid::character varying
			left join tb_picklist_values tpv on trim(tpv.picklist_value_cd) :: character varying = trim (tph.object_id) :: character varying  and tpv.picklist_type_id=37
		where tph.payment_id = v_paymentid 
			and tph.delete_sw = 'Y' 
		order by tph.payment_history_id desc
		) as x),
		(CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') THEN 
			CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm) 
		 ELSE 
			tp.provider_nm 
		END) as providername,
		payhead.payment_id,
		payhead.payment_dt,
		(select value_tx from tb_picklist_values 
			where PICKLIST_type_id=2 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(payhead.payment_type_cd)
		) AS  payment_type_nm,
		payhead.payment_type_cd,
		tps.payment_status_cd,
		(select value_tx from tb_picklist_values 
			where PICKLIST_type_id=133 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(tps.payment_status_cd)
		) as payment_status_nm,
		payhead.check_status_cd, 
		(select value_tx from tb_picklist_values 
			where PICKLIST_type_id=37 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(payhead.check_status_cd)
		) as check_status_nm,
		payhead.gross_amount_no,
		payhead.check_status_dt,
		(select value_tx from tb_picklist_values 
			where PICKLIST_type_id=1285 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(payhead.interface_to_cd)
		) as interface_to_nm,
		payhead.interface_to_cd,
		(select json_agg(x) from 
			(select count(1) over() as totalcount,
			(select value_tx from tb_picklist_values 
				where PICKLIST_type_id=133 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(paystat.payment_status_cd)
			)  as payment_status,
			payhead1.gross_amount_no as paymentamountno,
			tfr.warrant_no,
			(case when tfr.warrant_written_dt is not null and btrim(tfr.warrant_written_dt) <> '' then
				tfr.warrant_written_dt::date
			 else
			 	null
			 end	
			) as warrant_written_dt,
			(CASE WHEN (tfr.create_ts is null) THEN 
				(case when tfr.warrant_written_dt is not null and btrim(tfr.warrant_written_dt) <> '' then
					tfr.warrant_written_dt::date
				 else
					null
				 end	
				)
			 ELSE 
				tfr.create_ts 
			 END) as create_ts
		from  tb_payment_header payhead1 
			left join tb_fmis_response tfr  on 
				(select TRIM ( LEADING '0' FROM CAST (tfr.invoice_no AS TEXT)))=(select TRIM (LEADING '0' FROM CAST (payhead1.payment_id AS TEXT) ))
			left join tb_payment_status paystat on paystat.payment_id = payhead1.payment_id
		where payhead1.payment_id =payhead.payment_id 
		and tfr.delete_sw = 'N'   
		
		union 
	 
		select count(1) over() as totalcount,
			tar.payment_status,
			tar.payment_amount as paymentamountno,
			tar.check_no as warrant_no,
			tar.check_dt::date as warrant_written_dt,
			tar.create_ts
		from tb_afs_response tar
		where tar.payment_id = payhead.payment_id 
			and tar.delete_sw = 'N' 
		LIMIT  v_fmslimit  OFFSET  v_fmspageoffset
		) as x)  as afsorfmis,
	
		payhead.provider_id,
		payhead.notes_tx,payhead.offset_amount_no 
	from tb_payment_header payhead
		left join tb_provider tp on tp.provider_id = payhead.provider_id 
		left join tb_payment_status tps on tps.payment_id = payhead.payment_id
	where payhead.payment_id=v_paymentid 
		and payhead.delete_sw = 'N' 
	LIMIT  v_limit  OFFSET  v_pageoffset 
	;
END;

$function$
;
