DROP FUNCTION sp_get_final_disbursement(character varying,integer,bigint,bigint,character varying);
CREATE OR REPLACE FUNCTION cjams.sp_get_final_disbursement(v_securityid character varying, routingstatus integer, v_lipagenumber bigint, v_lipagesize bigint, v_status character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint, disb_amount numeric, client_account_id bigint, client_id bigint, case_id bigint, open_dt date, close_dt date, account_no_tx character varying, account_type_cd text, account_type_nm character varying, total_balance_no numeric, available_balance_no numeric, disbursement_id integer, client_name character varying, remarks text, reason_tx text)
 LANGUAGE plpgsql
AS $function$

DECLARE  

	v_client_id bigint;
	v_pagenumber int;
	v_pageoffset int;
	v_routingstatus text[];
	
	
BEGIN 
	--v_client_id := searchobj ->> 'client_id';
	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;
	if(routingstatus = 57)
	then 
	if (v_status='All')
	then 
	v_routingstatus := '{57,58,61}';
   else if (v_status='R')
   then 
    	v_routingstatus := '{61}';
     else if (v_status='A')
   then 
    	v_routingstatus := '{58}';
     else  if (v_status='P')
   then 
    	v_routingstatus := '{57}';
    end if;
    end if;
    end if;
    end if;
	else if(routingstatus = 56)
	then
	if (v_status='All')
	then 
	v_routingstatus := '{57,58,56,61}';
   else if (v_status='R')
   then 
    	v_routingstatus := '{61}';
     else if (v_status='A')
   then 
    	v_routingstatus := '{58}';
     else  if (v_status='P')
   then 
    	v_routingstatus := '{56}';
    end if;
    end if;
    end if;
    end if;
	
	else if(routingstatus = 58) --for FW dashboard
	then
		if (v_status='All')
	then 
	v_routingstatus := '{57,58,56,61}';
   else if (v_status='R')
   then 
    	v_routingstatus := '{61}';
     else if (v_status='A')
   then 
    	v_routingstatus := '{58}';
     else  if (v_status='P')
   then 
    	v_routingstatus := '{56}';
    end if;
    end if;
    end if;
    end if;
	end if;
	end if;
	end if;
	raise notice 'v_routingstatus %',v_routingstatus;
	if(routingstatus != 58 and v_status not in ('P','A'))
	then
	
	raise notice '11111 %',v_routingstatus;
	return query	
	SELECT COUNT(1) OVER() totalcount,cad.amount as disb_amount,ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,TRIM(ca.account_type_cd) As account_type_cd,
 (select value_tx from tb_picklist_values where PICKLIST_TYPE_ID=40 AND TRIM(PICKLIST_VALUE_CD)=ca.account_type_cd::text) As  account_type_nm,
	ca.total_balance_no,ca.available_balance_no,cad.disbursement_id,concat(p.firstname,' ',p.lastname) :: character varying  as pname
	   ,(select  
		case when rr.routingstatustypeid in (58,61) then  rr.remarks 
		when  rr.tosecurityusersid=v_securityid  then  'Pending' 
		else  rr.remarks  end as remarks
		from routing rr where rr.objectid =  cad.disbursement_id ::  character varying  and rr.eventcode ='FINALDIS' and rr.activeflag =1 order by rr.insertedon desc limit 1) as remarks
		,(select rr.routeddescription from routing rr where rr.eventcode ='FINALDIS' and rr.activeflag =1 and  rr.objectid =  cad.disbursement_id ::  character varying limit 1 ) as reason_tx 
		from tb_client_account ca
		join person p on p.cjamspid=ca.client_id and p.activeflag=1
	join tb_child_account_disbursement cad on cad.client_account_id = ca.client_account_id and cad.delete_sw ='N'
	join routing r on r.objectid = cad.disbursement_id :: character varying  and r.eventcode='FINALDIS' --and r.activeflag = 1
	where r.tosecurityusersid=v_securityid and r.routingstatustypeid :: text  = any (v_routingstatus)
	group by ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,ca.account_type_cd,account_type_nm,ca.total_balance_no,ca.available_balance_no,cad.disbursement_id, pname,r.remarks,cad.disbursement_dt
	,disb_amount
	order by cad.disbursement_dt desc
	LIMIT v_liPageSize OFFSET v_pageoffset; 

	elsif(routingstatus != 58 and v_status ='P')
	then
	raise notice '2222 %',v_routingstatus;
	return query	
	SELECT COUNT(1) OVER() totalcount,cad.amount as disb_amount,ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,TRIM(ca.account_type_cd) As account_type_cd,
 (select value_tx from tb_picklist_values where PICKLIST_TYPE_ID=40 AND TRIM(PICKLIST_VALUE_CD)=ca.account_type_cd::text) As  account_type_nm,
	ca.total_balance_no,ca.available_balance_no,cad.disbursement_id,concat(p.firstname,' ',p.lastname) :: character varying  as pname
	   ,(select  
		case when rr.routingstatustypeid in (58,61) then  rr.remarks 
		when  rr.tosecurityusersid=v_securityid  then  'Pending' 
		else  rr.remarks  end as remarks
		from routing rr where rr.objectid =  cad.disbursement_id ::  character varying  and rr.eventcode ='FINALDIS' and rr.activeflag =1 order by rr.insertedon desc limit 1) as remarks
		,(select rr.routeddescription from routing rr where rr.eventcode ='FINALDIS' and rr.activeflag =1 and  rr.objectid =  cad.disbursement_id ::  character varying limit 1 ) as reason_tx 
		from tb_client_account ca
		join person p on p.cjamspid=ca.client_id and p.activeflag=1
	join tb_child_account_disbursement cad on cad.client_account_id = ca.client_account_id and cad.delete_sw ='N'
	join routing r on r.objectid = cad.disbursement_id :: character varying  and r.eventcode='FINALDIS' and r.activeflag = 1
	where r.tosecurityusersid=v_securityid and r.routingstatustypeid :: text  = any (v_routingstatus)
	group by ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,ca.account_type_cd,account_type_nm,ca.total_balance_no,ca.available_balance_no,cad.disbursement_id, pname,r.remarks,cad.disbursement_dt
	,disb_amount
	order by cad.disbursement_dt desc
	LIMIT v_liPageSize OFFSET v_pageoffset; 

	elsif(routingstatus != 58 and v_status ='A')
	then
	raise notice '2222 %',v_routingstatus;
	return query	
	SELECT COUNT(1) OVER() totalcount,cad.amount as disb_amount,ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,TRIM(ca.account_type_cd) As account_type_cd,
 (select value_tx from tb_picklist_values where PICKLIST_TYPE_ID=40 AND TRIM(PICKLIST_VALUE_CD)=ca.account_type_cd::text) As  account_type_nm,
	ca.total_balance_no,ca.available_balance_no,cad.disbursement_id,concat(p.firstname,' ',p.lastname) :: character varying  as pname
	   ,(select  
		case when rr.routingstatustypeid in (58,61) then  rr.remarks 
		when  rr.tosecurityusersid=v_securityid  then  'Pending' 
		else  rr.remarks  end as remarks
		from routing rr where rr.objectid =  cad.disbursement_id ::  character varying  and rr.eventcode ='FINALDIS' and rr.activeflag =1 order by rr.insertedon desc limit 1) as remarks
		,(select rr.routeddescription from routing rr where rr.eventcode ='FINALDIS' and rr.activeflag =1 and  rr.objectid =  cad.disbursement_id ::  character varying limit 1 ) as reason_tx 
		from tb_client_account ca
		join person p on p.cjamspid=ca.client_id and p.activeflag=1
	join tb_child_account_disbursement cad on cad.client_account_id = ca.client_account_id and cad.delete_sw ='N'
	join routing r on r.objectid = cad.disbursement_id :: character varying  and r.eventcode='FINALDIS' --and r.activeflag = 1
	where (r.tosecurityusersid=v_securityid or r.fromsecurityusersid=v_securityid) 
	and r.routingstatustypeid :: text  = any (v_routingstatus)
	group by ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,ca.account_type_cd,account_type_nm,ca.total_balance_no,ca.available_balance_no,cad.disbursement_id, pname,r.remarks,cad.disbursement_dt
	,disb_amount
	order by cad.disbursement_dt desc
	LIMIT v_liPageSize OFFSET v_pageoffset; 
	
	else  -- for FW need to check with from security user id in routing
	raise notice '3333 %',v_routingstatus;
	return query	
	SELECT COUNT(1) OVER() totalcount,cad.amount as disb_amount,ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,TRIM(ca.account_type_cd) As account_type_cd,
 (select value_tx from tb_picklist_values where PICKLIST_TYPE_ID=40 AND TRIM(PICKLIST_VALUE_CD)=ca.account_type_cd::text) As  account_type_nm,
	ca.total_balance_no,ca.available_balance_no,cad.disbursement_id,concat(p.firstname,' ',p.lastname) :: character varying  as pname
	,(select  
		case when rr.routingstatustypeid in (58,61) then  rr.remarks 
		when  rr.tosecurityusersid=v_securityid  then  'Pending' 
		else  rr.remarks  end as remarks
		from routing rr where rr.objectid =  cad.disbursement_id ::  character varying  and rr.eventcode ='FINALDIS' and rr.activeflag =1 order by rr.insertedon desc limit 1) as remarks
		,(select rr.routeddescription from routing rr where rr.eventcode ='FINALDIS' and rr.activeflag =1 and  rr.objectid =  cad.disbursement_id ::  character varying limit 1 ) as reason_tx 
		from tb_client_account ca
		join person p on p.cjamspid=ca.client_id and p.activeflag=1
	join tb_child_account_disbursement cad on cad.client_account_id = ca.client_account_id and cad.delete_sw ='N'
	join routing r on r.objectid = cad.disbursement_id :: character varying  and r.eventcode='FINALDIS' 
	where r.fromsecurityusersid=v_securityid and r.routingstatustypeid :: text  = any (v_routingstatus) and r.activeflag = 1
	group by ca.client_account_id,ca.client_id,ca.case_id,ca.open_dt,ca.close_dt,ca.account_no_tx
	,ca.account_type_cd,account_type_nm,ca.total_balance_no,ca.available_balance_no,cad.disbursement_id, pname,r.remarks,cad.disbursement_dt
	,disb_amount
	order by cad.disbursement_dt desc
	LIMIT v_liPageSize OFFSET v_pageoffset; 
	
	end if;
	
END;

$function$;
