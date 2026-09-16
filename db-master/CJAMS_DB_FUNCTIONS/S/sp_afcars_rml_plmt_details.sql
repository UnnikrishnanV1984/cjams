CREATE OR REPLACE FUNCTION cjams.sp_afcars_rml_plmt_details(adt_from character varying, adt_to character varying, as_run_type character, al_client_id integer, al_removal_id bigint, ad_removal_dt date, ad_return_dt date, al_case_id bigint)
 RETURNS TABLE(as_num_placements character varying, as_first_removal_dt character varying, as_num_removals character varying, as_last_discharge_dt character varying, as_latest_removal_dt character varying, as_removal_transaction_dt character varying, as_placement_dt character varying, as_removal_type_cd character varying, as_out_of_state_placement_sw character varying, as_placement_settg_cd character varying, as_case_plan_goal_cd character varying, as_discharge_reason_cd character varying, as_discharge_transaction_dt character varying, as_discharge_dt character varying, al_placement_id integer, as_periodic_review_dt character varying, vl_excep_message integer)
 LANGUAGE plpgsql
AS $function$
DECLARE

VD_REMOVAL_DT 			DATE 	    DEFAULT NULL;--
VD_RETURN_DT 			DATE 	    DEFAULT NULL;--
AD_RETURN_DT1			DATE 	    DEFAULT NULL;
VD_ORI_REMOVAL_DT 		DATE 	    DEFAULT NULL;--
VDT_YEAR_MNTH_DAY     		DATE        DEFAULT NULL;--
VD_EXIT_DT 			DATE        DEFAULT NULL;--
VD_TEMP_RETURN_DT 		DATE        DEFAULT NULL;--
VD_PREV_ENTRY_DT 		DATE;--
VD_DOB_DT               	DATE;--
VD_ENTRY_DT  			DATE;--
VD_PREV_EXIT_DT 		DATE;--
VD_TP_ENTRY_DT 			DATE;--
VD_TP_EXIT_DT 			DATE;--
VD_TP_CPA_ENTRY_DT 		DATE;--
VD_TP_CPA_EXIT_DT 		DATE;--
AFCARS_RETURN_DT 		DATE;--
 VD_LA_START_DT  	        DATE ;--
 VD_LA_END_DT   	        DATE;--
 VD_PREV_LA_START_DT  	        DATE ;--
 VD_PREV_LA_END_DT   	        DATE;--
 VD_PERIOD_END_DT               DATE;--
 VD_PERIOD_DIS_DATE             DATE;--

VD_PREV_CPA_ENTRY_DT 		DATE;--
VD_RETURN_TRANS_TS              DATE;--
VD_PREV_CPA_EXIT_DT 		DATE;--
VD_TEMP_START_DT        	DATE;--
VD_21_BIRTH_DAY         	DATE;--
VD_18_BIRTH_DAY         	DATE;--
VD_LA_RH_START_DT       	DATE;--
VD_LA_RH_END_DT         	DATE;--


VD_CPA_ENTRY_DT         	DATE;--
VD_DIS_DATE             	DATE;--
VD_CPA_EXIT_DT          	DATE;--
VS_DISCHARGE_DT         	DATE;--
VS_DISCHARGE_TRANSACTION_DT 	DATE;--
VDT_7MTH_DT                 DATE;--
VDT_HEARING_DT              DATE;--
VD_DUMMY_ENTRY_DT           DATE;--
VD_DUMMY_EXIT_DT            DATE;--
PREV_TEMP_END_DT            DATE;--
PREV_TEMP_START_DT          DATE;--
VD_TEMP_DISC_TRANS_DT       DATE   DEFAULT  NULL;--
VD_TEMP_REML_TRANS_DT       DATE   DEFAULT  NULL;--

VS_REMOVAL_TYPE   		VARCHAR(6)  DEFAULT NULL;--
VS_PROV_CAT 			VARCHAR(5);--
VS_TP_PROVIDER_TYPE 		VARCHAR(4);--
VS_TABLE_NAME 			VARCHAR(50) DEFAULT  'TB_AFCARS_REFERENCE';--
VS_PROGRAM_NM           	VARCHAR(50) DEFAULT  'AFCARS_FOSTERCARE';--
VS_BATCH_NO             	VARCHAR(5)  DEFAULT  '000';--
VS_AFCARS_TYPE_CD 		VARCHAR(1)  DEFAULT  'F';--
VS_PICKLIST_VALUE_CD 		VARCHAR(10) DEFAULT  NULL;--
VS_CASE_PLAN_GOAL_CD 		VARCHAR(1)  DEFAULT  '7';--
 VS_YEAR                	VARCHAR(4);--
