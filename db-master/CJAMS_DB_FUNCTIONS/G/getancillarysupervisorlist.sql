DROP function if exists getancillarysupervisorlist(integer,bigint,bigint,character varying);
DROP function if exists getancillarysupervisorlist(integer,bigint,bigint,character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getancillarysupervisorlist(v_providerid integer, v_lipagesize bigint, v_lipagenumber bigint, v_status character varying DEFAULT NULL::character varying, v_securityusersid character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint,client_account_id integer,authorization_id integer, payment_id integer, payment_dt date, payment_start_dt date, payment_end_dt date, gross_amount_no numeric, localdepartment character varying, county_cd character varying, reference_payment_detail_id integer, final_service_id integer, final_service_nm character varying, provider_nm character varying, tax_id_no numeric, taxidtype character varying, payment_status_cd character varying, paymentstatus character varying, client_id bigint, clientfirstname character varying, clientlastname character varying, final_service_start_dt date, final_service_end_dt date, payment_method_cd character varying, payment_method_nm character varying, change_reason_cd character varying, reason_changed character varying, report_1099_sw character, type_1099_cd character varying, type1099nm character varying, case_id bigint, payment_detail_id integer, fiscal_category_cd character varying, fiscal_category_desc character varying, routingstatustypeid integer, tosecurityusersid character varying, fromsecurityusersid character varying, intakeserviceid uuid, manual_sw character, provider_id integer, notes_tx character varying, originaldetails jsonb)
 LANGUAGE plpgsql
AS $function$

DECLARE 

   	v_pagenumber int;
	v_pageoffset int;
	v_countycode character varying = '';

	
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

if (v_status = 'All')
then v_status = null;
end if;
 if (v_status = 'A')
then v_status = '1634';
end if;
 if (v_status = 'P')
then v_status = '1637';
end if;
 if (v_status = 'R')
then v_status = '1638';
end if;

select c.statecountycode INTO v_countycode
from teammemberassignment ta 
inner join teammember tm on ta.teammemberid=tm.teammemberid
inner join team t on t.teamid=tm.teamid
inner join county c on t.countyid::uuid=c.countyid::uuid
where ta.securityusersid :: character varying = v_securityusersid;

return query

select  count(1) over() as totalcount, x.* from (select distinct payhead.client_account_id :: integer,payhead.authorization_id,payhead.payment_id,payhead.payment_dt,payhead.payment_start_dt,payhead.payment_end_dt,payhead.gross_amount_no,(select value_tx from tb_picklist_values where 
TRIM(PICKLIST_VALUE_CD)=paydet.county_cd
AND PICKLIST_TYPE_ID='104') localdepartment,paydet.county_cd,paydet.reference_payment_detail_id,paydet.final_service_id,
(select service_nm from tb_services where delete_sw='N' and service_id =paydet.final_service_id) as 
final_service_nm,prov.provider_nm,prov.tax_id_no,(select value_tx from tb_picklist_values where 
TRIM(PICKLIST_VALUE_CD)=prov.prov_tax_type_cd
AND PICKLIST_TYPE_ID='216') as taxidtype,tps.payment_status_cd,(select value_tx from tb_picklist_values where 
TRIM(PICKLIST_VALUE_CD)=tps.payment_status_cd
AND PICKLIST_TYPE_ID='133') as paymentstatus,paydet.client_id,client.firstname,client.lastname,
paydet.final_service_start_dt,paydet.final_service_end_dt,payhead.payment_method_cd,(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=payhead.payment_method_cd
AND PICKLIST_TYPE_ID='1') as payment_method_nm,paydet.change_reason_cd,(select value_tx from tb_picklist_values where PICKLIST_type_id=277 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.change_reason_cd)) as  reason_changed,
paydet.report_1099_sw,paydet.type_1099_cd,(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=paydet.type_1099_cd
AND PICKLIST_TYPE_ID='308') type1099cd,paydet.case_id,paydet.payment_detail_id :: integer,Trim(paydet.final_fiscal_category_cd) :: character varying,
(select tfc.fiscal_category_desc from tb_fiscal_category_master tfc where tfc.fiscal_category_cd = paydet.final_fiscal_category_cd
limit 1) as final_fiscal_category,
rr.routingstatustypeid , rr.tosecurityusersid,rr.fromsecurityusersid,isr.intakeserviceid,payhead.manual_sw,payhead.provider_id 
,paydet.notes_tx,(select jsonb_agg(y) from (select tph.payment_id as originalpaymentid,tph.gross_amount_no as originalpaymentamount,tph.payment_dt as originalpaymentdate from tb_payment_detail tpd 
join tb_payment_header tph on tph.payment_id = tpd.payment_id
where tpd.payment_detail_id = paydet.reference_payment_detail_id and tph.payment_type_cd='4')as y) as originaldetails
from tb_payment_header payhead
left JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id
left join tb_provider prov on prov.provider_id = payhead.provider_id
left join routing rr on rr.objectid = payhead.payment_id::character varying and rr.eventcode='ANPAYADJ'
left join tb_payment_status tps on tps.payment_id = payhead.payment_id and tps.delete_sw='N'
INNER JOIN person as client ON paydet.client_id = client.cjamspid
left join intakeservicerequest isr on isr.servicerequestnumber = paydet.case_id::character varying
where payment_type_cd='3294' and payhead.manual_sw='Y' and paydet.reference_payment_detail_id is not null
 and (v_providerid is null or payhead.provider_id=v_providerid)
 and (v_status is null or trim(tps.payment_status_cd) = v_status)
 and LOWER(COALESCE(v_countycode,'')) = LOWER(COALESCE(paydet.county_cd,'')) 
 order by payhead.payment_id desc
 ) as x
LIMIT v_liPageSize OFFSET v_pageoffset; 
	

END;

$function$
;
