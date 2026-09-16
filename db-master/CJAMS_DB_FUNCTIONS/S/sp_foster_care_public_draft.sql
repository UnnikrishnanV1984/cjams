Drop function if exists cjams.sp_foster_care_public_draft();

CREATE OR REPLACE FUNCTION cjams.sp_foster_care_public_draft(OUT return_code integer, OUT al_sqlcode integer, OUT as_mess character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s):
-- 07/12/2021 Vineet Tirodkar - To exclude placements with entry date beyond client's 21st bday (CIDM-3049) 
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 11/06/2024 - Vineet Tirodkar - To add new Non-paid Kinship Placement structure in exclusion  (B-207876 / CIDM-9688)
------------------------------------------------------------------------
DECLARE vl_pay_header_id BIGINT DEFAULT 0;--
 vl_old_pay_header_id BIGINT DEFAULT 0;--
 vl_pay_detail_id BIGINT DEFAULT 0;--
 vl_provider_id BIGINT DEFAULT 0;--
 vl_placement_structure_id BIGINT DEFAULT 0;--
 vl_placement_id BIGINT DEFAULT 0;--
 vl_service_id BIGINT DEFAULT 0;--
 vl_doc_level_id BIGINT DEFAULT 0;--
 vl_emergency_structure_id BIGINT DEFAULT 71;--

 vl_linked_pymnt_hdr_id BIGINT DEFAULT NULL;--
 vl_reference_payment_detail_id BIGINT DEFAULT NULL;--

--
 vl_payment_count INT DEFAULT 0;--
 vl_unit_no INT DEFAULT 0;--
 vl_payment_detail_count INT DEFAULT 0;--

 vl_age_of_child INT DEFAULT 0;--
 vl_clothing_allow_count INT DEFAULT 0;--
 vl_doc_count INT DEFAULT 0;--
 vl_bed_retainer_count INT DEFAULT 0;--
 vl_bed_retainer_count_exist INT DEFAULT 0;--
 vl_paid_beds INT DEFAULT 0;--
 vl_available_vacancy INT DEFAULT 0;--
 vl_approved_beds INT DEFAULT 0;--

 vdc_monthly_rate decimal(10,2);--
 vdc_perdiem_rate decimal(10,2);--
 vdc_monthly_clothing_rate decimal(10,2);--
 vdc_monthly_doc_rate decimal(10,2);--
 vdc_emergency_per_diem_rate decimal(10,2);--
 vdc_bed_retainer_fee decimal(10,2);--
 vdc_gross_amount decimal(10,2);--
 vdc_total_draft_amount decimal(10,2);--
 vdc_bed_retainer_total decimal(10,2);--
 vdc_stipend_amount_no decimal(10,2);--

 vs_unit_type VARCHAR(5);--
 vs_payment_type VARCHAR(5) DEFAULT '6';--
 vs_rate_type_cd VARCHAR(5);--
 vs_draft_final_type CHAR(1) DEFAULT 'D';--
 vs_initial_clothing_flag CHAR(1) DEFAULT 'T'; -- initial clothing logic flag

 vd_previous_month_start_dt DATE;--
 vd_previous_month_end_dt DATE;--
 vd_current_month_end_dt DATE;--
 vd_current_service_start_dt DATE;--
 vd_current_service_end_dt DATE;--

 vd_current_placement_start_dt DATE;--
 vd_current_placement_end_dt DATE;--

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
 vl_no_of_days INTEGER;--

-- 12/04/2009
 vd_stipend_service_start_dt DATE;--
 vd_stipend_service_end_dt DATE;--
 vl_stipend_unit_no INT;--
 vs_stipend_unit_type VARCHAR(5);--

--01/27/2010
 vd_csrfc_service_st_dt DATE;--
 vd_csrfc_service_end_dt DATE;--
 vl_csrfc_unit_no INT;--
 vs_csrfc_unit_type VARCHAR(5);--
 vd_csrfcd_service_st_dt DATE;--
 vd_csrfcd_service_end_dt DATE;--
 vl_csrfcd_unit_no INT;--
 vs_csrfcd_unit_type VARCHAR(5);--

--Mohan
  VS_RESULT            CHAR(1);--
  VS_USER_ID           VARCHAR(10)     DEFAULT  'finance';--
  VTS_PREVIOUS_RUN_TS  TIMESTAMP;--
  VTS_CURRENT_RUN_TS    TIMESTAMP ;--
  VL_ROWCOUNT           INTEGER DEFAULT  0;--
--Mohan
Val_R CHAR(1) DEFAULT 'R';--
Val_L CHAR(1) DEFAULT 'L';--
Val_FC_PUBLIC_DRAFT CHAR(20) DEFAULT 'FC_PUBLIC_DRAFT';--
Val_MSG CHAR(200) DEFAULT 'Monthly Room and Board Rate is missing for the Placement Structure';--
-- PRJ-04753
 vs_change_type VARCHAR(5) DEFAULT NULL ;--

 as_error VARCHAR(3000);--
 SQLCODE    INTEGER    DEFAULT 0;--
 SQLSTATE CHAR(5) DEFAULT '00000';--
 p_sp_error CHAR(5);--
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
--DECLARE p_sp_error SQLSTATE  '99999' ;--
 vs_message_text VARCHAR(3000) DEFAULT '';--
 vl_ret_status INTEGER DEFAULT 0;--
 vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_FOSTER_CARE_PUBLIC_DRAFT';--
 vs_identity_column VARCHAR(100);--
 vs_identity_val VARCHAR(100);
 cur_placement record;
 cur_placement_detail record;
 cur_placement_refcur REFCURSOR;
 cur_placement_detail_refcur REFCURSOR;
 BEGIN

