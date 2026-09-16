CREATE OR REPLACE FUNCTION cjams.get_servlist_vendor(v_objecttype character varying)
 RETURNS TABLE(service_id integer, service_nm character varying, service_type character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 09/28/2021 Vineet Tirodkar - Modifications to display Service Category Description along with Service Name (B-109434)
------------------------------------------------------------------------------------------------------------	
BEGIN

IF (v_objecttype = 'service plan') THEN
	RETURN QUERY
	SELECT CASE WHEN TSR.service_id IS NOT NULL THEN TSR.service_id END AS "service_id"
	  ,CASE WHEN TSR.service_nm IS NOT NULL THEN TSR.service_nm END AS "service_nm"
	  ,TSR.paid_non_paid_cd	:: character varying															
	FROM tb_services TSR
	WHERE TSR.service_category_cd=5610 
	order by service_nm asc;
ELSE
	RETURN QUERY
	SELECT CASE WHEN TSR.service_id IS NOT NULL THEN TSR.service_id END AS "service_id"
	  ,CASE WHEN TSR.service_nm IS NOT NULL and btrim(TSR.service_category_cd)  is not null THEN 
			TSR.service_nm || ' - (Category: ' || 
				(  select pv.value_tx
					 from cjams.tb_picklist_values pv 
				   where btrim(pv.picklist_value_cd ) = btrim(TSR.service_category_cd) 
						and pv.picklist_type_id  = 1196
						and pv.delete_sw  = 'N'
				 ) || ')'
	   ELSE	
			TSR.service_nm 
	   END AS "service_nm"
	  ,TSR.paid_non_paid_cd	:: character varying															
	FROM tb_services TSR
	WHERE TSR.structure_service_cd = 'S' 
		and TSR.active_sw = 'Y' 
		and TSR.delete_sw='N'
		and TSR.paid_non_paid_cd::INTEGER IN ('3334','3335')
		and coalesce(TSR.teamtypekey, '') <> 'DJS'
	order by service_nm asc;
END IF;
																
END
$function$
;
