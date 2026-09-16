
---B-126595-CIDM-5793-Enhancement-Story-for-B-126595-CfE-Respite-Care-Services

DROP FUNCTION IF EXISTS cjams.getpicklist(integer);

CREATE OR REPLACE FUNCTION cjams.getpicklist(v_picklist_type_id integer)
 RETURNS TABLE(totalcount bigint, picklist_value_cd text, picklist_type_id integer, value_tx character varying, description_tx character varying,category_tx character varying )
 LANGUAGE plpgsql
AS $function$


BEGIN

RETURN QUERY 
select count(1) over(),
TRIM(TBPLV.picklist_value_cd) as picklist_value_cd, 
TBPLV.picklist_type_id , 
TBPLV.value_tx, 
TBPLV.description_tx,
TBPLV.category_tx 
 from tb_picklist_values as TBPLV where (TBPLV.picklist_type_id) = v_picklist_type_id
and TBPLV.active_sw = 'Y' and TBPLV.delete_sw = 'N'
order by sort_order_no, value_tx ASC ;
    
END;

$function$
;                                                                                                                                     