VS_MONTH                	VARCHAR(2);--
VS_PROVIDER_TYPE        	VARCHAR(5);--
VS_PREV_PROVIDER_TYPE 		VARCHAR(4);--
IVE_STATUS              	VARCHAR(10);--
VS_SERVICE_CD                   VARCHAR(10);--
VS_DAY                  	VARCHAR(2);--
VS_TYPE_cd                      VARCHAR(2);--
VS_DISCHARGE_REASON_CD  	VARCHAR(10);--
VS_EXIT_REASON_CD               VARCHAR(10) DEFAULT NULL;--
VS_TEMP_TYPE            	VARCHAR(2) ;--
VS_PRE_PROVIDER_TYPE VARCHAR(4)  DEFAULT NULL;--
VS_NXT_PROVIDER_TYPE VARCHAR(4)  DEFAULT NULL;--
VS_MESSAGE      		VARCHAR(1000);--
AS_ERROR                        VARCHAR(1000);--

 VS_PREV_LIVING_CD  	        VARCHAR(10);--
 VS_LIVING_CD  		        VARCHAR(10);--
VS_AGE_OUT_SW           	CHAR(1);--
VS_PLACEMENT_SW                 CHAR(1) ;--


VN_PL_COUNT 			INTEGER     DEFAULT 0;--
VN_B_CLIENT_ID 			INTEGER     DEFAULT 0;--
VN_PROVIDER_ID  		INTEGER     DEFAULT 0;--
VN_LD_COUNT 			INTEGER     DEFAULT 0;--
VN_PREV_CPA_HOME  		INTEGER     DEFAULT 0;--
VN_LA_COUNT 			INTEGER     DEFAULT 0;--
VN_CURR_CPA_HOME 		INTEGER     DEFAULT 0;--
VN_TP_CLIENT_ID  		INTEGER;--
VN_TP_PLACEMENT_ID 		INTEGER;--
VN_TP_ORIG_PLACEMENT_ID 	INTEGER;--
VN_TP_REMOVAL_ID 		INTEGER;--
VN_TP_NUM 			INTEGER;--
VN_TP_PROVIDER_ID 		INTEGER;--
VN_CLIENT_ID 			INTEGER;--
VN_OPTION_ID 			INTEGER;--
VN_NUM  			INTEGER;--
PL_NUM                          INTEGER;--
PRE_LA_TYPE 			INTEGER;--
VN_PLACEMENT_ID 		INTEGER;--
VN_TP_CPA_HOME 			INTEGER;--
VN_PREV_PROVIDER_ID 		INTEGER;--
VL_TOTAL_PLACEMENTS     	INTEGER;--
 VN_AGE                 	INTEGER;--
VD_TP_PLACEMENT_ID      	INTEGER;--
VL_LENGTH 	        	INTEGER;--
VL_OUTPUT_SQLCODE       	VARCHAR;--
VL_TOTAL_REMOVAL        	INTEGER;--
 VL_ID                  	INTEGER;--
VN_TEMP_PLACE_ID        	INTEGER;--
VN_REMOVAL_ID          		INTEGER;--
VN_ORIG_PLACEMENT_ID    	INTEGER;--
VN_CPA_HOME             	INTEGER;--

VL_PLACEMENT_ID         	INTEGER;--
VN_BIO_CASE_ID              INTEGER;--
VN_BIO_CLIENT_ID            INTEGER;--
VS_IDENTITY_COLUMN   		INTEGER;--
SQLCODE				INTEGER;--
VN_LA_NUM                       INTEGER;--
VL_CASE_ID                      INTEGER;--
VN_LA_NUM1      	        INTEGER;--
VN_PL_PR_NULL                   INTEGER;--

VN_LA_PREV_PROVIDER_ID          INTEGER;--
VN_LA_NEXT_PROVIDER_ID          INTEGER;--
VN_NEXT_NUM    		        INTEGER;--
VN_DUMMY_PROVIDER_ID         INTEGER;--
VN_PREV_CPA_HOME_ID           INTEGER;--
VN_NXT_CPA_HOME_ID           INTEGER;--
VN_RH_LIVING_ID              INTEGER;--
VN_RH_PL_COUNT                INTEGER;--
 CNT1                        INTEGER;--
VN_LA_LIVING_ID              INTEGER;--
VN_PREV_LA_ID                INTEGER;--
VS_OUTPUT_STATE              VARCHAR; --
VL_EXCEP_FLAG                INTEGER;--
VL_EXCEP_MESSAGE             VARCHAR; --

BEGIN
VS_OUTPUT_STATE:= '';

