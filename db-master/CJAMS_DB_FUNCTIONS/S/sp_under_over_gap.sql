CREATE OR REPLACE FUNCTION cjams.sp_under_over_gap(ad_run_dt date, OUT return_code integer, OUT al_sqlcode integer, OUT as_error character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      :  Vineet Tirodkar
-- Date        :  09/19/2015
-- Description :  PRJ-05327 - MD CHESSIE Fiscal Phases 2 
--				  To create under/over GAP payments due to retroactive changes to following GAP elements
--					Payment Amount
--					Rate Start Date
--					Rate End Date
--					Suspension Start Date
--					Suspension End Date
-- Arguments   : 1) IN ad_run_dt - Run Date
--				 2) OUT al_sqlcode - SQLCode for error handling
--				 3) OUT as_error - Error text

-- Revision(s)
-- 02/22/2016 Vineet Tirodkar - PRJ-05945 GAP Calculation - Warranty Project
-- Modification to 'Calculate Current Service month dates' sql to always get 1st & last days of the month for further calculation
-- 02/24/2016 Vineet Tirodkar - PRJ-05947 (IDEA-09155) Modify GAP Over Under Process
-- Modification to consider the System Generated Suspensions in under/over calculation
-- Modification to compare the new minimum re-calculation start date again with the Finance Go Live date
-- 08/12/2020 Vineet Tirodkar - To fix Unit number error for multiple rate slabs within a month (CDM-2935)
-- 10/23/2020 Vineet Tirodkar - Modifications to avoid duplicate Adoptions payments on 1st of the month (CDM-5034)
-- 04/16/2021 Vineet Tirodkar - Modifications to re-calculate payments after GAP Agreement extension (CDM-12331)
-- 05/07/2021 Vineet Tirodkar - Modifications to conver Month & Year DB2 functions to postgresql (Prod Batch failure on 05/06)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
-- 10/20/2023 - Vineet Tirodkar - To exclude suspensions with NULL Satrt Date (CIDM-8090)
------------------------------------------------------------------------
--	Log Error
DECLARE SQLCODE INT DEFAULT 0;
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;
p_sp_error CHAR(5);
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';
DECLARE vl_ret_status INTEGER DEFAULT 0;
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_UNDER_OVER_GAP';
DECLARE vs_identity_column VARCHAR(100);
DECLARE vs_identity_val VARCHAR(100);

DECLARE vl_rate_structure_id	INTEGER DEFAULT 503; -- Guardianship Assistance Program

DECLARE vdc_gross_amount		DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_payment_amount		DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_per_diem_rate		DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_suspension_amount	DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_current_balance		DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_receivable_amount	DECIMAL(10,2) DEFAULT 0.00;
DECLARE vdc_tca_amount 			DECIMAL(10,2) DEFAULT 0.00; -- TCA amount
								
DECLARE vs_payment_flag 		VARCHAR(1) DEFAULT 'G';
DECLARE vs_county_cd			VARCHAR(5);
DECLARE vs_change_type 			VARCHAR(5);
DECLARE vs_change_start_dt 		VARCHAR(10);
DECLARE vs_change_end_dt		VARCHAR(10);
DECLARE vs_TRAN_TYPE 			VARCHAR(20) DEFAULT NULL;	
DECLARE vs_room_board 			VARCHAR(5) DEFAULT '1232';
DECLARE vs_payment_type 		VARCHAR(5) DEFAULT '3294';  -- SYSTEM ADJUSTMENTS
DECLARE vs_unit_type 			VARCHAR(5);
DECLARE vs_payment_unit_type	VARCHAR(5);
DECLARE vd_previous_month_end_dt	DATE;

DECLARE vl_months					INTEGER;
DECLARE vl_age						INTEGER;
DECLARE vl_unit_no					INTEGER;
DECLARE vl_rate_slab_count 			int DEFAULT 0;
DECLARE vl_ageout_unit_no 			int DEFAULT 0;
DECLARE vl_suspension_days			INTEGER;
DECLARE vl_payment_unit_no			INTEGER;
DECLARE vl_draft_payment_run		INTEGER DEFAULT 0;
DECLARE vl_gap_payment_cnt			INTEGER DEFAULT 0;
DECLARE vl_count					INTEGER;	
DECLARE vl_total_payment_unit_no	INTEGER;	

DECLARE vl_guardian_subsidy_id			BIGINT;
DECLARE vl_provider_id					BIGINT;
DECLARE vl_client_id					BIGINT;
DECLARE vl_linked_pymnt_hdr_id			BIGINT;	
DECLARE vl_reference_payment_detail_id	BIGINT;	
DECLARE vl_adjust_payment_id			BIGINT;	
DECLARE vl_payment_id					BIGINT;	
DECLARE vl_payment_detail_id			BIGINT;	
-- DECLARE vl_parent_key_id				BIGINT;	
-- DECLARE vl_suspension_revision_id		BIGINT;	
-- DECLARE vl_first_susp_change_id			BIGINT;	
DECLARE vl_parent_key_id				uuid;	
DECLARE vl_suspension_revision_id		uuid;	
DECLARE vl_first_susp_change_id			uuid;	

DECLARE vd_change_start_dt			DATE;
DECLARE vd_change_end_dt			DATE;
DECLARE vd_subsidy_start_dt			DATE;
DECLARE vd_subsidy_end_dt			DATE;
DECLARE vl_client_dob_dt			DATE;
DECLARE vd_org_subsidy_end_dt		DATE;
DECLARE vd_current_month_start_dt	DATE;
DECLARE vd_current_month_end_dt		DATE;
DECLARE vd_payment_start_dt			DATE;
DECLARE vd_payment_end_dt			DATE;
DECLARE vd_current_service_start_dt	DATE;
DECLARE vd_current_service_end_dt	DATE;
DECLARE vd_rate_start_dt			DATE;
DECLARE vd_rate_end_dt				DATE;
DECLARE vd_min_change_start_dt		DATE;
DECLARE vd_old_start_dt				DATE;
DECLARE vd_start_date				DATE;
DECLARE SKIP_BATCH_RUN integer default 0;
CUR_UNDER_OVER_GAP record;
CUR_SUSPENSION_CHANGES record;
CUR_UNDER_OVER_GAP_refcur REFCURSOR;
CUR_SUSPENSION_CHANGES_refcur REFCURSOR;
 
CUR_GAP_RATES record;
CUR_GAP_RATES_refcur REFCURSOR;
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
begin
	EXCEPTION WHEN OTHERS THEN
    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
     as_error = COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::TEXT) ||'::' || vs_Procedure_nm || '.' ;
     as_error = COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');
     as_error = as_error || COALESCE(vs_message_text ,'');
	
	SELECT SP_BATCH_ERROR_LOG 
		(	vs_Procedure_nm,
			NULL::bigint,
			NULL::bigint,
			NULL::character varying,
			NULL::INTEGER,
			NULL::character varying,
			SQLSTATE::character varying,
			as_error::character varying,
			'finance'::character varying) 
	INTO vl_ret_status;
									 
     as_error := '';
	 return_code:=0;
	 return;
END;	 
--END;
-- Log error

-- Check for Monthly GAP payment batch run (DRAFT Payment) - START 
-- DRAFT Payment must run prior to GAP under/over batch
RAISE NOTICE 'ad_run_dt %',ad_run_dt;
RAISE NOTICE 'ad_run_dt day %',date_part('DAY', ad_run_dt );
RAISE NOTICE 'current_date day %',date_part('DAY', current_date );

