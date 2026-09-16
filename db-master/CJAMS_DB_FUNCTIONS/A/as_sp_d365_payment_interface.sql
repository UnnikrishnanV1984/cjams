CREATE OR REPLACE FUNCTION cjams.as_sp_d365_payment_interface(OUT vs_message character varying, OUT vl_output_sqlcode character varying, OUT a timestamp without time zone, OUT b timestamp without time zone)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 05/19/2020
-- Description: Generate Adult Services Ancillary Payment data to Interface with D365.

-- Revisions:
-- 12/16/2020 Vineet Tirodkar - Changes to first look for provider_nm column else provider_first_nm and provider_last_nm (CDM-3556)
------------------------------------------------------------------------------------------------
-- VARIABLE DECLARATION
DECLARE vts_previous_run_ts TIMESTAMP;
DECLARE vts_current_run_ts TIMESTAMP ;

DECLARE vs_log_procedure_nm VARCHAR(20) DEFAULT 'AS_D365_PAYMENT_INTF';
DECLARE vs_anc_payment_type_cd VARCHAR(50) DEFAULT '21' ; -- referencetypeid: 20003 -> ref_key: 21 (Ancillary Payment)
DECLARE vs_user_id  VARCHAR(10) DEFAULT 'asintrface';
DECLARE ls_county VARCHAR(4) DEFAULT '0000';
DECLARE ls_county_cd VARCHAR(2) DEFAULT '99';
DECLARE ls_provider_nm VARCHAR(500);
DECLARE ls_indicator_1099_sw VARCHAR(3);
DECLARE ls_provider_last_nm VARCHAR(100);
DECLARE ls_provider_first_nm VARCHAR(100);
DECLARE ls_provider_middle_nm VARCHAR(100);
DECLARE ls_person_nm VARCHAR(100);
DECLARE ls_org_nm VARCHAR(100);
DECLARE ls_vendor_nm VARCHAR(100);
DECLARE ls_payment_method_cd CHAR(1);
DECLARE ls_link_payment_status VARCHAR(4); 
DECLARE ls_client_first_nm VARCHAR(100);
DECLARE ls_client_last_nm VARCHAR(100);
DECLARE ls_client_nm VARCHAR(100);
DECLARE ls_prov_tax_type_cd VARCHAR(4);
DECLARE ls_type_1099_cd VARCHAR(5);
DECLARE ls_final_fiscal_category_cd VARCHAR(5);
DECLARE ls_tax_id_no VARCHAR(100);
DECLARE ls_store_receipt_id VARCHAR(100);
DECLARE ls_adr_work_phone_tx VARCHAR(20);
DECLARE ls_adr_home_phone_tx VARCHAR(20);
DECLARE ls_adr_cell_phone_tx VARCHAR(20);
DECLARE ls_phone_tx VARCHAR(20);
DECLARE ls_adr_type_cd VARCHAR(5);
DECLARE ls_adr_format_cd VARCHAR(5);
DECLARE ls_adr_pre_dir_cd VARCHAR(5);
DECLARE ls_adr_street_nm VARCHAR(50) ;
DECLARE ls_adr_street_suffix_cd VARCHAR(5);
DECLARE ls_adr_post_dir_cd VARCHAR(5);
DECLARE ls_adr_unit_type_cd VARCHAR(5);
DECLARE ls_adr_unit_no_tx VARCHAR(5);
DECLARE ls_adr_city_nm VARCHAR(50);
DECLARE ls_adr_state_cd VARCHAR(5);
DECLARE ls_adr_foreign_tx VARCHAR(500);
DECLARE ls_adr_foreign_state_tx VARCHAR(50);
DECLARE ls_adr_country_tx VARCHAR(50);
DECLARE ls_address_1 VARCHAR(100);
DECLARE ls_adr_zip5_no VARCHAR(5);
DECLARE ls_adr_zip4_no VARCHAR(4);
DECLARE ls_adr_street_no VARCHAR(5) ;
DECLARE ls_adr_street_no1 VARCHAR(50) ;
DECLARE ls_adr_box_no VARCHAR(15) ;
DECLARE ls_address_2 VARCHAR(100);
DECLARE ls_zip_code VARCHAR(50);
DECLARE ls_pay_to_affiliate_cd VARCHAR(5);
DECLARE ls_payee_nbr VARCHAR(10);
DECLARE ls_report_1099_sw VARCHAR(1);
DECLARE ls_payment_type_cd VARCHAR(5);
DECLARE ls_manual_sw CHAR(1);
DECLARE ls_alternate_adr_type_cd VARCHAR(5);
DECLARE vs_payee_short_nm VARCHAR(100);
DECLARE vs_payment_type_cd VARCHAR(5) DEFAULT '0000';
DECLARE vs_excep_message VARCHAR(2000) DEFAULT '' ;
Declare vs_exc_adr_type VARCHAR(100) DEFAULT '';
DECLARE ls_county_name VARCHAR(25) DEFAULT  '' ;
DECLARE ls_error_provname VARCHAR(2)DEFAULT  '' ;
DECLARE ls_error_childname VARCHAR(2)DEFAULT  '' ;
DECLARE vs_excep_message1 VARCHAR(150)DEFAULT  '' ;
DECLARE vs_child_disbursement VARCHAR (1) DEFAULT 'N';
DECLARE ls_code_1099 VARCHAR(10);
DECLARE ls_account_type VARCHAR(10);
DECLARE ls_address_id_tx VARCHAR(20);
DECLARE ls_approved VARCHAR(5);
DECLARE ls_approved_by VARCHAR(5);
DECLARE ls_currency VARCHAR(5);
DECLARE ls_invoice VARCHAR(20);
DECLARE ls_invoice_desc VARCHAR(100);
DECLARE ls_journal_desc VARCHAR(50);
DECLARE ls_payor_company VARCHAR(5);
DECLARE ls_offset_account VARCHAR(30);
DECLARE ls_offset_account_type VARCHAR(10);
DECLARE ls_posting_profile VARCHAR(10);
DECLARE ls_terms_of_payment VARCHAR(5);
DECLARE ls_vendoraccount VARCHAR(15);
DECLARE ls_childacc_id VARCHAR(20); 
DECLARE ls_payment_id VARCHAR(20);