BEGIN 
select ICR.min(removaldate),
ISR.max(returndate),
ICR.max(removaldate),
ICR.insertedon 
INTO AS_FIRST_REMOVAL_DT,
AS_LAST_DISCHARGE_DT,
AS_LATEST_REMOVAL_DT,
AS_REMOVAL_TRANSACTION_DT
from intakeservreqchildremoval ISR, servicecase SC, intakeservicerequestactor IAR, person PP
where ISR.servicecaseid = SC.servicecaseid
AND ISR.intakeservicerequestactorid = IAR.intakeservicerequestactorid
AND ICR.servicecasenumber = AL_CASE_ID
AND PP.personid = IAR.personid
AND PP.cjamspid = AL_CLIENT_ID 
AND ISR.activeflag =1 
AND IAR.activeflag = 1
AND PP.activeflag = 1
AND SC.activeflag = 1; --
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END; --

BEGIN
select count(*) INTO AS_NUM_REMOVALS
from intakeservreqchildremoval ISR, servicecase SC, intakeservicerequestactor IAR, person PP
where ISR.servicecaseid = SC.servicecaseid 
AND ISR.intakeservicerequestactorid = IAR.intakeservicerequestactorid
AND ISR.returndate IS NOT NULL
AND SC.servicecasenumber = AL_CASE_ID
AND PP.personid = ICR.personid
AND PP.cjamspid = AL_CLIENT_ID 
AND ICR.activeflag = 1
AND ISR.activeflag =1 
AND IAR.activeflag = 1
AND PP.activeflag = 1
AND SC.activeflag = 1; --

EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END; 

BEGIN

 SELECT count(*)
 INTO 
 AS_NUM_PLACEMENTS
 from placement TP, intakeservreqchildremoval ISR, servicecase SC, intakeservicerequestactor IAR, person PP
where TP.intakeservreqchildremovalid = ISR.intakeservreqchildremovalid
AND TP.servicecaseid = SC.servicecaseid
AND ISR.intakeservicerequestactorid = ICR.intakeservicerequestactorid
AND SC.servicecasenumber = AL_CASE_ID
AND PP.personid = ICR.personid
AND PP.cjamspid = AL_CLIENT_ID 
AND ICR.activeflag = 1
AND IAR.activeflag = 1
AND PP.activeflag = 1
AND SC.activeflag = 1; --

EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;

BEGIN
select ARC.afcars_ref_cd from 
afcars_ref_code ARC, intakeservreqchildremoval ISC, servicecase SC, intakeservicerequestactor IAR, person PP
where ISC.intakeservicerequestactorid = IAR.intakeservicerequestactorid 
AND ARC.cjams_cd = ISC.removaltypekey
AND ARC.afcars_ref_type = 'removaltype'
AND ISC.servicecaseid = SC.servicecaseid 
AND SC.servicecasenumber = AL_CASE_ID
AND PP.personid = IAR.personid
AND PP.cjamspid = AL_CLIENT_ID
AND ISC.activeflag = 1
AND IAR.activeflag = 1
AND PP.activeflag = 1
AND SC.activeflag = 1; --

EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;


BEGIN
select
case when P.service_id = '500' THEN '1' 
 when P.service_id = '9' THEN '2'
 when P.service_id = '10' THEN '2'
 when P.service_id = '14' THEN '3'
 when P.service_id = '15' THEN '4' 
 when P.service_id = '167' THEN '5'
 when P.service_id = '74' THEN '6' 
 when LA.livingarrangementtypekey = '6589' THEN '7' 
 when LA.livingarrangementtypekey = '10460' THEN '8' 
END INTO AS_PLACEMENT_SETTG_CD
from placement P
INNER JOIN servicecase SC ON SC.servicecaseid = P.servicecaseid
LEFT JOIN tb_placement TP ON TP.placementid = P.placementid
LEFT JOIN livingarrangement LA ON P.placementid = LA.placementid AND LA.livingarrangementtypekey in ('6589', '10460')
LEFT JOIN tb_services TS ON TS.service_id = P.service_id AND TS.service_id in ('500','9','10','14','15','167','74')
where LA.placementid = P.placementid
AND SC.servicecasenumber = AL_CASE_ID; --

EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;


BEGIN
select case when TPA.adr_state_cd = 'MD' THEN '2' ELSE '0' END AS AS_OUT_OF_STATE_PLACEMENT_SW
from tb_placement TP,  tb_provider_addresses TPA
where TP.provider_id::VARCHAR = TPA.parent_key_id
AND TP.case_id = AL_CASE_ID
AND TP.delete_sw = 'N'
AND TPA.delete_sw = 'N'; --
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR REMOVAL DETAILS FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;

 IF VL_EXCEP_FLAG = 1 THEN
   INSERT INTO interfaceserrorlog(
                                         interfaceid,
                                         currentruntimestamp,
                                         errorlineno,
                                         errorcode,
                                         errordescription,
                                         insertedon)VALUES ('AFACRS FOSTER CARE',
                                                CURRENT_TIMESTAMP,
                                                0,
                                                VL_EXCEP_MESSAGE,
                                                VS_OUTPUT_STATE,
                                                CURRENT_DATE);
END IF;--



END; --

$function$
