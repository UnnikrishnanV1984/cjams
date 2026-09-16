CREATE OR REPLACE FUNCTION cjams.sp_payment_detail_insert(al_placement_id bigint, al_payment_header_id bigint, al_service_id bigint, ad_start_dt date, ad_end_dt date, adc_gross_amount numeric, al_unit_no integer, as_unit_type character varying, adc_per_diem_rate numeric, as_type_cd character, as_rate_type character varying, al_linked_pymnt_hdr_id bigint, al_reference_payment_detail_id bigint, vs_change_type character varying, OUT al_sqlcode integer, OUT as_error character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Description: To Create Payment Detail data.

-- Revisions:
-- 09/25/2020 Vineet Tirodkar - Changes to trim and compare Eligibility Status Code - CDM-4684
-- 01/31/2022 Vineet Tirodkar - Changes for new Placement Structure 525 - CfE Placement (CIDM-4204/B-123939)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------------------------------
DECLARE vl_pay_detail_id BIGINT DEFAULT 0;
	vl_pay_category_id BIGINT DEFAULT 0;
	vl_elig_count_ind INT DEFAULT 0;

	vs_pay_detail_id VARCHAR(50) DEFAULT 'SQ_PAYMENT_DETAIL';
	vs_pay_category_id VARCHAR(50) DEFAULT 'SQ_PAYMENT_CATEGORY';
	vs_elig_type_cd VARCHAR(5) DEFAULT '2931';
	vl_count INT DEFAULT 0;
	vl_sqlcode INT DEFAULT 0;

	vl_placement_structure_id BIGINT DEFAULT 0;
	vl_rate_structure_id BIGINT DEFAULT 0;
	vl_org_id BIGINT DEFAULT 0;
	vl_event_id	BIGINT; 
	vl_cnt INTEGER;

	vl_client_id BIGINT DEFAULT 0;
	vl_case_id BIGINT DEFAULT 0;

	vs_county_cd VARCHAR(5) DEFAULT NULL;
	vs_fiscalCat VARCHAR(5) DEFAULT NULL;
	vs_entity_type_cd VARCHAR(5);
	vs_payment_type_cd VARCHAR(5) DEFAULT NULL;

	vs_insert_flag CHAR(1) DEFAULT NULL;
	vl_age_of_client INT DEFAULT 0;

	vd_previous_month_start_dt DATE;
	vd_previous_month_end_dt DATE;
	vd_current_month_end_dt DATE;

	vs_note_tx VARCHAR(500);

	vs_lic_agency VARCHAR(5);
	vs_lic_agency_cd VARCHAR(5);
	vl_provider_id BIGINT DEFAULT 0;
	vl_program_id BIGINT DEFAULT 0;	
	SQLCODE INTEGER DEFAULT 0;
	vs_message_text VARCHAR(3000) DEFAULT '';
	vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_PAYMENT_DETAIL_INSERT';
BEGIN

	--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text = MESSAGE_TEXT;--
		EXCEPTION WHEN OTHERS THEN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
		vl_sqlcode := -1 ;--
		as_error := COALESCE(as_error ,'') || ( CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
		as_error := COALESCE(as_error ,'') || '::RO ' || 'Placement id/ Payment id' || ' :: ' || COALESCE((al_placement_id)::character varying,'') || '/' || COALESCE((al_payment_header_id)::character varying,'');--
		as_error := as_error || COALESCE(vs_message_text ,'');--
	END;--

	vs_insert_flag := 'N';--

	IF al_linked_pymnt_hdr_id = 0 THEN
		al_linked_pymnt_hdr_id := NULL;--
		al_reference_payment_detail_id := NULL;--
	END IF;--

	-- get the last month start date and end date
	SELECT (date_trunc('month', now()) - interval '1 month')::date,
		   (date_trunc('month', now())::date - 1)::date,
		   ((date_trunc('month', now()) + interval '1 month')- interval '1 Day')::date
	INTO    vd_previous_month_start_dt,
			vd_previous_month_end_dt,
			vd_current_month_end_dt;
	--FROM sysibm.sysdummy1;--

	vs_lic_agency := ''; -- INITIAL VALUE

	IF as_type_cd = 'G' THEN -- subsidized guardianship
	   SELECT CLIENT_ID, f_prim_county (CASE_ID,'NULL',CLIENT_ID,'CLIENT'), CASE_ID
			INTO vl_client_id,vs_county_cd,vl_case_id
		  FROM TB_GUARDIAN_SUBSIDY
	   WHERE GUARDIAN_SUBSIDY_ID = al_placement_id;--

	   vl_placement_structure_id := 503; -- ADOPTION SUBSIDY
	   vs_elig_type_cd := '2935';  -- SUB G (CIS-18887)

	ELSE

		IF as_type_cd = 'A' THEN  -- adoption subsidy
			SELECT TA.CLIENT_ID, f_prim_county (TA.CASE_ID,'NULL',TA.CLIENT_ID,'CLIENT'), TA.CASE_ID
			 INTO vl_client_id,vs_county_cd,vl_case_id
			  FROM TB_ADOPTION TA
			WHERE TA.ADOPTION_ID = al_placement_id;--

			vl_placement_structure_id := 501; -- ADOPTION SUBSIDY
			vs_elig_type_cd := '2934';--
		ELSE
			SELECT P.PLACEMENT_STRUCTURE_ID,
				   P.CLIENT_ID,
				   f_prim_county (P.CASE_ID,'NULL',P.CLIENT_ID,'CLIENT'),
				   P.CASE_ID,
				   P.RATE_STRUCTURE_ID,
				   P.PROVIDER_ORGANIZATION_ID,
				   P.PROVIDER_ID,
				   P.CONTRACT_PROGRAM_ID
			   INTO vl_placement_structure_id,
					vl_client_id,
					vs_county_cd,
					vl_case_id,
					vl_rate_structure_id,
					vl_org_id,
					vl_provider_id,
					vl_program_id 	
			  FROM TB_PLACEMENT P
			WHERE  P.PLACEMENT_ID = al_placement_id;--

			IF vl_org_id IS NULL OR vl_org_id = 0 THEN -- chessie_mask PROVIDER
				vl_placement_structure_id :=  vl_rate_structure_id;--
			END IF;--

			-- CIS-19489
			IF vl_program_id is NULL THEN
			   vl_program_id := 0;--
			END IF;--

			IF vl_program_id > 0  AND ad_start_dt > DATE('2010-01-31') THEN
				-- SET vs_lic_agency_cd = NULL; -- INITIAL VALUE

				SELECT LTRIM(RTRIM(LICENSING_AGENCY_CD))
					INTO vs_lic_agency_cd
				FROM TB_PROVIDER_LICENSING
				WHERE SITE_ID = vl_provider_id
					AND PROVIDER_ID = vl_org_id
					AND LICENSE_ISSUE_DT <= ad_start_dt
					AND LICENSE_EXPIRY_DT >= ad_end_dt
					AND DELETE_SW = 'N'
				ORDER BY LICENSE_APPLICATION_ID DESC
				FETCH FIRST ROW ONLY ;--

				IF vs_lic_agency_cd is NULL THEN
					vs_lic_agency_cd := '';--
				END IF;--
				IF vs_lic_agency_cd = '8147' THEN  -- OOS
					vs_lic_agency := 'OOS';--
				END IF;--
			END IF;--
		END IF;--
	END IF;--

	IF al_service_id = 71 THEN -- EMERGENCY BED RETAINER FEE
		vs_county_cd := NULL; -- INITIAL VALUE
		vl_placement_structure_id := 71;--
		vl_client_id := NULL;--
		vl_case_id := NULL;--

		SELECT COUNTY_CD INTO vs_county_cd
			FROM TB_PROVIDER,TB_PAYMENT_HEADER
		WHERE TB_PROVIDER.PROVIDER_ID = TB_PAYMENT_HEADER.PROVIDER_ID AND
			  TB_PAYMENT_HEADER.PAYMENT_ID = al_payment_header_id;--
	END IF;--

	-- Verify Client is Eligible Reimbursable or not
	SELECT COUNT(1)
		INTO vl_elig_count_ind
	FROM TB_CLIENT_ELIGIBILITY
	WHERE CLIENT_ID = vl_client_id 
		AND CASE_ID = vl_case_id 
		AND btrim(ELIGIBILITY_STATUS_CD) = '2913' -- Eligible Reimbursable
		AND btrim(ELIGIBILITY_TYPE_CD) = vs_elig_type_cd 
		AND DELETE_SW = 'N' 
		AND start_dt <= ad_end_dt and (end_dt >= ad_start_dt or end_dt is null);

	-- commented CIS-18887
	--IF as_type_cd = 'G' THEN
	--    SET vl_elig_count_ind = 0 ; -- ALWAYS STATE FUNDS
	--END IF;--
	-- CIS 18887

	-- Get Client's Age
	-- PRJ-03767 - Calculate Age as of Service End Date 
	vl_age_of_client := 0; -- INITIAL VALUE
	SELECT F_AGE(dob::DATE, ad_end_dt)
		INTO vl_age_of_client
	FROM person
	WHERE cjamspid = vl_client_id
		AND activeflag = 1;--

	IF vl_age_of_client IS NULL THEN
	   vl_age_of_client := 0;--
	END IF;--

	-- Get the fiscal category code
	IF vl_placement_structure_id = 1 AND vl_age_of_client >= 16 AND vl_age_of_client <= 18 THEN
	   -- CIS-19489
	   IF ad_end_dt <= DATE('2010-01-31') THEN
		 IF vl_elig_count_ind > 0 THEN -- IV-E Eligible Client
			vs_fiscalCat := '5117'; -- SILA Housing (16yr - 18yr) IV-E Eligible
		 ELSE -- Not IV-E Eligible Client
			vs_fiscalCat := '5118'; -- SILA Housing (16yr - 18yr) Non IV-E Eligible
		 END IF;--
	   ELSE
		 IF vs_lic_agency = 'OOS' AND vl_elig_count_ind > 0 THEN -- IV-E Eligible Client
			vs_fiscalCat := '2178'; -- Out of State Group Care
		 ELSEIF vs_lic_agency = 'OOS' THEN
			vs_fiscalCat := '7178'; -- Out of State Group Care
		 ELSEIF vl_elig_count_ind > 0 THEN  -- IV-E Eligible Client
			vs_fiscalCat := '2177'; -- In State Group Care
		 ELSE -- Not IV-E Eligible Client
			vs_fiscalCat := '7177'; -- In State Group Care
		 END IF;--
	   END IF;--
	   -- CIS-19489
	ELSEIF vl_placement_structure_id = 1 AND vl_age_of_client > 18 AND vl_age_of_client <= 21 then
	   -- CIS-19489
	   IF ad_end_dt <= DATE('2010-01-31') THEN
		  vs_fiscalCat := '5119'; -- SILA Housing (18yr - 21yr) State's custody
	   ELSE
		  IF vs_lic_agency = 'OOS' THEN
			vs_fiscalCat := '7178'; -- Out of State Group Care
		  ELSE
			vs_fiscalCat := '7177'; -- In State Group Care	
		  END IF;--
	   END IF;--
	   -- CIS-19489
	ELSEIF vl_placement_structure_id = 525 THEN -- (CIDM-4204/B-123939)
		vs_fiscalCat = '4185'; -- 'Differential Board Rate' (CfE)
	ELSEIF vl_elig_count_ind > 0 THEN -- IV-E Eligible Client
		IF vl_placement_structure_id = 13 THEN -- CIS-17815 	
			SELECT FISCAL_CATEGORY_CD
				INTO vs_fiscalCat	
			FROM TB_PLACEMENT_STRU_CATEGORY_LINK, TB_FISCAL_CATEGORY_MASTER
			WHERE TB_PLACEMENT_STRU_CATEGORY_LINK.SERVICE_ID = al_service_id AND
				TB_PLACEMENT_STRU_CATEGORY_LINK.FISCAL_CATEGORY_ID = TB_FISCAL_CATEGORY_MASTER.FISCAL_CATEGORY_ID AND
				TB_FISCAL_CATEGORY_MASTER.ELIGIBILITY_CD = '3951' AND
				TB_PLACEMENT_STRU_CATEGORY_LINK.DELETE_SW = 'N' AND
				TB_FISCAL_CATEGORY_MASTER.DELETE_SW = 'N' ;--
		ELSE
			-- CIS-19489
			IF vs_lic_agency = 'OOS' AND ad_start_dt > DATE('2010-01-31') THEN
				vs_fiscalCat := '2178'; -- Out of State Group Care
			ELSE
				SELECT FISCAL_CATEGORY_CD
					INTO vs_fiscalCat	
				FROM TB_PLACEMENT_STRU_CATEGORY_LINK, TB_FISCAL_CATEGORY_MASTER
				WHERE TB_PLACEMENT_STRU_CATEGORY_LINK.SERVICE_ID = vl_placement_structure_id AND
					TB_PLACEMENT_STRU_CATEGORY_LINK.FISCAL_CATEGORY_ID = TB_FISCAL_CATEGORY_MASTER.FISCAL_CATEGORY_ID AND
					TB_FISCAL_CATEGORY_MASTER.ELIGIBILITY_CD = '3951' AND
					TB_PLACEMENT_STRU_CATEGORY_LINK.DELETE_SW = 'N' AND
					TB_FISCAL_CATEGORY_MASTER.DELETE_SW = 'N' ;--
			END IF;--
		END IF;--
	ELSEIF vl_elig_count_ind = 0 THEN -- Not IV-E Eligible Client
		IF vl_placement_structure_id = 13 THEN -- CIS-17815	
		   SELECT FISCAL_CATEGORY_CD
			   INTO vs_fiscalCat	
			 FROM TB_PLACEMENT_STRU_CATEGORY_LINK, TB_FISCAL_CATEGORY_MASTER
		   WHERE TB_PLACEMENT_STRU_CATEGORY_LINK.SERVICE_ID = al_service_id AND
				 TB_PLACEMENT_STRU_CATEGORY_LINK.FISCAL_CATEGORY_ID = TB_FISCAL_CATEGORY_MASTER.FISCAL_CATEGORY_ID AND
				 TB_FISCAL_CATEGORY_MASTER.ELIGIBILITY_CD = '3952' AND
				 TB_PLACEMENT_STRU_CATEGORY_LINK.DELETE_SW = 'N' AND
				 TB_FISCAL_CATEGORY_MASTER.DELETE_SW = 'N' ;--
		ELSE
			-- CIS-19489
			IF vs_lic_agency = 'OOS' AND ad_start_dt > DATE('2010-01-31') THEN
			   vs_fiscalCat := '7178'; -- Out of State Group Care
			ELSE
			  SELECT FISCAL_CATEGORY_CD
				 INTO vs_fiscalCat	
			   FROM TB_PLACEMENT_STRU_CATEGORY_LINK, TB_FISCAL_CATEGORY_MASTER
			  WHERE TB_PLACEMENT_STRU_CATEGORY_LINK.SERVICE_ID = vl_placement_structure_id AND
				 TB_PLACEMENT_STRU_CATEGORY_LINK.FISCAL_CATEGORY_ID = TB_FISCAL_CATEGORY_MASTER.FISCAL_CATEGORY_ID AND
				 TB_FISCAL_CATEGORY_MASTER.ELIGIBILITY_CD = '3952' AND
				 TB_PLACEMENT_STRU_CATEGORY_LINK.DELETE_SW = 'N' AND
				 TB_FISCAL_CATEGORY_MASTER.DELETE_SW = 'N' ;--
			END IF;--
		END IF;--
	END IF;--
	--fiscal category code check end

	IF as_type_cd = 'F' THEN      -- FINAL PAYMENT
		IF al_service_id = 71 THEN -- EMERGENCY BED RETAINER FEE
			SELECT COUNT(*)
				INTO vl_count
			FROM TB_PAYMENT_DETAIL
			WHERE PAYMENT_ID = al_payment_header_id AND
			   DRAFT_RATE_TYPE_CD = as_rate_type AND
			   DELETE_SW = 'N';--
		ELSE
		   IF vl_placement_structure_id = 13 THEN -- CIS-17815
			   SELECT COUNT(*)
				   INTO vl_count
				FROM TB_PAYMENT_DETAIL
				   WHERE PLACEMENT_ID = al_placement_id
					 AND PAYMENT_ID = al_payment_header_id
					 AND DRAFT_RATE_TYPE_CD = as_rate_type
					 AND DELETE_SW = 'N'
					 AND DRAFT_SERVICE_ID = al_service_id ;--
			ELSE
			   SELECT COUNT(*)
				   INTO vl_count
				FROM TB_PAYMENT_DETAIL
				   WHERE PLACEMENT_ID = al_placement_id AND
					 PAYMENT_ID = al_payment_header_id AND
					 DRAFT_RATE_TYPE_CD = as_rate_type AND
					 DELETE_SW = 'N';--
			END IF;--
		END IF;--

		IF vl_count > 0 THEN -- RECORD ALREADY EXIST NEED TO UPDATE THE FINAL INFO
		   IF al_service_id = 71 THEN -- EMERGENCY BED RETAINER FEE
				UPDATE
					TB_PAYMENT_DETAIL
				SET FINAL_SERVICE_ID = vl_placement_structure_id,
					FINAL_SERVICE_START_DT = ad_start_dt,
					FINAL_SERVICE_END_DT = ad_end_dt,
					FINAL_UNITS_NO = al_unit_no,
					FINAL_AMOUNT_NO = adc_gross_amount,
					FINAL_RATE_TYPE_CD = as_rate_type,
					FINAL_UNIT_RATE_AMT = adc_per_diem_rate,
					FINAL_UNIT_TYPE = as_unit_type,
					FINAL_FISCAL_CATEGORY_CD = vs_fiscalCat,
					UPDATE_TS = CURRENT_TIMESTAMP
				WHERE PAYMENT_ID = al_payment_header_id AND
					DRAFT_RATE_TYPE_CD = as_rate_type AND
					DELETE_SW = 'N';--

				al_sqlcode := SQLCODE;--
				IF al_sqlcode < 0  THEN
					as_error := 'Payment Detail: Error in updating FINAL PAYMENT Detail record (EMERGENCY BED RETAINER FEE)';--
				END IF ;--
			ELSEIF 	vl_placement_structure_id = 13 THEN -- CIS-17815
				IF al_service_id = 10 THEN
					vs_note_tx := 'This child is in ''Emergency Foster Home Care'' for more than 60 days; CHESSIE has generated payments as per ''Regular Foster Care'' rate.';--
				ELSE
					vs_note_tx := NULL;--
				END IF;--

				UPDATE
					TB_PAYMENT_DETAIL
				SET FINAL_SERVICE_ID = al_service_id,
					FINAL_SERVICE_START_DT = ad_start_dt,
					FINAL_SERVICE_END_DT = ad_end_dt,
					FINAL_UNITS_NO = al_unit_no,
					FINAL_AMOUNT_NO = adc_gross_amount,
					FINAL_RATE_TYPE_CD = as_rate_type,
					FINAL_UNIT_RATE_AMT = adc_per_diem_rate,
					FINAL_UNIT_TYPE = as_unit_type,
					FINAL_FISCAL_CATEGORY_CD = vs_fiscalCat,
					UPDATE_TS = CURRENT_TIMESTAMP,
					NOTES_TX = vs_note_tx
				WHERE PLACEMENT_ID =  al_placement_id
					AND PAYMENT_ID = al_payment_header_id
					AND DRAFT_RATE_TYPE_CD = as_rate_type
					AND DELETE_SW = 'N'
					AND DRAFT_SERVICE_ID = al_service_id ;--
		
				al_sqlcode := SQLCODE;--
				IF al_sqlcode < 0  THEN
					as_error := 'Payment Detail: Error in updating FINAL PAYMENT Detail record (Emergency Foster Home Care)';--
				END IF ;--
			ELSE
				UPDATE
					TB_PAYMENT_DETAIL
				 SET FINAL_SERVICE_ID = vl_placement_structure_id,
					FINAL_SERVICE_START_DT = ad_start_dt,
					FINAL_SERVICE_END_DT = ad_end_dt,
					FINAL_UNITS_NO = al_unit_no,
					FINAL_AMOUNT_NO = adc_gross_amount,
					FINAL_RATE_TYPE_CD = as_rate_type,
					FINAL_UNIT_RATE_AMT = adc_per_diem_rate,
					FINAL_UNIT_TYPE = as_unit_type,
					FINAL_FISCAL_CATEGORY_CD = vs_fiscalCat,
					UPDATE_TS = CURRENT_TIMESTAMP
				WHERE PLACEMENT_ID =  al_placement_id AND
					PAYMENT_ID = al_payment_header_id AND
					DRAFT_RATE_TYPE_CD = as_rate_type AND
					DELETE_SW = 'N';--

				al_sqlcode := SQLCODE;--
				IF al_sqlcode < 0  THEN
					as_error := 'Payment Detail: Error in updating FINAL PAYMENT Detail record';--
				END IF ;--
			END IF;--
		ELSE
			vs_insert_flag := 'Y';--
			-- generating payment detail id
			--SELECT CHESSIE_MASK_FIN.sp_nextid (vs_pay_detail_id, vl_pay_detail_id);--
			--SELECT al_next_value from  sp_nextid( vs_pay_detail_id) into vl_pay_detail_id;
			SELECT NEXTVAL('SQ_PAYMENT_DETAIL') into vl_pay_detail_id;	
			RAISE NOTICE '%  final payment details temp insert', as_type_cd;
			
			IF vl_placement_structure_id = 13 THEN -- CIS-17815
				IF al_service_id = 10 THEN
					vs_note_tx := 'This child is in ''Emergency Foster Home Care'' for more than 60 days; CHESSIE has generated payments as per ''Regular Foster Care'' rate.';--
				ELSE
					vs_note_tx := NULL;--
				END IF;--
    	
				INSERT INTO
				TB_PAYMENT_DETAIL
				(
				   PAYMENT_DETAIL_ID,              PAYMENT_ID,
				   COUNTY_CD,                      FINAL_AMOUNT_NO,
				   CLIENT_ID,                      FINAL_SERVICE_ID,
				   FINAL_SERVICE_START_DT,         FINAL_SERVICE_END_DT,
				   FINAL_UNITS_NO,                 FINAL_UNIT_TYPE,
				   FINAL_RATE_TYPE_CD,
				   PLACEMENT_ID,                   FINAL_UNIT_RATE_AMT,
				   CREATE_TS,                      CREATE_USER_ID,
				   UPDATE_TS,                      UPDATE_USER_ID,
				   DELETE_SW,                      FINAL_FISCAL_CATEGORY_CD,
				   CASE_ID,
				   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID ,
				   NOTES_TX
				)
				 VALUES
				(
				   vl_pay_detail_id,            al_payment_header_id,
				   vs_county_cd,				
					adc_gross_amount,
				   vl_client_id,                al_service_id,
				   ad_start_dt,                 ad_end_dt,
				   al_unit_no,                  as_unit_type,
				   as_rate_type,
				   al_placement_id,             adc_per_diem_rate,
				   CURRENT_TIMESTAMP,           'finance',
				   CURRENT_TIMESTAMP,           'finance',
				   'N',                         vs_fiscalCat,
				   vl_case_id,
				   al_reference_payment_detail_id, al_linked_pymnt_hdr_id,
				   vs_note_tx )  ;--
		
			   al_sqlcode := SQLCODE;--
			   IF al_sqlcode <> 0  THEN
				  as_error := 'Payment Detail: Error in inserting FINAL PAYMENT Detail record (Emergency Foster Home Care)';--
			   END IF;--
			ELSE
				INSERT INTO
				TB_PAYMENT_DETAIL
				(
				   PAYMENT_DETAIL_ID,              PAYMENT_ID,
				   COUNTY_CD,                      FINAL_AMOUNT_NO,
				   CLIENT_ID,                      FINAL_SERVICE_ID,
				   FINAL_SERVICE_START_DT,         FINAL_SERVICE_END_DT,
				   FINAL_UNITS_NO,                 FINAL_UNIT_TYPE,
				   FINAL_RATE_TYPE_CD,
				   PLACEMENT_ID,                   FINAL_UNIT_RATE_AMT,
				   CREATE_TS,                      CREATE_USER_ID,
				   UPDATE_TS,                      UPDATE_USER_ID,
				   DELETE_SW,                      FINAL_FISCAL_CATEGORY_CD,
				   CASE_ID,
				   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID
				)
				 VALUES
				(
				   vl_pay_detail_id,            al_payment_header_id,
				   vs_county_cd,				  
					adc_gross_amount,
				   vl_client_id,                vl_placement_structure_id,
				   ad_start_dt,                 ad_end_dt,
				   al_unit_no,                  as_unit_type,
				   as_rate_type,
				   al_placement_id,             adc_per_diem_rate,
				   CURRENT_TIMESTAMP,           'finance',
				   CURRENT_TIMESTAMP,           'finance',
				   'N',                         vs_fiscalCat,
				   vl_case_id,
				   al_reference_payment_detail_id, al_linked_pymnt_hdr_id )  ;--

					al_sqlcode := SQLCODE;--
					IF al_sqlcode <> 0  THEN
						as_error := 'Payment Detail: Error in inserting FINAL PAYMENT Detail record';--
					END IF;--
			END IF;--
		END IF;--
	END IF;--

	IF as_type_cd = 'D' THEN  -- DRAFT
		RAISE NOTICE '%  draft payment details temp insert', as_type_cd;
		vs_insert_flag := 'Y';--
		-- generating payment detail id
		--SELECT CHESSIE_MASK_FIN.sp_nextid (vs_pay_detail_id, vl_pay_detail_id);--
		--SELECT al_next_value from  sp_nextid ( vs_pay_detail_id) into vl_pay_detail_id;
								   
		SELECT NEXTVAL('SQ_PAYMENT_DETAIL')	into vl_pay_detail_id;					   
		--SELECT al_next_value from  sp_nextid ( 'SQ_PAYMENT_DETAIL') into vl_pay_detail_id;	
		IF vl_placement_structure_id = 13 THEN -- CIS-17815
			IF al_service_id = 10 THEN
				vs_note_tx := 'This child is in ''Emergency Foster Home Care'' for more than 60 days; CHESSIE has generated payments as per ''Regular Foster Care'' rate.';--
			ELSE
				vs_note_tx := NULL;--
			END IF;--
			
			INSERT INTO
			--TB_PAYMENT_DETAIL_TEMP --//here--- removed temp table and used tb_PAYMENT_DETAIL--- Chandra
			TB_PAYMENT_DETAIL
			(
			   PAYMENT_DETAIL_ID,              PAYMENT_ID,
			   COUNTY_CD,                      DRAFT_AMOUNT_NO,
			   CLIENT_ID,                      DRAFT_SERVICE_ID,
			   DRAFT_SERVICE_START_DT,         DRAFT_SERVICE_END_DT,
			   DRAFT_UNITS_NO,                 DRAFT_UNIT_TYPE,
			   DRAFT_RATE_TYPE_CD,
			   PLACEMENT_ID,                   DRAFT_UNIT_RATE_AMT,
			   CREATE_TS,                      CREATE_USER_ID,
			   UPDATE_TS,                      UPDATE_USER_ID,
			   DELETE_SW,                      DRAFT_FISCAL_CATEGORY_CD,
			   CASE_ID,
			   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID,
			   NOTES_TX
			)
			 VALUES
			(
			   vl_pay_detail_id,            al_payment_header_id,
			   vs_county_cd,                adc_gross_amount,
			   vl_client_id,                al_service_id,
			   ad_start_dt,                 ad_end_dt,
			   al_unit_no,                  as_unit_type,
			   as_rate_type,
			   al_placement_id,             adc_per_diem_rate,
			   CURRENT_TIMESTAMP,           'finance',
			   CURRENT_TIMESTAMP,           'finance',
			   'N',                         vs_fiscalCat,
			   vl_case_id,
			   al_reference_payment_detail_id, al_linked_pymnt_hdr_id,
			   vs_note_tx );--

			al_sqlcode := SQLCODE;--
			IF al_sqlcode <> 0  THEN
				as_error := 'Payment Detail: Error in inserting DRAFT PAYMENT Detail record (Emergency Foster Home Care)';--
			END IF ;--
		ELSE
			INSERT INTO
			   -- TB_PAYMENT_DETAIL_TEMP --//here--- removed temp table and used tb_PAYMENT_DETAIL--- Chandra
			   TB_PAYMENT_DETAIL
				(
				   PAYMENT_DETAIL_ID,              PAYMENT_ID,
				   COUNTY_CD,                      DRAFT_AMOUNT_NO,
				   CLIENT_ID,                      DRAFT_SERVICE_ID,
				   DRAFT_SERVICE_START_DT,         DRAFT_SERVICE_END_DT,
				   DRAFT_UNITS_NO,                 DRAFT_UNIT_TYPE,
				   DRAFT_RATE_TYPE_CD,
				   PLACEMENT_ID,                   DRAFT_UNIT_RATE_AMT,
				   CREATE_TS,                      CREATE_USER_ID,
				   UPDATE_TS,                      UPDATE_USER_ID,
				   DELETE_SW,                      DRAFT_FISCAL_CATEGORY_CD,
				   CASE_ID,
				   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID
				)
				 VALUES
				(
				   vl_pay_detail_id,            al_payment_header_id,
				   vs_county_cd,                adc_gross_amount,
				   vl_client_id,                vl_placement_structure_id,
				   ad_start_dt,                 ad_end_dt,
				   al_unit_no,                  as_unit_type,
				   as_rate_type,
				   al_placement_id,             adc_per_diem_rate,
				   CURRENT_TIMESTAMP,           'finance',
				   CURRENT_TIMESTAMP,           'finance',
				   'N',                         vs_fiscalCat,
				   vl_case_id,
				   al_reference_payment_detail_id, al_linked_pymnt_hdr_id );--
		
			al_sqlcode := SQLCODE;--
			IF al_sqlcode <> 0  THEN
				as_error := 'Payment Detail: Error in inserting DRAFT PAYMENT Detail record';--
			END IF;--
		END IF;--
	END IF;--

	IF as_type_cd = 'A' OR as_type_cd = 'G' THEN  -- adoption subsody / SUBSIDIZED GUARDIANSHIP
		-- Check for System generated - 3294 Adjustments
		RAISE NOTICE 'payment details insert SP>>>IF as_type_cd = A OR as_type_cd = G THEN';

		SELECT PAYMENT_TYPE_CD
			INTO vs_payment_type_cd
		FROM TB_PAYMENT_HEADER
		WHERE PAYMENT_ID = al_payment_header_id
			AND DELETE_SW = 'N';--
			
		al_sqlcode := SQLCODE;--
		IF al_sqlcode < 0  THEN
			as_error := 'Adoption & GAP: Error in getting Payment Type cd for PAYMENT_ID: ' || LTRIM(RTRIM((al_payment_header_id)::character varying));--
		END IF ;--
	
		vs_insert_flag := 'Y';--
		-- generating payment detail id
		--SELECT CHESSIE_MASK_FIN.sp_nextid (vs_pay_detail_id, vl_pay_detail_id);--
		--SELECT NEXTVAL('SQ_PAYMENT_DETAIL')	into vl_pay_detail_id;	
		--SELECT al_next_value from  sp_nextid ( 'SQ_PAYMENT_DETAIL') into vl_pay_detail_id;	
		SELECT NEXTVAL('SQ_PAYMENT_DETAIL')	into vl_pay_detail_id;	
		IF vs_payment_type_cd = '3294' THEN
			RAISE NOTICE '% adoption/gurartianship>>>insert TB_PAYMENT_DETAIL>>>if vs_payment_type_cd = 3294',vs_payment_type_cd;
			INSERT INTO
				TB_PAYMENT_DETAIL
				(
				   PAYMENT_DETAIL_ID,              PAYMENT_ID,
				   COUNTY_CD,                      FINAL_AMOUNT_NO,
				   CLIENT_ID,                      FINAL_SERVICE_ID,
				   FINAL_SERVICE_START_DT,         FINAL_SERVICE_END_DT,
				   FINAL_UNITS_NO,                 FINAL_UNIT_TYPE,
				   FINAL_RATE_TYPE_CD,
				   SUBSIDY_AGREEMENT_ID,           FINAL_UNIT_RATE_AMT,
				   CREATE_TS,                      CREATE_USER_ID,
				   UPDATE_TS,                      UPDATE_USER_ID,
				   DELETE_SW,                      FINAL_FISCAL_CATEGORY_CD,
				   CASE_ID,
				   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID
				)
				 VALUES
				(
				   vl_pay_detail_id,            al_payment_header_id,
				   vs_county_cd,	
					
					adc_gross_amount,
				   vl_client_id,                vl_placement_structure_id,
				   ad_start_dt,                 ad_end_dt,
				   al_unit_no,                  as_unit_type,
				   as_rate_type,
				   al_placement_id,             adc_per_diem_rate,
				   CURRENT_TIMESTAMP,           'finance',
				   CURRENT_TIMESTAMP,           'finance',
				   'N',                         vs_fiscalCat,
				   vl_case_id,
				   al_reference_payment_detail_id, al_linked_pymnt_hdr_id )  ;--

				al_sqlcode := SQLCODE;--
				IF al_sqlcode <> 0  THEN
					as_error := 'Payment Detail: Error in inserting ADOPTION SUBSIDY/SUBSIDIZED GUARDIANSHIP ADJ PAYMENT Detail record';--
				END IF;--
		ELSE
			RAISE NOTICE '% adoption/gurartianship>>>insert TB_PAYMENT_DETAIL_TEMP>>>vs_payment_type_cd = 3294 else part',vs_payment_type_cd;
			/*Added by Chandra.
			If payment_type_cd=7(Guardianship Assistance Program) 
			then FINAL_FISCAL_CATEGORY_CD=7185(Guardianship Subsidy=> from TB_FISCAL_CATEGORY_MASTER table) start*/
			/*IF((select payment_type_cd,* from tb_payment_header where payment_id=al_payment_header_id and delete_sw='N')=7) THEN
			RAISE NOTICE 'gurartianship>>>vs_fiscalCat set up';
			vs_fiscalCat:='7185';
			END IF;*/
			/*Added by Chandra.
			If payment_type_cd=7(Guardianship Assistance Program) 
			then FINAL_FISCAL_CATEGORY_CD=7185(Guardianship Subsidy=> from TB_FISCAL_CATEGORY_MASTER table) END*/
			INSERT INTO
			--TB_PAYMENT_DETAIL_TEMP--//here--- removed temp table and used tb_PAYMENT_DETAIL--- Chandra
			TB_PAYMENT_DETAIL
			(
			   PAYMENT_DETAIL_ID,              PAYMENT_ID,
			   COUNTY_CD,                      CLIENT_ID,
			   FINAL_SERVICE_ID,
			   FINAL_SERVICE_START_DT,         FINAL_SERVICE_END_DT,
			   FINAL_AMOUNT_NO,                SUBSIDY_AGREEMENT_ID,
			   FINAL_UNITS_NO,                 FINAL_UNIT_TYPE,
			   FINAL_RATE_TYPE_CD,             FINAL_UNIT_RATE_AMT,
			   CREATE_TS,                      CREATE_USER_ID,
			   UPDATE_TS,                      UPDATE_USER_ID,
			   DELETE_SW,                      FINAL_FISCAL_CATEGORY_CD,
			   CASE_ID,
			   REFERENCE_PAYMENT_DETAIL_ID,    LINKED_PYMNT_HDR_ID
			)
			 VALUES
			(
			   vl_pay_detail_id,            al_payment_header_id,
			   vs_county_cd,                vl_client_id,
			   vl_placement_structure_id,
			   ad_start_dt,                 ad_end_dt,
			   adc_gross_amount,            al_placement_id,
			   al_unit_no,                  as_unit_type,
			   as_rate_type,                adc_per_diem_rate,
			   CURRENT_TIMESTAMP,           'finance',
			   CURRENT_TIMESTAMP,           'finance',
			   'N',                         vs_fiscalCat,
			   vl_case_id,
			   al_reference_payment_detail_id, al_linked_pymnt_hdr_id );--

			al_sqlcode := SQLCODE;--
			IF al_sqlcode <> 0  THEN
				as_error := 'Payment Detail: Error in inserting ADOPTION SUBSIDY/SUBSIDIZED GUARDIANSHIP PAYMENT Detail record';--
			END IF;--
		END IF;	--
	END IF;--

	-- PRJ-04753 - Fiscal Audit Trail - Picklist Type ID 10041 
	IF vs_change_type IS NOT NULL AND RTRIM(LTRIM(vs_change_type)) <> '' THEN
		-- System generated - 3294 Adjustments
		SELECT COUNT(*)
			INTO vl_cnt
		FROM TB_PAYMENT_HEADER
		WHERE PAYMENT_ID = al_payment_header_id
			AND COALESCE(MANUAL_SW, '') = 'N'
			AND PAYMENT_TYPE_CD = '3294'
			AND DELETE_SW = 'N';--
		
		al_sqlcode := SQLCODE;--
		IF al_sqlcode < 0  THEN
			as_error := 'Fiscal Audit Trail: Error in verifying Payment Type for PAYMENT_ID: ' || LTRIM(RTRIM((al_payment_header_id)::character varying));--
		END IF ;--

		IF vl_cnt > 0 THEN
			vl_event_id := vl_pay_detail_id;--
			-- 1008	Payment Adjustment
			vs_entity_type_cd := '1008' ;--

			SELECT a.as_error,a.al_sqlcode from SP_FISCAL_AUDIT_TRAIL ( 'SP_PAYMENT_DETAIL_INSERT'
												, vs_change_type
												, vl_event_id
												, vs_entity_type_cd
												, vl_pay_detail_id) a into
												as_error
												, vl_sqlcode;--
												
			IF vl_sqlcode <> 0 THEN
				as_error := as_error;--
				IF as_error is NULL OR as_error = '' THEN
				   as_error := 'Fiscal Audit Trail: SP_FISCAL_AUDIT_TRAIL failed';--
				END IF;--
			END IF;--
		END IF;--
	END IF;--

	al_sqlcode := vl_sqlcode;--

END 
;

$function$
;
