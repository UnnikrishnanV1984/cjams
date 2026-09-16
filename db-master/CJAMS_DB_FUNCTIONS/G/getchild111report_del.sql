DROP FUNCTION cjams.getchild111report(v_clientid integer, v_paymenttype character varying, v_lipagesize bigint, v_lipagenumber bigint, date_sw character varying , date_from date , date_to date);


CREATE OR REPLACE FUNCTION cjams.getchild111report_del(v_clientid integer, v_paymenttype character varying, v_lipagesize bigint, v_lipagenumber bigint, date_sw character varying DEFAULT NULL::character varying, date_from date DEFAULT NULL::date, date_to date DEFAULT NULL::date)
 RETURNS TABLE(child111report json)
 LANGUAGE plpgsql
AS $function$

DECLARE	
 v_pageSize INT;
 v_pageNumber INT;
 v_pageNum INT; 
 v_pageOffset INT;

BEGIN  
 
 v_pageNum := v_pageNumber - 1;

 v_pageOffset = v_pageNum  * v_pageSize; 



 RETURN QUERY 
(select json_agg(x) from (
 SELECT 
tfd.fiscal_category_desc as funding_source,
isrt.description as case_nm,
concat(client.firstname,' ',client.lastname) as client_nm,
payhead.payment_id AS payment_id
,paydet.payment_detail_id:: bigint AS payment_detailid
,payhead.provider_id AS provider_id
,payhead.payment_dt AS payment_dt
,payhead.client_account_id AS client_account_id
,payhead.payment_type_cd AS payment_type_cd
,payhead.check_status_cd AS check_status_cd
,payhead.check_status_dt AS check_status_dt
,payhead.payment_method_cd AS payment_method_cd
,(payhead.gross_amount_no +coalesce(payhead.offset_amount_no,0.00) ) as netamount
,payhead.gross_amount_no AS gross_amount_no
,payhead.offset_amount_no AS offset_amount_no
,payhead.payee_nm AS payee_nm
,payhead.interface_to_cd AS interface_to_cd,
(select value_tx from tb_picklist_values where PICKLIST_type_id=1285 AND delete_sw='N'
AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(payhead.interface_to_cd)) as interface_to_nm
,payhead.adr_type_cd AS adr_type_cd
,payhead.payment_start_dt AS payment_start_dt
,payhead.payment_end_dt AS payment_end_dt
,paydet.case_id as case_id

,paydet.client_id AS client_id



,paydet.draft_units_no AS draft_units_no
,paydet.final_service_id AS final_service_id
,(select service_nm from tb_services where STRUCTURE_SERVICE_CD = 'P' and delete_sw='N' and service_id =paydet.final_service_id) as service_nm
--,case when payhead.payment_type_cd='3294' then (select pd.final_service_start_dt from tb_payment_detail pd where pd.payment_id =
--(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1) else 
,paydet.final_service_start_dt AS final_service_start_dt,
case when (payhead.payment_type_cd='3294' and paydet.reference_payment_detail_id is not null) then (select pd.final_service_start_dt from tb_payment_detail pd where pd.payment_detail_id =
(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1) else 
paydet.final_service_end_dt end AS final_service_end_dt
--paydet.final_service_end_dt AS final_service_end_dt
,case when (payhead.payment_type_cd='3294' and paydet.reference_payment_detail_id is not null) then (select paydet.final_units_no - pd.final_units_no  as final_units_no  from tb_payment_detail pd where pd.payment_detail_id =
(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1)
else paydet.final_units_no end AS final_units_no
--,paydet.draft_amount_no AS draft_amount_no
,paydet.final_amount_no AS final_amount_no
,paydet.notes_tx AS notes_tx
,paydet.status_cd AS status_cd
--,(select value_tx from tb_picklist_values where PICKLIST_type_id=82 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.draft_rate_type_cd)) AS draft_rate_type_cd
,(select value_tx from tb_picklist_values where PICKLIST_type_id=82 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.final_rate_type_cd)) AS final_rate_type_cd
--,paydet.draft_unit_rate_amt AS draft_unit_rate_amt
--,paydet.final_unit_rate_amt AS final_unit_rate_amt
--,(select value_tx from tb_picklist_values where PICKLIST_type_id=1316 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.draft_unit_type)) AS draft_unit_type
,(select value_tx from tb_picklist_values where PICKLIST_type_id=1316 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.final_unit_type)) AS final_unit_type

,paydet.final_fiscal_category_cd  AS final_fiscal_category_cd
,(select fiscal_category_desc from TB_FISCAL_CATEGORY_MASTER where delete_sw='N' AND fiscal_category_cd=paydet.draft_fiscal_category_cd limit 1) as draft_fiscal_category_nm
,(select fiscal_category_desc from TB_FISCAL_CATEGORY_MASTER where delete_sw='N' AND fiscal_category_cd=paydet.final_fiscal_category_cd limit 1) as final_fiscal_category_nm
,paydet.client_id as client_id
,client.cjamspid AS    cis_client_id
,client.firstname AS        client_first_nm
,client.lastname     AS    client_last_nm    
,prov.mail_code_tx AS     mail_code_tx
,prov.tax_id_no AS         tax_id_no


,(select value_tx from tb_picklist_values where PICKLIST_type_id=216 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(prov.prov_tax_type_cd)) AS  prov_tax_type_cd
,prov.provider_first_nm AS         prov_first_nm
,prov.provider_last_nm     AS      prov_last_nm 
--,CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) As provider_nm    
,CASE WHEN (prov.provider_nm = null OR prov.provider_nm='') 
THEN CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) ELSE prov.provider_nm END AS provider_nm
,(select value_tx from tb_picklist_values where PICKLIST_type_id=277 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.change_reason_cd)) as  reason_changed  
,(select value_tx from tb_picklist_values where PICKLIST_type_id=104 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(prov.county_cd)) as  local_department  
,(select distinct up.fullname 
from servicecase ISR
inner join userprofile up on up.securityusersid=ISR.insertedby
left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
left join userprofileaddress upa on up.securityusersid = upa.securityusersid
where   isr.activeflag=1  
and up.activeflag=1 and  ISR.servicecasenumber=paydet.case_id:: character varying
) as case_worker_nm
,(select distinct PV.value_tx from tb_payment_status PS 
INNER JOIN tb_picklist_values PV on PS.payment_status_cd=TRIM(PV.PICKLIST_VALUE_CD) 
AND PV.PICKLIST_TYPE_ID='133'
AND PS.payment_id=payhead.payment_id) as payment_status_nm
,case when (payhead.payment_type_cd='3294' and payhead.manual_sw='Y') then 'Manual Adjustments' else (select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=payhead.payment_type_cd
AND PICKLIST_TYPE_ID='2') end as payment_type_nm,(select coalesce(trd.receivable_balance_no,0) from tb_receivable_detail trd where trd.payment_detail_id = paydet.payment_detail_id limit 1) as receivable_balance_no,
(select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(payhead.check_status_cd) and picklist_type_id=37 limit 1) as check_status
FROM tb_payment_header as payhead  