--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
   EXCEPTION WHEN OTHERS THEN
   -- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
   --  al_sqlcode = -1 ;--
    as_error := COALESCE(as_error ,'') || ( CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
    as_error := COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');--
    as_error := as_error ||COALESCE(vs_message_text ,'');--

    /*select SP_BATCH_ERROR_LOG ( 'SP_FOSTER_CARE_PUBLIC_DRAFT' ,
				       NULL,
				       NULL,
				       NULL,
				       NULL,
				       as_error,
				       'finance',
				       vl_ret_status )                    ;--*/
    select SP_BATCH_ERROR_LOG ( 'SP_FOSTER_CARE_PUBLIC_DRAFT'::character varying ,
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
     
		return_code:=0;
		return;
     
END;--

--  get the last month start date and end date
SELECT (date_trunc('month', now()) - interval '1 month')::date,
       (date_trunc('month', now())::date - 1)::date,
       ((date_trunc('month', now()) + interval '1 month')- interval '1 Day')::date
INTO    vd_previous_month_start_dt,
        vd_previous_month_end_dt,
        vd_current_month_end_dt;

--  Initialize variables with the current timestamp
VTS_PREVIOUS_RUN_TS := CURRENT_TIMESTAMP;--
VTS_CURRENT_RUN_TS := CURRENT_TIMESTAMP;--

--  get the last run timestamp
--  if first run, i.e., no rows in log, then leave as initialized

SELECT COUNT(*)
	INTO VL_ROWCOUNT
FROM TB_PAYMENT_RUNTIMES_LOG
WHERE PAYMENT_TX   = 'FC_PUBLIC_DRAFT';--

IF  VL_ROWCOUNT > 0 THEN
	SELECT MAX(PAYMENT_CURRENT_RUN_TS::timestamp)
		INTO VTS_PREVIOUS_RUN_TS
	FROM TB_PAYMENT_RUNTIMES_LOG
	WHERE PAYMENT_TX = 'FC_PUBLIC_DRAFT';--
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
			PAYMENT_OTHER_TX )
SELECT 		NEXTVAL('SQ_PAYMENT_RUNTIMES_LOG'),
			'FC_PUBLIC_DRAFT',
			VTS_CURRENT_RUN_TS,
			VTS_PREVIOUS_RUN_TS,
			'',
			'',
		 CURRENT_TIMESTAMP,
			VS_USER_ID,   							
		 CURRENT_TIMESTAMP,
			VS_USER_ID,
			'N',
			'SP_FOSTER_CARE_PUBLIC_DRAFT -->  PROGRAM STARTED';
--FROM sysibm.sysdummy1;--
						
al_sqlcode := SQLCODE;			--
IF al_sqlcode <> 0 THEN
	as_error := 'Error in inserting PAYMENT RUNTIMES LOG -->  PROGRAM STARTED';--
	vs_identity_column := '';--
	vs_identity_val := '';--
	---- SIGNAL p_sp_error;--
END IF;--

-- check for placement record for public provider for the previous month
-- and placement structure other than Kinship care
-- need to add payee name and address

  OPEN cur_placement_refcur FOR
--FOR cur_placement AS
--cur1 CURSOR WITH HOLD FOR
	SELECT DISTINCT PL.PROVIDER_ID, 
					PL.PAYMENT_HEADER_ID
		FROM TB_PLACEMENT PL
	WHERE PL.PROVIDER_ORGANIZATION_ID  IS NULL
		AND PL.CONTRACT_PROGRAM_ID IS NULL
		AND PL.PLACEMENT_STRUCTURE_ID IS NOT NULL
		AND PL.PROVIDER_ID IS NOT NULL
		AND PL.PLACEMENT_STRUCTURE_ID not in ( 8, 76, 531 )
		AND PL.APPROVAL_STATUS_CD = '3047'
		AND ((PL.VOID_SW IS NULL) OR (PL.VOID_SW = 'N'))
		AND PL.ENTRY_DT <= vd_previous_month_end_dt
		AND ( (PL.EXIT_DT  IS NULL) OR  (PL.EXIT_DT > vd_previous_month_start_dt ))
		AND ( PL.EXIT_DT IS NULL OR PL.ENTRY_DT <> PL.EXIT_DT )
		AND PL.DELETE_SW = 'N'
		AND PL.CONVERSION_SW IS NULL;
		
		

--DO
	loop
	fetch cur_placement_refcur into cur_placement;
										 exit when not found;
	-- generating payment header id and insert into payment header with payment type
    vl_pay_header_id := 0;--
    vl_provider_id := cur_placement.PROVIDER_ID;--
    SELECT PAYMENT_ID
    	INTO vl_pay_header_id
      FROM TB_PAYMENT_HEADER
    WHERE PROVIDER_ID = vl_provider_id AND
          DELETE_SW = 'N' AND
          PAYMENT_START_DT = vd_previous_month_start_dt AND
          PAYMENT_END_DT = vd_previous_month_end_dt AND
          PAYMENT_TYPE_CD = '6';--

    IF ((vl_pay_header_id IS NULL) OR (vl_pay_header_id = 0)) THEN
        SELECT a.al_header_id,a.al_sqlcode,a.as_error from
											   sp_payment_header_insert(vl_provider_id::bigint,
												vs_payment_type::varchar,
												vd_previous_month_start_dt :: date,
												vd_previous_month_end_dt :: date) a into vl_pay_header_id, al_sqlcode,as_error;

		IF al_sqlcode <> 0 THEN
			as_error := as_error || ' (SP-1)' ;--
			IF as_error is NULL OR as_error = '' THEN
				as_error := 'SP_PAYMENT_HEADER_INSERT failed. (SP-1)'  ;--
			END IF;--
			-- SIGNAL p_sp_error  ;--
		END IF ;--
	END IF ;--

	-- create payment details for room and board
	OPEN cur_placement_detail_refcur  FOR
--    FOR cur_placement_detail AS
--		cur2 CURSOR WITH HOLD FOR
 	     SELECT P.PLACEMENT_ID,
		    P.ENTRY_DT::DATE,
		    (CASE WHEN f_age(C.dob::DATE,vd_previous_month_end_dt) = 21 AND ( (C.dob::DATE + interval '21 years') < P.EXIT_DT OR P.EXIT_DT is NULL)  THEN
		    	  C.dob::DATE + interval '21 years'	
		     ELSE
		          P.EXIT_DT
            END ) AS EXIT_DT,
		    P.PLACEMENT_STRUCTURE_ID,
		    P.CLIENT_ID,
		    --C.COUNTY_CD,
		    (CASE WHEN f_age(C.dob::DATE, vd_previous_month_end_dt) = 21 THEN
		    	20
		     ELSE
		    	f_age(C.dob::DATE, vd_previous_month_end_dt )
  		     END ) AS AGE_NO,
		    --C.APPROXIMATE_AGE_NO,
		    P.PAYMENT_HEADER_ID,
		    P.RATE_STRUCTURE_ID
		FROM TB_PLACEMENT P,
		     person C
		WHERE P.PROVIDER_ID = cur_placement.PROVIDER_ID
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
			AND C.dob::DATE is NOT NULL
			AND ( f_age(C.dob::DATE, vd_previous_month_end_dt ) < 21 
			     -- OR ( MONTH(C.DOB_DT + interval '21 years') = MONTH(vd_previous_month_end_dt)
				 --  AND YEAR(C.DOB_DT + interval '21 years') = YEAR(vd_previous_month_end_dt)
				 --  AND DAY(C.DOB_DT + interval '21 years') <> 1
			     --    )
				 OR ( extract(month from C.dob + INTERVAL '21 year')::integer = extract(month from vd_previous_month_end_dt)::integer
	       	         AND extract(YEAR from C.dob + INTERVAL '21 year')::integer = extract(YEAR from vd_previous_month_end_dt)::integer
	       	         AND extract(DAY from C.dob + INTERVAL '21 year')::integer <> 1
	      	       )
                )
			and P.ENTRY_DT::date < (C.dob::DATE + INTERVAL '21 year')::date -- CIDM-3049
			;

			--	AND CHESSIE.f_age(C.DOB_DT, vd_previous_month_end_dt ) < 21
			
--    DO
		loop
		fetch cur_placement_detail_refcur into cur_placement_detail;	
											exit when not found;
		vs_initial_clothing_flag := 'T';--
		-- check if this is first placement for initial clothing allowance
RAISE NOTICE '<<<<<<<<<<<<<age>>>>>>>>>>>>> %',cur_placement_detail.AGE_NO;
		vl_payment_count := 0;--

/*		SELECT COUNT(*)
			INTO vl_payment_count
		FROM TB_PLACEMENT
		WHERE CLIENT_ID = cur_placement_detail.CLIENT_ID
			AND DELETE_SW = 'N'
			AND ENTRY_DT IS NOT NULL
			AND PLACEMENT_ID <> cur_placement_detail.PLACEMENT_ID
			AND ((VOID_SW IS NULL) OR (VOID_SW = 'N'))
			AND APPROVAL_STATUS_CD = '3047'
			AND CONVERSION_SW IS NULL;--    */

		-- incident 5638 logic start
		raise notice '>>>>>>>cur_placement_detail.entry_dt>>>>>> % vd_previous_month_start_dt>>>> %',cur_placement_detail.entry_dt,vd_previous_month_start_dt;
		IF cur_placement_detail.entry_dt < vd_previous_month_start_dt THEN
			vs_initial_clothing_flag := 'F'; -- failed
		END IF;--
		-- incident 5638 logic end
		
		IF vl_payment_count = 0 OR vl_payment_count IS NULL THEN
			vl_payment_count := 0;--
		END IF;--

		vs_unit_type := NULL ;  -- Initializing the value
		vl_unit_no := NULL; -- Initializing the value
		vl_old_pay_header_id := cur_placement_detail.PAYMENT_HEADER_ID;--
		

		IF vl_old_pay_header_id IS NULL THEN
			vl_old_pay_header_id := 0;--
		END IF;--

		IF vl_old_pay_header_id !=  vl_pay_header_id THEN
		
			-- checking placement structure for preadaptive placement with adoption subsidy
			vl_placement_structure_id := 0;--
			
			vl_placement_structure_id := cur_placement_detail.RATE_STRUCTURE_ID;--
			
			vl_placement_id := cur_placement_detail.PLACEMENT_ID;--
			vd_current_placement_start_dt := cur_placement_detail.ENTRY_DT;--
			vd_current_placement_end_dt := cur_placement_detail.EXIT_DT;--

			--Mohan
			--  Adoption  Subsidy Check
			SELECT a.as_adpsub_exist from SP_ADOPTION_SUBSIDY_CHECK( cur_placement_detail.CLIENT_ID,
													 cur_placement_detail.ENTRY_DT::date) a into VS_RESULT;--
	

													 
			IF UPPER(VS_RESULT)  = 'N'  THEN -- adoption subsidy
				

				IF vl_placement_structure_id = 13 THEN -- CIS-17815
			
					--New SP for 60 days calculation, to return days in EFC and/or RFC for payments		
					-- INTIAL VALUES
					vd_efc_service_st_dt := NULL;--
					vd_efc_service_end_dt := NULL;--
					vl_efc_unit_no := NULL;--
					vs_efc_unit_type := NULL;--
					vd_rfc_service_st_dt := NULL;--
					vd_rfc_service_end_dt := NULL;--
					vl_rfc_unit_no := NULL;--
					vs_rfc_unit_type := NULL;--
             	
             	    vl_efc_calc_days := 60;--
             	
             /*	    SELECT SP_EFC_DAYS_CALCULATION(Val_R,
												  vl_placement_structure_id,
												  vd_current_placement_start_dt,
												  vd_current_placement_end_dt,
												  vd_previous_month_start_dt,
												  vd_previous_month_end_dt,
												  vl_efc_calc_days,
												  vd_efc_service_st_dt,
												  vd_efc_service_end_dt,
												  vl_efc_unit_no,
												  vs_efc_unit_type,
												  vd_rfc_service_st_dt,
												  vd_rfc_service_end_dt,
												  vl_rfc_unit_no,
												  vs_rfc_unit_type) ;--  */

             	SELECT  a.ad_efc_service_st_dt,
						a.ad_efc_service_end_dt,
						a.al_efc_unit_no,
						a.as_efc_unit_type,
						a.ad_rfc_service_st_dt,
						a.ad_rfc_service_end_dt,
						a.al_rfc_unit_no,
						a.as_rfc_unit_type FROM F_SP_EFC_DAYS_CALCULATION(Val_R,			  
							vl_placement_structure_id,
												  vd_current_placement_start_dt,
												  vd_current_placement_end_dt,
												  vd_previous_month_start_dt,
												  vd_previous_month_end_dt,
												  vl_efc_calc_days) a into vd_efc_service_st_dt,
												  vd_efc_service_end_dt,
												  vl_efc_unit_no,
												  vs_efc_unit_type,
												  vd_rfc_service_st_dt,
												  vd_rfc_service_end_dt,
												  vl_rfc_unit_no,
												  vs_rfc_unit_type; 
			RAISE NOTICE '>>>>IF vl_placement_structure_id = 13>>>>F_SP_EFC_DAYS_CALCULATION>>>>>vd_efc_service_st_dt %',vd_efc_service_st_dt;
             	ELSE
             	    -- CIS-18884

             	    IF vl_placement_structure_id = 10 THEN -- Regular Foster Care

						-- New SP for Service days calculation based on Provider Location Address county
						-- Returns payment days for 'Room & Board/Clothing' and/or 'Room & Board/Clothing/Differential'
						-- INTIAL VALUES
						vd_csrfc_service_st_dt := NULL;--
						vd_csrfc_service_end_dt := NULL;--
						vl_csrfc_unit_no := NULL;--
						vs_csrfc_unit_type := NULL;--
		
						vd_csrfcd_service_st_dt := NULL;--
						vd_csrfcd_service_end_dt := NULL;--
						vl_csrfcd_unit_no := NULL;--
						vs_csrfcd_unit_type := NULL;--
						al_sqlcode := 0;--
						as_error := NULL;--
             	
					/*	SELECT F_SP_CSRB_DAYS_CALCULATION( Val_R,
															vl_provider_id, 	
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt,
															vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vl_csrfc_unit_no,
															vs_csrfc_unit_type,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vl_csrfcd_unit_no,
															vs_csrfcd_unit_type,
															al_sqlcode,
															as_error );--   */

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
															vd_previous_month_end_dt) a into 
															vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vl_csrfc_unit_no,
															vs_csrfc_unit_type,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vl_csrfcd_unit_no,
															vs_csrfcd_unit_type,
															al_sqlcode,
															as_error;
									RAISE NOTICE '>>>>else>>>>F_SP_EFC_DAYS_CALCULATION>>>>>vd_csrfc_service_st_dt %',vd_csrfc_service_st_dt;

             	    ELSE
             	       /*	
									   SELECT SP_FOSTERCARE_CALCULATION('L',
															'R',
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vl_unit_no,
															vs_unit_type);--  */
				
			   	RAISE NOTICE '>>>>IF>>>>beofre call F_SP_FOSTERCARE_CALCULATION>>>>>vd_current_placement_start_dt %',vd_current_placement_start_dt;

						SELECT a.ad_service_start_dt,
								a.ad_service_end_dt,
								a.al_unit_no,
								a.as_unit_type FROM	F_SP_FOSTERCARE_CALCULATION(Val_L,
															Val_R,
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a into	vd_current_service_start_dt,
															vd_current_service_end_dt,
															vl_unit_no,
															vs_unit_type;
					RAISE NOTICE '>>>>IF>>>>F_SP_FOSTERCARE_CALCULATION>>>>>vd_current_service_start_dt %',vd_current_service_start_dt;

															
             	    END IF;--
                END IF;--

				--  Calculating the rate
				--  Find out the age of the child
				vl_age_of_child := 0; -- INITIAL VALUE
				vdc_monthly_rate := 0.00; -- initial value
				vdc_perdiem_rate := 0.00; -- initial value
				IF cur_placement_detail.AGE_NO IS NULL THEN
                    vl_age_of_child := 0;            --  Removed the Approximate Age 06/20/06

                    SELECT a.vl_output_sqlcode,
							a.vs_message  FROM SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
                                                         cur_placement_detail.CLIENT_ID,
                                             'Date of Birth is Missing for this Client ' || '' || (cur_placement_detail.CLIENT_ID::character varying)
                                                        -- Val_MSG
																				  ) a into 
												  		 AL_SQLCODE,
                                                         AS_MESS;--

					IF AL_SQLCODE <> 0 THEN
					   vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
					   vs_identity_column := 'Client ID';--
					   vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
					   as_error := AS_MESS || ' (SP-2)' ;--
					   IF as_error is NULL OR as_error = '' THEN
						  as_error := 'Date of Birth is missing: SP_PAYMENT_EXECEPTION failed. (SP-2)'  ;--
					   END IF;--
						-- SIGNAL p_sp_error  ;--
					END IF ;--
               ELSE
                    vl_age_of_child := cur_placement_detail.AGE_NO;--
               END IF;--

				-- get the rate for room and board
				vs_rate_type_cd := 'R';--
				IF vl_placement_structure_id <> 13 THEN -- CIS-17815				
					IF vl_placement_structure_id <> 10  THEN -- Regular Foster Care -- CIS-18884
						-- Existing Code
					/*	SELECT SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vs_rate_type_cd, 
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error );--  */

						SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;
						RAISE NOTICE 'SP_GET_PLACEMENT_RATE>>>>>>>>';

						IF al_sqlcode <> 0 THEN
							as_error := as_error || ' (SP-3)' ;--
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-3)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--

						IF vl_unit_no = 1 and vs_unit_type = '5611' THEN  -- monthly rate
							vdc_gross_amount := vdc_monthly_rate;--
							vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--
							IF vdc_monthly_rate = 0 THEN
								SELECT a.vl_output_sqlcode,
							a.vs_message FROM SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
								'Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)
														--Val_MSG
																				 ) a INTO
														AL_SQLCODE,
														AS_MESS;--

								IF AL_SQLCODE <> 0 THEN
									vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
									vs_identity_column := 'Client ID';--
									vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
									as_error := AS_MESS || ' (SP-4)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-4)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
						ELSE
							-- SET vl_unit_no = vl_no_of_nights;--
							vdc_gross_amount := vdc_perdiem_rate * vl_unit_no;--
							vdc_perdiem_rate    :=  COALESCE(vdc_perdiem_rate,0);--
							IF  vdc_perdiem_rate = 0  THEN
								SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
														AL_SQLCODE,
														AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-5)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-5)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
							END IF;--
						END IF;--
				
						-- insert record in payment detail
						-- New condition for Room & Board Rate Type cd - CIS-19002 	
						-- New condition check for placement structure id - PRJ-04753
						IF vs_rate_type_cd = 'R' THEN
							IF vd_current_service_end_dt <= DATE('2009-08-31') 
								AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409 ) THEN
									vs_rate_type_cd := '1232'; -- Room & Board	
							ELSE
									vs_rate_type_cd := '5670'; -- Room & Board/Clothing
							END IF;--
						END IF;--
			
						IF vs_unit_type = '5611' THEN
							vdc_perdiem_rate := vdc_monthly_rate; -- incident 5265
						END IF;--

					/*	SELECT SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
														vs_change_type,
														al_sqlcode,
														as_error );--  */
			
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vl_placement_id %',vl_placement_id;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vl_pay_header_id %',vl_pay_header_id;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vl_placement_structure_id %',vl_placement_structure_id;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vd_csrfc_service_st_dt %',vd_current_service_start_dt;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vd_csrfc_service_end_dt %',vd_current_service_end_dt;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vdc_gross_amount %',vdc_gross_amount;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vl_unit_no %',vl_unit_no;
			 RAISE NOTICE '>>>>>before>>>>>SP_PAYMENT_DETAIL_INSERT>>>>vl_unit_no %',vl_unit_no;
						SELECT a.al_sqlcode,
                                   a.as_error   FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																					vs_change_type) a INTO
																					al_sqlcode,
																					as_error;--
							/*SELECT a.al_sqlcode,
                                   a.as_error   FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type) a into al_sqlcode,
																as_error;*/

						IF al_sqlcode <> 0 THEN
							as_error := as_error || ' (SP-6)' ;--
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
					ELSE -- Placement Structure ID = 10 -- CIS-18884
						-- CIS-18884 New Code - START
						-- RFC - Room & Board/Clothing - START
						IF vl_csrfc_unit_no is NOT NULL AND vl_csrfc_unit_no > 0 THEN
							vs_rate_type_cd := 'R'; -- INITIAL VALUE
							vdc_monthly_rate := 0.00; -- INITIAL VALUE
							vdc_perdiem_rate := 0.00; -- INITIAL VALUE
               	
						/*	SELECT SP_GET_PLACEMENT_RATE (vl_placement_structure_id, 
																vl_age_of_child,
																vd_csrfc_service_st_dt,
																vd_csrfc_service_end_dt, 
																vs_rate_type_cd,
																vdc_monthly_rate,
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error );--  */
									   
						    SELECT a.adc_gross_amount,
									a.adc_per_diem_rate,
									a.al_sqlcode,
									a.as_error		FROM SP_GET_PLACEMENT_RATE (vl_placement_structure_id, 
																vl_age_of_child,
																vd_csrfc_service_st_dt,
																vd_csrfc_service_end_dt, 
																vs_rate_type_cd) a into vdc_monthly_rate,
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error;	   
	
							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6AA)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-6AA)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vl_csrfc_unit_no = 1 and vs_csrfc_unit_type = '5611' THEN  -- monthly rate
								vdc_gross_amount := vdc_monthly_rate;--
								vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--
								IF vdc_monthly_rate = 0 THEN
									SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
																cur_placement_detail.CLIENT_ID,
																'County Specific Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
																AL_SQLCODE,
																AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6AB)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-6AB)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							ELSE
								vdc_gross_amount := vdc_perdiem_rate * vl_csrfc_unit_no;--
								vdc_perdiem_rate :=  COALESCE(vdc_perdiem_rate,0);--
								IF vdc_perdiem_rate = 0 THEN
								/*	SELECT SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															--'County Specific Per Diem Room and Board Rate is missing for the Placement Structure' || '' || vl_placement_structure_id ,
															Val_MSG,
															AL_SQLCODE,
															AS_MESS);-- */
									   
									   SELECT a.vl_output_sqlcode,
												a.vs_message FROM SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															'County Specific Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)
															--Val_MSG
															) a into AL_SQLCODE,
															AS_MESS;
	
									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6AC)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-6AC)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							END IF;--
	       			
							-- Insert record in payment detail
							-- New condition check for placement structure id - PRJ-04753
							IF vs_rate_type_cd = 'R' THEN
								IF vd_csrfc_service_end_dt <= DATE('2009-08-31') 
									AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409 ) THEN
										vs_rate_type_cd := '1232'; -- Room & Board	
								ELSE
										vs_rate_type_cd := '5670'; -- Room & Board/Clothing
								END IF;--
							END IF;--
	       		
							IF vs_csrfc_unit_type = '5611' THEN
								vdc_perdiem_rate := vdc_monthly_rate;--
							END IF;--

					/*		SELECT SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type,
																al_sqlcode,
																as_error );--  */
	                        SELECT a.al_sqlcode,
                                   a.as_error   FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type) a into al_sqlcode,
																as_error;
							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6AD)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6AD)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF;--
						-- RFC - Room & Board/Clothing - END
	
	
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential - START
						IF vl_csrfcd_unit_no is NOT NULL AND vl_csrfcd_unit_no > 0 THEN
							vs_rate_type_cd := 'D'; -- INITIAL VALUE
							vdc_monthly_rate := 0.00; -- INITIAL VALUE
							vdc_perdiem_rate := 0.00; -- INITIAL VALUE

					/*		SELECT SP_GET_PLACEMENT_RATE (vl_placement_structure_id, 
																vl_age_of_child,
																vd_csrfcd_service_st_dt, 
																vd_csrfcd_service_end_dt, 
																vs_rate_type_cd,
																vdc_monthly_rate, 
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error );--   */
											
							SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															--vd_current_service_start_dt,
															--vd_current_service_end_dt,
															vd_csrfcd_service_st_dt, 
															vd_csrfcd_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;				
											

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6AE)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-6AE)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF vl_csrfcd_unit_no = 1 and vs_csrfcd_unit_type = '5611' THEN  -- monthly rate
								vdc_gross_amount := vdc_monthly_rate;--
								vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--
								IF vdc_monthly_rate = 0 THEN
									SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															'County Specific Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
															AL_SQLCODE,
															AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6AF)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-6AF)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							ELSE
								vdc_gross_amount := vdc_perdiem_rate * vl_csrfcd_unit_no;--
								vdc_perdiem_rate := COALESCE(vdc_perdiem_rate,0);--
								IF vdc_perdiem_rate = 0 THEN
									SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															'County Specific Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
															--VAL_MSG,
															AL_SQLCODE,
															AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6AG)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-6AG)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							END IF;--

							-- Insert record in payment detail
							IF vs_rate_type_cd = 'D' THEN
								vs_rate_type_cd := '5671'; -- Room & Board/Clothing/Differential
							END IF;--

							IF vs_csrfcd_unit_type = '5611' THEN
								vdc_perdiem_rate := vdc_monthly_rate;--
							END IF;--

					/*		SELECT SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type,
																al_sqlcode,
																as_error );--  */
							SELECT a.al_sqlcode,
                                   a.as_error   FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
																vl_pay_header_id,
																vl_placement_structure_id,
																--vd_csrfc_service_st_dt,
																--vd_csrfc_service_end_dt,
																vd_csrfcd_service_st_dt,
																vd_csrfcd_service_end_dt,
																vdc_gross_amount,
																--vl_csrfc_unit_no,
																--vs_csrfc_unit_type,
																vl_csrfcd_unit_no,
																vs_csrfcd_unit_type,
																vdc_perdiem_rate,
																vs_draft_final_type,
																vs_rate_type_cd,
																vl_linked_pymnt_hdr_id,
																vl_reference_payment_detail_id,
																vs_change_type) a into al_sqlcode,
																as_error;
							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6AH)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6AH)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF;--
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential - END
	
						-- CIS-18884 New Code - END
					END IF;--
				ELSE -- Placement Structure ID = 13 (Emergency Foster Home Care) - START
					--Insert Payment deatils based on days in EFC and/or RFC for payments
					--EFC - START
					IF vl_efc_unit_no is NOT NULL AND vl_efc_unit_no > 0 THEN
						vs_rate_type_cd := 'R'; -- INITIAL VALUE
						vdc_monthly_rate := 0.00; -- INITIAL VALUE
						vdc_perdiem_rate := 0.00; -- INITIAL VALUE

					/*	SELECT SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_efc_service_st_dt,
															vd_efc_service_end_dt,
															vs_rate_type_cd,
															vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error );--  */
											
						SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															--vd_current_service_start_dt,
															--vd_current_service_end_dt,
															vd_efc_service_st_dt,
															vd_efc_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error || ' (SP-6A)' ;--
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-6A)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--

						IF vl_efc_unit_no = 1 and vs_efc_unit_type = '5611' THEN  -- monthly rate
							IF vd_efc_service_end_dt = vd_previous_month_end_dt 
									and (vd_efc_service_end_dt <> vd_current_placement_end_dt or vd_current_placement_end_dt is null) THEN
								SELECT DAY(F_daymonth(CURRENT_DATE ,'L', 'P' )) - 1
									INTO vl_no_of_days
								FROM sysibm.sysdummy1;--

								vdc_gross_amount := vdc_perdiem_rate * (vl_no_of_days + 1);--
								vdc_monthly_rate := COALESCE(vdc_gross_amount,0);--
							ELSE
								vdc_gross_amount := vdc_monthly_rate;--
								vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--
							END IF;--

							IF vdc_monthly_rate = 0 THEN
								SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying))a into 
														AL_SQLCODE,
														AS_MESS;--

								IF AL_SQLCODE <> 0 THEN
									vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
									vs_identity_column := 'Client ID';--
									vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
									as_error := AS_MESS || ' (SP-6B)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-6B)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
						ELSE
							vdc_gross_amount := vdc_perdiem_rate * vl_efc_unit_no;--
							vdc_perdiem_rate := COALESCE(vdc_perdiem_rate,0);--
							IF vdc_perdiem_rate = 0  THEN
							/*	SELECT SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
													cur_placement_detail.CLIENT_ID,
													'Per Diem Room and Board Rate is missing for the Placement Structure' || '' || TO_CHAR(vl_placement_structure_id) ,
													AL_SQLCODE,
													AS_MESS);--  */
						SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)
														--Val_MSG
														) a INTO
														AL_SQLCODE,
														AS_MESS;--		  

								IF AL_SQLCODE <> 0 THEN
									vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
									vs_identity_column := 'Client ID';--
									vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
									as_error := AS_MESS || ' (SP-6C)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-6C)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
						END IF;--

						-- insert record in payment detail
						vs_rate_type_cd := '1232'; -- Room & Board

						IF vs_efc_unit_type = '5611' THEN
							vdc_perdiem_rate := vdc_monthly_rate;--
						END IF;--

					/*	SELECT SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
															vs_change_type,
															al_sqlcode,
															as_error );--  */
													  
													  
													  SELECT a.al_sqlcode,
                                   a.as_error   FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
																vl_pay_header_id,
																vl_placement_structure_id,
																--vd_csrfc_service_st_dt,
																--vd_csrfc_service_end_dt,
																vd_efc_service_st_dt,
																vd_efc_service_end_dt,
																vdc_gross_amount,
																--vl_csrfc_unit_no,
																--vs_csrfc_unit_type,
																vl_efc_unit_no,
																vs_efc_unit_type,
																vdc_perdiem_rate,
																vs_draft_final_type,
																vs_rate_type_cd,
																vl_linked_pymnt_hdr_id,
																vl_reference_payment_detail_id,
																vs_change_type) a into al_sqlcode,
																as_error;

						IF al_sqlcode <> 0 THEN
							as_error := as_error || ' (SP-6D)' ;--
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6D)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
					END IF;--
					--EFC - END
		
					--RFC - START
					-- 10 ( Regular Foster Care )
					IF vl_rfc_unit_no is NOT NULL AND vl_rfc_unit_no > 0 THEN
						-- CIS-18884
						-- INTIAL VALUES
						vd_csrfc_service_st_dt := NULL;--
						vd_csrfc_service_end_dt := NULL;--
						vl_csrfc_unit_no := NULL;--
						vs_csrfc_unit_type := NULL;--
		
						vd_csrfcd_service_st_dt := NULL;--
						vd_csrfcd_service_end_dt := NULL;--
						vl_csrfcd_unit_no := NULL;--
						vs_csrfcd_unit_type := NULL;--
						al_sqlcode := 0;--
						as_error := NULL;--
             	
						SELECT a.ad_rfc_service_st_dt,
								a.ad_rfc_service_end_dt,
								a.al_rfc_unit_no,
								a.as_rfc_unit_type,
								a.ad_rfcd_service_st_dt,
								a.ad_rfcd_service_end_dt,
								a.al_rfcd_unit_no,
								a.as_rfcd_unit_type,
								a.al_sqlcode,
								a.as_error FROM SP_CSRB_DAYS_CALCULATION( 'R',
															vl_provider_id, 	
															vl_plc_structure_rfc_id,
															vd_rfc_service_st_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a INTO
															vd_csrfc_service_st_dt,
															vd_csrfc_service_end_dt,
															vl_csrfc_unit_no,
															vs_csrfc_unit_type,
															vd_csrfcd_service_st_dt,
															vd_csrfcd_service_end_dt,
															vl_csrfcd_unit_no,
															vs_csrfcd_unit_type,
															al_sqlcode,
															as_error ;		--
		
		
						vd_rfc_service_st_dt := vd_csrfc_service_st_dt;--
						vd_rfc_service_end_dt := vd_csrfc_service_end_dt;--
						vl_rfc_unit_no := vl_csrfc_unit_no;--
						vs_rfc_unit_type := vs_csrfc_unit_type;--
		
						-- RFC - Room & Board/Clothing under Placement Structure 13 - START
						IF vl_rfc_unit_no is NOT NULL AND vl_rfc_unit_no > 0 THEN
							-- Existing Code
							vs_rate_type_cd := 'R'; -- INITIAL VALUE
							vdc_monthly_rate := 0.00; -- INITIAL VALUE
							vdc_perdiem_rate := 0.00; -- INITIAL VALUE
               	
						/*	SELECT SP_GET_PLACEMENT_RATE (vl_plc_structure_rfc_id,
																vl_age_of_child,
																vd_rfc_service_st_dt,
																vd_rfc_service_end_dt,vs_rate_type_cd,
																vdc_monthly_rate,
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error );--  */
						SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (
															--vl_placement_structure_id,
															vl_plc_structure_rfc_id,
															vl_age_of_child,
															--vd_current_service_start_dt,
															--vd_current_service_end_dt,
															vd_rfc_service_st_dt,
															vd_rfc_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;
							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6E)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-6E)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
		
							IF vl_rfc_unit_no = 1 and vs_rfc_unit_type = '5611' THEN  -- monthly rate
								vdc_gross_amount := vdc_monthly_rate;--
								vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--
			
								IF vdc_monthly_rate = 0 THEN
									SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_plc_structure_rfc_id::character varying)) a into
														AL_SQLCODE,
														AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6F)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-6F)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							ELSE
								vdc_gross_amount := vdc_perdiem_rate * vl_rfc_unit_no;--
								vdc_perdiem_rate :=  COALESCE(vdc_perdiem_rate,0);--
								IF vdc_perdiem_rate = 0 THEN
								/*	SELECT SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															'Per Diem Room and Board Rate is missing for the Placement Structure' || '' || TO_CHAR(vl_plc_structure_rfc_id) ,
															AL_SQLCODE,
															AS_MESS);--  */
													  
									SELECT a.vl_output_sqlcode,
							a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)
														) a INTO
														AL_SQLCODE,
														AS_MESS;--				  

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6G)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-6G)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							END IF;--

							-- insert record in payment detail
							-- New condition for Room & Board Rate Type cd - CIS-19002
							-- New condition check for placement structure id - PRJ-04753 	
							IF vs_rate_type_cd = 'R' THEN
								IF vd_rfc_service_end_dt <= DATE('2009-08-31') 
									AND vl_placement_structure_id NOT IN ( 11405, 11406, 11407, 11408, 11409 ) THEN
										vs_rate_type_cd := '1232'; -- Room & Board
								ELSE
										vs_rate_type_cd := '5670'; -- Room & Board/Clothing
								END IF;--
							END IF;--

							IF vs_rfc_unit_type = '5611' THEN
								vdc_perdiem_rate := vdc_monthly_rate;--
							END IF;--

							SELECT a.al_sqlcode,
                                   a.as_error FROM SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type) a INTO
																al_sqlcode,
																as_error;--

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6H)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6H)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;		--
						END IF;--
						-- RFC - Room & Board/Clothing under Placement Structure 13 - END
		   		   	
		   		   		-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential under Placement Structure 13 - START
						IF vl_csrfcd_unit_no is NOT NULL AND vl_csrfcd_unit_no > 0 THEN
							vs_rate_type_cd := 'D'; -- INITIAL VALUE
							vdc_monthly_rate := 0.00; -- INITIAL VALUE
							vdc_perdiem_rate := 0.00; -- INITIAL VALUE
               	
						/*	SELECT SP_GET_PLACEMENT_RATE (vl_plc_structure_rfc_id,
																vl_age_of_child,
																vd_csrfcd_service_st_dt, 
																vd_csrfcd_service_end_dt,
																vs_rate_type_cd,
																vdc_monthly_rate, 
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error );--  */
							SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (
															--vl_placement_structure_id,
															vl_plc_structure_rfc_id,
															vl_age_of_child,
															--vd_current_service_start_dt,
															--vd_current_service_end_dt,
															vd_csrfcd_service_st_dt, 
															vd_csrfcd_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;
							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6HA)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-6HA)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
		
							IF vl_csrfcd_unit_no = 1 and vs_csrfcd_unit_type = '5611' THEN  -- monthly rate
								vdc_gross_amount := vdc_monthly_rate;--
								vdc_monthly_rate := COALESCE(vdc_monthly_rate,0);--

								IF vdc_monthly_rate = 0 THEN
									SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
															cur_placement_detail.CLIENT_ID,
															'County Specific Monthly Room and Board Rate is missing for the Placement Structure ' || '' || (vl_plc_structure_rfc_id::character varying)) a into
															AL_SQLCODE,
															AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6HB)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-6HB)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							ELSE
								vdc_gross_amount := vdc_perdiem_rate * vl_csrfcd_unit_no;--
								vdc_perdiem_rate := COALESCE(vdc_perdiem_rate,0);--
								IF vdc_perdiem_rate = 0 THEN
									SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'County Specific Per Diem Room and Board Rate is missing for the Placement Structure ' || '' || (vl_plc_structure_rfc_id::character varying)) a into
														AL_SQLCODE,
														AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-6HC)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'SP_PAYMENT_EXECEPTION failed. (SP-6HC)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--
							END IF;--

							-- Insert record in payment detail
							IF vs_rate_type_cd = 'D' THEN
								vs_rate_type_cd := '5671'; -- Room & Board/Clothing/Differential
							END IF;--

							IF vs_csrfcd_unit_type = '5611' THEN
								vdc_perdiem_rate := vdc_monthly_rate;--
							END IF;--

							SELECT a.al_sqlcode,
                                   a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
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
																vs_change_type) a INTO
																al_sqlcode,
																as_error;--

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-6HD)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-6HD)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
								END IF ;		--
						END IF;	--
						-- RFC (COUNTY SPECIFIC) - Room & Board/Clothing/Differential under Placement Structure 13 - END
					END IF;--
					--RFC - END
				END IF; -- Placement Structure ID = 13 (Emergency Foster Home Care) - START
				--commented and added for new view
				--UPDATE TB_PLACEMENT
				--SET PAYMENT_HEADER_ID = vl_pay_header_id,
				--	update_user_id = 'finance',
				--	update_ts= current_timestamp
				--WHERE (PLACEMENT_ID = cur_placement_detail.PLACEMENT_ID);--
			UPDATE placement
				SET paymentheaderid = vl_pay_header_id,
					updatedby = 'finance',
					updatedon= current_timestamp
				WHERE (alternateid = cur_placement_detail.PLACEMENT_ID);--
				
				al_sqlcode := SQLCODE;--
				IF al_sqlcode <> 0 THEN
					as_error := 'Error in Updating TB_PLACEMENT. (SQL-1)'  ;--
					vs_identity_column := 'Placement ID';--
					vs_identity_val := (vl_placement_id)::character varying;--
					-- SIGNAL p_sp_error  ;--
				END IF ;--

				-- New condition for monthly clothing allowance - CIS-19002	
				IF vl_placement_structure_id <> 13 AND vd_current_service_end_dt <= DATE('2009-08-31') THEN
					IF vl_unit_no = 1 AND vs_unit_type = '5611' THEN  -- monthly if daily it is included in the foster care rate
						vd_current_service_start_dt := vd_previous_month_start_dt;--
						vd_current_service_end_dt := vd_previous_month_end_dt;--

						SELECT COUNT(*)
							INTO vl_clothing_allow_count
						--FROM TB_PAYMENT_DETAIL_TEMP
						FROM TB_PAYMENT_DETAIL -- removed TB_PAYMENT_DETAIL_TEMP and used TB_PAYMENT_DETAIL table--Chandra
						WHERE DRAFT_RATE_TYPE_CD = '1233' AND
							  DELETE_SW = 'N' AND
							  DRAFT_SERVICE_START_DT <= vd_current_service_start_dt AND
							  DRAFT_SERVICE_END_DT >= vd_current_service_end_dt AND
							  CLIENT_ID = cur_placement_detail.CLIENT_ID;--

						IF vl_clothing_allow_count = 0 OR vl_clothing_allow_count IS NULL THEN -- clothing allowance does not exist

							vs_rate_type_cd := 'C';--
							vdc_monthly_clothing_rate := 0.00; -- initial value
							vdc_perdiem_rate := 0.00; -- initial value

						/*	SELECT SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
																vl_age_of_child,
																vd_current_service_start_dt,
																vd_current_service_end_dt,
																vs_rate_type_cd,
																vdc_monthly_clothing_rate,
																vdc_perdiem_rate, 
																al_sqlcode, 
																as_error );--  */
							SELECT a.adc_gross_amount,
								a.adc_per_diem_rate,
								a.al_sqlcode,
								a.as_error  FROM SP_GET_PLACEMENT_RATE (vl_placement_structure_id,
															vl_age_of_child,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vs_rate_type_cd) a into vdc_monthly_clothing_rate,--vdc_monthly_rate,
															vdc_perdiem_rate, 
															al_sqlcode, 
															as_error;						  
													  

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-10)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-10)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--

							IF  vs_rate_type_cd = 'C' THEN
								vs_rate_type_cd := '1233';--
							END IF;--

							IF vs_unit_type = '5611' THEN
								vdc_perdiem_rate := vdc_monthly_clothing_rate;--
							END IF;--

							vdc_monthly_clothing_rate := COALESCE(vdc_monthly_clothing_rate,0);--
							IF  vdc_monthly_clothing_rate = 0 THEN
								SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Monthly Clothing Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
														AL_SQLCODE,
														AS_MESS;--

								IF AL_SQLCODE <> 0 THEN
									vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
									vs_identity_column := 'Client ID';--
									vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
									as_error := AS_MESS || ' (SP-11)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-11)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
	
							SELECT a.al_sqlcode,
                                   a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
																vl_pay_header_id,
																vl_placement_structure_id,
																vd_current_service_start_dt,
																vd_current_service_end_dt,
																vdc_monthly_clothing_rate,
																vl_unit_no,
																vs_unit_type,
																vdc_perdiem_rate,
																vs_draft_final_type,
																vs_rate_type_cd,
																vl_linked_pymnt_hdr_id,
																vl_reference_payment_detail_id,
																vs_change_type) a INTO
																al_sqlcode,
																as_error;--

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-12)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-12)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF;--
					END IF;--
				END IF;--

				-- check difficulity of care or tfc stipend record
				-- if approved record exist then create payment detail record for that
				-- New condition to pay Stipend  - CIS-19002	
				IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
					vd_current_service_start_dt := vd_previous_month_start_dt;--
					vd_current_service_end_dt := vd_previous_month_end_dt;--
				END IF;--

				SELECT COUNT(*)
					INTO vl_doc_count
				--FROM TB_PAYMENT_DETAIL_TEMP
				FROM TB_PAYMENT_DETAIL -- removed TB_PAYMENT_DETAIL_TEMP and used TB_PAYMENT_DETAIL table--Chandra

				WHERE DRAFT_RATE_TYPE_CD = '1234' AND
					  DELETE_SW = 'N' AND
					  DRAFT_SERVICE_START_DT <= vd_current_service_start_dt AND
					  DRAFT_SERVICE_END_DT >= vd_current_service_end_dt    AND
					  CLIENT_ID = cur_placement_detail.CLIENT_ID;--

				IF vl_doc_count = 0 OR vl_doc_count IS NULL THEN -- difficulty of care record does not exist
					-- check the approved record in placement
					-- check for placement structure if it is TFC then look for the level
					IF vl_placement_structure_id = 12 OR vl_placement_structure_id = 11 THEN  -- ONLY FOR TFC AND IFC PROVIDER WILL GET STIPEND
						vdc_stipend_amount_no := 0.00;--
						vl_doc_level_id := NULL;--

						-- New Logic for Stipend Calculation 12/04/2009	
						-- INTIAL VALUES
						vdc_stipend_amount_no := NULL;--
						vd_stipend_service_start_dt := NULL;--
						vd_stipend_service_end_dt := NULL;--
						vl_stipend_unit_no := NULL;--
						vs_stipend_unit_type := NULL;--
		
						SELECT a.al_doc_level_id,
	a.adc_stipend_amount_no,
	a.ad_service_start_dt,
	a.ad_service_end_dt,
	a.al_unit_no,
	a.as_unit_type,
	a.al_sqlcode ,
	a.as_error FROM SP_STIPEND_CALCULATION(cur_placement_detail.PLACEMENT_ID,
															vl_placement_structure_id,
															vd_current_placement_start_dt,
															vd_current_placement_end_dt,
															vd_previous_month_start_dt,
															vd_previous_month_end_dt) a INTO
															vl_doc_level_id,
															vdc_stipend_amount_no,
															vd_stipend_service_start_dt,
															vd_stipend_service_end_dt,
															vl_stipend_unit_no,
															vs_stipend_unit_type,
															al_sqlcode,
															as_error;--

						IF al_sqlcode <> 0 THEN
							as_error := as_error || ' (SP-12A)' ;--
							IF as_error is NULL OR as_error = '' THEN
								as_error := 'SP_STIPEND_CALCULATION failed. (SP-12A)'  ;--
							END IF;--
							-- SIGNAL p_sp_error  ;--
						END IF ;--
			
						IF vdc_stipend_amount_no IS NULL OR vdc_stipend_amount_no = 0.00 THEN

							IF  vl_doc_level_id IS NULL OR vl_doc_level_id = 0 THEN
								-- no need to create record
							ELSE -- check the rate in the rate table
								vs_rate_type_cd := 'S';--
								vdc_emergency_per_diem_rate := 0.00; -- initial value
								vdc_perdiem_rate := 0.00; -- initial value
			

								-- New Logic for Stipend Calculation 12/04/2009	
							/*	SELECT SP_GET_PLACEMENT_RATE (vl_doc_level_id,
																	vl_age_of_child,
																	vd_stipend_service_start_dt,
																	vd_stipend_service_end_dt,
																	vs_rate_type_cd,
																	vdc_emergency_per_diem_rate,
																	vdc_perdiem_rate, 
																	al_sqlcode, 
																	as_error );--   */

								  SELECT a.adc_gross_amount,
										a.adc_per_diem_rate,
										a.al_sqlcode,
										a.as_error  FROM SP_GET_PLACEMENT_RATE (vl_doc_level_id,
																	vl_age_of_child,
																	vd_stipend_service_start_dt,
																	vd_stipend_service_end_dt,
																	vs_rate_type_cd) a into vdc_emergency_per_diem_rate,
																	vdc_perdiem_rate, 
																	al_sqlcode, 
																	as_error;
								IF al_sqlcode <> 0 THEN
									as_error := as_error || ' (SP-13)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'SP_GET_PLACEMENT_RATE failed. (SP-13)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--

								vs_rate_type_cd := '1234';--
								-- New condition to pay Stipend  - CIS-19002	
								IF vd_current_service_end_dt <= DATE('2009-08-31') THEN
									vs_unit_type := '5611' ;  -- monthly for stipend
									vl_unit_no := 1; -- monthly for stipend
								ELSE
									vs_unit_type := '5610' ;  -- Nightly for stipend
									-- No need set vl_unit_no pay as per placement dates -- Nightly for stipend
									-- SET vdc_emergency_per_diem_rate = vdc_perdiem_rate * vl_unit_no;--
									vdc_emergency_per_diem_rate := vdc_perdiem_rate * vl_stipend_unit_no;--
									vdc_perdiem_rate := COALESCE(vdc_perdiem_rate,0);--
								END IF;--

								vdc_emergency_per_diem_rate := COALESCE(vdc_emergency_per_diem_rate,0);--
								IF vdc_emergency_per_diem_rate = 0 THEN
									SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
														cur_placement_detail.CLIENT_ID,
														'Stipend Rate is missing for the Placement Structure ' || '' || (vl_placement_structure_id::character varying)) a into
														AL_SQLCODE,
														AS_MESS;--

									IF AL_SQLCODE <> 0 THEN
										vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
										vs_identity_column := 'Client ID';--
										vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
										as_error := AS_MESS || ' (SP-14)' ;--
										IF as_error is NULL OR as_error = '' THEN
											as_error := 'Monthly Rate: SP_PAYMENT_EXECEPTION failed. (SP-14)'  ;--
										END IF;--
										-- SIGNAL p_sp_error  ;--
									END IF ;--
								END IF;--

								SELECT a.al_sqlcode,
                                   a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
																	vl_pay_header_id,
																	vl_placement_structure_id,
																	vd_stipend_service_start_dt,
																	vd_stipend_service_end_dt,
																	vdc_emergency_per_diem_rate,
																	vl_stipend_unit_no,
																	vs_unit_type,
																	vdc_perdiem_rate,
																	vs_draft_final_type,
																	vs_rate_type_cd,
																	vl_linked_pymnt_hdr_id,
																	vl_reference_payment_detail_id,
																	vs_change_type) a into
																	al_sqlcode,
																	as_error;--

								IF al_sqlcode <> 0 THEN
									as_error := as_error || ' (SP-15)' ;--
									IF as_error is NULL OR as_error = '' THEN
										as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-15)'  ;--
									END IF;--
									-- SIGNAL p_sp_error  ;--
								END IF ;--
							END IF;--
						ELSE
							-- This case is NOT possible as Amount field on Stipend screen is Permanently disabled. Ref: Incident#5704
							vs_rate_type_cd := '1234';--
							vdc_emergency_per_diem_rate := vdc_stipend_amount_no;--
							vdc_perdiem_rate := vdc_stipend_amount_no;--
							vs_unit_type := '5611' ;  -- monthly for stipend
							vl_unit_no := 1; -- monthly for stipend

							-- generating payment details for difficulity of care
							SELECT a.al_sqlcode,
                                   a.as_error from SP_PAYMENT_DETAIL_INSERT(vl_placement_id,
																vl_pay_header_id,
																vl_placement_structure_id,
																vd_current_service_start_dt,
																vd_current_service_end_dt,
																vdc_emergency_per_diem_rate,
																vl_unit_no,
																vs_unit_type,
																vdc_perdiem_rate,
																vs_draft_final_type,
																vs_rate_type_cd,
																vl_linked_pymnt_hdr_id,
																vl_reference_payment_detail_id,
																vs_change_type) a INTO
																al_sqlcode,
																as_error;--

							IF al_sqlcode <> 0 THEN
								as_error := as_error || ' (SP-16)' ;--
								IF as_error is NULL OR as_error = '' THEN
									as_error := 'SP_PAYMENT_DETAIL_INSERT failed. (SP-16)'  ;--
								END IF;--
								-- SIGNAL p_sp_error  ;--
							END IF ;--
						END IF;--
					END IF;--
				END IF;--
			ELSE -- Adoption subsidy check
				SELECT a.vl_output_sqlcode,a.vs_message from SP_PAYMENT_EXECEPTION (Val_FC_PUBLIC_DRAFT,
										cur_placement_detail.CLIENT_ID,
										'Client is receiving Adoption Subsidy ' || '' || (cur_placement_detail.CLIENT_ID::character varying)) a into
										AL_SQLCODE,
										AS_MESS;--

				IF AL_SQLCODE <> 0 THEN
					vs_Procedure_nm  :=  'SP_PAYMENT_EXECEPTION';	--
					vs_identity_column := 'Client ID';--
					vs_identity_val := (cur_placement_detail.CLIENT_ID)::character varying;--
					as_error := AS_MESS || ' (SP-17)' ;--
					IF as_error is NULL OR as_error = '' THEN
						as_error := 'Adoption subsidy check: SP_PAYMENT_EXECEPTION failed. (SP-17)'  ;--
					END IF;--
					-- SIGNAL p_sp_error;--
				END IF;--
			END IF;  --  Adoption  Subsidy Check
		END IF;--
	END LOOP;  -- FOR CUR_PLACEMENT_DETAIL
