CREATE OR REPLACE FUNCTION cjams.sp_csrb_days_calculation(as_rate_flag character, al_provider_id bigint, al_placement_structure_id bigint, ad_placement_start_dt date, ad_placement_end_dt date, ad_payment_start_dt date, ad_payment_end_dt date, OUT ad_rfc_service_st_dt date, OUT ad_rfc_service_end_dt date, OUT al_rfc_unit_no integer, OUT as_rfc_unit_type character varying, OUT ad_rfcd_service_st_dt date, OUT ad_rfcd_service_end_dt date, OUT al_rfcd_unit_no integer, OUT as_rfcd_unit_type character varying, OUT al_sqlcode integer, OUT as_error character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author      : Vineet Tirodkar
-- Description : Procedure to calculate service days based on Provider Location Address county
-- 				 For Address County is 1443 (Prince George's) or 1435 (Charles)
-- 				    Room & Board/Clothing/Differential (Higher Rate)
-- 				 For Others
-- 			     Room & Board/Clothing	


-- Revision(s)
-- 06/24/2020 Vineet Tirodkar - Modifications to fix one night less payment issue (CDM-1539)
-- 09/15/2022 Vineet Tirodkar - Type casting fixes for Aurora DB migration 
------------------------------------------------------------------------
DECLARE		
DECLARE vs_cursor_sql VARCHAR(12000) ;
DECLARE vd_previous_month_start_dt DATE;
DECLARE vd_previous_month_end_dt DATE;
DECLARE ad_service_start_dt DATE;
DECLARE ad_service_end_dt DATE;
DECLARE vl_no_of_nights INT;
DECLARE al_unit_no INT;
DECLARE as_unit_type VARCHAR(5);
DECLARE vl_adr_count INT;
DECLARE vl_rfc_unit_no INT;
DECLARE vl_rfcd_unit_no INT;
DECLARE vl_row_cnt INT DEFAULT 0;
DECLARE vd_adr_start_dt DATE;
DECLARE vd_adr_end_dt DATE;
DECLARE vs_higher_fc_rate_sw CHAR(1)DEFAULT NULL;
DECLARE vl_rfc_unit_no_temp INT DEFAULT 0;
DECLARE vl_rfcd_unit_no_temp INT DEFAULT 0;
DECLARE vs_last_add_slab_sw CHAR(1) DEFAULT NULL;
DECLARE vl_calc_total_unit_no INT DEFAULT 0;
DECLARE vl_diff_unit_no INT DEFAULT 0;
DECLARE vl_tot_rows INT DEFAULT 0;

DECLARE vl_sqlcode int default 0;
DECLARE SQLCODE INT DEFAULT 0;
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_CSRB_DAYS_CALCULATION';
VS_L            CHAR(1) DEFAULT  'L';
VS_R            CHAR(1) DEFAULT  'R';
--DECLARE CUR_PROVIDER_ADD CURSOR WITH HOLD FOR s1;
DECLARE CUR_PROVIDER_ADD REFCURSOR;

--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION

BEGIN												  
	BEGIN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text = MESSAGE_TEXT;
		EXCEPTION WHEN OTHERS THEN
		-- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
		vl_sqlcode := -1 ;
		as_error := COALESCE(as_error ,'') || (current_timestamp) ||'::' || vs_Procedure_nm || '.' ;
		-- as_error := COALESCE(as_error ,'') || '::RO ' || 'Provider id' || ' :: ' || COALESCE((al_provider_id),'');
		as_error := as_error || COALESCE(vs_message_text ,'');
	END;	
	
	vd_previous_month_start_dt := ad_payment_start_dt;
	vd_previous_month_end_dt := ad_payment_end_dt;		
	
	CASE as_rate_flag
	WHEN 'R' THEN  -- Room and Board
		IF ad_placement_end_dt IS NULL OR ad_placement_end_dt >= vd_previous_month_end_dt THEN
			ad_service_end_dt :=  vd_previous_month_end_dt;
		ELSE
			ad_service_end_dt := ad_placement_end_dt;
		END IF;

		IF ad_placement_start_dt <= vd_previous_month_start_dt THEN  --child is staying in this placment before the previous month
			ad_service_start_dt :=  vd_previous_month_start_dt;
		ELSE
			ad_service_start_dt := ad_placement_start_dt;
		END IF;

		-- Check Location Address County for Higher FC Rate
		-- 3357  Provider Location
		-- 1435 (Charles) and 1443 (Prince George's)

		SELECT COUNT(*)
				INTO vl_adr_count	
			FROM tb_PROVIDER_ADDRESSES
		WHERE DELETE_SW = 'N'
			AND PARENT_KEY_ID::bigint = al_provider_id::bigint
			AND ADR_TYPE_CD = '3357'
			AND RTRIM(LTRIM(ADR_COUNTY_CD)) in ( '1435', '1443' )
			AND ADR_START_DT <= ad_service_end_dt
			AND ( ADR_END_DT is NULL OR ADR_END_DT >= ad_service_start_dt ) ;


		al_sqlcode = SQLCODE;
		IF al_sqlcode < 0  THEN
			SET as_error = 'Error in getting count of Provider Addresses for Higher FC Rate.';
		END IF ;	

		IF ad_service_end_dt <= DATE('2010-03-31') OR vl_adr_count = 0 THEN -- Call Old SP
    	
			/* SELECT f_sp_fostercare_calculation('L',
												'R',
						al_placement_structure_id,
						ad_placement_start_dt,
						ad_placement_end_dt,
						ad_payment_start_dt,
						ad_payment_end_dt,
						ad_rfc_service_st_dt,
						ad_rfc_service_end_dt,
						al_rfc_unit_no,
						as_rfc_unit_type);-- */
						  
			SELECT  a.ad_service_start_dt,
				a.ad_service_end_dt,
				a.al_unit_no,
				a.as_unit_type 
			FROM F_SP_FOSTERCARE_CALCULATION(VS_L,
					VS_R,
					al_placement_structure_id,
					ad_placement_start_dt,
					ad_placement_end_dt,
					ad_payment_start_dt,
					ad_payment_end_dt) a into 
					ad_rfc_service_st_dt,
					ad_rfc_service_end_dt,
					al_rfc_unit_no,
					as_rfc_unit_type;

			ad_rfcd_service_st_dt := NULL;
			ad_rfcd_service_end_dt := NULL;
			al_rfcd_unit_no := NULL;
			as_rfcd_unit_type := NULL;

		ELSE
			-- vl_no_of_nights := DAY(ad_service_end_dt) - DAY(ad_service_start_dt);
			vl_no_of_nights := date_part('DAY',ad_service_end_dt) - date_part('DAY',ad_service_start_dt); -- CDM-1539	
			al_unit_no := vl_no_of_nights;

			IF ad_service_start_dt = vd_previous_month_end_dt AND (ad_placement_end_dt IS NULL
					OR ad_placement_end_dt > vd_previous_month_end_dt) THEN
				al_unit_no := 1;
			ELSEIF ad_service_end_dt = vd_previous_month_end_dt 
					and (ad_service_end_dt <> ad_placement_end_dt or ad_placement_end_dt is null) THEN
				al_unit_no := al_unit_no + 1;
			END IF;

			as_unit_type := '5610'; --nightly

			vl_rfc_unit_no := 0; -- INITIAL VALUE
			vl_rfcd_unit_no := 0; -- INITIAL VALUE
	
			/* -- SQL for Cursor (Location Addresses) - START	
			  vs_cursor_sql :=
				  ' SELECT ADR_START_DT, '||
				  '	       ADR_END_DT,  '||
				  '	       (CASE WHEN RTRIM(LTRIM(ADR_COUNTY_CD)) =  ''1435'' OR RTRIM(LTRIM(ADR_COUNTY_CD)) =  ''1443'' THEN '||
				  '	 	  ''Y'' '||
				  '		ELSE '||
				  '		  ''N'' '||
				  '		END) AS HIGHER_FC_RATE '||
				  '	    FROM tb_PROVIDER_ADDRESSES '||
				  ' WHERE DELETE_SW = ''N'' '||
				  '       AND PARENT_KEY_ID = '|| (al_provider_id) ||' '||
				  '       AND ADR_TYPE_CD = ''3357'' '||
				  '       AND ADR_START_DT <= '''|| (ad_service_end_dt, USA) ||''' '||
				  '       AND ( ADR_END_DT is NULL OR ADR_END_DT >= '''|| (ad_service_start_dt, USA) ||''' ) '||
				  '	ORDER BY ADR_START_DT  ' ;--
			
			-- SQL for Cursor (Location Addresses) - END	*/
			
			-- Take count to run a loop for cursor (Location Addresses) - START	
			SELECT COUNT(*)
				INTO vl_row_cnt
				FROM tb_PROVIDER_ADDRESSES
			WHERE DELETE_SW = 'N'
				AND PARENT_KEY_ID::bigint = al_provider_id::bigint
				AND ADR_TYPE_CD = '3357'
				AND ADR_START_DT <= ad_service_end_dt
				AND ( ADR_END_DT is NULL OR ADR_END_DT >= ad_service_start_dt ) ;
		
			vl_tot_rows := vl_row_cnt;
			-- Take count to run a loop for cursor (Location Addresses) - END	
		
			--PREPARE s1 FROM vs_cursor_sql ;
			OPEN CUR_PROVIDER_ADD FOR 
				SELECT ADR_START_DT,ADR_END_DT,(CASE WHEN RTRIM(LTRIM(ADR_COUNTY_CD)) =  '1435' 
						OR RTRIM(LTRIM(ADR_COUNTY_CD)) =  '1443' THEN 
						'Y' 
					ELSE 
						'N'
					END) AS HIGHER_FC_RATE 
				FROM tb_PROVIDER_ADDRESSES 
				WHERE DELETE_SW = 'N'
					AND PARENT_KEY_ID::bigint = al_provider_id::bigint
					AND ADR_TYPE_CD = '3357' 
					--AND ADR_START_DT <= (ad_service_end_dt, USA)
					-- AND ( ADR_END_DT is NULL OR ADR_END_DT >=  (ad_service_start_dt, USA) ) 
					AND ADR_START_DT <= (ad_service_end_dt)
					AND ( ADR_END_DT is NULL OR ADR_END_DT >=  (ad_service_start_dt) ) 
				ORDER BY ADR_START_DT ;
				
			--PROVIDER_LOCN_ADD:
			WHILE vl_row_cnt > 0  LOOP
				vd_adr_start_dt := null; 
				vd_adr_end_dt := NULL; -- INITIAL VALUE
				vs_higher_fc_rate_sw :=NULL; -- INITIAL VALUE
				vl_rfc_unit_no_temp := 0; -- INITIAL VALUE	
				vl_rfcd_unit_no_temp := 0; -- INITIAL VALUE	
				-- IF 'Y' Higher Rate County ELSE 'N' Other County
				vs_last_add_slab_sw := NULL; -- INITIAL VALUE	
	
				FETCH CUR_PROVIDER_ADD INTO vd_adr_start_dt, vd_adr_end_dt, vs_higher_fc_rate_sw;
	
				IF vl_row_cnt = 0 THEN
					--  LEAVE PROVIDER_LOCN_ADD;
				END IF;
	
				IF vs_higher_fc_rate_sw = 'N' THEN
					IF vd_adr_end_dt is NULL THEN	
						IF vd_adr_start_dt < ad_service_start_dt THEN
							vl_rfc_unit_no_temp := date_part('DAY',ad_service_end_dt) - date_part('DAY',ad_service_start_dt);	
						ELSE
							vl_rfc_unit_no_temp := date_part('DAY',ad_service_end_dt) - date_part('DAY',vd_adr_start_dt);	
						END IF;
					ELSE
						IF vd_adr_start_dt < ad_service_start_dt THEN
							vl_rfc_unit_no_temp := date_part('DAY',vd_adr_end_dt) - date_part('DAY',ad_service_start_dt);	
						ELSE
							vl_rfc_unit_no_temp := date_part('DAY',vd_adr_end_dt) - date_part('DAY',vd_adr_start_dt);	
						END IF;
					END IF;
					vl_rfc_unit_no := vl_rfc_unit_no + vl_rfc_unit_no_temp; 	
				ELSE
					IF vd_adr_end_dt is NULL THEN
						IF vd_adr_start_dt < ad_service_start_dt THEN
							vl_rfcd_unit_no_temp := date_part('DAY',ad_service_end_dt) - date_part('DAY',ad_service_start_dt);	
						ELSE
							vl_rfcd_unit_no_temp := date_part('DAY',ad_service_end_dt) - date_part('DAY',vd_adr_start_dt);	
						END IF;
					ELSE
						IF vd_adr_start_dt < ad_service_start_dt THEN
							vl_rfcd_unit_no_temp := date_part('DAY',vd_adr_end_dt) - date_part('DAY',ad_service_start_dt);	
						ELSE
							vl_rfcd_unit_no_temp := date_part('DAY',vd_adr_end_dt) - date_part('DAY',vd_adr_start_dt);	
						END IF;
					END IF;
					vl_rfcd_unit_no := vl_rfcd_unit_no + vl_rfcd_unit_no_temp; 	
				END IF;
	
				IF vl_row_cnt <> 1 AND vl_row_cnt <> vl_tot_rows THEN
					IF vs_higher_fc_rate_sw = 'N' THEN
						vl_rfc_unit_no := vl_rfc_unit_no  + 1;
					ELSE
						vl_rfcd_unit_no := vl_rfcd_unit_no + 1;
					END IF;
				END IF;
	
				vs_last_add_slab_sw := vs_higher_fc_rate_sw;
				vl_row_cnt := vl_row_cnt  - 1;	
			END LOOP ;
			CLOSE CUR_PROVIDER_ADD ;

			-- Verify the split total of days should match with al_unit_no
			vl_calc_total_unit_no := vl_rfc_unit_no + vl_rfcd_unit_no;
			IF al_unit_no <> vl_calc_total_unit_no THEN
				vl_diff_unit_no := al_unit_no - vl_calc_total_unit_no;
				IF vs_last_add_slab_sw = 'N' THEN
					vl_rfc_unit_no := vl_rfc_unit_no + vl_diff_unit_no;
				ELSE
					vl_rfcd_unit_no := vl_rfcd_unit_no + vl_diff_unit_no;
				END IF;
			END IF;

			IF vl_rfc_unit_no > 0 THEN
				ad_rfc_service_st_dt := ad_service_start_dt;
				ad_rfc_service_end_dt := ad_service_end_dt;
				al_rfc_unit_no := vl_rfc_unit_no;
				as_rfc_unit_type := '5610'; --nightly
			ELSE
				ad_rfc_service_st_dt := NULL;
				ad_rfc_service_end_dt := NULL;
				al_rfc_unit_no := NULL;
				as_rfc_unit_type := NULL;
			END IF;
	
			IF vl_rfcd_unit_no > 0 THEN
				ad_rfcd_service_st_dt := ad_service_start_dt;
				ad_rfcd_service_end_dt := ad_service_end_dt;
				al_rfcd_unit_no := vl_rfcd_unit_no;
				as_rfcd_unit_type := '5610'; --nightly
			ELSE
				ad_rfcd_service_st_dt := NULL;
				ad_rfcd_service_end_dt := NULL;
				al_rfcd_unit_no := NULL;
				as_rfcd_unit_type := NULL;
			END IF;
	
		END IF; -- Call Old SP
	END CASE; 
END;

$function$
;
