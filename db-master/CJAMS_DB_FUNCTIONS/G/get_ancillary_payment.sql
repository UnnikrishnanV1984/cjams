DROP FUNCTION IF EXISTS cjams.get_ancillary_payment(json);
CREATE OR REPLACE FUNCTION cjams.get_ancillary_payment(request json)
 RETURNS TABLE(
	totalcount bigint,
  	payment_id integer,
  	ads_approval_dt date,
  	pa_start_dt date,
  	pa_end_dt date,
  	provider_id integer,
  	payment_dt date,
  	client_account_id integer,
  	payment_type_cd character varying,
  	check_status_cd character varying,
  	check_status character varying,
  	payment_method_cd character varying,
  	gross_amount_no numeric,
  	offset_amount_no numeric,
  	payee_nm character varying,
  	interface_to_cd character varying,
  	adr_type_cd character varying,
  	payment_start_dt date,
  	payment_end_dt date,
  	address_details json,
  	client_id bigint,
  	draft_service_id integer,
  	draft_service_nm character varying,
  	draft_service_start_dt date,
  	draft_service_end_dt date,
  	draft_units_no integer,
  	final_service_id integer,
  	final_service_nm character varying,
  	final_service_start_dt date,
	final_service_end_dt date,
	final_units_no integer,
	draft_amount_no numeric,
	final_amount_no numeric,
	notes_tx character varying,
	status_cd character varying,
	draft_rate_type_cd character varying,
	final_rate_type_cd character varying,
	draft_unit_rate_amt numeric,
	final_unit_rate_amt numeric,
	draft_unit_type character varying,
	final_unit_type character varying,
	draft_fiscal_category_cd character,
	final_fiscal_category_cd character,
	draft_fiscal_category_nm character varying,
	final_fiscal_category_nm character varying,
	cis_client_id bigint,
	client_first_nm character varying,
	client_last_nm character varying,
	mail_code_tx character varying,
	tax_id_no numeric,
	prov_tax_type_cd character varying,
	prov_first_nm character varying,
	prov_last_nm character varying,
	provider_nm text,
	reason_changed character varying,
	county_cd character varying,
	case_worker jsonb,
	payment_status_nm character varying,
	payment_type_nm character varying,
	payment_method_nm character varying,
	check_status_nm character varying,
	amountnottoexceed numeric,
	cost numeric,
	justification_tx character varying,
	case_id bigint,
	service_log_id integer,
	authorization_id integer,
	store_receipt_id character varying,
	dob timestamp without time zone,
	clientgender character varying,
	programkey character varying,
	report_1099_sw character,
	type_1099_cd character varying
)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 05/28/2021 Vineet Tirodkar - Modifications to add the missing delete_sw in where clause of Payment tables (CDM-13300)
-- 02/22/2023 Vineet Tirodkar - Performance issue Fix - commented unwanted join with intakeservicerequest & servicecasenumber tables (CIDM-6787)
-- 09/22/2023 Vineet Tirodkar - To fix the Vendor Name display issue (CDM-34418)
-- 02/10/2026 Yogeshvar - Refactor the function to improve performance.
-- 06/26/2026 Vinesh - Fix for CDM-44855 As the part of query tuning tb_payment_status was missing and attempts to look up the payment status name by mapping a payment type code ('4') against the status picklist, resulting in no match (NULL).
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
	v_DOBDateFrom   TIMESTAMP(3);                
	v_DOBDateTo TIMESTAMP(3);
	v_adr_type_cd CHARACTER VARYING(50);
	v_adr_city_nm CHARACTER VARYING(50);
	v_adr_zip5_no INT;
	v_adr_county_cd CHARACTER VARYING(50);
	v_adr_work_phone_tx CHARACTER VARYING(10);
	v_clientname character varying(30);
	v_taxid int;
	v_ayear character varying(30);

BEGIN  
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
	v_clientname := request ->> 'clientname';
	v_taxid := request ->> 'taxid';

	v_DOBDateFrom 	 := request ->> 'dobdaterangefrom';                       
	v_DOBDateTo 		 := request ->> 'dobdaterangeto';
	v_ayear := request ->> 'ayear';
 