DECLARE vl_rowcount INTEGER DEFAULT 0;
DECLARE vl_interface_rowcount INTEGER DEFAULT 0;
DECLARE li_provider_id INTEGER DEFAULT 0;
DECLARE li_vendor_ln_1 INTEGER;
DECLARE li_vendor_ln_2 INTEGER;
DECLARE li_linked_pymnt_id INTEGER;
DECLARE li_payment_id INTEGER;
DECLARE li_interface_record_id INTEGER;
DECLARE li_client_id INTEGER;
DECLARE li_client_nm INTEGER;
DECLARE li_tax_id_no INTEGER;
DECLARE li_store_receipt_id INTEGER;
DECLARE li_adr_street_no INTEGER DEFAULT 0;
DECLARE li_adr_box_no INTEGER DEFAULT 0;
DECLARE li_adr_zip5_no INTEGER;
DECLARE li_adr_zip4_no INTEGER;
DECLARE li_payment_count INTEGER;
DECLARE li_client_count INTEGER;
DECLARE li_check INTEGER DEFAULT 0;
DECLARE li_address_1 INTEGER;
DECLARE li_address_2 INTEGER;
DECLARE li_city INTEGER;
DECLARE li_payee_nbr INTEGER;
DECLARE li_length  INTEGER DEFAULT 0;
DECLARE li_temp_provider_id INTEGER DEFAULT 0;
DECLARE li_affiliate_provider_id INTEGER DEFAULT 0;
DECLARE vl_payment_count INTEGER DEFAULT 0;
DECLARE vl_error_count INTEGER DEFAULT 0;
DECLARE vl_interfaces_error_log_id INTEGER DEFAULT 0;
DECLARE vl_error_logged INTEGER DEFAULT 0;
DECLARE li_payment_detail_id INTEGER;

DECLARE li_final_amount_no DECIMAL(13,2) DEFAULT 0.00;
DECLARE ld_amount_1099 DECIMAL(10,2);
DECLARE ll_address_id BIGINT;

DECLARE ld_payment_dt  DATE;
DECLARE ld_final_service_dt DATE  ;

DECLARE PAYMENT_CUR CURSOR FOR
	SELECT hdr.payment_id,
		dtl.linked_pymnt_hdr_id,
		hdr.provider_id,
		hdr.payment_method_cd,
		dtl.client_id,
		dtl.type_1099_cd,
		dtl.final_fiscal_category_cd,
		hdr.store_receipt_id,
		dtl.final_amount_no,
		hdr.payment_dt,
		dtl.final_service_end_dt,
		dtl.report_1099_sw,
		btrim(hdr.payment_type_cd),
		hdr.manual_sw      ,
		dtl.payment_detail_id
	FROM cjams.tb_payment_header AS hdr,
		cjams.tb_payment_detail AS dtl,
		cjams.tb_payment_status AS pst
	WHERE hdr.payment_id = dtl.payment_id
		AND hdr.payment_id = pst.payment_id
		AND hdr.delete_sw = 'N'
		AND dtl.delete_sw = 'N'
		AND pst.delete_sw = 'N'
		AND btrim(hdr.payment_type_cd) = vs_anc_payment_type_cd
		AND pst.payment_status_cd = '1634'
	ORDER BY  hdr.payment_id;

