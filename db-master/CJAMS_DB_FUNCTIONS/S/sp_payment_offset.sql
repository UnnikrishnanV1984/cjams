CREATE OR REPLACE FUNCTION cjams.sp_payment_offset(al_provider_id bigint, vdc_total_final_amount numeric, OUT adc_offset_amount numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 04/06/2021 Vineet Tirodkar 
-- Modifications to Offset using the Monthly Payment Plan    
-- Vineet Tirodkar - 05/03/2021 - Modifications for New Provider Category 3794 - Residential Treatment Center (B-102022)
------------------------------------------------------------------------
DECLARE vdc_provider_bal Decimal(10,2) DEFAULT 0.00;
	vl_receivable_id BIGINT DEFAULT NULL;
	vdc_percentage_no Decimal(5,2) DEFAULT 0.00;
	vdc_offset_amount Decimal(10,2) DEFAULT 0.00;
	vl_offset_percent_private Decimal(5,2) DEFAULT 100.00;
	vl_offset_percent_chessie_mask Decimal(5,2) DEFAULT 25.00;
	vs_provider_category VARCHAR(5);
	vl_months_no INTEGER;
	vdc_monthly_plan_amount Decimal(10,2) DEFAULT 0.00;

BEGIN

	SELECT SUM(COALESCE(trd.RECEIVABLE_BALANCE_NO,0)),
			trh.RECEIVABLE_ID
		INTO vdc_provider_bal,
			 vl_receivable_id
	FROM tb_RECEIVABLE_HEADER trh,
		tb_RECEIVABLE_DETAIL trd,
		tb_RECEIVABLE_COLLECTION_STATUS trcs,
		tb_PAYMENT_DETAIL tpd
	WHERE trh.RECEIVABLE_ID = trd.RECEIVABLE_ID
		AND trd.RECEIVABLE_DETAIL_ID = trcs.RECEIVABLE_DETAIL_ID
		AND trd.PAYMENT_DETAIL_ID = tpd.PAYMENT_DETAIL_ID
		AND trcs.COLLECTION_STATUS_CD <> '775' -- Reffered to CCU
		AND trcs.ACTIVE_SW = 'Y'
		AND trcs.DELETE_SW = 'N'
		AND trd.APPROVAL_STATUS_CD = '3047'
		AND trd.DELETE_SW = 'N'
		AND trh.PROVIDER_ID = al_provider_id
		AND trh.DELETE_SW = 'N'
		AND tpd.DELETE_SW = 'N'
		AND tpd.SUBSIDY_AGREEMENT_ID IS NULL --  PRJ-05327 - Excluding A/R for GAP & Adoption Subsidy 
		AND (
			--cjams.F_PRIM_COUNTY(tpd.CASE_ID,'NULL') IN 
			trd.COUNTY_CD IN ( select statecountycode from county where golivedate <= CURRENT_DATE ) OR
			(cjams.F_CHECK_CASE_TRANSFER(tpd.CASE_ID) = 1 AND trd.receivable_ts::date >= (select date_of_transfer::date from transferred_cases))
			)
	GROUP BY trh.RECEIVABLE_ID ;

	IF vdc_provider_bal IS NULL OR vdc_provider_bal = 0.00 THEN
	   adc_offset_amount := 0.00 ; -- NO NEED TO OFFSET
	ELSE -- CHECK THE PAYMENT PLAN
		SELECT PERCENTAGE_NO,
				MONTHS_NO,
				AMOUNT_NO
		INTO vdc_percentage_no,
			vl_months_no,
			vdc_monthly_plan_amount
		FROM tb_PAYMENT_PLAN
		WHERE RECEIVABLE_ID = vl_receivable_id
			AND END_DT IS NULL
			AND DELETE_SW = 'N'
		ORDER BY PAYMENT_PLAN_ID DESC
		FETCH FIRST ROW ONLY ;

		IF vdc_percentage_no IS NULL THEN
			vdc_percentage_no := 0.00;
		END IF;
		
		IF vdc_percentage_no = 0 THEN
			SELECT F_PRVPCKLST_CAT(tp.PROVIDER_ID,'PLACEMENT')
				INTO vs_provider_category   
			FROM tb_PROVIDER tp
			WHERE tp.PROVIDER_ID  = al_provider_id;

			IF vs_provider_category is NULL THEN
				vs_provider_category := '';
			END IF;

			IF vs_provider_category = '3049' OR vs_provider_category = '3274' 
				OR vs_provider_category = '3302' OR vs_provider_category = '1782' OR vs_provider_category = '3794' THEN
				vdc_percentage_no := vl_offset_percent_private;
			ELSEIF vs_provider_category = '1783' THEN
				vdc_percentage_no := vl_offset_percent_chessie_mask;
			ELSE
				-- Provider Category Unknown
				vdc_percentage_no := 100.00; -- OFFSET 100 %
			END IF;
		END IF;
			
		IF vdc_percentage_no > 0.00 THEN
			vdc_offset_amount := ( vdc_total_final_amount * vdc_percentage_no ) / 100 ;

			IF vdc_provider_bal < vdc_offset_amount THEN
				adc_offset_amount := vdc_provider_bal;
			ELSE
				adc_offset_amount := vdc_offset_amount;
			END IF;
		END IF;

		IF vl_months_no is null THEN
			vl_months_no := 0;
		END IF;
		
		IF vdc_monthly_plan_amount is null THEN
			vdc_monthly_plan_amount := 0;
		END IF;
		
		IF vl_months_no > 0 AND vdc_monthly_plan_amount > 0 THEN
			IF vdc_provider_bal < vdc_monthly_plan_amount THEN
				adc_offset_amount := vdc_provider_bal;
			ELSE
				adc_offset_amount := vdc_monthly_plan_amount;
			END IF;
			
			IF vdc_total_final_amount < adc_offset_amount THEN
				adc_offset_amount := vdc_total_final_amount;
			END IF;
		END IF;

		IF adc_offset_amount is NULL THEN
			adc_offset_amount := 0.00 ;
		END IF;
	END IF;

END 
;

$function$
;
