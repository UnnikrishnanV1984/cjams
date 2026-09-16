CREATE OR REPLACE FUNCTION fn_investigationallegation_mtype_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN

    IF  NEW.allegationid != OLD.allegationid THEN
      INSERT INTO investigationallegation_history (investigationallegationid, allegationid, allegationid_old, insertedby, insertedon, updatedby, updatedon)
      VALUES(NEW.investigationallegationid, NEW.allegationid, OLD.allegationid, NEW.updatedby, now(), NEW.updatedby, now());
    END IF;

return new;
END;

$function$;

DROP TRIGGER IF EXISTS investigationallegation_mtype_upd ON cjams.investigationallegationmaltreators;

CREATE TRIGGER investigationallegation_mtype_upd
AFTER UPDATE 
ON cjams.investigationallegation
FOR EACH ROW
EXECUTE PROCEDURE cjams.fn_investigationallegation_mtype_upd();

