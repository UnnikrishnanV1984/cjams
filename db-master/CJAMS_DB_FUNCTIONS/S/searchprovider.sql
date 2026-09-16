drop function cjams.searchprovider(searchobj json);
CREATE OR REPLACE FUNCTION cjams.searchprovider(searchobj json)
 RETURNS TABLE(countdata bigint, provider_id integer, mail_code_tx character varying, prov_tax_type_cd character varying, tax_id_no numeric, indicator_1099_sw character, medicaid_sw character, withhold_payment_sw character, admission_comments_tx character varying, provider_category_cd character varying, conversion_no_tx integer, source_tx character varying, provider_status_cd character varying, paid_sw character, profit_sw character, provider_nm character varying, provider_prefix_cd character varying, provider_first_nm character varying, provider_middle_nm character varying, provider_last_nm character varying, provider_suffix_cd character varying, business_start_tm character varying, business_end_tm character varying, medical_license_no_tx character varying, medical_speciality_tx character varying, school_district_tx character varying, county_cd character varying, collecting_entity_cd character varying, vacancy_no integer, pay_to_affiliate_cd character varying, dob_dt date, ref_contact_prefix_cd character varying, ref_contact_first_nm character varying, ref_contact_middle_nm character varying, ref_contact_last_nm character varying, ref_contact_suffix_cd character varying, adm_contact_prefix_cd character varying, adm_contact_first_nm character varying, adm_contact_middle_nm character varying, adm_contact_last_nm character varying, adm_contact_suffix_cd character varying, adr_work_phone_tx character varying, adr_work_xtn_tx character varying, adr_home_phone_tx character varying, adr_pager_tx character varying, adr_email_tx character varying, adr_fax_tx character varying, adr_cell_phone_tx character varying, adr_url_tx character varying, adr_other_contact_tx character varying, create_ts character varying, create_user_id character varying, update_ts character varying, update_user_id character varying, delete_sw character, affiliate_provider_id integer, co_prefix_cd character varying, co_first_nm character varying, co_middle_nm character varying, co_last_nm character varying, co_suffix_cd character varying, co_ssn_no numeric, co_dob_dt date, provider_type_cd character varying, ive_reimbursable_sw character, accept_plcmnt_ref_sw character, ref_work_phone_tx character varying, ref_work_xtn_tx character, ref_home_phone_tx character varying, ref_pager_tx character varying, ref_email_tx character varying, ref_fax_tx character varying, ref_cell_phone_tx character varying, ref_url_tx character varying, ref_other_contact_tx character varying, adm_work_phone_tx character varying, adm_work_xtn_tx character, adm_home_phone_tx character varying, adm_pager_tx character varying, adm_email_tx character varying, adm_fax_tx character varying, adm_cell_phone_tx character varying, adm_url_tx character varying, adm_other_contact_tx character varying, formatted_first_nm character varying, formatted_last_nm character varying, first_nm_soundex character, last_nm_soundex character, eft_sw character, formatted_middle_nm character varying, formatted_provider_nm character varying, provider_nm_soundex character, lnm_soundex character varying, fnm_soundex character varying, pnm_soundex character varying, info_date_changed date, reason_changed character varying, old_provider_id character varying, county_cd_tx character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Vineet Tirodkar - 05/04/2021 - Modifications for New Provider Category 3794 - Residential Treatment Center (B-102022)
-- Rengith Manickam - 11/19/2021 - Updated return table column type from integer to character varying[old_provider_id]
-- Sundeep kiran Anugolu - 03/08/2024 - Updated table with pagination and count(CIDM-8332)
------------------------------------------------------------------------------------------------
DECLARE 
  
	v_provider_id INTEGER;   
	v_pname VARCHAR(100);
	v_fname VARCHAR(50);
	v_mname VARCHAR(50);
	v_lname VARCHAR(50);
	v_pageoffset int;
    v_pagenumber int;
   	v_pagesize int;
	v_provider_status_cd VARCHAR(50);
	
BEGIN 

v_provider_id := searchobj ->> 'provider_id';
v_pname := searchobj ->> 'provider_nm';
v_fname := searchobj ->> 'provider_nm';
v_mname := searchobj ->> 'provider_nm';
v_lname := searchobj ->> 'provider_nm';

v_pagenumber := (searchobj ->> 'pagenumber')::int - 1;
v_pagesize := (searchobj ->> 'pagesize')::int;
v_pageoffset := v_pagenumber * v_pagesize;
v_provider_status_cd := searchobj ->> 'provider_status_cd';

RAISE NOTICE '%','v_provider_status_cd';

return query
select count(1) over(), * from (
    SELECT 
TBP.provider_id , 
TBP.mail_code_tx , 
TBP.prov_tax_type_cd , 
TBP.tax_id_no , 
TBP.indicator_1099_sw , 
TBP.medicaid_sw , 
TBP.withhold_payment_sw , 
TBP.admission_comments_tx , 
TBP.provider_category_cd , 
TBP.conversion_no_tx , 
TBP.source_tx , 
TBP.provider_status_cd , 
TBP.paid_sw , 
TBP.profit_sw , 
TBP.provider_nm , 
TBP.provider_prefix_cd , 
TBP.provider_first_nm , 
TBP.provider_middle_nm , 
TBP.provider_last_nm , 
TBP.provider_suffix_cd , 
TBP.business_start_tm , 
TBP.business_end_tm , 
TBP.medical_license_no_tx , 
TBP.medical_speciality_tx , 
TBP.school_district_tx , 
TBP.county_cd , 
TBP.collecting_entity_cd , 
TBP.vacancy_no , 
TBP.pay_to_affiliate_cd , 
TBP.dob_dt , 
TBP.ref_contact_prefix_cd , 
TBP.ref_contact_first_nm , 
TBP.ref_contact_middle_nm , 
TBP.ref_contact_last_nm , 
TBP.ref_contact_suffix_cd , 
TBP.adm_contact_prefix_cd , 
TBP.adm_contact_first_nm , 
TBP.adm_contact_middle_nm , 
TBP.adm_contact_last_nm , 
TBP.adm_contact_suffix_cd , 
TBP.adr_work_phone_tx , 
TBP.adr_work_xtn_tx , 
TBP.adr_home_phone_tx , 
TBP.adr_pager_tx , 
TBP.adr_email_tx , 
TBP.adr_fax_tx , 
TBP.adr_cell_phone_tx , 
TBP.adr_url_tx , 
TBP.adr_other_contact_tx , 
TBP.create_ts , 
TBP.create_user_id , 
TBP.update_ts , 
TBP.update_user_id , 
TBP.delete_sw , 
TBP.affiliate_provider_id , 
TBP.co_prefix_cd , 
TBP.co_first_nm , 
TBP.co_middle_nm , 
TBP.co_last_nm , 
TBP.co_suffix_cd , 
TBP.co_ssn_no , 
TBP.co_dob_dt date, 
TBP.provider_type_cd , 
TBP.ive_reimbursable_sw , 
TBP.accept_plcmnt_ref_sw , 
TBP.ref_work_phone_tx , 
TBP.ref_work_xtn_tx , 
TBP.ref_home_phone_tx , 
TBP.ref_pager_tx , 
TBP.ref_email_tx , 
TBP.ref_fax_tx , 
TBP.ref_cell_phone_tx , 
TBP.ref_url_tx , 
TBP.ref_other_contact_tx , 
TBP.adm_work_phone_tx , 
TBP.adm_work_xtn_tx , 
TBP.adm_home_phone_tx , 
TBP.adm_pager_tx , 
TBP.adm_email_tx , 
TBP.adm_fax_tx , 
TBP.adm_cell_phone_tx , 
TBP.adm_url_tx , 
TBP.adm_other_contact_tx , 
TBP.formatted_first_nm , 
TBP.formatted_last_nm , 
TBP.first_nm_soundex , 
TBP.last_nm_soundex , 
TBP.eft_sw , 
TBP.formatted_middle_nm , 
TBP.formatted_provider_nm , 
TBP.provider_nm_soundex , 
TBP.lnm_soundex , 
TBP.fnm_soundex , 
TBP.pnm_soundex , 
TBP.info_date_changed date, 
TBP.reason_changed , 
TBP.old_provider_id , 
TBP.county_cd_tx 
	FROM tb_provider as TBP
	WHERE 
    TBP.provider_id in (
		SELECT tpcl1.provider_id FROM TB_PROVIDER_PICKLIST tpcl1 WHERE tpcl1.PICKLIST_TYPE_ID=155 
		AND tpcl1.PICKLIST_VALUE_CD IN ('3274','3302','3049','1782','1785','1783','3794') 
		AND tpcl1.PROVIDER_ID = TBP.PROVIDER_ID AND tpcl1.DELETE_SW = 'N')
	AND CASE WHEN v_provider_status_cd IS NOT NULL THEN TBP.provider_status_cd = v_provider_status_cd ELSE TRUE END
	AND ((CASE WHEN v_fname IS NOT NULL THEN TBP.provider_first_nm ilike '%' || v_fname || '%' ELSE TRUE END)
	OR (CASE WHEN v_mname IS NOT NULL THEN TBP.provider_middle_nm ilike '%' || v_mname || '%' ELSE TRUE END)
	OR (CASE WHEN v_lname IS NOT NULL THEN TBP.provider_last_nm ilike '%' || v_lname || '%' ELSE TRUE END)
	OR (CASE WHEN v_pname IS NOT NULL THEN TBP.provider_nm ilike '%' || v_pname || '%' ELSE TRUE END))
	AND (CASE WHEN v_provider_id IS NOT NULL THEN TBP.provider_id = v_provider_id ELSE TRUE END)
	 ) as t
	LIMIT v_pagesize OFFSET v_pageoffset;           
END;
$function$
;
