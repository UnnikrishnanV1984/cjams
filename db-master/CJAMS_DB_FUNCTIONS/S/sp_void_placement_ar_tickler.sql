-- FUNCTION: cjams.sp_void_placement_ar_tickler(date, bigint)

 DROP FUNCTION if exists cjams.sp_void_placement_ar_tickler(date, bigint);

CREATE OR REPLACE FUNCTION cjams.sp_void_placement_ar_tickler(
	ad_run_dt date,
	al_system_ticlker_id bigint)
    RETURNS void
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      :  Vineet Tirodkar
-- Date        :  07/30/2010
-- Description :  To Create Void Placement A/R Ticklers # 439 for System created Overpayment Entries
-- Arguments   : 1) Run Date
--               2) System Tickler ID (Currently used for # 439)

-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------

DECLARE vs_cursor_sql VARCHAR(12000) ;--
DECLARE vs_option VARCHAR(1) DEFAULT 'I' ;--
DECLARE vs_entity_type VARCHAR(5) DEFAULT '2955' ;--
DECLARE vs_tickler_tx VARCHAR(500);--
--DECLARE vl_days_no BIGINT;--
vl_days_no INTEGER;--
--DECLARE vl_reminder_days BIGINT;--
vl_reminder_days INTEGER;--
DECLARE vs_nature VARCHAR(5);--
--DECLARE vl_expiry BIGINT;--
 vl_expiry INTEGER;--
DECLARE vd_due_dt DATE;--
DECLARE vd_reminder_dt DATE;--
DECLARE vd_expiry_dt DATE;--
DECLARE vs_client_nm VARCHAR(100);--
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
DECLARE vl_ENTITY_ID1 BIGINT DEFAULT 0;--
DECLARE vl_ENTITY_ID2 BIGINT DEFAULT 0;--

--Log Error
DECLARE SQLCODE INT DEFAULT 0;--
DECLARE al_sqlcode INT DEFAULT 0;--
DECLARE as_error VARCHAR(3000);--
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';--
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);--
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';--
DECLARE vl_ret_status INTEGER DEFAULT 0;--
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_VOID_PLACEMENT_AR_TICKLER';--
DECLARE vs_identity_column VARCHAR(100);--
DECLARE vs_identity_val VARCHAR(100);--
--Log Error

--DECLARE CUR_OVERPAYMENTS CURSOR WITH HOLD FOR s1;--

CUR_OVERPAYMENTS REFCURSOR;--
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
begin
	EXCEPTION WHEN OTHERS THEN
   -- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
