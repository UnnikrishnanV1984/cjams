CREATE OR REPLACE FUNCTION cjams.sp_financial_edits(al_provider_id bigint, as_user_id character varying, as_tickler_activity character, OUT al_output integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- 12/10/2007 Vineet Tirodkar
--
-- To perform Financial edits to ensure that all fields required to produce a payment are entered.
-- 02/01/2008 Vineet Tirodkar - to add one more argument as_tickler_activity, to do tickler activity or not. # 16706
-- 02/13/2008 Vineet Tridokar - Commented County and Resource worker checks
--      - Call of New Procedure SP_FM_EDITS_TICKLERS # 16810 / CIS-16755
-- 02/25/2008 Vineet Tirodkar - Changes done on Provider Profile ue_postsave for Tickler Activity # 16706 / CIS-16755
-- 03/26/2008 Vineet Tirodkar - Un-commented County and Resource worker checks as per UAT
-- 04/14/2008 Vineet Tirodkar - To call SP_VALIDATE_SSN for SSN Check
-- 05/09/2008 Vineet Tirodkar - Exclude Checks for COUNTY & Resource Worker if as_user_id = 'Interface' # 17505
-- 05/27/2008 Vineet Tirodkar - Commented Resource worker check
-- 06/12/2014 Andy Rubey - Fix Tax Identification Type of N/A - Project Request: PRJ-04409 - Req #4
-- 09/15/2020 Vineet Tirodkar - To Add Adult Services Service Plan Provider Category
-- 08/05/2021 Vineet Tirodkar - Modifications for New Category 3794 - Residential Treatment Center (CDM-15776)
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration
-- 11/22/2022 - Vineet Tirodkar - To Fix type casting issue Aurora DB migration
-- 9/12/2023 -- Chandra/Palani -- Query optimization (CIDM-7911)
------------------------------------------------------------------------

DECLARE vs_provider_cat VARCHAR(5) DEFAULT NULL ;
DECLARE vs_vendor VARCHAR(5) DEFAULT NULL ;
DECLARE vs_community VARCHAR(5) DEFAULT NULL ;
DECLARE vs_as_service_plan_cat VARCHAR(5) DEFAULT NULL ;

DECLARE vs_Prov_cat_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vl_AFF_PROVIDER_ID BIGINT DEFAULT NULL;
DECLARE vl_provider_for_address BIGINT ;

DECLARE vl_ASSIGN_TO_STAFF_ID BIGINT DEFAULT NULL;
DECLARE vs_ASSIGN_TO_STAFF_ID_SW VARCHAR(1) DEFAULT 'Y';

DECLARE vs_TAX_TYPE_CD VARCHAR(5) DEFAULT NULL ;
DECLARE vs_TAX_TYPE_CD_SW VARCHAR(1) DEFAULT 'Y';

DECLARE vs_MAIL_CODE_TX VARCHAR(20) DEFAULT NULL ;
DECLARE vs_MAIL_CODE_TX_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vs_INDICATOR_1099 VARCHAR(1) DEFAULT NULL ;
DECLARE vs_INDICATOR_1099_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vs_COUNTY_CD VARCHAR(5) DEFAULT NULL ;
DECLARE vs_COUNTY_CD_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vs_PAY_TO_AFFILIATE_CD VARCHAR(5) DEFAULT NULL ;
DECLARE vs_PAY_TO_AFFILIATE_CD_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vl_TAX_ID_NO INTEGER DEFAULT NULL ;
DECLARE vs_TAX_ID_NO_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vl_locn_add_id BIGINT DEFAULT NULL ;
DECLARE vs_locn_add_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vl_payt_add_id BIGINT DEFAULT NULL ;
DECLARE vs_payt_add_SW VARCHAR(1) DEFAULT 'Y' ;

DECLARE vs_pay_to_aff VARCHAR(5) DEFAULT NULL ;
DECLARE vs_adr_type VARCHAR(5) ;

DECLARE VL_OUTPUT INT ;
DECLARE vl_return INT DEFAULT 1 ;
DECLARE vl_Checklist_cnt INT DEFAULT 0 ;
DECLARE VL_SSN_OUTPUT INT DEFAULT 1;

DECLARE vs_LOCN_ADR_MISSING VARCHAR(1) DEFAULT 'N' ;
DECLARE vs_PAY_ADR_MISSING VARCHAR(1) DEFAULT 'N' ;

DECLARE vs_NULL VARCHAR(1) ;
DECLARE vs_activity_type varchar(15);
DECLARE vs_tickler_user_id VARCHAR(10);
DECLARE vs_string VARCHAR(5);
DECLARE vl_entity_id1 bigint ;
DECLARE vl_entity_id2 bigint ;

-- Log Error

DECLARE SQLCODE INT DEFAULT 0;
DECLARE al_sqlcode INT DEFAULT 0;
DECLARE as_error VARCHAR(3000);
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
--DECLARE p_sp_error CONDITION FOR SQLSTATE '99999' ;--
p_sp_error CHAR(5);
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';
DECLARE vl_ret_status INTEGER DEFAULT 0;
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_FINANCIAL_EDITS';
DECLARE vs_identity_column VARCHAR(100);
DECLARE vs_identity_val VARCHAR(100);
DECLARE GOTO_DO_NOT_CHECK INTEGER DEFAULT 0;
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN

BEGIN
EXCEPTION WHEN OTHERS THEN
RAISE NOTICE '>>>>Inside sp_financial_edits excepiton--END---';
--GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;
--vs_message_text :=  MESSAGE_TEXT;
--    SET al_sqlcode = -1 ;--
as_error = COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;
as_error = COALESCE(as_error ,'') || '::RO ' || COALESCE(vs_identity_column ,'N/A') || ' :: ' || COALESCE(vs_identity_val ,'');
as_error = as_error || COALESCE(vs_message_text ,'');

SELECT SP_BATCH_ERROR_LOG ( 'SP_BATCH_PROV_CHECKLIST'::character varying ,
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
RETURN;
END;

--Log error

 vs_NULL := NULL;

SELECT F_PRVPCKLST_CAT(TB_PROVIDER.PROVIDER_ID::bigint,'PLACEMENT') AS PLACEMENT ,
       F_PRVPCKLST_CAT(TB_PROVIDER.PROVIDER_ID::bigint,'VENDOR') AS VENDOR ,
       F_PRVPCKLST_CAT(TB_PROVIDER.PROVIDER_ID::bigint,'COMMUNITY') AS COMMUNITY,
  F_PRVPCKLST_CAT(TB_PROVIDER.PROVIDER_ID::bigint,'ASSERVICEPLAN')
INTO vs_provider_cat,
      vs_vendor,
      vs_community,
 vs_as_service_plan_cat
FROM TB_PROVIDER
WHERE TB_PROVIDER.PROVIDER_ID  = al_provider_id
    AND DELETE_SW = 'N' ;

IF vs_provider_cat = '1783' OR vs_provider_cat = '1785' THEN -- PUBLIC PROVIDER
   -- For Addtional Edits Category wise

ELSEIF vs_provider_cat is NOT NULL AND vs_provider_cat <> '1782' THEN-- PRIVATE PROVIDER, Other Than CPA Home
   -- For Addtional Edits Category wise
  GOTO_DO_NOT_CHECK:=0;
ELSEIF vs_vendor = '3304' THEN -- VENDOR
   -- For Addtional Edits Category wise
  GOTO_DO_NOT_CHECK:=0;
ELSEIF vs_community = '3305' OR vs_provider_cat = '1782'  THEN -- COMMUNITY PROVIDER OR CPA Home
    -- CHESSIE don't pay to COMMUNITY PROVIDERS and CPA Home
    -- GOTO DO_NOT_CHECK;--
-- GOTO DO_NOT_CHECK;
GOTO_DO_NOT_CHECK:=1;
ELSEIF vs_as_service_plan_cat = '1787' THEN -- Service Plan Provider
GOTO_DO_NOT_CHECK:=0;
ELSE
IF GOTO_DO_NOT_CHECK != 1 THEN
     vs_Prov_cat_SW := 'N';
GOTO_DO_NOT_CHECK:=0;
END IF;
END IF;

IF GOTO_DO_NOT_CHECK != 1 THEN
-- Required Fields Check - START
SELECT PROV_TAX_TYPE_CD,
       TAX_ID_NO,
       MAIL_CODE_TX,
       INDICATOR_1099_SW,
       COUNTY_CD,
       PAY_TO_AFFILIATE_CD,
       AFFILIATE_PROVIDER_ID
 INTO vs_TAX_TYPE_CD,
  vl_TAX_ID_NO,
  vs_MAIL_CODE_TX,
  vs_INDICATOR_1099,
  vs_COUNTY_CD,
  vs_PAY_TO_AFFILIATE_CD,
  vl_AFF_PROVIDER_ID
  FROM TB_PROVIDER
WHERE PROVIDER_ID = al_provider_id
 AND DELETE_SW = 'N' ;

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'Error in selecting Provider Details'  ;
vs_identity_column := 'Provider ID';
vs_identity_val := (al_provider_id)::character varying;
-- SIGNAL p_sp_error  ;--
END IF;

IF vs_TAX_TYPE_CD Is NULL OR RTRIM(LTRIM(vs_TAX_TYPE_CD)) = '' OR RTRIM(LTRIM(vs_TAX_TYPE_CD)) = '4970' THEN
vs_TAX_TYPE_CD_SW := 'N' ;
ELSE
vs_TAX_TYPE_CD_SW := 'Y' ;
END IF;

IF vl_TAX_ID_NO Is NULL OR vl_TAX_ID_NO = 0 THEN
vs_TAX_ID_NO_SW := 'N' ;
ELSE
--Call SP_VALIDATE_SSN for Tax Tpe as SSN (2518)
IF vs_TAX_TYPE_CD_SW = 'Y' AND RTRIM(LTRIM(vs_TAX_TYPE_CD)) = '2518' THEN
SELECT SP_VALIDATE_SSN(vl_TAX_ID_NO) a into VL_SSN_OUTPUT;

IF VL_SSN_OUTPUT = 1 THEN
vs_TAX_ID_NO_SW := 'Y';
ELSE
vs_TAX_ID_NO_SW := 'N';
END IF;
ELSE
vs_TAX_ID_NO_SW := 'Y' ;
END IF;
END IF;

IF vs_MAIL_CODE_TX Is NULL OR RTRIM(LTRIM(vs_MAIL_CODE_TX)) = '' THEN
vs_MAIL_CODE_TX_SW :='N' ;
ELSE
vs_MAIL_CODE_TX_SW :='Y' ;
END IF;

IF vs_INDICATOR_1099 Is NULL OR RTRIM(LTRIM(vs_INDICATOR_1099)) = '' THEN
vs_INDICATOR_1099_SW := 'N' ;
ELSE
vs_INDICATOR_1099_SW := 'Y' ;
END IF;

-- DO Not Check COUNTY - 02/13/2008
-- Check COUNTY - 03/26/2008 as per UAT
IF vs_COUNTY_CD Is NULL OR RTRIM(LTRIM(vs_COUNTY_CD)) = '' THEN
vs_COUNTY_CD_SW := 'N' ;
ELSE
vs_COUNTY_CD_SW := 'Y' ;
END IF;

IF vs_PAY_TO_AFFILIATE_CD Is NULL OR RTRIM(LTRIM(vs_PAY_TO_AFFILIATE_CD)) = '' THEN
vs_PAY_TO_AFFILIATE_CD_SW := 'N' ;
ELSE
vs_PAY_TO_AFFILIATE_CD_SW := 'Y' ;
END IF;

-- DO Not Check for Resource Worker - 02/13/2008
-- Check for Resource Worker - 03/26/2008 as per UAT
-- DO Not Check for Resource Worker - 05/27/2008
--Provider - Resource Worker
--  SELECT ASSIGN_TO_STAFF_ID
--      INTO vl_ASSIGN_TO_STAFF_ID
--    FROM TB_ASSIGNMENT
--  WHERE ENTITY_KEY_ID = al_provider_id
--      AND RESPONSIBILITY_CD = 'P'
--      AND ENTITY_TYPE_CD = '2953'
--      AND DELETE_SW = 'N'
--      AND END_DT IS NULL ;--

--IF vl_ASSIGN_TO_STAFF_ID IS NULL OR vl_ASSIGN_TO_STAFF_ID = 0 THEN
--   SET vs_ASSIGN_TO_STAFF_ID_SW = 'N';--
--ELSE
--   SET vs_ASSIGN_TO_STAFF_ID_SW = 'Y';--
--END IF;--

-- Required Fields Check - END

-- Update Provider Details Checklist Table - START
vl_Checklist_cnt := 0; --INITIAL VALUE

SELECT COUNT(*)
  INTO vl_Checklist_cnt
FROM TB_PROVIDER_DETAILS_CHECKLIST
WHERE PROVIDER_ID = al_provider_id
 AND DELETE_SW = 'N' ;

IF vl_Checklist_cnt > 0 THEN
DELETE FROM TB_PROVIDER_DETAILS_CHECKLIST
WHERE PROVIDER_ID  = al_provider_id
AND DELETE_SW = 'N';

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'Delete Failed on Provider Details Checklist Table'  ;
vs_identity_column := 'Provider ID';
vs_identity_val := (al_provider_id)::character varying;
--SIGNAL p_sp_error  ;--
END IF;
END IF;

INSERT INTO TB_PROVIDER_DETAILS_CHECKLIST
         ( PROVIDER_ID,
           PROVIDER_CATEGORY_SW,
           TAX_ID_TYPE_SW,
           TAX_ID_SW,
           MAIL_CODE_SW,
           INDICATOR_1099_SW,
           SEND_PAYMENT_TO_SW,
           LOCAL_DEPARTMENT_SW,
           RESOURCE_WORKER_SW,
           CREATE_TS,
           CREATE_USER_ID,
           UPDATE_TS,
           UPDATE_USER_ID,
           DELETE_SW )
VALUES ( al_provider_id,
           vs_Prov_cat_SW,
           vs_TAX_TYPE_CD_SW,
           vs_TAX_ID_NO_SW,
           vs_MAIL_CODE_TX_SW,
           vs_INDICATOR_1099_SW,
           vs_PAY_TO_AFFILIATE_CD_SW,
           vs_COUNTY_CD_SW,
           vs_ASSIGN_TO_STAFF_ID_SW,
           CURRENT_TIMESTAMP,
           as_user_id,
           CURRENT_TIMESTAMP,
           as_user_id,
           'N' )  ;

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'INSERT INTO Provider Details Checklist FAILED.'  ;
vs_identity_column := 'Provider ID';
vs_identity_val := (al_provider_id)::character varying;
--SIGNAL p_sp_error  ;--
--    ELSE
--        Commit ;--
END IF;

-- Update Provider Details Checklist Table - END

-- Addresses Check - START
vl_provider_for_address := al_provider_id;

-- Location Address - START
SELECT MAX(ADDRESS_ID)
INTO vl_locn_add_id
FROM TB_PROVIDER_ADDRESSES
WHERE PARENT_KEY_ID = vl_provider_for_address::varchar
AND ADR_TYPE_CD =  '3357'
AND DELETE_SW = 'N'
AND ADR_DEFAULT_SW = 'Y';
   

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'Error in selecting Provider Location Address'  ;
vs_identity_column := 'Provider ID';
vs_identity_val := (al_provider_id)::character varying;
--SIGNAL p_sp_error  ;--
END IF;

--Addtional Check for Location address format wise
IF vl_locn_add_id > 0 THEN
vs_LOCN_ADR_MISSING := 'N';
-- CALL New Procedure for address format Check
-- Set the SW accordingly

SELECT a.al_OUTPUT,a.al_sqlcode,a.as_error
from SP_ADDRESS_EDITS(vl_locn_add_id, al_provider_id, '3357', as_user_id) a
INTO  VL_OUTPUT, al_sqlcode, as_error;

IF al_sqlcode <> 0 THEN
as_error := as_error  ;
IF as_error is NULL OR as_error = '' THEN
as_error := 'SP_ADDRESS_EDITS failed.';
vs_identity_column := 'Provider ID/ Address ID';
vs_identity_val := (al_provider_id)::character varying || '/ ' || (vl_locn_add_id)::character varying ;
END IF;
-- SIGNAL p_sp_error  ;
END IF ;

IF VL_OUTPUT = 1 THEN
vs_locn_add_SW := 'Y';
ELSE
vs_locn_add_SW := 'N';
END IF;
ELSE
       vs_locn_add_SW := 'N';
       vs_LOCN_ADR_MISSING := 'Y';
END IF;

--Update TB_PROVIDER_DETAILS_CHECKLIST for LOCN add Missing
IF vs_LOCN_ADR_MISSING = 'Y' THEN
UPDATE TB_PROVIDER_DETAILS_CHECKLIST
SET LOCN_ADR_FORMAT_CD = vs_NULL,
LOCN_BOX_PO_NO_SW = vs_NULL,
LOCN_STREET_ROUTE_NO_SW = vs_NULL,
LOCN_STREET_NM_SW = vs_NULL,
LOCN_CITY_NM_SW = vs_NULL,
LOCN_STATE_CD_SW = vs_NULL,
LOCN_ZIP5_NO_SW = vs_NULL,
LOCN_UNIT_TYPE_SW = vs_NULL,
LOCN_FOREIGN_TX_SW = vs_NULL,
LOCN_FOREIGN_STATE_TX_SW = vs_NULL,
LOCN_COUNTRY_TX_SW = vs_NULL,
LOCN_POSTAL_CODE_TX_SW = vs_NULL,
LOCN_ADR_SW = 'N',
UPDATE_TS =  CURRENT_TIMESTAMP,
UPDATE_USER_ID = as_user_id
WHERE PROVIDER_ID = al_provider_id
AND DELETE_SW = 'N' ;
   
al_sqlcode := SQLCODE;
IF al_sqlcode <> 0  THEN
as_error := 'Location Address Missing: UPDATE Provider Details Checklist FAILED.';
--SIGNAL p_sp_error  ;--
END IF ;
END IF;
-- Location Address - END

-- Payment Address - START

-- Send Payment to
IF vs_PAY_TO_AFFILIATE_CD is NOT NULL THEN
-- SET vs_PAY_TO_AFFILIATE_CD_SW = 'Y';
IF vs_PAY_TO_AFFILIATE_CD = '3366' THEN -- same as provider
vs_payt_add_SW := vs_locn_add_SW ;

IF vs_LOCN_ADR_MISSING = 'N' THEN

UPDATE TB_PROVIDER_DETAILS_CHECKLIST
SET PAY_ADR_FORMAT_CD = LOCN_ADR_FORMAT_CD,
PAY_BOX_PO_NO_SW = LOCN_BOX_PO_NO_SW,
PAY_STREET_ROUTE_NO_SW = LOCN_STREET_ROUTE_NO_SW,
PAY_STREET_TX_SW = LOCN_STREET_NM_SW,
PAY_CITY_NM_SW = LOCN_CITY_NM_SW,
PAY_STATE_CD_SW = LOCN_STATE_CD_SW,
PAY_ZIP5_NO_SW = LOCN_ZIP5_NO_SW,
PAY_UNIT_TYPE_SW = LOCN_UNIT_TYPE_SW,
PAY_FOREIGN_TX_SW = LOCN_FOREIGN_TX_SW,
PAY_FOREIGN_STATE_TX_SW = LOCN_FOREIGN_STATE_TX_SW,
PAY_COUNTRY_TX_SW = LOCN_COUNTRY_TX_SW,
PAY_POSTAL_CODE_TX_SW = LOCN_POSTAL_CODE_TX_SW,
PAY_ADR_SW = LOCN_ADR_SW,
UPDATE_TS =  CURRENT_TIMESTAMP,
UPDATE_USER_ID = as_user_id
  WHERE PROVIDER_ID = al_provider_id
AND DELETE_SW = 'N' ;
   
al_sqlcode := SQLCODE;
IF al_sqlcode <> 0  THEN
as_error := 'Payment Add same as Location Add: UPDATE Provider Details Checklist FAILED.';
--SIGNAL p_sp_error  ;--
END IF ;
ELSE
vs_PAY_ADR_MISSING := 'Y' ;
END IF;

ELSEIF vs_PAY_TO_AFFILIATE_CD = '3367' THEN  -- a different address

SELECT MAX(ADDRESS_ID)
INTO vl_payt_add_id
FROM TB_PROVIDER_ADDRESSES
WHERE PARENT_KEY_ID = vl_provider_for_address::varchar
  AND ADR_TYPE_CD = '3356'
  AND DELETE_SW = 'N'
  AND ADR_DEFAULT_SW = 'Y';
   

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'Error in selecting Provider Payment Address'  ;
vs_identity_column := 'Provider ID';
vs_identity_val := (al_provider_id)::character varying;
--SIGNAL p_sp_error  ;--
END IF;


--Addtional Check for Payment address format wise
IF vl_payt_add_id > 0 THEN
vs_PAY_ADR_MISSING := 'N' ;
-- CALL New Procedure for address format Check
-- Set the SW accordingly
SELECT a.al_OUTPUT,a.al_sqlcode,a.as_error
from SP_ADDRESS_EDITS(vl_payt_add_id, al_provider_id, '3356', as_user_id) a
into VL_OUTPUT, al_sqlcode, as_error;
       
IF al_sqlcode <> 0 THEN
as_error := as_error  ;
IF as_error is NULL OR as_error = '' THEN
as_error := 'SP_ADDRESS_EDITS failed.';
vs_identity_column := 'Provider ID/ Address ID';
vs_identity_val := (al_provider_id)::character varying || '/ ' || (vl_payt_add_id)::character varying ;
END IF;
--SIGNAL p_sp_error  ;--
END IF ;

IF VL_OUTPUT = 1 THEN
vs_payt_add_SW := 'Y';
ELSE
vs_payt_add_SW := 'N';
END IF;
ELSE
vs_payt_add_SW := 'N';
vs_PAY_ADR_MISSING := 'Y';
END IF;

ELSEIF vs_PAY_TO_AFFILIATE_CD = '3368' THEN -- send payment to affiliate org
vl_provider_for_address := vl_AFF_PROVIDER_ID;

SELECT PAY_TO_AFFILIATE_CD
INTO vs_pay_to_aff
FROM TB_PROVIDER
WHERE PROVIDER_ID = vl_provider_for_address
AND DELETE_SW = 'N';

IF vs_pay_to_aff is NOT NULL THEN        
IF vs_pay_to_aff = '3366' THEN -- same as provider
vs_adr_type := '3357';
ELSEIF vs_pay_to_aff = '3367' THEN  -- a different address
vs_adr_type := '3356';
END IF;


SELECT MAX(ADDRESS_ID)
INTO vl_payt_add_id
FROM TB_PROVIDER_ADDRESSES
WHERE PARENT_KEY_ID = vl_provider_for_address::varchar
             AND ADR_TYPE_CD = vs_adr_type
             AND DELETE_SW = 'N'
             AND ADR_DEFAULT_SW = 'Y';

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0 THEN
as_error := 'Error in selecting Provider Payment Address'  ;
vs_identity_column := 'Aff Provider ID/ AFF Prov ID';
vs_identity_val := (vl_provider_for_address)::character varying ||'/ ' || (vl_provider_for_address)::character varying;
--SIGNAL p_sp_error  ;--
END IF;

--Addtional Check for Payment address format wise
IF vl_payt_add_id > 0 THEN
vs_PAY_ADR_MISSING := 'N';
-- CALL New Procedure for address format Check
-- Set the SW accordingly
SELECT a.al_OUTPUT,a.al_sqlcode,a.as_error
from SP_ADDRESS_EDITS(vl_payt_add_id, al_provider_id, '3356', as_user_id) a
into VL_OUTPUT, al_sqlcode, as_error;

IF al_sqlcode <> 0 THEN
as_error := as_error  ;
IF as_error is NULL OR as_error = '' THEN
as_error := 'SP_ADDRESS_EDITS failed.';
vs_identity_column := 'Aff Provider ID/ Address ID';
vs_identity_val := (vl_provider_for_address)::character varying || '/ ' || (vl_payt_add_id)::character varying  ;
END IF;
-- SIGNAL p_sp_error  ;--
END IF ;

IF VL_OUTPUT = 1 THEN
vs_payt_add_SW := 'Y';
ELSE
vs_payt_add_SW := 'N';
END IF;
ELSE
vs_payt_add_SW := 'N';
vs_PAY_ADR_MISSING := 'Y';
END IF;
ELSE
vs_payt_add_SW := 'N';
vs_PAY_ADR_MISSING := 'Y';
END IF;
END IF;
ELSE
-- SET vs_PAY_TO_AFFILIATE_CD_SW = 'N'; --
       vs_payt_add_SW := 'N';
       vs_PAY_ADR_MISSING := 'Y';
END IF;

--Update TB_PROVIDER_DETAILS_CHECKLIST for LOCN add Missing
IF vs_PAY_ADR_MISSING = 'Y' THEN

UPDATE TB_PROVIDER_DETAILS_CHECKLIST
SET PAY_ADR_FORMAT_CD = vs_NULL,
PAY_BOX_PO_NO_SW = vs_NULL,
            PAY_STREET_TX_SW = vs_NULL,
            PAY_STREET_ROUTE_NO_SW = vs_NULL,
            PAY_CITY_NM_SW = vs_NULL,
            PAY_STATE_CD_SW = vs_NULL,
            PAY_ZIP5_NO_SW = vs_NULL,
            PAY_UNIT_TYPE_SW = vs_NULL,
            PAY_FOREIGN_TX_SW = vs_NULL,
            PAY_FOREIGN_STATE_TX_SW = vs_NULL,
            PAY_COUNTRY_TX_SW = vs_NULL,
            PAY_POSTAL_CODE_TX_SW = vs_NULL,
            PAY_ADR_SW = 'N',
            UPDATE_TS =  CURRENT_TIMESTAMP,
            UPDATE_USER_ID = as_user_id
WHERE PROVIDER_ID = al_provider_id
        AND DELETE_SW = 'N' ;

al_sqlcode := SQLCODE;
IF al_sqlcode <> 0  THEN
as_error := 'Payment Address Missing: UPDATE Provider Details Checklist FAILED.';
-- SIGNAL p_sp_error  ;--
END IF ;
END IF;
-- Payment Address - END
-- Addresses Check - END

IF vs_Prov_cat_SW = 'N' OR vs_ASSIGN_TO_STAFF_ID_SW = 'N' OR vs_TAX_TYPE_CD_SW = 'N' OR vs_MAIL_CODE_TX_SW = 'N' OR vs_INDICATOR_1099_SW = 'N' OR vs_COUNTY_CD_SW = 'N' OR vs_PAY_TO_AFFILIATE_CD_SW = 'N' OR vs_TAX_ID_NO_SW = 'N' OR vs_locn_add_SW = 'N' OR vs_payt_add_SW = 'N' THEN
vl_return := -1;
END IF;

--Commit ;--

IF as_tickler_activity = 'Y' THEN -- Placment Validation Screen
IF vl_return = -1 THEN -- Info Missing
-- 'INFO_MISSING' - Create Tickler # 409
vs_activity_type := 'INFO_MISSING';
vs_tickler_user_id := 'finance';
vs_string := '';
vl_entity_id1 := 0;
vl_entity_id2 := 0;
ELSE -- Info Okay
-- This is temporary remove after changes made in Provider Profile ue_postsave (Do NOTHING)
-- 'INFO_CORRECTED' - Delete Tickler # 409
--      SET vs_activity_type = 'INFO_CORRECTED';--
--      SET vs_tickler_user_id = as_user_id;--
--      SET vs_string = '';--
--      SET vl_entity_id1 = 0;--
--      SET vl_entity_id2 = 0;--
 -- This is temporary remove after changes made in Provider Profile ue_postsave (Do NOTHING)

-- Do Nothing
vs_activity_type := '';
END IF;
ELSEIF as_tickler_activity = 'X' THEN -- Provider Profile ue_postsave
IF vl_return = -1 THEN -- Info Missing
-- Do Nothing
vs_activity_type := '';
ELSE -- Info Okay
-- 'INFO_CORRECTED' - Delete Tickler # 409 and Create Tickler # 410
vs_activity_type := 'INFO_CORRECTED';
vs_tickler_user_id := as_user_id;
vs_string := '';
vl_entity_id1 := 0;
vl_entity_id2 := 0;
END IF;
ELSE
vs_activity_type := '';
END IF;

IF vs_activity_type <> '' THEN
PERFORM FROM SP_FM_EDITS_TICKLERS(al_provider_id,
      vs_activity_type,
    vs_tickler_user_id,
    vs_string,
    vl_entity_id1,
    vl_entity_id2) ;

END IF;
                             
--DO_NOT_CHECK:
--<<DO_NOT_CHECK>>--here
END IF;

IF UPPER(as_user_id) = 'INTERFACE' THEN
   IF vs_Prov_cat_SW = 'N' OR vs_TAX_TYPE_CD_SW = 'N' OR vs_MAIL_CODE_TX_SW = 'N' OR vs_INDICATOR_1099_SW = 'N' OR vs_PAY_TO_AFFILIATE_CD_SW = 'N' OR vs_TAX_ID_NO_SW = 'N' OR vs_locn_add_SW = 'N' OR vs_payt_add_SW = 'N' THEN
       vl_return := -1;
   ELSE
       vl_return := 1;
   END IF;
END IF;

al_OUTPUT := vl_return;

END;

$function$
;
