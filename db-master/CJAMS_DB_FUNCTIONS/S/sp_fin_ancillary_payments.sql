DROP FUNCTION if exists cjams.sp_fin_ancillary_payments(json);

CREATE OR REPLACE FUNCTION cjams.sp_fin_ancillary_payments(v_ancillary_details json)
 RETURNS TABLE(paymentid text, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Chandra Ramasamy
-- Date Created : 04/07/2022 
-- To Create a  Ancillary Payments
--			'26' - CfE Bed Hold Retainer Fee

-- Argument   :		
--	'authorizationid' - PK of ancillaryservices table (alternateid)
--	'securityuserid' - Finance User ID who is approving this payment
--  'paymentmethod' - Payment method(Picklist values-picklist_type_id=1)
--  'storereceiptid' - store receipt id
--  'type1099cd' - type 1099 cd
--  'vreport1099sw' - report 1099 sw
--Sample : 
--select cjams.sp_fin_ancillary_payments(
--  '{"authorizationid":1,	
--	"securityuserid": "d44eb3ee-9b1d-4271-8307-2587d0109772",
--    "paymentmethod":"3",
--	"storereceiptid":"12344",
--	"type1099cd":"2",
--	"vreport1099sw":"Y"	
--	}'
--);

-- Revison(s)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 12/09/2022 - Vineet Tirodkar - To fix Type casting Aurora issue character varying = bigint (CDM-27171)
------------------------------------------------------------------------	
DECLARE 
	v_county_cd character varying;
	vl_region_id integer;
	v_securityuserid_statecountycd character varying;
	v_purchase_type_cd character varying;
	v_provider_id bigint;
	vl_payment_provider_id bigint;
	v_service_id integer;
	v_final_amount_no numeric;
--	v_client_id bigint;
	v_case_id bigint;
	v_payment_start_dt date;
	v_payment_end_dt date;
--	v_djs_resource_approval character varying; -- uuid;
--	v_djs_resource_approval_dt timestamp;
--	v_djs_finance_approval uuid;
--	v_djs_finance_approval_dt timestamp;
--	v_djs_pca_group_id uuid;
--	v_djs_pca_code_id uuid;
--	v_djs_object_group_id uuid;
--	v_djs_object_code_id uuid;
--	v_djs_pca_code character varying;
	v_requestor_user_id uuid;
	vl_affiliate_provider bigint;
	v_pay_cd character varying;
	v_adr_typ character varying;
	v_addr_format character varying;
	v_addr_st_no character varying;
	vl_addr_box bigint;
	v_addr_pre character varying;
	v_addr_st character varying;
	v_addr_suff character varying;
	v_addr_post character varying;
	v_unit_type character varying;
	v_add_unit character varying;
	v_city character varying;
	v_county character varying;
	v_state character varying; 
	vd_zip5 bigint;
	vd_zip4 bigint;
	v_direc character varying;
	v_foreign character varying;
	v_foreign_st character varying;
	v_foreign_postal character varying;
	v_add_country character varying;
	v_default_sw character varying;
	vdt_end_dt date;
	vdt_start_dt date;
	vl_pay_header_id bigint default 0;
	vl_pay_status_id bigint default 0;
	vl_pay_detail_id bigint default 0;
	vl_slpa_snapshot_id bigint default 0;
	v_paymentid bigint;
	v_requestor_staff_id character varying; 
	v_requestor_name character varying;
	v_requestor_phone character varying;  
	v_requestor_title character varying;
	v_payment_staff_id bigint;  
	v_payment_name character varying; 
	v_payment_phonenumber character varying;  
	v_payment_title character varying; 
	v_payment_method character varying; 
	v_store_receipt_id character varying; 
	v_report_1099_sw  character varying; 
	v_type_1099_cd character varying; 
	v_caseworker_statecountycd character varying;
	v_financecategorycode character varying;
	v_authorization_id bigint;
	v_securityuserid character varying;	
	 

begin
	
	v_authorization_id := v_ancillary_details->>'authorizationid'; 
	v_securityuserid := v_ancillary_details->>'securityuserid';
    v_payment_method  := v_ancillary_details->>'payment_method_cd';
    v_store_receipt_id := v_ancillary_details->>'store_receipt_id';
    v_type_1099_cd:= v_ancillary_details->>'type_1099_cd';
    --v_report_1099_sw := v_ancillary_details->>'report_1099_sw';
	v_report_1099_sw := (CASE WHEN v_type_1099_cd is not null then 'Y' else null end); 

	--For getting case worker county id 
