-- FUNCTION: cjams.sp_address_edits(bigint, bigint, character varying, character varying)

DROP FUNCTION cjams.sp_address_edits(bigint, bigint, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.sp_address_edits(
	al_add_id bigint,
	al_provider_id bigint,
	as_adr_type character varying,
	as_user_id character varying,
	OUT al_output integer,
	OUT al_sqlcode integer,
	OUT as_error character varying)
RETURNS record
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
AS $BODY$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Vineet Tirodkar
-- 12/12/2007
-- To ensure address must have appropriate required fields and conditionally required fields.
-- 02/06/2008 Vineet Tirodkar - added check for Unit Type / # for Adr Format 'Street' # 16706
-- 03/03/2008 Vineet Tirodkar - added check for Postal code, address format cd - Foreign
-- 04/02/2008 Vineet Tirodkar - change in the check for Postal code Also not mandatory field- Foreign # 26071 / CIS-16755
-- 11/18/2008 Vineet Tirodkar - To Update correct missing info for Payment add Street # and NM		
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------

DECLARE v_sqlcode INT DEFAULT 0;--
DECLARE vl_return INT DEFAULT 1;--

DECLARE vs_adr_type_cd VARCHAR(5);--
DECLARE vs_adr_format_cd VARCHAR(5);--
DECLARE vs_street_no VARCHAR(10) DEFAULT NULL;--
DECLARE vl_adr_box_no BIGINT DEFAULT 0;--
DECLARE vs_adr_street_nm  VARCHAR(150);--
DECLARE vs_unit_type_cd VARCHAR(5);--
DECLARE vs_unit_no_tx VARCHAR(150);--
DECLARE vs_city_nm  VARCHAR(150);--
DECLARE vs_adr_state_cd VARCHAR(5);--
DECLARE vl_zip5_no BIGINT DEFAULT 0;--
DECLARE vs_forgin_tx VARCHAR(150);--
DECLARE vs_forgin_state VARCHAR(150);--
DECLARE vs_country_tx VARCHAR(150);--
DECLARE vs_adr_postal_tx VARCHAR(150);--
DECLARE vs_zip_DATA VARCHAR(10) DEFAULT NULL;--
DECLARE vs_ZIP_char CHAR(1) DEFAULT NULL;--

DECLARE vs_ADR_BOX_PO_NO_SW VARCHAR(1) DEFAULT 'Y';	--
DECLARE vs_ADR_STREET_ROUTE_NO_SW VARCHAR(1) DEFAULT 'Y';	--
DECLARE vs_ADR_STREET_NM_SW VARCHAR(1) DEFAULT 'Y';	--
DECLARE vs_ADR_CITY_SW VARCHAR(1) DEFAULT 'Y';	--
DECLARE vs_ADR_STATE_SW VARCHAR(1) DEFAULT 'Y';--
DECLARE vs_ADR_ZIP5_SW VARCHAR(1) DEFAULT 'Y';--
DECLARE vs_ADR_UNIT_SW VARCHAR(1) DEFAULT 'Y';--
DECLARE vs_ADR_FOREIGN_TX_SW VARCHAR(1) DEFAULT 'Y';	--
DECLARE vs_ADR_FOREIGN_STATE_SW VARCHAR(1) DEFAULT 'Y';--
DECLARE vs_ADR_COUNTRY_SW VARCHAR(1) DEFAULT 'Y';--
DECLARE vs_ADR_POSTAL_CODE_SW VARCHAR(1) DEFAULT 'Y';--

DECLARE vs_ADR_SW VARCHAR(1) DEFAULT 'Y';--

DECLARE vl_state_cnt INT;--
DECLARE vl_zipcd_len INTEGER DEFAULT NULL;--
DECLARE vl_len_ctnr INTEGER DEFAULT 1;--
DECLARE vl_ASCII INTEGER ;--

DECLARE SQLCODE INT DEFAULT 0;--
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);--
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';--
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';--
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_ADDRESS_EDITS';--
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
	
	BEGIN
	EXCEPTION WHEN OTHERS THEN
    --GET DIAGNOSTICS EXCEPTION 1 vs_message_text = MESSAGE_TEXT;--
	vs_message_text := MESSAGE_TEXT;--
     v_sqlcode := -1 ;--
     as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP)::character varying ||'::' || vs_Procedure_nm || '.' ;--
     as_error := COALESCE(as_error ,'') || '::RO ' || 'Provider Id / Address Id' || ' :: ' || COALESCE((al_provider_id)::character varying,'') || '/ ' || COALESCE((al_add_id)::character varying,'');--
     as_error := as_error || COALESCE(vs_message_text ,'');
	
	RETURN;
	END;
