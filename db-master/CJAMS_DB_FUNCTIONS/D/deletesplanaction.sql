DROP FUNCTION IF EXISTS cjams.deletesplanaction(v_actionid CHARACTER VARYING, v_userid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.deletesplanaction(v_actionid character varying, v_userid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
-- Revision(s)
-- 9/12/2023 - Chandra/Palani -- Performance fix (CIDM-7910)

-------------------------------------------------------------------------------------------
DECLARE
v_message character varying;

BEGIN

UPDATE serviceplanaction
SET activeflag = 0, updatedon = now(), updatedby = v_userid
WHERE
serviceplanactionid = v_actionid::uuid AND activeflag = 1;

UPDATE serviceplanpersoninvolved
SET activeflag = 0, updatedon = now(), updatedby = v_userid
WHERE
serviceplanactionid= v_actionid::uuid AND activeflag = 1;

v_message:= 'Success';

    return v_message;
END  
$function$;