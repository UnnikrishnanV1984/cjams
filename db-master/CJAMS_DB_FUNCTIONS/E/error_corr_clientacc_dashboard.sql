DROP FUNCTION IF EXISTS  error_corr_clientacc_dashboard(v_routingstatustypeid integer, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_statusval character varying);
CREATE OR REPLACE FUNCTION cjams.error_corr_clientacc_dashboard(v_routingstatustypeid integer, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_statusval character varying)
 RETURNS TABLE(totalcount bigint, client_account_id bigint, account_no_tx character varying, client_nm text, client_id bigint, available_balance_no numeric, transaction_id bigint, transaction_dt date, benefit_end_dt date, benefit_start_dt date, transaction_amount_no numeric)
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
	v_routing := '{81}';
	else if(v_statusval = 'A')
	then
	v_routing := '{82}' ;
	else if(v_statusval = 'R')
	then
	v_routing :='{83}' ;
	else if(v_statusval = 'All')
	then
	v_routing := '{81,82,83}';
	end if;
	end if;
	end if;
	end if;
   
   if(v_routingstatustypeid = 81)
	then
	return query 
select count(1) over(), tca.client_account_id,tca.account_no_tx,concat (p.firstname ,' ', p.lastname , ' ', p.lastname) as pname,
tca.client_id,tca.available_balance_no , tat.transaction_id ,tat.transaction_dt,tat.benefit_end_dt,tat.benefit_start_dt,tat.transaction_amount_no
from tb_client_account tca
join tb_account_transaction tat on tat.client_account_id = tca.client_account_id 
join person p on p.cjamspid = tca.client_id 
join routing r on tat.transaction_id :: character varying = r.objectid   
where r.fromsecurityusersid = v_securityuserid and r.eventcode = 'CACCTRANS' and r.routingstatustypeid = Any(v_routing) and r.activeflag =1
and tca.status_cd = '592'
order by tat.transaction_dt desc 
LIMIT pagesize OFFSET v_pageoffset;

--select count(1) over(),tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,tct.mod_interest_amount_no as request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd from tb_commingled_account tca 
--join tb_comm_acct_transactions tct on tct.comm_account_id = tca.comm_account_id and tct.delete_sw = 'N'
--join routing r on tct.comm_acct_trans_id :: character varying = r.objectid 
--where r.routingstatustypeid = any(v_routing)  and r.eventcode = 'COMMACCDEL' and r.activeflag=1 and r.fromsecurityusersid = v_securityuserid
--group by tct.comm_acct_trans_id,tca.comm_account_id,tca.account_no,request_amount,tct.interest_amount_no,tct.interest_start_dt,tct.interest_end_dt,tca.county_cd
--LIMIT pagesize OFFSET v_pageoffset;

else if(v_routingstatustypeid = 82)
then

	return query 
select  count(1) over(), tca.client_account_id,tca.account_no_tx,concat (p.firstname ,' ', p.lastname , ' ', p.lastname) as pname,
tca.client_id,tca.available_balance_no , tat.transaction_id ,tat.transaction_dt,tat.benefit_end_dt,tat.benefit_start_dt,tat.transaction_amount_no
from tb_client_account tca
join tb_account_transaction tat on tat.client_account_id = tca.client_account_id 
join person p on p.cjamspid = tca.client_id 
join routing r on tat.transaction_id :: character varying = r.objectid   
where r.tosecurityusersid = v_securityuserid and r.eventcode = 'CACCTRANS' and r.routingstatustypeid = Any(v_routing) and r.activeflag =1
and tca.status_cd = '592'
order by tat.transaction_dt desc 
LIMIT pagesize OFFSET v_pageoffset;

end if;
end if;
END;

$function$
;
