DROP function if exists error_correction_dashboard(integer,character varying,bigint,bigint,character varying);
CREATE OR REPLACE FUNCTION cjams.error_correction_dashboard(v_routingstatustypeid integer, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_statusval character varying)
 RETURNS TABLE(totalcount bigint, comm_acct_trans_id integer, comm_account_id integer, account_no character varying, request_amount numeric, interest_amount_no numeric, interest_start_dt date, interest_end_dt date, county_cd character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_pageoffset int;
    v_pagenumber int;
   v_routing int[];
	
BEGIN

	v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
   
   	if(v_statusval = 'P')
	then
	v_routing := '{45}';
	else if(v_statusval = 'A')
	then
	v_routing := '{53}' ;
	else if(v_statusval = 'R')
	then
	v_routing :='{63}' ;
	else if(v_statusval = 'All')
	then
	v_routing := '{45,53,63}';
	end if;
	end if;
	end if;
	end if;
   
   if(v_routingstatustypeid = 45)
	then

	return query 
select count(1) over(),tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,tct.mod_interest_amount_no as request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd from tb_commingled_account tca 
join tb_comm_acct_transactions tct on tct.comm_account_id = tca.comm_account_id and tct.delete_sw = 'N'
join routing r on tct.comm_acct_trans_id :: character varying = r.objectid 
where r.routingstatustypeid = any(v_routing)  and r.eventcode = 'COMMACCDEL' and r.activeflag=1 and r.fromsecurityusersid = v_securityuserid
group by tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd
order by tct.comm_acct_trans_id desc
LIMIT pagesize OFFSET v_pageoffset;

else if(v_routingstatustypeid = 53)
then

	return query 
select count(1) over(),tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,tct.mod_interest_amount_no as request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd from tb_commingled_account tca 
join tb_comm_acct_transactions tct on tct.comm_account_id = tca.comm_account_id and tct.delete_sw = 'N'
join routing r on tct.comm_acct_trans_id :: character varying = r.objectid 
where r.routingstatustypeid =any (v_routing) and r.eventcode = 'COMMACCDEL' and r.activeflag=1 and r.tosecurityusersid = v_securityuserid
group by tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd
order by tct.comm_acct_trans_id desc
LIMIT pagesize OFFSET v_pageoffset;

end if;
end if;
END;

$function$
;