IF date_part('DAY', ad_run_dt ) = 1 OR date_part('DAY', current_date) = 1 THEN
	SELECT COUNT(*)
		INTO vl_draft_payment_run
	FROM tb_PAYMENT_RUNTIMES_LOG
	WHERE PAYMENT_TX = 'GS_SUBSIDY_PAYMENT'
		AND DELETE_SW = 'N'
		AND (   DATE(PAYMENT_CURRENT_RUN_TS) = current_date 
				or
			    DATE(PAYMENT_CURRENT_RUN_TS) = ad_run_dt 
			 );

		
	select count(*)
		into vl_gap_payment_cnt 	
	from tb_payment_detail pd,
		 tb_payment_header ph,
		 tb_payment_status ps
	where pd.payment_id = ph.payment_id
		and ph.payment_id = ps.payment_id
		and pd.delete_sw = 'N'
		and ph.delete_sw = 'N'
		and ps.delete_sw = 'N'
		and pd.subsidy_agreement_id > 0
		and ph.payment_type_cd = '7'
		and ( ph.payment_dt = current_date 
			  or
			  ph.payment_dt = ad_run_dt 	
			) ;	
		
	IF vl_draft_payment_run = 0 OR vl_gap_payment_cnt = 0 THEN
		as_error := 'Monthly GAP payment batch must run prior to the GAP under/over batch.' ;
		
		SELECT SP_BATCH_ERROR_LOG 
			(	vs_Procedure_nm,
				NULL::bigint,
				NULL::bigint,
				NULL::character varying,
				NULL::INTEGER,
				NULL::character varying,
				SQLSTATE::character varying,
				as_error::character varying,
				'finance'::character varying
			   ) 
		INTO vl_ret_status;
									   
		--GOTO SKIP_BATCH_RUN;
		SKIP_BATCH_RUN:=1;
		al_sqlcode :=0;
		--RETURN 0;
	END IF;
END IF;	
	 
	
-- Check for Monthly GAP payment batch run (DRAFT Payment) - END

-- Get previous month last day based on input date
if(SKIP_BATCH_RUN=0) then
SELECT (date_trunc('month', now())::date - 1)
      
INTO vd_previous_month_end_dt;
    
-- GAP Under/Over main cursor - START
--FOR CUR_UNDER_OVER_GAP AS
	--cur1 CURSOR WITH HOLD FOR
	OPEN CUR_UNDER_OVER_GAP_refcur FOR
	SELECT GS.GUARDIAN_SUBSIDY_ID, 
			GS.PROVIDER_ID,
			GS.CLIENT_ID,
			GS.SUBSIDY_START_DT,
			GS.SUBSIDY_END_DT,
			 F_PRIM_COUNTY(GS.CASE_ID,'NULL',GS.CLIENT_ID,'CLIENT') AS COUNTY_CD,
			GR.RATE_START_DT AS CHANGE_START_DT, 
			GR.RATE_END_DT AS CHANGE_END_DT,
			'RATE_CHANGES' AS TRAN_TYPE,
			GR.gapagreementrateid AS PARENT_KEY_ID
		FROM tb_GAP_RATES GR,
			 tb_GUARDIAN_SUBSIDY GS
	WHERE GR.ASSISTANCE_ID = GS.GUARDIAN_SUBSIDY_ID
		AND GR.DELETE_SW = 'N'
		AND GS.DELETE_SW = 'N'
		/*AND GR.GAP_RATE_ID IN ( SELECT GRR.GAP_RATE_ID 
									FROM tb_GAP_RATES_REVISION GRR
								WHERE GRR.DELETE_SW = 'N'
								   AND COALESCE(GRR.APPROVAL_STATUS_CD, '') = '3047'
								   AND GRR.APPROVAL_DT = ad_run_dt
								   -- for Unit Testing
								   -- AND GRR.GUARDIAN_SUBSIDY_ID = 3406              
								   -- for Unit Testing
							  )	*/
		AND GR.GAP_RATE_ID IN ( SELECT (select alternateid from gapagreementrate where gapagreementrateid=GRR.gaprateid) AS GAP_RATE_ID 
									FROM gapratesrevision GRR
								WHERE GRR.activeflag = 1
								   AND COALESCE(GRR.approvalstatustypekey, '') = '3047'
								   AND GRR.approvaldate::date = ad_run_dt::date
								   AND GRR.gaprateid is not null
								-- CDM-12331   
								union 
								select gr.alternateid
								from gapagreementrevision agr,
									gapagreementrate gr
								where agr.gapagreementid  = gr.gapagreementid 
									and agr.approvalstatustypekey = '3047'
									and agr.approvaldate::date = ad_run_dt::date
									and agr.activeflag  = 1
									and gr.activeflag  = 1   
							  )	
	UNION ALL
	SELECT GS.GUARDIAN_SUBSIDY_ID, 
			GS.PROVIDER_ID,
			GS.CLIENT_ID,
			GS.SUBSIDY_START_DT,
			GS.SUBSIDY_END_DT,
			 F_PRIM_COUNTY(GS.CASE_ID,'NULL',GS.CLIENT_ID,'CLIENT') AS COUNTY_CD,
			-- GSP.START_DT AS CHANGE_START_DT, 
			-- GSP.END_DT AS CHANGE_END_DT,
			GSP.startdate AS CHANGE_START_DT, 
			GSP.enddate AS CHANGE_END_DT,
			(CASE WHEN GSP.suspensionreasontypekey IN ('COHP','DCHD','33427','33424') THEN	
				'SYS_SUSPN_CHANGES' 
			ELSE
				'SUSPENSION_CHANGES' 
			END ) AS TRAN_TYPE,
			GSP.gapsuspensionid AS PARENT_KEY_ID
		-- FROM tb_GUARDIAN_SUBSIDY_SUSPENSION GSP,
		FROM gapsuspension GSP,
			 tb_GUARDIAN_SUBSIDY GS
	WHERE GSP.gapid = GS.gapid
		AND GSP.activeflag = 1
		AND GS.DELETE_SW = 'N'
		AND GSP.startdate is NOT NULL
		AND ( 	GSP.gapsuspensionid IN ( SELECT GSR.suspensionid 
											FROM gapsuspensionrevision GSR
										WHERE GSR.activeflag = 1
										   AND COALESCE(GSR.approvalstatustypekey, '') = '3047'
										   AND GSR.approvaldate::date = ad_run_dt::date
										   and GSR.startdate is NOT NULL
										-- SELECT GSR.SUSPENSION_ID 
										-- 	FROM tb_GAP_SUSPENSION_REVISION GSR
										-- WHERE GSR.DELETE_SW = 'N'
										--    AND COALESCE(GSR.APPROVAL_STATUS_CD, '') = '3047'
										--    AND GSR.APPROVAL_DT = ad_run_dt
										   -- for Unit Testing
										   -- AND GSR.GUARDIAN_SUBSIDY_ID = 3406              
										   -- for Unit Testing
									  )	
				OR
				(	
					-- GSP.REASON_CD IN ('33427','33424')	
					GSP.suspensionreasontypekey IN ('COHP','DCHD','33427','33424')
					AND GSP.updatedon::date = ad_run_dt::date
				)	
			)
		
	ORDER BY 1, TRAN_TYPE;

--DO
 RAISE NOTICE 'before loop>>>>>fetch CUR_UNDER_OVER_GAP_refcur into CUR_UNDER_OVER_GAP';
