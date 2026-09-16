
CREATE OR REPLACE FUNCTION fn_invallegationmaltreators_mtype_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN

    IF  NEW.coamaltreatmenttypeid IS NOT NULL THEN
		UPDATE investigationallegation SET allegationid = NEW.coamaltreatmenttypeid, updatedby = NEW.updatedby, updatedon = now() 
		WHERE investigationallegationid = NEW.investigationallegationid;
	ELSIF NEW.csmaltreatmenttypeid IS NOT NULL THEN
		UPDATE investigationallegation SET allegationid = NEW.csmaltreatmenttypeid, updatedby = NEW.updatedby, updatedon = now() 
		WHERE investigationallegationid = NEW.investigationallegationid;	
	ELSIF NEW.ccmaltreatmenttypeid IS NOT NULL THEN
		UPDATE investigationallegation SET allegationid = NEW.ccmaltreatmenttypeid, updatedby = NEW.updatedby, updatedon = now() 
		WHERE investigationallegationid = NEW.investigationallegationid;
	ELSIF NEW.oahmaltreatmenttypeid IS NOT NULL THEN
		UPDATE investigationallegation SET allegationid = NEW.oahmaltreatmenttypeid, updatedby = NEW.updatedby, updatedon = now() 
		WHERE investigationallegationid = NEW.investigationallegationid;
	ELSIF NEW.scmaltreatmenttypeid IS NOT NULL THEN
		UPDATE investigationallegation SET allegationid = NEW.scmaltreatmenttypeid, updatedby = NEW.updatedby, updatedon = now() 
		WHERE investigationallegationid = NEW.investigationallegationid;
    END IF;

return new;
END;

$function$;


DROP TRIGGER IF EXISTS invallegationmaltreators_mtype_upd ON cjams.investigationallegationmaltreators;

CREATE TRIGGER invallegationmaltreators_mtype_upd
AFTER INSERT OR UPDATE 
ON cjams.investigationallegationmaltreators
FOR EACH ROW
EXECUTE PROCEDURE cjams.fn_invallegationmaltreators_mtype_upd();