--	select trim(c.statecountycode)::character varying 
--		into v_caseworker_statecountycd 
--	from routing r 
--		join team t on r.teamid=t.teamid  and t.activeflag = 1
--		join county c on c.countyid = t.countyid::uuid 
--	where r.objectid=v_authorization_id 
--		and r.routingstatustypeid=39
--	limit 1;
		
	-- Get Srevice Log/Purchase Auth details
		select btrim(ancs.paymenttype) as purchase_type_cd,
			ps.provider_id, 
			ps.service_id,
			ancs.costnotexceed, -- final_amount_no,
--			sl.client_id,
--			sl.case_id,
			ancs.startdate, 
			ancs.enddate,
--			ancs.insertedby,
--			ancs.insertedon,
			-- pa.djs_resource_approval,
			-- pa.djs_resource_approval_dt,
--			pa.djs_finance_approval,
--			pa.djs_finance_approval_dt,
--			pa.djs_pca_group_id,
--			pa.djs_pca_code_id,
--			pa.djs_object_group_id,
--			pa.djs_object_code_id,
--			pa.djs_pca_code,
			ancs.insertedby, 
			ancs.financecategorycode,
			ancs.statecountycode
		into v_purchase_type_cd,
			v_provider_id,
			v_service_id,
			v_final_amount_no,
--			v_client_id,
--			v_case_id,
			v_payment_start_dt, 
			v_payment_end_dt,
