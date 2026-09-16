-- FUNCTION: cjams.sp_release_payments(bigint)

-- DROP FUNCTION cjams.sp_release_payments(bigint);

CREATE OR REPLACE FUNCTION cjams.sp_release_payments(al_provider_id bigint)
RETURNS integer
LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- 06/06/2008 Vineet Tirodkar
--
-- To Release all payments on HOLD due to missing information of the provider.
-- Create new payments with type as ‘Adjustment’ for payments on HOLD
-- and update status of original HOLD payment to ‘1639'- Released
-- 06/16/2008 Vineet Tirodkar - Changes to create Diff payment Adjustment entries client wise and county wise
-- 10/01/2008 Vineet Tirodkar - Create new FOSTER_CARE_BEDRETAINER payments with type as ‘Adjustment’ for payments on HOLD.
--            BEDRETAINER payments are provider wise (Client ID is null)
-- 10/30/2008 Vineet Tirodkar - Changes to create adjustments for the final payment amount greater than $ 0.
-- 11/18/2008 Vineet Tirodkar - Changes to add condition CLIEND_ID is NULL for BEDRETAINER payment detls cursor. # 18984
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 06/13/2023 Vineet Tirodkar - To update audit columns (update_ts & update_user_id) for Reporting mart data pull (CDM-31419) 
-----------------------------------------------------------------------------------------------------------

DECLARE vl_org_pay_header_id BIGINT DEFAULT 0;--
DECLARE vl_org_pay_detail_id BIGINT DEFAULT 0;--
DECLARE vs_county_cd VARCHAR(5) DEFAULT NULL;--
DECLARE vl_client_id BIGINT DEFAULT 0;--

DECLARE vl_pay_header_id BIGINT DEFAULT 0;--
DECLARE vl_pay_detail_id BIGINT DEFAULT 0;--
DECLARE vl_pay_status_id BIGINT DEFAULT 0;--

DECLARE vdc_gross_amount DECIMAL(10,2) DEFAULT 0.00;--

DECLARE vs_pay_header_id VARCHAR(50) DEFAULT 'sq_payment_header';--
DECLARE vs_pay_detail_id VARCHAR(50) DEFAULT 'sq_payment_detail';--
DECLARE vs_pay_status_id VARCHAR(50) DEFAULT 'sq_payment_status';--

DECLARE  VS_RESULT            CHAR(1);--
DECLARE  VS_USER_ID           VARCHAR(10)     DEFAULT  'finance';--
DECLARE  VTS_PREVIOUS_RUN_TS  TIMESTAMP;--
DECLARE  VTS_CURRENT_RUN_TS   TIMESTAMP ;--
DECLARE  VL_ROWCOUNT          INTEGER DEFAULT  0;--
DECLARE  VL_SQLCODE           INTEGER DEFAULT 0;--
DECLARE  VS_MESSAGE           VARCHAR(150);--

--Log Error
DECLARE SQLCODE INT DEFAULT 0;--
DECLARE al_sqlcode INT DEFAULT 0;--
DECLARE as_error VARCHAR(3000);--
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';--
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);--
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';--
DECLARE vl_ret_status INTEGER DEFAULT 0;--
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_RELEASE_PAYMENTS';--
DECLARE vs_identity_column VARCHAR(100);--
DECLARE vs_identity_val VARCHAR(100);--
CUR_HOLD_PAYMENTS record;
 CUR_HOLD_PAYMENTS_refcur REFCURSOR;
 CUR_HOLD_PAY_DETAIL record;
 CUR_HOLD_PAY_DETAIL_refcur REFCURSOR;
 
