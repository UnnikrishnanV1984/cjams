CREATE OR REPLACE FUNCTION cjams.sp_susbsidy_receivables(as_type_flag character, ad_run_dt date, OUT al_sqlcode integer, OUT as_error character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

						
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      :  Vineet Tirodkar
-- Date        :  09/17/2015
-- Description :  PRJ-05327 - MD CHESSIE Fiscal Phases 2 
--				  To create Adoption Subsidy and GAP A/Rs beyond max rate end date

-- Arguments   : 1) IN as_type_flag CHAR(1) - 'A' for Adoption Subsidy and 'G' for GAP 
--				 2) IN ad_run_dt DATE	
-- Revision(s)
-- 11/10/2020 - Vineet Tirodkar - Modifications to create ARs for prior to GAP start date period
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------

--	Log Error
DECLARE SQLCODE INT DEFAULT 0;
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';
DECLARE vl_ret_status INTEGER DEFAULT 0;
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_SUSBSIDY_RECEIVABLES';
DECLARE vs_identity_column VARCHAR(100);
DECLARE vs_identity_val VARCHAR(100);

DECLARE  vs_change_type 		VARCHAR(5);

DECLARE vdc_old_receivable_no	DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_receivable_amount	DECIMAL(10,2) DEFAULT 0.00;

DECLARE vl_provider_id 			BIGINT;
DECLARE vl_payment_detail_id	BIGINT;
DECLARE vl_client_id			BIGINT;
DECLARE vl_adoption_id			BIGINT;

DECLARE vl_cjams_county 		INTEGER DEFAULT 0;

DECLARE vd_service_start_dt		DATE;
DECLARE vd_service_end_dt		DATE;

CUR_OVER_ADOPTION record;
CUR_OVER_ADOPTION_refcur REFCURSOR;	
CUR_OVER_GAP record;
CUR_OVER_GAP_refcur REFCURSOR;
 
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
begin
	EXCEPTION WHEN OTHERS THEN
   -- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;

    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
     as_error = COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;
     as_error = COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');
     as_error = as_error || COALESCE(vs_message_text ,'');
	
	SELECT SP_BATCH_ERROR_LOG (	vs_Procedure_nm,
                                NULL::bigint,
								NULL::bigint,
								NULL::character varying,
								NULL::INTEGER,
								NULL::character varying,
								SQLSTATE::character varying,
								as_error::character varying,
								'finance'::character varying) 
	INTO
		vl_ret_status;
									 
     as_error := '';
END;
-- Log error

-- INITILA VALUE
 al_sqlcode := 0;

