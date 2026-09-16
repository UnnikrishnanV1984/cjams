Drop function if exists cjams.sp_placement_validation_creation();

CREATE OR REPLACE FUNCTION cjams.sp_placement_validation_creation(	OUT retrun_code integer, 
																	OUT al_sqlcode integer, 
																	OUT as_mess character varying
																 )
 RETURNS record
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Amit Rastogi
-- Date Created :04/12/2004
-- generating placement validation records for all open ended placement for
-- the last month
-- EXCLUDE SPLIT CONVERTED PLACEMENT FOR PLACEMENT VALIDATION - #7521
-- 05/27/2009 Vineet Tirodkar - Error Fix: To create Placement validation records for 
--            the placements with Entry date as last day of the month and created on last day of the month.
-- 07/25/2012 Vineet Tirodkar PRJ-02667 - MD CHESSIE Batch Process Redesign - To change Return 0 on success
-- 06/02/2020 Vineet Tirodkar - To delete placement validation records with no draft payments. 
-- 11/06/2024 - Vineet Tirodkar - To add new Non-paid Kinship Placement structure in exclusion  (B-207876 / CIDM-9688)
------------------------------------------------------------------------
DECLARE vl_placement_validation_id BIGINT DEFAULT 0;
DECLARE vl_placment_val_count INT DEFAULT 0;

DECLARE SQLCODE INT DEFAULT 0;

DECLARE vs_placement_validation_id VARCHAR(50) DEFAULT 'sq_placement_validation';

DECLARE vd_previous_month_start_dt DATE;
DECLARE vd_previous_month_end_dt DATE;
cur_placement record;
 cur_placement_refcur REFCURSOR;

--  get the last month start date and end date
BEGIN

	SELECT (date_trunc('month', now()) - interval '1 month')::date,
		   (date_trunc('month', now())::date - 1)
	INTO vd_previous_month_start_dt,
		vd_previous_month_end_dt;
        
	-- get all the open ended placment from the previous month
	--FOR cur_placement AS
	OPEN cur_placement_refcur FOR
		SELECT PLACEMENT_ID, ENTRY_DT, EXIT_DT
			FROM tb_PLACEMENT
		WHERE ENTRY_DT <= vd_previous_month_end_dt 
			AND PROVIDER_ID IS NOT NULL 
			AND PLACEMENT_STRUCTURE_ID not in ( 8, 76, 531 )
			AND ( (EXIT_DT  IS NULL) OR  (EXIT_DT > vd_previous_month_start_dt)) 
			AND ((VOID_SW IS NULL) OR (VOID_SW = 'N')) 
			AND APPROVAL_STATUS_CD = '3047' 
			AND DELETE_SW = 'N' 
			-- AND	 ( cjams.F_PRIM_COUNTY(CASE_ID,'NULL') IN 
			-- 				( select statecountycode from county where golivedate <= CURRENT_DATE ) 
			-- 				OR
			-- 				cjams.F_CHECK_CASE_TRANSFER(CASE_ID) = 1
			-- 	) 
			AND CONVERSION_SW IS NULL;

	--DO
	loop
		fetch cur_placement_refcur into cur_placement;
										exit when not found;

		-- check if placement validation record already exist then
		SELECT count(*)
			INTO vl_placment_val_count
		FROM tb_PLACEMENT_VALIDATION
		WHERE (	PLACEMENT_ID = cur_placement.PLACEMENT_ID 
			AND VALIDATION_START_DT = vd_previous_month_start_dt 
			AND VALIDATION_END_DT = vd_previous_month_end_dt 
			AND DELETE_SW = 'N'
			);

		IF vl_placment_val_count = 0 THEN  -- not validation record exist in the validation
			-- create validation record for the previous month
			-- generate placement_validaion_id
			RAISE NOTICE 'beofre SP_nextid>>>>>>>vs_placement_validation_id %',vs_placement_validation_id;
			-- SELECT al_next_value from sp_nextid ( vs_placement_validation_id::character varying) into vl_placement_validation_id;
			RAISE NOTICE 'Output SP_nextid>>>>>>>vl_placement_validation_id %',vl_placement_validation_id;

			INSERT INTO
				tb_PLACEMENT_VALIDATION
				(
				   PLACEMENT_VALIDATION_ID,               PLACEMENT_ID,
				   PLACEMENT_ENTRY_DT,                    PLACEMENT_EXIT_DT,
				   VALIDATION_STATUS_CD,                  COMMENT_TX,
				   VALIDATION_START_DT,                   VALIDATION_END_DT,
				   CREATE_TS,                             CREATE_USER_ID,
				   UPDATE_TS,                             UPDATE_USER_ID,
				   DELETE_SW
				)
             VALUES
				(
				   --vl_placement_validation_id,
				   NEXTVAL('sq_placement_validation'), 		cur_placement.PLACEMENT_ID,
				   cur_placement.ENTRY_DT,                  cur_placement.EXIT_DT,
				   NULL,                                    NULL,
				   vd_previous_month_start_dt,              vd_previous_month_end_dt,
				   CURRENT_TIMESTAMP,                       'finance',
				   CURRENT_TIMESTAMP,                       'finance',
				   'N'
				);

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in creating validation record'  ;
				-- GOTO ERROR_SECTION;
				-- GOTO ERROR_SECTION;
				ROLLBACK;
				al_sqlcode :=-1;
				-- RETURN al_sqlcode;
			END IF ;
		END IF;
	END LOOP;	
	--END FOR; 
	-- FOR CUR_PLACEMENT
	
	-- To delete placement validation records with no draft payments	
	update tb_placement_validation
		set delete_sw = 'Y',
			update_ts = now()
	where validation_start_dt = vd_previous_month_start_dt
		and validation_end_dt = vd_previous_month_end_dt
		and delete_sw = 'N'
		and placement_id not in 
		(
			select pd.placement_id
				from tb_payment_detail pd,
					tb_payment_header ph,
					tb_payment_status ps	
			where pd.payment_id = ph.payment_id
				and ph.payment_id = ps.payment_id
				and pd.delete_sw = 'N'
				and ph.delete_sw = 'N'
				and ps.delete_sw = 'N'
				and pd.placement_id > 0
				and ph.payment_type_cd = '6'
				and date_part('month', pd.draft_service_start_dt) = date_part('month', vd_previous_month_start_dt)
				and date_part('year', pd.draft_service_start_dt) = date_part('year', vd_previous_month_start_dt)
		) ;
	
	-- COMMIT;
	al_sqlcode := 0;
	-- RETURN 0;
	-- ERROR_SECTION:
	-- <<ERROR_SECTION>>
	-- ROLLBACK;
	-- RETURN -1;
	retrun_code:=1;
END;

$function$
;