Begin
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		EXCEPTION WHEN OTHERS THEN
		--GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
	--    SET al_sqlcode = -1 ;--
		 as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
		 as_error := COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');--
		 as_error := as_error || COALESCE(vs_message_text ,'');--

	   /* call CHESSIE.SP_BATCH_ERROR_LOG ( 'SP_RELEASE_PAYMENTS' ,
						   NULL,
						   NULL,
						   NULL,
						   NULL,
						   as_error,
						   'finance',
						   vl_ret_status )                    ;--*/
		SELECT SP_BATCH_ERROR_LOG ( 'SP_RELEASE_PAYMENTS'::character varying ,
										   NULL::bigint,
										   NULL::bigint,
										   NULL::character varying,
										   NULL::INTEGER,
										   NULL::character varying,
										   SQLSTATE::character varying,
										   as_error::character varying,
										   'finance'::character varying) INTO
										   vl_ret_status;

		 as_error := '';--
		 RETURN 0;
	END;--

	--Log Error

	--PAYMENT HEADER LOOP -  START
	--FOR CUR_HOLD_PAYMENTS AS
	OPEN CUR_HOLD_PAYMENTS_refcur FOR
	--cur1 CURSOR WITH HOLD FOR
	   SELECT DISTINCT PD.COUNTY_CD,
			   PD.CLIENT_ID,
			   PH.PAYMENT_ID
		  FROM TB_PAYMENT_HEADER PH,
			   TB_PAYMENT_STATUS PS,
			   TB_PAYMENT_DETAIL PD
		WHERE PH.PAYMENT_ID = PS.PAYMENT_ID
			  AND PD.PAYMENT_ID = PH.PAYMENT_ID	
			  AND PH.DELETE_SW = 'N'
			  AND PS.DELETE_SW = 'N'
			  AND PD.DELETE_SW = 'N'
			  AND PS.PAYMENT_STATUS_CD = '1635'
			  AND COALESCE(PD.FINAL_AMOUNT_NO,0) > 0
		  AND PH.PROVIDER_ID = al_provider_id;
		
	--DO
	loop
		fetch CUR_HOLD_PAYMENTS_refcur into CUR_HOLD_PAYMENTS;
	 exit when not found;
		 vs_county_cd := NULL; -- INTIAL VALUE		
		 vs_county_cd := CUR_HOLD_PAYMENTS.COUNTY_CD;--

		 vl_client_id := NULL; -- INTIAL VALUE
		 vl_client_id := CUR_HOLD_PAYMENTS.CLIENT_ID;--

		 vl_org_pay_header_id := 0; -- INTIAL VALUE	
		 vl_org_pay_header_id := CUR_HOLD_PAYMENTS.PAYMENT_ID;--

		
		-- Payment Header Insert - START
		vl_pay_header_id := 0; -- INITIAL VALUE
		select sp_nextid ( vs_pay_header_id) into vl_pay_header_id;--

		-- Get Gross Amount for TB_PAYMENT_HEADER based on County CD
		 vdc_gross_amount := 0; -- INTIAL VALUE	
		IF vl_client_id is NOT NULL AND vl_client_id > 0 THEN
		   SELECT SUM(COALESCE(FINAL_AMOUNT_NO,0))
			INTO vdc_gross_amount
		FROM TB_PAYMENT_DETAIL
		WHERE PAYMENT_ID = vl_org_pay_header_id
			  AND COUNTY_CD = vs_county_cd
				  AND CLIENT_ID = vl_client_id
			  AND DELETE_SW = 'N' 
			  AND COALESCE(FINAL_AMOUNT_NO,0) > 0;--
		 ELSE
		   SELECT SUM(COALESCE(FINAL_AMOUNT_NO,0))
				INTO vdc_gross_amount
			FROM TB_PAYMENT_DETAIL
			WHERE PAYMENT_ID = vl_org_pay_header_id
				  AND COUNTY_CD = vs_county_cd
				  AND CLIENT_ID is NULL
			  AND DELETE_SW = 'N' 
			  AND COALESCE(FINAL_AMOUNT_NO,0) > 0;--
		 END IF;--
		
		IF vdc_gross_amount is NULL THEN
			vdc_gross_amount := 0;--
		END IF;--
		

		INSERT INTO TB_PAYMENT_HEADER
				 ( PAYMENT_ID,		PROVIDER_ID,
				   AUTHORIZATION_ID,	PAYMENT_DT,
				   PAYMENT_TYPE_CD,		CHECK_STATUS_CD,
				   CHECK_STATUS_DT,		PAYMENT_METHOD_CD,
				   GROSS_AMOUNT_NO,		OFFSET_AMOUNT_NO,
				   MANUAL_SW,		APPROVAL_STATUS_CD,
				   UPDATE_METHOD_SW,	CREATE_TS,
				   STORE_RECEIPT_ID,	CREATE_USER_ID,
				   UPDATE_TS,		UPDATE_USER_ID,
				   DELETE_SW,		NOTES_TX,
				   PAYEE_NM,		INTERFACE_TO_CD,
				   ADR_TYPE_CD,		ADR_FORMAT_CD,
				   ADR_STREET_NO,		ADR_BOX_NO,
				   ADR_PRE_DIR_CD,		ADR_STREET_NM,
				   ADR_STREET_SUFFIX_CD,	ADR_POST_DIR_CD,
				   ADR_UNIT_TYPE_CD,	ADR_UNIT_NO_TX,
				   ADR_CITY_NM,		ADR_COUNTY_CD,
				   ADR_STATE_CD,		ADR_ZIP5_NO,
				   ADR_ZIP4_NO,		ADR_DIRECTION_TX,
				   ADR_FOREIGN_TX,		ADR_HOME_PHONE_TX,
				   ADR_WORK_PHONE_TX,	ADR_WORK_XTN_TX,
				   ADR_PAGER_TX,		ADR_EMAIL_TX,
				   ADR_FAX_TX,		ADR_CELL_PHONE_TX,
				   ADR_URL_TX,		ADR_OTHER_CONTACT_TX,
				   PAYMENT_START_DT,	PAYMENT_END_DT,
				   ADR_FOREIGN_STATE_TX,	ADR_COUNTRY_TX,
				   ADR_POSTAL_CODE_TX,	ADR_DEFAULT_SW,
				   ADR_START_DT,		ADR_END_DT,
				   CLIENT_ACCOUNT_ID,	ADR_STREET_TX )
		   (    SELECT vl_pay_header_id,	PROVIDER_ID,
				AUTHORIZATION_ID,	CURRENT_DATE ,
				'3294',			CHECK_STATUS_CD,
				CHECK_STATUS_DT,	PAYMENT_METHOD_CD,
				vdc_gross_amount,	OFFSET_AMOUNT_NO,
				'N',			APPROVAL_STATUS_CD,
				UPDATE_METHOD_SW,	CURRENT_TIMESTAMP,
				STORE_RECEIPT_ID,	'finance',
				CURRENT_TIMESTAMP,	'finance',
				DELETE_SW,		NOTES_TX,
				PAYEE_NM,		INTERFACE_TO_CD,
				ADR_TYPE_CD,		ADR_FORMAT_CD,
				ADR_STREET_NO,		ADR_BOX_NO,
				ADR_PRE_DIR_CD,		ADR_STREET_NM,
				ADR_STREET_SUFFIX_CD,	ADR_POST_DIR_CD,
				ADR_UNIT_TYPE_CD,	ADR_UNIT_NO_TX,
				ADR_CITY_NM,		ADR_COUNTY_CD,
				ADR_STATE_CD,		ADR_ZIP5_NO,
				ADR_ZIP4_NO,		ADR_DIRECTION_TX,
				ADR_FOREIGN_TX,		ADR_HOME_PHONE_TX,
				ADR_WORK_PHONE_TX,	ADR_WORK_XTN_TX,
				ADR_PAGER_TX,		ADR_EMAIL_TX,
				ADR_FAX_TX,		ADR_CELL_PHONE_TX,
				ADR_URL_TX,		ADR_OTHER_CONTACT_TX,
				PAYMENT_START_DT,	PAYMENT_END_DT,
				ADR_FOREIGN_STATE_TX,	ADR_COUNTRY_TX,
				ADR_POSTAL_CODE_TX,	ADR_DEFAULT_SW,
				ADR_START_DT,		ADR_END_DT,
				CLIENT_ACCOUNT_ID,	ADR_STREET_TX
				  FROM TB_PAYMENT_HEADER
				WHERE PAYMENT_ID = vl_org_pay_header_id
				  AND DELETE_SW = 'N'  )  ;--

		al_sqlcode := SQLCODE;--
		IF al_sqlcode <> 0 THEN
			as_error := 'Error in Inserting record in TB_PAYMENT_HEADER. (SQL-1)'  ;--
			vs_identity_column := 'Org Payment ID';--
			vs_identity_val := (vl_org_pay_header_id)::character varying;--
		   --SIGNAL p_sp_error  ;--
		END IF ;--
		-- Payment Header Insert - END
			

		-- PAYMENT DETAILS LOOP -  START
		IF vl_client_id is NOT NULL AND vl_client_id > 0 THEN -- CASE Payments with CLIENT IDs	
		  --  FOR CUR_HOLD_PAY_DETAIL AS
			--cur2 CURSOR WITH HOLD FOR
			OPEN CUR_HOLD_PAY_DETAIL_refcur FOR
				SELECT PAYMENT_DETAIL_ID
				   FROM TB_PAYMENT_DETAIL
				WHERE PAYMENT_ID = vl_org_pay_header_id
				  AND COUNTY_CD = vs_county_cd
				  AND CLIENT_ID = vl_client_id
				  AND DELETE_SW = 'N'
				  AND COALESCE(FINAL_AMOUNT_NO,0) > 0;

			--DO
			loop
			fetch CUR_HOLD_PAY_DETAIL_refcur into CUR_HOLD_PAY_DETAIL;
			exit when not found;
	 
			 vl_org_pay_detail_id := CUR_HOLD_PAY_DETAIL.PAYMENT_DETAIL_ID;--

			-- Payment Detail Insert - START
			 vl_pay_detail_id := 0; -- INITIAL VALUE
			select sp_nextid (vs_pay_detail_id) into vl_pay_detail_id;--

			INSERT INTO TB_PAYMENT_DETAIL
				 ( PAYMENT_DETAIL_ID,		PAYMENT_ID,
				   COUNTY_CD,			PAYMENT_AMOUNT_NO,
				   CLIENT_ID,			DRAFT_SERVICE_ID,
				   DRAFT_SERVICE_START_DT,	DRAFT_SERVICE_END_DT,
				   DRAFT_UNITS_NO,		FINAL_SERVICE_ID,
				   FINAL_SERVICE_START_DT,	FINAL_SERVICE_END_DT,
				   FINAL_UNITS_NO,              DRAFT_AMOUNT_NO,
				   FINAL_AMOUNT_NO,             NOTES_TX,
				   CHANGE_REASON_CD,		STATUS_CD,
				   TCA_STOPPED_CD,		TYPE_1099_CD,
				   CREATE_TS,			CREATE_USER_ID,
				   UPDATE_TS,			UPDATE_USER_ID,
				   DELETE_SW,			REFERENCE_PAYMENT_DETAIL_ID,
				   REPORT_1099_SW,		LINKED_PYMNT_HDR_ID,
				   DRAFT_RATE_TYPE_CD,		FINAL_RATE_TYPE_CD,
				   PLACEMENT_ID,		SUBSIDY_AGREEMENT_ID,
				   DRAFT_UNIT_RATE_AMT,		FINAL_UNIT_RATE_AMT,
				   DRAFT_UNIT_TYPE,		FINAL_UNIT_TYPE,
				   DRAFT_FISCAL_CATEGORY_CD,	FINAL_FISCAL_CATEGORY_CD,
				   CASE_ID,			AGENCY_OBJECT_CD )
			  ( SELECT vl_pay_detail_id,		vl_pay_header_id,
				 COUNTY_CD,			PAYMENT_AMOUNT_NO,
				 CLIENT_ID,			DRAFT_SERVICE_ID,
				 DRAFT_SERVICE_START_DT,	DRAFT_SERVICE_END_DT,
				 DRAFT_UNITS_NO,		FINAL_SERVICE_ID,
				 FINAL_SERVICE_START_DT,	FINAL_SERVICE_END_DT,
				 FINAL_UNITS_NO,		DRAFT_AMOUNT_NO,
				 FINAL_AMOUNT_NO,		NOTES_TX,
				 CHANGE_REASON_CD,		STATUS_CD,
				 TCA_STOPPED_CD,		TYPE_1099_CD,
				 CURRENT_TIMESTAMP,            'finance',
				 CURRENT_TIMESTAMP,            'finance',
				 DELETE_SW,			vl_org_pay_detail_id,
				 REPORT_1099_SW,		vl_org_pay_header_id,
				 DRAFT_RATE_TYPE_CD,		FINAL_RATE_TYPE_CD,
				 PLACEMENT_ID,			SUBSIDY_AGREEMENT_ID,
				 DRAFT_UNIT_RATE_AMT,		FINAL_UNIT_RATE_AMT,
				 DRAFT_UNIT_TYPE,		FINAL_UNIT_TYPE,
				 DRAFT_FISCAL_CATEGORY_CD,	FINAL_FISCAL_CATEGORY_CD,
				 CASE_ID,			AGENCY_OBJECT_CD
				FROM TB_PAYMENT_DETAIL
			   WHERE PAYMENT_DETAIL_ID =  vl_org_pay_detail_id
				 AND  DELETE_SW = 'N' 	)  ;--

				al_sqlcode := SQLCODE;--
				IF al_sqlcode <> 0 THEN
					as_error := 'Error in Inserting record in TB_PAYMENT_DETAIL. (SQL-2)'  ;--
					vs_identity_column := 'Org Payment Detail ID';--
					vs_identity_val := (vl_org_pay_detail_id)::character varying;--
				  -- SIGNAL p_sp_error  ;--
				END IF ;--

				-- Payment Detail Insert - END

				--END FOR;--
			END loop;
			close CUR_HOLD_PAY_DETAIL_refcur;
		ELSE -- BEDRETAINER payments
		   -- FOR CUR_HOLD_PAY_DETAIL AS
			--cur2 CURSOR WITH HOLD FOR
			OPEN CUR_HOLD_PAY_DETAIL_refcur FOR
				SELECT PAYMENT_DETAIL_ID
				   FROM TB_PAYMENT_DETAIL
				WHERE PAYMENT_ID = vl_org_pay_header_id
				  AND COUNTY_CD = vs_county_cd
				  AND CLIENT_ID is NULL
				  AND DELETE_SW = 'N'
				  AND COALESCE(FINAL_AMOUNT_NO,0) > 0;

			--DO
			loop
			fetch CUR_HOLD_PAY_DETAIL_refcur into CUR_HOLD_PAY_DETAIL;
			exit when not found;
			vl_org_pay_detail_id := CUR_HOLD_PAY_DETAIL.PAYMENT_DETAIL_ID;--

			-- Payment Detail Insert - START
			vl_pay_detail_id := 0; -- INITIAL VALUE
			select sp_nextid (vs_pay_detail_id) into vl_pay_detail_id;--

			INSERT INTO TB_PAYMENT_DETAIL
				 ( PAYMENT_DETAIL_ID,		PAYMENT_ID,
				   COUNTY_CD,			PAYMENT_AMOUNT_NO,
				   CLIENT_ID,			DRAFT_SERVICE_ID,
				   DRAFT_SERVICE_START_DT,	DRAFT_SERVICE_END_DT,
				   DRAFT_UNITS_NO,		FINAL_SERVICE_ID,
				   FINAL_SERVICE_START_DT,	FINAL_SERVICE_END_DT,
				   FINAL_UNITS_NO,              DRAFT_AMOUNT_NO,
				   FINAL_AMOUNT_NO,             NOTES_TX,
				   CHANGE_REASON_CD,		STATUS_CD,
				   TCA_STOPPED_CD,		TYPE_1099_CD,
				   CREATE_TS,			CREATE_USER_ID,
				   UPDATE_TS,			UPDATE_USER_ID,
				   DELETE_SW,			REFERENCE_PAYMENT_DETAIL_ID,
				   REPORT_1099_SW,		LINKED_PYMNT_HDR_ID,
				   DRAFT_RATE_TYPE_CD,		FINAL_RATE_TYPE_CD,
				   PLACEMENT_ID,		SUBSIDY_AGREEMENT_ID,
				   DRAFT_UNIT_RATE_AMT,		FINAL_UNIT_RATE_AMT,
				   DRAFT_UNIT_TYPE,		FINAL_UNIT_TYPE,
				   DRAFT_FISCAL_CATEGORY_CD,	FINAL_FISCAL_CATEGORY_CD,
				   CASE_ID,			AGENCY_OBJECT_CD )
			  ( SELECT vl_pay_detail_id,		vl_pay_header_id,
				 COUNTY_CD,			PAYMENT_AMOUNT_NO,
				 CLIENT_ID,			DRAFT_SERVICE_ID,
				 DRAFT_SERVICE_START_DT,	DRAFT_SERVICE_END_DT,
				 DRAFT_UNITS_NO,		FINAL_SERVICE_ID,
				 FINAL_SERVICE_START_DT,	FINAL_SERVICE_END_DT,
				 FINAL_UNITS_NO,		DRAFT_AMOUNT_NO,
				 FINAL_AMOUNT_NO,		NOTES_TX,
				 CHANGE_REASON_CD,		STATUS_CD,
				 TCA_STOPPED_CD,		TYPE_1099_CD,
				 CURRENT_TIMESTAMP,            'finance',
				 CURRENT_TIMESTAMP,            'finance',
				 DELETE_SW,			vl_org_pay_detail_id,
				 REPORT_1099_SW,		vl_org_pay_header_id,
				 DRAFT_RATE_TYPE_CD,		FINAL_RATE_TYPE_CD,
				 PLACEMENT_ID,			SUBSIDY_AGREEMENT_ID,
				 DRAFT_UNIT_RATE_AMT,		FINAL_UNIT_RATE_AMT,
				 DRAFT_UNIT_TYPE,		FINAL_UNIT_TYPE,
				 DRAFT_FISCAL_CATEGORY_CD,	FINAL_FISCAL_CATEGORY_CD,
				 CASE_ID,			AGENCY_OBJECT_CD
				FROM TB_PAYMENT_DETAIL
			   WHERE PAYMENT_DETAIL_ID =  vl_org_pay_detail_id
				 AND  DELETE_SW = 'N' 	)  ;--

			al_sqlcode := SQLCODE;--
			IF al_sqlcode <> 0 THEN
				as_error := 'Error in Inserting record in TB_PAYMENT_DETAIL. (SQL-2A)'  ;--
				vs_identity_column := 'Org Payment Detail ID';--
				vs_identity_val := (vl_org_pay_detail_id)::character varying;--
			  -- SIGNAL p_sp_error  ;--
			END IF ;--

			-- Payment Detail Insert - END

			-- END FOR;--
		   end loop;
		   close CUR_HOLD_PAY_DETAIL_refcur;
		END IF;--
		-- PAYMENT DETAILS LOOP -  END

		-- Payment Status Insert with Stsus as '1634' ( Approved) - START
		vl_pay_status_id := 0; -- INITIAL VALUE
		select sp_nextid ( vs_pay_status_id) into vl_pay_status_id;    		--

		INSERT INTO TB_PAYMENT_STATUS
			 ( PAYMENT_STATUS_ID,	PAYMENT_STATUS_CD,
			   PAYMENT_STATUS_DT,	PAYMENT_ID,
			   ACTIVE_SW,		CREATE_TS,
			   CREATE_USER_ID,	UPDATE_TS,
			   UPDATE_USER_ID,	DELETE_SW,
			   APPROVAL_STATUS_CD )
	   ( SELECT vl_pay_status_id,	'1634',
			 PAYMENT_STATUS_DT,	vl_pay_header_id,
			 ACTIVE_SW,		CURRENT_TIMESTAMP,
			 'finance',		CURRENT_TIMESTAMP,
			 'finance',		DELETE_SW,
			 APPROVAL_STATUS_CD
		   FROM TB_PAYMENT_STATUS
		 WHERE PAYMENT_ID = vl_org_pay_header_id
		   AND DELETE_SW  = 'N'  )  ;--
		

		al_sqlcode := SQLCODE;--
		IF al_sqlcode <> 0 THEN
			as_error := 'Error in Inserting record in TB_PAYMENT_STATUS (SQL-3)'  ;--
			vs_identity_column := 'Payment ID';--
			vs_identity_val := (vl_org_pay_header_id)::character varying;--
		  -- SIGNAL p_sp_error  ;--
		END IF ;		--
		-- Payment Status Insert with Stsus as '1634' ( Approved) - END

		-- Change Status of Original payment to Released - START
		
		UPDATE TB_PAYMENT_STATUS
		SET PAYMENT_STATUS_CD = '1639',
			PAYMENT_STATUS_DT = CURRENT_DATE,
			update_user_id = 'finance',
			update_ts = CURRENT_TIMESTAMP
		WHERE PAYMENT_ID = vl_org_pay_header_id
		  AND DELETE_SW = 'N';--

		al_sqlcode := SQLCODE;--
		IF al_sqlcode <> 0 THEN
			 as_error := 'Error in Updating TB_PAYMENT_STATUS. (SQL-4)'  ;--
			 vs_identity_column := 'Pyament ID';--
			 vs_identity_val := (vl_pay_header_id)::character varying;--
		  --  SIGNAL p_sp_error  ;--
		END IF ;--

		-- Change Status of Original payment to Released - END

	--COMMIT;--
	--END FOR;    --PAYMENT HEADER LOOP -  END
	END loop;
	
	close CUR_HOLD_PAYMENTS_refcur;
	PERFORM SP_UPDATE_PAYMENT_PROV_ADR('H', al_provider_id );--
	
	return 1;

END;
		
$function$;