--			v_djs_resource_approval,
--			v_djs_resource_approval_dt,
--			v_djs_finance_approval,
--			v_djs_finance_approval_dt,
--			v_djs_pca_group_id,
--			v_djs_pca_code_id,
--			v_djs_object_group_id,
--			v_djs_object_code_id,
--			v_djs_pca_code,
			v_requestor_user_id,
			v_financecategorycode,
			v_county_cd
		from cjams.ancillaryservices ancs,
			prov.tb_provider_services ps	
		where  ancs.providerserviceid = ps.provider_service_id::int
			and ancs.activeflag = 1
			and ancs.alternateid = v_authorization_id ;
 
		If v_purchase_type_cd is null then
			v_purchase_type_cd := 'Null' ;
		end if;
		
		if v_provider_id > 0 AND v_purchase_type_cd in (  '26', '27') then
			-- Step 1
			-- Get Provider payment setting & affiliated provider Organization ID		
			SELECT affiliate_provider_id,
					pay_to_affiliate_cd 
			INTO vl_affiliate_provider,
				 v_pay_cd
			from prov.tb_provider
			where provider_id = v_provider_id 
				and delete_sw = 'N' ;
					
			-- Step 2
			-- Verify Payment setting
			IF v_pay_cd = '3368' THEN -- The Payment Address of the Affiliate Organization
				-- Send Payment to affiliated provider Organization ID		
				vl_payment_provider_id = vl_affiliate_provider;

				-- Get affiliated provider Organization payment setting	
				select pay_to_affiliate_cd 
					into v_pay_cd
				from prov.tb_provider
				where provider_id = vl_payment_provider_id
					and delete_sw = 'N' ;
			ELSE
				-- Send Payment to the provider selected on Service Log screen		
				vl_payment_provider_id = v_provider_id;
			END IF;

			-- Step 3
			-- Get Provider's Payment Address Type, based on the vs_pay_cd (payment setting) of the Payment Provider
			IF v_pay_cd = '3366' THEN -- The Same Address (means Provider's payment address is same as Location Address)
				v_adr_typ = '3357'; -- Provider Location Address
			ELSE 
				v_adr_typ = '3356'; -- Provider Payment Address
			END IF;

			-- Step 4
			-- Get Provider's Payment Address to populate in TB_PAYMENT_HEADER table	
			select adr_format_cd, adr_street_tx, adr_box_no, adr_pre_dir_cd, adr_street_nm, 
				adr_street_suffix_cd, adr_post_dir_cd, adr_unit_type_cd, adr_unit_no_tx, adr_city_nm,   
				adr_county_cd, adr_state_cd, adr_zip5_no, adr_zip4_no, adr_direction_tx, 
				adr_foreign_tx, adr_foreign_state_tx, adr_postal_code_tx, adr_country_tx, adr_default_sw,   
				adr_end_dt, adr_start_dt  
			into v_addr_format, v_addr_st_no, vl_addr_box, v_addr_pre, v_addr_st, 
				v_addr_suff, v_addr_post, v_unit_type, v_add_unit, v_city,
				v_county, v_state, vd_zip5, vd_zip4, v_direc, 
				v_foreign, v_foreign_st, v_foreign_postal, v_add_country, v_default_sw,
				vdt_end_dt, vdt_start_dt			
			from prov.tb_provider_addresses  
			where adr_type_cd = v_adr_typ
				and parent_key_id = vl_payment_provider_id::character varying
				and delete_sw = 'N' 
				and adr_default_sw = 'Y' 
			limit 1;
			
			select nextval('cjams.sq_payment_header') into vl_pay_header_id ;
			raise notice 'before payment header v_securityuserid %',v_securityuserid;
			insert 
			into
			cjams.tb_payment_header ( payment_id,
			provider_id,
			authorization_id,
			client_account_id,
			payment_dt,
			payment_type_cd,
			check_status_cd,
			payment_method_cd,
			gross_amount_no,
			offset_amount_no,
			manual_sw,
			approval_status_cd,
			create_ts,
			create_user_id,
			update_ts,
			update_user_id,
			delete_sw,
			store_receipt_id,
			adr_box_no,
			adr_city_nm,
			adr_country_tx,
			adr_county_cd,
			adr_default_sw,
			adr_direction_tx,
			adr_end_dt,
			adr_start_dt,
			adr_foreign_state_tx,
			adr_foreign_tx,
			adr_format_cd,
			adr_post_dir_cd,
			adr_postal_code_tx,
			adr_pre_dir_cd,
			adr_state_cd,
			adr_street_nm,
			adr_street_tx,
			adr_street_suffix_cd,
			adr_unit_no_tx,
			adr_unit_type_cd,
			adr_zip4_no,
			adr_zip5_no,
			payment_start_dt,
			payment_end_dt
			 )
			values ( vl_pay_header_id,
			vl_payment_provider_id,
			v_authorization_id,
			null,
			now(),
			v_purchase_type_cd,
			'',
			v_payment_method,
			v_final_amount_no,
			0,
			'',
			'3047',
			now(),
			v_securityuserid,
			now(),
			v_securityuserid,
			'N',
			v_store_receipt_id,
			vl_addr_box,
			v_city,
			v_add_country,
			v_county,
			v_default_sw,
			v_direc,
			vdt_end_dt,
			vdt_start_dt,
			v_foreign_st,
			v_foreign,
			v_addr_format,
			v_addr_post,
			v_foreign_postal,
			v_addr_pre,
			v_state,
			v_addr_st,
			v_addr_st_no,
			v_addr_suff,
			v_add_unit,
			v_unit_type,
			vd_zip4,
			vd_zip5,
			v_payment_start_dt,
			v_payment_end_dt
			 ) returning payment_id into
				v_paymentid;
			
			select nextval('cjams.sq_payment_detail') into vl_pay_detail_id ;
			
			insert
			into
			cjams.tb_payment_detail ( payment_detail_id,
			payment_id,
			county_cd,
			payment_amount_no,
			client_id,
			final_service_id,
			final_service_start_dt,
			final_service_end_dt,
			final_amount_no,
			create_ts,
			create_user_id,
			update_ts,
			update_user_id,
			case_id,
			type_1099_cd,
			report_1099_sw,
			final_fiscal_category_cd )
			values ( vl_pay_detail_id,
			v_paymentid,
			v_county_cd,
			v_final_amount_no,
			null,
			v_service_id,
			v_payment_start_dt,
			v_payment_end_dt,
			v_final_amount_no,
			now(),
			v_securityuserid,
			now(),
			v_securityuserid,
			null,
			v_type_1099_cd,
			v_report_1099_sw,
			v_financecategorycode );
				
			select nextval('cjams.sq_payment_status') into vl_pay_status_id ;
			
			insert
			into
			cjams.tb_payment_status ( payment_status_id,
			payment_status_cd,
			payment_status_dt,
			payment_id,
			create_ts,
			create_user_id,
			update_ts,
			update_user_id )
			values ( vl_pay_status_id,
			'1634',
			now(),
			v_paymentid,
			now(),
			v_securityuserid,
			now(),
			v_securityuserid ); 

			
			--snapshot captures start here
--			
--			--  Update Payment Status & date 
--			update djs_finance.tb_djs_service_purchase_authorization
--				set payment_approval_status_cd = '3047', 
--					payment_approval_dt = now() 
--			where authorization_id = v_authorization_id ;	

		 raise notice 'before 1';

			-- create snapshot		
			-- Get Requestor User Details  ???
			select up.securityusersid, up.fullname , upp.phonenumber, up.description 
				into v_requestor_staff_id, v_requestor_name, v_requestor_phone,  v_requestor_title 
				from v_userprofile up 
					left outer join userprofilephonenumber upp on upp.securityusersid = up.securityusersid 
						and upp.activeflag = 1
			where up.securityusersid = v_requestor_user_id::character varying ;
			
--			-- Get Payment Approval User Details 
			select up.cjamspid, up.fullname , upp.phonenumber, up.description 
				into v_payment_staff_id, v_payment_name, v_payment_phonenumber, v_payment_title 
				from v_userprofile up 
					left outer join userprofilephonenumber upp on upp.securityusersid = up.securityusersid 
						and upp.activeflag = 1
			where up.securityusersid = v_securityuserid::character varying ;
 raise notice 'before ancillaryservicessnapshot';
			insert into cjams.ancillaryservicessnapshot
			( 	
				ancillaryservicesid, 
				providerid, 
				taxidno,
				provtaxtypecd,
				providername,
				provideraddress,
				providerphone,
				ldsscd,
				ldssdesc,
				ldssaddress,
				workerid,
				workername,
				workerphone,
--				requestdate,
				providerserviceid,
				providerservicedesc,
				justificationtx,
				fiscalcategorycd,
				fiscalcategorydesc,
				startdate,
				enddate,
				costno,
				finalamountno,
				sprvsrapprovaldate,
				sprvsrapprovalstatuscd,
				supervisorapprovalstatus,
				supervisorid,
				supervisorname,
				paymentapprovaldate,
				paymentapprovalstatuscd,
				paymentapprovalstatus,
				paymentstaffid, 
				paymentapprovername,
				updatedby,
				updatedon,
				insertedby,
				insertedon,
				activeflag
			)
			select 
				ancis.ancillaryservicesid, 
				tp.provider_id, 
				tp.tax_id_no, 
				tp.prov_tax_type_cd, 
				(case when tp.provider_nm  is not null THEN tp.provider_nm else	CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying end) as provider_nm,
				(select provider_adr as paymentaddress from cjams.get_provider_address(tp.provider_id::integer,trim('{3357,3356}')::character varying )),
				coalesce(tp.adr_cell_phone_tx,tp.adr_home_phone_tx,tp.adr_work_phone_tx)::character varying,
				v_county_cd,
				( select countyname from county where statecountycode  = v_county_cd ), 
				(select concat_ws(' ', upa.address, upa.city)::character varying || ', ' ||	concat_ws(' ', upa.state, upa.zipcode)::character varying from userprofileaddress upa	where upa.securityusersid = v_securityuserid order by upa.insertedon desc limit 1 ) as ldss_address, 
				v_requestor_staff_id::uuid, 
				v_requestor_name, 
				v_requestor_phone, 
--				v_requestor_staff_id, 
--				v_requestor_name, 
--				v_requestor_phone, 
				ancis.providerserviceid, 
				ts.service_nm, 
				ancis.comments, 
				ancis.financecategorycode, 
				'' as fiscal_category_desc, -- tspa.djs_pca_code,
				ancis.startdate, 
				ancis.enddate, 
				ancis.costnotexceed, 
				ancis.finalamount, 
				null,
				null,
				null,
				null,
				null,
				null,--//here paymentapprovaldate
				null,--//here paymentapprovalstatuscd
				null,--//here paymentapprovalstatus
				v_payment_staff_id, 
				v_payment_name, 
				'finance', 
				now(), 
				'finance',
				now(), 				
				1
			from cjams.ancillaryservices ancis 
				join prov.tb_provider_services tps on tps.provider_service_id = ancis.providerserviceid
				join prov.tb_provider tp on tps.provider_id = tp.provider_id
				left join prov.tb_provider_addresses tpas on tp.provider_id = tpas.parent_key_id::integer 
					and tpas.delete_sw = 'N'
				left join prov.tb_services ts on ts.service_id = tps.service_id 
			where ancis.alternateid = v_authorization_id 
			limit 1 ;
--snapshot captures end here
				RETURN QUERY SELECT vl_pay_header_id::text, true;
		else
			-- Error 
			RETURN QUERY SELECT 'Error - Invalid Authorization Id Or Payment Type :' || (v_authorization_id)::character varying || ' - ' || v_purchase_type_cd, false;
		end if;
	-- end if;
	
END;
		
$function$;
