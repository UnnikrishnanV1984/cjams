Drop function if exists cjams.sp_foster_care_public_final();

CREATE OR REPLACE FUNCTION cjams.sp_foster_care_public_final()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Amit Rastogi
-- Date Created :04/04/2004
-- generating final payment detail for public provider
-- if there is any change from draft
-- ADDED CONDITION FOR PROVIDER_ID IS NOT NULL
-- incident 5265
-- incident 5638 added logic for initial clothing allowance amount
-- ADDED LOGIC TO CREATE PAYMENT HEADER ONLY IF NO HEADER EXIST
-- INITIALIZING THE VALUES FOR THE PAYMENT AMOUNT
-- 01/14/2006 added logic for final payment calculation
-- 01/18/2006 ADDED FLAG TO UPDATE THE PAYMENT STATUS
-- 01/18/2006 change the logic for age calculation
-- BED RETAINER FEE CHANGE
-- REMOVING PRE ADOPTIVE PLACEMENT STRUCTURE, ADDING RATE_STRUCTURE_ID INSTEAD OF PLACEMENT_STRUCTURE_ID
-- 02/02/2006 STIPEND LOGIC CHANGE
-- INITIAL CLOTHING ALLOWANCE LOGIC CHANGE
-- 02/08/2006 exclude Residential Treatment Centers
-- 05/04/2006 change calculation of age of the client. Instead of age based on the CURRENT_DATE changed to
-- calculate age based on the placement payment month #6962
-- included conversion_sw to exclude the split converted placement.  #7521
-- Mohan - added error log
-- 10/12/2006 added two parameter to SP_FOSTERCARE_CALCULATION for payment calculation
-- 10/26/2006 change the payment header procedure call passing prev month dates
-- 12/01/2006 changed for stipend payment calculation.
-- 12/19/2006 placement stipend change
-- 02/05/2007 Initial clothing allowance rate calculation
-- 03/20/2007 incident 7263 added new procedure to update reason code
-- 05/09/2007 Vineet Tirodkar - Added CONTINUE HANDLER to trap the Errors/Warnings in TB_BATCH_ERROR_LOG # 14088
-- 07/10/2007 Vineet Tirodkar - commit statement has been added inside the for loop
-- 03/17/2008 Vineet Tirodkar - Changes for Provider Checklist (CIS-16755)
--	      Change in Cursor cur_check_detail to add Provider checklist table
--	      Change in Cursor cur_placement_detail to add DOB and Age conditions 	
-- 04/14/2008 Vineet Tirodkar - Changes in LOG ERROR texts to identify exact SQLs
--            Reting variables as NULL before each run in a loop for ROOM AND BOARD
-- 04/21/2008 Vineet Tirodkar - TO EXCLUDE SAME ENTRY DT and EXIT DT PLACEMENT	
-- 05/13/2008 Vineet Tirodkar - Change in logic to pay initial clothing or monthly clothing allowance
--                              (same as in public draft payment procedure)
-- 05/29/2008 Vineet Tirodkar - Changes in logic for Provider Checklist,
--            In case of missing information generate payment with status as Hold.
-- 05/30/2008 Vineet Tirodkar - New arguments Original Payment ID and Pay Detl ID for SP_PAYMENT_DETAIL_INSERT
-- 06/02/2008 Vineet Tirodkar - New Logic to update payment with status as Hold
--            In case of missing info and Payment Type 'Final'.
-- 08/18/2008 Vineet Tirodkar - Change in Cursor cur_placement_detail for Age conditions (< 21). CIS-17754	
-- 09/17/2008 Vineet Tirodkar - CIS-17815
--            1) New Logic for payments to the placement with 'Emergency Foster Home Care' for first 60 days and there after.
--            2) Call of New Stored Procedure - SP_EFC_RFC_TICKLERS
-- 10/2/2008  Vineet Tirodkar - 1) To Re variables before calling SP_GET_PLACEMENT_RATE
--            2) Changes for CHESSIE was underpaying for 1 night in case of Placement Structure ID 13 (Emergency Foster Home Care)
-- 10/24/2008 Vineet Tirodkar - Check if there is any payment header created without detail; then delete Payment Status and Payment Header record. # 18838
-- 11/10/2008 Vineet Tirodkar - Commented call of SP_FOSTER_CARE_BEDRETAINER, to disable Bed retainer fee functionality. # 18936
-- 12/08/2008 Vineet Tirodkar - Changes to pass new Argument for SP_PAYMENT_OFF - CIS-18254
-- 01/07/2009 Vineet Tirodkar - Changes NOT to Off Amount if Payment status is  'Hold' - CIS-18254 II
-- 03/18/2009 Vineet Tirodkar - Change in Placement Cursor for Age conditions.
--            CHESSIE will pay to all clients up to DOB for the client turning 21 in that service month  - CIS-18524	
-- 08/05/2009 Vineet Tirodkar - To Comment the logic to generate payment for Maximum Initial Clothing Allowance - CIS-18971
-- 08/17/2009 Vineet Tirodkar - Changes to Implement Per Diem Rates for Public Provider Payments -- CIS-19002
-- 09/03/2009 Vineet Tirodkar - Changes to recalculate payment amounts always
--            For Placement structures 11 and  12 (Intermediate Foster Care, Treatment Foster Care) - CIS-19002
-- 09/08/2009 Vineet Tirodkar - Do Not Update Change Reason code as '3035 - Date Change' for stipend if nothing changes since draft to final
-- 12/07/2009 Vineet Tirodkar - Changes in logic for Stipend calculation
-- 01/27/2010 Vineet Tirodkar - New Logic for 'Room & Board/Clothing/Differential' rate type -- CIS-18884
-- 10/22/2012 Vineet Tirodkar PRJ-03018 - To fix Foster care payment issue additional payment for 1 night (last day of the month).
-- 05/29/2015 J Niespodzianski PRJ-04753 - Fiscal Enhancements Foster Care rate changes.
-- 06/05/2015 Vineet Tirodkar - PRJ-04753 - Fiscal-Related Enhancements - Phase I
-- 			  Modifications to SP_PAYMENT_DETAIL_INSERT calls for Fiscal Audit Trail(BDSD Req # 36)
-- 07/12/2021 Vineet Tirodkar - To exclude placements with entry date beyond client's 21st bday (CIDM-3049) 
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 11/06/2024 - Vineet Tirodkar - To add new Non-paid Kinship Placement structure in exclusion  (B-207876 / CIDM-9688)
------------------------------------------------------------------------

DECLARE
 vl_pay_header_id BIGINT DEFAULT 0;--
 vl_pay_detail_id BIGINT DEFAULT 0;--
 vl_provider_id BIGINT DEFAULT 0;--
 vl_placement_structure_id BIGINT DEFAULT 0;--
 vl_draft_service_id BIGINT DEFAULT 0;--
 vl_placement_id BIGINT DEFAULT 0;--
 vl_payment_detail_count BIGINT DEFAULT 0;--
 vl_emergency_structure_id BIGINT DEFAULT 71;--

 vl_linked_pymnt_hdr_id BIGINT DEFAULT NULL;--
 vl_reference_payment_detail_id BIGINT DEFAULT NULL;--

 vl_approved_beds INT DEFAULT 0;--
 vl_paid_beds INT DEFAULT 0;--

 vl_available_vacancy INT DEFAULT 0;--
 vl_pay_header_count INT DEFAULT 0;--
 vl_payment_count INT DEFAULT 0;--
 vl_unit_no INT DEFAULT 0;--
 vl_no_of_nights INT DEFAULT 0;--
 vl_age_of_child INT DEFAULT 0;--
 vl_clothing_allow_count INT DEFAULT 0;--
 vl_doc_count INT DEFAULT 0;--
 vl_bed_retainer_count INT DEFAULT 0;--
 vl_bed_retainer_count_exist INT DEFAULT 0;--

 vdc_monthly_rate decimal(10,2);--
 vdc_perdiem_rate decimal(10,2);--
 vdc_monthly_clothing_rate decimal(10,2);--
 vdc_emergency_per_diem_rate decimal(10,2);--
 vdc_bed_retainer_fee decimal(10,2);--
 vdc_gross_amount decimal(10,2);--
 vdc_bed_retainer_total decimal(10,2);--
 vdc_total_final_amount decimal(10,2);--
 vdc_stipend_amount_no decimal(10,2);--

 vs_unit_type VARCHAR(5);--
 vs_validation_status VARCHAR(5) DEFAULT NULL;--
 vl_doc_level_id BIGINT;--
 vs_payment_type VARCHAR(5) DEFAULT '6';--
 vs_draft_final_type CHAR(1) DEFAULT 'F';--
 vs_public_sw CHAR(1) DEFAULT 'L';--

 vs_rate_type_cd VARCHAR(5);--
 vs_payment_status VARCHAR(5);--
 vs_withhold_payment CHAR(1);--
 vs_initial_clothing_flag CHAR(1) DEFAULT 'T'; -- initial clothing logic flag

 vs_update_status_flag CHAR(1) DEFAULT  'N';--

 vd_previous_month_start_dt DATE;--
 vd_previous_month_end_dt DATE;--
 vd_current_month_end_dt DATE;--
 vd_current_service_start_dt DATE;--
 vd_current_service_end_dt DATE;--
 vd_draft_service_end_dt DATE;--
 vd_draft_service_start_dt DATE;--
 vd_current_placement_start_dt DATE;--
 vd_current_placement_end_dt DATE;--

 vl_checklist_cnt INT DEFAULT 0;--

 vl_efc_calc_days INT;--
 vd_efc_service_st_dt DATE;--
 vd_efc_service_end_dt DATE;--
 vl_efc_unit_no INT;--
 vs_efc_unit_type VARCHAR(5);--
 vd_rfc_service_st_dt DATE;--
 vd_rfc_service_end_dt DATE;--
 vl_rfc_unit_no INT;--
 vs_rfc_unit_type VARCHAR(5);--
 vl_plc_structure_rfc_id BIGINT DEFAULT 10;--
 vs_EFC_no_change CHAR(1);--
 vs_RFC_no_change CHAR(1);--
 vd_efc_draft_service_start_dt DATE;--
 vd_efc_draft_service_end_dt DATE;--
 vd_rfc_draft_service_start_dt DATE;--
 vd_rfc_draft_service_end_dt DATE;--
 vs_note_tx VARCHAR(500);--
 vl_no_of_days INTEGER;--

-- 12/07/2009
 vd_stipend_service_start_dt DATE;--
 vd_stipend_service_end_dt DATE;--
 vl_stipend_unit_no INT;--
 vs_stipend_unit_type VARCHAR(5);--

--01/29/2010
 vd_csrfc_service_st_dt DATE;--
 vd_csrfc_service_end_dt DATE;--
 vl_csrfc_unit_no INT;--
 vs_csrfc_unit_type VARCHAR(5);--
 vd_csrfcd_service_st_dt DATE;--
 vd_csrfcd_service_end_dt DATE;--
 vl_csrfcd_unit_no INT;--
 vs_csrfcd_unit_type VARCHAR(5);--

 vs_CSRFC_no_change CHAR(1);--
 vs_CSRFCD_no_change CHAR(1);--
 vd_csrfc_draft_st_dt DATE;--
 vd_csrfc_draft_ed_dt DATE;--
 vd_csrfcd_draft_st_dt DATE;--
 vd_csrfcd_draft_ed_dt DATE;--

 vl_check_csrfc_unit_no INT;--
 vl_check_csrfcd_unit_no INT;--

 vs_DRAFT_CHANGED CHAR(1);--

--Mohan
  VS_RESULT CHAR(1);--
  VS_USER_ID VARCHAR(10) DEFAULT 'finance';--
  VTS_PREVIOUS_RUN_TS timestamp;--varchar(50) ;--
  VTS_CURRENT_RUN_TS timestamp;--varchar(50) ;--
  VL_ROWCOUNT INTEGER DEFAULT  0;--
  VL_SQLCODE INTEGER DEFAULT 0;--
  VS_MESSAGE VARCHAR(150);--
--Mohan
 vdc_off_amount DECIMAL(10,2);--

-- PRJ-04753
 vs_change_type VARCHAR(5) DEFAULT NULL ;--

--Log Error
 SQLCODE INTEGER DEFAULT 0;--
 al_sqlcode INT DEFAULT 0;--
 as_error VARCHAR(3000) DEFAULT '';--
 SQLSTATE CHAR(5) DEFAULT '00000';--
 --p_sp_error CONDITION FOR SQLSTATE '99999' ;--
 vs_message_text VARCHAR(3000) DEFAULT '';--
 vl_ret_status INTEGER DEFAULT 0;--
 vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_FOSTER_CARE_PUBLIC_FINAL';--
 vs_identity_column VARCHAR(100);--
 vs_identity_val VARCHAR(100);--
 cur_check_detail_record record;
 cur_placement_detail_record record;
 cur_check_detail REFCURSOR;
 cur_placement_detaiL REFCURSOR;
 
--CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
begin
	EXCEPTION WHEN OTHERS THEN
    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;

--     al_sqlcode = -1 ;--
     as_error = COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
     as_error = COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');--
     as_error = as_error || COALESCE(vs_message_text ,'');--

    select SP_BATCH_ERROR_LOG ( 'SP_FOSTER_CARE_PUBLIC_FINAL'::character varying ,
				        NULL::bigint,
				        NULL::bigint,
                		NULL::character varying,
				        NULL::INTEGER,
						NULL::character varying,
				        SQLSTATE::character varying,
                		as_error::character varying,
				        'finance'::character varying) INTO
                		vl_ret_status;

     as_error = '';--
     RETURN 0;
END;-- 
--Log Error

-- get the last month start date and end date
SELECT (date_trunc('month', now()) - interval '1 month')::date,
       (date_trunc('month', now())::date - 1),
       ((date_trunc('month', now()) + interval '1 month')- interval '1 Day')::date
INTO    vd_previous_month_start_dt,
        vd_previous_month_end_dt,
        vd_current_month_end_dt;

--  Initialize variables with the CURRENT_TIMESTAMP
 VTS_PREVIOUS_RUN_TS = CURRENT_TIMESTAMP;--            to_char(CURRENT_TIMESTAMP, 'yyyy-MM-dd HH24:MI:SS.MS')::timestamp; --
 VTS_CURRENT_RUN_TS = CURRENT_TIMESTAMP;--  to_char(CURRENT_TIMESTAMP, 'yyyy-MM-dd HH24:MI:SS.MS')::timestamp;

--  get the last run timestamp
--  if first run, i.e., no rows in log, then leave as initialized
SELECT COUNT(*)
	INTO VL_ROWCOUNT
FROM TB_PAYMENT_RUNTIMES_LOG
WHERE PAYMENT_TX   = 'FC_PUBLIC_FINAL';--

IF  VL_ROWCOUNT > 0 THEN
	--SELECT MAX(PAYMENT_CURRENT_RUN_TS) || '-00'
	SELECT MAX(PAYMENT_CURRENT_RUN_TS)::timestamp
	   INTO VTS_PREVIOUS_RUN_TS
	FROM TB_PAYMENT_RUNTIMES_LOG
	WHERE PAYMENT_TX   = 'FC_PUBLIC_FINAL';--
END IF;--

---  Insert Into PAYMENT log

INSERT INTO TB_PAYMENT_RUNTIMES_LOG   
		(	PAYMENT_RUNTIMES_LOG_ID,
			PAYMENT_TX,
			PAYMENT_CURRENT_RUN_TS,
			PAYMENT_PREVIOUS_RUN_TS,
			PAYMENT_BATCH_NO,
			PAYMENT_SUCCESSFUL_SW,
			CREATE_TS,
			CREATE_USER_ID,
			UPDATE_TS,
			UPDATE_USER_ID,
			DELETE_SW,
			PAYMENT_OTHER_TX)
SELECT 		NEXTVAL ('sq_payment_runtimes_log'),
			'FC_PUBLIC_FINAL',
			VTS_CURRENT_RUN_TS,
			VTS_PREVIOUS_RUN_TS,
			'',
			'',
			VTS_CURRENT_RUN_TS,
			VS_USER_ID,   							
			VTS_CURRENT_RUN_TS,
			VS_USER_ID,
			'N',
			'SP_FOSTER_CARE_PUBLIC_FINAL -->  PROGRAM STARTED';
--FROM sysibm.sysdummy1 ;--
					
 
		al_sqlcode = SQLCODE;			--
IF al_sqlcode <> 0 THEN
	 as_error = 'Error in inserting PAYMENT RUNTIMES LOG -->  PROGRAM STARTED'  ;--
	 vs_identity_column = '';--
	 vs_identity_val = '';--
	-- SIGNAL p_sp_error  ;--
END IF ;--
						
OPEN cur_check_detail  FOR   
		SELECT DISTINCT PL.PROVIDER_ID
	   FROM TB_PLACEMENT PL
	WHERE PL.PROVIDER_ORGANIZATION_ID  IS NULL
		AND PL.CONTRACT_PROGRAM_ID IS NULL
		AND PL.PLACEMENT_STRUCTURE_ID IS NOT NULL
		AND PL.PROVIDER_ID IS NOT NULL
		AND PL.PLACEMENT_STRUCTURE_ID not in ( 8, 76, 531 )
		AND PL.APPROVAL_STATUS_CD = '3047'
		AND (( PL.VOID_SW IS NULL) OR ( PL.VOID_SW = 'N'))
		AND PL.ENTRY_DT <= vd_previous_month_end_dt
        AND ( ( PL.EXIT_DT IS NULL) OR ( PL.EXIT_DT > vd_previous_month_start_dt ))
        AND ( PL.EXIT_DT IS NULL OR PL.ENTRY_DT <> PL.EXIT_DT )
		AND PL.DELETE_SW = 'N'
		AND PL.CONVERSION_SW IS NULL;

    loop
	 fetch cur_check_detail into cur_check_detail_record;
	  EXIT WHEN NOT FOUND;
	 vl_provider_id = 0;--
	 vl_pay_header_id = 0;  -- INITIAL VALUE
	-- Check if payment header record is created for the previous month for this provider
	SELECT PAYMENT_ID
		INTO vl_pay_header_id
	 FROM TB_PAYMENT_HEADER
	WHERE PROVIDER_ID = cur_check_detail_record.PROVIDER_ID AND
		  DELETE_SW = 'N' AND
		  PAYMENT_START_DT = vd_previous_month_start_dt AND
		  PAYMENT_END_DT = vd_previous_month_end_dt AND
		  PAYMENT_TYPE_CD = '6';--

	 vl_provider_id = cur_check_detail_record.PROVIDER_ID;--
     RAISE INFO 'PROVIDER ID IS (%)', vl_provider_id;
	 
    IF vl_pay_header_id IS NULL OR vl_pay_header_id = 0 THEN      -- no payment header found for this provider create payment header
     RAISE INFO '-- no payment header found for this provider create payment header';
        SELECT a.al_header_id,a.al_sqlcode,a.as_error from
											   sp_payment_header_insert(vl_provider_id,
												vs_payment_type::varchar,
												vd_previous_month_start_dt :: date,
												vd_previous_month_end_dt :: date) a into vl_pay_header_id, al_sqlcode,as_error;

		IF al_sqlcode <> 0 THEN
			 as_error = as_error || ' (SP-1)' ;--
			IF as_error is NULL OR as_error = '' THEN
				 as_error = 'SP_PAYMENT_HEADER_INSERT failed. (SP-1)'  ;--
			END IF;--
			-- SIGNAL p_sp_error  ;--
		END IF ;--
    END IF ;--

    OPEN cur_placement_detail  FOR
        SELECT P.PLACEMENT_ID,
        	   P.ENTRY_DT,
        	   (CASE WHEN f_age(C.dob::DATE,vd_previous_month_end_dt) = 21 AND ( (C.dob::DATE + INTERVAL '21 years') < P.EXIT_DT OR P.EXIT_DT is NULL)  THEN
					C.dob::DATE + INTERVAL '21 years'	
				ELSE
					P.EXIT_DT
                END ) AS EXIT_DT,
        	   P.PLACEMENT_STRUCTURE_ID,
        	   P.CLIENT_ID,--C.COUNTY_CD,
        	   (CASE WHEN f_age(C.dob::DATE, vd_previous_month_end_dt) = 21 THEN
					20
				ELSE
					f_age(C.dob::DATE, vd_previous_month_end_dt)
        	    END )AS AGE_NO,
        	   --C.APPROXIMATE_AGE_NO,
        	   P.PLACEMENT_CHANGE_DT,
        	   P.PAYMENT_HEADER_ID,
        	   P.RATE_STRUCTURE_ID
    	FROM TB_PLACEMENT P,
	         person C
    	WHERE  P.PROVIDER_ID = cur_check_detail_record.PROVIDER_ID
	    	AND P.CLIENT_ID = C.cjamspid
    		AND P.PROVIDER_ORGANIZATION_ID  IS NULL
	    	AND P.CONTRACT_PROGRAM_ID IS NULL
    		AND P.PLACEMENT_STRUCTURE_ID IS NOT NULL
	    	AND P.PLACEMENT_STRUCTURE_ID not in ( 8, 76, 531 )
    		AND P.APPROVAL_STATUS_CD = '3047'
    		AND ((P.VOID_SW IS NULL) OR (P.VOID_SW = 'N'))
    		AND P.ENTRY_DT <= vd_previous_month_end_dt
	    	AND ( (P.EXIT_DT  IS NULL) OR  (P.EXIT_DT > vd_previous_month_start_dt ))
	    	AND ( P.EXIT_DT IS NULL OR P.ENTRY_DT <> P.EXIT_DT )
    		AND P.DELETE_SW = 'N'
	    	AND P.CONVERSION_SW IS NULL
    		AND C.dob::DATE IS NOT NULL
    		AND ( f_age(C.dob::DATE, vd_previous_month_end_dt ) < 21
				OR ( MONTH_CUSTOM(C.dob::DATE + INTERVAL '21 years') = MONTH_CUSTOM(vd_previous_month_end_dt)
					AND YEAR_CUSTOM(C.dob::DATE + INTERVAL '21 years') = YEAR_CUSTOM(vd_previous_month_end_dt)
					AND DAY_CUSTOM(C.dob::DATE + INTERVAL '21 years') <> 1
	         		)
                )
			and P.ENTRY_DT::date < (C.dob::DATE + INTERVAL '21 years')::date -- CIDM-3049			
			;
	    	-- AND f_age(C.DOB_DT, vd_previous_month_end_dt) < 21
		
	    LOOP
		fetch cur_placement_detail into cur_placement_detail_record; 
		  EXIT WHEN NOT FOUND;
		 RAISE INFO 'checking placement %I',cur_check_detail_record.PROVIDER_ID;
		-- checking placement structure for preadaptive placement with adoption subsidy
		 vl_placement_structure_id = cur_placement_detail_record.RATE_STRUCTURE_ID;--
		 vl_placement_id = cur_placement_detail_record.PLACEMENT_ID;--
		 vd_current_placement_start_dt = cur_placement_detail_record.ENTRY_DT;--
		 vd_current_placement_end_dt = cur_placement_detail_record.EXIT_DT;--

		 vl_unit_no = NULL;   -- INITIAL VALUE
		 vs_unit_type = NULL; -- INITIAL VALUE
		-- check validation record
		-- CHECK VALIDATION RECORD
		 vs_validation_status = NULL;--

        SELECT VALIDATION_STATUS_CD
            INTO vs_validation_status
         FROM TB_PLACEMENT_VALIDATION
        WHERE PLACEMENT_ID = vl_placement_id 
			AND DELETE_SW = 'N' 
			AND VALIDATION_START_DT = vd_previous_month_start_dt 
			AND VALIDATION_END_DT = vd_previous_month_end_dt 
			AND PLACEMENT_VALIDATION_ID = (SELECT MAX(PLACEMENT_VALIDATION_ID)
											FROM TB_PLACEMENT_VALIDATION
										   WHERE PLACEMENT_ID = vl_placement_id 
												 AND DELETE_SW = 'N' 
												 AND VALIDATION_START_DT = vd_previous_month_start_dt 
												 AND VALIDATION_END_DT = vd_previous_month_end_dt
										   ) ;--
--vs_validation_status :='1750'; --temporarily added the validation code. need to do the validation module also. //here
        IF vs_validation_status = '1750'  THEN  -- PLACEMENT VALIDATED
			 vs_update_status_flag = 'Y';--

			--  Adoption  Subsidy Check
			SELECT as_adpsub_exist from  SP_ADOPTION_SUBSIDY_CHECK(cur_placement_detail_record.CLIENT_ID,
													cur_placement_detail_record.ENTRY_DT::date) into
													VS_RESULT;--
													 RAISE INFO 'SP_ADOPTION_SUBSIDY_CHECK result %I' , VS_RESULT;
			IF UPPER(VS_RESULT)  = 'N'  THEN
				IF vl_placement_structure_id = 13 THEN -- CIS-17815
             	    --New SP for 60 days calculation, to return days in EFC and/or RFC for payments		
             	    -- INTIAL VALUES
             	     vd_efc_service_st_dt = NULL;--
             	     vd_efc_service_end_dt = NULL;--
             	     vl_efc_unit_no = NULL;--
             	     vs_efc_unit_type = NULL;--
             	     vd_rfc_service_st_dt = NULL;--
             	     vd_rfc_service_end_dt = NULL;--
             	     vl_rfc_unit_no = NULL;--
             	     vs_rfc_unit_type = NULL;--
             	
             	     vl_efc_calc_days = 60;--

             	     
             	
             	    SELECT  a.ad_efc_service_st_dt ,
			    a.ad_efc_service_end_dt ,
			    a.al_efc_unit_no ,
			    a.as_efc_unit_type  ,
			    a.ad_rfc_service_st_dt ,
			    a.ad_rfc_service_end_dt,
			    a.al_rfc_unit_no ,
			    a.as_rfc_unit_type FROM F_SP_EFC_DAYS_CALCULATION( 'R',
							  vl_placement_structure_id,
							  vd_current_placement_start_dt,
							  vd_current_placement_end_dt,
							  vd_previous_month_start_dt,
							  vd_previous_month_end_dt,
							  vl_efc_calc_days
							  
							  ) a INTO vd_efc_service_st_dt,vd_efc_service_end_dt,
							  vl_efc_unit_no,
							  vs_efc_unit_type,
							  vd_rfc_service_st_dt,
							  vd_rfc_service_end_dt,
							  vl_rfc_unit_no,
							  vs_rfc_unit_type;--
				ELSE	
					-- CIS-18884
					IF vl_placement_structure_id = 10 THEN -- Regular Foster Care
						-- New SP for Service days calculation based on Provider Location Address county
						-- Returns payment days for 'Room & Board/Clothing' and/or 'Room & Board/Clothing/Differential'
						-- INTIAL VALUES
						 vd_csrfc_service_st_dt = NULL;--
						 vd_csrfc_service_end_dt = NULL;--
						 vl_csrfc_unit_no = NULL;--
						 vs_csrfc_unit_type = NULL;--

						 vd_csrfcd_service_st_dt = NULL;--
						 vd_csrfcd_service_end_dt = NULL;--
						 vl_csrfcd_unit_no = NULL;--
						 vs_csrfcd_unit_type = NULL;--
						 al_sqlcode = 0;--
						 as_error = NULL;--

						SELECT a.ad_rfc_service_st_dt,
								a.ad_rfc_service_end_dt,
								a.al_rfc_unit_no,
								a.as_rfc_unit_type,
								a.ad_rfcd_service_st_dt,
								a.ad_rfcd_service_end_dt,
								a.al_rfcd_unit_no,
								a.as_rfcd_unit_type,
								a.al_sqlcode,
								a.as_error  FROM SP_CSRB_DAYS_CALCULATION( 'R',
															vl_provider_id, 	
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a into vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vl_csrfc_unit_no,
															vs_csrfc_unit_type,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vl_csrfcd_unit_no,
															vs_csrfcd_unit_type,
															al_sqlcode,
															as_error;
		             	
						
		             	
					ELSE
						-- Checking what is the service start and end date for this placement
						SELECT   ad_service_start_dt ,
						         ad_service_end_dt,
							 al_unit_no ,
							 as_unit_type   from  
					        SP_FOSTERCARE_CALCULATION('L',
                                                   'R',
                                                   vl_placement_structure_id,
                                                   vd_current_placement_start_dt,
                                                   vd_current_placement_end_dt,
                                                   vd_previous_month_start_dt,
                                                   vd_previous_month_end_dt) into 
                                                   vd_current_service_start_dt,
                                                   vd_current_service_end_dt,
                                                   vl_unit_no,
                                                   vs_unit_type;--
					END IF;--
				END IF;--
		

				IF vl_placement_structure_id <> 13 THEN -- CIS-17815
					-- ********** ROOM AND BOARD START ******** -------------------
					-- CIS-18884
					 vs_DRAFT_CHANGED = 'N' ; -- INITIAL VALUE
		
					IF vl_placement_structure_id <> 10 THEN -- Regular Foster Care
						
						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - START
						
						-- Calculating the rate
						-- Find out the age of the child
						 vl_age_of_child = 0; -- INITIAL VALUE
						IF cur_placement_detail_record.AGE_NO IS NULL  THEN
							 vl_age_of_child = cur_placement_detail_record.APPROXIMATE_AGE_NO;--
						ELSE
							 vl_age_of_child = cur_placement_detail_record.AGE_NO;--
						END IF;--

						-- get the rate for room and board
						 vs_rate_type_cd = 'R';--
						 vs_draft_final_type = 'F';--
						 vdc_monthly_rate = 0.00; -- INITIAL VALUE
						 vdc_perdiem_rate = 0.00; -- INITIAL VALUE

												
						SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error  from SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

						IF al_sqlcode <> 0 THEN
							 as_error = as_error || ' (SP-2)' ;--
							IF as_error is NULL OR as_error = '' THEN
								 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-2)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--

						IF vl_unit_no = 1 and vs_unit_type = '5611' THEN  -- monthly rate
						    vdc_gross_amount = vdc_monthly_rate;--
						    vdc_perdiem_rate = vdc_monthly_rate; -- incident 5265
						ELSE
						    vs_unit_type = '5610'; -- nightly rate
						    vdc_gross_amount = vdc_perdiem_rate * vl_unit_no;--
						    vdc_perdiem_rate = vdc_perdiem_rate;--
						END IF;--

						-- insert or updating record in payment detail
						-- New condition for Room & Board Rate Type cd - CIS-19002 	
						-- New condition check for placement structure id - PRJ-04753
						IF vs_rate_type_cd = 'R' THEN
							IF vd_current_service_end_dt <= DATE('2009-08-31') 
								AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409) THEN
									 vs_rate_type_cd = '1232'; -- Room & Board
							ELSE
									 vs_rate_type_cd = '5670'; -- Room & Board/Clothing
							END IF;--
						END IF;--

					SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_current_service_start_dt,
										vd_current_service_end_dt,
										vdc_gross_amount,
										vl_unit_no,
										vs_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;--

						IF al_sqlcode <> 0 THEN
							 as_error = as_error || ' (SP-3)' ;--
							IF as_error is NULL OR as_error = '' THEN
								 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-3)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - END
						
						-- Existing Code
						-- CHECKING IF ROOM AND BOARD PAYMENT_DRAFT_EXIST FOR THE PREVIOUS MONTH
						 vd_draft_service_start_dt = NULL;   -- INITIAL VALUE
						 vd_draft_service_end_dt = NULL;   -- INITIAL VALUE
						 vl_draft_service_id = NULL;   -- INITIAL VALUE
		
						SELECT DRAFT_SERVICE_START_DT, DRAFT_SERVICE_END_DT, DRAFT_SERVICE_ID
		            	     INTO vd_draft_service_start_dt, vd_draft_service_end_dt, vl_draft_service_id
						FROM TB_PAYMENT_DETAIL
		                  WHERE PAYMENT_ID = vl_pay_header_id 
								AND DELETE_SW = 'N' 
								AND PLACEMENT_ID = vl_placement_id 
								AND DRAFT_RATE_TYPE_CD in ('1232', '5670') ;--

						-- NOTHING CHANGED FROM DRAFT AND FINAL RUN UPDATE THE FINAL WITH DRAFT
						-- New condition Placement structure Ids 11 or 12 -- CIS-19002
						IF vd_draft_service_start_dt = vd_current_service_start_dt
							AND vd_draft_service_end_dt = vd_current_service_end_dt
							AND vl_draft_service_id = vl_placement_structure_id
							AND vl_placement_structure_id <> 11
							AND vl_placement_structure_id <> 12 THEN  -- NOTHING CHANGED
				
							-- PRJ-03018 - Removed Update TB_PAYMENT_DETAIL statement from here.

						ELSE  -- NO DRAFT EXIST OR DRAFT HAVE BEEN CHANGED AND PLACEMENT IS VALIDATED NEEDS TO RECALCULATE FINAL PAYMENT
							 vs_DRAFT_CHANGED = 'Y'; -- CIS-18884
							 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE							
							
							-- PRJ-03018- payment re-calculation code was moved out of IF....ELSE...END IF  from here
			
							-- New condition for Placement Structure 11 and 12 -- CIS-19002
							IF vl_placement_structure_id = 11 OR vl_placement_structure_id = 12 THEN
								IF vd_draft_service_start_dt = vd_current_service_start_dt
									AND vd_draft_service_end_dt = vd_current_service_end_dt
									AND vl_draft_service_id = vl_placement_structure_id THEN
			       	
									-- NOTHING CHANGE SINCE DRAFT
									-- DO NOTHING
			       	
								ELSE
									UPDATE TB_PAYMENT_DETAIL
									SET	 CHANGE_REASON_CD = '3035'
									WHERE PAYMENT_ID = vl_pay_header_id
										  AND PLACEMENT_ID = vl_placement_id;--
			   	
									 al_sqlcode = SQLCODE;--
									IF al_sqlcode <> 0 THEN
										 as_error = 'Error in Updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-2A)'  ;--
										 vs_identity_column = 'Placement ID';--
										 vs_identity_val = (vl_placement_id)::character varying;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF; 	--
							ELSE
								UPDATE TB_PAYMENT_DETAIL
								SET	 CHANGE_REASON_CD = '3035'
								WHERE PAYMENT_ID = vl_pay_header_id
									AND PLACEMENT_ID = vl_placement_id;--
			
								 al_sqlcode = SQLCODE;--
								IF al_sqlcode <> 0 THEN
									 as_error = 'Error in Updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-2)'  ;--
									 vs_identity_column = 'Placement ID';--
									 vs_identity_val =  (vl_placement_id)::character varying;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
							-- commented bcz of placement view
						   -- UPDATE TB_PLACEMENT  
							--SET	 PAYMENT_HEADER_ID = vl_pay_header_id
							--WHERE (PLACEMENT_ID = cur_placement_detail_record.PLACEMENT_ID);--
							
							UPDATE placement
							SET paymentheaderid = vl_pay_header_id					
							WHERE (alternateid = cur_placement_detail_record.PLACEMENT_ID);--
							
							 al_sqlcode = SQLCODE;--
							IF al_sqlcode <> 0 THEN
								 as_error = 'Error in Updating TB_PLACEMENT. (SQL-3)'  ;--
								 vs_identity_column = 'Placement ID';--
								 vs_identity_val =  (vl_placement_id)::character varying;----
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF; -- DRAFT HAVE BEEN CHANGED	
					ELSE -- 10 (Regular Foster Care)
						-- New Code
						 vs_CSRFC_no_change = 'N'; -- INITIAL VALUE
						 vs_CSRFCD_no_change = 'N'; -- INITIAL VALUE

						 vd_csrfc_draft_st_dt = NULL;   -- INITIAL VALUE
						 vd_csrfc_draft_ed_dt = NULL;   -- INITIAL VALUE
		
						SELECT DRAFT_SERVICE_START_DT, DRAFT_SERVICE_END_DT
							INTO vd_csrfc_draft_st_dt, vd_csrfc_draft_ed_dt
						FROM TB_PAYMENT_DETAIL
						WHERE PAYMENT_ID = vl_pay_header_id
							AND DELETE_SW = 'N'
							AND PLACEMENT_ID = vl_placement_id
							AND DRAFT_RATE_TYPE_CD = '5670' ; -- Room & Board/Clothing

						IF (( vd_csrfc_draft_st_dt = vd_csrfc_service_st_dt )
								OR (vd_csrfc_draft_st_dt is NULL AND vd_csrfc_service_st_dt is NULL))
								AND (( vd_csrfc_draft_ed_dt = vd_csrfc_service_end_dt )
								OR (vd_csrfc_draft_ed_dt is NULL AND vd_csrfc_service_end_dt is NULL)) THEN
		   		
							 vs_CSRFC_no_change = 'Y';	--
						END IF;		--
		

						 vd_csrfcd_draft_st_dt = NULL;   -- INITIAL VALUE
						 vd_csrfcd_draft_ed_dt = NULL;   -- INITIAL VALUE
		
						-- New condition to Check RFC draft payment  - CIS-19002	
						SELECT DRAFT_SERVICE_START_DT, DRAFT_SERVICE_END_DT
							INTO vd_csrfcd_draft_st_dt, vd_csrfcd_draft_ed_dt
						FROM TB_PAYMENT_DETAIL
						WHERE PAYMENT_ID = vl_pay_header_id
							AND DELETE_SW = 'N'
							AND PLACEMENT_ID = vl_placement_id
							AND DRAFT_RATE_TYPE_CD = '5671'; -- Room & Board/Clothing/Differential			
		
			
						IF (( vd_csrfcd_draft_st_dt = vd_csrfcd_service_st_dt )
								OR (vd_csrfcd_draft_st_dt is NULL AND vd_csrfcd_service_st_dt is NULL))
								AND (( vd_csrfcd_draft_ed_dt = vd_csrfcd_service_end_dt )
								OR (vd_csrfcd_draft_ed_dt is NULL AND vd_csrfcd_service_end_dt is NULL)) THEN
				
							 vs_CSRFCD_no_change = 'Y';	--
						END IF;	--
		
						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - START
						
						-- Find out the age of the child
						 vl_age_of_child = 0; -- INITIAL VALUE
						IF cur_placement_detail_record.AGE_NO IS NULL  THEN
							 vl_age_of_child = cur_placement_detail_record.APPROXIMATE_AGE_NO;--
						ELSE
							 vl_age_of_child = cur_placement_detail_record.AGE_NO;--
						END IF;--

						 vs_draft_final_type = 'F';--
			
						-- RFC - Room & Board/Clothing - START
						IF vl_csrfc_unit_no is NOT NULL AND vl_csrfc_unit_no > 0 THEN
							 vs_rate_type_cd = 'R'; -- INITIAL VALUE
							 vdc_monthly_rate = 0.00; -- INITIAL VALUE
							 vdc_perdiem_rate = 0.00; -- INITIAL VALUE

								SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error  from SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															--vd_current_service_start_dt,
															--vd_current_service_end_dt,
															vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

							
							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-3AA)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-3AA)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vl_csrfc_unit_no = 1 and vs_csrfc_unit_type = '5611' THEN  -- monthly rate
								 vdc_gross_amount = vdc_monthly_rate;--
								 vdc_monthly_rate = vdc_monthly_rate;--
							ELSE
								 vs_csrfc_unit_type = '5610';  -- nightly rate
								 vdc_gross_amount = vdc_perdiem_rate * vl_csrfc_unit_no;--
								 vdc_perdiem_rate = vdc_perdiem_rate;--
							END IF;--

							-- insert or updating record in payment detail
							-- New condition check for placement structure id - PRJ-04753
							IF vs_rate_type_cd = 'R' THEN
								IF vd_csrfc_service_end_dt <= DATE('2009-08-31') 
									AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409 ) THEN
									 vs_rate_type_cd = '1232'; -- Room & Board
								ELSE
									 vs_rate_type_cd = '5670'; -- Room & Board/Clothing
								END IF;--
							END IF;--

						SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_csrfc_service_st_dt,
										vd_csrfc_service_end_dt,
										vdc_gross_amount,
										vl_csrfc_unit_no,
										vs_csrfc_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-3AB)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-3AB)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;		--
						END IF;	--
						-- RFC - Room & Board/Clothing - END
		
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential - START
						IF vl_csrfcd_unit_no is NOT NULL AND vl_csrfcd_unit_no > 0 THEN
							 vs_rate_type_cd = 'D'; -- INITIAL VALUE
							 vdc_monthly_rate = 0.00; -- INITIAL VALUE
							 vdc_perdiem_rate = 0.00; -- INITIAL VALUE
							 
						SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error from SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-3AC)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-3AC)';--
								END IF;--
								-- SIGNAL p_sp_error;--
							END IF;--

							IF vl_csrfcd_unit_no = 1 and vs_csrfcd_unit_type = '5611' THEN  -- monthly rate
								 vdc_gross_amount = vdc_monthly_rate;--
								 vdc_monthly_rate = vdc_monthly_rate;--
							ELSE
								 vs_csrfc_unit_type = '5610';  -- nightly rate
								 vdc_gross_amount = vdc_perdiem_rate * vl_csrfcd_unit_no;--
								 vdc_perdiem_rate = vdc_perdiem_rate;--
							END IF;--

							-- insert or updating record in payment detail
							IF vs_rate_type_cd = 'D' THEN
								 vs_rate_type_cd = '5671'; -- Room & Board/Clothing/Differential
							END IF;--

							SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_csrfcd_service_st_dt,
										vd_csrfcd_service_end_dt,
										vdc_gross_amount,
										vl_csrfcd_unit_no,
										vs_csrfcd_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a INTO 
										al_sqlcode,
										as_error ;-- 

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-3AD)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-3AD)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;		--
						END IF;--
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential - END			
						
						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - END
		
						IF vs_CSRFC_no_change = 'Y' AND vs_CSRFCD_no_change = 'Y' THEN  -- NOTHING CHANGED
							-- PRJ-03018 - Removed Update TB_PAYMENT_DETAIL statement from here.
						ELSE
							-- Re-calculate Final Payment Amounts
							 vs_DRAFT_CHANGED = 'Y' ;--
							
							-- PRJ-03018- payment re-calculation code was moved out of IF....ELSE...END IF  from here
							 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE
		     			
							UPDATE TB_PAYMENT_DETAIL
							SET	 CHANGE_REASON_CD = '3035'
							WHERE PAYMENT_ID = vl_pay_header_id
								AND PLACEMENT_ID = vl_placement_id;--

							 al_sqlcode = SQLCODE;--
							IF al_sqlcode <> 0 THEN
								 as_error = 'Error in Updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-2AA)'  ;--
								 vs_identity_column = 'Placement ID';--
								 vs_identity_val =  (vl_placement_id)::character varying;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
		    		     			
							--commented bcz of placement view
							--UPDATE TB_PLACEMENT 
							--SET	 PAYMENT_HEADER_ID = vl_pay_header_id
							--WHERE (PLACEMENT_ID = cur_placement_detail_record.PLACEMENT_ID);--
							
							UPDATE placement
							SET paymentheaderid = vl_pay_header_id					
							WHERE (alternateid = cur_placement_detail_record.PLACEMENT_ID);--
							
							 al_sqlcode = SQLCODE;--
							IF al_sqlcode <> 0 THEN
								 as_error = 'Error in Updating TB_PLACEMENT. (SQL-3AA)'  ;--
								 vs_identity_column = 'Placement ID';--
								 vs_identity_val =  (vl_placement_id)::character varying;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF;--
					END IF;--
					-- ********** ROOM AND BOARD END ******** -------------------
					-- PRJ-03018- Change in follwoing re-calculate condition; only for Clothing
					-- Stipend always re-calculate.
					
					-- New Condition to re-calculate Clothing - START
					IF vs_DRAFT_CHANGED = 'Y' THEN 
						-- ********** clothing information START ******** -------------------
						-- New condition for monthly clothing allowance - CIS-19002 - START
						IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
							 vs_initial_clothing_flag = 'T';--
							 vd_current_service_start_dt = vd_previous_month_start_dt;--
							 vd_current_service_end_dt = vd_previous_month_end_dt;--
							--CHECK WHETHER TO PAY INITIAL CLOTHING OR MONTHLY CLOTHING ALLOWANCE
							-- check if this is first placement for initial clothing allowance
							 vl_payment_count = 0;--

							SELECT COUNT(*)
								INTO vl_payment_count
							FROM TB_PLACEMENT
							WHERE CLIENT_ID = cur_placement_detail_record.CLIENT_ID 
								AND DELETE_SW = 'N' 
								AND ENTRY_DT IS NOT NULL 
								AND PLACEMENT_ID <> cur_placement_detail_record.PLACEMENT_ID 
								AND ((VOID_SW IS NULL) OR (VOID_SW = 'N')) 
								AND APPROVAL_STATUS_CD = '3047'
								AND CONVERSION_SW IS NULL ;--

							IF vl_payment_count IS NULL THEN
								 vl_payment_count = 0;--
							END IF;--

							IF cur_placement_detail_record.ENTRY_DT < vd_previous_month_start_dt THEN
								 vs_initial_clothing_flag = 'F'; -- failed
							END IF;--

							-- PAY MONTHLY CLOTHING ALLOWANCE
							IF vl_unit_no = 1 AND vs_unit_type = '5611' THEN
								 vdc_monthly_clothing_rate = 0.00; -- initial value
								 vdc_perdiem_rate = 0.00; -- initial value
								 vs_rate_type_cd = 'C';    -- MONTHLY clothing allowance
								 vs_draft_final_type = 'F';--

								SELECT a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error from SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
																	vl_age_of_child,
																	vd_current_service_start_dt,
																	vd_current_service_end_dt,
																	vs_rate_type_cd) a into
																	vdc_monthly_rate,
																	vdc_perdiem_rate, 
																	al_sqlcode, 
																	as_error;--

								IF al_sqlcode <> 0 THEN
									 as_error = as_error || ' (SP-6)' ;--
									IF as_error is NULL OR as_error = '' THEN
										 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-6)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--

								 vdc_perdiem_rate = vdc_monthly_rate;--
								 vdc_gross_amount = vdc_monthly_rate;--
								IF vs_rate_type_cd = 'C' THEN
									 vs_rate_type_cd = '1233';--
								END IF;--

									SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_current_service_start_dt,
										vd_current_service_end_dt,
										vdc_gross_amount,
										vl_unit_no,
										vs_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

								IF al_sqlcode <> 0 THEN
									 as_error = as_error || ' (SP-7)' ;--
									IF as_error is NULL OR as_error = '' THEN
										 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-7)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--

								-- New condition for Placement Structure 11 and 12 -- CIS-19002
								IF vl_placement_structure_id = 11 OR vl_placement_structure_id = 12 THEN
									IF vd_draft_service_start_dt = vd_current_service_start_dt
										AND vd_draft_service_end_dt = vd_current_service_end_dt
										AND vl_draft_service_id = vl_placement_structure_id THEN

										-- NOTHING CHANGE SINCE DRAFT
										-- DO NOTHING
		
									ELSE
										UPDATE TB_PAYMENT_DETAIL
										SET	 CHANGE_REASON_CD = '3035'
										WHERE PAYMENT_ID = vl_pay_header_id
											AND PLACEMENT_ID = vl_placement_id;--

										 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE

										 al_sqlcode = SQLCODE;--
										IF al_sqlcode <> 0 THEN
											 as_error = 'Error in updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-4A)'  ;--
											 vs_identity_column = 'Placement ID';--
											 vs_identity_val =  (vl_placement_id)::character varying;--
											-- SIGNAL p_sp_error  ;--
										END IF ;--
									END IF;--
								ELSE
									UPDATE TB_PAYMENT_DETAIL
									SET	 CHANGE_REASON_CD = '3035'
									WHERE PAYMENT_ID = vl_pay_header_id
									AND PLACEMENT_ID = vl_placement_id;--

									 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE

									 al_sqlcode = SQLCODE;--
									IF al_sqlcode <> 0 THEN
										 as_error = 'Error in updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-4)'  ;--
										 vs_identity_column = 'Placement ID';--
										 vs_identity_val = (vl_placement_id)::character varying;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--

							END IF;--
						END IF;--
						-- New condition for monthly clothing allowance - CIS-19002 - END
						-- ********** clothing information END ******** -------------------
					END IF;--
					-- New Condition to re-calculate Clothing - END
					
					-- PRJ-03018 - Stipend always re-calculate. - START
					-- ********** Stipend information START ******** -------------------
					-- check difficulity of care FOR IFC or TFC
					-- if approved record exist then create payment detail record for that
					-- New condition to pay Stipend  - CIS-19002	
					IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
						 vd_current_service_start_dt = vd_previous_month_start_dt;--
						 vd_current_service_end_dt = vd_previous_month_end_dt;--
					END IF;--

					-- New condition to pay Stipend  - CIS-19002	
					IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
						 vs_unit_type = '5611' ;  -- monthly for stipend
						 vl_unit_no = 1; -- monthly for stipend
					ELSE
						 vs_unit_type = '5610' ;  -- Nightly for stipend
						-- No need  vl_unit_no pay as per placement dates -- Nightly for stipend
						-- SP_STIPEND_CALCULATION have logic to calculate Unit No for payments from Feb 2010 onwards.
					END IF;--

					 vl_doc_count = 0; -- INITIAL VALUE

					SELECT COUNT(*)
						INTO vl_doc_count
					FROM TB_PAYMENT_DETAIL
					WHERE FINAL_RATE_TYPE_CD = '1234' 
						AND DELETE_SW = 'N' 
						AND FINAL_SERVICE_START_DT = vd_current_service_start_dt 
						AND FINAL_SERVICE_END_DT = vd_current_service_end_dt    
						AND CLIENT_ID = cur_placement_detail_record.CLIENT_ID;--

					IF vl_doc_count = 0 OR vl_doc_count IS NULL THEN -- difficulty of care record exist
						-- check the approved record in placement
						IF vl_placement_structure_id = 11 OR vl_placement_structure_id = 12 THEN --  ONLY FOR TFC OR IFC
							 vdc_stipend_amount_no = 0.00;--
							 vl_doc_level_id = NULL;--

							-- New Logic for Stipend Calculation 12/07/2009	
							-- INTIAL VALUES
							 vdc_stipend_amount_no = NULL;--
							 vd_stipend_service_start_dt = NULL;--
							 vd_stipend_service_end_dt = NULL;--
							 vl_stipend_unit_no = NULL;--
							 vs_stipend_unit_type = NULL;--

							   SELECT    a.al_doc_level_id ,
								     a.adc_stipend_amount_no ,
								     a.ad_service_start_dt ,
								     a.ad_service_end_dt ,
								     a.al_unit_no ,
								     a.as_unit_type  ,
								     a.al_sqlcode ,
								     a.as_error   from  SP_STIPEND_CALCULATION(cur_placement_detail_record.PLACEMENT_ID,
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a into 
															vl_doc_level_id,
															vdc_stipend_amount_no,
															vd_stipend_service_start_dt,
															vd_stipend_service_end_dt,
															vl_stipend_unit_no,
															vs_stipend_unit_type,
															al_sqlcode,
															as_error;--
							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-7A)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_STIPEND_CALCULATION failed. (SP-7A)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vdc_stipend_amount_no IS NULL OR vdc_stipend_amount_no = 0.00 THEN
								IF  vl_doc_level_id IS NULL OR vl_doc_level_id = 0 THEN
									-- no need to create record
								ELSE -- check the rate in the rate table
									 vdc_perdiem_rate = 0.00;--
									 vdc_monthly_rate = 0.00;--
									 vs_rate_type_cd = 'S';--
									 vs_draft_final_type = 'F';--

								SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error from SP_GET_PLACEMENT_RATE (vl_doc_level_id,
															vl_age_of_child,
															vd_stipend_service_start_dt,
															vd_stipend_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

									IF al_sqlcode <> 0 THEN
										 as_error = as_error || ' (SP-8)' ;--
										IF as_error is NULL OR as_error = '' THEN
											 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-8)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--

									IF vs_rate_type_cd = 'S' THEN
										 vs_rate_type_cd = '1234';--
									END IF;--

									-- New condition for Stipend allowance - CIS-19002 - START
									IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
										 vdc_gross_amount = vdc_monthly_rate;--
										 vdc_perdiem_rate = vdc_monthly_rate;--
									ELSE
										--  vdc_gross_amount = vdc_perdiem_rate * vl_unit_no;--
										 vdc_gross_amount = vdc_perdiem_rate * vl_stipend_unit_no;--
										 vdc_perdiem_rate = COALESCE(vdc_perdiem_rate,0);--
									END IF;--

									SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_stipend_service_start_dt,
										vd_stipend_service_end_dt,
										vdc_gross_amount,
										vl_stipend_unit_no,
										vs_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

									IF al_sqlcode <> 0 THEN
										 as_error = as_error || ' (SP-9)' ;--
										IF as_error is NULL OR as_error = '' THEN
											 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-9)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--

									-- New condition for Placement Structure 11 and 12 -- CIS-19002
									IF vd_draft_service_start_dt = vd_current_service_start_dt
										AND vd_draft_service_end_dt = vd_current_service_end_dt
										AND vl_draft_service_id = vl_placement_structure_id THEN

										-- NOTHING CHANGE SINCE DRAFT
										-- DO NOTHING
									ELSE	

										UPDATE TB_PAYMENT_DETAIL
										SET	 CHANGE_REASON_CD = '3035'
										WHERE PAYMENT_ID = vl_pay_header_id
											AND PLACEMENT_ID = vl_placement_id;--

										 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE

										 al_sqlcode = SQLCODE;--
										IF al_sqlcode <> 0 THEN
											 as_error = 'Error in updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-5)'  ;--
											 vs_identity_column = 'Placement ID';--
											 vs_identity_val =  (vl_placement_id)::character varying;--
											-- SIGNAL p_sp_error  ;--
										END IF ;--
									END IF;--
								END IF;--
							ELSE
								-- This case is NOT possible as Amount field on Stipend screen is Permanently disabled. Ref: Incident#5704
								 vdc_monthly_rate = vdc_stipend_amount_no;--
								 vs_rate_type_cd = '1234';--
								 vs_draft_final_type = 'F';--
								 vdc_gross_amount = vdc_monthly_rate;--
								-- New condition for Stipend allowance - CIS-19002 - START
								IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
									 vdc_perdiem_rate = vdc_monthly_rate;--
								END IF;--

								SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_current_service_start_dt,
										vd_current_service_end_dt,
										vdc_gross_amount,
										vl_unit_no,
										vs_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

								IF al_sqlcode <> 0 THEN
									 as_error = as_error || ' (SP-10)' ;--
									IF as_error is NULL OR as_error = '' THEN
										 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-10)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--

								-- New condition for Placement Structure 11 and 12 -- CIS-19002
								IF vd_draft_service_start_dt = vd_current_service_start_dt
									AND vd_draft_service_end_dt = vd_current_service_end_dt
									AND vl_draft_service_id = vl_placement_structure_id THEN

									-- NOTHING CHANGE SINCE DRAFT
									-- DO NOTHING
								ELSE		
									UPDATE TB_PAYMENT_DETAIL
										SET CHANGE_REASON_CD = '3035'
									WHERE PAYMENT_ID = vl_pay_header_id
										AND PLACEMENT_ID = vl_placement_id;--

									 al_sqlcode = SQLCODE;--
									IF al_sqlcode <> 0 THEN
										 as_error = 'Error in updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-6)'  ;--
										 vs_identity_column = 'Placement ID';--
										 vs_identity_val =  (vl_placement_id)::character varying;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
									 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE
								END IF;--
							END IF;--
						END IF;  -- TFC & IFC CHCEK
					END IF;--
					-- ********** Stipend information END ******** -------------------
