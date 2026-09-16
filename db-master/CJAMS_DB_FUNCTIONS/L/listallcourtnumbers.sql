DROP FUNCTION IF EXISTS cjams.listallcourtnumbers(v_caseid character varying);

CREATE OR REPLACE FUNCTION cjams.listallcourtnumbers(v_caseid character varying)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_courtnumbers json;
	 	 
BEGIN
		
    SELECT json_agg(x) INTO v_courtnumbers 
    FROM (
		SELECT  
		(SELECT concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix) FROM person p WHERE p.personid = cn.personid ) AS clientname,
        * 
		FROM courtnumbers cn WHERE caseid::CHARACTER VARYING = v_caseid AND activeflag = 1
	) AS x;
        
	RETURN v_courtnumbers;
END  
$function$;