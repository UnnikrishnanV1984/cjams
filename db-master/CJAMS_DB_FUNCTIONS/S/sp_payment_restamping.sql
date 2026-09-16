CREATE OR REPLACE FUNCTION cjams.sp_payment_restamping(ad_run_dt date)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
--Sql Stored Procedure
--Author : Gayathri Rajkumar
--Date   : '2009-05-14'
--Re-allocates child money for late transactions( Late entry, Late validation and Hold and Release)
--Applied IVE logic
--Gayathri Fixed negative amt '2009-06-02'   # 20315
--Included Runtime log logic and fund_allocation_dt for restamping
--Excluded current month late validations
--Modified Coc Logic
--Removed Hard coded
--Modified System Adjustment logic - '2009-06-19'
--Gayathri Modified the eligibility logic - '2010-04-05'
-- 02/28/2012 Vineet Tirodkar - PRJ-02312
-- To update Eligibility Status Code in TB_FUND_ALLOCATION_MASTER & TB_FUND_ALLOCATION_DETAIL
-- 03/26/2012 Vineet Tirodkar - PRJ-02515
-- To consider previously used child accounts funds from 'Closed' or 'Inactive' account. 
-- 09/04/2012 Vineet Tirodkar - Payment stamping batch production issue fix (Sept 2012)
-- New condition ORDER BY ELIGIBILITY_ID DESC FETCH FIRST ROW ONLY in the SQL to get client's Eligibility Status.
-- Added RETURN -1 for execptions & RETURN 0 for success
-- 06/03/2020 Vineet Tirodkar - To fix issue of null/zero cost-of-care reimbursement amounts under all funding sources.
-- 09/25/2020 Vineet Tirodkar - Changes to trim and compare Eligibility Status Code - CDM-4684
-- 01/29/2021 Vineet Tirodkar - Modifications to update tb_fund_allocation_detail audit columns (CDM-9278)
-- 04/30/2021 Vineet Tirodkar - Modifications to fix 1st System Adjustment Re-stamp Issue (No prior payment) (CDM-12488)
-----------------------------------------------------------------------
-- P1: BEGIN
DECLARE vl_child_account_id  	 BIGINT       DEFAULT 0;
DECLARE vl_client_id         	 BIGINT       DEFAULT 0;
DECLARE vl_case_id           	 BIGINT       DEFAULT 0;
DECLARE vl_eligiblity_status 	 INTEGER       DEFAULT 0;
DECLARE vl_count    	     	 INTEGER       DEFAULT 0;
DECLARE vn_payment_detail_id 	 BIGINT        DEFAULT 0;
DECLARE vn_client_id         	 BIGINT       DEFAULT 0;
DECLARE vn_client_account_id 	 BIGINT       DEFAULT 0;
DECLARE vl_ret_status 	     	 INTEGER       DEFAULT 0;
DECLARE vn_stamp_count           INTEGER       DEFAULT 0;
DECLARE  vl_rs_eligiblity_status INTEGER       DEFAULT 0;
--DECLARE  VN_STATUS_CHANGE        INTEGER       DEFAULT 0;
DECLARE  VL_RUNTIME_ID           INTEGER       DEFAULT 0;

DECLARE VN_PAYMENT_AMOUNT_NO 	 DECIMAL(10,2) DEFAULT 0.00;
DECLARE COS_AMOUNT 				 DECIMAL(10,2) DEFAULT 0.00;
DECLARE Vn_restamp_amt 		 	 DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_ssi_amt_adj_credit 	 DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_ssi_amt_adj_debit    DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_ssi_stamped_amt      DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_child_other_amount   DECIMAL(10,2) DEFAULT 0.00;

DECLARE vdc_ssa_amt_adj_credit   DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_ssa_amt_adj_debit    DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_ssa_stamped_amt      DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_RS_SSI  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_RS_SSA  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_RS_COC  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_IS_SSI  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_IS_SSA  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_IS_COC  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_bl_SSI  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_bL_SSA  		 		 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VN_bl_COC  		 		 DECIMAL(10,2) DEFAULT 0.00;

DECLARE vdc_othcoc_amt_adj_credit    DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_othcoc_amt_adj_debit     DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_othcoc_stamped_amt       DECIMAL(10,2) DEFAULT 0.00;
DECLARE vn_Required_balance          DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_Ive_require_amt	     	 DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_state_amt	             DECIMAL(10,2) DEFAULT 0.00;
DECLARE TOTAL_ALL_AMT 		     	 DECIMAL(10,2) DEFAULT 0.00;
DECLARE VDC_IVE_FUNDING_AMT          DECIMAL(10,2) DEFAULT 0.00;

DECLARE VDT_START_DT  DATE  DEFAULT NULL;
DECLARE VDT_END_DT    DATE  DEFAULT NULL;

DECLARE VS_transaction_source_cd VARCHAR(4) DEFAULT NULL;
DECLARE vs_fiscal_cat 		 	 VARCHAR(5) DEFAULT NULL;
DECLARE VS_PRE_ELIGI_STATUS      CHAR(1)    DEFAULT 'N';
DECLARE VS_ELIG_SW               CHAR(1) DEFAULT NULL;
DECLARE vs_curr_elig_status_cd   VARCHAR(5);
DECLARE vs_rs_elig_status_cd     VARCHAR(5);
DECLARE vs_updt_elig_status_cd   VARCHAR(5);

--Log Error
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;
p_sp_error CHAR(5);
DECLARE vs_Procedure_nm 	VARCHAR(100) DEFAULT 'SP_PAYMENT_RESTAMPING';
DECLARE vs_identity_column 	VARCHAR(100);
DECLARE vs_identity_val 	VARCHAR(100);
DECLARE vs_message_text 	VARCHAR(3000) DEFAULT '';
DECLARE as_error 		    VARCHAR(3000);
DECLARE al_sqlcode          INTEGER DEFAULT 0;
DECLARE SQLCODE             INTEGER DEFAULT 0;
DECLARE VL_SQL_CODE         INTEGER DEFAULT 0;

-- Vineet START
DECLARE vl_placement_id BIGINT;
DECLARE vl_fund_alloc_cnt INTEGER;
DECLARE V_SQL_STMT1 VARCHAR(3000);
-- Selecting all client's FC payments eligible for Initial and restamping
--DECLARE Late_entry_cur CURSOR WITH HOLD FOR s1;
DECLARE Late_entry_cur REFCURSOR;
DECLARE cur_late_validations REFCURSOR;
DECLARE cur_late_validation_rec record;
-- Vineet END

