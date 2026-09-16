DROP FUNCTION IF EXISTS cjams.sp_subsidy_payment_stamping(date);

CREATE OR REPLACE FUNCTION cjams.sp_subsidy_payment_stamping(
	ad_run_dt date,
	OUT vs_success_sw character varying,
	OUT vl_output_sqlcode character varying,
	OUT vs_message character varying
)
 LANGUAGE plpgsql
AS $function$
/**
cjams.sp_subsidy_payment_stamping
- Allocates funds for prior adoption subsidy gap payments (system adjustments included)
- Updates FMIS/AFS payment headers for eligible records
- Eligibility: FINAL_SERVICE_ID in (501, 503) and SUBSIDY_AGREEMENT_ID not null
- Splits payment 50/50 state/IVE if ELIGIBILITY_STATUS_CD = '2913', else 100% state
- Inserts allocation into TB_FUND_ALLOCATION_MASTER (only state/IVE columns used)
- OUT parameters:
    - vs_success_sw: 'Y' (success) or 'N' (error)
    - vl_output_sqlcode: '0' (success) or error message
    - vs_message: outcome description
- All errors logged and reported via OUT params
*/


DECLARE
	vl_client_id BIGINT;
	vl_case_id BIGINT;
	vd_previous_month_start_dt DATE;
	vd_previous_month_end_dt DATE;
	vd_current_month_end_dt DATE;
	vdc_final_payment_amount DECIMAL(10,2);
	vs_final_fiscal_category_cd VARCHAR(5);
	vs_eligibility_status_cd VARCHAR(5);
	VS_ELIG_SW CHAR(1);
	al_sqlcode INT DEFAULT 0;
	as_error VARCHAR(3000) DEFAULT '';
	SQLSTATE CHAR(5) DEFAULT '00000';
	vs_message_text VARCHAR(3000) DEFAULT '';
	vl_ret_status INTEGER DEFAULT 0;
	vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_SUBSIDY_PAYMENT_STAMPING';
	vs_identity_column VARCHAR(100);
	vs_identity_val VARCHAR(100);
	vl_count INTEGER;
	cur_payment_detail RECORD;
	cur_payment_detail_refcur REFCURSOR;
	vl_funding_allocation_id BIGINT;
	vl_final_service_id  BIGINT;
	vdc_state_amt DECIMAL(10,2);
	vdc_ive_amt DECIMAL(10,2);