--					END IF; -- New Condition to re-calculate Clothing / Stipend  - END
					-- PRJ-03018 - Stipend always re-calculate. - END

				ELSE -- Case vl_placement_structure_id = 13 (Emergency Foster Home Care)
		
					-- ********** ROOM AND BOARD START ******** -------------------
					-- CHECKING IF ROOM AND BOARD PAYMENT_DRAFT_EXIST FOR THE PREVIOUS MONTH
					-- INITIAL VALUES
					 vs_EFC_no_change = 'N';--
					 vs_RFC_no_change = 'N';--
					 vs_CSRFC_no_change = 'N';--

					 vd_efc_draft_service_start_dt = NULL;   -- INITIAL VALUE
					 vd_efc_draft_service_end_dt = NULL;   -- INITIAL VALUE

					SELECT DRAFT_SERVICE_START_DT, DRAFT_SERVICE_END_DT
						INTO  vd_efc_draft_service_start_dt, vd_efc_draft_service_end_dt
					FROM  TB_PAYMENT_DETAIL
					WHERE PAYMENT_ID = vl_pay_header_id
							AND DELETE_SW = 'N'
							AND PLACEMENT_ID = vl_placement_id
							AND DRAFT_RATE_TYPE_CD = '1232'
							AND DRAFT_SERVICE_ID = 13 ;	--

					IF (( vd_efc_draft_service_start_dt = vd_efc_service_st_dt )
						OR (vd_efc_draft_service_start_dt is NULL AND vd_efc_service_st_dt is NULL))
						AND (( vd_efc_draft_service_end_dt = vd_efc_service_end_dt )
						OR (vd_efc_draft_service_end_dt is NULL AND vd_efc_service_end_dt is NULL)) THEN

						 vs_EFC_no_change = 'Y';	--
					END IF;		--
		

					 vd_rfc_draft_service_start_dt = NULL;   -- INITIAL VALUE
					 vd_rfc_draft_service_end_dt = NULL;   -- INITIAL VALUE

					-- New condition to Check RFC draft payment  - CIS-19002	
					SELECT DRAFT_SERVICE_START_DT, DRAFT_SERVICE_END_DT
						INTO  vd_rfc_draft_service_start_dt, vd_rfc_draft_service_end_dt
					FROM  TB_PAYMENT_DETAIL
					WHERE PAYMENT_ID = vl_pay_header_id
						AND DELETE_SW = 'N'
						AND PLACEMENT_ID = vl_placement_id
						AND ( DRAFT_RATE_TYPE_CD = '1232' OR DRAFT_RATE_TYPE_CD = '5670' )
						AND DRAFT_SERVICE_ID = 10 ;			--
		
			
					IF (( vd_rfc_draft_service_start_dt = vd_rfc_service_st_dt )
						OR (vd_rfc_draft_service_start_dt is NULL AND vd_rfc_service_st_dt is NULL))
						AND (( vd_rfc_draft_service_end_dt = vd_rfc_service_end_dt )
						OR (vd_rfc_draft_service_end_dt is NULL AND vd_rfc_service_end_dt is NULL)) THEN

						 vs_RFC_no_change = 'Y';	--
					END IF;		--
		
					-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - START
					
					-- Find out the age of the child
					 vl_age_of_child = 0; -- INITIAL VALUE
					IF cur_placement_detail_record.AGE_NO IS NULL  THEN
						 vl_age_of_child = cur_placement_detail_record.APPROXIMATE_AGE_NO;--
					ELSE
						 vl_age_of_child = cur_placement_detail_record.AGE_NO;--
					END IF;--
					
					 vs_draft_final_type = 'F';--
		
					--EFC
					IF vl_efc_unit_no is NOT NULL AND vl_efc_unit_no > 0 THEN
						 vs_rate_type_cd = 'R'; -- INITIAL VALUE
						 vdc_monthly_rate = 0.00; -- INITIAL VALUE
						 vdc_perdiem_rate = 0.00; -- INITIAL VALUE
			
						SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error from SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_efc_service_st_dt,
															vd_efc_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

						IF al_sqlcode <> 0 THEN
							 as_error = as_error || ' (SP-10A)' ;--
							IF as_error is NULL OR as_error = '' THEN
								 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-10A)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--

						IF vl_efc_unit_no = 1 and vs_efc_unit_type = '5611' THEN  -- monthly rate
							IF vd_efc_service_end_dt = vd_previous_month_end_dt and (vd_efc_service_end_dt <> vd_current_placement_end_dt or vd_current_placement_end_dt is null) THEN
								SELECT DAY(F_daymonth(CURRENT_DATE ,'L', 'P' )) - 1
									INTO vl_no_of_days;
								--FROM sysibm.sysdummy1;--
						
								 vdc_gross_amount = vdc_perdiem_rate * (vl_no_of_days + 1);--
								 vdc_monthly_rate = COALESCE(vdc_gross_amount,0);--
							ELSE
								 vdc_gross_amount = vdc_monthly_rate;--
								 vdc_monthly_rate = vdc_monthly_rate;--
							END IF;--
						ELSE
							 vs_efc_unit_type = '5610';  -- nightly rate
							 vdc_gross_amount = vdc_perdiem_rate * vl_efc_unit_no;--
							 vdc_perdiem_rate = vdc_perdiem_rate;--
						END IF;--

						-- insert or updating record in payment detail
						IF vs_rate_type_cd = 'R' THEN
							 vs_rate_type_cd = '1232';--
						END IF;--

							SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_placement_structure_id,
										vd_efc_service_st_dt,
										vd_efc_service_end_dt,
										vdc_gross_amount,
										vl_efc_unit_no,
										vs_efc_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

						IF al_sqlcode <> 0 THEN
							 as_error = as_error || ' (SP-10B)' ;--
							IF as_error is NULL OR as_error = '' THEN
								 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-10B)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
					END IF;	--
					-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - END
				
					-- Logic modified for EFC only and created separate section for RFC - CIS18884
					IF vs_EFC_no_change = 'Y' AND vs_RFC_no_change = 'Y' THEN  -- NOTHING CHANGED
					
						-- PRJ-03018 - Removed Update TB_PAYMENT_DETAIL statement from here.

					ELSE  -- NO DRAFT EXIST OR DRAFT HAVE BEEN CHANGED AND PLACEMENT IS VALIDATED NEEDS TO RECALCULATE FINAL PAYMENT	
						-- ********** ROOM AND BOARD END ******** -------------------

						-- PRJ-03018- payment re-calculation code was moved out of IF....ELSE...END IF  from here
						
					END IF;--
		
					-- New Section For RFC under Emergency Foster Home Care
					-- 10 ( Regular Foster Care )
					IF vl_rfc_unit_no is NOT NULL AND vl_rfc_unit_no > 0 THEN
						-- INTIAL VALUES
						 vd_csrfc_service_st_dt = NULL;--
						 vd_csrfc_service_end_dt = NULL;--
						 vl_csrfc_unit_no = NULL;--
						 vs_csrfc_unit_type = NULL;--

						 vd_csrfcd_service_st_dt = NULL;--
						 vd_csrfcd_service_end_dt = NULL;--
						 vl_csrfcd_unit_no = NULL;--
						 vs_csrfcd_unit_type = NULL;--
						 al_sqlcode = 0;--
						 as_error = NULL;--
		             	SELECT a.ad_rfc_service_st_dt,
								a.ad_rfc_service_end_dt,
								a.al_rfc_unit_no,
								a.as_rfc_unit_type,
								a.ad_rfcd_service_st_dt,
								a.ad_rfcd_service_end_dt,
								a.al_rfcd_unit_no,
								a.as_rfcd_unit_type,
								a.al_sqlcode,
								a.as_error  FROM SP_CSRB_DAYS_CALCULATION( 'R',
															vl_provider_id, 	
															vl_plc_structure_rfc_id,
															vd_rfc_service_st_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a into vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vl_csrfc_unit_no,
															vs_csrfc_unit_type,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vl_csrfcd_unit_no,
															vs_csrfcd_unit_type,
															al_sqlcode,
															as_error;	--
		
		
		
						-- INITIAL VALUE
						 vl_check_csrfc_unit_no = NULL;--
		
						SELECT DRAFT_UNITS_NO
							INTO vl_check_csrfc_unit_no
						FROM  TB_PAYMENT_DETAIL
						WHERE PAYMENT_ID = vl_pay_header_id
							AND DELETE_SW = 'N'
							AND PLACEMENT_ID = vl_placement_id
							AND ( DRAFT_RATE_TYPE_CD = '1232' OR DRAFT_RATE_TYPE_CD = '5670' )
							AND DRAFT_SERVICE_ID = 10 ;			--

						-- INITIAL VALUE	
						 vl_check_csrfcd_unit_no = NULL;--
		
						SELECT DRAFT_UNITS_NO
							INTO vl_check_csrfcd_unit_no
						FROM  TB_PAYMENT_DETAIL
						WHERE PAYMENT_ID = vl_pay_header_id
							AND DELETE_SW = 'N'
							AND PLACEMENT_ID = vl_placement_id
							AND DRAFT_RATE_TYPE_CD = '5671'
							AND DRAFT_SERVICE_ID = 10 ;			--
		

						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - START
					
						 vd_rfc_service_st_dt = vd_csrfc_service_st_dt;--
						 vd_rfc_service_end_dt = vd_csrfc_service_end_dt;--
						 vl_rfc_unit_no = vl_csrfc_unit_no;--
						 vs_rfc_unit_type = vs_csrfc_unit_type;--
		
						-- RFC -  START
						IF vl_rfc_unit_no is NOT NULL AND vl_rfc_unit_no > 0 THEN
							 vs_rate_type_cd = 'R'; -- INITIAL VALUE
							 vdc_monthly_rate = 0.00; -- INITIAL VALUE
							 vdc_perdiem_rate = 0.00; -- INITIAL VALUE
				
							SELECT  a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error from SP_GET_PLACEMENT_RATE (vl_plc_structure_rfc_id,
															vl_age_of_child,
															vd_rfc_service_st_dt,
															vd_rfc_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-10C)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-10C)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vl_rfc_unit_no = 1 and vs_rfc_unit_type = '5611' THEN  -- monthly rate
								 vdc_gross_amount = vdc_monthly_rate;--
								 vdc_monthly_rate = vdc_monthly_rate;--
							ELSE
								 vs_rfc_unit_type = '5610';  -- nightly rate
								 vdc_gross_amount = vdc_perdiem_rate * vl_rfc_unit_no;--
								 vdc_perdiem_rate = vdc_perdiem_rate;--
							END IF;--

							-- insert or updating record in payment detail
							-- New condition for Room & Board Rate Type cd - CIS-19002 	
							-- New condition check for placement structure id - PRJ-04753
							IF vs_rate_type_cd = 'R' THEN
								IF vd_rfc_service_end_dt <= DATE('2009-08-31') 
									AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409 ) THEN
										 vs_rate_type_cd = '1232'; -- Room & Board
								ELSE
										 vs_rate_type_cd = '5670'; -- Room & Board/Clothing
								END IF;--
							END IF;--

						
								         SELECT a.al_sqlcode, a.as_error 
								         from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_plc_structure_rfc_id,
										vd_rfc_service_st_dt,
										vd_rfc_service_end_dt,
										vdc_gross_amount,
										vl_rfc_unit_no,
										vs_rfc_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-10D)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-10D)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;		--
						END IF;--
						-- RFC -  END
	
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential under Placement Structure 13 - START
						IF vl_csrfcd_unit_no is NOT NULL AND vl_csrfcd_unit_no > 0 THEN
							 vs_rate_type_cd = 'D'; -- INITIAL VALUE
							 vdc_monthly_rate = 0.00; -- INITIAL VALUE
							 vdc_perdiem_rate = 0.00; -- INITIAL VALUE
				
						SELECT a.adc_gross_amount ,
							a.adc_per_diem_rate ,
							a.al_sqlcode ,
							a.as_error  from SP_GET_PLACEMENT_RATE (vl_plc_structure_rfc_id,
															vl_age_of_child,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vs_rate_type_cd) a into 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error ;--

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-10DA)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_GET_PLACEMENT_RATE failed. (SP-10DA)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vl_csrfcd_unit_no = 1 and vs_csrfcd_unit_type = '5611' THEN  -- monthly rate
								 vdc_gross_amount = vdc_monthly_rate;--
								 vdc_monthly_rate = vdc_monthly_rate;--
							ELSE
								 vs_csrfc_unit_type = '5610';  -- nightly rate
								 vdc_gross_amount = vdc_perdiem_rate * vl_csrfcd_unit_no;--
								 vdc_perdiem_rate = vdc_perdiem_rate;--
							END IF;--

							-- insert or updating record in payment detail
							IF vs_rate_type_cd = 'D' THEN
								 vs_rate_type_cd = '5671'; -- Room & Board/Clothing/Differential
							END IF;--

							SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
										vl_pay_header_id,
										vl_plc_structure_rfc_id,
										vd_csrfcd_service_st_dt,
										vd_csrfcd_service_end_dt,
										vdc_gross_amount,
										vl_csrfcd_unit_no,
										vs_csrfcd_unit_type,
										vdc_perdiem_rate,
										vs_draft_final_type,
										vs_rate_type_cd,
										vl_linked_pymnt_hdr_id,
										vl_reference_payment_detail_id,
										vs_change_type) a into 
										al_sqlcode,
										as_error ;-- 

							IF al_sqlcode <> 0 THEN
								 as_error = as_error || ' (SP-10DB)' ;--
								IF as_error is NULL OR as_error = '' THEN
									 as_error = 'SP_PAYMENT_DETAIL_INSERT failed. (SP-10DB)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;				--
						END IF;--
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential under Placement Structure 13 - END
						-- PRJ-03018 - Always re-calculate payment amount even if nothing changed from draft and final run - END
		
						IF vs_EFC_no_change = 'Y' AND vs_RFC_no_change = 'Y'
							AND ( ( vl_csrfc_unit_no is NULL AND vl_check_csrfc_unit_no is NULL )
							OR ( vl_csrfc_unit_no = vl_check_csrfc_unit_no ) )
							AND ( ( vl_csrfcd_unit_no is NULL AND vl_check_csrfcd_unit_no is NULL )
							OR ( vl_csrfcd_unit_no = vl_check_csrfcd_unit_no ) ) THEN  -- NOTHING CHANGED
		     	
								 vs_CSRFC_no_change = 'Y';--
			
							-- PRJ-03018 - Removed Update TB_PAYMENT_DETAIL statement from here.

						ELSE
						
							-- PRJ-03018- payment re-calculation code was moved out of IF....ELSE...END IF  from here.	

						END IF;--
					ELSE
						 vs_CSRFC_no_change = 'Y';--
					END IF;--
		
					IF (( vl_efc_unit_no is NOT NULL AND vl_efc_unit_no > 0 ) OR ( vl_rfc_unit_no is NOT NULL AND vl_rfc_unit_no > 0 ) OR ( vl_csrfcd_unit_no is NOT NULL AND vl_csrfcd_unit_no > 0 ))
						AND ( vs_EFC_no_change = 'N' OR vs_RFC_no_change = 'N' OR vs_CSRFC_no_change = 'N') THEN
 				
						 vs_update_status_flag = 'Y';  -- UPDATE PAYMENT STATUS TO APPROVED, CAN BE PICKED UP BY FMIS INTERFACE

						UPDATE TB_PAYMENT_DETAIL
						SET	 CHANGE_REASON_CD = '3035'
						WHERE PAYMENT_ID = vl_pay_header_id
							AND PLACEMENT_ID = vl_placement_id;--

						 al_sqlcode = SQLCODE;--
						IF al_sqlcode <> 0 THEN
							 as_error = 'Error in Updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-6C)'  ;--
							 vs_identity_column = 'Placement ID';--
							 vs_identity_val =  (vl_placement_id)::character varying;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
						--Commented bcz of placement view
						--UPDATE TB_PLACEMENT
						--SET  PAYMENT_HEADER_ID = vl_pay_header_id
						--WHERE (PLACEMENT_ID = cur_placement_detail_record.PLACEMENT_ID);--
						
						UPDATE placement
							SET paymentheaderid = vl_pay_header_id					
							WHERE (alternateid = cur_placement_detail_record.PLACEMENT_ID);--
						
						 al_sqlcode = SQLCODE;--
						IF al_sqlcode <> 0 THEN
							 as_error = 'Error in Updating TB_PLACEMENT. (SQL-6D)'  ;--
							 vs_identity_column = 'Placement ID';--
							 vs_identity_val =  (vl_placement_id)::character varying;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
					END IF;--
					-- ********** ROOM AND BOARD END ******** -------------------
				END IF;--
			ELSE
				SELECT a.vl_output_sqlcode,
							a.vs_message  FROM SP_PAYMENT_EXECEPTION ('FC_PUBLIC_FINAL',
												cur_placement_detail_record.CLIENT_ID,
												'Client is receiving Adoption Subsidy ' || '' || (cur_placement_detail_record.CLIENT_ID::character varying)) a into
												VL_SQLCODE,
												VS_MESSAGE;--

				IF VL_SQLCODE <> 0 THEN
					 vs_Procedure_nm  =  'SP_PAYMENT_EXECEPTION';	--
					 vs_identity_column = 'Client ID';--
					 vs_identity_val = cur_placement_detail_record.CLIENT_ID;--
					 as_error = VS_MESSAGE  || ' (SP-11)' ;--
					IF as_error is NULL OR as_error = '' THEN
						 as_error = 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-11)'  ;--
					END IF;--
					-- SIGNAL p_sp_error  ;--
				END IF ;--
            END IF; -- adoption subsidy check

        ELSE  -- RECORD NOT VALIDATED
			UPDATE TB_PAYMENT_DETAIL
				SET CHANGE_REASON_CD = '3037'
			WHERE PAYMENT_ID = vl_pay_header_id
				AND PLACEMENT_ID = vl_placement_id;--

			 al_sqlcode = SQLCODE;--
			IF al_sqlcode <> 0 THEN
				 as_error = 'Error in updating TB_PAYMENT_DETAIL - Change Reason CD. (SQL-7)'  ;--
				 vs_identity_column = 'Placement ID';--
				 vs_identity_val = vl_placement_id;--
				-- SIGNAL p_sp_error  ;--
			END IF ;--
        END IF;   -- record validation
	END LOOP;    -- cur_placement_detail
        CLOSE cur_placement_detail;
	-- check if any final record is created and provider does not have withhold sw then  payment status to approved else  the
	-- payment status to hold
	IF vs_update_status_flag = 'Y' THEN
		SELECT WITHHOLD_PAYMENT_SW
			INTO vs_withhold_payment
		FROM TB_PROVIDER
		WHERE PROVIDER_ID = vl_provider_id
			  AND DELETE_SW = 'N';--

		-- 06/02/2008 New Logic for missing info (Provider Checklist) - START
		 vl_checklist_cnt = 0 ; -- INITIAL VALUE

		SELECT COUNT(*)
			INTO vl_checklist_cnt
		FROM TB_PROVIDER_DETAILS_CHECKLIST
		WHERE PROVIDER_ID = vl_provider_id
			AND DELETE_SW = 'N'
			AND PROVIDER_CATEGORY_SW = 'Y'
			AND TAX_ID_TYPE_SW = 'Y'
			AND TAX_ID_SW = 'Y'
			AND MAIL_CODE_SW = 'Y'
			AND INDICATOR_1099_SW = 'Y'
			AND SEND_PAYMENT_TO_SW = 'Y'
			AND LOCAL_DEPARTMENT_SW = 'Y'
			AND RESOURCE_WORKER_SW = 'Y'
			AND LOCN_ADR_SW = 'Y'
			AND PAY_ADR_SW  = 'Y' ;--

		 al_sqlcode = SQLCODE;--
		IF al_sqlcode <> 0  THEN
			 as_error = 'Payment Header: Error in selecting record from TB_PROVIDER_DETAILS_CHECKLIST (SQL-7A)';--
			 vs_identity_column = 'Provider ID';--
			 vs_identity_val = vl_provider_id;--
			-- SIGNAL p_sp_error  ;--
		END IF ;	--

		IF vl_checklist_cnt is NULL THEN
			 vl_checklist_cnt = 0;--
		END IF;--
		-- 06/02/2008 New Logic for missing info (Provider Checklist) - END

		IF vs_withhold_payment = 'Y' OR vl_checklist_cnt = 0 THEN
			 vs_payment_status = '1635';   -- Hold
		ELSE
			 vs_payment_status = '1634';   -- Approved
		END IF;--

		UPDATE TB_PAYMENT_STATUS
		 SET   PAYMENT_STATUS_CD = vs_payment_status,
			   PAYMENT_STATUS_DT = CURRENT_DATE
		WHERE PAYMENT_ID = vl_pay_header_id
			  AND DELETE_SW = 'N';--

		 al_sqlcode = SQLCODE;--
		IF al_sqlcode <> 0 THEN
			 as_error = 'Error in updating TB_PAYMENT_STATUS. (SQL-8)'  ;--
			 vs_identity_column = 'Payment ID';--
			 vs_identity_val = vl_pay_header_id;--
			-- SIGNAL p_sp_error  ;--
		END IF ;--
		
		-- getting the sum of all the payment needed
		SELECT SUM(FINAL_AMOUNT_NO)
			INTO vdc_total_final_amount
		FROM TB_PAYMENT_DETAIL
		WHERE ( PAYMENT_ID = vl_pay_header_id AND DELETE_SW = 'N' );--

		-- check any off amount for this provider
		IF vdc_total_final_amount > 0 AND vs_payment_status = '1634' THEN -- CIS-18254 II
			SELECT sp_payment_offset (vl_provider_id, 
											vdc_total_final_amount) into
											vdc_off_amount;--
			
			IF vdc_off_amount > 0 THEN
				IF vdc_total_final_amount <= vdc_off_amount THEN
					 vdc_off_amount = vdc_total_final_amount;--
				END IF;--

				SELECT SP_RECEIVABLE_OFFSET_AMOUNT ( vdc_off_amount,
														   vl_provider_id, 
														   vl_pay_header_id) INTO vl_sqlcode;--
				
				IF vl_sqlcode <> 0 THEN
					 vs_Procedure_nm  =  'SP_RECEIVABLE_OFFSET_AMOUNT';	--
					 vs_identity_column = 'Provider ID/ Payment ID';--
					 vs_identity_val = vl_provider_id || '/ ' || vl_pay_header_id ;--
					 as_error = as_error || ' (SP-12)' ;--
					IF as_error is NULL OR as_error = '' THEN
						 as_error = 'SP_RECEIVABLE_OFFSET_AMOUNT failed. (SP-12)'  ;--
					END IF;--
					-- SIGNAL p_sp_error  ;--
				END IF ;--
			ELSE
				 vdc_off_amount = null;--
			END IF;--
		ELSE
			 vdc_off_amount = null;--
		END IF;--
		--  off amount processing

		-- updating header table
		UPDATE TB_PAYMENT_HEADER
		SET	 GROSS_AMOUNT_NO = vdc_total_final_amount,
			PAYMENT_DT = CURRENT_DATE,
			offset_amount_no = vdc_off_amount
		WHERE (  PAYMENT_ID = vl_pay_header_id );--

		 al_sqlcode = SQLCODE;--
		IF al_sqlcode <> 0 THEN
			 as_error = 'Error in updating TB_PAYMENT_HEADER - Gross Amount. (SQL-9)'  ;--
			 vs_identity_column = 'Payment ID';--
			 vs_identity_val =vl_pay_header_id;--
			-- SIGNAL p_sp_error  ;--
		END IF ;--

		-- CHECK IF THERE IS ANY PAYMENT HEADER CREATED WITHOUT DETAIL THEN DELETE
		SELECT COUNT(*)
			INTO vl_payment_detail_count
		FROM TB_PAYMENT_DETAIL
		WHERE PAYMENT_ID = vl_pay_header_id;--

		IF vl_payment_detail_count = 0  THEN
			DELETE FROM TB_PAYMENT_STATUS WHERE PAYMENT_ID = vl_pay_header_id;--
			DELETE FROM TB_PAYMENT_HEADER WHERE PAYMENT_ID = vl_pay_header_id;--
		END IF;--

		 vs_update_status_flag = 'N';--
	END IF;--
	--COMMIT;--