close CUR_PLACEMENT_DETAIL_refcur;
	-- getting the sum of all the payment needed
	SELECT SUM(DRAFT_AMOUNT_NO)
		INTO vdc_total_draft_amount
	--FROM TB_PAYMENT_DETAIL_TEMP
	FROM TB_PAYMENT_DETAIL -- removed TB_PAYMENT_DETAIL_TEMP and used TB_PAYMENT_DETAIL table--Chandra

	WHERE ( PAYMENT_ID = vl_pay_header_id AND DELETE_SW = 'N' );--

	al_sqlcode := SQLCODE;--
	IF al_sqlcode <> 0 THEN
		as_error := 'Error in selecting sum amount in detail. (SQL-2)'  ;--
		vs_identity_column := 'Payment ID';--
		vs_identity_val := (vl_pay_header_id)::character varying;--
		-- SIGNAL p_sp_error  ;--
	END IF ;--
	
	-- updating header table
	UPDATE TB_PAYMENT_HEADER
		SET GROSS_AMOUNT_NO = vdc_total_draft_amount
	WHERE ( PAYMENT_ID = vl_pay_header_id );--

    al_sqlcode := SQLCODE;--
    IF al_sqlcode <> 0 THEN
    	as_error := 'Error in updating sum amount in header. (SQL-3)'  ;--
    	vs_identity_column := 'Payment Header ID';--
    	vs_identity_val := (vl_pay_header_id)::character varying;--
    	-- SIGNAL p_sp_error  ;--
    END IF ;--

	-- CHECK IF THERE IS ANY PAYMENT HEADER CREATED WITHOUT DETAIL DELETE THEN
	SELECT COUNT(*)
		INTO vl_payment_detail_count
	--FROM TB_PAYMENT_DETAIL_TEMP
	FROM TB_PAYMENT_DETAIL -- removed TB_PAYMENT_DETAIL_TEMP and used TB_PAYMENT_DETAIL table--Chandra
	WHERE PAYMENT_ID = vl_pay_header_id;--