IF as_type_flag = 'A' THEN
	-- Adoption Subsidy Payments beyond Subsidy Dates - main cursor - START
	-- FOR CUR_OVER_ADOPTION AS
	OPEN CUR_OVER_ADOPTION_refcur FOR
		SELECT PH.PROVIDER_ID,
			   PD.PAYMENT_DETAIL_ID,
			   PD.FINAL_AMOUNT_NO,
			   PD.CLIENT_ID,
			   PD.FINAL_SERVICE_START_DT,
			   PD.FINAL_SERVICE_END_DT,
			   tb_SUB.ADOPTION_ID,
			   '1013' AS CHANGE_TYPE  -- Adoption Subsidy Rate Changes
		FROM ( SELECT TA.ADOPTION_ID,
					  MAX(TAS.AGREEMENT_END_DT) AS MAX_RATE_END_DT
			   FROM tb_ADOPTION TA,
					tb_ADOPTION_SUBSIDY_AGREEMENT TAS
			   WHERE TA.ADOPTION_ID = TAS.ADOPTION_ID
				AND TA.DELETE_SW = 'N'
				AND TAS.DELETE_SW = 'N'
				AND TAS.PROVIDER_ID IS NOT NULL
				AND TAS.APPROVAL_STATUS_CD = '3047'
				AND DATE(TAS.UPDATE_TS) = ad_run_dt
			GROUP BY TA.ADOPTION_ID
				) AS tb_SUB,
			 tb_PAYMENT_DETAIL PD,
			 tb_PAYMENT_HEADER PH,
			 tb_PAYMENT_STATUS PS
		WHERE tb_SUB.ADOPTION_ID = PD.SUBSIDY_AGREEMENT_ID
			  AND PH.PAYMENT_ID = PD.PAYMENT_ID
			  AND PH.PAYMENT_ID = PS.PAYMENT_ID 
			  AND PD.DELETE_SW = 'N'
			  AND PH.DELETE_SW = 'N'
			  AND PS.DELETE_SW = 'N'	  
			  AND PH.PAYMENT_TYPE_CD IN ('5689', '3294')
			  AND PD.FINAL_SERVICE_ID = 501
			  AND PD.FINAL_AMOUNT_NO <> 0
			  AND PD.FINAL_SERVICE_START_DT > tb_SUB.MAX_RATE_END_DT
			  AND tb_SUB.MAX_RATE_END_DT NOT BETWEEN PH.PAYMENT_START_DT AND PH.PAYMENT_END_DT 
			  AND tb_SUB.MAX_RATE_END_DT IS NOT NULL
			  AND PS.PAYMENT_STATUS_CD = '1636'	 
		UNION ALL
		SELECT PH.PROVIDER_ID,
			   PD.PAYMENT_DETAIL_ID,
			   PD.FINAL_AMOUNT_NO,
			   PD.CLIENT_ID,
			   PD.FINAL_SERVICE_START_DT,
			   PD.FINAL_SERVICE_END_DT,
			   tb_SUB.ADOPTION_ID,
			   '1013' AS CHANGE_TYPE  -- Adoption Subsidy Rate Changes
		FROM (  SELECT TA.ADOPTION_ID,
					  TA.SUBSIDY_START_DT
				FROM tb_ADOPTION TA,
					tb_ADOPTION_SUBSIDY_AGREEMENT TAS
				WHERE TA.ADOPTION_ID = TAS.ADOPTION_ID
					AND TA.DELETE_SW = 'N'
					AND TAS.DELETE_SW = 'N'
					AND TAS.PROVIDER_ID IS NOT NULL
					AND TAS.APPROVAL_STATUS_CD = '3047'
					AND DATE(TAS.UPDATE_TS) = ad_run_dt ) AS tb_SUB,
			 tb_PAYMENT_DETAIL PD,
			 tb_PAYMENT_HEADER PH,
			 tb_PAYMENT_STATUS PS
		WHERE tb_SUB.ADOPTION_ID = PD.SUBSIDY_AGREEMENT_ID
			  AND PH.PAYMENT_ID = PD.PAYMENT_ID
			  AND PH.PAYMENT_ID = PS.PAYMENT_ID 
			  AND PD.DELETE_SW = 'N'
			  AND PH.DELETE_SW = 'N'
			  AND PS.DELETE_SW = 'N'	  
			  AND PH.PAYMENT_TYPE_CD IN ('5689', '3294')
			  AND PD.FINAL_SERVICE_ID = 501
			  AND PD.FINAL_AMOUNT_NO <> 0
			  AND PD.FINAL_SERVICE_START_DT < tb_SUB.SUBSIDY_START_DT
			  AND tb_SUB.SUBSIDY_START_DT NOT BETWEEN PH.PAYMENT_START_DT AND PH.PAYMENT_END_DT 
			  AND tb_SUB.SUBSIDY_START_DT IS NOT NULL
			  AND PS.PAYMENT_STATUS_CD = '1636'	 ;
	--DO
	loop
	fetch CUR_OVER_ADOPTION_refcur into CUR_OVER_ADOPTION;
	exit when not found;
		-- INITIAL VALUES
		 vl_provider_id := NULL;
		 vl_payment_detail_id := NULL;
		 vdc_receivable_amount := NULL;
		 vl_client_id := NULL;
		 vd_service_start_dt := NULL;
		 vd_service_end_dt := NULL;
		 vl_adoption_id := NULL;
		 vs_change_type := NULL;

		 vl_provider_id := CUR_OVER_ADOPTION.PROVIDER_ID;
		 vl_payment_detail_id := CUR_OVER_ADOPTION.PAYMENT_DETAIL_ID;
		 vdc_receivable_amount := CUR_OVER_ADOPTION.FINAL_AMOUNT_NO;
		 vl_client_id := CUR_OVER_ADOPTION.CLIENT_ID;
		 vd_service_start_dt := CUR_OVER_ADOPTION.FINAL_SERVICE_START_DT;
		 vd_service_end_dt := CUR_OVER_ADOPTION.FINAL_SERVICE_END_DT;
		 vl_adoption_id := CUR_OVER_ADOPTION.ADOPTION_ID;
		 vs_change_type := CUR_OVER_ADOPTION.CHANGE_TYPE;
	  
		vdc_old_receivable_no  := 0;
		SELECT SUM(AMOUNT_NO)
			INTO vdc_old_receivable_no
		FROM tb_RECEIVABLE_DETAIL
		WHERE PAYMENT_DETAIL_ID = vl_payment_detail_id
			AND DELETE_SW = 'N';

		IF vdc_old_receivable_no is NULL THEN
			vdc_old_receivable_no  := 0;
		END IF;

		vdc_receivable_amount := vdc_receivable_amount - vdc_old_receivable_no;

		-- Check Case County
		-- SELECT COUNT(*)
		-- 	INTO vl_cjams_county
		-- FROM TB_ADOPTION
		-- WHERE ADOPTION_ID = vl_adoption_id
		-- 	AND DELETE_SW = 'N'
		-- 	AND (
		-- 		cjams.F_PRIM_COUNTY(CASE_ID,'NULL') IN 
		-- 		( select statecountycode from county where golivedate <= CURRENT_DATE ) OR
		-- 		cjams.F_CHECK_CASE_TRANSFER(CASE_ID) = 1
		-- 		)
		-- ;

		-- IF vl_cjams_county is NULL THEN 
		-- 	SET vl_cjams_county = 0;
		-- END IF;

		-- IF vdc_receivable_amount > 0 AND vl_cjams_county > 0 THEN -- GENERATE THE RECEIVABLE
		IF vdc_receivable_amount > 0 THEN -- GENERATE THE RECEIVABLE

			SELECT a.al_sqlcode,a.as_error from SP_OVER_PAYMENT ( vl_payment_detail_id,
											vl_client_id,
											vl_provider_id,
											vd_service_start_dt,
											vd_service_end_dt,
											vdc_receivable_amount,
											vs_change_type) a into
											al_sqlcode,
											as_error;

			IF al_sqlcode < 0 THEN
				 as_error := 'ADOPTION SUSBSIDY - SP_OVER_PAYMENT failed'  ;
				 vs_identity_column := 'Payment Detail ID';
				 vs_identity_val := (vl_payment_detail_id)::character varying;
				--SIGNAL p_sp_error  ;--
			END IF ;
		END IF;
		
	--END FOR;	 --
	END LOOP;
	-- Adoption Subsidy Payments beyond Subsidy Dates - main cursor - END

