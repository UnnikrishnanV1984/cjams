

DROP FUNCTION IF EXISTS cjams.validateprogramarea(v_personid uuid, v_servicecaseid uuid);

CREATE OR REPLACE FUNCTION cjams.validateprogramarea(v_personid uuid, v_servicecaseid uuid)
 RETURNS TABLE(count bigint)
 LANGUAGE plpgsql
AS $function$

BEGIN  

   RETURN QUERY 

	SELECT count(1)
	FROM placement pl
	INNER JOIN routing r ON r.objectid = pl.placementid::character varying and r.routingstatustypeid in (16) and r.activeflag = 1
	WHERE pl.personid=v_personid AND (isvoided = 0 or isvoided is null) AND pl.activeflag=1 AND pl.alternateid is not null AND pl.enddatetime is null and pl.altproviderid is not null 
	and pl.servicecaseid = v_servicecaseid AND (pl.placementtypekey <> 'LA' OR pl.placementtypekey IS NULL);

END;

$function$
;
