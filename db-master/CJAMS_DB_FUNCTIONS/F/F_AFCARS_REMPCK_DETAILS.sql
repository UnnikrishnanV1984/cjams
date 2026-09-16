-- FUNCTION: cjams.f_afcars_rempck_details(character varying, character varying, integer, uuid)

-- DROP FUNCTION cjams.f_afcars_rempck_details(character varying, character varying, integer, uuid);

CREATE OR REPLACE FUNCTION cjams.f_afcars_rempck_details(
	adt_from character varying,
	adt_to character varying,
	al_client_id integer,
	al_removal_id uuid)
    RETURNS TABLE(as_physical_abuse_sw character varying, as_sexual_abuse_sw character varying, as_neglect_sw character varying, as_par_alcohol_abuse_sw character varying, as_par_drug_abuse_sw character varying, as_child_alcohol_abuse_sw character varying, as_child_drug_abuse_sw character varying, as_child_disability_sw character varying, as_child_behavior_sw character varying, as_parent_death_sw character varying, as_parent_incarceration_sw character varying, as_caretaker_illness_sw character varying, as_abandonment_sw character varying, as_relinquishment_sw character varying, as_inadequate_housing_sw character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE VL_OUTPUT_SQLCODE 		VARCHAR;--
        VS_OUTPUT_STATE        VARCHAR(5) DEFAULT '00000';
        -- VS_BATCH_NO             	VARCHAR(5)    DEFAULT '000';--
        VL_EXCEP_FLAG   		INTEGER;--
        VS_MESSAGE  			VARCHAR(1000);--
        VL_EXCEP_MESSAGE 			VARCHAR(1000);--

BEGIN

 VL_OUTPUT_SQLCODE:= ''; --
begin
return query
SELECT 
CASE WHEN removalreasontypekey = 'PA' THEN '1' ELSE '0' END AS AS_PHYSICAL_ABUSE_SW,
CASE WHEN removalreasontypekey = 'SA' THEN '1' ELSE '0' END AS AS_SEXUAL_ABUSE_SW,
CASE WHEN removalreasontypekey = 'HG' THEN '1' ELSE '0' END AS AS_NEGLECT_SW,
CASE WHEN removalreasontypekey = 'AAP' THEN '1' ELSE '0' END AS AS_PAR_ALCOHOL_ABUSE_SW,
CASE WHEN removalreasontypekey = 'DAP' THEN '1' ELSE '0' END AS AS_PAR_DRUG_ABUSE_SW,
CASE WHEN removalreasontypekey = 'AAC' THEN '1' ELSE '0' END AS AS_CHILD_ALCOHOL_ABUSE_SW,
CASE WHEN removalreasontypekey = 'DAC' THEN '1' ELSE '0' END AS AS_CHILD_DRUG_ABUSE_SW,
CASE WHEN removalreasontypekey = 'CD' THEN '1' ELSE '0' END AS AS_CHILD_DISABILITY_SW,
CASE WHEN removalreasontypekey = 'DP' THEN '1' ELSE '0' END AS AS_PARENT_DEATH_SW,
CASE WHEN removalreasontypekey = 'IP' THEN '1' ELSE '0' END AS AS_PARENT_INCARCERATION_SW,
CASE WHEN removalreasontypekey = 'CIIO' THEN '1' ELSE '0' END AS AS_CARETAKER_ILLNESS_SW,
CASE WHEN removalreasontypekey = 'ADT' THEN '1' ELSE '0' END AS AS_ABANDONMENT_SW,
CASE WHEN removalreasontypekey = 'RLQ' THEN '1' ELSE '0' END AS AS_RELINQUISHMENT_SW,
CASE WHEN removalreasontypekey = 'IDH' THEN '1' ELSE '0' END AS AS_INADEQUATE_HOUSING_SW
from intakeservreqchildremoval where  intakeservreqchildremovalid = AL_REMOVAL_ID                      
                                   AND  activeflag = 1 ; --
 
 EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
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
END
$BODY$;

ALTER FUNCTION cjams.f_afcars_rempck_details(character varying, character varying, integer, uuid)
    OWNER TO welfareadmin;