SELECT ADR_TYPE_CD,
       ADR_FORMAT_CD,
       ADR_BOX_NO,
       ADR_STREET_TX,
       ADR_STREET_NM,
       ADR_CITY_NM,
       ADR_STATE_CD,
       ADR_ZIP5_NO,
       ADR_UNIT_TYPE_CD,
       ADR_UNIT_NO_TX,
       ADR_FOREIGN_TX,
       ADR_FOREIGN_STATE_TX,
       ADR_COUNTRY_TX,
       ADR_POSTAL_CODE_TX
  INTO vs_adr_type_cd,
       vs_adr_format_cd,
       vl_adr_box_no,
       vs_street_no,
       vs_adr_street_nm,
       vs_city_nm,
       vs_adr_state_cd,
       vl_zip5_no,
       vs_unit_type_cd,
       vs_unit_no_tx,
       vs_forgin_tx,
       vs_forgin_state,
       vs_country_tx,
       vs_adr_postal_tx
   FROM TB_PROVIDER_ADDRESSES
WHERE ADDRESS_ID = al_add_id
      AND DELETE_SW = 'N' ;--

al_sqlcode := SQLCODE;--
IF al_sqlcode <> 0  THEN
    as_error := 'Address Edits: Error in Selecting Address Details.';--
   --SIGNAL p_sp_error  ;--
END IF ;--

 vl_return := 1; -- INITIAL VALUE	

IF vs_adr_format_cd = 'S' THEN -- Street
    -- Street #, Street NM, City, State, Zip
    -- IF Unit Type selected then Unit #

   IF vs_street_no IS NULL OR LTRIM(RTRIM(vs_street_no)) = '' THEN
       vs_ADR_STREET_ROUTE_NO_SW := 'N';	--
   END IF;--

   IF vs_adr_street_nm IS NULL OR LTRIM(RTRIM(vs_adr_street_nm)) = '' THEN
       vs_ADR_STREET_NM_SW := 'N';	--
   END IF;--

   IF vs_city_nm IS NULL OR LTRIM(RTRIM(vs_city_nm)) = '' THEN
       vs_ADR_CITY_SW := 'N';	--
   END IF;--

   IF vs_adr_state_cd IS NULL OR LTRIM(RTRIM(vs_adr_state_cd)) = '' THEN
       vs_ADR_STATE_SW := 'N';	--
   ELSE
    -- Check for - 2 character Postal abbreviation
       SELECT COUNT(*)
         INTO vl_state_cnt
       FROM TB_PICKLIST_VALUES
     WHERE trim(PICKLIST_VALUE_CD) = trim(vs_adr_state_cd)
           AND PICKLIST_TYPE_ID = 211
           AND DELETE_SW = 'N' ;--

     IF vl_state_cnt = 0 THEN
        vs_ADR_STATE_SW := 'N';	--
     END IF;--
   END IF;--

   IF vl_zip5_no IS NULL THEN
      vs_ADR_ZIP5_SW :='N';	--
   END IF;--

   IF vs_unit_type_cd IS NOT NULL AND LTRIM(RTRIM(vs_unit_type_cd)) <> '' THEN
      IF vs_unit_no_tx IS NULL OR LTRIM(RTRIM(vs_unit_no_tx)) = '' THEN
          vs_ADR_UNIT_SW := 'N';	--
      END IF;--
   END IF;--

