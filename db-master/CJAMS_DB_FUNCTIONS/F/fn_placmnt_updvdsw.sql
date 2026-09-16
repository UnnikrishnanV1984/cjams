CREATE OR REPLACE FUNCTION cjams.fn_placmnt_updvdsw()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 12/16/2021 Vineet Tirodkar - Modification to update livingarrangement Audit Columns (CDM-17201)
------------------------------------------------------------------------
BEGIN
	IF UPPER(NEW.voidflag) = 1 THEN
		UPDATE livingarrangement  
		SET activeflag = 0,
			updatedon = current_timestamp,
			updatedby = NEW.updatedby
		WHERE placementid = NEW.placementid ;
	END IF;
	return new;
END;

$function$
;