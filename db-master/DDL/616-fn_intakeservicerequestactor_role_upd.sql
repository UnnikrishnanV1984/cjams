CREATE OR REPLACE FUNCTION fn_intakeservicerequestactor_role_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

DECLARE
	comment_val character varying;

BEGIN

	IF NEW.intakeservicerequestpersontypekey = 'ICC' then
	  
	  comment_val := CASE WHEN NEW.activeflag = 1 THEN 'Initial contact caregiver Role is Added' ELSE 'Initial contact caregiver Role is Removed' END;	
		
      INSERT INTO personrole_history (personid, intakeservicerequestpersontypekey, comments, insertedby, insertedon, updatedby, updatedon)
      VALUES(NEW.personid, NEW.intakeservicerequestpersontypekey, comment_val, COALESCE(NEW.updatedby, NEW.insertedby), now(), COALESCE(NEW.updatedby, NEW.insertedby), now());

    END IF;

RETURN NEW;
END;

$function$;

DROP TRIGGER IF EXISTS intakeservicerequestactor_role_upd ON cjams.intakeservicerequestactor;

CREATE TRIGGER intakeservicerequestactor_role_upd
AFTER INSERT OR UPDATE 
ON cjams.intakeservicerequestactor
FOR EACH ROW
EXECUTE PROCEDURE cjams.fn_intakeservicerequestactor_role_upd();

