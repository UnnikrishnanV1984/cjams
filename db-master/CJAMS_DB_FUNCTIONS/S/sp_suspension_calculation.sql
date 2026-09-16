CREATE OR REPLACE FUNCTION cjams.sp_suspension_calculation(	as_type_flag character, 
															al_key_id bigint, 
															ad_subsidy_start_dt date, 
															ad_subsidy_end_dt date, 
															ad_service_month_start_dt date, 
															ad_service_month_end_dt date, 
															ad_rate_start_dt date, 
															ad_rate_end_dt date, 
															al_unit_no integer, 
															OUT al_suspension_days integer
														)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$						
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      :  Vineet Tirodkar
-- Date        :  09/10/2015
-- Description :  PRJ-05327 - MD CHESSIE Fiscal Phases 2 
--				  To calculate No of days in suspension during specified period

-- Arguments   : 1) IN as_type_flag CHAR(1) - 'A' for Adoption Subsidy and 'G' for GAP 
--				 2) IN al_key_id BIGINT - ADOPTION_ID for Adoption Subsidy and GUARDIAN_SUBSIDY_ID for GAP
--				 3) IN ad_subsidy_start_dt DATE  
--				 4) IN ad_subsidy_end_dt DATE
--				 5)	IN ad_service_month_start_dt DATE
-- 				 6) IN ad_service_month_end_dt DATE
--				 5) IN ad_rate_start_dt DATE
--				 6)	IN ad_rate_end_dt DATE
--				 7) OUT al_suspension_days INTEGER	
-- Revision(s)
-- 02/24/2016 Vineet Tirodkar - PRJ-05947 (IDEA-09155) Modify GAP Over Under Process
-- Modification to consider the System Generated Suspensions in calculating no of days in suspension for GAP
-- 06/02/2020 Vineet Tirodkar - Suspension calculation changes for subsidy final month payment (Subtract 1 extra night) 
-- 10/05/2020 Vineet Tirodkar - Fix to prevent payment batch failure for multiple adoptioncase records with same alternateid (Adoption_id)
-- 04/13/2021 Vineet Tirodkar - Modifications to exclude Suspension with Start date same as End date (CDM-12062)
------------------------------------------------------------------------
DECLARE vl_suspesion_cnt	INTEGER;
DECLARE vd_calc_dt			DATE;
DECLARE vl_ageout_unit_no 	INTEGER;
 
BEGIN
	IF ad_rate_end_dt is NULL OR ad_rate_end_dt > ad_service_month_end_dt THEN
		ad_rate_end_dt := ad_service_month_end_dt;
	END IF;

	al_suspension_days := 0 ; -- INITIAL VALUE
	vd_calc_dt := ad_rate_start_dt;
	
	CASE as_type_flag
	WHEN 'A' THEN  -- Adoption Subsidy
		-- Verify if Adoption subsidy final month payment
		SELECT sp_subsidy_ageout_calculation
			INTO vl_ageout_unit_no
		FROM cjams.sp_subsidy_ageout_calculation('A', al_key_id::bigint, ad_rate_start_dt::date);
		
		IF vl_ageout_unit_no is null THEN
			vl_ageout_unit_no := 0;
		END IF;
	
		--WHILE (al_unit_no > 0 ) 
		loop EXIT WHEN al_unit_no <= 0::bigint ;
			--DO
			SELECT COUNT(*)
				INTO vl_suspesion_cnt
			-- FROM tb_ADOPTION_PAYMENT_SUSPENSION
			FROM adoptioncasesuspension
			-- WHERE ADOPTION_ID = al_key_id
			WHERE adoptioncaseid = (	select adoptioncaseid 
											from adoptioncase 
										where alternateid = al_key_id
											and activeflag = 1
										order by insertedon desc
										limit 1
										-- select adoptioncaseid from adoptioncase where alternateid = al_key_id
									)
				AND suspensionbegindate <> coalesce(suspensionenddate, current_date + interval '1 day' ) -- CDM-12062 					
				AND (
					  ( suspensionenddate IS NULL AND suspensionbegindate::date <= vd_calc_dt  )
					   OR
					  ( suspensionenddate IS NOT NULL 
						AND vd_calc_dt BETWEEN suspensionbegindate::date AND suspensionenddate::date
					   )
					)  
				AND vd_calc_dt <> COALESCE(suspensionenddate, ( ad_rate_end_dt + interval '1 day') )
				-- AND DELETE_SW = 'N'
				AND activeflag = 1
				AND COALESCE(approvalstatustypekey, '') = '3047';
	
			IF vl_suspesion_cnt > 0 THEN
				al_suspension_days := al_suspension_days + 1;
			END IF;	

			vd_calc_dt := vd_calc_dt + interval '1 day';
		
			-- IF ad_subsidy_end_dt::date = vd_calc_dt THEN
			IF ( ( ad_subsidy_end_dt::date = vd_calc_dt AND vl_ageout_unit_no = 0 )
					OR
				 ( ad_subsidy_end_dt::date + 1 = vd_calc_dt )
				) THEN
				al_unit_no := -1; -- Exit
			ELSE
				al_unit_no := al_unit_no - 1;
			END IF;
		END loop;
		--END WHILE;
			
	WHEN 'G' THEN  -- GAP
		-- 33424 - Child entered Out of Home Placement (system generated)
		-- 33427 - Death of child (case to be closed immediately)
		
		-- Verify if GAP final month payment
		SELECT sp_subsidy_ageout_calculation
			INTO vl_ageout_unit_no
		FROM cjams.sp_subsidy_ageout_calculation('G', al_key_id::bigint, ad_rate_start_dt::date);
		
		IF vl_ageout_unit_no is null THEN
			vl_ageout_unit_no := 0;
		END IF;
		
		--WHILE (al_unit_no > 0 ) 
		--DO
		loop EXIT WHEN al_unit_no <= 0::bigint ;
			SELECT COUNT(*)
				INTO vl_suspesion_cnt
			-- FROM tb_GUARDIAN_SUBSIDY_SUSPENSION
			FROM gapsuspension
			WHERE gapid = (	select gapid 
								from tb_guardian_subsidy 
							where guardian_subsidy_id = al_key_id
								and delete_sw = 'N'
							order by create_ts desc
							limit 1
							-- select gapid from tb_guardian_subsidy where guardian_subsidy_id = al_key_id
						   )
				AND	startdate <> coalesce(enddate,current_date + interval '1 day' )	-- CDM-12062 
				AND (
					  ( enddate IS NULL AND startdate::date <= vd_calc_dt  )
					   OR
					  ( enddate IS NOT NULL 
						AND vd_calc_dt BETWEEN startdate::date AND enddate::date
					   )
					)  
				AND vd_calc_dt <> COALESCE(enddate, ( ad_rate_end_dt + interval '1 day') )
				-- AND DELETE_SW = 'N'
				AND activeflag = 1
				AND ( COALESCE(approvalstatustypekey, '') = '3047'
						OR
					  suspensionreasontypekey IN ('COHP','DCHD','33427','33424')	
					);
		
			IF vl_suspesion_cnt > 0 THEN
				al_suspension_days := al_suspension_days + 1;
			END IF;	

			vd_calc_dt = vd_calc_dt + interval '1 day';
			
			IF ad_subsidy_end_dt::date = vd_calc_dt THEN
				al_unit_no = -1; -- Exit
			ELSE
				al_unit_no := al_unit_no - 1;
			END IF;
		END loop;
		--END WHILE;
END CASE;

END;
$function$
;