-- Selecting all client's FC payments eligible for Initial and restamping
--Declare Late_entry_cur cursor with hold for
/*Declare Late_entry_cur cursor for
	-- Late entry
        select distinct * 
		    from ( select distinct pd.payment_detail_id
			              , ca.client_id
			              , AT.BENEFIT_START_DT
						  , AT.BENEFIT_END_DT
			              , pd.case_id
			              , ( select payment_amount 
						         from tb_fund_allocation_master 
							  where payment_detail_id =  pd.payment_detail_id  
							        and delete_sw ='N') as pay_amt
			       from tb_payment_detail pd 
				        inner join (tb_account_transaction at
			                          inner join tb_client_account ca on at.client_account_id = ca.client_account_id  )
			                  on pd.client_id = ca.client_id
			       where late_entry_sw = 'Y'
			             and final_service_start_dt between at.benefit_start_dt and at.benefit_end_dt
			             and At.delete_sw = 'N' 
						 and ca.delete_sw = 'N'
        union
	-- Late validation (system adjustments)
        Select pd.payment_detail_id
		       , client_id
        	   , ph.payment_start_dt
			   , ph.payment_end_dt
        	   , pd.case_id
        	   , PD.FINAL_AMOUNT_NO  -
	       	        COALESCE((  SELECT SUM(COALESCE(RD.AMOUNT_NO,0))
	  		                        FROM TB_RECEIVABLE_DETAIL RD
			                    WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
					                  AND RD.DELETE_SW = 'N' ),0) as  pay_amt
		from tb_payment_status ps 
		         inner join (tb_payment_detail pd 
		                       inner join tb_payment_header ph on pd.payment_id = ph.payment_id )
		                     on ps.payment_id =  pd.payment_id
		where pd.delete_sw = 'N' 
		    and ph.delete_sw = 'N'
			and  PAYMENT_TYPE_CD IN ('3294')
			and final_amount_no is not null
			AND PD.PAYMENT_DETAIL_ID NOT IN ( SELECT PAYMENT_DETAIL_ID FROM TB_FUND_ALLOCATION_MASTER WHERE DELETE_SW = 'N' )
	        AND ( SELECT COUNT(*)
 		        	  FROM TB_FUND_ALLOCATION_MASTER
			      WHERE DELETE_SW = 'N'
			            AND PAYMENT_DETAIL_ID in 
 					 	    (select pd1.payment_detail_id  
							    from tb_payment_status ps1 
								   inner join (tb_payment_detail pd1 inner join tb_payment_header ph1
						                         on pd1.payment_id = ph1.payment_id )
					               on ps1.payment_id =  pd1.payment_id
						  where pd1.placement_id = pd.placement_id
							and date_part('year',ph1.payment_start_dt) = date_part('year',ph.payment_start_dt)
							and date_part('month',payment_start_dt) = date_part('month',ph.payment_start_dt)
							and pd1.delete_sw = 'N' 
							and ph1.delete_sw = 'N'
							and ps1.payment_status_cd in ( '1634','1636')
			                and ps1.delete_sw = 'N'
							and ph1.payment_type_cd in ( '6','3294' )) ) = 0
			and payment_start_dt >= '2009-01-01'
			--and ph.payment_start_dt <= chessie.f_daymonth(ad_run_dt - 1 MONTH ,'L','')
			and ph.payment_start_dt <= f_daymonth((ad_run_dt - INTERVAL '1 month')::date ,'L','')
    		and placement_id is not null
			and payment_status_cd in ( '1634','1636')
			and ps.delete_sw = 'N'
			AND ( PH.MANUAL_SW = 'N' OR PH.MANUAL_SW IS NULL )
			and PD.FINAL_AMOUNT_NO  -
			COALESCE(( SELECT SUM(COALESCE(RD.AMOUNT_NO,0))
				           FROM TB_RECEIVABLE_DETAIL RD
				        WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
					          AND RD.DELETE_SW = 'N' ),0) > 0
					
		union
		-- IV-E status changes
		Select  distinct pd.payment_detail_id 
		        , ive.client_id
			    , IVE.BENEFIT_START_DT
				, ive.BENEFIT_END_DT
			    , pd.case_id
			    , (select payment_amount 
				       from tb_fund_allocation_master 
				   where payment_detail_id =  pd.payment_detail_id  
				         and delete_sw ='N') as pay_amt
        from TB_RS_IVE_STATUS IVE 
		        inner join tb_payment_detail pd on IVE.client_id = pd.client_id
        where  pd.delete_sw = 'N' 
		       and ive.delete_sw = 'N'
               and date_part('year',benefit_start_dt) = date_part('year',final_service_start_dt)
               and date_part('month',benefit_start_dt) = date_part('month',final_service_start_dt)
               and payment_detail_id in (select payment_detail_id from tb_fund_allocation_master where delete_sw = 'N')
 	 ) as d1
	 where pay_amt <> 0   
	       and pay_amt is not null
	 order by 1;*/