ELSEIF vs_adr_format_cd = 'R' THEN -- Rural
   -- Box #, Rural Route #, City, State, Zip

   IF vl_adr_box_no IS NULL THEN
       vs_ADR_BOX_PO_NO_SW :='N';	   	--
   END IF;--

   IF vs_street_no IS NULL OR LTRIM(RTRIM(vs_street_no)) = '' THEN
	  vs_ADR_STREET_ROUTE_NO_SW := 'N';	--
   END IF;--

   IF vs_city_nm IS NULL OR LTRIM(RTRIM(vs_city_nm)) = '' THEN
       vs_ADR_CITY_SW := 'N';	--
   END IF;--

   IF vs_adr_state_cd IS NULL OR LTRIM(RTRIM(vs_adr_state_cd)) = '' THEN
       vs_ADR_STATE_SW := 'N';	--
   ELSE
	-- Check for - 2 character Postal abbreviation
	SELECT COUNT(*)
	   INTO vl_state_cnt
	  FROM TB_PICKLIST_VALUES
	WHERE trim(PICKLIST_VALUE_CD) = trim(vs_adr_state_cd)
	      AND PICKLIST_TYPE_ID = 211
	      AND DELETE_SW = 'N' ;--

	IF vl_state_cnt = 0 THEN
	    vs_ADR_STATE_SW := 'N';	--
	END IF;--
   END IF;--

   IF vl_zip5_no IS NULL THEN
       vs_ADR_ZIP5_SW :='N';	--
   END IF;--

ELSEIF vs_adr_format_cd = 'P' THEN -- P.O. Box
   -- PO Box #, City, State, Zip

   IF vl_adr_box_no IS NULL THEN
       vs_ADR_BOX_PO_NO_SW :='N';	   	--
   END IF;--

   IF vs_city_nm IS NULL OR LTRIM(RTRIM(vs_city_nm)) = '' THEN
       vs_ADR_CITY_SW := 'N';	--
   END IF;--

   IF vs_adr_state_cd IS NULL OR LTRIM(RTRIM(vs_adr_state_cd)) = '' THEN
       vs_ADR_STATE_SW := 'N';	--
   ELSE
	-- Check for - 2 character Postal abbreviation
	SELECT COUNT(*)
	   INTO vl_state_cnt
	  FROM TB_PICKLIST_VALUES
	WHERE trim(PICKLIST_VALUE_CD) = trim(vs_adr_state_cd)
	      AND PICKLIST_TYPE_ID = 211
	      AND DELETE_SW = 'N' ;--

	IF vl_state_cnt = 0 THEN
	    vs_ADR_STATE_SW := 'N';	--
	END IF;--
   END IF;--

   IF vl_zip5_no IS NULL THEN
       vs_ADR_ZIP5_SW :='N';	--
   END IF;--

