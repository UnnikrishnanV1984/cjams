CREATE OR REPLACE FUNCTION f_supervisor_name(v_objectid character varying,isfname character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE

	VN_FIRST_NAME text;
    VN_LAST_NAME text;

BEGIN

SELECT up.firstname,up.lastname into VN_FIRST_NAME,VN_LAST_NAME
	FROM userprofile up
	WHERE up.activeflag = 1 AND 
			up.securityusersid IN (SELECT tma.securityusersid
									FROM teammember tm, teammemberassignment tma
									WHERE tm.teammemberid = tma.teammemberid AND tm.activeflag = 1 AND 
											tma.activeflag = 1 AND  tm.roletypekey = 'CWSP' AND
											tma.securityusersid in (
											(select fromsecurityusersid from routing where objectid= v_objectid  and activeflag=1 order by insertedon desc limit 1),
                                            (select tosecurityusersid from routing where objectid= v_objectid  and activeflag=1 order by insertedon desc limit 1)
											)
											
						 );
if isfname = 'Y' then 
   RETURN VN_FIRST_NAME;
end if;
if isfname = 'N' then 
   RETURN VN_LAST_NAME;
end if;

END;

$function$;