RETURN QUERY 
	with base as (
		SELECT 
			payhead.payment_id,
			paydet.payment_detail_id,
			paydet.client_id,
			payhead.provider_id,
			payhead.authorization_id,
			paydet.case_id,
			paydet.draft_service_id,
			paydet.final_service_id
		FROM tb_payment_header as payhead  
		INNER JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id AND paydet.delete_sw = 'N'
		INNER JOIN tb_provider as prov ON payhead.provider_id = prov.provider_id
		LEFT JOIN person as client ON paydet.client_id = client.cjamspid AND client.activeflag = 1
		WHERE payhead.delete_sw = 'N' 
		AND payhead.payment_type_cd = '4'
		and (v_payment_id is null or payhead.payment_id = v_payment_id)
		AND (v_provider_id is null or payhead.provider_id = v_provider_id)
		AND (v_client_id is null or paydet.client_id = v_client_id)
		AND (v_adr_type_cd is null or payhead.adr_type_cd = v_adr_type_cd)
		AND (v_adr_city_nm is null or payhead.adr_city_nm = v_adr_city_nm)
		AND (v_adr_zip5_no is null or payhead.adr_zip5_no = v_adr_zip5_no)
		AND (v_adr_county_cd is null or payhead.adr_county_cd = v_adr_county_cd)
		AND (v_adr_work_phone_tx is null or payhead.adr_work_phone_tx = v_adr_work_phone_tx)
		AND  (lower(trim(v_clientname)) is null
		or	 ((COALESCE(lower(client.firstname) ,'') LIKE '%'|| COALESCE(lower(v_clientname) ,'')||'%')
		or  (COALESCE(lower(client.lastname) ,'') LIKE '%'||COALESCE(lower(v_clientname) ,'')||'%')) 
		or  (COALESCE(lower(concat (client.firstname,' ',client.lastname)) ,'') LIKE '%'||COALESCE(lower(v_clientname) ,'')||'%')
		OR	soundex(lower(trim(client.firstname))) = soundex(lower(trim(v_clientname)))
		OR	soundex(lower(trim(client.LastName)))  = soundex(lower(trim(v_clientname)))
		OR  soundex(lower(trim(client.MiddleName))) = soundex(lower(trim(v_clientname))) )       
		AND (v_taxid is null or prov.tax_id_no = v_taxid)
		and 
		case
			when (v_DateFrom is not null and v_DateTo is not null)  then to_char((payhead.create_ts), 'YYYY-MM-DD')::date
			between to_char(DATE(v_DateFrom::varchar), 'YYYY-MM-DD')::date and to_char(DATE(v_DateTo::varchar), 'YYYY-MM-DD')::date
			else true
		end
			and
		case
			when (v_DateFrom is not null and v_DateTo is null)  then to_char((payhead.create_ts ), 'YYYY-MM-DD')::date
			between to_char(DATE(v_DateFrom::varchar), 'YYYY-MM-DD')::date and to_char(DATE(now()::varchar ), 'YYYY-MM-DD')::date
			else true
		end
		and
		case
			when (v_DOBDateFrom is not null and v_DOBDateTo is not null) then to_char(DATE(client.dob::varchar ), 'YYYY-MM-DD')::date 
			between to_char(DATE(v_DOBDateFrom::varchar), 'YYYY-MM-DD')::date and to_char(DATE(v_DOBDateTo::varchar), 'YYYY-MM-DD')::date
			else true
		end
			and
		case
			when (v_DOBDateFrom is not null and v_DOBDateTo is null) then to_char(DATE(client.dob ::varchar ), 'YYYY-MM-DD')::date 
			between to_char(DATE(v_DOBDateFrom::varchar), 'YYYY-MM-DD')::date and to_char(DATE(now()::varchar ), 'YYYY-MM-DD')::date
			else true
		end
		ORDER BY payhead.payment_id DESC
	),
	TotalCount AS (
		SELECT count(1) as full_count FROM base
	)
	SELECT 
		(SELECT full_count FROM TotalCount) as totalcount,
		payhead.payment_id, payauth.ads_approval_dt,
		payauth.start_dt::date as pa_start_dt, payauth.end_dt::date as pa_end_dt,
		payhead.provider_id, payhead.payment_dt, payhead.client_account_id,
		payhead.payment_type_cd, payhead.check_status_cd,
		pv_check.value_tx as check_status,
		payhead.payment_method_cd, payhead.gross_amount_no, payhead.offset_amount_no,
		payhead.payee_nm, payhead.interface_to_cd, payhead.adr_type_cd,
		paydet.final_service_start_dt AS payment_start_dt,
		paydet.final_service_end_dt AS payment_end_dt,
		null::json as address_details,
		paydet.client_id, paydet.draft_service_id,
		ds.service_nm as draft_service_nm, paydet.draft_service_start_dt,
		paydet.draft_service_end_dt, paydet.draft_units_no, paydet.final_service_id,
		fs.service_nm as final_service_nm, tsl.start_dt as final_service_start_dt,
		tsl.end_dt as final_service_end_dt, paydet.final_units_no,
		paydet.draft_amount_no, paydet.final_amount_no, paydet.notes_tx, paydet.status_cd,
		pv_rate_d.value_tx as draft_rate_type_cd, pv_rate_f.value_tx as final_rate_type_cd,
		paydet.draft_unit_rate_amt, paydet.final_unit_rate_amt,
		pv_unit_d.value_tx as draft_unit_type, pv_unit_f.value_tx as final_unit_type,
		paydet.draft_fiscal_category_cd, paydet.final_fiscal_category_cd,
		fmc_d.fiscal_category_desc as draft_fiscal_category_nm,
		fmc_f.fiscal_category_desc as final_fiscal_category_nm,
		client.cjamspid as cis_client_id, client.firstname as client_first_nm,
		client.lastname as client_last_nm, prov.mail_code_tx, prov.tax_id_no,
		pv_tax.value_tx as prov_tax_type_cd, prov.provider_first_nm, prov.provider_last_nm,
		COALESCE(NULLIF(prov.provider_nm,''), CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm)) AS provider_nm,
		pv_reason.value_tx as reason_changed, pv_county.value_tx as county_cd,
		cw.worker_info as case_worker,
		pv_status.value_tx as payment_status_nm, pv_type.value_tx as payment_type_nm,
		pv_meth.value_tx as payment_method_nm, pv_check_nm.value_tx as check_status_nm,
		payauth.final_amount_no as amountnottoexceed, payauth.cost_no as cost,
		payauth.justification_tx::character varying, paydet.case_id, payauth.service_log_id,
		payhead.authorization_id, payhead.store_receipt_id, client.dob,
		''::character varying as clientgender, APA.programkey, paydet.report_1099_sw, paydet.type_1099_cd
	FROM base f
	JOIN tb_payment_header payhead ON f.payment_id = payhead.payment_id
	JOIN tb_payment_detail paydet ON payhead.payment_id = paydet.payment_id AND paydet.delete_sw = 'N'
	LEFT JOIN person client ON paydet.client_id = client.cjamspid AND client.activeflag = 1
	LEFT JOIN tb_provider prov ON payhead.provider_id = prov.provider_id
	LEFT JOIN tb_payment_status paystat ON payhead.payment_id = paystat.payment_id AND paystat.delete_sw = 'N'
	LEFT JOIN tb_service_purchase_authorization payauth ON payauth.authorization_id = payhead.authorization_id AND payauth.delete_sw = 'N'
	LEFT JOIN tb_service_log tsl ON payauth.service_log_id = tsl.service_log_id AND tsl.delete_sw = 'N'
	LEFT JOIN agencyprogramarea APA ON APA.programkey = tsl.agency_program_area_id AND APA.activeflag = 1
	LEFT JOIN tb_services ds ON ds.service_id = paydet.draft_service_id AND ds.delete_sw = 'N'
	LEFT JOIN tb_services fs ON fs.service_id = paydet.final_service_id AND fs.delete_sw = 'N'
	LEFT JOIN TB_FISCAL_CATEGORY_MASTER fmc_d ON fmc_d.fiscal_category_cd = paydet.draft_fiscal_category_cd AND fmc_d.delete_sw = 'N'
	LEFT JOIN TB_FISCAL_CATEGORY_MASTER fmc_f ON fmc_f.fiscal_category_cd = paydet.final_fiscal_category_cd AND fmc_f.delete_sw = 'N'
	LEFT JOIN tb_picklist_values pv_check ON pv_check.PICKLIST_VALUE_CD = payhead.check_status_cd AND pv_check.PICKLIST_TYPE_ID = 37
	LEFT JOIN tb_picklist_values pv_rate_d ON pv_rate_d.PICKLIST_VALUE_CD = paydet.draft_rate_type_cd AND pv_rate_d.PICKLIST_TYPE_ID = 82
	LEFT JOIN tb_picklist_values pv_rate_f ON pv_rate_f.PICKLIST_VALUE_CD = paydet.final_rate_type_cd AND pv_rate_f.PICKLIST_TYPE_ID = 82
	LEFT JOIN tb_picklist_values pv_unit_d ON pv_unit_d.PICKLIST_VALUE_CD = paydet.draft_unit_type AND pv_unit_d.PICKLIST_TYPE_ID = 1316
	LEFT JOIN tb_picklist_values pv_unit_f ON pv_unit_f.PICKLIST_VALUE_CD = paydet.final_unit_type AND pv_unit_f.PICKLIST_TYPE_ID = 1316
	LEFT JOIN tb_picklist_values pv_tax ON pv_tax.PICKLIST_VALUE_CD = prov.prov_tax_type_cd AND pv_tax.PICKLIST_TYPE_ID = 216
	LEFT JOIN tb_picklist_values pv_reason ON pv_reason.PICKLIST_VALUE_CD = paydet.change_reason_cd AND pv_reason.PICKLIST_TYPE_ID = 277
	LEFT JOIN tb_picklist_values pv_county ON pv_county.PICKLIST_VALUE_CD = prov.county_cd AND pv_county.PICKLIST_TYPE_ID = 104
	LEFT JOIN tb_picklist_values pv_meth ON pv_meth.PICKLIST_VALUE_CD = payhead.payment_method_cd AND pv_meth.PICKLIST_TYPE_ID = 1
	LEFT JOIN tb_picklist_values pv_status ON TRIM(pv_status.PICKLIST_VALUE_CD) = TRIM(paystat.payment_status_cd) AND pv_status.PICKLIST_TYPE_ID = 133
	LEFT JOIN tb_picklist_values pv_type ON pv_type.PICKLIST_VALUE_CD = payhead.payment_type_cd AND pv_type.PICKLIST_TYPE_ID = 2
	LEFT JOIN tb_picklist_values pv_check_nm ON pv_check_nm.PICKLIST_VALUE_CD = payhead.payment_type_cd AND pv_check_nm.PICKLIST_TYPE_ID = 5
	LEFT JOIN LATERAL (
		SELECT row_to_json(w)::jsonb as worker_info FROM (
			SELECT up.fullname, up.cjamspid as workerid, upp.phonenumber, upa.county as localdepartment 
			FROM servicecase sc
			INNER JOIN caseassignment ca ON ca.objectid = sc.servicecaseid
			INNER JOIN userprofile up ON up.securityusersid = ca.toworkeridno
			LEFT JOIN userprofilephonenumber upp ON up.securityusersid = upp.securityusersid
			LEFT JOIN userprofileaddress upa ON up.securityusersid = upa.securityusersid
			WHERE sc.servicecasenumber = paydet.case_id::character varying
			AND LOWER(ca.responsibilitytypekey) = 'family' AND ca.enddate IS NULL AND ca.activeflag = 1
			LIMIT 1
		) w
	) cw ON TRUE
	LIMIT v_pageSize OFFSET v_pageOffset;
END;

$function$;