ELSEIF vs_adr_format_cd = 'F' THEN -- Foreign
  -- City, State XX (Hard Coding), Addess (Street # and NM), State, Country
  -- Postal Code format X9X__X9X_ (where X=Alpha, 9=numeric, _=space) - as per DSD
  -- Postal Code format X9X__X9X (where X=Alpha, 9=numeric, _=space) - final
  -- No specific Format, should have alphabets and numbers only  # 26071 / CIS-16755

   IF vs_city_nm IS NULL OR LTRIM(RTRIM(vs_city_nm)) = '' THEN
       vs_ADR_CITY_SW := 'N';	--
   END IF;--

   IF vs_adr_state_cd IS NULL OR LTRIM(RTRIM(vs_adr_state_cd)) = '' OR vs_adr_state_cd <> 'XX' THEN
       vs_ADR_STATE_SW := 'N';	--
   END IF;--

   -- How to check (Street # and NM)???
   IF vs_forgin_tx IS NULL OR LTRIM(RTRIM(vs_forgin_tx)) = '' THEN
       vs_ADR_FOREIGN_TX_SW := 'N';	--
   END IF;--

   IF vs_forgin_state IS NULL OR LTRIM(RTRIM(vs_forgin_state)) = '' THEN
       vs_ADR_FOREIGN_STATE_SW := 'N';	--
   END IF;--

   IF vs_country_tx IS NULL OR LTRIM(RTRIM(vs_country_tx)) = '' THEN
       vs_ADR_COUNTRY_SW := 'N';	--
   END IF;--

   -- format X9X__X9X
--   IF vs_adr_postal_tx IS NULL OR LTRIM(RTRIM(vs_adr_postal_tx)) = '' THEN
--      SET vs_ADR_POSTAL_CODE_SW = 'N';	--
--   ELSE
--      SET vs_zip_DATA = LTRIM(RTRIM(vs_adr_postal_tx));--
--      SET vl_zipcd_len = LENGTH(vs_zip_DATA);--
--
--      IF vl_zipcd_len = 8 THEN
--         ZIPCD_CHECK:
--         WHILE vl_len_ctnr <= vl_zipcd_len DO
--           SET vs_ZIP_char = SUBSTR(vs_zip_DATA,vl_len_ctnr,1);--
--           SET vl_ASCII = ASCII(vs_ZIP_char);--
--
--           IF vl_len_ctnr in (1,3,6,8) THEN	
--      	      IF vl_ASCII < 65 OR vl_ASCII > 122 OR vl_ASCII IN (91,92,93,94,95,96) THEN
--      	         SET vs_ADR_POSTAL_CODE_SW = 'N';--
--      	         LEAVE ZIPCD_CHECK;--
--              END IF;--
--      	   ELSEIF vl_len_ctnr in (2, 7) THEN
--      	      IF vl_ASCII < 48 OR vl_ASCII > 57 THEN
--      	         SET vs_ADR_POSTAL_CODE_SW = 'N';--
--      	         LEAVE ZIPCD_CHECK;--
--              END IF;--
--      	   ELSE
--      	      IF vl_ASCII <> 32 THEN
--      	         SET vs_ADR_POSTAL_CODE_SW = 'N';--
--      	         LEAVE ZIPCD_CHECK;--
--      	      END IF;--
--      	   END IF;--
--
--           SET vl_len_ctnr = vl_len_ctnr + 1;--
--         END WHILE;--
--      ELSE
--         SET vs_ADR_POSTAL_CODE_SW = 'N';		--
--      END IF;--
--   END IF;--

      vs_zip_DATA := LTRIM(RTRIM(vs_adr_postal_tx));--
      vl_zipcd_len := LENGTH(vs_zip_DATA);--

     IF vl_zipcd_len > 0 THEN	
	     --ZIPCD_CHECK:
		 <<ZIPCD_CHECK>>
	    -- WHILE vl_len_ctnr <= vl_zipcd_len DO
		 loop EXIT WHEN vl_len_ctnr >= vl_zipcd_len ;

	            vs_ZIP_char := LTRIM(RTRIM(SUBSTR(vs_zip_DATA,vl_len_ctnr,1)));--
	
	           IF vs_ZIP_char <> '' THEN
	           	 vl_ASCII := ASCII(vs_ZIP_char);--
	
	              IF vl_ASCII < 48 OR vl_ASCII > 122 OR vl_ASCII IN (91,92,93,94,95,96,58,59,60,61,62,63,64) THEN
	                  vs_ADR_POSTAL_CODE_SW := 'N';--
	      	         --LEAVE ZIPCD_CHECK;--
					-- EXIT <<ZIPCD_CHECK>>;-- here need to get the alternate for leave
	              END IF;--
	      	   END IF;--
	      	
	            vl_len_ctnr := vl_len_ctnr + 1;--
	    -- END WHILE;--
		END LOOP;
     END IF; --

ELSE
     vl_return := -1;	--
END IF;--

IF vs_ADR_BOX_PO_NO_SW = 'N' OR vs_ADR_STREET_ROUTE_NO_SW = 'N' OR vs_ADR_STREET_NM_SW = 'N' OR vs_ADR_CITY_SW = 'N' OR vs_ADR_STATE_SW = 'N' OR vs_ADR_ZIP5_SW = 'N' OR vs_ADR_UNIT_SW = 'N' OR vs_ADR_FOREIGN_TX_SW = 'N' OR vs_ADR_FOREIGN_STATE_SW = 'N' OR vs_ADR_COUNTRY_SW = 'N' OR vs_ADR_POSTAL_CODE_SW = 'N' THEN
    

	 vl_return := -1;	--
     vs_ADR_SW := 'N';--
END IF;--

IF as_adr_type = '3357'	THEN -- Provider Location

  UPDATE TB_PROVIDER_DETAILS_CHECKLIST
     SET LOCN_ADR_FORMAT_CD = vs_adr_format_cd,
     	 LOCN_BOX_PO_NO_SW = vs_ADR_BOX_PO_NO_SW,
         LOCN_STREET_ROUTE_NO_SW = vs_ADR_STREET_ROUTE_NO_SW,
         LOCN_STREET_NM_SW = vs_ADR_STREET_NM_SW,
         LOCN_CITY_NM_SW = vs_ADR_CITY_SW,
         LOCN_STATE_CD_SW = vs_ADR_STATE_SW,
         LOCN_ZIP5_NO_SW = vs_ADR_ZIP5_SW,
         LOCN_UNIT_TYPE_SW = vs_ADR_UNIT_SW,
         LOCN_FOREIGN_TX_SW = vs_ADR_FOREIGN_TX_SW,
         LOCN_FOREIGN_STATE_TX_SW = vs_ADR_FOREIGN_STATE_SW,
         LOCN_COUNTRY_TX_SW = vs_ADR_COUNTRY_SW,
         LOCN_POSTAL_CODE_TX_SW = vs_ADR_POSTAL_CODE_SW,
         LOCN_ADR_SW = vs_ADR_SW,
         UPDATE_TS =  CURRENT_TIMESTAMP,
         UPDATE_USER_ID = as_user_id
   WHERE PROVIDER_ID = al_provider_id
	 AND DELETE_SW = 'N' ;--
	
   al_sqlcode := SQLCODE;--
  IF al_sqlcode <> 0  THEN
      as_error := 'Location Address Edits: UPDATE Provider Details Checklist FAILED.';--
    -- SIGNAL p_sp_error  ;--
  END IF ;--

ELSEIF as_adr_type = '3356' THEN -- Provider Payment

  UPDATE TB_PROVIDER_DETAILS_CHECKLIST
     SET PAY_ADR_FORMAT_CD = vs_adr_format_cd,
     	 PAY_BOX_PO_NO_SW = vs_ADR_BOX_PO_NO_SW,
         PAY_STREET_TX_SW = vs_ADR_STREET_NM_SW,
         PAY_STREET_ROUTE_NO_SW = vs_ADR_STREET_ROUTE_NO_SW,
         PAY_CITY_NM_SW = vs_ADR_CITY_SW,
         PAY_STATE_CD_SW = vs_ADR_STATE_SW,
         PAY_ZIP5_NO_SW = vs_ADR_ZIP5_SW,
         PAY_UNIT_TYPE_SW = vs_ADR_UNIT_SW,
         PAY_FOREIGN_TX_SW = vs_ADR_FOREIGN_TX_SW,
         PAY_FOREIGN_STATE_TX_SW = vs_ADR_FOREIGN_STATE_SW,
         PAY_COUNTRY_TX_SW = vs_ADR_COUNTRY_SW,
         PAY_POSTAL_CODE_TX_SW = vs_ADR_POSTAL_CODE_SW,
         PAY_ADR_SW = vs_ADR_SW,
         UPDATE_TS =  CURRENT_TIMESTAMP,
         UPDATE_USER_ID = as_user_id
   WHERE PROVIDER_ID = al_provider_id
	 AND DELETE_SW = 'N' ;--

   al_sqlcode := SQLCODE;--
  IF al_sqlcode <> 0  THEN
      as_error := 'Payment Address Edits: UPDATE Provider Details Checklist FAILED.';--
     --SIGNAL p_sp_error  ;--
  END IF ;--
END IF;--

 al_sqlcode := v_sqlcode;--
 al_OUTPUT := vl_return;--

END;

$BODY$;