ELSE
	-- GAP Payments beyond Subsidy Dates - main cursor - START
	-- FOR CUR_OVER_GAP AS
	
	OPEN CUR_OVER_GAP_refcur FOR
		SELECT PH.PROVIDER_ID,
			   PD.PAYMENT_DETAIL_ID,
			   PD.FINAL_AMOUNT_NO,
			   PD.CLIENT_ID,
			   PD.FINAL_SERVICE_START_DT,
			   PD.FINAL_SERVICE_END_DT,
			   tb_SUB.GUARDIAN_SUBSIDY_ID,
			   '1011' AS CHANGE_TYPE  -- GAP Rate Changes
		FROM ( SELECT GS.GUARDIAN_SUBSIDY_ID,
					MAX(CASE WHEN GR.OVERRIDE_STATUS_CD IN ('3045','3046') 		
							AND GR.RATE_OVERRIDE_SW = 'Y' THEN 
							GR.RATE2_END_DT 
						ELSE 	
							GR.RATE_END_DT 
						END) AS MAX_RATE_END_DT
				FROM tb_GUARDIAN_SUBSIDY GS,
					tb_GAP_RATES GR
				WHERE GS.GUARDIAN_SUBSIDY_ID = GR.ASSISTANCE_ID
					AND GS.DELETE_SW = 'N'
					AND GR.DELETE_SW = 'N'
					AND GS.PROVIDER_ID IS NOT NULL
					AND GS.SUSBSIDY_APPROVAL_STATUS_CD = '3047'
					AND GR.APPROVAL_STATUS_CD = '3047'
					AND GR.UPDATE_TS::DATE = ad_run_dt
				GROUP BY GS.GUARDIAN_SUBSIDY_ID
				) AS tb_SUB,
			 tb_PAYMENT_DETAIL PD,
			 tb_PAYMENT_HEADER PH,
			 tb_PAYMENT_STATUS PS
		WHERE tb_SUB.GUARDIAN_SUBSIDY_ID = PD.SUBSIDY_AGREEMENT_ID
			  AND PH.PAYMENT_ID = PD.PAYMENT_ID
			  AND PH.PAYMENT_ID = PS.PAYMENT_ID 
			  AND PD.DELETE_SW = 'N'
			  AND PH.DELETE_SW = 'N'
			  AND PS.DELETE_SW = 'N'	  
			  AND PH.PAYMENT_TYPE_CD IN ( '7', '3294')	
			  AND PD.FINAL_SERVICE_ID = 503
			  AND PD.FINAL_AMOUNT_NO <> 0
			  AND PD.FINAL_SERVICE_START_DT > tb_SUB.MAX_RATE_END_DT
			  AND tb_SUB.MAX_RATE_END_DT NOT BETWEEN PH.PAYMENT_START_DT AND PH.PAYMENT_END_DT 
			  AND tb_SUB.MAX_RATE_END_DT IS NOT NULL
			  AND PS.PAYMENT_STATUS_CD = '1636'	 
		UNION ALL
		SELECT PH.PROVIDER_ID,
			   PD.PAYMENT_DETAIL_ID,
			   PD.FINAL_AMOUNT_NO,
			   PD.CLIENT_ID,
			   PD.FINAL_SERVICE_START_DT,
			   PD.FINAL_SERVICE_END_DT,
			   tb_SUB.GUARDIAN_SUBSIDY_ID,
			   '1011' AS CHANGE_TYPE  -- GAP Rate Changes
		FROM ( select GS.GUARDIAN_SUBSIDY_ID, 
					   GS.SUBSIDY_START_DT
				FROM tb_GUARDIAN_SUBSIDY GS,
					tb_GAP_RATES GR
				WHERE GS.GUARDIAN_SUBSIDY_ID = GR.ASSISTANCE_ID
					AND GS.DELETE_SW = 'N'
					AND GR.DELETE_SW = 'N'
					AND GS.PROVIDER_ID IS NOT NULL
					AND GS.SUSBSIDY_APPROVAL_STATUS_CD = '3047'
					AND GR.APPROVAL_STATUS_CD = '3047'
					AND GR.UPDATE_TS::DATE = ad_run_dt	 
				) AS tb_SUB,
			 tb_PAYMENT_DETAIL PD,
			 tb_PAYMENT_HEADER PH,
			 tb_PAYMENT_STATUS PS
		WHERE tb_SUB.GUARDIAN_SUBSIDY_ID = PD.SUBSIDY_AGREEMENT_ID
			  AND PH.PAYMENT_ID = PD.PAYMENT_ID
			  AND PH.PAYMENT_ID = PS.PAYMENT_ID 
			  AND PD.DELETE_SW = 'N'
			  AND PH.DELETE_SW = 'N'
			  AND PS.DELETE_SW = 'N'	  
			  AND PH.PAYMENT_TYPE_CD IN ( '7', '3294')	
			  AND PD.FINAL_SERVICE_ID = 503
			  AND PD.FINAL_AMOUNT_NO <> 0
			  AND PD.FINAL_SERVICE_START_DT < tb_SUB.SUBSIDY_START_DT
			  AND tb_SUB.SUBSIDY_START_DT NOT BETWEEN PH.PAYMENT_START_DT AND PH.PAYMENT_END_DT 
			  AND tb_SUB.SUBSIDY_START_DT IS NOT null
			  AND PS.PAYMENT_STATUS_CD = '1636'	 ;
		--DO
	loop
	fetch CUR_OVER_GAP_refcur into CUR_OVER_GAP;
	exit when not found;
		-- INITIAL VALUES
		 vl_provider_id := NULL;
		 vl_payment_detail_id := NULL;
		 vdc_receivable_amount := NULL;
		 vl_client_id := NULL;
		 vd_service_start_dt := NULL;
		 vd_service_end_dt := NULL;
		 vl_adoption_id := NULL;
		 vs_change_type := NULL;

		 vl_provider_id := CUR_OVER_GAP.PROVIDER_ID;
		 vl_payment_detail_id := CUR_OVER_GAP.PAYMENT_DETAIL_ID;
		 vdc_receivable_amount := CUR_OVER_GAP.FINAL_AMOUNT_NO;
		 vl_client_id := CUR_OVER_GAP.CLIENT_ID;
		 vd_service_start_dt := CUR_OVER_GAP.FINAL_SERVICE_START_DT;
		 vd_service_end_dt := CUR_OVER_GAP.FINAL_SERVICE_END_DT;
		 vl_adoption_id := CUR_OVER_GAP.GUARDIAN_SUBSIDY_ID;
		 vs_change_type := CUR_OVER_GAP.CHANGE_TYPE;
	  
		vdc_old_receivable_no  := 0;
		SELECT SUM(AMOUNT_NO)
			INTO vdc_old_receivable_no
		FROM tb_RECEIVABLE_DETAIL
		WHERE PAYMENT_DETAIL_ID = vl_payment_detail_id
			AND DELETE_SW = 'N';

		IF vdc_old_receivable_no is NULL THEN
			vdc_old_receivable_no  := 0;
		END IF;

		vdc_receivable_amount := vdc_receivable_amount - vdc_old_receivable_no;

		-- Check Case County
		-- SELECT COUNT(*)
		-- 	INTO vl_cjams_county
		-- FROM tb_GUARDIAN_SUBSIDY
		-- WHERE GUARDIAN_SUBSIDY_ID = vl_adoption_id
		-- 	AND DELETE_SW = 'N'
		-- 	AND (
		-- 		cjams.F_PRIM_COUNTY(CASE_ID,'NULL') IN 
		-- 		( select statecountycode from county where golivedate <= CURRENT_DATE ) OR
		-- 		cjams.F_CHECK_CASE_TRANSFER(CASE_ID) = 1
		-- 		)
		-- ;

		-- IF vl_cjams_county is NULL THEN 
		-- 	SET vl_cjams_county = 0;
		-- END IF;

		-- IF vdc_receivable_amount > 0 AND vl_cjams_county > 0 THEN -- GENERATE THE RECEIVABLE

		IF vdc_receivable_amount > 0 THEN -- GENERATE THE RECEIVABLE

			SELECT a.al_sqlcode,a.as_error from SP_OVER_PAYMENT ( vl_payment_detail_id,
											vl_client_id,
											vl_provider_id,
											vd_service_start_dt,
											vd_service_end_dt,
											vdc_receivable_amount,
											vs_change_type) a into
											al_sqlcode,
											as_error;

			IF al_sqlcode < 0 THEN
				 as_error := 'GAP - SP_OVER_PAYMENT failed'  ;
				 vs_identity_column := 'Payment Detail ID';
				 vs_identity_val := (vl_payment_detail_id)::character varying;
				--SIGNAL p_sp_error  ;--
			END IF ;
		END IF;
	--END FOR;--
	END LOOP;
	-- GAP Payments beyond Subsidy Dates - main cursor - END
END IF;
	  
END
;

$function$
;
