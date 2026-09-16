-- FUNCTION: cjams.fn_placmnt_updvdsw()

-- DROP FUNCTION cjams.fn_placmnt_updvdsw();

CREATE FUNCTION cjams.fn_placmnt_updvdsw()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
IF UPPER(NEW.voidflag) = 1 THEN
	UPDATE livingarrangement  SET activeflag= 0 WHERE placementid = NEW.placementid ;--
END IF;--
return new;
END;

$BODY$;

CREATE TRIGGER tr_placmnt_updvdsw 
AFTER UPDATE OF voidflag ON placement
FOR EACH ROW 
EXECUTE PROCEDURE fn_placmnt_updvdsw();
