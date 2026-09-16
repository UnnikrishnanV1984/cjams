DROP  FUNCTION IF EXISTS cjams.getsubprogramarea(v_programkey character varying);
CREATE OR REPLACE FUNCTION cjams.getsubprogramarea(v_programkey character varying)
 RETURNS TABLE(subprogram json, programarea json)
 LANGUAGE plpgsql
AS $function$

BEGIN


RETURN QUERY

SELECT 

   (SELECT json_agg(e) FROM
    (
        
		SELECT DISTINCT rv.description AS subprogramname,pac.subprogramkey, case when subprogramkey = 'KN' then 'true' else 'false' end as disabled
        FROM programareaconfig pac 
        INNER JOIN referencevalues rv ON rv.ref_key=pac.subprogramkey AND rv.activeflag=1 AND rv.referencetypeid=12
        WHERE pac.programkey= v_programkey AND pac.activeflag=1
        
    ) e
) :: json AS subprogram,
(
    SELECT json_agg(e) FROM
    (
        SELECT DISTINCT programname,pac.programkey 
        FROM programareaconfig pac 
        INNER JOIN agencyprogramarea rv ON rv.programkey=pac.programkey AND rv.activeflag=1
        WHERE pac.activeflag=1 AND pac.programkey= v_programkey
        
    ) e
) :: json AS programarea;

END;

$function$;
