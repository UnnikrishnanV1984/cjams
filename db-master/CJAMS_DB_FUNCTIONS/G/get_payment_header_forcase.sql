DROP FUNCTION IF EXISTS get_payment_header_forcase(json);

CREATE OR REPLACE FUNCTION cjams.get_payment_header_forcase(request json)
 RETURNS TABLE(totalcount bigint, payment_id integer, gross_amount_no numeric, 
 payment_start_dt date, payment_end_dt date, provider_id int,payment_type_cd character varying, payment_type_nm character varying,
 final_fiscal_category_cd character varying,
 final_fiscal_category_nm character varying,payment_status_nm character varying, provider_nm character varying)
 LANGUAGE plpgsql
AS $function$

---------------------------------------------------------------------------------------
-- Revision(s)
-- 11/13/2024 Sai Teja Chintha - To fix the provider name not display issue (CIDM-9794).
---------------------------------------------------------------------------------------

DECLARE	
 v_pageSize INT;
 v_pageNumber INT;
 v_pageNum INT; 
 v_pageOffset INT;

 v_client_id INT;
 
BEGIN  
 v_client_id := request ->> 'clientid';

RETURN QUERY 
select  count(1) over(), 
payhead.payment_id
,paydet.final_amount_no
--,SUM(paydet.final_amount_no)
 --,CASE WHEN (payhead.offset_amount_no != null) THEN payhead.offset_amount_no ELSE 0.00 END AS offset_amount_no
,paydet.final_service_start_dt
,paydet.final_service_end_dt,
payhead.provider_id,
payhead.payment_type_cd,
case when (payhead.payment_type_cd='3294' and payhead.manual_sw='Y') then 'Manual Adjustments' 
else (select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=payhead.payment_type_cd
AND PICKLIST_TYPE_ID='2') end as payment_type_nm,
paydet.final_fiscal_category_cd::character varying
,(select fiscal_category_desc from TB_FISCAL_CATEGORY_MASTER where delete_sw='N' AND fiscal_category_cd=paydet.final_fiscal_category_cd limit 1) as final_fiscal_category_nm
,(select distinct PV.value_tx from tb_payment_status PS
INNER JOIN tb_picklist_values PV on PS.payment_status_cd=TRIM(PV.PICKLIST_VALUE_CD) 
AND PV.PICKLIST_TYPE_ID='133'
AND PS.payment_id=payhead.payment_id) as payment_status_nm,
/*(case when prov.provider_nm = '' or prov.provider_nm is null then concat_ws(' ',prov.provider_first_nm,prov.provider_middle_nm,prov.provider_last_nm) else prov.provider_nm end) as provider_nm*/
cjams.f_ename('2953', prov.provider_id :: bigint) as provider_nm
from tb_payment_header payhead 
INNER join tb_payment_detail paydet on paydet.payment_id=payhead.payment_id 
inner join person client on client.cjamspid=paydet.client_id 
INNER JOIN tb_provider as prov ON payhead.provider_id = prov.provider_id 
INNER JOIN tb_payment_status paystat ON payhead.payment_id=paystat.payment_id
WHERE payhead.delete_sw='N' and payhead.payment_type_cd not in  ('5989','4')  and  payhead.manual_sw != 'Y'
AND (v_client_id is null or paydet.client_id = v_client_id)
and paystat.payment_status_cd in ('1636', '1634')
group by payhead.payment_id,payhead.gross_amount_no,payhead.payment_start_dt,payhead.payment_end_dt,
payhead.payment_type_cd,payhead.manual_sw,paydet.final_amount_no,paydet.final_service_start_dt
,paydet.final_service_end_dt,
payhead.provider_id,paydet.final_fiscal_category_cd,prov.provider_id
order by payhead.payment_id desc;
--LIMIT v_pageSize OFFSET v_pageOffset;

 END;
$function$
;