--DECLARE CONTINUE HANDLER FOR SQLWARNING
BEGIN
	begin
		EXCEPTION WHEN OTHERS THEN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;

		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
		-- SET al_sqlcode = -1 ;
		al_sqlcode := SQLCODE;
		as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;
		as_error := COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');
		as_error := as_error || COALESCE(vs_message_text ,'');

		select cjams.SP_BATCH_ERROR_LOG ( vs_Procedure_nm ,
											NULL::bigint,
											NULL::bigint,
											NULL::character varying,
											NULL::INTEGER,
											NULL::character varying,
											SQLSTATE::character varying,
											as_error::character varying,
											'finance'::character varying) INTO
											vl_ret_status;

		as_error := '';
		al_sqlcode := 0;
		RETURN 0;
	END;

	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION
	-- BEGIN
	/*GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
		SET al_sqlcode = SQLCODE;
		SET as_error = COALESCE(as_error ,'') || CHAR(CURRENT TIMESTAMP) ||'::' || vs_Procedure_nm || '.' ;
		SET as_error = COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');
		SET as_error = as_error || vs_message_text;

		CALL CHESSIE.SP_BATCH_ERROR_LOG  ( vs_Procedure_nm
											, NULL
											, NULL
											, NULL
											, NULL
											, as_error
											, 'RESTAMP'
											, vl_ret_status );
		RETURN -1;									
	END;
	*/

	-- Vineet - START
	-- Temporary table to get the Late_entry_cur records
	DROP TABLE IF EXISTS TEMP_LATE_ENTRY_CUR;

	CREATE TEMP TABLE TEMP_LATE_ENTRY_CUR
		( 	PAYMENT_DETAIL_ID BIGINT,
			CLIENT_ID BIGINT,
			PAYMENT_START_DT DATE,
			PAYMENT_END_DT DATE,
			CASE_ID BIGINT,
			PAY_AMT DECIMAL(10,2)
	   );
	--WITH REPLACE ;
	-- Vineet - END


	VL_RUNTIME_ID :=  NEXTVAL('sq_batch_runtime_log');
	
	INSERT INTO TB_BATCH_RUNTIME_LOG 
	(	RUNTIME_LOG_ID, PROGRAM_NM, RUNTIME_START_TS, CREATE_TS, 
		CREATE_USER_ID, UPDATE_TS, UPDATE_USER_ID)
	VALUES 
	(	VL_RUNTIME_ID, 'SP_PAYMENT_RESTAMPING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 
		'RESTAMP', CURRENT_TIMESTAMP, 'RESTAMP');

	Raise notice '>>>>>>>>>>sq_batch_runtime_log ->>after %', VL_RUNTIME_ID;

	Raise notice '>>>>>>>>>>starting TEMP_LATE_ENTRY_CUR 1st insert %', now();
	-- Vineet - START
	-- Late entry (Insert 1st SQL of original cursor)
	INSERT INTO TEMP_LATE_ENTRY_CUR   
	   (	PAYMENT_DETAIL_ID,
			CLIENT_ID,
			PAYMENT_START_DT,
			PAYMENT_END_DT,
			CASE_ID,
			PAY_AMT
		)
	SELECT DISTINCT PD.PAYMENT_DETAIL_ID
		  , CA.CLIENT_ID
		  , ATR.BENEFIT_START_DT
		  , ATR.BENEFIT_END_DT
		  , PD.CASE_ID
		  , ( SELECT PAYMENT_AMOUNT 
				 FROM TB_FUND_ALLOCATION_MASTER 
			  WHERE PAYMENT_DETAIL_ID =  PD.PAYMENT_DETAIL_ID  
					AND DELETE_SW ='N') AS PAY_AMT
	FROM TB_PAYMENT_DETAIL PD 
		INNER JOIN (TB_ACCOUNT_TRANSACTION ATR
					  INNER JOIN TB_CLIENT_ACCOUNT CA ON ATR.CLIENT_ACCOUNT_ID = CA.CLIENT_ACCOUNT_ID  )
			  ON PD.CLIENT_ID = CA.CLIENT_ID
	WHERE LATE_ENTRY_SW = 'Y'
		 AND FINAL_SERVICE_START_DT BETWEEN ATR.BENEFIT_START_DT AND ATR.BENEFIT_END_DT
		 AND ATR.DELETE_SW = 'N' 
		 AND CA.DELETE_SW = 'N'
		 AND PD.county_cd IN
			( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE )	;	 

	Raise notice '>>>>>>>>>>after Late entry (Insert 1st SQL of original cursor) %', al_sqlcode;
	Raise notice '>>>>>>>>>>starting TEMP_LATE_ENTRY_CUR 2nd insert %', now();

	-- IV-E status changes	(Insert 3rd SQL of original cursor)
	INSERT INTO TEMP_LATE_ENTRY_CUR   
	   (	PAYMENT_DETAIL_ID,
			CLIENT_ID,
			PAYMENT_START_DT,
			PAYMENT_END_DT,
			CASE_ID,
			PAY_AMT
		) 
	SELECT DISTINCT PD.PAYMENT_DETAIL_ID 
		, IVE.CLIENT_ID
		, IVE.BENEFIT_START_DT
		, IVE.BENEFIT_END_DT
		, PD.CASE_ID
		, FAM.PAYMENT_AMOUNT AS PAY_AMT
	FROM TB_FUND_ALLOCATION_MASTER FAM,
		TB_PAYMENT_DETAIL PD,
		TB_RS_IVE_STATUS IVE 	
	WHERE FAM.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
		AND IVE.CLIENT_ID = PD.CLIENT_ID
		AND FAM.DELETE_SW = 'N' 
		AND PD.DELETE_SW = 'N' 
		AND IVE.DELETE_SW = 'N'
		AND date_part('year',IVE.BENEFIT_START_DT::date) = date_part('year',PD.FINAL_SERVICE_START_DT::date)
		AND date_part('month',IVE.BENEFIT_START_DT::date) = date_part('month',PD.FINAL_SERVICE_START_DT::date)
		AND PD.county_cd IN
			( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE ) ;


	Raise notice '>>>>>>>>>>after IV-E status changes	(Insert 3rd SQL of original cursor) %', al_sqlcode;

	Raise notice '>>>>>>>>>>before Late validation (system adjustments) - (Insert 2nd SQL of original cursor) %', al_sqlcode;
	Raise notice '>>>>>>>>>>starting TEMP_LATE_ENTRY_CUR 3rd insert %', now();
	
	-- Late validation (system adjustments) - (Insert 2nd SQL of original cursor)
	-- FOR cur_late_validations AS
	OPEN cur_late_validations FOR
		SELECT PD.PAYMENT_DETAIL_ID
		   , PD.CLIENT_ID
		   , PH.PAYMENT_START_DT
		   , PH.PAYMENT_END_DT
		   , PD.CASE_ID
		   , PD.FINAL_AMOUNT_NO  -
				COALESCE((  SELECT SUM(COALESCE(RD.AMOUNT_NO,0))
								FROM TB_RECEIVABLE_DETAIL RD
							WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
								  AND RD.DELETE_SW = 'N' ),0) AS  PAY_AMT
			, PD.PLACEMENT_ID				  
		FROM TB_PAYMENT_STATUS PS 
			 INNER JOIN (TB_PAYMENT_DETAIL PD 
						   INNER JOIN TB_PAYMENT_HEADER PH ON PD.PAYMENT_ID = PH.PAYMENT_ID )
						 ON PS.PAYMENT_ID =  PD.PAYMENT_ID
		WHERE PD.DELETE_SW = 'N' 
			AND PH.DELETE_SW = 'N'
			AND PH.PAYMENT_TYPE_CD IN ('3294')
			AND PD.FINAL_AMOUNT_NO IS NOT NULL
			AND PD.PAYMENT_DETAIL_ID NOT IN ( SELECT PAYMENT_DETAIL_ID FROM TB_FUND_ALLOCATION_MASTER WHERE DELETE_SW = 'N' )
			
			AND PH.PAYMENT_START_DT >= '2009-01-01'::date
			--AND PH.PAYMENT_START_DT <= CHESSIE.F_DAYMONTH(AD_RUN_DT - 1 MONTH ,'L','')
			and ph.payment_start_dt <= f_daymonth((ad_run_dt - INTERVAL '1 month')::date ,'L','')
			AND PD.PLACEMENT_ID IS NOT NULL
			AND PS.PAYMENT_STATUS_CD IN ( '1634','1636')
			AND PS.DELETE_SW = 'N'
			AND ( PH.MANUAL_SW = 'N' OR PH.MANUAL_SW IS NULL )
			AND PD.FINAL_AMOUNT_NO  -
			COALESCE(( SELECT SUM(COALESCE(RD.AMOUNT_NO,0))
						   FROM TB_RECEIVABLE_DETAIL RD
						WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
							  AND RD.DELETE_SW = 'N' ),0) > 0
			AND PD.county_cd  IN( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE ) ;
	--DO
	LOOP
	fetch cur_late_validations into cur_late_validation_rec;
		exit when not found;
									 
		vn_payment_detail_id := cur_late_validation_rec.PAYMENT_DETAIL_ID;
		vn_client_id := cur_late_validation_rec.CLIENT_ID;
		VDT_START_DT := cur_late_validation_rec.PAYMENT_START_DT;
		VDT_END_DT := cur_late_validation_rec.PAYMENT_END_DT;
		vl_case_id := cur_late_validation_rec.CASE_ID;
		VN_PAYMENT_AMOUNT_NO := cur_late_validation_rec.PAY_AMT;
		vl_placement_id := cur_late_validation_rec.PLACEMENT_ID;
		vl_fund_alloc_cnt := 0;

		Raise notice '>>>>>>>>>>fetch cur_late_validations %', vn_payment_detail_id;
	
		-- Verify if the payment stamping was done for original payment
		/*SELECT COUNT(1)
				INTO vl_fund_alloc_cnt
			FROM TB_FUND_ALLOCATION_MASTER
			WHERE DELETE_SW = 'N'
			AND PAYMENT_DETAIL_ID IN 
				(	SELECT PD1.PAYMENT_DETAIL_ID  
						FROM TB_PAYMENT_STATUS PS1 
						INNER JOIN (TB_PAYMENT_DETAIL PD1 INNER JOIN TB_PAYMENT_HEADER PH1
									 ON PD1.PAYMENT_ID = PH1.PAYMENT_ID )
						ON PS1.PAYMENT_ID =  PD1.PAYMENT_ID
					WHERE PD1.PLACEMENT_ID = vl_placement_id
						--AND YEAR(PH1.PAYMENT_START_DT) = YEAR(VDT_START_DT)
						--AND MONTH(PAYMENT_START_DT) = MONTH(VDT_START_DT)
						and date_part('year',ph1.payment_start_dt::date) = date_part('year',VDT_START_DT::date)
						and date_part('month',ph1.payment_start_dt::date) = date_part('month',VDT_START_DT::date)
						AND PD1.DELETE_SW = 'N' 
						AND PH1.DELETE_SW = 'N'
						AND PS1.PAYMENT_STATUS_CD IN ( '1634','1636')
						AND PS1.DELETE_SW = 'N'
						AND PH1.PAYMENT_TYPE_CD IN ( '6','3294' )
		) ;*/
			
		SELECT COUNT(FAM.FUND_ALLOC_ID)  
			INTO vl_fund_alloc_cnt
		FROM TB_PAYMENT_STATUS PS1, 
			TB_PAYMENT_HEADER PH1,
			TB_PAYMENT_DETAIL PD1
			LEFT OUTER JOIN TB_FUND_ALLOCATION_MASTER FAM
				ON FAM.PAYMENT_DETAIL_ID = PD1.PAYMENT_DETAIL_ID
					AND FAM.DELETE_SW = 'N'
		WHERE PS1.PAYMENT_ID = PH1.PAYMENT_ID
			AND PS1.PAYMENT_ID = PD1.PAYMENT_ID
			AND PS1.DELETE_SW = 'N'
			AND PD1.DELETE_SW = 'N' 
			AND PH1.DELETE_SW = 'N'
			AND PS1.PAYMENT_STATUS_CD IN ( '1634','1636')
			AND PD1.PLACEMENT_ID = vl_placement_id
			and date_part('year',ph1.payment_start_dt::date) = date_part('year',VDT_START_DT::date)
			and date_part('month',ph1.payment_start_dt::date) = date_part('month',VDT_START_DT::date)
			AND PH1.PAYMENT_TYPE_CD IN ( '6','3294' );
			-- AND PD1.county_cd  IN( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE ) ;
				
		IF vl_fund_alloc_cnt = 0 THEN
			Raise notice '>>>>>>>>>>fund allocation = 0 %', vn_payment_detail_id;
			INSERT INTO TEMP_LATE_ENTRY_CUR   
			   (	PAYMENT_DETAIL_ID,
					CLIENT_ID,
					PAYMENT_START_DT,
					PAYMENT_END_DT,
					CASE_ID,
					PAY_AMT
				) 
			VALUES
				(
					vn_payment_detail_id,
					vn_client_id,
					VDT_START_DT,
					VDT_END_DT,
					vl_case_id,
					VN_PAYMENT_AMOUNT_NO
				);
	
		END IF;

		-- Reset
		vn_payment_detail_id := NULL;
		vn_client_id := NULL;
		VDT_START_DT := NULL;
		VDT_END_DT := NULL;
		vl_case_id := NULL;
		VN_PAYMENT_AMOUNT_NO := NULL;
		vl_placement_id := NULL;
		vl_fund_alloc_cnt := 0;
	
	END LOOP;

	Raise notice '>>>>>>>>>>after Late validation (system adjustments) - (Insert 2nd SQL of original cursor)%', al_sqlcode;

	close cur_late_validations;	
	Raise notice '>>>>>>>>>>ending TEMP_LATE_ENTRY_CUR 3rd insert %', now();
	
	-- Reset
	vn_payment_detail_id := NULL;
	vn_client_id := NULL;
	VDT_START_DT := NULL;
	VDT_END_DT := NULL;
	vl_case_id := NULL;
	VN_PAYMENT_AMOUNT_NO := NULL;
	vl_placement_id := NULL;
	vl_fund_alloc_cnt := NULL;
	
	V_SQL_STMT1 :=
		' SELECT DISTINCT PAYMENT_DETAIL_ID, '||
		'	CLIENT_ID, '||
		'	PAYMENT_START_DT, '||
		'	PAYMENT_END_DT, '||
		'	CASE_ID, '||
		'	PAY_AMT '||
		' FROM TEMP_LATE_ENTRY_CUR '||
		' WHERE PAY_AMT <> 0 '|| 
		'	AND PAY_AMT IS NOT NULL '||
		' ORDER BY 1 ';

	-- PREPARE s1 FROM V_SQL_STMT1;
	-- Vineet - END
	Raise notice '>>>>>>>>>>after reset %', V_SQL_STMT1;


	-- OPEN late_entry_cur;
	Raise notice '>>>>>>>>>>before Late_entry_cur %',Late_entry_cur;
	OPEN Late_entry_cur FOR EXECUTE V_SQL_STMT1;

	-- main_loop:
	-- WHILE VL_SQL_CODE <> 100 DO
	loop EXIT WHEN VL_SQL_CODE = 100::integer ;

		FETCH Late_entry_cur INTO vn_payment_detail_id, 
									vn_client_id, 
									VDT_START_DT, 
									VDT_END_DT, 
									vl_case_id, 
									VN_PAYMENT_AMOUNT_NO;
									
		VL_SQL_CODE := SQLCODE;
		Raise notice '>>>>>>>>>>Late_entry_cur>>>>>vn_payment_detail_id %',vn_payment_detail_id;
		Raise notice '>>>>>>>>>>Late_entry_cur>>>>>vn_client_id %',vn_client_id;
		Raise notice '>>>>>>>>>>Late_entry_cur>>>>>VL_SQL_CODE %',VL_SQL_CODE;
		
		IF (vn_payment_detail_id IS NULL AND vn_client_id IS NULL) THEN
			VL_SQL_CODE:=100::integer; -- No data found
			Raise notice '>>>>>>>>>>Late_entry_cur>>>>>Inside IF (vn_payment_detail_id IS NULL AND vn_client_id IS NULL) THEN >>>VL_SQL_CODE %',VL_SQL_CODE;
		END IF;
		
		IF VL_SQL_CODE = 100 THEN
			-- LEAVE main_loop ;
		END IF;
		Raise notice '>>>>>>>>>>Late_entry_cur>>>>>VL_SQL_CODE %',VL_SQL_CODE;

		IF VL_SQL_CODE <> 100 THEN
			Vn_restamp_amt := VN_PAYMENT_AMOUNT_NO;
			vn_Required_balance := VN_PAYMENT_AMOUNT_NO;

			-- Verify if Active 'Conserved' child account exists
			-- 590 - Conserved
			-- 592 - Active
			IF COALESCE(vn_client_account_id,0) = 0 THEN
				SELECT TA.CLIENT_ACCOUNT_ID
					INTO vn_client_account_id
				FROM TB_CLIENT_ACCOUNT TA
				WHERE TA.DELETE_SW = 'N'
					AND TA.ACCOUNT_TYPE_CD = '590'
					AND TA.CLIENT_ID = vn_client_id
					AND TA.STATUS_CD = '592';
			END IF;

			IF vn_client_account_id is NULL THEN
				vn_client_account_id := 0; 	
			END IF;

			-- Get the allocated amount as per pervious stamping
			SELECT (SSI_FUNDING_AMT + SSA_FUNDING_AMT + COC_FUNDING_AMT),
				IVE_FUNDING_AMT
			INTO TOTAL_ALL_AMT,
				VDC_IVE_FUNDING_AMT
			FROM TB_FUND_ALLOCATION_MASTER
			WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id
				AND DELETE_SW = 'N';

			TOTAL_ALL_AMT := COALESCE(TOTAL_ALL_AMT,0);
					
			IF COALESCE(VDC_IVE_FUNDING_AMT,0) <> 0 THEN
				VS_PRE_ELIGI_STATUS  := 'Y'; -- If payment amount was divided into IV-E and State
			ELSE
				VS_PRE_ELIGI_STATUS  := 'N';
			END IF;

			-- PRJ-02312 Get client's Eligibility Status to update in TB_FUND_ALLOCATION_MASTER
			-- New Logic - START
			vs_rs_elig_status_cd := NULL;
			vl_rs_eligiblity_status := 0;
			vs_updt_elig_status_cd := NULL;
		
			-- Get Client's eligibility status from Re-stamping staging table
			SELECT RESULTING_STATUS_CD
				INTO vs_rs_elig_status_cd
			FROM TB_RS_IVE_STATUS	
			WHERE CLIENT_ID = vn_client_id
				AND benefit_start_dt = VDT_START_DT 
				and benefit_end_dt = VDT_END_DT
				AND DELETE_SW = 'N';
		
			IF al_sqlcode < 0 THEN
				as_error := as_error  ;
				as_error := 'Error in getting RESULTING_STATUS_CD from TB_RS_IVE_STATUS.'  ;
				--SIGNAL p_sp_error  ;		    	
			END IF; 
		
			IF vs_rs_elig_status_cd is NOT NULL THEN
				IF vs_rs_elig_status_cd = '2913' THEN -- Eligible Reimbursable
					vl_rs_eligiblity_status := 1;
				END IF;
				vs_updt_elig_status_cd := vs_rs_elig_status_cd;
			ELSE
				vs_curr_elig_status_cd := NULL;
				vl_eligiblity_status := 0;
			
				-- Get Client's eligibility status from TB_CLIENT_ELIGIBILITY
				SELECT btrim(ELIGIBILITY_STATUS_CD)
					INTO vs_curr_elig_status_cd
				FROM TB_CLIENT_ELIGIBILITY
				WHERE CLIENT_ID = vn_client_id 
					AND case_id = vl_case_id 
					AND btrim(ELIGIBILITY_TYPE_CD) = '2931' 
					AND DELETE_SW = 'N' 
					AND START_DT <= VDT_END_DT 
					and (END_DT >= VDT_START_DT OR END_DT IS NULL)
				ORDER BY ELIGIBILITY_ID DESC
				FETCH FIRST ROW ONLY;
		
				IF al_sqlcode < 0 THEN
					as_error := as_error  ;
					as_error := 'Error in getting ELIGIBILITY_STATUS_CD from TB_CLIENT_ELIGIBILITY.'  ;
					--SIGNAL p_sp_error  ;		    	
				END IF; 
		
				IF vs_curr_elig_status_cd = '2913' THEN -- Eligible Reimbursable
					vl_eligiblity_status := 1;	
				END IF;
			
				vs_updt_elig_status_cd := vs_curr_elig_status_cd;
			END IF;			
			-- New Logic - END

			-- Old Code	
			--    SELECT COUNT(*) 
			--	    INTO vl_rs_eligiblity_status
			--		FROM TB_RS_IVE_STATUS
			--	WHERE client_id =  vn_client_id
			--		AND benefit_start_dt = VDT_START_DT 
			--		AND benefit_end_dt = VDT_END_DT
			--		AND resulting_status_cd =  '2913'
			--		AND delete_sw = 'N';
						
			-- Verify if payment has been previously stamped
			SELECT COUNT(*) 
				INTO vn_stamp_count
			FROM TB_FUND_ALLOCATION_MASTER
			WHERE PAYMENT_DETAIL_ID =  vn_payment_detail_id
				AND DELETE_SW = 'N' ;

			-- Re-stamping conditions 
			-- Previously used child accounts funds for COC <> PAYMENT AMOUNT
			-- Client's Eligibility status changed (from ER to NOT ER) OR (from NOT ER to ER)
			IF (TOTAL_ALL_AMT <>  COALESCE(VN_PAYMENT_AMOUNT_NO,0)  
					OR (VS_PRE_ELIGI_STATUS = 'Y' AND  vl_rs_eligiblity_status = 0 )
					OR (VS_PRE_ELIGI_STATUS = 'N' AND Vl_rs_eligiblity_status > 0 ) ) THEN
			
				-- If Active 'Conserved' child account exists - START		
				IF vn_client_account_id > 0 THEN
			
					-- Get previously used SSI funds
					SELECT coalesce(SSI_FUNDING_AMT,0)  
						INTO VN_IS_SSI
					FROM TB_FUND_ALLOCATION_MASTER
					WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id 
						AND DELETE_SW = 'N';

					-- CDM-12488
					IF VN_IS_SSI is null THEN
						VN_IS_SSI := 0;
					END IF;
					
					-- Calculate SSI - START
					-- 587 - SSI
					IF ( VN_IS_SSI ) = 0 THEN  -- First time stamping
						vs_transaction_source_cd  := '587';
					
						-- Set re-stamping amount = Total Payment amt - previously used Child Acc funds
						Vn_restamp_amt := VN_PAYMENT_AMOUNT_NO - TOTAL_ALL_AMT ;

						IF Vn_restamp_amt > 0 THEN
							SELECT a.al_other_amt,a.al_adj_credit,a.al_adj_debit,a.al_stamped_amt,a.al_sqlcode,a.as_error 
								from SP_RS_ACC_TRANS_CALC (vs_transaction_source_cd
															  ,vn_client_account_id
															  ,VDT_START_DT
															  ,VDT_END_DT
															  ,vn_client_id) a 
								into
									vdc_child_other_amount
									,vdc_SSI_amt_adj_credit
									,vdc_SSI_amt_adj_debit
									,vdc_SSI_stamped_amt
									,al_sqlcode
									,As_error;

							IF al_sqlcode <> 0 THEN
								as_error := as_error  ;
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_RS_ACC_TRANS_CALC failed - SSI'  ;
								END IF;
								-- SIGNAL p_sp_error  ;		    			
							END IF;

							vdc_child_other_amount := ( coalesce(vdc_child_other_amount,0) 
													  + coalesce(vdc_SSI_amt_adj_credit,0) ) 
													  - ( coalesce(vdc_SSI_amt_adj_debit,0) 
													  + coalesce(vdc_SSI_stamped_amt,0) );
						
							IF vdc_child_other_amount < 0 THEN
								vdc_child_other_amount := 0;
							END IF;
						
							IF vdc_child_other_amount > VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT)  THEN
								Cos_amount := ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT) ) ;
								vn_Required_balance := ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT +  cos_amount) )  ;
								Vn_restamp_amt := vn_Required_balance ;
							ELSE
								Cos_amount := vdc_child_other_amount ;
								vn_Required_balance := VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT +  Cos_amount) ;
								Vn_restamp_amt := vn_Required_balance ;
							END IF;
							VN_RS_SSI := Cos_amount;
						ELSE --Vn_restamp_amt > 0
							VN_RS_SSI := 0;
						END IF; 
					ELSE --( VN_IS_SSI ) = 0
						VN_RS_SSI :=  VN_IS_SSI   ;
						VN_bl_SSI :=  VN_IS_SSI  ;
					END IF;

					IF VN_bl_SSI <> 0 THEN
						VN_bl_SSI := 0 ;
					ELSE
						VN_bl_SSI := VN_RS_SSI;
					END IF;
					
					-- 06/03 - set 0 if null
					IF VN_bl_SSI is null THEN
						VN_bl_SSI := 0;
					END IF;	
					-- Calculate SSI - END

					-- Get previously used SSA funds
					SELECT SSA_FUNDING_AMT 
						INTO VN_IS_SSA
					FROM TB_FUND_ALLOCATION_MASTER
					WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id 
						AND DELETE_SW = 'N';

					-- CDM-12488
					IF VN_IS_SSA is null THEN
						VN_IS_SSA := 0;
					END IF;
					
					-- Calculate SSA - START
					-- 586 - SSA
					IF ( VN_IS_SSA ) = 0 THEN
						vs_transaction_source_cd := '586';
					
						-- Set re-stamping amount = Total Payment amt - previously used Child Acc funds - SSI funds used in this run
						Vn_restamp_amt := VN_PAYMENT_AMOUNT_NO - ( TOTAL_ALL_AMT + VN_bl_SSI);

						IF Vn_restamp_amt > 0 THEN
							SELECT  a.al_other_amt,a.al_adj_credit,a.al_adj_debit,a.al_stamped_amt,a.al_sqlcode,a.as_error 
								from  SP_RS_ACC_TRANS_CALC(vs_transaction_source_cd
															,vn_client_account_id
															,VDT_START_DT
															,VDT_END_DT
															,vn_client_id) a 
								INTO
									vdc_child_other_amount
									,vdc_ssa_amt_adj_credit
									,vdc_SSa_amt_adj_debit
									,vdc_ssa_stamped_amt
									,al_sqlcode
									,As_error;

							IF al_sqlcode <> 0 THEN
								as_error := as_error  ;
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_RS_ACC_TRANS_CALC failed - SSA'  ;
								END IF;
								--SIGNAL p_sp_error  ;		    			
							END IF;

							vdc_child_other_amount := ( coalesce(vdc_child_other_amount,0) 
													   + coalesce(vdc_SSa_amt_adj_credit,0) ) 
													   - ( coalesce(vdc_SSa_amt_adj_debit,0) 
													   + coalesce(vdc_SSa_stamped_amt,0) );
						
							IF vdc_child_other_amount < 0 THEN
								vdc_child_other_amount := 0;
							END IF;

							IF vdc_child_other_amount > VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT  +  VN_bl_SSI ) THEN
								Cos_amount :=  ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT +  VN_bl_SSI) ) ;
								vn_Required_balance :=  ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT +  VN_bl_SSI + cos_amount) )  ;
								Vn_restamp_amt := vn_Required_balance ;
							ELSE
								Cos_amount := vdc_child_other_amount;
								vn_Required_balance := (VN_PAYMENT_AMOUNT_NO 
													   - (TOTAL_ALL_AMT +  VN_bl_SSI)) -  vdc_child_other_amount  ;
								Vn_restamp_amt := vn_Required_balance ;
							END IF;
							VN_RS_SSA := Cos_amount ;
						ELSE -- Vn_restamp_amt  > 0
							VN_RS_SSA := 0 ;
						END IF;
					ELSE --( VN_IS_SSA   ) = 0
						VN_RS_SSA := VN_IS_SSA ;
						VN_bl_SSA := VN_IS_SSA ;
					END IF;

					IF VN_bl_SSA  <> 0 THEN
						VN_bl_SSA := 0  ;
					ELSE
						VN_bl_SSA := VN_RS_SSA;
					END IF;
					
					-- 06/03 - set 0 if null
					IF VN_bl_SSA is null THEN
						VN_bl_SSA := 0;
					END IF;	
					-- Calculate SSA - END
					
					-- Get previously used OTHER COC funds
					SELECT COC_FUNDING_AMT  
						INTO VN_IS_COC
					FROM TB_FUND_ALLOCATION_MASTER
					WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id
						AND DELETE_SW = 'N' ;
				   
					-- 06/03 - set 0 if null
					IF VN_IS_COC is null THEN
						VN_IS_COC := 0;
					END IF;	
					
					-- Calculate Other (Cost Of Care) - START
					-- 585 - Other (Cost Of Care)
					--  IF (VN_IS_COC) = 0 THEN
					vs_transaction_source_cd  := '585'  ;
				
					-- Set re-stamping amount = 
					-- Total Payment amt - previously used Child Acc funds - SSI funds used in this run - SSA funds used in this run
					Vn_restamp_amt  := VN_PAYMENT_AMOUNT_NO - ( TOTAL_ALL_AMT + VN_bl_SSI + VN_bl_SSA );
				
					IF Vn_restamp_amt > 0 THEN
						SELECT  a.al_other_amt,a.al_adj_credit,a.al_adj_debit,a.al_stamped_amt,a.al_sqlcode,a.as_error 
							from SP_RS_ACC_TRANS_CALC (vs_transaction_source_cd
														,vn_client_account_id
														,VDT_START_DT
														,VDT_END_DT
														,vn_client_id) a 
							INTO
								vdc_child_other_amount
								,vdc_othcoc_amt_adj_credit
								,vdc_othcoc_amt_adj_debit
								, vdc_othcoc_stamped_amt
								,al_sqlcode
								,As_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error  ;
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_RS_ACC_TRANS_CALC failed - COC'  ;
							END IF;
							--SIGNAL p_sp_error  ;		    			
						END IF;

						vdc_child_other_amount := ( coalesce(vdc_child_other_amount,0) 
												   + coalesce(vdc_othcoc_amt_adj_credit,0) ) 
												   - ( coalesce(vdc_othcoc_amt_adj_debit,0) 
												   + coalesce(vdc_othcoc_stamped_amt,0) ) 
												   + vn_is_coc ;
					
						IF vdc_child_other_amount < 0 THEN
							vdc_child_other_amount := 0;
							IF ( coalesce(vdc_child_other_amount,0) 
								+ coalesce(vdc_othcoc_amt_adj_credit,0) ) > coalesce(vdc_othcoc_amt_adj_debit,0) THEN
								vdc_child_other_amount :=  ( coalesce(vdc_child_other_amount,0) 
															+ coalesce(vdc_othcoc_amt_adj_credit,0) ) 
															- coalesce(vdc_othcoc_stamped_amt,0)  ;
							END IF;
						END IF;
					
						IF vdc_child_other_amount > VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT + VN_bl_SSI + VN_bl_SSA) THEN
							Cos_amount := ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT + VN_bl_SSI + VN_bl_SSA )) ;
							vn_Required_balance := ( VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT + VN_bl_SSI + VN_bl_SSA + cos_amount ))  ;
							Vn_restamp_amt := vn_Required_balance ;
						ELSE
							Cos_amount := vdc_child_other_amount ;
							vn_Required_balance :=  VN_PAYMENT_AMOUNT_NO - (TOTAL_ALL_AMT + VN_bl_SSI + VN_bl_SSA + Cos_amount) ;
							Vn_restamp_amt := vn_Required_balance ;
						END IF;
						VN_RS_COC := Cos_amount ;
					ELSE
						VN_RS_COC := 0;
					END IF;--Vn_restamp_amt > 0
						--  ELSE
						--	SET VN_RS_COC = VN_IS_COC  ;
						--	SET  VN_bl_COC =  VN_IS_COC  ;
						--	set Vn_restamp_amt  = VN_PAYMENT_AMOUNT_NO - ( TOTAL_ALL_AMT +  VN_bl_SSI +   VN_bl_SSA );
						--   END IF;--(VN_IS_COC) = 0
					-- Calculate Other (Cost Of Care) - END
				
					-- Set remaining payment amount after Child account 'Cost of Care Reimbursement' 
					vn_Required_balance := Vn_restamp_amt;
				
					-- SSI Transaction insert - START
					IF VN_rs_ssi <> 0 AND vn_iS_ssi = 0 THEN
						-- 587 - SSI
						vs_transaction_source_cd := '587' ;
					
						SELECT a.al_sqlcode,a.as_error 
							from SP_ACC_TRANS_RS_INSERT( vs_transaction_source_cd, VN_rs_ssi, VN_PAYMENT_DETAIL_ID,
												VN_CLIENT_ACCOUNT_ID, VDT_START_DT, VDT_END_DT, ad_run_dt) a 
							into
								al_sqlcode, as_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error  ;
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_ACC_TRANS_RS_INSERT failed - SSI'  ;
							END IF;
							--SIGNAL p_sp_error ;	
						END IF;
					END IF;
					-- SSI Transaction insert - END
				
					-- SSA Transaction insert - START
					IF VN_RS_SSA <> 0 AND VN_IS_SSA  = 0 then
						-- 586 - SSA
						vs_transaction_source_cd := '586' ;
					
						SELECT  a.al_sqlcode,a.as_error 
							from  SP_ACC_TRANS_RS_INSERT( vs_transaction_source_cd, VN_rs_ssa, VN_PAYMENT_DETAIL_ID,
											VN_CLIENT_ACCOUNT_ID, VDT_START_DT, VDT_END_DT, ad_run_dt) a 
							into
								al_sqlcode, as_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error  ;
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_ACC_TRANS_RS_INSERT failed - SSA'  ;
							END IF;
							--SIGNAL p_sp_error  ;		    			
						END IF; 			
					END IF;			                 
					-- SSA Transaction insert - END
				
					-- Other (Cost Of Care) Transaction insert - START
					IF VN_RS_coc <> 0 and VN_rs_coc <> VN_IS_coc THEN
						-- 585 - Other (Cost Of Care)
						vs_transaction_source_cd := '585' ;
					
						SELECT  a.al_sqlcode,a.as_error 
							from  SP_ACC_TRANS_RS_INSERT( vs_transaction_source_cd, VN_rs_coc, VN_PAYMENT_DETAIL_ID,
												VN_CLIENT_ACCOUNT_ID, VDT_START_DT, VDT_END_DT, ad_run_dt) a 
							into
								al_sqlcode, As_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error  ;
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_ACC_TRANS_RS_INSERT failed - COC'  ;
							END IF;
							--SIGNAL p_sp_error  ;		    	
						END IF; 			    		
					END IF; 
					-- Other (Cost Of Care) Transaction insert - END
					-- PRJ-02515 - New condition for 'Closed' or 'Inactive' child account - START
				ELSE
					IF TOTAL_ALL_AMT > 0 THEN -- Previously used Child Accounts funds for 'Cost of Care Reimbursement' 
						vn_Required_balance := vn_Required_balance -	TOTAL_ALL_AMT;
					END IF;	
					-- PRJ-02515 - New condition for 'Closed' or 'Inactive' child account - END	
				END IF ; 
				-- If Active 'Conserved' child account exists - END

				-- IVE CALCULATION - START
				IF  vn_Required_balance > 0 THEN
					-- PRJ-02312 Get client's Eligibility Status to update in TB_FUND_ALLOCATION_MASTER
					-- New Logic - START
					IF vs_updt_elig_status_cd = '2913' THEN -- Eligible Reimbursable
						vdc_Ive_require_amt := vn_Required_balance / 2;
						vdc_state_amt := vn_Required_balance / 2;
					ELSE
						vdc_Ive_require_amt := 0;
						vdc_state_amt := vn_Required_balance ;
					END IF;	
					-- New Logic - END
				
					-- PRJ-02312 Commented on 03/08/2012
					-- Old Logic - START
					--			SELECT COUNT(*) 
					--			    INTO VN_STATUS_CHANGE
					--			    FROM TB_RS_IVE_STATUS	
					--			WHERE CLIENT_ID = VN_CLIENT_ID
					--				AND  benefit_start_dt = VDT_START_DT 
					--				and benefit_end_dt = VDT_END_DT
					--				AND DELETE_SW = 'N';

					-- 		    IF VN_STATUS_CHANGE > 0 THEN
					--			    IF  VS_PRE_ELIGI_STATUS = 'Y' AND  vl_RS_eligiblity_status  = 0 then
					--					set vdc_Ive_require_amt = 0;
					--					set vdc_state_amt = vn_Required_balance ;
					--		  	    elseIF  VS_PRE_ELIGI_STATUS = 'N' AND  vl_RS_eligiblity_status  > 0 then
					--					Set vdc_Ive_require_amt = vn_Required_balance / 2;
					--					set vdc_state_amt = vn_Required_balance / 2;
					--	            elseIF  VS_PRE_ELIGI_STATUS = 'N' AND  vl_RS_eligiblity_status  = 0 then
					--		            set vdc_Ive_require_amt = 0;
					--			        set vdc_state_amt = vn_Required_balance ;
					--	            elseif VS_PRE_ELIGI_STATUS = 'Y' AND  vl_RS_eligiblity_status  > 0 then 		
					--					Set vdc_Ive_require_amt = vn_Required_balance / 2;
					--					set vdc_state_amt = vn_Required_balance / 2;
					--           		END IF;	

					--			ELSE
					--				SELECT COUNT(*)
					--					INTO vl_eligiblity_status
					--					FROM TB_CLIENT_ELIGIBILITY
					--				WHERE CLIENT_ID = vn_client_id 
					--					AND case_id = vl_case_id 
					--					AND ELIGIBILITY_STATUS_CD = '2913'  -- Eligibility Reimb
					--					AND ELIGIBILITY_TYPE_CD = '2931' 
					--					AND DELETE_SW = 'N' 
					--					AND start_dt <= VDT_END_DT 
					--					and (end_dt >=  VDT_START_DT  or end_dt is null);

					--				IF vl_eligiblity_status > 0 then
					--					set vdc_Ive_require_amt = vn_Required_balance / 2;
					--					set vdc_state_amt = vn_Required_balance / 2;
					--		        ELSE
					--			 	    set vdc_state_amt = vn_Required_balance;
					--					set vdc_Ive_require_amt  = 0;
					--		        end if;
					--			END IF;
								-- Old Logic - END
				ELSE
					vn_Required_balance := 0;
					vdc_Ive_require_amt  := 0;
				END IF ;
				--IVE CALCULATION - END
			
				-- Get Fiscal Category code - START
				IF vl_rs_eligiblity_status > 0 OR vl_eligiblity_status > 0 THEN
					VS_ELIG_SW := 'Y' ;
				ELSE
					VS_ELIG_SW := 'N';
				END IF;

				SELECT a.as_fiscalcat,a.al_sqlcode,a.as_error 
					from SP_RS_FISCAL_CAT_CD ( VN_CLIENT_ID,
												vn_payment_detail_id,
												VS_ELIG_SW,
												VDT_start_dt,
												VDT_END_dt) a 
					into
						Vs_fiscal_cat,
						al_sqlcode,
						As_error;

				IF al_sqlcode <> 0 THEN
					as_error := as_error  ;
					IF as_error is NULL OR as_error = '' THEN
						as_error := 'SP_RS_FISCAL_CAT_CD failed'  ;
					END IF;
					--SIGNAL p_sp_error  ;
				END IF;
				-- Get Fiscal Category code - END
			
				-- Fund Allocation Transactions insert - START
				IF vn_client_account_id > 0  THEN -- If Active 'Conserved' child account exists
					IF vn_stamp_count > 0 THEN -- Re-stamping
						IF VN_RS_ssi <> VN_IS_ssi or VN_RS_SsA <> vN_IS_SSA or VN_RS_coc <> coalesce(VN_IS_coc ,0)
							or ((VS_PRE_ELIGI_STATUS = 'Y' AND  vl_RS_eligiblity_status  = 0 and vl_eligiblity_status = 0 )
							or (VS_PRE_ELIGI_STATUS = 'N' AND ( vl_RS_eligiblity_status  > 0 or vl_eligiblity_status > 0 ) )
								) THEN

							INSERT INTO TB_FUND_ALLOCATION_DETAIL 
								(	FUND_ALLOC_HISTORY_ID
									,FUND_ALLOC_ID
									,FUND_ALLOCATION_DATE
									,PAYMENT_DETAIL_ID
									,PAYMENT_AMOUNT
									,FISCAL_CATEGORY_CD
									,SSI_FUNDING_AMT
									,SSA_FUNDING_AMT
									,COC_FUNDING_AMT
									,STATE_FUNDING_AMT
									,IVE_FUNDING_AMT
									,IVD_FUNDING_AMT
									,LOCAL_FUNDING_AMT
									,INITIAL_STAMPING_SW
									,DELETE_SW
									,CREATE_TS
									,CREATE_USER_ID
									,UPDATE_TS
									,UPDATE_USER_ID
									,ELIGIBILITY_STATUS_CD)
							(	SELECT NEXTVAL('sq_fund_allocation_detail')
												,fund_alloc_id
												,FUND_ALLOCATION_DATE
												,PAYMENT_DETAIL_ID
												,PAYMENT_AMOUNT
												,FISCAL_CATEGORY_CD
												,SSI_FUNDING_AMT
												,SSA_FUNDING_AMT
												,COC_FUNDING_AMT
												,STATE_FUNDING_AMT
												,IVE_FUNDING_AMT
												,IVD_FUNDING_AMT
												,LOCAL_FUNDING_AMT
												,INITIAL_STAMPING_SW
												,DELETE_SW
												,current_timestamp -- CREATE_TS
												,'finance' -- CREATE_USER_ID
												,current_timestamp -- UPDATE_TS
												,'finance' -- UPDATE_USER_ID
												,ELIGIBILITY_STATUS_CD
								FROM TB_FUND_ALLOCATION_MASTER
								WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id
									AND DELETE_SW = 'N'
							);

							al_sqlcode := SQLCODE;
							IF al_sqlcode <> 0  THEN
								as_error := 'Error in inserting funding allocation history record';
							END IF ;

						
							UPDATE TB_FUND_ALLOCATION_MASTER
								SET SSI_FUNDING_AMT = coalesce( VN_RS_ssi,0),
									SSA_FUNDING_AMT = COALESCE( VN_RS_ssa,0),
									COC_FUNDING_AMT =  COALESCE( VN_RS_COC,0) + COALESCE(Vn_Is_coc,0),
									FISCAL_CATEGORY_CD = vs_fiscal_cat,
									FUND_ALLOCATION_DATE = ad_run_dt,
									STATE_FUNDING_AMT = vdc_state_amt ,
									IVE_FUNDING_AMT = vdc_Ive_require_amt,
									INITIAL_STAMPING_SW = 'N',
									UPDATE_USER_ID = 'finance',
									UPDATE_TS = current_timestamp,
									ELIGIBILITY_STATUS_CD = vs_updt_elig_status_cd
							WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id
								  AND DELETE_SW = 'N';

							al_sqlcode := SQLCODE;
							IF al_sqlcode <> 0  THEN
								as_error := 'Error in updating funding allocation master record';
							END IF ;
						END IF;
					ELSE -- Initial stamping
						-- 06/03 to add COALESCE for VN_RS_ssi, VN_RS_SSA & VN_RS_coc
						INSERT INTO TB_FUND_ALLOCATION_MASTER
							( FUND_ALLOC_ID,			FUNDING_AMOUNT_NO,
							  PAYMENT_DETAIL_ID,		FUND_ALLOCATION_DATE,
							  PAYMENT_AMOUNT,			FISCAL_CATEGORY_CD,
							  SSI_FUNDING_AMT,			SSA_FUNDING_AMT,
							  COC_FUNDING_AMT,			STATE_FUNDING_AMT,
							  IVE_FUNDING_AMT,			IVD_FUNDING_AMT,
							  LOCAL_FUNDING_AMT,		INITIAL_STAMPING_SW,
							  DELETE_SW,
							  CREATE_TS,    			CREATE_USER_ID,
							  UPDATE_TS,			    UPDATE_USER_ID,
							  ELIGIBILITY_STATUS_CD	 )
						VALUES ( NEXTVAL('sq_FUND_ALLOCATION_MASTER'),		0,
							  vn_payment_detail_id,		ad_run_dt,
							  VN_PAYMENT_AMOUNT_NO,		vs_fiscal_cat,
							  COALESCE(VN_RS_ssi,0),    COALESCE(VN_RS_SSA,0),
							  COALESCE(VN_RS_coc,0),	vdc_state_amt,
							  vdc_Ive_require_amt,		0,
							  0,						'Y',
							  'N',
							  CURRENT_TIMESTAMP,		'finance',
							  CURRENT_TIMESTAMP,		'finance',
							  vs_updt_elig_status_cd )  ;

						al_sqlcode := SQLCODE;
						IF al_sqlcode <> 0  THEN
							as_error := 'Error in inserting funding allocation master record';
						END IF ;	
					END IF;
				ELSE -- If NO Active 'Conserved' child account exists
					VN_RS_ssi := 0;
					VN_RS_SSA := 0;
					VN_RS_COC := 0 ;
				
					IF vn_stamp_count > 0 THEN -- Re-stamping
						IF ((VS_PRE_ELIGI_STATUS = 'Y' AND  vl_RS_eligiblity_status  = 0  and vl_eligiblity_status = 0 )
							or (VS_PRE_ELIGI_STATUS = 'N' AND ( vl_RS_eligiblity_status  > 0 or vl_eligiblity_status > 0 ) )) THEN

							INSERT INTO TB_FUND_ALLOCATION_DETAIL 
								(	FUND_ALLOC_HISTORY_ID
									,FUND_ALLOC_ID
									,FUND_ALLOCATION_DATE
									,PAYMENT_DETAIL_ID
									,PAYMENT_AMOUNT
									,FISCAL_CATEGORY_CD
									,SSI_FUNDING_AMT
									,SSA_FUNDING_AMT
									,COC_FUNDING_AMT
									,STATE_FUNDING_AMT
									,IVE_FUNDING_AMT
									,IVD_FUNDING_AMT
									,LOCAL_FUNDING_AMT
									,INITIAL_STAMPING_SW
									,DELETE_SW
									,CREATE_TS
									,CREATE_USER_ID
									,UPDATE_TS
									,UPDATE_USER_ID
									,ELIGIBILITY_STATUS_CD)
							(SELECT NEXTVAL('sq_fund_allocation_detail')
								,fund_alloc_id
								,FUND_ALLOCATION_DATE
								,PAYMENT_DETAIL_ID
								,PAYMENT_AMOUNT
								,FISCAL_CATEGORY_CD
								,SSI_FUNDING_AMT
								,SSA_FUNDING_AMT
								,COC_FUNDING_AMT
								,STATE_FUNDING_AMT
								,IVE_FUNDING_AMT
								,IVD_FUNDING_AMT
								,LOCAL_FUNDING_AMT
								,INITIAL_STAMPING_SW
								,DELETE_SW
								,current_timestamp -- CREATE_TS
								,'finance' -- CREATE_USER_ID
								,current_timestamp -- UPDATE_TS
								,'finance' -- UPDATE_USER_ID
								,ELIGIBILITY_STATUS_CD
							FROM TB_FUND_ALLOCATION_MASTER
							WHERE PAYMENT_DETAIL_ID = vn_payment_detail_id
								AND DELETE_SW = 'N'

							);

							al_sqlcode := SQLCODE;
							IF al_sqlcode <> 0  THEN
								as_error := 'Error in inserting funding allocation history record';
							END IF ;
						
							-- PRJ-02515 - New condition for 'Closed' or 'Inactive' child account - START
							-- Set Previously used Child Accounts funds for 'Cost of Care Reimbursement' 
							SELECT COALESCE(SSI_FUNDING_AMT,0),
								COALESCE(SSA_FUNDING_AMT,0),
								COALESCE(COC_FUNDING_AMT,0)
							INTO VN_RS_ssi,
								VN_RS_SSA,
								VN_RS_COC
							FROM TB_FUND_ALLOCATION_MASTER
							WHERE PAYMENT_DETAIL_ID  = vn_payment_detail_id
								AND DELETE_SW = 'N';

			
							IF al_sqlcode < 0 THEN
								as_error := as_error  ;
								as_error := 'Error in getting Previously used Child Accounts funds.'  ;
							-- SIGNAL p_sp_error;		    	
							END IF; 
							-- PRJ-02515 - New condition for 'Closed' or 'Inactive' child account - END
						
							UPDATE TB_FUND_ALLOCATION_MASTER
								SET SSI_FUNDING_AMT = COALESCE( VN_RS_ssi,0),
									SSA_FUNDING_AMT = COALESCE( VN_RS_ssa,0),
									COC_FUNDING_AMT =  COALESCE( VN_RS_COC,0) ,
									FISCAL_CATEGORY_CD = 	vs_fiscal_cat,
									FUND_ALLOCATION_DATE = ad_run_dt,
									STATE_FUNDING_AMT =  vdc_state_amt ,
									IVE_FUNDING_AMT =vdc_Ive_require_amt,
									INITIAL_STAMPING_SW = 'N',
									UPDATE_USER_ID = 'finance',
									UPDATE_TS = current_timestamp,
									ELIGIBILITY_STATUS_CD = vs_updt_elig_status_cd
							WHERE PAYMENT_DETAIL_ID =  vn_payment_detail_id
								 AND DELETE_SW = 'N';	

							al_sqlcode := SQLCODE;
							IF al_sqlcode <> 0  THEN
								as_error := 'Error in updating funding allocation master record';
							END IF ;
						END IF;
					ELSE -- Initial stamping
						-- 06/03 to add COALESCE for VN_RS_ssi, VN_RS_SSA & VN_RS_coc
						INSERT INTO TB_FUND_ALLOCATION_MASTER
							( FUND_ALLOC_ID,			FUNDING_AMOUNT_NO,
							 PAYMENT_DETAIL_ID,		    FUND_ALLOCATION_DATE,
							 PAYMENT_AMOUNT,			FISCAL_CATEGORY_CD,
							 SSI_FUNDING_AMT,			SSA_FUNDING_AMT,
							 COC_FUNDING_AMT,			STATE_FUNDING_AMT,
							 IVE_FUNDING_AMT,			IVD_FUNDING_AMT,
							 LOCAL_FUNDING_AMT,		    INITIAL_STAMPING_SW,
							 DELETE_SW,
							 CREATE_TS,    		        CREATE_USER_ID,
							 UPDATE_TS,			        UPDATE_USER_ID,
							 ELIGIBILITY_STATUS_CD )
						VALUES ( NEXTVAL('sq_FUND_ALLOCATION_MASTER') ,		0,
							 vn_payment_detail_id,		ad_run_dt,
							 VN_PAYMENT_AMOUNT_NO,		vs_fiscal_cat,
							 COALESCE(VN_RS_ssi,0),		COALESCE(VN_RS_SSA,0),
							 COALESCE(VN_RS_coc,0),		vdc_state_amt,
							 vdc_Ive_require_amt,		0,
							 0,							'Y',
							 'N',
							 CURRENT_TIMESTAMP,			'finance',
							 CURRENT_TIMESTAMP,			'finance',
							 vs_updt_elig_status_cd )  ;

						al_sqlcode := SQLCODE;
						IF al_sqlcode <> 0  THEN
							as_error := 'Error in inserting funding allocation master record';
						END IF ;	
					END IF ;
				END IF ; --vn_client_account_id > 0
				-- Fund Allocation Transactions insert - END
			END IF ; --TOTAL_ALL_AMT <>  coalesce(VN_PAYMENT_AMOUNT_NO,0)

			-- 5583 AFS
			IF VN_IS_COC = 0 AND VN_IS_SSI = 0 AND VN_IS_SSA = 0 THEN
				UPDATE TB_PAYMENT_HEADER
				   SET INTERFACE_TO_CD = '5583'
				WHERE DELETE_SW = 'N'
					AND PAYMENT_TYPE_CD = '3294'
					AND MANUAL_SW= 'N'
					AND PAYMENT_START_DT =VDT_START_DT
					AND PAYMENT_END_DT = VDT_END_DT
					AND PAYMENT_ID IN (SELECT PAYMENT_ID
											FROM TB_PAYMENT_DETAIL
										WHERE DELETE_SW = 'N'
										   AND PAYMENT_DETAIL_ID = vn_payment_detail_id 
										   AND county_cd IN
										   ( select statecountycode 
												from county where activeflag = 1 and golivedate <= CURRENT_DATE )	   
										) ;

				al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					as_error := 'Error in Updating Payment Header with code interface to AFS'  ;
					vs_identity_column := 'Payment ID';
					vs_identity_val := 'Multiple';
					--SIGNAL p_sp_error  ;
				END IF ;
			END IF ;
		

			-- COMMIT;--
			VN_PAYMENT_AMOUNT_NO      := 0;
			vl_rs_eligiblity_status   := 0;
			VN_RS_COC  		      := 0;
			VN_RS_SSI  		      := 0;
			VN_RS_SSA  		      := 0;
			VN_IS_COC  		      := 0;
			VN_IS_SSI  		      := 0;
			VN_IS_SSA  		      := 0;
			VN_BL_COC  		      := 0;
			VN_BL_SSI  		      := 0;
			VN_BL_SSA  		      := 0;
			Cos_amount 		      := 0;
			vdc_child_other_amount    := 0;
			vn_Required_balance       := 0;
			vdc_state_amt             := 0;
			vdc_Ive_require_amt       := 0;
			Vn_restamp_amt            := 0;
			vn_payment_detail_id      := 0;
			vn_client_account_id      := 0;
			VDT_START_DT  	      := null;
			VDT_END_DT    	      := null;
			vn_client_id              := 0;
			vdc_child_other_amount    := 0;
			vdc_ssa_amt_adj_credit    := 0;
			vdc_SSa_amt_adj_debit     := 0;
			vdc_ssa_stamped_amt       := 0;
			vdc_ssa_amt_adj_credit    := 0;
			vdc_SSa_amt_adj_debit     := 0;
			vdc_ssi_amt_adj_credit    := 0;
			vdc_SSi_amt_adj_debit     := 0;
			vdc_ssi_stamped_amt       := 0;
			vdc_othcoc_amt_adj_credit := 0;
			vdc_othcoc_amt_adj_debit  := 0;
			vdc_ssa_stamped_amt       := 0;
			vdc_othcoc_stamped_amt    := 0;
			total_all_amt             := 0;
			vn_stamp_count            := 0;
			vl_eligiblity_status      := 0;
			--	  VN_STATUS_CHANGE          := 0;
			VS_PRE_ELIGI_STATUS       := NULL;
			VDC_IVE_FUNDING_AMT       := 0;
			VS_ELIG_SW                := NULL;
			vs_fiscal_cat             := NULL;
			vs_updt_elig_status_cd := NULL;
		END IF;
		--END WHILE ;
	END LOOP;

	Raise notice '>>>>>>>>>>start SP_PAYMENT_STAMPING %',now();

	CLOSE Late_entry_cur;

	Perform SP_PAYMENT_STAMPING ( ad_run_dt ) ;
	al_sqlcode := SQLCODE;
	IF al_sqlcode <> 0  THEN
		as_error := 'Error in PAYMENT_STAMPING';
	End if;

	Raise notice '>>>>>>>>>>end SP_PAYMENT_STAMPING %',now();
	UPDATE TB_BATCH_RUNTIME_LOG
		SET RUNTIME_END_TS = CURRENT_TIMESTAMP, 
			UPDATE_TS = CURRENT_TIMESTAMP, 
			UPDATE_USER_ID = 'RESTAMP',
			DELETE_SW = 'N',
			SUCCESS_SW = 'Y'
	WHERE RUNTIME_LOG_ID = VL_RUNTIME_ID;
	  
	al_sqlcode := 0;
	as_error := '';
	RETURN 1;
END;

$function$
;