loop
	fetch CUR_UNDER_OVER_GAP_refcur into CUR_UNDER_OVER_GAP;
										 exit when not found;
     RAISE NOTICE 'inside loop>>>>>fetch CUR_UNDER_OVER_GAP_refcur into CUR_UNDER_OVER_GAP';
	-- INITIAL VALUES
	  vl_months := 0;
	  vl_guardian_subsidy_id := NULL;
	  vl_provider_id := NULL;
	  vs_county_cd := NULL;
	  vl_client_id := NULL;
	  vd_change_start_dt := NULL;
	  vd_change_end_dt := NULL;
	  vd_subsidy_start_dt := NULL;
	  vd_subsidy_end_dt := NULL;
	  vd_org_subsidy_end_dt := NULL;
	  vd_current_service_start_dt := NULL;
	  vd_current_service_end_dt := NULL;
	  vs_change_type := NULL;
	  vl_client_dob_dt := NULL;
	  vl_age := NULL;
	  vdc_tca_amount := 0.00;
	  vl_parent_key_id := NULL;
	  vl_first_susp_change_id := NULL;
	
	  vl_guardian_subsidy_id := CUR_UNDER_OVER_GAP.GUARDIAN_SUBSIDY_ID;
	  vl_provider_id := CUR_UNDER_OVER_GAP.PROVIDER_ID;
	  vs_county_cd := CUR_UNDER_OVER_GAP.COUNTY_CD;
	  vl_client_id := CUR_UNDER_OVER_GAP.CLIENT_ID;
	  vd_change_start_dt := CUR_UNDER_OVER_GAP.CHANGE_START_DT;
	  vd_change_end_dt := CUR_UNDER_OVER_GAP.CHANGE_END_DT;
	  vd_subsidy_start_dt := CUR_UNDER_OVER_GAP.SUBSIDY_START_DT;
	  vd_org_subsidy_end_dt := CUR_UNDER_OVER_GAP.SUBSIDY_END_DT;
	  vs_TRAN_TYPE := CUR_UNDER_OVER_GAP.TRAN_TYPE;
	  vl_parent_key_id := CUR_UNDER_OVER_GAP.PARENT_KEY_ID;
	RAISE NOTICE 'inside loop>>>>>vl_guardian_subsidy_id %',vl_guardian_subsidy_id;
	RAISE NOTICE 'inside loop>>>>>vl_provider_id %',vl_provider_id;
	RAISE NOTICE 'inside loop>>>>>vl_client_id %',vl_client_id;
	RAISE NOTICE 'inside loop>>>>>vd_change_start_dt %',vd_change_start_dt;
	RAISE NOTICE 'inside loop>>>>>vd_change_end_dt %',vd_change_end_dt;
	RAISE NOTICE 'inside loop>>>>>vd_subsidy_start_dt %',vd_subsidy_start_dt;
	RAISE NOTICE 'inside loop>>>>>vd_org_subsidy_end_dt %',vd_org_subsidy_end_dt;

	-- Set Change Type for Fiscal Audit Trail
	IF vs_TRAN_TYPE = 'RATE_CHANGES' THEN
		 vs_change_type := '1011'; --	GAP Rate Changes
	ELSEIF vs_TRAN_TYPE = 'SUSPENSION_CHANGES' THEN -- (manual) 
		 vs_change_type := '1012'; --	GAP Suspension Changes
	ELSE -- SYS_SUSPN_CHANGES (system generated)
		 vs_change_type := '1015'; --	GAP System Generated Suspension Changes
	END IF;
		
	-- GET TCA Amount 
	SELECT COALESCE(TCA_AMOUNT,0.00) as TCA_AMT
		INTO vdc_tca_amount
	FROM tb_GUARDIAN_SUBSIDY 
	WHERE GUARDIAN_SUBSIDY_ID = vl_guardian_subsidy_id	
		AND DELETE_SW = 'N';

	 al_sqlcode := SQLCODE;
	IF al_sqlcode < 0 THEN
		 as_error := 'Error in getting TCA amount'  ;
		 vs_identity_column := 'GAP ID';
		 vs_identity_val := (vl_guardian_subsidy_id)::character varying;
		--SIGNAL p_sp_error  ;
	END IF ;
				
	-- minimum re-calculation start date is MD CHESSIE Finance G0-Live date 01/01/2009
	IF vd_change_start_dt < DATE('2009-01-01') THEN
		 vd_change_start_dt := DATE('2009-01-01');
	END IF;
	
	-- Get the old dates prior to current revision - START
	IF vs_TRAN_TYPE = 'SUSPENSION_CHANGES' THEN
		 vd_min_change_start_dt := vd_change_start_dt;
		
		-- SELECT MIN(GAP_SUSPENSION_REVISION_ID)
		-- 	INTO vl_first_susp_change_id
		-- FROM tb_GAP_SUSPENSION_REVISION
		-- WHERE SUSPENSION_ID = vl_parent_key_id 
		-- 	AND APPROVAL_STATUS_CD = '3047'
		-- 	AND DELETE_SW = 'N' ;
		SELECT gapsuspensionrevisionid
			INTO vl_first_susp_change_id
		FROM gapsuspensionrevision
		WHERE suspensionid = vl_parent_key_id 
			AND activeflag = 1
			and startdate is NOT NULL
			AND COALESCE(approvalstatustypekey, '') = '3047'
			order by startdate limit 1;
		
		 al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			 as_error := 'Error in getting MIN(GAP_SUSPENSION_REVISION_ID) from tb_GAP_SUSPENSION_REVISION'  ;
			 vs_identity_column := 'SUSPENSION_ID';
			 vs_identity_val := (vl_parent_key_id)::character varying;
			--SIGNAL p_sp_error  ;
		END IF ;
			
		--FOR CUR_SUSPENSION_CHANGES AS
		-- OPEN CUR_SUSPENSION_CHANGES_refcur FOR
		-- 	SELECT GAP_SUSPENSION_REVISION_ID
		-- 		FROM tb_GAP_SUSPENSION_REVISION
		-- 	WHERE SUSPENSION_ID = vl_parent_key_id
		-- 		AND DELETE_SW = 'N'
		-- 		AND COALESCE(APPROVAL_STATUS_CD, '') = '3047'
		-- 		AND COALESCE(ORIGINAL_SW, 'N') <> 'Y'
		-- 		AND APPROVAL_DT = ad_run_dt
		-- 	ORDER BY GAP_SUSPENSION_REVISION_ID ;
		OPEN CUR_SUSPENSION_CHANGES_refcur FOR
			SELECT gapsuspensionrevisionid, startdate
				FROM gapsuspensionrevision
			WHERE suspensionid = vl_parent_key_id 
				AND activeflag = 1
				and startdate is NOT NULL
				AND COALESCE(approvalstatustypekey, '') = '3047'
				AND approvaldate = ad_run_dt
			ORDER BY startdate;
		--DO
		 loop
	fetch CUR_SUSPENSION_CHANGES_refcur into CUR_SUSPENSION_CHANGES;
										 exit when not found;

			-- INITIAL VALUES
			 vl_suspension_revision_id := NULL;
			 vl_count := NULL;
			 vd_old_start_dt := NULL;
			 vd_start_date := NULL;
			
			 -- vl_suspension_revision_id := CUR_SUSPENSION_CHANGES.GAP_SUSPENSION_REVISION_ID;
			 vl_suspension_revision_id := CUR_SUSPENSION_CHANGES.gapsuspensionrevisionid;
			 vd_start_date := CUR_SUSPENSION_CHANGES.startdate;

			-- First Suspension Change - check against ORIGINAL_SW = 'Y'
			IF vl_first_susp_change_id = vl_suspension_revision_id THEN 
			-- SELECT START_DT
			-- 		INTO vd_old_start_dt
			-- 	FROM tb_GAP_SUSPENSION_REVISION 	
			-- 	WHERE SUSPENSION_ID = vl_parent_key_id 
			-- 		AND APPROVAL_STATUS_CD = '3047'
			-- 		AND DELETE_SW = 'N' 	
			-- 		AND COALESCE(ORIGINAL_SW, 'N') = 'Y';
				SELECT startdate
					INTO vd_old_start_dt
				FROM gapsuspension 	
				WHERE gapsuspensionid = vl_parent_key_id 
					AND COALESCE(approvalstatustypekey, '') = '3047'
					AND activeflag = 1
					and startdate is not null
					AND startdate::date < vd_start_date::date
					ORDER BY startdate limit 1;
					
				 al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					 as_error := 'Error in getting START_DT from tb_GAP_SUSPENSION_REVISION (ORIGINAL_SW = Y)'  ;
					 vs_identity_column := 'SUSPENSION_ID';
					 vs_identity_val := (vl_parent_key_id)::character varying;
					--SIGNAL p_sp_error  ;
				END IF ;				
			ELSE
				-- SELECT START_DT
				-- 	INTO vd_old_start_dt
				-- FROM tb_GAP_SUSPENSION_REVISION 	
				-- WHERE SUSPENSION_ID = vl_parent_key_id 
				-- 	AND GAP_SUSPENSION_REVISION_ID < vl_suspension_revision_id
				-- 	AND APPROVAL_STATUS_CD = '3047'
				-- 	AND DELETE_SW = 'N' 	
				-- 	AND COALESCE(ORIGINAL_SW, 'N') <> 'Y'
				-- ORDER BY GAP_SUSPENSION_REVISION_ID DESC  
				-- FETCH FIRST ROW ONLY;
				SELECT startdate
					INTO vd_old_start_dt
				FROM gapsuspensionrevision 	
				WHERE suspensionid = vl_parent_key_id 
					AND COALESCE(approvalstatustypekey, '') = '3047'
					and startdate is NOT NULL
					AND activeflag = 1
					AND startdate::date < vd_start_date::date
				ORDER BY startdate limit 1;
				
				 al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					 as_error := 'Error in getting START_DT from tb_GAP_SUSPENSION_REVISION'  ;
					 vs_identity_column := 'GAP_SUSPENSION_REVISION_ID';
					 vs_identity_val := (vl_suspension_revision_id)::character varying;
					--SIGNAL p_sp_error  ;
				END IF ;				
			END IF;
			
			IF vd_old_start_dt IS NOT NULL THEN
				IF vd_old_start_dt < vd_min_change_start_dt THEN
					 vd_min_change_start_dt := vd_old_start_dt;
				END IF;
			END IF;
			
		--END FOR;	
		END LOOP;
		close CUR_SUSPENSION_CHANGES_refcur;
	ELSEIF vs_TRAN_TYPE = 'SYS_SUSPN_CHANGES' THEN 	
		-- For system generated suspensions always re-calculate starting from GAP Agreement Start Date
		-- As CHESSIE is not maintaining suspension date change history for system generated suspension
		 vd_min_change_start_dt := vd_subsidy_start_dt;--
	END IF;
	-- Get the old dates prior to current revision - END
	
	-- Set the change start date and end date - START
	IF vs_TRAN_TYPE = 'SUSPENSION_CHANGES' OR vs_TRAN_TYPE = 'SYS_SUSPN_CHANGES'  THEN
		IF vd_min_change_start_dt < vd_change_start_dt THEN
			 vd_change_start_dt := vd_min_change_start_dt;
		END IF;
		
		-- minimum re-calculation start date is MD CHESSIE Finance G0-Live date 01/01/2009
		IF vd_change_start_dt < DATE('2009-01-01') THEN
			 vd_change_start_dt := DATE('2009-01-01');
		END IF;
		
		-- Always re-calculate payments up to current - 1 month
		 vd_change_end_dt := vd_previous_month_end_dt;
	ELSE
		-- for vd_change_end_dt > current - 1 month then re-calculate up to current - 1 month
		IF vd_change_end_dt > vd_previous_month_end_dt THEN
			 vd_change_end_dt := vd_previous_month_end_dt;
		END IF;
	END IF;
	-- Set the change start date and end date - END
	
	-- Calculate the no of months to re-calculate payments	
	 vs_change_end_dt := RTRIM(TO_CHAR(vd_change_end_dt,'YYYY-MM-DD'));
	 vs_change_start_dt := RTRIM(TO_CHAR(vd_change_start_dt,'YYYY-MM-DD'));
	
	SELECT F_MONTHS_BETWEEN (vd_change_end_dt, vd_change_start_dt) + 1 
		INTO vl_months;
	--FROM SYSIBM.SYSDUMMY1; 
			RAISE NOTICE 'F_MONTHS_BETWEEN>>>>>>>vl_months %',vl_months;

	-- Verify if change start date is greater than previous month end date - DO NOT re-calculate payments for under/over
	IF vd_change_start_dt > vd_previous_month_end_dt THEN
		 vl_months := 0;
	END IF;
	--WHILE vl_months > 0 
	--DO
	loop EXIT WHEN vl_months < 0::bigint ;
		-- Calculate Current Service month dates 
		SELECT  F_DAYMONTH(vd_change_start_dt,'F','C'),
				 F_DAYMONTH(vd_change_start_dt,'L','C')
	   	INTO  vd_current_month_start_dt,
			  vd_current_month_end_dt;
		--FROM SYSIBM.SYSDUMMY1;
	
		-- Calculate GAP under/over up to previous month - START
		IF vd_current_month_start_dt < vd_previous_month_end_dt THEN
		
			-- Re-calculate Subsidy end date and get Cleint's DOB & Age
			SELECT 	( CASE WHEN f_age(CL.dob::DATE,vd_current_month_end_dt) = 21 
						AND ( (CL.dob::DATE +interval '21 year' ) < vd_org_subsidy_end_dt OR vd_org_subsidy_end_dt is NULL) THEN
							CL.dob::DATE + interval '21 year'	
					  ELSE
							vd_org_subsidy_end_dt
					  END ) AS SUBSIDY_END_DT,
					  CL.dob::DATE,
					   F_AGE(CL.dob::DATE, vd_current_month_end_dt )
				INTO vd_subsidy_end_dt,
					 vl_client_dob_dt,
					 vl_age
			FROM person CL
			WHERE CL.cjamspid = vl_client_id
				AND CL.activeflag = 1;
			
			 al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				 as_error := 'Error in getting Client details'  ;
				 vs_identity_column := 'Client ID';
				 vs_identity_val := (vl_client_id)::character varying;
				--SIGNAL p_sp_error  ;
			END IF ;

			-- Process GAP payment upto client's 21 birthday - START
			IF vl_client_dob_dt IS NOT NULL
					AND vl_age < 21 
							OR ( date_part('month',vl_client_dob_dt + interval '21 year') = date_part('MONTH',vd_current_month_end_dt)
									AND date_part('YEAR',vl_client_dob_dt + interval '21 year') = date_part('YEAR',vd_current_month_end_dt)
									AND date_part('DAY',vl_client_dob_dt + interval '21 year') <> 1  
								) THEN
			
				-- INITIAL VALUES
				 vdc_gross_amount := 0;
				 vdc_payment_amount := 0; 
				 vdc_per_diem_rate := 0;
				 vl_unit_no := 0;
				 vl_suspension_days := 0;
				 vs_unit_type := NULL;

				-- GET GAP PAYMENT AMOUNT & RATE
				SELECT  COALESCE(GR.PAYMENT_AMT,0) AS PAYMENT_AMT,
						CAST(ROUND(( GR.PAYMENT_AMT * 12 ) /365, 2) AS DECIMAL (10,2)) AS PER_DIEM_RATE
					INTO vdc_payment_amount,
						 vdc_per_diem_rate
				FROM tb_GAP_RATES GR
				WHERE GR.ASSISTANCE_ID = vl_guardian_subsidy_id	
					AND GR.DELETE_SW = 'N'
					AND GR.APPROVAL_STATUS_CD = '3047'
					AND GR.GAP_RATE_ID = (SELECT MAX(GR1.GAP_RATE_ID)
											FROM tb_GAP_RATES GR1
										  WHERE GR1.ASSISTANCE_ID = GR.ASSISTANCE_ID	
											AND GR1.APPROVAL_STATUS_CD = '3047'
											AND GR1.RATE_START_DT <= vd_current_month_end_dt
											AND GR1.RATE_END_DT >= vd_current_month_start_dt
											-- AND (CASE WHEN GR1.OVERRIDE_STATUS_CD IN ('3045','3046') 		
											--		AND GR1.RATE_OVERRIDE_SW = 'Y' THEN 
											--		GR1.RATE2_END_DT 
											--	ELSE 	
											--		GR1.RATE_END_DT 
											--	 END) >= vd_current_month_start_dt
										  ) ;
		
				 al_sqlcode := SQLCODE;
				IF al_sqlcode < 0 THEN
					 as_error := 'Error in getting previously paid amount'  ;
					 vs_identity_column := 'GAP ID';
					 vs_identity_val := (vl_guardian_subsidy_id)::character varying;
					--SIGNAL p_sp_error  ;
				END IF ;
				
				
				-- Differentiate Payments prior to / later on  2009-08-31 - START
				IF vd_current_month_end_dt <= DATE('2009-08-31') THEN -- Monthly Rate
					IF vdc_payment_amount > 0 THEN
						--- HOW MUCH WE WERE SUPPOSE TO PAY (MONTHLY) - START
						 vdc_gross_amount := vdc_payment_amount;
						-- Get actual no of nights for Suspension calculation
						SELECT a.ad_service_start_dt,
								a.ad_service_end_dt,
								a.al_unit_no,
								a.as_unit_type from SP_FOSTERCARE_CALCULATION('P',
															'R',	
															0,
															vd_subsidy_start_dt,
															vd_subsidy_end_dt,
															vd_current_month_start_dt,
															vd_current_month_end_dt) a into
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vl_unit_no,
															vs_unit_type;
															
						-- Calculate Suspension period
						SELECT a.al_suspension_days from SP_SUSPENSION_CALCULATION ('G',
																vl_guardian_subsidy_id,
																vd_subsidy_start_dt,
																vd_subsidy_end_dt,
																vd_current_month_start_dt,
																vd_current_month_end_dt,
																vd_current_service_start_dt,
																vd_current_service_end_dt,
																vl_unit_no) a INTO
																vl_suspension_days;

						IF vl_suspension_days IS NULL THEN
							 vl_suspension_days := 0;
						END IF;		
						
						-- Exclude amount for Suspension period
						IF vl_suspension_days > 0 THEN
							 vdc_suspension_amount := vl_suspension_days * vdc_per_diem_rate;
							IF vdc_suspension_amount > 0 THEN
								 vdc_gross_amount := vdc_gross_amount - vdc_suspension_amount;
							END IF;
						END IF;												

						-- Check for TCA amount - START 
						IF vdc_gross_amount > 0 AND vdc_tca_amount > 0 THEN
							-- 05/07/2021
							-- IF MONTH(vd_current_month_start_dt) = MONTH(vd_subsidy_start_dt) THEN
							--	IF YEAR(vd_current_month_start_dt) = YEAR(vd_subsidy_start_dt) THEN
							IF date_part('month', vd_current_month_start_dt ) = date_part('month', vd_subsidy_start_dt) THEN
								IF date_part('year', vd_current_month_start_dt ) = date_part('year', vd_subsidy_start_dt) THEN
									IF vdc_tca_amount >= vdc_gross_amount THEN
										 vdc_gross_amount := 0.00;
									ELSE
										 vdc_gross_amount := vdc_gross_amount - vdc_tca_amount;
									END IF;
								END IF;
							END IF;
						END IF;	
						-- Check for TCA amount - END						
						
						 vl_unit_no := 1;
						 vs_unit_type := '5611'; -- monthly
						 vdc_per_diem_rate := vdc_payment_amount;			
						--- HOW MUCH WE WERE SUPPOSE TO PAY (MONTHLY) - END
						
						--- CHECK CURRENT BALANCE - START
						 vdc_current_balance := 0;
						 vl_linked_pymnt_hdr_id := NULL; -- INITIAL VALUE
						 vl_reference_payment_detail_id := NULL; -- INITIAL VALUE
						
						SELECT a.al_linked_pymnt_hdr_id,a.al_reference_payment_detail_id,a.adc_current_balance,a.al_sqlcode,a.as_error FROM SP_GET_CURRENT_BALANCE(vl_guardian_subsidy_id,
															vd_current_service_start_dt,
															vd_current_service_end_dt,
															vs_room_board,
															vd_current_month_start_dt,
															vl_rate_structure_id) a into
															vl_linked_pymnt_hdr_id,
															vl_reference_payment_detail_id,
															vdc_current_balance,
															al_sqlcode,
															as_error;

						IF al_sqlcode <> 0 THEN
						    as_error := as_error  ;
						   IF as_error is NULL OR as_error = '' THEN
							   as_error := 'SP_GET_CURRENT_BALANCE failed - GAP ADJ (Monthly Rate) NOT CREATED'  ;
						   END IF;
						   --SIGNAL p_sp_error  ;
						END IF ;

						IF vl_linked_pymnt_hdr_id = 0 THEN
						    vl_linked_pymnt_hdr_id := NULL;
						    vl_reference_payment_detail_id := NULL;
						END IF;
						--- CHECK CURRENT BALANCE - END
						
						-- PAYABLE / RECEIVABLE - START
						-- IF To Pay and Current Balance are same, DO NOTHING		
						IF vdc_gross_amount = vdc_current_balance THEN
							-- DO NOTHING
						ELSEIF vdc_gross_amount > vdc_current_balance THEN -- Payable
							-- CHECK ADJUSTMENT CREATED ON THAT DAY - START	
							 vl_adjust_payment_id := 0; -- INITIAL VALUE

							SELECT MIN(PH.PAYMENT_ID)
								INTO vl_adjust_payment_id
							FROM tb_PAYMENT_HEADER PH,
								tb_PAYMENT_DETAIL PD
							WHERE  PH.PAYMENT_ID = PD.PAYMENT_ID
								AND PH.PROVIDER_ID = vl_provider_id
								AND PH.PAYMENT_DT = CURRENT_DATE
								AND PH.PAYMENT_TYPE_CD = '3294'
								AND PD.SUBSIDY_AGREEMENT_ID IS NOT NULL
								AND PH.MANUAL_SW = 'N'
								AND PH.DELETE_SW = 'N'
								AND PD.DELETE_SW = 'N'
								-- AND MONTH(PH.PAYMENT_START_DT) = MONTH(vd_current_month_start_dt)
								-- AND YEAR(PH.PAYMENT_START_DT) = YEAR(vd_current_month_start_dt)
								AND date_part('month',PH.PAYMENT_START_DT) = date_part('month', vd_current_month_start_dt)
								AND date_part('year',PH.PAYMENT_START_DT) = date_part('year', vd_current_month_start_dt)
								AND PD.COUNTY_CD =  vs_county_cd
								AND PD.CLIENT_ID = vl_client_id ;

							IF vl_adjust_payment_id IS NULL THEN
								 vl_adjust_payment_id := 0;	
							END IF;
							-- CHECK ADJUSTMENT CREATED ON THAT DAY - START	
							
							IF vl_adjust_payment_id = 0 or vl_adjust_payment_id is NULL THEN
								SELECT  a.al_header_id, a.al_sqlcode,a.as_error 
									from SP_PAYMENT_HEADER_INSERT(	vl_provider_id,
															vs_payment_type,
															vd_current_month_start_dt,
															vd_current_month_end_dt) a into
															vl_payment_id, 
															al_sqlcode, 
															as_error;
								/*							
								SELECT SP_PAYMENT_HEADER_INSERT( vl_provider_id,
																 vs_payment_type,
																 vd_current_month_start_dt,
																 vd_current_month_end_dt,
																 vl_payment_id, 
																 al_sqlcode, 
																 as_error 
															  );
								*/							  
								IF al_sqlcode <> 0 THEN
									 as_error := as_error  ;
									IF as_error is NULL OR as_error = '' THEN
										 as_error := 'SP_PAYMENT_HEADER_INSERT failed - GAP ADJ (Monthly Rate) NOT CREATED'  ;
									END IF;
									--SIGNAL p_sp_error  ;
								END IF ;
							ELSE
								 vl_payment_id := vl_adjust_payment_id;
							END IF;
									
							-- CREATE SYSTEM ADJUSTMENT FOR THE DIFF
							 vdc_gross_amount := vdc_gross_amount - vdc_current_balance;
							
							-- CREATE PAYMENT DETAIL ID AND INSERT RECORD IN PAYMENT DETAIL
							SELECT a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(	vl_guardian_subsidy_id,
																	vl_payment_id,
																	vl_rate_structure_id,
																	vd_current_service_start_dt,
																	vd_current_service_end_dt,
																	vdc_gross_amount,
																	vl_unit_no,
																	vs_unit_type,
																	vdc_per_diem_rate,
																	vs_payment_flag,
																	vs_room_board,
																	vl_linked_pymnt_hdr_id,
																	vl_reference_payment_detail_id,
																	vs_change_type) a into
																	al_sqlcode,
																	as_error;

							
							IF al_sqlcode <> 0 THEN
								 as_error := as_error  ;
								IF as_error is NULL OR as_error = '' THEN
									 as_error := 'SP_PAYMENT_DETAIL_INSERT failed - GAP ADJ (Monthly Rate) NOT CREATED'  ;
								END IF;
								--SIGNAL p_sp_error ;
							END IF ;
							
							-- UPDATING HEADER TABLE - START
							UPDATE tb_PAYMENT_HEADER
								SET GROSS_AMOUNT_NO = (SELECT SUM(FINAL_AMOUNT_NO) 
															FROM tb_PAYMENT_DETAIL 
														WHERE PAYMENT_ID = vl_payment_id 
															AND DELETE_SW = 'N' )
							WHERE PAYMENT_ID = vl_payment_id;

							 al_sqlcode := SQLCODE;
							IF al_sqlcode <> 0 THEN
								 as_error := 'Error in Updating PAYMENT HEADER GAP ADJ (Monthly Rate) - Gross Amount'  ;
								 vs_identity_column := 'Payment ID';
								 vs_identity_val := (vl_payment_id)::character varying;
								--SIGNAL p_sp_error  ;
							END IF ;
							-- UPDATING HEADER TABLE - END			
							
						ELSE -- Receivable
							 vdc_receivable_amount := vdc_current_balance - vdc_gross_amount ;
							 vl_payment_detail_id := 0; -- INITIAL VALUE	
						
							IF vl_reference_payment_detail_id is NOT NULL AND vl_reference_payment_detail_id > 0 THEN
							    vl_payment_detail_id := vl_reference_payment_detail_id;
							END IF;

							IF vl_payment_detail_id = 0 OR vl_payment_detail_id is NULL THEN
								 as_error := 'No PAYMENT_DETAIL_ID found for Receivable. (GAP - Monthly Rate)'  ;
								 vs_identity_column := 'GAP ID';
								 vs_identity_val := (vl_guardian_subsidy_id)::character varying;
								--SIGNAL p_sp_error  ;
							END IF ;

						   SELECT a.al_sqlcode,a.as_error from SP_OVER_PAYMENT (vl_payment_detail_id,
														 vl_client_id,
														 vl_provider_id,
														 vd_current_service_start_dt,
														 vd_current_service_end_dt,
														 vdc_receivable_amount,
														 vs_change_type) a into
														 al_sqlcode,
														 as_error;

							IF al_sqlcode <> 0 THEN
							   as_error := as_error  ;
							  IF as_error is NULL OR as_error = '' THEN
								  as_error := 'SP_OVER_PAYMENT failed - GAP (Monthly Rate)'  ;
							  END IF;
							  --SIGNAL p_sp_error ;
							END IF ;
						END IF;
						-- PAYABLE / RECEIVABLE - END
					END IF;	
				ELSE -- > DATE('2009-08-31') - Per Diem Rate
				
					--- HOW MUCH WE WERE SUPPOSE TO PAY (Per Diem Rate) - START
					-- Get actual service period & no of nights
					SELECT a.ad_service_start_dt,
								a.ad_service_end_dt,
								a.al_unit_no,
								a.as_unit_type from  SP_FOSTERCARE_CALCULATION('P',
														'R',	
														0,
														vd_subsidy_start_dt,
														vd_subsidy_end_dt,
														vd_current_month_start_dt,
														vd_current_month_end_dt)a into
														vd_current_service_start_dt,
														vd_current_service_end_dt,
														vl_unit_no,
														vs_unit_type;
				
					-- INITIAL VALUE
					 vdc_gross_amount := 0;
				
					--EXIT_LOOP:
					--FOR CUR_GAP_RATES AS
					
					--Get Count for Ageout Calculation
					vl_rate_slab_count := 0;
					
					SELECT COUNT(*) 
					INTO 
						vl_rate_slab_count 
					FROM 
						tb_GAP_RATES GR
					WHERE 
						GR.ASSISTANCE_ID = vl_guardian_subsidy_id
						AND GR.APPROVAL_STATUS_CD = '3047'
						AND GR.RATE_START_DT <= vd_current_service_end_dt
						AND GR.RATE_END_DT >= vd_current_service_start_dt;
					
					-- INITIAL VALUE
					vl_total_payment_unit_no = 0; -- CDM-2935
					
					OPEN CUR_GAP_RATES_refcur FOR
						SELECT GR.PAYMENT_AMT AS PAYMENT_AMOUNT_NO,
							CAST(ROUND(( GR.PAYMENT_AMT * 12 ) /365, 2) AS DECIMAL (10,2)) AS PER_DIEM_RATE,
							GR.RATE_START_DT,
							GR.RATE_END_DT
						FROM tb_GAP_RATES GR
						WHERE GR.ASSISTANCE_ID = vl_guardian_subsidy_id
							AND GR.APPROVAL_STATUS_CD = '3047'
							AND GR.RATE_START_DT <= vd_current_service_end_dt
							AND GR.RATE_END_DT >= vd_current_service_start_dt
						ORDER BY GR.GAP_RATE_ID DESC;	
					--DO
					loop
					fetch CUR_GAP_RATES_refcur into CUR_GAP_RATES;
										 exit when not found;

						-- INITIAL VALUES
						 vdc_payment_amount := 0; 
						 vdc_per_diem_rate := 0;
						 vd_rate_start_dt := NULL;
						 vd_rate_end_dt := NULL;
						 vl_payment_unit_no := 0;
						 vs_payment_unit_type := NULL;
						 vl_suspension_days := 0;
						
						 vdc_per_diem_rate := CUR_GAP_RATES.PER_DIEM_RATE;
						 vd_rate_start_dt := CUR_GAP_RATES.RATE_START_DT;
						 vd_rate_end_dt := CUR_GAP_RATES.RATE_END_DT;
			
						SELECT a.ad_service_start_dt,
								a.ad_service_end_dt,
								a.al_unit_no,
								a.as_unit_type from SP_FOSTERCARE_CALCULATION('P',
															'R',	
															0,
															vd_rate_start_dt,
															vd_rate_end_dt,
															vd_current_service_start_dt,
															vd_current_service_end_dt)a into
															vd_payment_start_dt,
															vd_payment_end_dt,
															vl_payment_unit_no,
															vs_payment_unit_type;							
															
						-- Add 1 day if rate end date month/year is same as service month/year
						IF date_part('MONTH',vd_rate_end_dt) = date_part('MONTH',vd_current_service_start_dt) 
							AND date_part('YEAR',vd_rate_end_dt) = date_part('YEAR',vd_current_service_start_dt) THEN
							
							-- Verify if GAP end date is beyond rate end date
							IF vd_subsidy_end_dt > vd_rate_end_dt THEN
								 vl_payment_unit_no := vl_payment_unit_no + 1;
							END IF;	
						END IF;
						
						
						IF vl_payment_unit_no > vl_unit_no THEN		
							 vl_payment_unit_no := vl_unit_no;
							
							SELECT vd_payment_start_dt + (vl_unit_no - 1 ) DAYS
								INTO vd_payment_end_dt;
						--	FROM SYSIBM.SYSDUMMY1;	
							
						END IF;			
						
						vl_unit_no := vl_unit_no - vl_payment_unit_no ;
						vl_rate_slab_count := vl_rate_slab_count -1;
				
						--Ageout Calculation when client turns 18 or 21 on the same date as Subsidy End Date
						IF vl_unit_no <= 0 OR vl_rate_slab_count <= 0 THEN
							vl_ageout_unit_no := 0;
							raise notice 'Inside rate cursor - Rate start date %',vd_current_service_start_dt;
							raise notice 'Inside rate cursor - GAP ID %',vl_guardian_subsidy_id;
							
							SELECT sp_subsidy_ageout_calculation
							INTO 
								vl_ageout_unit_no
							FROM
								cjams.sp_subsidy_ageout_calculation('G', vl_guardian_subsidy_id::bigint, vd_current_service_start_dt::date);
							
							IF vl_ageout_unit_no > 0 THEN
								vl_payment_unit_no := vl_payment_unit_no + vl_ageout_unit_no;
							END IF;
								
						END IF;
						
						vdc_payment_amount := vl_payment_unit_no * vdc_per_diem_rate;
						
						IF vdc_payment_amount > 0 THEN
							-- Calculate Suspension period
							SELECT a.al_suspension_days from  SP_SUSPENSION_CALCULATION ('G',
																	vl_guardian_subsidy_id,
																	vd_subsidy_start_dt,
																	vd_subsidy_end_dt,
																	vd_rate_start_dt,
																	vd_rate_end_dt,
																	vd_payment_start_dt,
																	vd_payment_end_dt,
																	vl_payment_unit_no)a into
																	vl_suspension_days;

							IF vl_suspension_days IS NULL THEN
								 vl_suspension_days := 0;
							END IF;
							
							-- Exclude amount for Suspension period
							IF vl_suspension_days > 0 THEN
								 vdc_suspension_amount := vl_suspension_days * vdc_per_diem_rate;
								IF vdc_suspension_amount > 0 THEN
									 vdc_payment_amount := vdc_payment_amount - vdc_suspension_amount;
								END IF;
							END IF;								
						END IF;		
						
						IF vdc_payment_amount > 0 THEN
							 vdc_gross_amount := vdc_gross_amount + vdc_payment_amount ;
						END IF;
						
						vl_total_payment_unit_no := vl_total_payment_unit_no + vl_payment_unit_no ;  -- CDM-2935
						-- vl_unit_no := vl_unit_no - vl_payment_unit_no ;
						IF vl_unit_no <= 0 THEN
							--LEAVE EXIT_LOOP;
							EXIT;
						END IF;
					--END FOR;		
					END LOOP;
					close CUR_GAP_RATES_refcur;
					
					-- Check for TCA amount - START 
					IF vdc_gross_amount > 0 AND vdc_tca_amount > 0 THEN
						IF date_part('MONTH',vd_current_month_start_dt) = date_part('MONTH',vd_subsidy_start_dt) THEN
							IF date_part('YEAR',vd_current_month_start_dt) = date_part('YEAR',vd_subsidy_start_dt) THEN
								IF vdc_tca_amount >= vdc_gross_amount THEN
									 vdc_gross_amount := 0.00;
								ELSE
									 vdc_gross_amount := vdc_gross_amount - vdc_tca_amount;
								END IF;
							END IF;
						END IF;
					END IF;	
					-- Check for TCA amount - END
					
					--- HOW MUCH WE WERE SUPPOSE TO PAY (Per Diem Rate) - START
					
					--- CHECK CURRENT BALANCE - START
					 vdc_current_balance := 0;
					 vl_linked_pymnt_hdr_id := NULL; -- INITIAL VALUE
					 vl_reference_payment_detail_id := NULL; -- INITIAL VALUE

					SELECT a.al_linked_pymnt_hdr_id,a.al_reference_payment_detail_id,a.adc_current_balance,a.al_sqlcode,a.as_error FROM SP_GET_CURRENT_BALANCE(vl_guardian_subsidy_id,
														-- vd_payment_start_dt,
														-- vd_payment_end_dt,
														vd_current_service_start_dt,
														vd_current_service_end_dt,
														vs_room_board,
														vd_current_month_start_dt,
														vl_rate_structure_id)a into
														vl_linked_pymnt_hdr_id,
														vl_reference_payment_detail_id,
														vdc_current_balance,
														al_sqlcode,
														as_error;

					IF al_sqlcode <> 0 THEN
					    as_error := as_error  ;
					   IF as_error is NULL OR as_error = '' THEN
						   as_error := 'SP_GET_CURRENT_BALANCE failed - GAP ADJ NOT CREATED'  ;
					   END IF;
					   --SIGNAL p_sp_error  ;
					END IF ;

					IF vl_linked_pymnt_hdr_id = 0 THEN
					    vl_linked_pymnt_hdr_id := NULL;
					    vl_reference_payment_detail_id := NULL;
					END IF;
					--- CHECK CURRENT BALANCE - END

					-- PAYABLE / RECEIVABLE - START
					-- IF To Pay and Current Balance are same, DO NOTHING		
					IF vdc_gross_amount = vdc_current_balance THEN
						-- DO NOTHING
					ELSEIF vdc_gross_amount > vdc_current_balance THEN -- Payable
						-- CHECK ADJUSTMENT CREATED ON THAT DAY - START	
						 vl_adjust_payment_id := 0; -- INITIAL VALUE

						SELECT MIN(PH.PAYMENT_ID)
							INTO vl_adjust_payment_id
						FROM tb_PAYMENT_HEADER PH,
							tb_PAYMENT_DETAIL PD
						WHERE  PH.PAYMENT_ID = PD.PAYMENT_ID
							AND PH.PROVIDER_ID = vl_provider_id
							AND PH.PAYMENT_DT = CURRENT_DATE
							AND PH.PAYMENT_TYPE_CD = '3294'
							AND PD.SUBSIDY_AGREEMENT_ID IS NOT NULL
							AND PH.MANUAL_SW = 'N'
							AND PH.DELETE_SW = 'N'
							AND PD.DELETE_SW = 'N'
							AND date_part('MONTH',PH.PAYMENT_START_DT) = date_part('MONTH',vd_current_month_start_dt)
							AND date_part('YEAR',PH.PAYMENT_START_DT) = date_part('YEAR',vd_current_month_start_dt)
							AND PD.COUNTY_CD =  vs_county_cd
							AND PD.CLIENT_ID = vl_client_id ;

						IF vl_adjust_payment_id IS NULL THEN
							 vl_adjust_payment_id := 0;	
						END IF;
						-- CHECK ADJUSTMENT CREATED ON THAT DAY - START	
						
						IF vl_adjust_payment_id = 0 or vl_adjust_payment_id is NULL THEN
							SELECT  a.al_header_id,a.al_sqlcode,a.as_error from SP_PAYMENT_HEADER_INSERT(	vl_provider_id,
															vs_payment_type,
															vd_current_month_start_dt,
															vd_current_month_end_dt) a into
															vl_payment_id, 
															al_sqlcode, 
															as_error;
														  
							IF al_sqlcode <> 0 THEN
								 as_error := as_error  ;
								IF as_error is NULL OR as_error = '' THEN
									 as_error := 'SP_PAYMENT_HEADER_INSERT failed - GAP ADJ NOT CREATED'  ;
								END IF;
								--SIGNAL p_sp_error  ;
							END IF ;
						ELSE
							 vl_payment_id := vl_adjust_payment_id;
						END IF;
								
						-- CREATE SYSTEM ADJUSTMENT FOR THE DIFF
						 vdc_gross_amount:= vdc_gross_amount - vdc_current_balance;
						
						-- CREATE PAYMENT DETAIL ID AND INSERT RECORD IN PAYMENT DETAIL
						SELECT  a.al_sqlcode, a.as_error from SP_PAYMENT_DETAIL_INSERT(	vl_guardian_subsidy_id,
																vl_payment_id,
																vl_rate_structure_id,
																-- vd_payment_start_dt,
																-- vd_payment_end_dt,
																vd_current_service_start_dt,
																vd_current_service_end_dt,
																vdc_gross_amount,
																vl_total_payment_unit_no, -- vl_payment_unit_no, -- CDM-2935
																vs_payment_unit_type,
																vdc_per_diem_rate,
																vs_payment_flag,
																vs_room_board,
																vl_linked_pymnt_hdr_id,
																vl_reference_payment_detail_id,
																vs_change_type) a into
																al_sqlcode,
																as_error;

						
						IF al_sqlcode <> 0 THEN
							 as_error := as_error  ;
							IF as_error is NULL OR as_error = '' THEN
								 as_error := 'SP_PAYMENT_DETAIL_INSERT failed - GAP ADJ NOT CREATED'  ;
							END IF;
							--SIGNAL p_sp_error;
						END IF ;
						
						-- UPDATING HEADER TABLE - START
						UPDATE tb_PAYMENT_HEADER
							SET GROSS_AMOUNT_NO = (SELECT SUM(FINAL_AMOUNT_NO) 
														FROM tb_PAYMENT_DETAIL 
													WHERE PAYMENT_ID = vl_payment_id 
														AND DELETE_SW = 'N' )
						WHERE PAYMENT_ID = vl_payment_id;

						 al_sqlcode := SQLCODE;
						IF al_sqlcode <> 0 THEN
							 as_error := 'Error in Updating PAYMENT HEADER GAP ADJ - Gross Amount'  ;
							 vs_identity_column := 'Payment ID';
							 vs_identity_val := (vl_payment_id)::character varying;
							--SIGNAL p_sp_error  ;
						END IF ;
						-- UPDATING HEADER TABLE - END		
						
					ELSE -- Receivable
						 vdc_receivable_amount := vdc_current_balance - vdc_gross_amount ;
						 vl_payment_detail_id := 0; -- INITIAL VALUE	

						IF vl_reference_payment_detail_id is NOT NULL AND vl_reference_payment_detail_id > 0 THEN
						    vl_payment_detail_id := vl_reference_payment_detail_id;
						END IF;

						IF vl_payment_detail_id = 0 OR vl_payment_detail_id is NULL THEN
							 as_error := 'No PAYMENT_DETAIL_ID found for Receivable. (GAP SUBSIDY)'  ;
							 vs_identity_column := 'GAP ID';
							 vs_identity_val := (vl_guardian_subsidy_id)::character varying;
							--SIGNAL p_sp_error  ;
						END IF ;

					   SELECT a.al_sqlcode,a.as_error from SP_OVER_PAYMENT (	vl_payment_detail_id,
														vl_client_id,
														vl_provider_id,
														-- vd_payment_start_dt,
														-- vd_payment_end_dt,
														vd_current_service_start_dt,
														vd_current_service_end_dt,
														vdc_receivable_amount,
														vs_change_type)a into
														al_sqlcode,
														as_error;

						IF al_sqlcode <> 0 THEN
						   as_error := as_error  ;
						  IF as_error is NULL OR as_error = '' THEN
							  as_error := 'SP_OVER_PAYMENT failed - GAP'  ;
						  END IF;
						  --SIGNAL p_sp_error ;
						END IF ;
					END IF;
					-- PAYABLE / RECEIVABLE - END
				END IF;
				-- Differentiate Payments prior to / later on  2009-08-31 - END
			END IF;
			-- Process GAP payment upto client's 21 birthday - END
		END IF;
		-- Calculate GAP under/over up to previous month - END
		
		-- Set next month 
		 vd_change_start_dt := vd_change_start_dt + interval '1 month'  ;	
		 vl_months := vl_months - 1;
	--END WHILE;
	END LOOP;
	
	--COMMIT;
--END FOR;
END LOOP;
close CUR_UNDER_OVER_GAP_refcur;
-- GAP Under/Over main cursor - END

SELECT a.al_sqlcode,a.as_error from SP_SUSBSIDY_RECEIVABLES('G', ad_run_dt) a into al_sqlcode, as_error;
IF al_sqlcode <> 0 THEN
   as_error := as_error  ;
  IF as_error is NULL OR as_error = '' THEN
	  as_error := 'SP_SUSBSIDY_RECEIVABLES failed - GAP'  ;
  END IF;
  --SIGNAL p_sp_error ;
END IF ;

	

ELSE 
SKIP_BATCH_RUN=0;
END IF;

--COMMIT;
--SKIP_BATCH_RUN:

--RETURN 0;
 return_code:=1;
	 return;
END
;

$function$
;