INNER JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id
--INNER JOIN tb_payment_detail_temp as paydettemp ON payhead.payment_id = paydettemp.payment_id
INNER JOIN person as client ON paydet.client_id = client.cjamspid
--inner join tb_client_account tca on tca.client_id =  client.cjamspid 
INNER JOIN tb_provider as prov ON payhead.provider_id = prov.provider_id
left join servicecase sc on sc.servicecasenumber= paydet.case_id::character varying
left join intakeservicerequest isr on isr.servicecaseid = sc.servicecaseid
left join IntakeServiceRequestType isrt on isrt.intakeservreqtypeid = isr.intakeservreqinputtypeid
left join tb_fiscal_category_master tfd on tfd.fiscal_category_cd = paydet.final_fiscal_category_cd
INNER JOIN tb_payment_status paystat ON payhead.payment_id=paystat.payment_id
where (v_clientid is null or  paydet.client_id  = v_clientid ) and 
(v_paymenttype is null or payhead.payment_type_cd = v_paymenttype) 
    and 
			(date_sw is null 
	  		or case 
			  when date_sw = 'M' then 
			  	(date_trunc('month',payhead.payment_start_dt) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
			  when date_sw = 'Y' then
			    date_part('year', now() :: date):: integer =
date_part('year', payhead.payment_start_dt):: integer
				--  (tat.benefit_start_dt = date_trunc('year', CURRENT_DATE)) 
			  when date_sw = 'D' then 
				  to_date(cast(payhead.payment_start_dt as TEXT), 'YYYY-MM-DD') 
				  BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
		  			AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) 
  			end) 
group by payhead.payment_id,payhead.provider_id,paydet.payment_detail_id,paydet.case_id,
payhead.payment_dt,payhead.client_account_id,payhead.payment_type_cd,payhead.check_status_dt,
payhead.check_status_cd,payhead.payment_method_cd,payhead.gross_amount_no,
payhead.offset_amount_no,payhead.payee_nm,payhead.interface_to_cd,interface_to_nm,
payhead.adr_type_cd,payhead.payment_start_dt,payhead.payment_end_dt,payhead.adr_street_nm,
payhead.adr_city_nm,payhead.adr_state_cd,payhead.adr_zip5_no,payhead.adr_county_cd,paydet.client_id,
paydet.draft_service_id,paydet.draft_service_start_dt,paydet.draft_service_end_dt,
paydet.draft_units_no,paydet.final_service_id,service_nm,paydet.final_service_start_dt,paydet.final_service_end_dt,
paydet.final_units_no,paydet.draft_amount_no,paydet.final_amount_no,paydet.notes_tx,paydet.status_cd,
paydet.draft_rate_type_cd,paydet.final_rate_type_cd,paydet.draft_unit_rate_amt,paydet.final_unit_rate_amt,
paydet.draft_unit_type,paydet.final_unit_type,paydet.draft_fiscal_category_cd,paydet.final_fiscal_category_cd,draft_fiscal_category_nm,final_fiscal_category_nm,
cis_client_id,client_first_nm,client_last_nm,prov.mail_code_tx,prov.tax_id_no,prov.prov_tax_type_cd,
prov_first_nm,prov_last_nm,prov.provider_nm,prov.reason_changed,local_department,case_worker_nm,payment_status_nm,payment_type_nm,
paydet.reference_payment_detail_id,paydet.change_reason_cd,tfd.fiscal_category_desc,isrt.description,client.firstname,client.lastname

LIMIT v_pageSize OFFSET v_pageOffset
)as x ) ;
 END;

$function$
;
