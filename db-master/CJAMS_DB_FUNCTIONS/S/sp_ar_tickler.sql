CREATE OR REPLACE FUNCTION cjams.sp_ar_tickler(as_provider_type character varying, al_system_ticlker_id bigint)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      :  Vineet Tirodkar
-- Date        :  11/14/2007
-- Description :  To Create A/R Ticklers for System created Overpayment Entries
-- Arguments   : 1) Case System Tickler ID  42
--			Private (PVT) / chessie_mask (PUB) Providers
--		    Case System Tickler ID  425
--		    	'' Blank quotes
--               2) System Tickler ID  	
-- 01/08/2009 Vineet Tirodkar - Changes to include logic for Monthly Offset Ticklers # - CIS-18126
--            Also change in Tickler Tx for System Tickler ID  42                				
-- 09/04/2015 - Vineet Tirodkar - PRJ-05327 - MD CHESSIE Fiscal Phases 2
-- 				Changes for GAP & Adoption Subsidy A/R Tickler.
-- Vineet Tirodkar - 05/03/2021 - Modifications for New Provider Category 3794 - Residential Treatment Center (B-102022)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 11/22/2022 - Vineet Tirodkar - To Fix Trim error on Bigint data type Aurora DB migration 
------------------------------------------------------------------------

DECLARE vs_cursor_sql VARCHAR(12000) ;--
DECLARE vs_option VARCHAR(1) DEFAULT 'I' ;--
DECLARE vs_entity_type VARCHAR(5) DEFAULT '2953' ;--
DECLARE vs_tickler_tx VARCHAR(500);--
--DECLARE vl_days_no BIGINT;--
DECLARE vl_days_no INTEGER;--
--DECLARE vl_reminder_days BIGINT;--
 vl_reminder_days INTEGER;--
DECLARE vs_nature VARCHAR(5);--
--DECLARE vl_expiry BIGINT;--
 vl_expiry INTEGER;--
DECLARE vd_due_dt DATE;--
DECLARE vd_reminder_dt DATE;--
DECLARE vd_expiry_dt DATE;--
DECLARE vs_provider_nm VARCHAR(100);--
DECLARE vs_screen_cd VARCHAR(8) DEFAULT NULL;--

DECLARE vs_county_cd VARCHAR(5);--
DECLARE vs_to_county_cd VARCHAR(5);--
DECLARE vs_assign_to_county_cd VARCHAR(5);--
	
DECLARE vl_unit_id BIGINT DEFAULT NULL;--
DECLARE vl_to_unit_id BIGINT DEFAULT NULL;--
DECLARE vl_assign_to_unit_id BIGINT DEFAULT NULL;--

DECLARE vl_provider_id BIGINT DEFAULT 0;--
DECLARE vl_client_id BIGINT DEFAULT 0;--
DECLARE vl_staff_id BIGINT DEFAULT 0;--
DECLARE ll_tickler_cnt BIGINT DEFAULT 0;--
DECLARE vl_row_cnt BIGINT DEFAULT 0;--

DECLARE vs_tickler_col VARCHAR(50) DEFAULT 'sq_ticklers';--
DECLARE vl_tickler_id BIGINT DEFAULT 0;--
DECLARE vd_previous_month_start_dt DATE;--
DECLARE vdc_offset_amt Decimal(10,2) DEFAULT 0.00;--
DECLARE vl_ENTITY_ID1 BIGINT DEFAULT 0;--
DECLARE vl_ENTITY_ID2 BIGINT DEFAULT 0;--
DECLARE vl_placement_cnt BIGINT DEFAULT 0;--
DECLARE vl_subsidy_agreement_id BIGINT DEFAULT 0;--

--Log Error
DECLARE SQLCODE INT DEFAULT 0;--
DECLARE al_sqlcode INT DEFAULT 0;--
DECLARE as_error VARCHAR(3000);--
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';--
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);--
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';--
DECLARE vl_ret_status INTEGER DEFAULT 0;--
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_AR_TICKLER';--
DECLARE vs_identity_column VARCHAR(100);--
DECLARE vs_identity_val VARCHAR(100);--
DECLARE v_provider_count INT DEFAULT 0;--
--Log Error

--DECLARE CUR_OVERPAYMENTS CURSOR WITH HOLD FOR s1;--
CUR_OVERPAYMENTS REFCURSOR;--