BEGIN 
	vts_previous_run_ts := CURRENT_TIMESTAMP;
	vts_current_run_ts := CURRENT_TIMESTAMP;
	ld_payment_dt  := '1900-01-01'::DATE;
	ld_final_service_dt := '1900-01-01'::DATE;
	vl_output_sqlcode := '00000';

	--  if first run, i.e., no rows in log, then leave as initialized
	IF EXISTS (SELECT 1 FROM cjams.interfacesruntimeslog) THEN
	BEGIN
		SELECT MAX(currentruntimestamp) 
			INTO vts_previous_run_ts 
		FROM cjams.interfacesruntimeslog
			WHERE interfaceid = vs_log_procedure_nm;
		
		EXCEPTION WHEN OTHERS THEN
			vs_message := 'SELECT MAX(currentruntimestamp) from cjams.interfacesruntimeslog FAILED '||SQLERRM  ;
			vl_output_sqlcode := SQLSTATE;
			
			INSERT INTO interfaceserrorlog
				(	interfaceid, 
					currentruntimestamp, 
					batchnumber, 
					errorlineno, 
					errorcode,
					errorsqlcode, 
					errordescription, 
					payment_id,
					provider_id, 
					county_cd, 
					client_id, 
					payment_amount
				)
			VALUES 
				(	vs_log_procedure_nm, 
					current_timestamp, 
					'000', 
					NULL, 
					'0',
					vl_output_sqlcode, 
					vs_message, 
					NULL, 
					NULL, 
					NULL, 
					NULL ,
					NULL
				);
			RETURN;
		END;
	END IF;

	-- Check for rows to interface, if none then quit.
	BEGIN
		IF EXISTS (	SELECT 1
					FROM cjams.tb_payment_header AS hdr,
						cjams.tb_payment_detail AS dtl,
						cjams.tb_payment_status AS pst
					WHERE hdr.payment_id = dtl.payment_id
						AND hdr.payment_id = pst.payment_id
						AND hdr.delete_sw = 'N'
						AND dtl.delete_sw = 'N'
						AND pst.delete_sw = 'N'
						AND btrim(hdr.payment_type_cd) = vs_anc_payment_type_cd
						AND pst.payment_status_cd = '1634'
					) THEN
		-- Payment found to process			
	ELSE
		vs_message := 'There are no Adult Services Ancillary Payment to interface with D365';
	END IF;

	EXCEPTION WHEN OTHERS THEN
		vs_message := 'select of Payments to interface count(*) FAILED '||SQLERRM  ;
		vl_output_sqlcode := SQLSTATE;
		INSERT INTO interfaceserrorlog
			(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode,
				errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
				client_id, payment_amount
			)
		VALUES 
			(	vs_log_procedure_nm, current_timestamp, '000', NULL, '0',
				vl_output_sqlcode, vs_message, NULL, NULL, NULL, 
				NULL, NULL
			);
		RETURN;
	END;

	SELECT COUNT(*) 
		INTO vl_payment_count
	FROM cjams.tb_payment_header AS hdr,
		cjams.tb_payment_detail AS dtl,
		cjams.tb_payment_status AS pst
	WHERE hdr.payment_id = dtl.payment_id
		AND hdr.payment_id = pst.payment_id
		AND hdr.delete_sw = 'N'
		AND dtl.delete_sw = 'N'
		AND pst.delete_sw = 'N'
		AND btrim(hdr.payment_type_cd) = vs_anc_payment_type_cd
		AND pst.payment_status_cd = '1634';

	OPEN PAYMENT_CUR;
	<<PAYMENT>>
	WHILE vl_payment_count > 0  LOOP
		li_payment_id := 0;
		li_provider_id := 0;
		ls_payment_method_cd := '';
		li_client_id := 0;
		ls_type_1099_cd := '';
		ls_final_fiscal_category_cd := '';
		ls_store_receipt_id := '';
		li_final_amount_no := 0 ;
		ld_payment_dt  := NULL ;
		ld_final_service_dt := NULL;
		ls_report_1099_sw := '';
		ls_payment_type_cd := '';
		ls_manual_sw := '';
		li_linked_pymnt_id := 0;
		ls_link_payment_status := '';
		li_payment_detail_id := 0;

		FETCH PAYMENT_CUR INTO 
			li_payment_id,
			li_linked_pymnt_id,
			li_provider_id,
			ls_payment_method_cd,
			li_client_id ,
			ls_type_1099_cd,
			ls_final_fiscal_category_cd,
			ls_store_receipt_id,
			li_final_amount_no,
			ld_payment_dt ,
			ld_final_service_dt,
			ls_report_1099_sw,
			ls_payment_type_cd,
			ls_manual_sw,
			li_payment_detail_id;

		EXIT PAYMENT WHEN NOT FOUND;
	
		RAISE NOTICE 'li_payment_id >> %',li_payment_id;
		li_client_count := 0; 

		li_provider_id := COALESCE(li_provider_id,0);
	
		ls_provider_nm := '';
		ls_provider_last_nm := '';
		ls_provider_first_nm := '';
		ls_provider_middle_nm := '';
		ls_indicator_1099_sw := '';
		ls_adr_work_phone_tx := '';
		ls_adr_home_phone_tx := '';
		ls_adr_cell_phone_tx := '';
		ls_prov_tax_type_cd := '';
		li_tax_id_no := 0;
		ls_pay_to_affiliate_cd := '';

		BEGIN
			SELECT pr.provider_nm,
				pr.provider_last_nm,
				pr.provider_first_nm,
				pr.provider_middle_nm,
				pr.indicator_1099_sw,
				pr.adr_work_phone_tx,
				pr.adr_home_phone_tx,
				pr.adr_cell_phone_tx,
				COALESCE(	pr.prov_tax_type_cd,
							(SELECT pr1.prov_tax_type_cd
								FROM cjams.tb_provider pr1
							 WHERE pr1.provider_id = pr.affiliate_provider_id
							 )
						) as prov_tax_type_cd,
				coalesce (pr.tax_id_no,
							(SELECT pr2.tax_id_no
								from cjams.tb_provider pr2
							where pr2.provider_id = pr.affiliate_provider_id
							)
						)as tax_id_no,
				pay_to_affiliate_cd
			INTO ls_provider_nm,
				ls_provider_last_nm,
				ls_provider_first_nm,
				ls_Provider_middle_nm,
				ls_indicator_1099_sw,
				ls_adr_work_phone_tx,
				ls_adr_home_phone_tx,
				ls_adr_cell_phone_tx,
				ls_prov_tax_type_cd,
				li_tax_id_no,
				ls_pay_to_affiliate_cd
			FROM cjams.tb_provider pr
			WHERE pr.provider_id = li_provider_id
				AND pr.delete_sw = 'N' ;

			EXCEPTION WHEN OTHERS THEN
				vs_message := 'Error in fetching Provider Information '||SQLERRM  ;
				vl_output_sqlcode := SQLSTATE;
				INSERT INTO interfaceserrorlog
					(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
						errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
						client_id, payment_amount
					)
				VALUES
					( 	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
						vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
						li_client_id , li_final_amount_no
					);
			RETURN;
		END;

		IF vl_payment_count > 0 THEN
			li_check := 1;
		END IF;

		IF ls_prov_tax_type_cd = '2517' THEN
			ls_prov_tax_type_cd := '1';
		ELSIF ls_prov_tax_type_cd = '2518' THEN
			ls_prov_tax_type_cd := '2';
		ELSE
			ls_prov_tax_type_cd := LPAD('',1);
		END IF;

		IF ls_type_1099_cd = '3155' THEN
			ls_type_1099_cd := '1';
		ELSIF ls_type_1099_cd = '3156' THEN
			ls_type_1099_cd := '6';
		ELSIF ls_type_1099_cd = '3157' THEN
			ls_type_1099_cd := '7';
		ELSE
			ls_type_1099_cd := NULL;
		END IF;

		ls_tax_id_no := SUBSTRING(RTRIM(LTRIM(li_tax_id_no::VARCHAR)),1,9);
		li_length := LENGTH(RTRIM(ls_tax_id_no));
		IF li_length < 9 THEN
			li_length := 9 - li_length ;
			WHILE li_length > 0 LOOP
				ls_tax_id_no := '0' || ls_tax_id_no;
				li_length := li_length - 1;
			END LOOP;
		END IF;

		ls_store_receipt_id := RTRIM(LTRIM((ls_store_receipt_id)));

		CASE WHEN LENGTH(ls_adr_work_phone_tx) = 0 THEN
			ls_phone_tx := COALESCE( ls_adr_cell_phone_tx, ls_adr_home_phone_tx );
		ELSE
			ls_phone_tx := ls_adr_work_phone_tx;
		END CASE;

		ls_provider_last_nm := RTRIM(LTRIM(ls_provider_last_nm));
		ls_provider_first_nm := RTRIM(LTRIM(ls_provider_first_nm));
		ls_provider_middle_nm := RTRIM(LTRIM(ls_provider_middle_nm));

		CASE WHEN LENGTH(ls_provider_last_nm) = 0 THEN
			ls_provider_last_nm := '';
		ELSE
			ls_provider_last_nm := COALESCE(ls_provider_last_nm,'');
		END CASE;

		IF ls_provider_last_nm <> '' THEN
			ls_provider_last_nm := ls_provider_last_nm;
		END IF;

		CASE WHEN LENGTH(ls_provider_first_nm) = 0 THEN
			ls_provider_first_nm := '';
		ELSE
			ls_provider_first_nm := COALESCE(ls_provider_first_nm,'');
		END CASE;

		IF ls_provider_first_nm <> '' THEN
			ls_provider_first_nm := ls_provider_first_nm;
		END IF;

		CASE WHEN LENGTH(ls_provider_middle_nm) = 0 THEN
			ls_provider_middle_nm := '';
		ELSE
			ls_provider_middle_nm := COALESCE(ls_provider_middle_nm,'');
		END CASE;

		IF ls_provider_middle_nm <> '' THEN
			ls_provider_middle_nm := ',' || ' ' || ls_provider_middle_nm;
		END IF;

		CASE WHEN LENGTH(ls_provider_nm) = 0 THEN
			ls_provider_nm := '';
		ELSE
			ls_provider_nm := COALESCE(ls_provider_nm,'');
		END CASE;

		ls_person_nm := COALESCE(RTRIM(LTRIM(ls_provider_last_nm)),'') || ',' || ' ' ||
				COALESCE(RTRIM(LTRIM(ls_provider_first_nm)),'') ;

		-- New Code
		IF ls_person_nm = ', ' THEN
			ls_person_nm := '';
		END IF;

		ls_org_nm := COALESCE(RTRIM(LTRIM(ls_provider_nm)),'');
		vs_payee_short_nm := COALESCE(RTRIM(LTRIM(ls_provider_first_nm)),'') || ' ' ||
			COALESCE(RTRIM(LTRIM(ls_provider_last_nm)),'');

		CASE WHEN LENGTH(ls_person_nm) = 0 THEN
			ls_person_nm := '';
		ELSE
			ls_person_nm := COALESCE(ls_person_nm,'');
		END CASE;

		CASE WHEN LENGTH(ls_org_nm) = 0 THEN
			ls_org_nm := '';
		ELSE
			ls_org_nm := COALESCE(ls_org_nm,'');
		END CASE;

		-- CDM-3556
		IF ls_org_nm <> '' THEN
			ls_vendor_nm := ls_org_nm;
			VS_PAYEE_SHORT_NM := ls_org_nm;
		ELSIF ls_person_nm <> '' THEN
			ls_vendor_nm := ls_person_nm;
		END IF;
		-- Old code
		/*
		IF ls_person_nm <> '' THEN
			ls_vendor_nm := ls_person_nm;
		ELSIF ls_org_nm <> '' THEN
			ls_vendor_nm := ls_org_nm;
			vs_payee_short_nm := ls_org_nm;
		END IF;
		*/
		
		li_vendor_ln_1 := LENGTH(ls_vendor_nm);
		li_vendor_ln_2 := LENGTH(ls_vendor_nm);

		IF li_vendor_ln_1 > 40 OR li_vendor_ln_1 = 40 THEN 
			li_vendor_ln_1 := 40 ;
		END IF;

		IF li_vendor_ln_2 > 40 OR li_vendor_ln_2 = 40 THEN
			li_vendor_ln_2 := 40;
		END IF;

		ls_payment_id := RTRIM(LTRIM((li_payment_id::VARCHAR)));

		BEGIN
			CASE WHEN ls_pay_to_affiliate_cd IN ('3366') THEN -- For LDSS
				ls_alternate_adr_type_cd := '3357';
				li_temp_provider_id := li_provider_id;
			WHEN ls_pay_to_affiliate_cd IN ('3367') THEN -- For Private Department
				ls_alternate_adr_type_cd := '3356';
				li_temp_provider_id := li_provider_id;
			WHEN ls_pay_to_affiliate_cd IN ('3368') THEN
				li_affiliate_provider_id := 0;


				SELECT DISTINCT affiliate_provider_id
					INTO li_affiliate_provider_id
				FROM cjams.tb_provider
				WHERE provider_id = li_provider_id
					AND Delete_sw  = 'N';

				IF li_affiliate_provider_id > 0 THEN
					ls_pay_to_affiliate_cd := ''; 

					SELECT pay_to_affiliate_cd
						INTO ls_pay_to_affiliate_cd
					FROM cjams.tb_provider
					WHERE affiliate_provider_id = li_affiliate_provider_id
						AND provider_id = li_provider_id
						AND delete_sw = 'N';


					CASE WHEN ls_pay_to_affiliate_cd in ('3366') THEN -- For LDSS
						ls_alternate_adr_type_cd := '3357';
						li_temp_provider_id := li_provider_id;
					WHEN ls_pay_to_affiliate_cd IN ('3367') THEN -- For Private Department
						ls_alternate_adr_type_cd := '3356';
						li_temp_provider_id := li_provider_id;
					WHEN ls_pay_to_affiliate_cd IN ('3368') THEN
						ls_pay_to_affiliate_cd := '' ;

						SELECT pay_to_affiliate_cd
							INTO ls_pay_to_affiliate_cd
						FROM cjams.tb_provider
						WHERE provider_id = li_affiliate_provider_id
							AND delete_sw  = 'N';

						CASE WHEN ls_pay_to_affiliate_cd IN ('3366') THEN -- For LDSS
							ls_alternate_adr_type_cd := '3357';
							li_temp_provider_id := li_affiliate_provider_id;
						WHEN ls_pay_to_affiliate_cd IN ('3367') THEN  --  For Private Department
							ls_alternate_adr_type_cd := '3356'     ;
							li_temp_provider_id := li_affiliate_provider_id;
						ELSE
							ls_alternate_adr_type_cd := LPAD('',4);
						END CASE;
					ELSE
						ls_alternate_adr_type_cd := LPAD('',4);
					END CASE;
				END IF; -- If affiliate provider is zero
			ELSE
				ls_alternate_adr_type_cd := LPAD('',4);
			END CASE;

			EXCEPTION WHEN OTHERS THEN
				vs_message := 'Error in fetching  Affiliate Provider for Private Department '||SQLERRM  ;
				vl_output_sqlcode := SQLSTATE;
		END;

		IF ls_alternate_adr_type_cd = '3356' THEN
			vs_exc_adr_type := 'Provider Payment address ' ;
		ELSIF ls_alternate_adr_type_cd = '3357' THEN
			vs_exc_adr_type := 'Provider Location address ' ;
		ELSE
			vs_exc_adr_type := 'Provider address ' ;
		END IF;
		

		ll_address_id := NULL; -- for AddressCode
		ls_adr_type_cd := '';
		ls_adr_format_cd := '';
		ls_adr_street_no := '';
		li_adr_box_no := 0 ;
		ls_adr_pre_dir_cd := '';
		ls_adr_street_nm := '';
		ls_adr_street_suffix_cd := '';
		ls_adr_post_dir_cd := '';
		ls_adr_unit_type_cd := '';
		ls_adr_unit_no_tx := '';
		ls_adr_city_nm := '';
		ls_adr_state_cd := '';
		ls_adr_foreign_tx := '';
		ls_adr_foreign_state_tx := '';
		ls_adr_country_tx := '';
		li_adr_zip5_no := 0;
		li_adr_zip4_no := 0;
		
		BEGIN
			SELECT DISTINCT address_id,
				adr_type_cd,
				adr_format_cd,
				adr_street_tx,
				adr_box_no,
				adr_pre_dir_cd,
				adr_street_nm,
				adr_street_suffix_cd,
				adr_post_dir_cd,
				adr_unit_type_cd,
				adr_unit_no_tx,
				adr_city_nm,
				adr_state_cd,
				adr_foreign_tx,
				adr_foreign_state_tx,
				adr_country_tx,
				adr_zip5_no,
				adr_zip4_no
			INTO ll_address_id,
				ls_adr_type_cd,
				ls_adr_format_cd,
				ls_adr_street_no,
				li_adr_box_no,
				ls_adr_pre_dir_cd,
				ls_adr_street_nm,
				ls_adr_street_suffix_cd,
				ls_adr_post_dir_cd,
				ls_adr_unit_type_cd,
				ls_adr_unit_no_tx,
				ls_adr_city_nm,
				ls_adr_state_cd,
				ls_adr_foreign_tx,
				ls_adr_foreign_state_tx,
				ls_adr_country_tx,
				li_adr_zip5_no,
				li_adr_zip4_no
			FROM cjams.tb_provider_addresses
			WHERE parent_key_id = li_temp_provider_id::character varying
				AND delete_sw = 'N'
				AND adr_default_sw = 'Y'
				AND adr_type_cd = ls_alternate_adr_type_cd  ;

		EXCEPTION WHEN OTHERS THEN
			vs_message := 'Error in fetching Provider Address '||SQLERRM  ;
			vl_output_sqlcode := SQLSTATE;
			INSERT INTO interfaceserrorlog
				(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
					errorsqlcode, errordescription, payment_id, provider_id, county_cd,
					client_id,  payment_amount
				)
			VALUES 
				( 	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
					vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
					li_client_id , li_final_amount_no
				);
		END;


		CASE WHEN LENGTH(ls_adr_street_no) = 0 THEN
			ls_adr_street_no := '';
		ELSE
			ls_adr_street_no := COALESCE(ls_adr_street_no,'');
		END CASE;

		IF li_adr_box_no > 0 THEN
			ls_adr_box_no := 'P.O. Box ' || RTRIM(LTRIM((li_adr_box_no::VARCHAR))) ;
		ELSE
			ls_adr_box_no := '      '; 
		END IF;

		--  Based on the Address Format Get the values
		CASE WHEN ls_adr_format_cd = 'S' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_adr_street_no)),'')    || ' '||
			UPPER(COALESCE(F_PDESC(ls_adr_pre_dir_cd,69),''))        || ' '||
			UPPER(RTRIM(LTRIM(ls_adr_street_nm)))   || ' '||
			UPPER(COALESCE(F_PDESC(ls_adr_street_suffix_cd,212),'')) || ' '||
			UPPER(COALESCE(F_PDESC(ls_adr_post_dir_cd,69) ,''));
			ls_address_1 := COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40));
		WHEN ls_adr_format_cd = 'R' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_adr_street_no)),'')    || ' '||
			COALESCE(RTRIM(LTRIM(ls_adr_box_no)),'') ;
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
		WHEN ls_adr_format_cd = 'P' THEN
			ls_address_1 := 'P.O. Box ' || RTRIM(LTRIM((li_adr_box_no::VARCHAR)));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40)));
		WHEN ls_adr_format_cd = 'F' THEN
			ls_address_1 := RTRIM(LTRIM(ls_adr_foreign_tx));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
			ls_adr_state_cd := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_adr_foreign_tx)),1,2),LPAD('',2))) ;
		ELSE
			ls_address_1 := LPAD('',40);
		END CASE;

		--Get For the Address Line 2
		ls_address_2 := UPPER(COALESCE(F_PDESC(ls_adr_unit_type_cd,250), '') || ' '|| ls_adr_unit_no_tx);
		ls_address_2 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_2)),1,40),LPAD('',40)));
		li_length := 0;

		IF li_adr_zip5_no > 0 THEN
			ls_adr_zip5_no := RTRIM(LTRIM(li_adr_zip5_no::VARCHAR));
			li_length := LENGTH (ls_adr_zip5_no);
			IF li_length < 5 THEN
				li_length := 5 - li_length ;
				WHILE li_length > 0 LOOP
					ls_adr_zip5_no := '0' || ls_adr_zip5_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			ls_zip_code := COALESCE(ls_adr_zip5_no,'00000');
		ELSE
			ls_adr_zip5_no := '00000';
			ls_zip_code := ls_adr_zip5_no;
		END IF;

		li_length := 0;
		IF li_adr_zip4_no > 0 THEN
			ls_adr_zip4_no := RTRIM(LTRIM((li_adr_zip4_no::VARCHAR)));
			li_length := LENGTH (ls_adr_zip4_no);
			IF li_length < 4 THEN
				li_length := 4 - li_length ;
				WHILE li_length > 0 LOOP
					ls_adr_zip4_no :=  '0' || ls_adr_zip4_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			ls_zip_code := LPAD('',5);
			ls_zip_code := COALESCE(ls_adr_zip5_no,'00000')   || '-'  ||COALESCE(ls_adr_zip4_no,'');
		END IF;

		li_length := 0;
		li_length := LENGTH(ls_zip_code);
		IF li_length < 7 THEN
			ls_zip_code := Substring(ls_zip_code,1,5);
		END IF;

		--Payment Type
		ls_county_name := '';
		ls_county_cd := ''; 
		IF ls_payment_type_cd = '3294' AND ls_manual_sw = 'N'  THEN
			ls_payment_method_cd := '1';
			ls_REPORT_1099_SW := 'N';
			ls_type_1099_cd := NULL;
		END IF;

		SELECT DISTINCT dtl.county_cd
			INTO ls_county
		FROM cjams.tb_payment_detail as DTL
		WHERE dtl.payment_id = li_payment_id  -- added 09/08/06
			AND dtl.delete_sw = 'N'
			AND (dtl.county_cd IS NOT NULL AND LENGTH(dtl.county_cd) > 0);

		CASE WHEN ls_county ='1427' THEN  ls_county_cd := '01';   ls_county_name := 'Allegany';    -- 07/24/06
			WHEN ls_county ='1428'  THEN  ls_county_cd := '02';   ls_county_name := 'Anne Arundel';
			WHEN ls_county ='1430'  THEN  ls_county_cd := '03';   ls_county_name := 'Baltimore County';
			WHEN ls_county ='1431'  THEN  ls_county_cd := '04';   ls_county_name := 'Calvert';
			WHEN ls_county ='1432'  THEN  ls_county_cd := '05';   ls_county_name := 'Caroline';
			WHEN ls_county ='1433'  THEN  ls_county_cd := '06';   ls_county_name := 'Carroll';
			WHEN ls_county ='1434'  THEN  ls_county_cd := '07';   ls_county_name := 'Cecil';
			WHEN ls_county ='1435'  THEN  ls_county_cd := '08';   ls_county_name := 'Charles';
			WHEN ls_county ='1436'  THEN  ls_county_cd := '09';   ls_county_name := 'Dorchester';
			WHEN ls_county ='1437'  THEN  ls_county_cd := '10';   ls_county_name := 'Frederick';
			WHEN ls_county ='1438'  THEN  ls_county_cd := '11';   ls_county_name := 'Garrett';
			WHEN ls_county ='1439'  THEN  ls_county_cd := '12';   ls_county_name := 'Harford';
			WHEN ls_county ='1440'  THEN  ls_county_cd := '13';   ls_county_name := 'Howard';
			WHEN ls_county ='1441'  THEN  ls_county_cd := '14';   ls_county_name := 'Kent';
			WHEN ls_county ='1442'  THEN  ls_county_cd := '15';   ls_county_name := 'Montgomery';
			WHEN ls_county ='1443'  THEN  ls_county_cd := '16';   ls_county_name := 'Prince George';
			WHEN ls_county ='1444'  THEN  ls_county_cd := '17';   ls_county_name := 'Queen Anne';
			WHEN ls_county ='1446'  THEN  ls_county_cd := '18';   ls_county_name := 'St. Marys';
			WHEN ls_county ='1445'  THEN  ls_county_cd := '19';   ls_county_name := 'Somerset';
			WHEN ls_county ='1447'  THEN  ls_county_cd := '20';   ls_county_name := 'Talbot';
			WHEN ls_county ='1448'  THEN  ls_county_cd := '21';   ls_county_name := 'Washington';
			WHEN ls_county ='1449'  THEN  ls_county_cd := '22';   ls_county_name := 'Wicomico';
			WHEN ls_county ='1450'  THEN  ls_county_cd := '23';   ls_county_name := 'Worcester';
			WHEN ls_county ='1429'  THEN  ls_county_cd := '24';   ls_county_name := 'Baltimore City';
		ELSE
			ls_county_cd  :='99';
		END CASE;
	
		ls_client_first_nm := '';
		ls_client_last_nm := '';
		SELECT firstname,
			lastname
		INTO ls_client_first_nm,
			ls_client_last_nm
		FROM person
		WHERE cjamspid = li_client_id AND ACTIVEFLAG = 1;
	
		ls_client_nm := COALESCE(RTRIM(LTRIM(ls_client_last_nm)),'') || ',' || ' '||
		COALESCE(RTRIM(LTRIM(ls_client_first_nm)),'');

		IF ls_client_nm = ','  THEN
			ls_client_nm  := ' ';
		END IF; 

		CASE WHEN length(ls_client_nm) = 0 THEN
			ls_client_nm := '';
		ELSE
			ls_client_nm := COALESCE(ls_client_nm,'');
		END CASE;

		li_client_nm :=  Length(ls_client_nm);
		IF li_client_nm > 40 OR li_client_nm = 40 THEN
			li_client_nm := 40 ;
		END IF;

		li_address_1 := Length(RTRIM(LTRIM(ls_address_1)));
		li_address_2 := Length(RTRIM(LTRIM(ls_address_2)));
		li_city := Length(RTRIM(LTRIM(ls_adr_city_nm)));

		IF li_address_1 > 40 OR li_address_1 = 40 THEN
			li_address_1 := 40 ;
		END IF;

		IF li_address_2 > 40 OR li_address_2 = 40 THEN
			li_address_2 := 40;
		END IF;

		IF li_city > 30 OR li_city = 30 THEN
			li_city := 30 ;
		END IF;

		CASE WHEN length(ls_REPORT_1099_SW) = 0 THEN
			ls_REPORT_1099_SW := 'N';
		ELSE
			ls_REPORT_1099_SW := COALESCE(ls_REPORT_1099_SW,'N');
		END CASE;

		ls_payee_nbr := COALESCE(Substring(RTRIM(LTRIM((li_provider_id::VARCHAR))),1,10), '0');
		li_payee_nbr := Length(RTRIM(LTRIM(ls_payee_nbr)));

		IF li_payee_nbr > 10 OR li_payee_nbr = 10 THEN
			li_payee_nbr := 10 ;
		END IF;

		CASE ls_payment_type_cd WHEN '3294' THEN
			IF ls_manual_sw = 'Y' THEN
				vs_payment_type_cd := 'MNAD';
			ELSIF ls_manual_sw IS NULL THEN
				vs_payment_type_cd := 'SYAD';
			ELSIF ls_manual_sw = 'N' THEN
				vs_payment_type_cd := 'SYAD';
			END IF;
		WHEN '4' THEN
			vs_payment_type_cd := 'ANCL';
		WHEN '21' THEN
			vs_payment_type_cd := 'ANCL';	
		ELSE
			vs_payment_type_cd := 'CHAC';
		END CASE;

		IF vs_payment_type_cd = 'SYAD' THEN
			IF li_linked_pymnt_id > 0 THEN
				SELECT payment_status_cd INTO ls_link_payment_status
					FROM cjams.tb_payment_status
				WHERE payment_id = li_linked_pymnt_id 
					AND delete_sw = 'N' ;

				IF ls_link_payment_status = '1639' THEN
					vs_payment_type_cd := 'RELS' ;
				ELSE
					vs_payment_type_cd := 'SYAD';
				END IF;
			END IF;
		END IF;

		-- 1099Amount & 1099Code
		ld_amount_1099 := NULL;
		ls_code_1099 := NULL;

		IF ls_REPORT_1099_SW = 'Y' THEN
			ld_amount_1099 := li_final_amount_no;

			IF ls_type_1099_cd = '1' THEN -- 1 - Rental (Code '3155')
				ls_code_1099 := 'MISC-01';
			ELSIF ls_type_1099_cd = '6' THEN -- 6 - Med Exp (Code '3156')
				ls_code_1099 := 'MISC-06';
			ELSIF ls_type_1099_cd = '7' THEN -- 7 - Misc. (Code '3157')
				ls_code_1099 := 'MISC-07';
			END IF;

		END IF;
		-- AccountType
		ls_account_type := 'Vendor';
		-- Approved
		ls_approved := 'Yes';
		-- ApprovedBy
		ls_approved_by := '300'; -- 100 (from MD CHESSIE), 200 (from CJAMS CW) and 300 (from CJAMS AS)
		-- Currency
		ls_currency := 'USD';
		-- Invoice
		ls_invoice := NULL;
		ls_invoice := RTRIM(LTRIM((li_payment_id::VARCHAR)));
		-- InvoiceDescription
		ls_invoice_desc := NULL;
		-- JournalDescription -- (see the below code after cursor statement)
		ls_journal_desc := NULL;
		-- PayorCompany
		ls_payor_company := NULL;
		ls_payor_company := 'N' || RTRIM(LTRIM(ls_county_cd));
		-- OffsetAccount
		ls_offset_account := NULL;
		ls_offset_account := RTRIM(LTRIM(ls_final_fiscal_category_cd)) ;
		-- OffsetAccountType
		ls_offset_account_type := 'Ledger';
		-- PostingProfile
		ls_posting_profile := 'APSTD';
		-- TermsOfPayment
		ls_terms_of_payment := 'N00';
		-- VendorAccount
		ls_vendoraccount := NULL;
		
		IF li_provider_id > 0 THEN
			ls_vendoraccount := 'CH' || RTRIM(LTRIM((li_provider_id::VARCHAR)));
		END IF;
		-- AddressCode
		ls_address_id_tx := NULL;
		IF li_provider_id > 0 THEN
			ls_address_id_tx := RTRIM(LTRIM(ll_address_id::VARCHAR));
		ELSE
			ls_address_id_tx := 'CH' || RTRIM(LTRIM((ls_childacc_id::VARCHAR))); --101119 - Set same as Vendor Account
			--ls_address_id_tx := 'CH' || RTRIM(LTRIM(li_client_id::VARCHAR)); --101119
		END IF;
	
		vs_payment_type_cd := COALESCE(vs_payment_type_cd,'0000');
		vs_message := '';
		vs_excep_message := '';
		ls_error_provname := 'p';
		ls_error_childname := 'c';

		-- Get Interface data    
		IF li_interface_record_id = 0 THEN
			vs_excep_message := 'Interface-Record-ID is missing; ' ;
			li_check := 0;
		END IF;

		IF ls_county_cd is null OR ls_county_cd = '' OR ls_county_cd = '99' THEN
			vs_excep_message := vs_excep_message ||'County/LDSS code is missing; ';
			li_check := 0;
		END IF;

		IF ls_payment_method_cd='0' OR ls_payment_method_cd = '' OR ls_payment_method_cd IS NULL THEN
			vs_excep_message := vs_excep_message || 'Payment Method Code is missing; ';
			li_check := 0;
		END IF;

		IF ls_payment_id = '0' OR ls_payment_id IS NULL OR ls_payment_id = '' THEN
			vs_excep_message := vs_excep_message || 'Payment ID is missing; ';
			li_check := 0;
		END IF;
		
		IF vs_child_disbursement = 'Y' THEN  
			ls_payee_nbr := (li_client_id::VARCHAR); 
		ELSE
			IF ls_payee_nbr ='0' OR ls_payee_nbr IS NULL OR ls_payee_nbr='' THEN
				vs_excep_message := vs_excep_message || 'Payee Number is missing; ';
				li_check := 0;
			END IF;
		END IF;

		IF vs_payee_short_nm ='0' OR vs_payee_short_nm IS NULL OR vs_payee_short_nm ='' THEN
			vs_excep_message := vs_excep_message || 'Provider/Payee Name is missing; ';
			li_check := 0;
			ls_error_provname := '';
		END IF;

		IF ls_vendor_nm ='0' OR ls_vendor_nm IS NULL OR ls_vendor_nm ='' THEN
			vs_excep_message := vs_excep_message || 'Vendor name is missing; ';
			li_check := 0;
		END IF;

		IF ls_address_1 ='0' OR ls_address_1 IS NULL OR ls_address_1 ='' THEN
			vs_excep_message := vs_excep_message ||vs_exc_adr_type || 'line 1 is missing; ';
			li_check := 0;
		END IF;

		IF ls_adr_city_nm ='0' OR ls_adr_city_nm IS NULL OR ls_adr_city_nm ='' THEN
			vs_excep_message := vs_excep_message ||vs_exc_adr_type|| 'city name is missing; ';
			li_check := 0;
		END IF;

		IF ls_adr_state_cd ='0' OR ls_adr_state_cd IS NULL OR ls_adr_state_cd ='' THEN
			vs_excep_message := vs_excep_message ||vs_exc_adr_type || 'state code is missing; ';
			li_check := 0;
		END IF;

		IF li_adr_zip5_no = 0 OR li_adr_zip5_no IS NULL THEN
			vs_excep_message := vs_excep_message ||vs_exc_adr_type || 'zip code is missing; ';
			li_check := 0;
		END IF;

		IF ls_prov_tax_type_cd ='0' OR ls_prov_tax_type_cd IS NULL OR ls_prov_tax_type_cd ='' THEN
			vs_excep_message := vs_excep_message || 'Prov Tax Type code is missing; ';
			li_check := 0;
		END IF;

		IF ls_tax_id_no ='0' OR ls_tax_id_no IS NULL OR ls_tax_id_no = '' THEN
			vs_excep_message := vs_excep_message || 'Tax ID No is missing; ';
			li_check := 0;
		END IF;

		IF ls_final_fiscal_category_cd ='0' OR ls_final_fiscal_category_cd IS NULL OR ls_final_fiscal_category_cd ='' THEN
			vs_excep_message := vs_excep_message || 'Final Fiscal Category code is missing; ';
			li_check := 0;
		END IF;

		IF ls_REPORT_1099_SW ='0' OR ls_REPORT_1099_SW IS NULL OR ls_REPORT_1099_SW ='' THEN
			vs_excep_message := vs_excep_message || 'REPORT 1099 SW is missing; ';
			li_check := 0;
		END IF;

		IF li_final_amount_no = 0 OR li_final_amount_no IS NULL THEN           -- #15672
			vs_excep_message := vs_excep_message || 'Final Amount is missing; ';
			li_check := 0;
		END IF;

		IF RTRIM(LTRIM((ld_payment_dt ::varChar))) ='01/01/1900' THEN
			vs_excep_message := vs_excep_message || 'Payment Date is missing; ';
			li_check := 0;
		END IF;

		IF RTRIM(LTRIM((ld_final_service_dt::VARChar)))= '01/01/1900'  THEN
			vs_excep_message := vs_excep_message || 'Final Service Date is missing; ';
			li_check := 0;
		END IF;

		IF ls_client_nm ='0' OR ls_client_nm IS NULL OR ls_client_nm ='' THEN
			vs_excep_message := vs_excep_message || 'Client Name is missing; ';
			li_check := 0;
			ls_error_childname := '';
		END IF;

		IF vs_payment_type_cd ='0' OR vs_payment_type_cd IS NULL OR vs_payment_type_cd ='' THEN
			vs_excep_message := vs_excep_message || 'Payment Type code is missing; ';
			li_check := 0;
		END IF;

		vl_error_logged := 0;
		vs_excep_message1 := '';
		IF ls_county_cd <> '99' THEN
			vs_excep_message1 := 'County Name: ' || ls_county_name || '; ';
		END IF;

		IF ls_error_provname <> '' THEN
			vs_excep_message1 := vs_excep_message1 ||'Provider/Payee Name: ' || vs_payee_short_nm || '; ';
		END IF;

		IF ls_error_childname <> '' THEN
			vs_excep_message1 :=  vs_excep_message1 ||'Client Name: ' || ls_client_nm || '; ';
		END IF;

		vs_excep_message1 := Substring((vs_excep_message1),1,LENGTH(vs_excep_message1)-2) ||' - ' ;
		IF li_check = 0 AND vs_excep_message <> '' AND vs_excep_message IS NOT NULL THEN
			vs_excep_message :=  vs_excep_message1 || vs_excep_message;
			vl_error_logged := 1;
			RAISE NOTICE 'Error_Message vs_excep_message >> %',vs_excep_message;
			
			BEGIN
				VL_OUTPUT_SQLCODE := '00000';  
				INSERT INTO interfaceserrorlog
					( 	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode,
						errorsqlcode, errordescription, payment_id,	provider_id, county_cd,
						client_id, payment_amount
					)
				VALUES 
					( 	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0',
						vl_output_sqlcode, vs_excep_message, li_payment_id, li_provider_id, ls_county,
						li_client_id, li_final_amount_no
					);


				EXCEPTION WHEN OTHERS THEN
					vs_message := vs_message || '. Insert failed into interfaceserrorlog '||SQLERRM  ;
					vl_output_sqlcode := SQLSTATE;
					INSERT INTO interfaceserrorlog
						(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
							errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
							client_id,  payment_amount
						)
					VALUES 
						( 	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
							vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
							li_client_id , li_final_amount_no
						);

			END;

		END IF;
	
		IF li_check > 0 THEN
			vs_payee_short_nm := Substring(vs_payee_short_nm, 1, 40); 
			ls_vendor_nm := Substring(ls_vendor_nm, 1, 40); 
			vl_output_sqlcode := '00000';

			SELECT NEXTVAL('as_sq_d365_interfaces') INTO li_interface_record_id ;
			BEGIN
				INSERT INTO cjams.as_tb_d365_interfaces
				(
					interface_record_id,
					ldss_nm,
					payment_method_cd,
					payment_id,
					payee_nbr,
					payee_nm,
					payee_alpha_sort_nm,
					adr_line_1,
					adr_line_2,
					adr_city_nm,
					adr_state_cd,
					adr_zip5_no,
					phone_tx,
					taxpayer_type_cd,
					taxpayer_id,
					budget_cd,
					ind_1099_sw,
					type_1099_sw,
					invoice_nbr_tx,
					payment_amt,
					payment_approval_dt,
					payment_service_dt,
					client_name,
					create_ts,
					create_user_id,
					update_ts,
					update_user_id,
					delete_sw,
					payment_type_cd,
					payment_detail_id,
					amount_1099,
					code_1099,
					account_type,
					address_id,
					approved,
					approved_by,
					currency,
					invoice,
					invoice_desc,
					journal_desc,
					payor_company,
					offset_account,
					offset_account_type,
					posting_profile,
					terms_of_payment,
					vendoraccount
				)
				SELECT
					li_interface_record_id,
					ls_county_cd,
					ls_payment_method_cd,
					ls_payment_id,
					ls_payee_nbr,
					vs_payee_short_nm,
					ls_vendor_nm,
					ls_address_1,
					UPPER(COALESCE(SUBSTRING(RTRIM(LTRIM(ls_address_2)),1,li_address_2),LPAD('',40))),
					ls_adr_city_nm,
					UPPER(ls_adr_state_cd),
					ls_zip_code,
					ls_phone_tx,
					ls_prov_tax_type_cd,
					ls_tax_id_no,
					ls_final_fiscal_category_cd,
					ls_REPORT_1099_SW,
					ls_type_1099_cd,
					ls_store_receipt_id,
					li_final_amount_no,
					ld_payment_dt ,
					ld_final_service_dt,
					ls_client_nm,
					CURRENT_TIMESTAMP,
					vs_user_id,
					CURRENT_TIMESTAMP,
					vs_user_id,
					'N',
					vs_payment_type_cd,
					li_payment_detail_id,
					ld_amount_1099,
					ls_code_1099,
					ls_account_type,
					ls_address_id_tx,
					ls_approved,
					ls_approved_by,
					ls_currency,
					ls_invoice,
					ls_invoice_desc,
					ls_journal_desc,
					ls_payor_company,
					ls_offset_account,
					ls_offset_account_type,
					ls_posting_profile,
					ls_terms_of_payment,
					ls_vendoraccount
				;
				
				EXCEPTION WHEN OTHERS THEN
					vs_message := 'INSERT FAILED INTO as_tb_d365_interfaces  '||SQLERRM  ;
					vl_output_sqlcode := SQLSTATE;
					
					INSERT INTO interfaceserrorlog
						(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
							errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
							client_id,  payment_amount
						)
					VALUES 
						(	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
							vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
							li_client_id , li_final_amount_no
						);

			END;

			BEGIN
				update cjams.tb_payment_status
				set payment_status_cd = '1636',
					payment_status_dt = vts_current_run_ts::DATE,
					update_ts = CURRENT_TIMESTAMP
				WHERE payment_status_cd = '1634'
					AND payment_id = li_payment_id
					AND delete_sw = 'N';

				EXCEPTION WHEN OTHERS THEN
					vs_message := 'Error in updating Payment Status  '||SQLERRM  ;
					vl_output_sqlcode := SQLSTATE;
					INSERT INTO interfaceserrorlog
						(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
							errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
							client_id,  payment_amount
						)
					VALUES 
						(	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
							vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
							li_client_id , li_final_amount_no
						);
			END;
		END IF; -- li check  >0

		li_check := 0;
		vs_child_disbursement := 'n';
		ls_person_nm := '';
		ls_org_nm := '';
		vs_payee_short_nm := '';
		vs_message :=  '';

		vl_interface_rowcount := vl_interface_rowcount - 1;
		vs_payment_type_cd := '0000';
		vl_payment_count := vl_payment_count - 1 ;
	END LOOP;
	CLOSE PAYMENT_CUR;

	-- To update JOURNAL_DESC as unique Timestamp on each file (system adjustments & Ancillary)
	-- Ancillary & other payments
	BEGIN
		update cjams.as_tb_d365_interfaces
			set journal_desc = 'MD CJAMS ' || current_timestamp
		where interface_record_id IN ( 	SELECT d.interface_record_id
												FROM cjams.as_tb_d365_interfaces d,
													cjams.tb_payment_header ph
											WHERE RTRIM(d.payment_id)::INTEGER = ph.payment_id
												AND (ph.payment_type_cd <> '3294' 
														OR (ph.payment_type_cd = '3294' AND ph.manual_sw = 'Y'))
			);
	EXCEPTION WHEN OTHERS THEN
		vs_message := 'Error in updating as_tb_d365_interfaces --> JOURNAL_DESC (Ancillary)  '||SQLERRM  ;
		vl_output_sqlcode := SQLSTATE;
		INSERT INTO interfaceserrorlog
			(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
				errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
				client_id,  payment_amount
			)
		VALUES 
			(	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
				vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
				li_client_id , li_final_amount_no
			);

	END;

	-- System Adjustments
	BEGIN
		UPDATE cjams.as_tb_d365_interfaces
			SET journal_desc = 'MD CJAMS ' || CURRENT_TIMESTAMP
		WHERE interface_record_id IN ( 	SELECT d.interface_record_id
											FROM cjams.as_tb_d365_interfaces d,
												cjams.tb_payment_header ph
											WHERE RTRIM(d.payment_id)::INTEGER = ph.payment_id
												AND (ph.payment_type_cd = '3294' 
												AND (ph.manual_sw IS NULL OR ph.manual_sw <> 'Y'))
										 );
		EXCEPTION WHEN OTHERS THEN
			vs_message := 'Error in updating as_tb_d365_interfaces --> JOURNAL_DESC (System Adjustments)  '||SQLERRM  ;
			vl_output_sqlcode := SQLSTATE;
			INSERT INTO interfaceserrorlog
				(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
					errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
					client_id,  payment_amount
				)
			VALUES 
				(	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
					vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
					li_client_id , li_final_amount_no
				);

	END;

	BEGIN
		INSERT INTO interfacesruntimeslog
			(	interfaceid,
				currentruntimestamp,
				previousruntimestamp,
				batchnumber,
				insertedon,
				insertedby,
				updatedon,
				updatedby,
				activeflag  
			)
		SELECT
			vs_log_procedure_nm,
			vts_current_run_ts,
			vts_previous_run_ts,
			'000',
			CURRENT_TIMESTAMP,
			vs_user_id,
			CURRENT_TIMESTAMP,
			vs_user_id,
			1
			;

		EXCEPTION WHEN OTHERS THEN
			vs_message := 'INSERT INTO INTERFACESRUNTIMESLOG FAILED  '||SQLERRM  ;
			vl_output_sqlcode := SQLSTATE;
			INSERT INTO interfaceserrorlog
				(	interfaceid, currentruntimestamp, batchnumber, errorlineno, errorcode, 
					errorsqlcode, errordescription, payment_id, provider_id, county_cd, 
					client_id,  payment_amount
				)
			VALUES 
				(	vs_log_procedure_nm, current_timestamp, '000', li_payment_id, '0', 
					vl_output_sqlcode, vs_message, li_payment_id, li_provider_id, ls_county, 
					li_client_id , li_final_amount_no
				);

	END;

	IF vl_output_sqlcode = '00000' then
		vs_message := 'Adult Services Ancillary Payments Interface with D365 run was successful';
		a := vts_current_run_ts;
		b :=  vts_previous_run_ts;
	END IF;

END ;
$function$
;