RAISE NOTICE '% vl_payment_detail_count',vl_payment_detail_count;
	IF vl_payment_detail_count = 0  THEN
		DELETE FROM TB_PAYMENT_STATUS WHERE PAYMENT_ID = vl_pay_header_id;--
		DELETE FROM TB_PAYMENT_HEADER WHERE PAYMENT_ID = vl_pay_header_id;--
	END IF;--
	/* COMMIT; */--
													  
END LOOP;
close CUR_PLACEMENT_refcur;
 -- END FOR;  -- FOR CUR_PLACEMENT

-- check for emergency bed retainer fee
-- SELECT SP_FOSTER_CARE_BEDRETAINER (vd_previous_month_start_dt,vd_previous_month_end_dt,vs_draft_final_type  );--

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
		NEXTVAL('SQ_PAYMENT_RUNTIMES_LOG'),
		'FC_PUBLIC_DRAFT',
	 CURRENT_TIMESTAMP,
	 CURRENT_TIMESTAMP,
		'',
		'',
	 CURRENT_TIMESTAMP,
		VS_USER_ID,   							
	 CURRENT_TIMESTAMP,
		VS_USER_ID,
		'N',
		'SP_FOSTER_CARE_PUBLIC_DRAFT -->  PROGRAM ENDED';
--FROM sysibm.sysdummy1 ;--
						
--al_sqlcode := SQLCODE;--
--IF al_sqlcode <> 0 THEN
--	as_error := 'Error in Inserting PAYMENT RUNTIMES LOG -->  PROGRAM ENDED'  ;--
--	vs_identity_column := '';--
--	vs_identity_val := '';--
--	SIGNAL p_sp_error  ;--
--END IF ;--
--al_sqlcode :=1;
return_code:=1;
		return;
END;


$function$
;