BEGIN
	BEGIN
		SELECT (date_trunc('month', ad_run_dt::date) - interval '1 month')::date,
			   (date_trunc('month', ad_run_dt::date)::date - 1),
			   ((date_trunc('month', ad_run_dt::date) + interval '1 month')- interval '1 Day')::date
		  INTO vd_previous_month_start_dt,
			   vd_previous_month_end_dt,
			   vd_current_month_end_dt;

		-- FMIS update
		UPDATE TB_PAYMENT_HEADER
			SET INTERFACE_TO_CD = '5585',
				UPDATE_USER_ID = 'STAMPING-SUBSIDY'
		WHERE DELETE_SW = 'N'
			AND PAYMENT_TYPE_CD in ( '7', '5689' )
			AND MANUAL_SW = 'N'
			AND PAYMENT_START_DT = vd_previous_month_start_dt
			AND PAYMENT_END_DT = vd_previous_month_end_dt
			AND PAYMENT_ID IN (
				SELECT PAYMENT_ID
				FROM TB_PAYMENT_DETAIL
				WHERE DELETE_SW = 'N'
					AND FINAL_SERVICE_ID IN (501, 503)
					AND SUBSIDY_AGREEMENT_ID IS NOT NULL
			);
		
		-- AFS update
		UPDATE TB_PAYMENT_HEADER
			SET INTERFACE_TO_CD = '5583',
				UPDATE_USER_ID = 'STAMPING-SUBSIDY'
		WHERE DELETE_SW = 'N'
			AND PAYMENT_TYPE_CD = '3294'
			AND MANUAL_SW = 'N'
			AND PAYMENT_START_DT = vd_previous_month_start_dt
			AND PAYMENT_END_DT = vd_previous_month_end_dt
			AND PAYMENT_ID IN (
				SELECT PAYMENT_ID
				FROM TB_PAYMENT_DETAIL
				WHERE DELETE_SW = 'N'
					AND FINAL_SERVICE_ID IN (501, 503)
					AND SUBSIDY_AGREEMENT_ID IS NOT NULL
			);
		
		-- Cursor for eligible subsidy payments
		OPEN cur_payment_detail_refcur FOR
			SELECT PD.CLIENT_ID,
				(PD.FINAL_AMOUNT_NO - COALESCE((SELECT SUM(COALESCE(RD.AMOUNT_NO,0))
												FROM TB_RECEIVABLE_DETAIL RD
												WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
													AND RD.DELETE_SW = 'N'),0)) AS FINAL_AMOUNT_NO,
				PD.PAYMENT_DETAIL_ID,
				PD.CASE_ID,
				PD.FINAL_FISCAL_CATEGORY_CD,
				PD.FINAL_SERVICE_ID
			FROM TB_PAYMENT_HEADER PH,
				TB_PAYMENT_DETAIL PD,
				TB_PAYMENT_STATUS PS
			WHERE PH.PAYMENT_ID = PD.PAYMENT_ID
				AND PH.PAYMENT_ID = PS.PAYMENT_ID
				AND PH.PAYMENT_START_DT = vd_previous_month_start_dt
				AND PH.PAYMENT_END_DT = vd_previous_month_end_dt
				AND PH.DELETE_SW = 'N'
				AND PD.DELETE_SW = 'N'
				AND PS.DELETE_SW = 'N'
				AND PH.PAYMENT_TYPE_CD IN ('7','3294','5689')
				AND (PH.MANUAL_SW = 'N' OR PH.MANUAL_SW IS NULL)
				AND PD.FINAL_SERVICE_ID IN (501, 503)
				AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639')
				AND PD.SUBSIDY_AGREEMENT_ID IS NOT NULL;

		LOOP
			FETCH cur_payment_detail_refcur INTO cur_payment_detail;
			EXIT WHEN NOT FOUND;
			vdc_final_payment_amount := COALESCE(cur_payment_detail.FINAL_AMOUNT_NO, 0.00);
			vl_client_id := cur_payment_detail.CLIENT_ID;
			vl_case_id := cur_payment_detail.CASE_ID;
			vs_final_fiscal_category_cd := cur_payment_detail.FINAL_FISCAL_CATEGORY_CD;
			vl_final_service_id := cur_payment_detail.FINAL_SERVICE_ID;
			VS_ELIG_SW := NULL;
			vs_eligibility_status_cd := NULL;

			-- Get eligibility status for type_cd '2934', '2935'
			IF vl_final_service_id = 501 then  -- Adoption
				SELECT btrim(ELIGIBILITY_STATUS_CD)
					INTO vs_eligibility_status_cd
				FROM TB_CLIENT_ELIGIBILITY
				WHERE CLIENT_ID = vl_client_id
					AND CASE_ID = vl_case_id
					AND btrim(ELIGIBILITY_TYPE_CD) = '2934'
					AND DELETE_SW = 'N'
					AND START_DT <= vd_previous_month_end_dt
					AND (END_DT >= vd_previous_month_start_dt OR END_DT IS NULL)
				ORDER BY ELIGIBILITY_ID DESC
				FETCH FIRST ROW ONLY;
			else -- 503 GAP
				SELECT btrim(ELIGIBILITY_STATUS_CD)
					INTO vs_eligibility_status_cd
				FROM TB_CLIENT_ELIGIBILITY
				WHERE CLIENT_ID = vl_client_id
					AND CASE_ID = vl_case_id
					AND btrim(ELIGIBILITY_TYPE_CD) = '2935'
					AND DELETE_SW = 'N'
					AND START_DT <= vd_previous_month_end_dt
					AND (END_DT >= vd_previous_month_start_dt OR END_DT IS NULL)
				ORDER BY ELIGIBILITY_ID DESC
				FETCH FIRST ROW ONLY;
			end if;	

			IF vs_eligibility_status_cd IS NOT NULL AND vs_eligibility_status_cd = '2913' THEN
				VS_ELIG_SW := 'Y';
			ELSE
				VS_ELIG_SW := 'N';
			END IF;

			-- Only stamp if not already stamped
			SELECT COUNT(*) INTO vl_count
			FROM TB_FUND_ALLOCATION_MASTER
			WHERE PAYMENT_DETAIL_ID = cur_payment_detail.PAYMENT_DETAIL_ID
				AND DELETE_SW = 'N';

			IF vl_count = 0 AND vdc_final_payment_amount <> 0 THEN
				IF VS_ELIG_SW = 'Y' THEN
					vdc_ive_amt := vdc_final_payment_amount / 2;
					vdc_state_amt := vdc_final_payment_amount / 2;
				ELSE
					vdc_ive_amt := 0.00;
					vdc_state_amt := vdc_final_payment_amount;
				END IF;

				-- Insert into TB_FUND_ALLOCATION_MASTER
				SELECT sp_nextid('sq_fund_allocation_master') INTO vl_funding_allocation_id;
				INSERT INTO TB_FUND_ALLOCATION_MASTER (
					FUND_ALLOC_ID, FUNDING_AMOUNT_NO, PAYMENT_DETAIL_ID, FUND_ALLOCATION_DATE, PAYMENT_AMOUNT, FISCAL_CATEGORY_CD,
					SSI_FUNDING_AMT, SSA_FUNDING_AMT, COC_FUNDING_AMT, STATE_FUNDING_AMT, IVE_FUNDING_AMT, IVD_FUNDING_AMT,
					LOCAL_FUNDING_AMT, INITIAL_STAMPING_SW, DELETE_SW, CREATE_TS, CREATE_USER_ID, UPDATE_TS, UPDATE_USER_ID, ELIGIBILITY_STATUS_CD
				) VALUES (
					vl_funding_allocation_id, 0, cur_payment_detail.PAYMENT_DETAIL_ID, ad_run_dt, vdc_final_payment_amount, vs_final_fiscal_category_cd,
					0, 0, 0, vdc_state_amt, vdc_ive_amt, 0,
					0, 'Y', 'N', CURRENT_TIMESTAMP, 'finance-subsidy', CURRENT_TIMESTAMP, 'finance-subsidy', vs_eligibility_status_cd
				);
			END IF;
		END LOOP;

		vs_success_sw := 'Y';
		vl_output_sqlcode := '0';
		vs_message := 'Subsidy payment stamping completed successfully.';
		
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS vs_message_text = MESSAGE_TEXT;
		vs_success_sw := 'N';
		vl_output_sqlcode := vs_message_text;
		vs_message := 'Error in sp_subsidy_payment_stamping: ' || vs_message_text;
		SELECT SP_BATCH_ERROR_LOG (
			vs_Procedure_nm,
			NULL::bigint,
			NULL::bigint,
			NULL::character varying,
			NULL::INTEGER,
			NULL::character varying,
			SQLSTATE::character varying,
			vs_message::character varying,
			'finance'::character varying) INTO vl_ret_status;
	END;
END;
$function$
;
