-- FUNCTION: cjams.sp_get_placement_rate(bigint, integer, date, date, character)

 DROP FUNCTION if exists cjams.sp_get_placement_rate(bigint, integer, date, date, character);

CREATE OR REPLACE FUNCTION cjams.sp_get_placement_rate(
	al_placement_structure_id bigint,
	al_child_age integer,
	ad_start_dt date,
	ad_end_dt date,
	as_type_cd character,
	OUT adc_gross_amount numeric,
	OUT adc_per_diem_rate numeric,
	OUT al_sqlcode integer,
	OUT as_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
------------------------------------------------------------------------
-- Revision:
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------
DECLARE vl_prov_org_id BIGINT;--
 vl_prov_id BIGINT;--
 vl_plc_str_id BIGINT;--
 al_new_placement_structure_id  BIGINT;--
 vl_no_of_days INTEGER;--

 vs_rate_type VARCHAR(5) DEFAULT NULL;--

 vl_sqlcode int default 0;--
DECLARE      SQLCODE                         INTEGER         DEFAULT 0;--
--
--
 vs_message_text VARCHAR(3000) DEFAULT '';--
 vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_GET_PLACEMENT_RATE';
 BEGIN
--
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
--    GET DIAGNOSTICS EXCEPTION 1 vs_message_text = MESSAGE_TEXT;--
	EXCEPTION WHEN OTHERS THEN
   -- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
	
    vl_sqlcode := -1 ;--
    as_error := COALESCE(as_error ,'') || ( CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
    as_error := COALESCE(as_error ,'') || '::RO ' || 'Placement Structure_id' || ' :: ' ||
    COALESCE((al_placement_structure_id)::character varying,'');--
    as_error := as_error || COALESCE(vs_message_text ,'');--
END;--

--SELECT  DAY(F_daymonth(CURRENT_DATE ,'L', 'P' )) - 1
--	INTO vl_no_of_days
--FROM sysibm.sysdummy1;--

 CASE as_type_cd
         WHEN 'R' THEN  -- room and board
            -- New condition to get Room & Board Rate - CIS-19002 	
            -- 13 - Emergency Foster Home Care
            -- 503 - Subsidized Guardianship
            -- New condition check for placement structure id - PRJ-04753
		    IF al_placement_structure_id IN (11405, 11406, 11407, 11408, 11409) THEN
		      vs_rate_type := '5670'; -- Room & Board/Clothing
		    ELSEIF ad_end_dt <= DATE('2009-08-31') OR al_placement_structure_id IN(13, 503) THEN
		      vs_rate_type := '1232'; -- Room & Board
		    ELSE
		      vs_rate_type := '5670'; -- Room & Board/Clothing
		    END IF;--

            SELECT MONTHLY_RATE_NO,
                   PER_DIEM_RATE_NO
              INTO adc_gross_amount,
                   adc_per_diem_rate
              FROM TB_FOSTER_CARE_RATE
            WHERE ( SERVICE_ID = al_placement_structure_id
            	    AND DELETE_SW = 'N'
            	    AND RATE_TYPE_CD = vs_rate_type
            	    AND START_DT <= ad_start_dt
            	    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
            	    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO );--

            al_sqlcode := SQLCODE;--
    	    IF al_sqlcode < 0  THEN
	       as_error := 'Placement Rate: Error in getting rates for Room and Board';--
    	    END IF ;--

            IF al_placement_structure_id = 13 THEN
               IF adc_gross_amount is NULL or adc_gross_amount = 0 THEN
    	          adc_gross_amount := vl_no_of_days * adc_per_diem_rate	;--
	       END IF;--
    	    END IF;--

 WHEN 'C' THEN  -- Clothing allowance
            SELECT MONTHLY_RATE_NO
            	INTO adc_gross_amount
            FROM TB_FOSTER_CARE_RATE
            WHERE ( SERVICE_ID = al_placement_structure_id
            	    AND DELETE_SW = 'N'
            	    AND RATE_TYPE_CD = '1233'
            	    AND START_DT <= ad_start_dt
            	    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
            	    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO );--

	    al_sqlcode := SQLCODE;--
	    IF al_sqlcode < 0  THEN
	       as_error := 'Placement Rate: Error in getting rates for Clothing Allowance';--
	    END IF ;--
	
 WHEN 'I' THEN  -- Initial Clothing allowance
            SELECT MAX_CLOTHING_NO
            	INTO adc_gross_amount
            FROM TB_FOSTER_CARE_RATE
            WHERE ( SERVICE_ID = 659
            	    AND DELETE_SW = 'N'
            	    AND RATE_TYPE_CD = '5669'
            	    AND START_DT <= ad_start_dt
            	    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
            	    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO );--

	    al_sqlcode := SQLCODE;--
	    IF al_sqlcode < 0  THEN
	       as_error := 'Placement Rate: Error in getting rates for Initial Clothing Allowance';--
	    END IF ;--

 WHEN 'S' THEN  -- Stipend and difficulity of care
	    -- New condition to get Stipend Rate - CIS-19002 	
        IF ad_end_dt <= DATE('2009-08-31') THEN	

	       SELECT MONTHLY_STIPEND_NO
		    INTO adc_gross_amount
	       FROM TB_FOSTER_CARE_RATE
	       WHERE ( SERVICE_ID = al_placement_structure_id
		    AND DELETE_SW = 'N'
		    AND RATE_TYPE_CD  = '1234'
		    AND START_DT <= ad_start_dt
		    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
		    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO);--
	    ELSE
	
	       SELECT MONTHLY_STIPEND_NO,
	    	      PER_DIEM_RATE_NO
	    	INTO adc_gross_amount,
	    	     adc_per_diem_rate
	       FROM TB_FOSTER_CARE_RATE
	       WHERE ( SERVICE_ID = al_placement_structure_id
	     	    AND DELETE_SW = 'N'
	    	    AND RATE_TYPE_CD  = '1234'
	    	    AND START_DT <= ad_start_dt
	    	    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
		    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO);--
	    END IF;--
	
	    al_sqlcode := SQLCODE;--
	    IF al_sqlcode < 0  THEN
	       as_error := 'Placement Rate: Error in getting rates for Stipend and difficulity of care';--
	    END IF ;--

 WHEN 'B' THEN  -- Bed Retainer Fee

       	   SELECT MONTHLY_RATE_NO
               INTO adc_gross_amount
               FROM TB_FOSTER_CARE_RATE
           WHERE ( DELETE_SW = 'N'
           	   AND RATE_TYPE_CD  = '5629'
           	   AND START_DT <= ad_start_dt
           	   AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL)) );--

   	    al_sqlcode := SQLCODE;--
   	    IF al_sqlcode < 0  THEN
   	       as_error := 'Placement Rate: Error in getting rates for Bed Retainer Fee';--
	    END IF ;--

 WHEN 'P' THEN  -- private provider

        SELECT MONTHLY_RATE_NO,
               PER_DIEM_RATE_NO
          INTO adc_gross_amount,
               adc_per_diem_rate
           FROM TB_PROV_PROGRAM_RATES
        WHERE  (PROGRAM_ID = al_placement_structure_id
        	AND PROV_PROGRAM_ACTUAL_MAX_CD = '5590'
        	AND DELETE_SW = 'N'
        	AND START_DT <= ad_end_dt
        	AND ((END_DT >= ad_start_dt) OR (END_DT IS NULL)) )
        ORDER BY PROGRAM_RATE_ID DESC
    	FETCH FIRST ROW ONLY ;--

        al_sqlcode := SQLCODE;--
    	IF al_sqlcode < 0  THEN
	   as_error := 'Placement Rate: Error in getting rates for Private Provider';--
    	END IF ;--

	-- commented on 09/16/2008 # 18461
	--IF adc_gross_amount = 0 OR adc_gross_amount Is NULL THEN
	--	
	--	  SELECT TB_PLACEMENT.PROVIDER_ORGANIZATION_ID,
    	--	  	 TB_PLACEMENT.PROVIDER_ID,
	--    		 TB_PLACEMENT.PLACEMENT_STRUCTURE_ID
	--		INTO  vl_prov_org_id ,
	--		      vl_prov_id ,
	--		      vl_plc_str_id
	--		 FROM TB_PLACEMENT
	--		WHERE TB_PLACEMENT.CONTRACT_PROGRAM_ID = al_placement_structure_id
	--			FETCH FIRST ROW ONLY ;--

		
	--	  SELECT MAX(TB_CONTRACT_PROGRAM.PROGRAM_ID)
	--	     INTO al_new_placement_structure_id
	--	   FROM TB_PROVIDER_CONTRACTS ,
	--	        TB_CONTRACT_PROGRAM,
	--	        TB_PROV_PROGRAM_SITES,
	--	        TB_PROVIDER_SERVICES,
	--	        TB_SERVICES
	--	  WHERE TB_PROVIDER_CONTRACTS.CONTRACT_ID = TB_CONTRACT_PROGRAM.CONTRACT_ID AND
	--		TB_PROVIDER_SERVICES.PROGRAM_ID = TB_CONTRACT_PROGRAM.PROGRAM_ID AND
	--		TB_PROV_PROGRAM_SITES.PROGRAM_ID = TB_CONTRACT_PROGRAM.PROGRAM_ID AND
	--		TB_SERVICES.SERVICE_ID=TB_PROVIDER_SERVICES.SERVICE_ID AND	
	--		TB_PROVIDER_CONTRACTS.PROVIDER_ID = vl_prov_org_id AND
	--		TB_PROV_PROGRAM_SITES.SITE_ID = vl_prov_id AND
	--		TB_PROVIDER_CONTRACTS.DELETE_SW = 'N' AND
	--		TB_CONTRACT_PROGRAM.DELETE_SW= 'N' AND
	--		TB_PROV_PROGRAM_SITES.DELETE_SW = 'N' AND
	--		TB_SERVICES.STRUCTURE_SERVICE_CD = 'P'  AND
	--		TB_PROVIDER_SERVICES.SERVICE_ID = vl_plc_str_id AND
	--		TB_CONTRACT_PROGRAM.START_DT <= ad_end_dt  AND
	--		TB_CONTRACT_PROGRAM.END_DT >= ad_start_dt;--

		

	--    	  SELECT MONTHLY_RATE_NO,
	--             PER_DIEM_RATE_NO
   	--            INTO adc_gross_amount,
	--           	 adc_per_diem_rate
	--     	   FROM  TB_PROV_PROGRAM_RATES
	--    	  WHERE (PROGRAM_ID = al_new_placement_structure_id AND
	--                 PROV_PROGRAM_ACTUAL_MAX_CD = '5590' AND
	--                 DELETE_SW = 'N' AND
	--                 START_DT <= ad_end_dt   AND
	--                ((END_DT >= ad_start_dt) OR (END_DT IS NULL)) )
	--          ORDER BY PROGRAM_RATE_ID DESC
	--              FETCH FIRST ROW ONLY ;--

	--  	  SET al_sqlcode = SQLCODE;--
	--    	  IF al_sqlcode < 0  THEN
	--	         SET as_error = 'Placement Rate: Error in getting rates for Private Provider Program';--
	--  	  END IF ;--
	--END IF;--
	-- commented on 09/16/2008 # 18461
