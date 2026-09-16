DROP FUNCTION IF EXISTS cjams.updatequickperson(v_personid uuid, v_quickpersonid uuid, v_updatedby character varying);
CREATE OR REPLACE FUNCTION cjams.updatequickperson(v_personid uuid, v_quickpersonid uuid, v_updatedby character varying, l_caseid uuid default null::uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
v_date timestamp without time zone;

BEGIN
v_date:= now() ;
	
	 
	 UPDATE cjams.quickperson SET caseid = coalesce(caseid,l_caseid), personid = v_personid, activeflag = 0, updatedon = v_date, updatedby = 'QP System Update' WHERE quickpersonid = v_quickpersonid;
	
RETURN 'Success';
		
END
$function$
;