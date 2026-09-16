CREATE OR REPLACE FUNCTION cjams.sp_child_acccount_datafix(as_county_cd character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- To Update Child Account Balances in tb_client_account
-- Revision(s)
-- 06/22/2020 - Modifications for 5472 - Bank Service Charges- No approval is required in CJAMS 
------------------------------------------------------------------------
DECLARE vs_cursor_sql VARCHAR(12000) ;

DECLARE vd_date_2months DATE;

DECLARE vl_row_cnt BIGINT DEFAULT 0;
DECLARE vl_client_acc_id BIGINT DEFAULT NULL;

DECLARE vdc_total_credit decimal(10,2) DEFAULT 0.00;
DECLARE vdc_total_debit decimal(10,2) DEFAULT 0.00;
DECLARE vdc_total_balance decimal(10,2) DEFAULT 0.00;
DECLARE vdc_obligated_for_COC decimal(10,2) DEFAULT 0.00;
DECLARE vdc_obligated_for_ANC decimal(10,2) DEFAULT 0.00;
DECLARE vdc_available_bal decimal(10,2) DEFAULT 0.00;
DECLARE vdc_total_acc_balance decimal(10,2) DEFAULT 0.00;

DECLARE vl_commingled_acc_id BIGINT DEFAULT NULL;

--Log Error
DECLARE SQLCODE INT DEFAULT 0;
DECLARE al_sqlcode INT DEFAULT 0;
DECLARE as_error VARCHAR(3000);
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
p_sp_error CHAR(5);

CUR_CHILD_ACCOUNTS REFCURSOR;

BEGIN

	SELECT F_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
    INTO vd_date_2months;
	
	vs_cursor_sql := ''; -- INITIAL VALUE

	vs_cursor_sql :=
	' SELECT TCA.CLIENT_ACCOUNT_ID, '||
	'        TCA.OBLIGATED_FOR_ANC '||
	'   FROM TB_CLIENT_ACCOUNT  TCA '||
	' WHERE TCA.ACCOUNT_TYPE_CD in ( ''590'', ''591'' )'||
	'       AND TCA.STATUS_CD = ''592'' '||
	'	  AND TCA.DELETE_SW = ''N'' '||
	'   AND btrim(TCA.COUNTY_CD)= '|| ''''||btrim(as_county_cd)||'''' ;
			
								
	vl_row_cnt := 0; -- INITIAL VALUE

	SELECT COUNT(TCA.CLIENT_ACCOUNT_ID)
		INTO vl_row_cnt
		FROM TB_CLIENT_ACCOUNT TCA
	WHERE TCA.ACCOUNT_TYPE_CD IN ( '590', '591' )
		AND TCA.STATUS_CD = '592'
		AND TCA.DELETE_SW = 'N'
		AND Btrim(TCA.COUNTY_CD) = Btrim(as_county_cd) ;
				

	IF vl_row_cnt > 0 THEN
	  OPEN CUR_CHILD_ACCOUNTS FOR EXECUTE vs_cursor_sql;
	  
	  loop EXIT WHEN vl_row_cnt = 0::bigint ;
		vl_client_acc_id := NULL; -- INITIAL VALUE
		vdc_obligated_for_ANC := NULL; -- INITIAL VALUE

		FETCH CUR_CHILD_ACCOUNTS INTO vl_client_acc_id, vdc_obligated_for_ANC;

		-- Get Sum of All Credit Transactions
		-- If Adjustments consider only Approved transactions
		vdc_total_credit := 0.00; -- INITIAL VALUE

		SELECT SUM(COALESCE(TR.TRANSACTION_AMOUNT_NO,0))
			INTO vdc_total_credit
		FROM TB_ACCOUNT_TRANSACTION  TR
		WHERE TR.CLIENT_ACCOUNT_ID =  vl_client_acc_id
		   AND ( 	TR.TRANSACTION_TYPE_CD <> '588' 
					OR
					( TR.TRANSACTION_TYPE_CD = '588' AND TR.TRANSACTION_SOURCE_CD = '5472' )
					OR
					( TR.TRANSACTION_TYPE_CD = '588' AND TR.TRANSACTION_SOURCE_CD <> '5472' 
						AND TR.ADJUSTMENT_APPROVAL_STATUS_CD = '3047' ) 
				)
		   AND TR.TRANSACTION_TYPE_CD <> '5530'    
		   AND TR.CREDIT_DEBIT_SW = 'C'
		   AND TR.DELETE_SW = 'N' ;

		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_error := 'Error in getting Total Credit Transactions.';
		END IF ;

		IF vdc_total_credit is NULL THEN
			vdc_total_credit := 0.00;
		END IF;

		-- Get Sum of All Debit Transactions
		-- If Adjustments consider only Approved transactions
		vdc_total_debit := 0.00; -- INITIAL VALUE

		SELECT SUM(COALESCE(TR.TRANSACTION_AMOUNT_NO,0))
			INTO vdc_total_debit
		FROM TB_ACCOUNT_TRANSACTION  TR
		WHERE TR.CLIENT_ACCOUNT_ID =  vl_client_acc_id
			AND ( 	TR.TRANSACTION_TYPE_CD <> '588' 
					OR
					( TR.TRANSACTION_TYPE_CD = '588' AND TR.TRANSACTION_SOURCE_CD = '5472' )
					OR
					( TR.TRANSACTION_TYPE_CD = '588' AND TR.TRANSACTION_SOURCE_CD <> '5472' 
						AND TR.ADJUSTMENT_APPROVAL_STATUS_CD = '3047' ) 
				)
			AND TR.TRANSACTION_TYPE_CD <> '5530'    
			AND TR.CREDIT_DEBIT_SW = 'D'
			AND TR.DELETE_SW = 'N' ;

		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_error := 'Error in getting Total Debit Transactions.';
		END IF ;

		IF vdc_total_debit is NULL THEN
			vdc_total_debit := 0.00;
		END IF;

		-- Total Balance = Sum of All Credits - Sum of All Debits
		vdc_total_balance := vdc_total_credit - vdc_total_debit;

		-- Get Obligated for COC (SSI, SSA or Other [COC]) as of current date
		-- Receipts + Adj Credit - Adj Debit where Benefit_Start_dt > 2MonthsDate
		vdc_obligated_for_COC := 0.00; -- INITIAL VALUE

		SELECT
			( SELECT SUM(COALESCE(TR.TRANSACTION_AMOUNT_NO,0))
				FROM TB_ACCOUNT_TRANSACTION TR
			   WHERE TR.CLIENT_ACCOUNT_ID = CA.CLIENT_ACCOUNT_ID
				AND TR.DELETE_SW = 'N'
				AND TR.CREDIT_DEBIT_SW = 'C'
				AND TR.TRANSACTION_SOURCE_CD IN ('587','586','585')	
				AND BENEFIT_START_DT > vd_date_2months
			 )
			+
			COALESCE((
			  SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))	
				FROM TB_ACCOUNT_TRANSACTION TR1
			   WHERE TR1.TRANSACTION_TYPE_CD = '588'
				AND TR1.CREDIT_DEBIT_SW = 'C'
				AND TR1.TRANSACTION_SOURCE_CD = '5473'	
				AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
				AND TR1.REFERENCE_TRANSACTION_ID in
						(
						  SELECT TR.TRANSACTION_ID
							FROM TB_ACCOUNT_TRANSACTION TR
						  WHERE TR.CLIENT_ACCOUNT_ID = CA.CLIENT_ACCOUNT_ID
							AND TR.DELETE_SW = 'N'
							AND TR.CREDIT_DEBIT_SW = 'C'
							AND TR.TRANSACTION_SOURCE_CD IN ('587','586','585')	
							AND BENEFIT_START_DT > vd_date_2months
						)

			),0)
		-
			COALESCE((
			  SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))	
				FROM TB_ACCOUNT_TRANSACTION TR1
			   WHERE TR1.TRANSACTION_TYPE_CD = '588'
				AND TR1.CREDIT_DEBIT_SW = 'D'
				AND TR1.TRANSACTION_SOURCE_CD = '5473'	
				AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
				AND TR1.REFERENCE_TRANSACTION_ID in
						(
						  SELECT TR.TRANSACTION_ID
							FROM TB_ACCOUNT_TRANSACTION TR
						  WHERE TR.CLIENT_ACCOUNT_ID = CA.CLIENT_ACCOUNT_ID
							AND TR.DELETE_SW = 'N'
							AND TR.CREDIT_DEBIT_SW = 'C'
							AND TR.TRANSACTION_SOURCE_CD IN ('587','586','585')	
							AND BENEFIT_START_DT > vd_date_2months
						)

			),0)
				INTO vdc_obligated_for_COC
			FROM TB_CLIENT_ACCOUNT CA
		WHERE CA.CLIENT_ACCOUNT_ID = vl_client_acc_id
			AND CA.DELETE_SW = 'N' ;

		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_error := 'Error in getting Obligated for COC Transactions as of current date.';
		END IF ;

		IF vdc_obligated_for_COC is NULL THEN
			vdc_obligated_for_COC := 0.00;		
		END IF;

		IF vdc_obligated_for_ANC is NULL THEN
			vdc_obligated_for_ANC := 0.00;
		END IF;

		-- Available Balance = Total Balance - ( Obligated for COC + Obligated for ANC )

		vdc_available_bal := vdc_total_balance - ( vdc_obligated_for_ANC + vdc_obligated_for_COC );

		UPDATE TB_CLIENT_ACCOUNT
		SET TOTAL_BALANCE_NO = vdc_total_balance,
			OBLIGATED_FOR_COC = vdc_obligated_for_COC,
			AVAILABLE_BALANCE_NO = vdc_available_bal,
			UPDATE_TS = CURRENT_TIMESTAMP,
			UPDATE_USER_ID = 'finance'
		WHERE CLIENT_ACCOUNT_ID = vl_client_acc_id
			AND DELETE_SW = 'N' ;
		
		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_error := 'Error in Updating Child Account Balances.';
		END IF ;
				
		-- Update Total Balance No in Commingled Account - START
		vl_commingled_acc_id := NULL; -- INITIAL VALUE

		SELECT COMM_ACCOUNT_ID
			INTO vl_commingled_acc_id
		FROM TB_CLIENT_ACCOUNT
		WHERE CLIENT_ACCOUNT_ID = vl_client_acc_id
		AND DELETE_SW = 'N' ;
		
		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_error := 'Error in getting Commingled Account ID.';
		END IF ;				
			
		IF vl_commingled_acc_id is NULL THEN
			vl_commingled_acc_id := 0;
		END IF;			
						
		IF vl_commingled_acc_id > 0 THEN
			vdc_total_acc_balance := 0.00; -- INITIAL VALUE

			SELECT SUM(COALESCE(TOTAL_BALANCE_NO,0))
					INTO vdc_total_acc_balance
				FROM TB_CLIENT_ACCOUNT
			WHERE COMM_ACCOUNT_ID = vl_commingled_acc_id
			AND DELETE_SW = 'N' ;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_error := 'Error in Selecting Total Balance to update Commingled Account.';
			END IF ;
						
			UPDATE TB_COMMINGLED_ACCOUNT
				SET TOTAL_BALANCE_NO = vdc_total_acc_balance,
					UPDATE_TS = CURRENT_TIMESTAMP,
					UPDATE_USER_ID = 'finance'
			WHERE COMM_ACCOUNT_ID = vl_commingled_acc_id
				AND DELETE_SW = 'N' ;

				
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_error := 'Error in Updating Commingled Account.';
			END IF ;
		END IF;
		-- Update Total Balance No in Commingled Account - END	
		
		vl_row_cnt := vl_row_cnt  - 1;	
	   END loop;
	   CLOSE CUR_CHILD_ACCOUNTS ;
	END IF;
END;

$function$
;

