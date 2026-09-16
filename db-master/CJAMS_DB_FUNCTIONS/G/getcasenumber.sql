DROP FUNCTION IF EXISTS cjams.getcasenumber(v_objecttypekey character varying, v_objectid character varying);
CREATE OR REPLACE FUNCTION cjams.getcasenumber(v_objecttypekey character varying, v_objectid character varying)
 RETURNS TABLE(casenumber character varying)
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------
-- Revision(s)
-- 07/20/2023 Palani / Chandra - Performance fixes (CIDM-6945)
--------------------------------------------------------------------------
BEGIN

IF (lower(v_objecttypekey) = 'servicecase') THEN

RETURN QUERY

SELECT servicecasenumber FROM servicecase WHERE servicecaseid = v_objectid::uuid AND activeflag =1;

ELSIF (lower(v_objecttypekey) = 'servicerequest') THEN

RETURN QUERY

SELECT servicerequestnumber FROM intakeservicerequest WHERE intakeserviceid = v_objectid::uuid AND activeflag =1;

ELSIF (lower(v_objecttypekey) = 'adoptioncase') THEN

RETURN QUERY

SELECT adoptioncasenumber FROM adoptioncase WHERE adoptioncaseid = v_objectid::uuid AND activeflag =1;

END IF;

END;

$function$
;
