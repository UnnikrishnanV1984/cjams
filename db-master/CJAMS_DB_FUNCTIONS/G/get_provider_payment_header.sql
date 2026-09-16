DROP FUNCTION IF EXISTS cjams.get_provider_payment_header(json);
CREATE OR REPLACE FUNCTION cjams.get_provider_payment_header(request json)
 RETURNS TABLE(totalcount bigint, provider_id integer, mail_code_tx character varying, tax_id_no text, prov_tax_type_cd character varying, provider_nm character varying, providertype character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Parshal Chitrakar - 09/11/2024 CIDM-9412 Provider Name Suffix is not updated in CW Application
------------------------------------------------------------------------------------------------
DECLARE	
 v_pageSize INT;
 v_pageNumber INT;
 v_pageNum INT; 
 v_pageOffset INT;
 v_payment_id INT;
 v_provider_id INT;
 v_client_id INT;
 v_DateFrom TIMESTAMP(3);                        
 v_DateTo TIMESTAMP(3);
  v_DOBDateFrom   TIMESTAMP(3);                
 v_DOBDateTo TIMESTAMP(3);
 v_adr_type_cd CHARACTER VARYING(50);
 v_adr_city_nm CHARACTER VARYING(50);
 v_adr_zip5_no INT;
 v_adr_county_cd CHARACTER VARYING(50);
 v_adr_work_phone_tx CHARACTER VARYING(10);
v_taxid int;
v_ayear character varying(30);
v_payment_type_cd CHARACTER varying; 
v_payment_status_cd CHARACTER varying;
v_county_cd CHARACTER varying;

v_payee_nm CHARACTER VARYING(50);
v_payee_firstnm CHARACTER VARYING(50);
v_payee_lastnm CHARACTER VARYING(50);
v_clientfirstnm character varying(30);
v_clientlastnm character varying(30);

BEGIN  
 
 v_pageNumber   := request ->> 'pagenumber' ;
 v_pageNum := v_pageNumber - 1;
 v_pageSize     := request ->> 'pagesize' ;
 v_pageOffset = v_pageNum  * v_pageSize; 

 v_payee_nm := request ->> 'providername';
v_payee_firstnm := request ->>'providerfirstnm';
v_payee_lastnm := request ->>'providerlastnm';
v_clientfirstnm := request ->> 'clientfirstnm';
v_clientlastnm := request ->> 'clientlastnm';

 v_payment_id 	 := request ->> 'paymentid';
 v_provider_id 	:= request ->> 'providerid';
 v_client_id := request ->> 'clientid';
 v_DateFrom 	 := request ->> 'daterangefrom';                       
 v_DateTo 		 := request ->> 'daterangeto';
 v_adr_type_cd := request ->> 'address';
 v_adr_city_nm := request ->> 'city';
 v_adr_zip5_no := request ->> 'zip';
 v_adr_county_cd := request ->> 'county';
 v_adr_work_phone_tx := request ->> 'phonenumber';
 
 v_taxid := request ->> 'taxid';
	 v_payment_type_cd := request ->> 'payment_type_cd';
	 v_payment_status_cd := request ->> 'payment_status_cd';
	 v_county_cd := request ->> 'county_cd';
  v_DOBDateFrom 	 := request ->> 'dobdaterangefrom';                       
 v_DOBDateTo 		 := request ->> 'dobdaterangeto';
 v_ayear := request ->> 'ayear';
raise notice 'v_county_cd % ',v_county_cd;
 RETURN QUERY 

SELECT 
count(1)  over(),
payhead.provider_id AS provider_id
,prov.mail_code_tx AS     mail_code_tx
--,prov.tax_id_no AS         tax_id_no
,LPAD(prov.tax_id_no::text, 9, '0') ::text as tax_id_no
,(select value_tx from tb_picklist_values where PICKLIST_type_id=216 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(prov.prov_tax_type_cd)) AS  prov_tax_type_cds,
/*
(CASE WHEN (prov.provider_nm is null OR prov.provider_nm='') THEN CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) ELSE prov.provider_nm END) AS provider_nms
*/
cjams.f_ename('2953', prov.provider_id::bigint) AS provider_nms

,(select value_tx from tb_picklist_values where PICKLIST_type_id=155 AND delete_sw='N'
AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(prov.provider_category_cd) ) AS  providertype
--as payment_type_nm
FROM tb_payment_header as payhead  
INNER JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id
LEFT JOIN person as client ON paydet.client_id = client.cjamspid
INNER JOIN tb_provider as prov ON payhead.provider_id = prov.provider_id 
INNER JOIN tb_payment_status paystat ON payhead.payment_id=paystat.payment_id and paystat.delete_sw='N'
left JOIN tb_service_purchase_authorization payauth on payauth.authorization_id = payhead.authorization_id and payauth.delete_sw='N'
left join tb_service_log tsl on payauth.service_log_id = tsl.service_log_id and tsl.delete_sw='N'
--left join tb_provider_addresses tpa on tpa.parent_key_id = prov.provider_id::character varying and tpa.delete_sw='N'
where
payhead.payment_type_cd not in ('5989','4') and  payhead.manual_sw != 'Y'
and
(v_payment_type_cd is null or payhead.payment_type_cd = v_payment_type_cd) and
(v_payment_status_cd is null or paystat.payment_status_cd = v_payment_status_cd) and
(v_payment_id is null or payhead.payment_id = v_payment_id)

and (case when (trim(v_payee_nm) !=''  or v_payee_nm is not null)  then (COALESCE(lower(prov.provider_nm) ,'') LIKE '%'||COALESCE(lower(v_payee_nm) ,'')||'%' 
or (COALESCE(lower(concat (prov.provider_first_nm,' ',prov.provider_last_nm)) ,'') LIKE '%'||COALESCE(lower(v_payee_nm) ,'')||'%')) else true end 
or case when (trim(v_payee_nm) !=''  or v_payee_nm is not null)  then soundex(lower(trim(prov.provider_nm))) = soundex(lower(trim(v_payee_nm))) 
or soundex(lower(trim(concat (prov.provider_first_nm,' ',prov.provider_last_nm)))) = soundex(lower(trim(v_payee_nm))) else true end)
and (case when (trim(v_payee_firstnm) !='' or v_payee_firstnm is not null)then  (COALESCE(lower(prov.provider_first_nm) ,'') LIKE '%'||COALESCE(lower(v_payee_firstnm) ,'')||'%') else true end
or case when (trim(v_payee_firstnm) !='' or v_payee_firstnm is not null)then soundex(lower(trim(prov.provider_first_nm))) = soundex(lower(trim(v_payee_firstnm))) else true end)
and (case when (trim(v_payee_lastnm) !='' or v_payee_lastnm is not null ) then  (COALESCE(lower(prov.provider_last_nm) ,'') LIKE '%'||COALESCE(lower(v_payee_lastnm) ,'')||'%') else true end 
or case when (trim(v_payee_lastnm) !='' or v_payee_lastnm is not null ) then  soundex(lower(trim(prov.provider_last_nm))) = soundex(lower(trim(v_payee_lastnm))) else true  end)

and (case when  (trim(v_clientfirstnm) !=''  or v_clientfirstnm is not null) then (COALESCE(lower(client.firstname) ,'') LIKE '%'|| COALESCE(lower(v_clientfirstnm) ,'')||'%') else true end
or case when  (trim(v_clientfirstnm) !=''  or v_clientfirstnm is not null) then soundex(lower(trim(client.firstname))) = soundex(lower(trim(v_clientfirstnm))) else true end)
and (case when  (trim(v_clientlastnm) !=''  or v_clientlastnm is not null) then (COALESCE(lower(client.lastname) ,'') LIKE '%'||COALESCE(lower(v_clientlastnm) ,'')||'%') else true end
or case when  (trim(v_clientlastnm) !=''  or v_clientlastnm is not null) then soundex(lower(trim(client.LastName)))  = soundex(lower(trim(v_clientlastnm))) else true end)
 
 
AND (v_provider_id is null or payhead.provider_id = v_provider_id)
AND (v_client_id is null or paydet.client_id = v_client_id)
AND (v_adr_type_cd is null or payhead.adr_type_cd = v_adr_type_cd)
AND (v_adr_city_nm is null or payhead.adr_city_nm = v_adr_city_nm)
AND (v_adr_zip5_no is null or payhead.adr_zip5_no = v_adr_zip5_no)
--AND (v_adr_county_cd is null or payhead.adr_county_cd = v_adr_county_cd)
AND (v_adr_work_phone_tx is null or payhead.adr_work_phone_tx = v_adr_work_phone_tx)

     
AND (v_taxid is null or prov.tax_id_no :: character varying LIKE '%'|| v_taxid ||'%')
and (v_DateFrom IS null or  to_char(payhead.payment_start_dt, 'YYYY-MM-DD') ::date >= to_char(DATE(v_DateFrom ::varchar), 'YYYY-MM-DD')  :: date) 
	and	
	 (v_DateTo IS null or  to_char(payhead.payment_start_dt, 'YYYY-MM-DD') ::date <= to_char(DATE(v_DateTo ::varchar), 'YYYY-MM-DD')  :: date)
/*
--AND case WHEN v_DateFrom IS NOT NULL THEN to_date(cast(payhead.create_ts as TEXT), 'YYYY-MM-DD') 
--BETWEEN to_date(cast(v_DateFrom as TEXT), 'YYYY-MM-DD') 
--AND to_date(cast(v_DateTo as TEXT), 'YYYY-MM-DD') ELSE TRUE end
--AND case WHEN v_DOBDateFrom IS NOT NULL THEN to_date(cast(client.dob ::date as TEXT), 'YYYY-MM-DD') 
--BETWEEN to_date(cast(v_DOBDateFrom as TEXT), 'YYYY-MM-DD') 
--AND to_date(cast(v_DOBDateTo as TEXT), 'YYYY-MM-DD') ELSE TRUE end
	and
	  (case WHEN (v_DOBDateFrom IS NOT null and v_DOBDateTo is not null)  THEN to_char(client.dob, 'YYYY-MM-DD') ::date
	 -- BETWEEN to_date(cast(v_DOBDateFrom as TEXT), 'YYYY-MM-DD')
	 BETWEEN to_char(DATE(v_DOBDateFrom ::varchar), 'YYYY-MM-DD')  :: date 
	AND to_char(DATE(v_DOBDateTo ::varchar), 'YYYY-MM-DD')  ::date
		WHEN (v_DOBDateFrom IS NOT null)  THEN to_char(client.dob, 'YYYY-MM-DD') ::date >= to_char(DATE(v_DOBDateFrom ::varchar), 'YYYY-MM-DD')  :: date 
	WHEN (v_DOBDateTo IS NOT null)  THEN to_char(client.dob , 'YYYY-MM-DD') ::date <= to_char(DATE(v_DOBDateTo ::varchar), 'YYYY-MM-DD')  :: date ELSE
	TRUE end) 
	and
	  (case WHEN (v_DateFrom IS NOT null and v_DOBDateTo is not null)  THEN to_char(payhead.create_ts, 'YYYY-MM-DD') ::date
	 -- BETWEEN to_date(cast(v_DOBDateFrom as TEXT), 'YYYY-MM-DD')
	 BETWEEN to_char(DATE(v_DOBDateFrom ::varchar), 'YYYY-MM-DD')  :: date 
	AND to_char(DATE(v_DateTo ::varchar), 'YYYY-MM-DD')  ::date
		WHEN (v_DateFrom IS NOT null)  THEN to_char(payhead.create_ts, 'YYYY-MM-DD') ::date >= to_char(DATE(v_DateFrom ::varchar), 'YYYY-MM-DD')  :: date 
	WHEN (v_DateTo IS NOT null)  THEN to_char(payhead.create_ts , 'YYYY-MM-DD') ::date <= to_char(DATE(v_DateTo ::varchar), 'YYYY-MM-DD')  :: date ELSE
	TRUE end) 
AND case WHEN (v_ayear IS NOT null and payhead.payment_dt is not NULL) then payhead.payment_dt   > now() - interval '1 year'  ELSE TRUE end 
*/
group by payhead.provider_id,
prov.mail_code_tx 
,prov.tax_id_no
, prov_tax_type_cds
,provider_nms,
providertype ,
prov.provider_nm,prov.provider_first_nm ,prov.provider_last_nm

order by (case when (v_payee_nm is not null or trim(v_payee_nm) !='')   then 
				( case when prov.provider_nm is not null 	then levenshtein( prov.provider_nm,(lower( trim( v_payee_nm) )) ,1,0,4)
			else levenshtein((concat_ws(' ',prov.provider_first_nm,prov.provider_last_nm) ),(lower( trim( v_payee_nm) )) ,1,0,4) end )end )
LIMIT v_pageSize OFFSET v_pageOffset;
 END;
$function$
;