--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
	begin
		EXCEPTION WHEN OTHERS THEN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
		-- SET al_sqlcode = -1 ;--
		 as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
		 as_error := COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');--
		 as_error := as_error || COALESCE(vs_message_text ,'');--

		SELECT SP_BATCH_ERROR_LOG ( 'SP_AR_TICKLER ' || '(' || as_provider_type || ')'  ,
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
	--Log error

	SELECT (date_trunc('month', now()) - interval '1 month')::date    
       INTO vd_previous_month_start_dt    
        ;

	SELECT DAYS_NO,
	   REMINDER_DAYS_NO,
	   SYSTEM_TICKLER_TX,
	   TICKLER_NATURE_CD,
	   EXPIRE_AFTER_DAYS
	INTO vl_days_no,
	   vl_reminder_days,
	   vs_tickler_tx,
	   vs_nature,
	   vl_expiry
	FROM tb_SYSTEM_TICKLERS
	WHERE SYSTEM_TICKLER_ID = al_system_ticlker_id AND
		DELETE_SW = 'N' AND
		ACTIVE_SW = 'Y';--
	
	al_sqlcode := SQLCODE;--
	IF al_sqlcode <> 0 THEN
		as_error := 'System tickler info NOT found.' ;--
		vs_identity_column := 'SYSTEM_TICKLER_ID';--
		vs_identity_val := (al_system_ticlker_id)::character varying;--
	   --SIGNAL p_sp_error  ;--
	END IF ;--

	SELECT ( CURRENT_DATE + vl_days_no ) AS DUE_DT,
       ( CURRENT_DATE + vl_days_no ) - vl_reminder_days AS REMD_DT,
       (CURRENT_DATE + vl_days_no ) + vl_expiry  AS EXP_DT
	INTO vd_due_dt,
    	vd_reminder_dt,
        vd_expiry_dt;
	--FROM sysibm.sysdummy1 ;

 		
	vs_cursor_sql := ''; -- INITIAL VALUE

	IF al_system_ticlker_id = 425 THEN
		vs_cursor_sql := ' SELECT PH.PROVIDER_ID, '||
		 '		F_ENAME(''2953'', PH.PROVIDER_ID) AS PROVIDER_NM,  '||
		 '		PH.OFFSET_AMOUNT_NO,  '||
		 '      PH.PAYMENT_ID  '||
		 '   FROM tb_PAYMENT_HEADER  PH  '||
		 ' WHERE COALESCE(PH.OFFSET_AMOUNT_NO, 0) > 0   '||
		 '	 AND PH.DELETE_SW = ''N''  '||
		 '   AND PH.PAYMENT_TYPE_CD = ''6'' '||
		 ' 	 AND PH.PAYMENT_START_DT = '''|| TO_CHAR(vd_previous_month_start_dt:: DATE, 'mm/dd/yyyy') ||''' ';--

	ELSEIF al_system_ticlker_id = 42 THEN
		IF as_provider_type = 'PVT' THEN
			vs_cursor_sql := ' SELECT RH.PROVIDER_ID, PD.CLIENT_ID, PD.CASE_ID,'||
			'	 	 	F_ENAME(''2953'', RH.PROVIDER_ID) AS PROVIDER_NM, RD.COUNTY_CD, RD.RECEIVABLE_DETAIL_ID'||		    	
			'    FROM tb_RECEIVABLE_HEADER RH,'||
			'	 	tb_RECEIVABLE_DETAIL RD,'||
			'	 	tb_PAYMENT_DETAIL PD'||
			' WHERE  RH.RECEIVABLE_ID = RD.RECEIVABLE_ID'||
			'       AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID'||
			'       AND RH.DELETE_SW = ''N'''||
			'       AND RD.DELETE_SW = ''N'''||
			'       AND COALESCE(RD.MANUAL_SW, ''N'') = ''N'''||
			'       AND RD.RECEIVABLE_BALANCE_NO > 0'||
			'       AND DATE(RD.CREATE_TS) = CURRENT_DATE'||	
			'       AND ( SELECT  F_PRVPCKLST_CAT(RH.PROVIDER_ID,''PLACEMENT'')'||
			'		 ) NOT IN (''1783'',''1785'')'||
			' ORDER BY RH.PROVIDER_ID,'||
			'	 PD.CLIENT_ID,'||
			'	 PD.CASE_ID ' ;--
		ELSE
			vs_cursor_sql := ' SELECT RH.PROVIDER_ID, PD.CLIENT_ID, PD.CASE_ID,'||
			'	 			F_ENAME(''2953'', RH.PROVIDER_ID) AS PROVIDER_NM, RD.COUNTY_CD, RD.RECEIVABLE_DETAIL_ID, PD.SUBSIDY_AGREEMENT_ID'||		    	
			'    FROM tb_RECEIVABLE_HEADER RH,'||
			'	 	tb_RECEIVABLE_DETAIL RD,'||
			'	 	tb_PAYMENT_DETAIL PD'||
			' WHERE  RH.RECEIVABLE_ID = RD.RECEIVABLE_ID'||
			'       AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID'||
			'       AND RH.DELETE_SW = ''N'''||
			'       AND RD.DELETE_SW = ''N'''||
			'       AND COALESCE(RD.MANUAL_SW, ''N'') = ''N'''||
			'       AND RD.RECEIVABLE_BALANCE_NO > 0'||
			'       AND DATE(RD.CREATE_TS) = CURRENT_DATE'||	
			'       AND ( SELECT  F_PRVPCKLST_CAT(RH.PROVIDER_ID,''PLACEMENT'')'||
			'		 ) IN (''1783'',''1785'')'||
			' ORDER BY RH.PROVIDER_ID,'||
			'	 PD.CLIENT_ID,'||
			'	 PD.CASE_ID ' ;--
		END IF;--
	END IF;--

	vl_row_cnt := 0; -- INITIAL VALUE
	IF al_system_ticlker_id = 425 THEN
		SELECT COUNT(*)
			INTO vl_row_cnt
		FROM tb_PAYMENT_HEADER  PH
		WHERE COALESCE(PH.OFFSET_AMOUNT_NO, 0) > 0
			AND PH.DELETE_SW = 'N'
			AND PH.PAYMENT_TYPE_CD = '6'
			AND PH.PAYMENT_START_DT = vd_previous_month_start_dt ;--
 	
	ELSEIF al_system_ticlker_id = 42 THEN
		IF as_provider_type = 'PVT' THEN
			SELECT COUNT(*)
				INTO vl_row_cnt
			FROM tb_RECEIVABLE_HEADER RH,
				tb_RECEIVABLE_DETAIL RD,
				tb_PAYMENT_DETAIL PD
			WHERE  RH.RECEIVABLE_ID = RD.RECEIVABLE_ID
				AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID
				AND RH.DELETE_SW = 'N'
				AND RD.DELETE_SW = 'N'
				AND COALESCE(RD.MANUAL_SW, 'N') = 'N'
				AND RD.RECEIVABLE_BALANCE_NO > 0
				AND DATE(RD.CREATE_TS) = CURRENT_DATE
				AND ( SELECT  F_PRVPCKLST_CAT(RH.PROVIDER_ID,'PLACEMENT')
						 ) NOT IN ('1783','1785');--
		ELSE
			SELECT COUNT(*)
				INTO vl_row_cnt
			FROM tb_RECEIVABLE_HEADER RH,
				tb_RECEIVABLE_DETAIL RD,
				tb_PAYMENT_DETAIL PD
			WHERE  RH.RECEIVABLE_ID = RD.RECEIVABLE_ID
				AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID
				AND RH.DELETE_SW = 'N'
				AND RD.DELETE_SW = 'N'
				AND COALESCE(RD.MANUAL_SW, 'N') = 'N'
				AND RD.RECEIVABLE_BALANCE_NO > 0
				AND DATE(RD.CREATE_TS) = CURRENT_DATE
				AND ( SELECT  F_PRVPCKLST_CAT(RH.PROVIDER_ID,'PLACEMENT')
						 ) IN ('1783','1785');--

		END IF;--
	END IF;	--

	--PREPARE s1 FROM vs_cursor_sql;--
	--OPEN CUR_OVERPAYMENTS;--
	--OVERPAYMENT:
	OPEN CUR_OVERPAYMENTS FOR EXECUTE vs_cursor_sql;--
	<<OVERPAYMENT>>
	loop EXIT WHEN vl_row_cnt = 0::bigint ;
		--WHILE vl_row_cnt > 0  DO
		vl_provider_id := NULL; -- INITIAL VALUE
		vl_client_id := NULL; -- INITIAL VALUE
		vs_provider_nm := NULL; -- INITIAL VALUE
		vs_county_cd := NULL; -- INITIAL VALUE
		vdc_offset_amt := NULL; -- INITIAL VALUE
		vl_ENTITY_ID1 := NULL; -- INITIAL VALUE
		vl_ENTITY_ID2 := NULL; -- INITIAL VALUE
		vl_subsidy_agreement_id := NULL; -- INITIAL VALUE

		IF al_system_ticlker_id = 42 THEN		
			IF as_provider_type = 'PUB' THEN
				FETCH CUR_OVERPAYMENTS INTO vl_provider_id, 
											vl_client_id, 
											vl_ENTITY_ID2, 
											vs_provider_nm, 
											vs_county_cd, 
											vl_ENTITY_ID1, 
											vl_subsidy_agreement_id;--
			ELSE
				FETCH CUR_OVERPAYMENTS INTO vl_provider_id, 
											vl_client_id, 
											vl_ENTITY_ID2, 
											vs_provider_nm, 
											vs_county_cd, 
											vl_ENTITY_ID1;--
			END IF;--
		ELSEIF al_system_ticlker_id = 425 THEN		
			FETCH CUR_OVERPAYMENTS INTO vl_provider_id, 
									vs_provider_nm, 
									vdc_offset_amt, 
									vl_ENTITY_ID1;--
		END IF;--

		IF vl_row_cnt = 0 THEN
			--LEAVE OVERPAYMENT;--
		END IF;--

		vl_placement_cnt := 0; -- INITIAL VALUE	

		IF al_system_ticlker_id = 42 THEN
			IF as_provider_type = 'PUB' AND vl_subsidy_agreement_id > 0 THEN
				 vs_tickler_tx := 'A Subsidy/GAP overpayment has occurred for the provider ' || vs_provider_nm || '. Send Overpayment Notice (Recovery).';	--
			ELSE
				SELECT COUNT(*)
					INTO vl_placement_cnt
				FROM tb_PLACEMENT
				WHERE ( PROVIDER_ID = vl_provider_id OR PROVIDER_ORGANIZATION_ID = vl_provider_id )
					AND ENTRY_DT IS NOT NULL
					AND (EXIT_DT IS NULL OR EXIT_DT > CURRENT_DATE)
					AND (VOID_SW is NULL OR VOID_SW = 'N' OR RTRIM(LTRIM(VOID_SW)) = '' )
					AND DELETE_SW = 'N' ;--
				
				IF vl_placement_cnt > 0 THEN -- Active Provider	
					 vs_tickler_tx := 'An overpayment has occurred for Active provider ' || vs_provider_nm || '. Send Overpayment Notice (FM210R).';--
				ELSE -- Incative Provider
					 vs_tickler_tx := 'An overpayment has occurred for Inactive provider ' || vs_provider_nm || '. Send Overpayment Notice (Recovery).';--
				END IF;--
			END IF;	--
		ELSEIF al_system_ticlker_id = 425 THEN
			vs_tickler_tx := 'A/R Offset: $ ' || REPLACE(LTRIM(REPLACE(LTRIM(RTRIM((vdc_offset_amt)::character varying)),'0',' ')),' ','0') || ' has been offset from the ' || to_char(vd_previous_month_start_dt, 'Month') || ' payment for Provider ' || RTRIM(LTRIM((vl_provider_id)::character varying)) || ' ' || RTRIM(LTRIM(vs_provider_nm)) || '. This tickler will automatically expire and be removed in 30 days.';--
		END IF;--
	
		ll_tickler_cnt := 0; -- INITIAL VALUE
	
		IF al_system_ticlker_id = 42 THEN
              
			SELECT COUNT(*)
				INTO ll_tickler_cnt		
			FROM tb_TICKLERS
			WHERE tb_TICKLERS.ENTITY_TYPE_CD = '2953'
				AND tb_TICKLERS.ENTITY_KEY_ID = vl_provider_id
				AND tb_TICKLERS.CLIENT_ID = vl_client_id
				AND tb_TICKLERS.DELETE_SW = 'N'
				AND tb_TICKLERS.EXPIRY_DT > CURRENT_DATE
				AND tb_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
				AND tb_TICKLERS.ENTITY_ID2 = vl_ENTITY_ID2 
				AND DATE(tb_TICKLERS.CREATE_TS) <> CURRENT_DATE ;--

			-- Delete Existing Tickler and Create New 	
			IF ll_tickler_cnt > 0 THEN
				UPDATE tb_TICKLERS
					SET DELETE_SW = 'Y' 
				WHERE tb_TICKLERS.ENTITY_TYPE_CD = '2953'
					AND tb_TICKLERS.ENTITY_KEY_ID = vl_provider_id
					AND tb_TICKLERS.CLIENT_ID = vl_client_id
					AND tb_TICKLERS.DELETE_SW = 'N'
					AND tb_TICKLERS.EXPIRY_DT > CURRENT_DATE
					AND tb_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
					AND tb_TICKLERS.ENTITY_ID2 = vl_ENTITY_ID2 
					AND DATE(tb_TICKLERS.CREATE_TS) <> CURRENT_DATE ;--
			   
				 al_sqlcode := SQLCODE;--
				IF al_sqlcode < 0 THEN
					 as_error := 'Error in Deleting A/R Tickler for Provider ID ' || (vl_provider_id)::character varying  ;--
					 vs_identity_column := 'SysTickler ID/Case ID';--
					 vs_identity_val := (al_system_ticlker_id)::character varying || '/ ' || (vl_ENTITY_ID2)::character varying;--
					--SIGNAL p_sp_error  ;--
				END IF;--
			END IF;	         --

			ll_tickler_cnt := 0; -- INITIAL VALUE
        
			SELECT COUNT(*)
				INTO ll_tickler_cnt		
			FROM tb_TICKLERS
			WHERE tb_TICKLERS.ENTITY_TYPE_CD = '2953'
				AND tb_TICKLERS.ENTITY_KEY_ID = vl_provider_id
				AND tb_TICKLERS.CLIENT_ID = vl_client_id
				AND tb_TICKLERS.DELETE_SW = 'N'
				AND tb_TICKLERS.EXPIRY_DT > CURRENT_DATE
				AND tb_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
				AND tb_TICKLERS.ENTITY_ID2 = vl_ENTITY_ID2 
				AND DATE(tb_TICKLERS.CREATE_TS) = CURRENT_DATE ;--
		   
		ELSEIF al_system_ticlker_id = 425 THEN
			SELECT COUNT(*)
				INTO ll_tickler_cnt		
			FROM tb_TICKLERS
			WHERE tb_TICKLERS.ENTITY_TYPE_CD = '2953'
				AND tb_TICKLERS.ENTITY_KEY_ID = vl_provider_id
				AND tb_TICKLERS.DELETE_SW = 'N'
				AND tb_TICKLERS.EXPIRY_DT > CURRENT_DATE
				AND tb_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
				AND tb_TICKLERS.ENTITY_ID1 = vl_ENTITY_ID1 ;--
		END IF;--
	
		IF ll_tickler_cnt = 0 THEN
	
			vl_staff_id := NULL; -- INITIAL VALUE
			-- Tb_assignment and tb_staff are old tables. 
			-- SELECT ASG.ASSIGN_TO_STAFF_ID,
			-- 		STA.PRIMARY_COUNTY_CD,
			-- 		STA.PRIMARY_COUNTY_UNIT_ID
			-- INTO vl_staff_id,
			-- 	vs_to_county_cd,
			-- 	vl_to_unit_id
			-- FROM tb_ASSIGNMENT ASG,
			-- 	 tb_STAFF STA	
			-- WHERE ASG.ASSIGN_TO_STAFF_ID = STA.STAFF_ID AND
			-- 	ASG.ENTITY_KEY_ID = vl_provider_id  AND
			-- 	ASG.RESPONSIBILITY_CD = 'P' AND
			-- 	ASG.ENTITY_TYPE_CD = '2953' AND
			-- 	ASG.DELETE_SW = 'N' AND
			-- 	ASG.END_DT IS NULL
			-- ORDER BY ASG.ASSIGNMENT_ID DESC ;--
			-- Added new logics to get the county
			vl_staff_id := null;
			vs_to_county_cd = null;
			vl_to_unit_id := null;

			select count(*) 
				into v_provider_count 
			from tb_provider_picklist 
			where provider_id = vl_provider_id 
				and picklist_type_id = 155 
				and trim(picklist_value_cd) in ('3049','3274','3302','3794');
			
			IF (v_provider_count > 0) THEN
				vs_to_county_cd = '3824';
			END IF;

			IF vs_to_county_cd is NULL THEN
				 vs_to_county_cd := vs_county_cd;--
			END IF;--

			vs_assign_to_county_cd := NULL;--
			vl_assign_to_unit_id := NULL;--

			IF vs_nature = '2523' OR vs_nature = '2532' THEN -- Fiscal Ticklers

				vs_assign_to_county_cd := vs_to_county_cd;	--
				vl_to_unit_id := NULL;--

				SELECT COUNTY_UNIT_ID
					INTO vl_to_unit_id
				FROM tb_COUNTY_UNIT
				WHERE COUNTY_CD = vs_to_county_cd
					AND UNIT_CD = '8109'
					AND DELETE_SW = 'N' ;--

			END IF;--

			vl_tickler_id := 0; -- INITIAL VALUE
			--SELECT SP_nextid(vs_tickler_col,vl_tickler_id);--
			SELECT SP_nextid(vs_tickler_col) INTO vl_tickler_id;--
			INSERT INTO tb_TICKLERS
				 ( TICKLER_ID,
				   TICKLER_TX,
				   TICKLER_TYPE_SW,
				   DUE_DT,
				   REMINDER_START_DT,
				   ENTITY_TYPE_CD,
				   ENTITY_KEY_ID,
				   ENTITY_NM,
				   ASSIGNED_TO_STAFF_ID,
				   CLIENT_ID,
				   CREATE_TS,
				   CREATE_USER_ID,
				   UPDATE_TS,
				   UPDATE_USER_ID,
				   DELETE_SW,
				   COUNTY_CD,
				   COUNTY_UNIT_ID,
				   SYSTEM_TICKLER_ID,
				   TICKLER_NATURE_CD,
				   ASSIGN_TO_COUNTY_CD,
				   ASSIGN_TO_UNIT_ID,
				   EXPIRY_DT,
				   ENTITY_ID1,
				   ENTITY_ID2,
				   SCREEN_CD )
			VALUES ( vl_tickler_id,
				   vs_tickler_tx,
				   'S',
				   vd_due_dt,
				   vd_reminder_dt,
				   vs_entity_type,
				   vl_provider_id,
				   vs_provider_nm,
				   vl_staff_id,
				   vl_client_id,
				   CURRENT_TIMESTAMP,
				   'finance',
				   CURRENT_TIMESTAMP,
				   'finance',
				   'N',
				   vs_to_county_cd,
				   vl_to_unit_id,
				   al_system_ticlker_id,
				   vs_nature,
				   vs_assign_to_county_cd,
				   vl_assign_to_unit_id,
				   vd_expiry_dt,
				   vl_ENTITY_ID1,
				   vl_ENTITY_ID2,
				   vs_screen_cd )  ;--

			al_sqlcode := SQLCODE;--
			IF al_sqlcode <> 0 THEN
				IF al_system_ticlker_id = 42 THEN	
					 as_error := 'Error in generating A/R Tickler for Provider ID ' || (vl_provider_id)::character varying  ;--
					 vs_identity_column := 'SysTickler ID/RecDetl ID';--
				ELSEIF al_system_ticlker_id = 425 THEN	
					 as_error := 'Error in generating Offset Tickler for Provider ID ' || (vl_provider_id)::character varying  ;--
					 vs_identity_column := 'SysTickler ID/Payment ID';--
				END IF;--
				 vs_identity_val = (al_system_ticlker_id)::character varying || '/ ' || (vl_ENTITY_ID1)::character varying;--
				--SIGNAL p_sp_error  ;--
			END IF ;--

			--COMMIT;			--
		END IF;	--
		vl_row_cnt := vl_row_cnt  - 1;	--
		--END WHILE ;--
	END loop;
CLOSE CUR_OVERPAYMENTS ;--
return 1;
END 
;

$function$
;