END LOOP;  -- FOR CHECK_PLACEMENT
CLOSE cur_check_detail;

-- check for emergency bed retainer fee
-- CALL CHESSIE.SP_FOSTER_CARE_BEDRETAINER (vd_previous_month_start_dt,vd_previous_month_end_dt,vs_draft_final_type  );--

execute SP_UPDATE_PAYMENT_REASONS (vs_public_sw );--

execute SP_EFC_RFC_TICKLERS(420, 'F', vd_previous_month_start_dt, vd_previous_month_end_dt);--

---  Insert Into PAYMENT log
INSERT INTO TB_PAYMENT_RUNTIMES_LOG   
	(	PAYMENT_RUNTIMES_LOG_ID,
		PAYMENT_TX,
		PAYMENT_CURRENT_RUN_TS,
		PAYMENT_PREVIOUS_RUN_TS,
		PAYMENT_BATCH_NO,
		PAYMENT_SUCCESSFUL_SW,
		CREATE_TS,
		CREATE_USER_ID,
		UPDATE_TS,
		UPDATE_USER_ID,
		DELETE_SW,
		PAYMENT_OTHER_TX)
SELECT
		NEXTVAL('sq_payment_runtimes_log'),
		'FC_PUBLIC_FINAL',
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
		'',
		'',
		CURRENT_TIMESTAMP,
		VS_USER_ID,   							
		CURRENT_TIMESTAMP,
		VS_USER_ID,
		'N',
		'SP_FOSTER_CARE_PUBLIC_FINAL -->  PROGRAM ENDED';
--FROM sysibm.sysdummy1 ;--
			
 al_sqlcode = SQLCODE;--
IF al_sqlcode <> 0 THEN
	 as_error = 'Error in Inserting PAYMENT RUNTIMES LOG -->  PROGRAM ENDED'  ;--
	 vs_identity_column = '';--
	 vs_identity_val = '';--
	-- SIGNAL p_sp_error  ;--
END IF ;--
					
--COMMIT;--
RETURN 1;
END 
;

$function$
;