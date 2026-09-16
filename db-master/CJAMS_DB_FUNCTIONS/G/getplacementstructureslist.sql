 DROP function if exists getplacementstructureslist(character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.getplacementstructureslist(v_structure_service_cd character varying, v_provider_id character varying)
 RETURNS TABLE(totalcount bigint, service_id integer, service_nm character varying, payment_category_cd character varying, placement_sw character, affiliated_sw character, support_sw character, create_ts character varying, create_user_id character varying, update_ts character varying, update_user_id character varying, delete_sw character, educational_sw character, structure_service_cd character varying, state_ldss_cd character varying, active_sw character, placement_structure_id integer, paid_non_paid_cd character, service_category_cd character, comar_sw character, child_account_sw character, iv_e_allowable_sw character, service_status text)
 LANGUAGE plpgsql
AS $function$

DECLARE
v_providercategorycd varchar(5);
v_affprovid int;
lpubliccount int;
BEGIN
IF (v_provider_id!='' or v_provider_id!=null) then

   SELECT count(1) into lpubliccount FROM TB_PROVIDER_PICKLIST tpcl1 WHERE tpcl1.PICKLIST_TYPE_ID=155 
   AND tpcl1.PICKLIST_VALUE_CD IN ('1783') 
   AND tpcl1.PROVIDER_ID =v_provider_id:: integer  AND tpcl1.DELETE_SW = 'N';

   select provider_category_cd , affiliate_provider_id into v_providercategorycd , v_affprovid 
   from tb_provider 
   where provider_id = v_provider_id::integer;

    RETURN QUERY 
select count(1) over(),TBS.service_id, TBS.service_nm, TBS.payment_category_cd, TBS.placement_sw, TBS.affiliated_sw, TBS.support_sw, TBS.create_ts, TBS.create_user_id,
TBS.update_ts, TBS.update_user_id, TBS.delete_sw, TBS.educational_sw, TBS.structure_service_cd, TBS.state_ldss_cd, TBS.active_sw, TBS.placement_structure_id,
TBS.paid_non_paid_cd, TBS.service_category_cd, TBS.comar_sw, TBS.child_account_sw, TBS.iv_e_allowable_sw,
-- TBPS.service_status  
CASE WHEN (TBPS.end_dt IS NULL OR TBPS.end_dt>=now()::date) THEN 'Active' ELSE 'Inactive' END AS service_status
from tb_services as TBS 
JOIN TB_PROVIDER_SERVICES as TBPS 
     ON TBPS.service_id = TBS.service_id and TBPS.delete_sw = 'N'
where TBS.STRUCTURE_SERVICE_CD = v_structure_service_cd and 
(case when lpubliccount>0 then 
TBPS.provider_id = v_provider_id::integer
else TBPS.provider_id = v_affprovid::integer end)
and TBS.active_sw = 'Y' and TBS.delete_sw = 'N' and TBS.teamtypekey = 'CW'
order by service_nm ASC ;

ELSE
      RETURN QUERY 
select count(1) over(),TBS.service_id, TBS.service_nm, TBS.payment_category_cd, TBS.placement_sw, TBS.affiliated_sw, TBS.support_sw, TBS.create_ts, TBS.create_user_id,
TBS.update_ts, TBS.update_user_id, TBS.delete_sw, TBS.educational_sw, TBS.structure_service_cd, TBS.state_ldss_cd, TBS.active_sw, TBS.placement_structure_id,
TBS.paid_non_paid_cd, TBS.service_category_cd, TBS.comar_sw, TBS.child_account_sw, TBS.iv_e_allowable_sw,null:: text as service_status from tb_services as TBS where TBS.STRUCTURE_SERVICE_CD = v_structure_service_cd
and TBS.active_sw = 'Y' and TBS.delete_sw = 'N' and TBS.teamtypekey = 'CW'
order by service_nm ASC ;

END IF;
    
END;
 
$function$
;
