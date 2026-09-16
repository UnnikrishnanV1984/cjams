DROP FUNCTION IF EXISTS cjams.get_payment_header_details(json);
CREATE OR REPLACE FUNCTION cjams.get_payment_header_details(request json)
 RETURNS TABLE(totalcount bigint, payment_id integer, payment_detail_id bigint, provider_id integer, payment_dt date, client_account_id integer, payment_type_cd character varying, check_status_cd character varying, payment_method_cd character varying, gross_amount_no numeric, offset_amount_no numeric, payee_nm character varying, interface_to_cd character varying, interface_to_nm character varying, adr_type_cd character varying, payment_start_dt date, payment_end_dt date, adr_street_nm character varying, adr_city_nm character varying, adr_state_cd character varying, adr_zip5_no numeric, adr_county_cd character varying, adr_street_tx character varying, adr_unit_no_tx character varying, adr_unit_type_cd character varying, adr_street_suffix_cd character varying, adr_pre_dir_cd character varying, client_id bigint, draft_service_id integer, draft_service_nm character varying, draft_service_start_dt date, draft_service_end_dt date, draft_units_no integer, final_service_id integer, final_service_nm character varying, final_service_start_dt date, final_service_end_dt date, final_units_no integer, draft_amount_no numeric, final_amount_no numeric, notes_tx character varying, status_cd character varying, draft_rate_type_cd character varying, final_rate_type_cd character varying, draft_unit_rate_amt numeric, final_unit_rate_amt numeric, draft_unit_type character varying, final_unit_type character varying, draft_fiscal_category_cd character, final_fiscal_category_cd character, draft_fiscal_category_nm character varying, final_fiscal_category_nm character varying, cis_client_id bigint, client_first_nm character varying, client_last_nm character varying, client_middle_nm character varying, client_suffix character varying, mail_code_tx character varying, tax_id_no text, prov_tax_type_cd character varying, prov_first_nm character varying, prov_last_nm character varying, provider_nm character varying, reason_changed character varying, local_department character varying, case_worker_nm character varying, payment_status_nm character varying, payment_type_nm character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 05/28/2021 Vineet Tirodkar - Modifications to add the missing delete_sw in where clause of Payment tables (CDM-13300)
-- Parshal Chitrakar - 09/12/2024 CIDM-9412 Provider Name Suffix is not updated in CW Application
------------------------------------------------------------------------------------------------------------	
DECLARE	
	v_pageSize INT;
	v_pageNumber INT;
	v_pageNum INT; 
	v_pageOffset INT;

	v_payment_id INT;
	v_payee_nm CHARACTER VARYING(50);
	v_provider_id INT;
	v_client_id INT;
	v_DateFrom TIMESTAMP(3);                        
	v_DateTo TIMESTAMP(3);
	v_adr_type_cd CHARACTER VARYING(50);
	v_adr_city_nm CHARACTER VARYING(50);
	v_adr_zip5_no INT;
	v_adr_county_cd CHARACTER VARYING(50);
	v_adr_work_phone_tx CHARACTER VARYING(10);
	v_DOBDateFrom   TIMESTAMP(3);                
	v_DOBDateTo TIMESTAMP(3);
	v_ayear character varying(30);
	v_sortcolumn character varying(30);
	v_sortorder character varying(30);

	v_clientfirstnm CHARACTER VARYING(100);
	v_clientlastnm CHARACTER VARYING(100);
	v_clientmiddlenm CHARACTER VARYING(100);
	soundslikeindex int;
	
BEGIN  
	v_clientfirstnm := lower(trim( request ->> 'clientfirstnm'));
	v_clientlastnm := lower(trim( request->> 'clientlastnm'));
	v_clientmiddlenm := lower(trim(request->> 'clientmiddlenm'));

	v_pageNumber   := request ->> 'pagenumber' ;
	v_pageNum := v_pageNumber - 1;
	v_pageSize     := request ->> 'pagesize' ;
	v_pageOffset = v_pageNum  * v_pageSize; 

	v_payee_nm := request ->> 'providername';
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
	v_sortcolumn := request ->> 'sortcolumn';
	v_sortorder  := request ->> 'sortorder';
	v_DOBDateFrom 	 := request ->> 'dobdaterangefrom';                       
	v_DOBDateTo 		 := request ->> 'dobdaterangeto';
	v_ayear := request ->> 'ayear';

	drop table if exists temp_payment_header_ma;
	drop table if exists temp_payment_detail_ma;
	drop table if exists temp_payment_status_ma;
	
	CREATE TEMP TABLE temp_payment_header_ma AS
	SELECT ph.payment_id, ph.provider_id, ph.authorization_id, ph.payment_dt, ph.payment_type_cd, 
	ph.check_status_cd, ph.check_status_dt, ph.payment_method_cd, ph.gross_amount_no, ph.offset_amount_no, ph.manual_sw,
	ph.approval_status_cd, ph.update_method_sw, ph.store_receipt_id, ph.create_user_id, ph.update_user_id, ph.delete_sw,
	ph.notes_tx, ph.payee_nm, ph.interface_to_cd, ph.adr_type_cd, ph.adr_format_cd,ph.adr_street_no, ph.adr_box_no, ph.adr_pre_dir_cd,
	ph.adr_street_nm, ph.adr_street_suffix_cd, ph.adr_post_dir_cd, ph.adr_unit_type_cd, ph.adr_unit_no_tx, ph.adr_city_nm,
	ph.adr_county_cd, ph.adr_state_cd, ph.adr_zip5_no, ph.adr_zip4_no, ph.adr_direction_tx, ph.adr_foreign_tx, ph.adr_home_phone_tx,
	ph.adr_work_phone_tx, ph.adr_work_xtn_tx, ph.adr_pager_tx, ph.adr_email_tx, ph.adr_fax_tx, ph.adr_cell_phone_tx, ph.adr_url_tx,
	ph.adr_other_contact_tx, ph.payment_start_dt, ph.payment_end_dt, ph.adr_foreign_state_tx, 
	ph.adr_country_tx, ph.adr_postal_code_tx, ph.adr_default_sw, ph.adr_start_dt, ph.adr_end_dt, ph.client_account_id, 
	ph.adr_street_tx, ph.create_ts, ph.update_ts
	FROM tb_payment_header ph 
	where ph.payment_id =  v_payment_id
		and ph.delete_sw = 'N' ;

	create temp table temp_payment_detail_ma as 
	select pd.payment_detail_id, pd.payment_id, pd.county_cd, pd.payment_amount_no, pd.client_id, pd.draft_service_id, pd.draft_service_start_dt,
	pd.draft_service_end_dt, pd.draft_units_no, pd.final_service_id, pd.final_service_start_dt, pd.final_service_end_dt, pd.final_units_no,
	pd.draft_amount_no, pd.final_amount_no, pd.notes_tx, pd.change_reason_cd, pd.status_cd, pd.tca_stopped_cd, pd.type_1099_cd, pd.create_user_id,
	pd.update_user_id, pd.delete_sw, pd.reference_payment_detail_id, pd.report_1099_sw, pd.linked_pymnt_hdr_id, pd.draft_rate_type_cd,
	pd.final_rate_type_cd, pd.placement_id, pd.subsidy_agreement_id, pd.draft_unit_rate_amt, pd.final_unit_rate_amt, pd.draft_unit_type,
	pd.final_unit_type, pd.draft_fiscal_category_cd,
	pd.final_fiscal_category_cd, pd.case_id, pd.agency_object_cd, pd.data_valid_sw, pd.client_merge_id, pd.create_ts, pd.update_ts
	FROM tb_payment_detail pd 
		join temp_payment_header_ma tph on tph.payment_id = pd.payment_id
	where pd.delete_sw = 'N';
   
   	create temp table temp_payment_status_ma as
   	SELECT tps.payment_status_id, tps.payment_status_cd, tps.payment_status_dt, tps.payment_id, tps.active_sw, tps.create_user_id, 
   	tps.update_user_id, tps.delete_sw, tps.approval_status_cd, tps.create_ts, tps.update_ts
	FROM tb_payment_status tps
		join temp_payment_header_ma tph on tph.payment_id = tps.payment_id
	where tps.delete_sw = 'N' ;

RETURN QUERY 
	SELECT 
		count(1)  over(),
		payhead.payment_id AS payment_id
		,paydet.payment_detail_id:: bigint AS payment_detailid
		,payhead.provider_id AS provider_id
		,payhead.payment_dt AS payment_dt
		,payhead.client_account_id AS client_account_id
		,payhead.payment_type_cd AS payment_type_cd
		,payhead.check_status_cd AS check_status_cd
		,payhead.payment_method_cd AS payment_method_cd
		,payhead.gross_amount_no AS gross_amount_no
		,payhead.offset_amount_no AS offset_amount_no
		,payhead.payee_nm AS payee_nm
		,payhead.interface_to_cd AS interface_to_cd,
		(select value_tx from tb_picklist_values where PICKLIST_type_id=1285 AND delete_sw='N'
		AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(payhead.interface_to_cd)) as interface_to_nm
		,payhead.adr_type_cd AS adr_type_cd
		,payhead.payment_start_dt AS payment_start_dt
		,payhead.payment_end_dt AS payment_end_dt
		,tpa.adr_street_nm AS adr_street_nm             
		,tpa.adr_city_nm   AS adr_city_nm         
		,tpa.adr_state_cd  AS adr_state_cd       
		,tpa.adr_zip5_no   AS adr_zip5_no
		,tpa.adr_county_cd AS adr_county_cd
		,tpa.adr_street_tx as adr_street_tx,
		tpa.adr_unit_no_tx,
		(select value_tx from tb_picklist_values where trim(picklist_value_cd)= trim(tpa.adr_unit_type_cd) and picklist_type_id=250) as adr_unit_type_cd,
		(select value_tx from tb_picklist_values where trim(picklist_value_cd)= trim(tpa.adr_street_suffix_cd) and picklist_type_id=212) as adr_street_suffix_cd,
		(select value_tx from tb_picklist_values where trim(picklist_value_cd)= trim(tpa.adr_pre_dir_cd) and picklist_type_id=69) as adr_pre_dir_cd

		--,payhead.adr_zip5_no AS adr_zip5_no
		,paydet.client_id AS client_id
		,paydet.draft_service_id AS draft_service_id
		,(select service_nm from tb_services where STRUCTURE_SERVICE_CD = 'P' and delete_sw='N' and service_id =paydet.draft_service_id) as draft_service_nm
		,paydet.draft_service_start_dt AS draft_service_start_dt
		,paydet.draft_service_end_dt AS draft_service_end_dt
		,paydet.draft_units_no AS draft_units_no
		,paydet.final_service_id AS final_service_id
		,(select service_nm from tb_services where STRUCTURE_SERVICE_CD = 'P' and delete_sw='N' and service_id =paydet.final_service_id) as final_service_nm
		--,case when payhead.payment_type_cd='3294' then (select pd.final_service_start_dt from tb_payment_detail pd where pd.payment_id =
		--(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1) else 
		--,paydet.final_service_start_dt AS final_service_start_dt,
		/*,CASE WHEN (trim(payhead.payment_type_cd) = '3294' and paydet.reference_payment_detail_id is not null) 
		THEN (select tbpaydet.final_service_end_dt from tb_payment_detail tbpaydet where tbpaydet.payment_detail_id=paydet.reference_payment_detail_id limit 1)
		ELSE paydet.final_service_start_dt END AS final_service_start_dt*/
		,paydet.final_service_start_dt AS final_service_start_dt
		--case when (payhead.payment_type_cd='3294' and paydet.reference_payment_detail_id is not null) then (select pd.final_service_start_dt from tb_payment_detail pd where pd.payment_detail_id =
		--(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1) else 
		--paydet.final_service_end_dt end  

		--,(select ((final_service_start_dt - interval '1 day') +  (interval '1 day' * coalesce((tpde.final_amount_no/tpde.final_unit_rate_amt),0)))::date
		/*,(select (((CASE WHEN (trim(payhead.payment_type_cd) = '3294' and paydet.reference_payment_detail_id is not null) 
		THEN (select tbpaydet.final_service_end_dt from tb_payment_detail tbpaydet where tbpaydet.payment_detail_id=paydet.reference_payment_detail_id limit 1)
		ELSE paydet.final_service_start_dt END) - interval '1 day') +  (interval '1 day' * coalesce((tpde.final_amount_no/tpde.final_unit_rate_amt),0)))::date
		--- interval '1 day' 
		from tb_payment_detail tpde
		where 
		tpde.payment_detail_id = paydet.payment_detail_id )

		AS final_service_end_dt,*/
		,paydet.final_service_end_dt AS final_service_end_dt,
		--paydet.final_service_end_dt AS final_service_end_dt
		--case when (payhead.payment_type_cd='3294' and paydet.reference_payment_detail_id is not null) then (select paydet.final_units_no - pd.final_units_no  as final_units_no  from tb_payment_detail pd where pd.payment_detail_id =
		--(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1)
		--else paydet.final_units_no end
		--(select (tpde.final_amount_no/tpde.final_unit_rate_amt) ::integer from tb_payment_detail tpde where 
		--tpde.payment_detail_id = paydet.payment_detail_id)
		paydet.final_units_no AS final_units_no
		,paydet.draft_amount_no AS draft_amount_no
		,paydet.final_amount_no AS final_amount_no
		,paydet.notes_tx AS notes_tx
		,paydet.status_cd AS status_cd
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=82 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.draft_rate_type_cd)) AS draft_rate_type_cd
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=82 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.final_rate_type_cd)) AS final_rate_type_cd
		,paydet.draft_unit_rate_amt AS draft_unit_rate_amt
		,paydet.final_unit_rate_amt AS final_unit_rate_amt
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=1316 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.draft_unit_type)) AS draft_unit_type
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=1316 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.final_unit_type)) AS final_unit_type
		,paydet.draft_fiscal_category_cd AS draft_fiscal_category_cd
		,paydet.final_fiscal_category_cd  AS final_fiscal_category_cd
		,(select fiscal_category_desc from TB_FISCAL_CATEGORY_MASTER where delete_sw='N' AND fiscal_category_cd=paydet.draft_fiscal_category_cd limit 1) as draft_fiscal_category_nm
		,(select fiscal_category_desc from TB_FISCAL_CATEGORY_MASTER where delete_sw='N' AND fiscal_category_cd=paydet.final_fiscal_category_cd limit 1) as final_fiscal_category_nm
		,client.cjamspid AS    cis_client_id
		,client.firstname AS        client_first_nm
		,client.lastname     AS    client_last_nm  
		,client.middlename as client_middle_nm
		,client.suffix as client_suffix
		,prov.mail_code_tx AS     mail_code_tx
		,LPAD(prov.tax_id_no::text, 9, '0') ::text as tax_id_no 
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=216 AND delete_sw='N' AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(prov.prov_tax_type_cd)) AS  prov_tax_type_cd
		,prov.provider_first_nm AS         prov_first_nm
		,prov.provider_last_nm     AS      prov_last_nm 
		--,CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) As provider_nm    
		/*,CASE WHEN (prov.provider_nm = null OR prov.provider_nm='') 
		THEN CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) ELSE prov.provider_nm END AS provider_nm
		*/
		,cjams.f_ename('2953', prov.provider_id::bigint) AS provider_nm
		,(select value_tx from tb_picklist_values where PICKLIST_type_id=277 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.change_reason_cd)) as  reason_changed,
		(select c.countyname from county c where trim(c.statecountycode)=trim(paydet.county_cd) limit 1) as  local_department
		/*,(select  up.fullname 
		from servicecase ISR
		left JOIN (SELECT RANK() OVER(PARTITION BY objectid ORDER BY insertedon DESC) rno,toworkeridno,objectid
						FROM caseassignment) ca ON ca.objectid = ISR.servicecaseid AND ISR.activeflag = 1 AND rno = 1
		inner join userprofile up on up.securityusersid=ca.toworkeridno
		left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
		left join userprofileaddress upa on up.securityusersid = upa.securityusersid
		where   isr.activeflag=1  
		and up.activeflag=1 and  ISR.servicecasenumber=paydet.case_id:: character varying
		order by Isr.insertedon desc limit  1) as case_worker_nm*/
		,(select up.fullname FROM caseassignment ca 
		inner join userprofile up on up.securityusersid = ca.toworkeridno
		inner join servicecase sc on sc.servicecasenumber = paydet.case_id:: character varying
		where ca.objectid = sc.servicecaseid
		AND LOWER(ca.responsibilitytypekey) = 'family' AND ca.enddate IS NULL AND ca.activeflag= 1 limit 1) :: character varying  as case_worker_nm 
		,(select distinct PV.value_tx from tb_payment_status PS 
		INNER JOIN tb_picklist_values PV on PS.payment_status_cd=TRIM(PV.PICKLIST_VALUE_CD) 
		AND PV.PICKLIST_TYPE_ID='133'
		AND PS.payment_id=payhead.payment_id) as payment_status_nm
		,case when (payhead.payment_type_cd='3294' and payhead.manual_sw='Y') then 'Manual Adjustments' else (select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=payhead.payment_type_cd
		AND PICKLIST_TYPE_ID='2') end as payment_type_nm
	FROM temp_payment_header_ma as payhead  
	INNER JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id
		and paydet.delete_sw = 'N'
	--INNER JOIN tb_payment_detail_temp as paydettemp ON payhead.payment_id = paydettemp.payment_id
	LEFT JOIN person as client ON paydet.client_id = client.cjamspid
	INNER JOIN tb_provider as prov ON payhead.provider_id = prov.provider_id
	INNER JOIN temp_payment_status_ma paystat ON payhead.payment_id=paystat.payment_id
	left join tb_provider_addresses tpa on tpa.parent_key_id = prov.provider_id::character varying 
		and tpa.adr_type_cd = '3356'
		and tpa.adr_default_sw = 'Y'
		and tpa.delete_sw='N'
	WHERE (v_payment_id is null or payhead.payment_id = v_payment_id)
	--AND (v_payee_nm is null or payhead.payee_nm = v_payee_nm)

	and (case when  (trim(v_clientfirstnm) !=''  or v_clientfirstnm is not null) then (COALESCE(lower(client.firstname) ,'') LIKE '%'|| COALESCE(v_clientfirstnm ,'')||'%') else true end
	or case when  (trim(v_clientfirstnm) !=''  or v_clientfirstnm is not null) then soundex(lower(trim(client.firstname))) = soundex(v_clientfirstnm) else true end)
	and (case when  (trim(v_clientlastnm) !=''  or v_clientlastnm is not null) then (COALESCE(lower(client.lastname) ,'') LIKE '%'||COALESCE(v_clientlastnm ,'')||'%') else true end
	or case when  (trim(v_clientlastnm) !=''  or v_clientlastnm is not null) then soundex(lower(trim(client.LastName)))  = soundex(v_clientlastnm) else true end)
	 /*
	AND (v_provider_id is null or payhead.provider_id = v_provider_id)
	AND (v_client_id is null or paydet.client_id = v_client_id)
	AND (v_adr_type_cd is null or payhead.adr_type_cd = v_adr_type_cd)
	AND (v_adr_city_nm is null or payhead.adr_city_nm = v_adr_city_nm)
	AND (v_adr_zip5_no is null or payhead.adr_zip5_no = v_adr_zip5_no)
	AND (v_adr_county_cd is null or prov.county_cd = v_adr_county_cd)
	AND (v_adr_work_phone_tx is null or payhead.adr_work_phone_tx = v_adr_work_phone_tx)
	and
	 (v_DateFrom IS null or  to_char(payhead.payment_start_dt, 'YYYY-MM-DD') ::date >= to_char(DATE(v_DateFrom ::varchar), 'YYYY-MM-DD')  :: date) 
		and	
		 (v_DateTo IS null or  to_char(payhead.payment_start_dt, 'YYYY-MM-DD') ::date <= to_char(DATE(v_DateTo ::varchar), 'YYYY-MM-DD')  :: date)
	case	when (v_DateFrom is not null and v_DateTo is not null)  then to_date(cast(payhead.create_ts as text), 'YYYY-MM-DD')
			between to_date(cast(v_DateFrom as text), 'YYYY-MM-DD') and to_date(cast(v_DateTo as text), 'YYYY-MM-DD')
			else true	end	and	case
			when (v_DateFrom is not null and v_DateTo is null)  then to_date(cast(payhead.create_ts as text), 'YYYY-MM-DD')
			between to_date(cast(v_DateFrom as text), 'YYYY-MM-DD') and to_date(cast(now() as text), 'YYYY-MM-DD')
			else true	end	and
	case		when (v_DOBDateFrom is not null and v_DOBDateTo is not null) then to_date(cast(client.dob ::date as text), 'YYYY-MM-DD') between to_date(cast(v_DOBDateFrom as text), 'YYYY-MM-DD') and to_date(cast(v_DOBDateTo as text), 'YYYY-MM-DD')
			else true
		end
		and
		case
			when (v_DOBDateFrom is not null and v_DOBDateTo is null) then to_date(cast(client.dob ::date as text), 'YYYY-MM-DD') between to_date(cast(v_DOBDateFrom as text), 'YYYY-MM-DD') and now():: date
			else true
		end
	*/
	--AND case WHEN v_DateFrom IS NOT NULL THEN to_date(cast(payhead.create_ts as TEXT), 'YYYY-MM-DD') 
	--BETWEEN to_date(cast(v_DateFrom as TEXT), 'YYYY-MM-DD') 
	--AND to_date(cast(v_DateTo as TEXT), 'YYYY-MM-DD') ELSE TRUE end
	--AND case WHEN v_DOBDateFrom IS NOT NULL THEN to_date(cast(client.dob ::date as TEXT), 'YYYY-MM-DD') 
	--BETWEEN to_date(cast(v_DOBDateFrom as TEXT), 'YYYY-MM-DD') 
	--AND to_date(cast(v_DOBDateTo as TEXT), 'YYYY-MM-DD') ELSE TRUE end
	--AND case WHEN v_ayear IS NOT NULL then payhead.payment_dt   > now() - interval '1 year'  ELSE TRUE end 
	group by payhead.payment_id,payhead.provider_id,paydet.payment_detail_id,
		payhead.payment_dt,payhead.client_account_id,payhead.payment_type_cd,
		payhead.check_status_cd,payhead.payment_method_cd,payhead.gross_amount_no,
		payhead.offset_amount_no,payhead.payee_nm,payhead.interface_to_cd,interface_to_nm,
		payhead.adr_type_cd,payhead.payment_start_dt,payhead.payment_end_dt,tpa.adr_street_nm,
		tpa.adr_city_nm,tpa.adr_state_cd,tpa.adr_zip5_no,tpa.adr_county_cd, tpa.adr_street_tx, tpa.adr_pre_dir_cd,tpa.adr_street_suffix_cd, tpa.adr_unit_type_cd,tpa.adr_unit_no_tx,paydet.client_id,
		paydet.draft_service_id,draft_service_nm,paydet.draft_service_start_dt,paydet.draft_service_end_dt,
		paydet.draft_units_no,paydet.final_service_id,final_service_nm,paydet.final_service_start_dt,paydet.final_service_end_dt,
		paydet.final_units_no,paydet.draft_amount_no,paydet.final_amount_no,paydet.notes_tx,paydet.status_cd,
		paydet.draft_rate_type_cd,paydet.final_rate_type_cd,paydet.draft_unit_rate_amt,paydet.final_unit_rate_amt,
		paydet.draft_unit_type,paydet.final_unit_type,paydet.draft_fiscal_category_cd,paydet.final_fiscal_category_cd,draft_fiscal_category_nm,final_fiscal_category_nm,
		cis_client_id,client_first_nm,client_last_nm,client_middle_nm,client_suffix,prov.mail_code_tx,prov.tax_id_no,prov.prov_tax_type_cd,
		prov_first_nm,prov_last_nm,prov.provider_nm,prov.provider_id,prov.reason_changed,local_department,case_worker_nm,payment_status_nm,payment_type_nm,
		paydet.reference_payment_detail_id,paydet.change_reason_cd,paydet.case_id

	order by (
				case v_sortorder
					when 'asc'
					then 
						case v_sortcolumn 
							when 'client_id' then  cast(client.cjamspid as character varying)
							when 'client_first_nm' then cast(client.firstname as character varying)
							when 'case_worker_nm' then cast ((select distinct up.fullname 
	from servicecase ISR
		inner join userprofile up on up.securityusersid=ISR.insertedby
		left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
		left join userprofileaddress upa on up.securityusersid = upa.securityusersid
	where   isr.activeflag=1  
	and up.activeflag=1 and  ISR.servicecasenumber=paydet.case_id:: character varying
	) as character varying)
							when 'local_department' then cast((select value_tx from tb_picklist_values where PICKLIST_type_id=104 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.county_cd)) as character varying)
							when 'draft_amount_no' then cast(paydet.draft_amount_no as character varying)
							when 'final_amount_no' then cast(paydet.final_amount_no as character varying)
						else 
							cast(client.cjamspid as character varying)
						end 
				end) asc nulls last,
			 (
				case v_sortorder
					when 'desc'
					then 
						case v_sortcolumn 
							when 'client_id' then  cast(client.cjamspid as character varying)
							when 'client_first_nm' then cast(client.firstname as character varying)
							when 'case_worker_nm' then cast ((select distinct up.fullname 
	from servicecase ISR
		inner join userprofile up on up.securityusersid=ISR.insertedby
		left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
		left join userprofileaddress upa on up.securityusersid = upa.securityusersid
	where   isr.activeflag=1  
	and up.activeflag=1 and  ISR.servicecasenumber=paydet.case_id:: character varying
	) as character varying)
							when 'local_department' then cast((select value_tx from tb_picklist_values where PICKLIST_type_id=104 AND delete_sw='N' AND active_sw='Y' AND TRIM(PICKLIST_VALUE_CD)=TRIM(paydet.county_cd)) as character varying)
							when 'draft_amount_no' then cast(paydet.draft_amount_no as character varying)
							when 'final_amount_no' then cast(paydet.final_amount_no as character varying)
						else 
							cast(client.cjamspid as character varying)
						end 
				end) desc nulls last,
					   levenshtein((lower(CAST(INITCAP(TRIM(client.firstname) || ' '||TRIM(client.lastname) )as character varying))),(lower( trim( v_clientfirstnm)   || ' '|| trim(v_clientlastnm))),1,0,4) 
	LIMIT v_pageSize OFFSET v_pageOffset;

	drop table if exists temp_payment_header_ma;
	drop table if exists temp_payment_detail_ma;
	drop table if exists temp_payment_status_ma;
END;

$function$
;