--    SET al_sqlcode = -1 ;--
     as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
     as_error := COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');--
     as_error := as_error || COALESCE(vs_message_text ,'');--

    select cjams.SP_BATCH_ERROR_LOG ( 'SP_VOID_PLACEMENT_AR_TICKLER',
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
END;--
--Log error

SELECT DAYS_NO,
       REMINDER_DAYS_NO,
       SYSTEM_TICKLER_TX,
       TICKLER_NATURE_CD,
       EXPIRE_AFTER_DAYS
INTO   vl_days_no,
       vl_reminder_days,
       vs_tickler_tx,
       vs_nature,
       vl_expiry
FROM TB_SYSTEM_TICKLERS
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

SELECT ( CURRENT_DATE + vl_days_no  ) AS DUE_DT,
       ( CURRENT_DATE + vl_days_no  ) - vl_reminder_days  AS REMD_DT,
       ( CURRENT_DATE + vl_days_no  ) + vl_expiry  AS EXP_DT
   INTO vd_due_dt,
    	vd_reminder_dt,
        vd_expiry_dt;

 		
 vs_cursor_sql := ''; -- INITIAL VALUE
IF al_system_ticlker_id = 439 THEN
    vs_cursor_sql :=
  ' SELECT RH.PROVIDER_ID, '||
  '        PD.CLIENT_ID, '||
  '        PD.CASE_ID,'||
  '        F_ENAME(''2955'', PD.CLIENT_ID) AS CLIENT_NM, '||
  '        RD.COUNTY_CD '||
  ' FROM TB_RECEIVABLE_HEADER RH,'||
  '      TB_RECEIVABLE_DETAIL RD,'||
  '      TB_PAYMENT_DETAIL PD '||
  '  WHERE RH.RECEIVABLE_ID = RD.RECEIVABLE_ID '||
  ' 	 AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID '||
  ' 	 AND RH.DELETE_SW = ''N'' '||
  ' 	 AND RD.DELETE_SW = ''N'' '||
  ' 	 AND COALESCE(RD.MANUAL_SW, ''N'') = ''N'' '||
  ' 	 AND RD.RECEIVABLE_BALANCE_NO > 0 '||
  ' 	 AND DATE(RD.CREATE_TS) = '''|| TO_CHAR(ad_run_dt:: DATE, 'mm/dd/yyyy') ||''' '||
  ' 	 AND PD.PLACEMENT_ID in ( SELECT DISTINCT PLACEMENT_ID '||
  ' 				     FROM TB_PLACEMENT '||
  ' 				   WHERE DELETE_SW = ''N'' '||
  ' 					 AND VOID_SW IS NOT NULL '||
  ' 					 AND VOID_SW = ''Y'' '||
  ' 					 AND VOID_APPROVAL_DT = '''|| TO_CHAR(ad_run_dt:: DATE, 'mm/dd/yyyy') ||''' '||
  ' 				)  '||
  '  ORDER BY RH.PROVIDER_ID, '||
  '   	     PD.CLIENT_ID, '||
  ' 	     PD.CASE_ID ' ;--
END IF;--

 vl_row_cnt := 0; -- INITIAL VALUE
IF al_system_ticlker_id = 439 THEN
  SELECT COUNT(*)
    INTO vl_row_cnt
  FROM TB_RECEIVABLE_HEADER RH,
       TB_RECEIVABLE_DETAIL RD,
       TB_PAYMENT_DETAIL PD
  WHERE RH.RECEIVABLE_ID = RD.RECEIVABLE_ID
        AND PD.PAYMENT_DETAIL_ID = RD.PAYMENT_DETAIL_ID
        AND RH.DELETE_SW = 'N'
        AND RD.DELETE_SW = 'N'
        AND COALESCE(RD.MANUAL_SW, 'N') = 'N'
        AND RD.RECEIVABLE_BALANCE_NO > 0
        AND DATE(RD.CREATE_TS) = ad_run_dt
        AND PD.PLACEMENT_ID in ( SELECT DISTINCT PLACEMENT_ID
				   FROM TB_PLACEMENT
			         WHERE DELETE_SW = 'N'
				     AND VOID_SW IS NOT NULL
				     AND VOID_SW = 'Y'
				     AND VOID_APPROVAL_DT = ad_run_dt
			      ) ;--

END IF;	--

--PREPARE s1 FROM vs_cursor_sql;--
--OPEN CUR_OVERPAYMENTS;--
--OVERPAYMENT:
OPEN CUR_OVERPAYMENTS FOR EXECUTE vs_cursor_sql;--
<<OVERPAYMENT>>
--WHILE vl_row_cnt > 0  DO
loop EXIT WHEN vl_row_cnt = 0::bigint ;

     vl_provider_id := NULL; -- INITIAL VALUE
     vl_client_id := NULL; -- INITIAL VALUE
     vs_client_nm := NULL; -- INITIAL VALUE
     vs_county_cd := NULL; -- INITIAL VALUE
     vl_ENTITY_ID1 := NULL; -- INITIAL VALUE
     vl_ENTITY_ID2 := NULL; -- INITIAL VALUE

    IF al_system_ticlker_id = 439 THEN		
    	FETCH CUR_OVERPAYMENTS INTO vl_provider_id, vl_client_id, vl_ENTITY_ID1, vs_client_nm, vs_county_cd ;--
    END IF;--

    IF vl_row_cnt = 0 THEN
    	--LEAVE OVERPAYMENT;--
    END IF;--

     ll_tickler_cnt := 0; -- INITIAL VALUE
	
    IF al_system_ticlker_id = 439 THEN

       SELECT COUNT(*)
	       INTO ll_tickler_cnt		
	     FROM TB_TICKLERS
	   WHERE TB_TICKLERS.ENTITY_TYPE_CD = '2955'
	      AND TB_TICKLERS.ENTITY_KEY_ID = vl_client_id
	      AND TB_TICKLERS.DELETE_SW = 'N'
	      AND TB_TICKLERS.EXPIRY_DT > CURRENT_DATE
	      AND TB_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
	      AND TB_TICKLERS.ENTITY_ID1 = vl_ENTITY_ID1
	      AND DATE(TB_TICKLERS.CREATE_TS) <> ad_run_dt ;--
	
       -- Delete Existing Tickler and Create New 	
       IF ll_tickler_cnt > 0 THEN
          UPDATE TB_TICKLERS
       	      SET DELETE_SW = 'Y'
       	   WHERE TB_TICKLERS.ENTITY_TYPE_CD = '2955'
       	      AND TB_TICKLERS.ENTITY_KEY_ID = vl_client_id
       	      AND TB_TICKLERS.DELETE_SW = 'N'
       	      AND TB_TICKLERS.EXPIRY_DT > CURRENT_DATE
       	      AND TB_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
	      AND TB_TICKLERS.ENTITY_ID1 = vl_ENTITY_ID1
	      AND DATE(TB_TICKLERS.CREATE_TS) <> ad_run_dt ;--

           al_sqlcode := SQLCODE;--
          IF al_sqlcode < 0 THEN
              as_error := 'Error in Deleting A/R 439 Tickler for Provider ID ' || (vl_provider_id)::character varying  ;--
       	      vs_identity_column := 'Case ID/Client ID';--
    	      vs_identity_val := (vl_ENTITY_ID1)::character varying || '/ ' || (vl_client_id)::character varying;--
	    -- SIGNAL p_sp_error  ;--
          END IF;--
        END IF;	--

         ll_tickler_cnt := 0; -- INITIAL VALUE

    	SELECT COUNT(*)
       	       INTO ll_tickler_cnt		
       	     FROM TB_TICKLERS
       	   WHERE TB_TICKLERS.ENTITY_TYPE_CD = '2955'
       	      AND TB_TICKLERS.ENTITY_KEY_ID = vl_client_id
       	      AND TB_TICKLERS.DELETE_SW = 'N'
       	      AND TB_TICKLERS.EXPIRY_DT > CURRENT_DATE
       	      AND TB_TICKLERS.SYSTEM_TICKLER_ID = al_system_ticlker_id
       	      AND TB_TICKLERS.ENTITY_ID1 = vl_ENTITY_ID1
	      AND DATE(TB_TICKLERS.CREATE_TS) = ad_run_dt ;--

    END IF;--
	
    IF ll_tickler_cnt = 0 THEN
	
 	 vl_staff_id := NULL; -- INITIAL VALUE

	SELECT ASG.ASSIGN_TO_STAFF_ID,
	       STA.PRIMARY_COUNTY_CD,
	       STA.PRIMARY_COUNTY_UNIT_ID
	    INTO vl_staff_id,
		 vs_to_county_cd,
    		 vl_to_unit_id
	   FROM TB_ASSIGNMENT ASG,
	    	TB_STAFF STA	
	WHERE ASG.ASSIGN_TO_STAFF_ID = STA.STAFF_ID AND
	      ASG.ENTITY_KEY_ID = vl_provider_id  AND
	      ASG.RESPONSIBILITY_CD = 'P' AND
	      ASG.ENTITY_TYPE_CD = '2953' AND
	      ASG.DELETE_SW = 'N' AND
	      ASG.END_DT IS NULL
	ORDER BY ASG.ASSIGNMENT_ID DESC ;--

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
	      FROM TB_COUNTY_UNIT
	   WHERE COUNTY_CD = vs_to_county_cd
	   	 AND UNIT_CD = '8109'
	   	 AND DELETE_SW = 'N' ;--

	END IF;--

	 vl_tickler_id := 0; -- INITIAL VALUE
	 vs_tickler_col:='sq_ticklers';
	--SELECT sp_nextid(vs_tickler_col,vl_tickler_id);--
SELECT sp_nextid(vs_tickler_col::character varying) into vl_tickler_id;
		  INSERT INTO TB_TICKLERS
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
			 -- NEXTVAL('sq_ticklers'),
			   vs_tickler_tx,
			   'S',
			   vd_due_dt,
			   vd_reminder_dt,
			   vs_entity_type,
			   vl_client_id,
			   vs_client_nm,
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
		    as_error := 'Error in generating A/R 439 Tickler for Provider ID ' || (vl_provider_id)::character varying  ;--
		    vs_identity_column := 'Case ID/Client ID';--
		    vs_identity_val := (vl_ENTITY_ID1)::character varying || '/ ' || (vl_client_id)::character varying;--
		  -- SIGNAL p_sp_error  ;--
		END IF ;--

		--COMMIT;			--
    END IF;	--
 vl_row_cnt := vl_row_cnt  - 1;	--
--END WHILE ;--
END LOOP;
--CLOSE CUR_OVERPAYMENTS ;--
close CUR_OVERPAYMENTS;
END;

$BODY$;