WHEN 'D' THEN  -- Room & Board/Clothing/Differential -- CIS-18884
	
	vs_rate_type := '5671'; -- Room & Board/Clothing/Differential
	
	SELECT MONTHLY_RATE_NO,
	       PER_DIEM_RATE_NO
	  INTO adc_gross_amount,
	       adc_per_diem_rate
	  FROM TB_FOSTER_CARE_RATE
	WHERE ( SERVICE_ID = al_placement_structure_id
	    AND DELETE_SW = 'N'
	    AND RATE_TYPE_CD = vs_rate_type
	    AND START_DT <= ad_start_dt
	    AND ((END_DT >= ad_end_dt) OR (END_DT IS NULL))
	    AND al_child_age BETWEEN MIN_AGE_NO AND MAX_AGE_NO );--

	al_sqlcode := SQLCODE;--
	IF al_sqlcode < 0  THEN
	  as_error := 'Placement Rate: Error in getting rates for Room & Board/Clothing/Differential';--
	END IF ;--

END CASE;--
 IF adc_gross_amount IS NULL THEN
    adc_gross_amount  := 0;--
 END IF;--
 IF adc_per_diem_rate IS NULL THEN
     adc_per_diem_rate  := 0;--
 END IF;--

 al_sqlcode := vl_sqlcode;--

END 
;

$BODY$;

